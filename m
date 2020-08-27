Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6932545D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgH0NWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 09:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbgH0NVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 09:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598534464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxj3/pnEKNdJXQYKt9vOuqr1Pjo+7bDlTiGFlo7k2bk=;
        b=AdhY35Ul5Ut+0CwcMY+3YmEM3gx2B2w/Qgna0lmpKg9KDgpG+2nf4e17ozmYUhSPQFWUxe
        syfZzW0jyrxWKjTi9x787U3hQBDvzCZMwEcvoi7qHEQRmim3q6wCOJN3kc6EXx6oT/62y/
        6yFWJ883rf5m2myJ6qoT/LtYBKHnAq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-Kv9Ig1K7NFS8Ya33PNgGOQ-1; Thu, 27 Aug 2020 09:21:02 -0400
X-MC-Unique: Kv9Ig1K7NFS8Ya33PNgGOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE83189E60D;
        Thu, 27 Aug 2020 13:21:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-28.rdu2.redhat.com [10.10.114.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8FB61972A;
        Thu, 27 Aug 2020 13:20:59 +0000 (UTC)
Date:   Thu, 27 Aug 2020 09:20:58 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        shuah@kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: Do not check order when using
 "comm" for dmesg checking
Message-ID: <20200827132058.GA24622@redhat.com>
References: <20200827110709.26824-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827110709.26824-1-mbenes@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 27, 2020 at 01:07:09PM +0200, Miroslav Benes wrote:
> check_result() uses "comm" to check expected results of selftests output
> in dmesg. Everything works fine if timestamps in dmesg are unique. If
> not, like in this example
> 
> [   86.844422] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
> [   86.844422] livepatch: 'test_klp_callbacks_demo': starting unpatching transition
> 

Heh, our assumption that the timestamps would provide sorting wasn't
true after all.

> , "comm" fails with "comm: file 2 is not in sorted order". Suppress the
> order checking with --nocheck-order option.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

And not so important for selftests, but helpful for backporting efforts:

Fixes: 2f3f651f3756 ("selftests/livepatch: Use "comm" instead of "diff" for dmesg")

> ---
> 
> The strange thing is, I can reproduce the issue easily and reliably on
> older codestreams (4.12) but not on current upstream in my testing
> environment. I think the change makes sense regardless though.
> 

We haven't backported v5.8 changes just yet, so thanks for finding this
one and posting a fix.

-- Joe

>  tools/testing/selftests/livepatch/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 1aba83c87ad3..846c7ed71556 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -278,7 +278,7 @@ function check_result {
>  	# help differentiate repeated testing runs.  Remove them with a
>  	# post-comparison sed filter.
>  
> -	result=$(dmesg | comm -13 "$SAVED_DMESG" - | \
> +	result=$(dmesg | comm --nocheck-order -13 "$SAVED_DMESG" - | \
>  		 grep -e 'livepatch:' -e 'test_klp' | \
>  		 grep -v '\(tainting\|taints\) kernel' | \
>  		 sed 's/^\[[ 0-9.]*\] //')
> -- 
> 2.28.0
> 

