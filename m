Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34B5264AAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIJRHv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 13:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgIJQy3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 12:54:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC423207EA;
        Thu, 10 Sep 2020 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599756831;
        bh=jQ0ZRylENGKXOzmgkK2AlOHvIv1X+hciX8EofZovJZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2PChalw8ifQxX2QZUgkdtCnaPQO6Xu0oG0GYrww7Ml5suypUU78GW8lB7dpAbt4f
         FlYuPb45rk8Us6voZlv2GdlgU+xQwWlNRkDdktHKa/xWUlL6y/fMNzxeEF/kIUc78F
         /VB6XGRdW2LiEur3TlCluYx1ayzvZj0GT7h14JXE=
Date:   Thu, 10 Sep 2020 18:53:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/lkdtm: Use "comm" instead of "diff" for
 dmesg
Message-ID: <20200910165358.GD1458062@kroah.com>
References: <20200909211700.2399399-1-keescook@chromium.org>
 <f92a05d3-6932-d644-e95f-d63c0a34fa19@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92a05d3-6932-d644-e95f-d63c0a34fa19@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 09, 2020 at 03:35:00PM -0600, Shuah Khan wrote:
> On 9/9/20 3:17 PM, Kees Cook wrote:
> > Instead of full GNU diff (which smaller boot environments may not have),
> > use "comm" which is more available.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: add --nocheck-order, thanks to Joe Lawrence
> > v1: https://lore.kernel.org/lkml/202006261358.3E8AA623A9@keescook/
> > ---
> >   tools/testing/selftests/lkdtm/run.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> > index 8383eb89d88a..bb7a1775307b 100755
> > --- a/tools/testing/selftests/lkdtm/run.sh
> > +++ b/tools/testing/selftests/lkdtm/run.sh
> > @@ -82,7 +82,7 @@ dmesg > "$DMESG"
> >   ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
> >   # Record and dump the results
> > -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> > +dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
> >   cat "$LOG"
> >   # Check for expected output
> > 
> 
> Greg,
> 
> Would you like me to take this through kselftest tree?
> 
> If you want to take it through lkdtm tree, here is my Ack:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I'll take it.

greg k-h
