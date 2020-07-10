Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29E21BD03
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJSbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 14:31:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727910AbgGJSbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 14:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594405880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRqWXRqtM1jmKDk24CkRG8osdjmpDaMTznOjUGxYXsQ=;
        b=ScuhrsJIHutquNH8Xyb5nKV1UgyWiUunSPaJceSsDIqNgCAiuFhOy1Fdf4d8VeasLaA0mK
        fGzBZXp2gTamrEr35Ez4BmaHSd2uK9oY8E25dxJUf+w5Mlis/ZhUlYGpGnNfsY3rSKS4io
        JEuILmtV8FHtYHkzrqSaZb/0JOYCZRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Dpe36TqMP-esFQn4fKd4GA-1; Fri, 10 Jul 2020 14:31:16 -0400
X-MC-Unique: Dpe36TqMP-esFQn4fKd4GA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA03518FF661;
        Fri, 10 Jul 2020 18:31:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.rdu2.redhat.com [10.10.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6457D5C6DD;
        Fri, 10 Jul 2020 18:31:10 +0000 (UTC)
Date:   Fri, 10 Jul 2020 14:31:08 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Shuah Khan <shuah@kernel.org>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: adopt to newer sysctl error format
Message-ID: <20200710183108.GA17581@redhat.com>
References: <20200710051043.899291-1-kamalesh@linux.vnet.ibm.com>
 <20200710152735.GA20226@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710152735.GA20226@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 10, 2020 at 05:27:35PM +0200, Petr Mladek wrote:
> On Fri 2020-07-10 10:40:43, Kamalesh Babulal wrote:
> > With procfs v3.3.16, the sysctl command doesn't prints the set key and
> > value on error.  This change breaks livepatch selftest test-ftrace.sh,
> > that tests the interaction of sysctl ftrace_enabled:
> > 

Good catch, it looks like it was this procps commit that modified that
behavior:

  commit da82fe49b1476d227874905068adb69577e11d96
  Author: Patrick Steinhardt <ps@pks.im>
  Date:   Tue May 29 13:29:03 2018 +0200
  
      sysctl: do not report set key in case `close_stream` fails
      
      As we're using buffered I/O when writing kernel parameters, write errors
      may get delayed until we close the `FILE` stream. As we are currently
      outputting the key that is to be set disregarding the return value of
      `close_stream`, we may end up in a situation where we report error and
      success:
      
          $ sysctl kernel.printk_ratelimit=100000000000000
          sysctl: setting key "kernel.printk_ratelimit": error code 22
          kernel.printk_ratelimit = 100000000000000
      
      Fix the issue by only outputting the updated value in case
      `close_stream` does not report an error.
      
      Signed-off-by: Patrick Steinhardt <ps@pks.im>

And I'd agree that echoing the failed new value was confusing to see
from a user's perspective.

> >  # selftests: livepatch: test-ftrace.sh
> >  # TEST: livepatch interaction with ftrace_enabled sysctl ... not ok
> >  #
> >  # --- expected
> >  # +++ result
> >  # @@ -16,7 +16,7 @@ livepatch: 'test_klp_livepatch': initial
> >  #  livepatch: 'test_klp_livepatch': starting patching transition
> >  #  livepatch: 'test_klp_livepatch': completing patching transition
> >  #  livepatch: 'test_klp_livepatch': patching complete
> >  # -livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
> >     resource busy kernel.ftrace_enabled = 0
> >  # +livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
> >     resource busy
> >  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> >  #  livepatch: 'test_klp_livepatch': initializing unpatching transition
> >  #  livepatch: 'test_klp_livepatch': starting unpatching transition
> >  #
> >  # ERROR: livepatch kselftest(s) failed
> > 
> > on setting sysctl kernel.ftrace_enabled={0,1} value successfully, the
> > set key and value is displayed.
> > 
> > This patch fixes it by limiting the output from both the cases to eight
> > words, that includes the error message or set key and value on failure
> > and success. The upper bound of eight words is enough to display the
> > only tracked error message. Also, adjust the check_result string in
> > test-ftrace.sh to match the expected output.
> 
> This looks really tricky.
> 
> I wonder if we could use "sysctl -q" to refuse printing the value
> even with older versions. The following patch works here with
> sysctl 3.3.15:
> 

FWIW, --quiet was added to procps way back in 2004, so it should be safe
to use... and there's already a bunch of net selftests using it.

> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 2aab9791791d..47aa4c762bb4 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -64,7 +64,8 @@ function set_dynamic_debug() {
>  }
>  
>  function set_ftrace_enabled() {
> -	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
> +	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
> +		 sysctl kernel.ftrace_enabled 2>&1)
>  	echo "livepatch: $result" > /dev/kmsg
>  }
>  
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index e2a76887f40a..aa967c5d0558 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -53,7 +53,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
> +livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
>  % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
>  livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
>  livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> 
> 

I think this method is less fragile than word count / cutting and we get
to drop that strange 'paste' invocation (I had to look that up in the
mapages to remember why we used it).

Regards,

-- Joe

