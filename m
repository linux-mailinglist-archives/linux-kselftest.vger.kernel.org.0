Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE081059F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUSwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 13:52:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39733 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUSwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 13:52:11 -0500
Received: by mail-pj1-f66.google.com with SMTP id t103so1886139pjb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUALPva1YZVx3/2BQ9xkXxgM4On7BMfGtAqUM5uBBGM=;
        b=QkkdDs9DdEZpBZNUwVByWOjPfaCLv5Fazv+T6W/jsGE/QJ22fsNVmNCKvxFOWGUM+5
         Ub+65sE7+UddobbPy8Eo7/AE2rO56F/2Vo6vrTZXTzmY42lHLf6Gnq1WSTD9qr3kp5Bn
         fSW0qljDPVCBYTHAaHbnZZJdXBigRahCRKtbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUALPva1YZVx3/2BQ9xkXxgM4On7BMfGtAqUM5uBBGM=;
        b=hW1zpb3NeZ1o6Hw9K2awamBt3vx88XQQ5KQK28Lny/i7nL9Ig1qpVADlzbYovW7ufa
         TEh/IS9V73Arx8EDfiTu4tsEX+UMLtp0O+aw/rom2T4ZtGQMXA/+aKDFDs/6AWcbPa/F
         YCgg2ALrfgQep3zIzy659jNX5xJVyGM5H3CWFSxjKN11wSKyKWoYDLYBHMVPqifnw0HE
         shAJi00X5vglnVwYIunQocGJDVQop6wLExI+qbOTZqwkrZspNoWyNpjMZalKezlSe3oq
         bcbmzKys/GQFXv2XlZKyiX6Y4Dck52YN8A+33OtN2+JSDFpODKXsNjeYLaZT9xlRENqC
         QbNQ==
X-Gm-Message-State: APjAAAXEMCOMScXAEGHJ2zLnlHHkM9oRhK2xhHGZGXvf1e/eVFNzkQ/P
        IsryQ/cPUx/MWeRQzZONT0N8og==
X-Google-Smtp-Source: APXvYqyK7CVdwbuMQqybLkpohnb4M7+sMWlod2tDFQzPuY7KWaq3YXComqcwID39J5WBbAezdPL/1Q==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr13768023pje.11.1574362331026;
        Thu, 21 Nov 2019 10:52:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15sm4085805pgb.0.2019.11.21.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:52:09 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:52:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: settings: tests can be in subsubdirs
Message-ID: <201911211018.D6CD68AC5@keescook>
References: <20191022171223.27934-1-matthieu.baerts@tessares.net>
 <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 05:32:42PM +0100, Matthieu Baerts wrote:
> Hi Shuah,
> 
> First, thank you for maintaining the Kernel Selftest framework!
> 
> On 22/10/2019 19:12, Matthieu Baerts wrote:
> > Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
> > timeout per test) adds support for a new per-test-directory "settings"
> > file. But this only works for tests not in a sub-subdirectories, e.g.
> > 
> >   - tools/testing/selftests/rtc (rtc) is OK,
> >   - tools/testing/selftests/net/mptcp (net/mptcp) is not.
> > 
> > We have to increase the timeout for net/mptcp tests which are not
> > upstreamed yet but this fix is valid for other tests if they need to add
> > a "settings" file, see the full list with:
> > 
> >    tools/testing/selftests/*/*/**/Makefile
> > 
> > Note that this patch changes the text header message printed at the end
> > of the execution but this text is modified only for the tests that are
> > in sub-subdirectories, e.g.
> > 
> >    ok 1 selftests: net/mptcp: mptcp_connect.sh
> > 
> > Before we had:
> > 
> >    ok 1 selftests: mptcp: mptcp_connect.sh
> > 
> > But showing the full target name is probably better, just in case a
> > subsubdir has the same name as another one in another subdirectory.
> > 
> > Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Sorry to bother you again with this but by chance, did you have a look at
> the patch below? :)
> 
> It doesn't only fix an issue with MPTCP, not in the kernel yet. But it also
> fixes the issue of taking the right "settings" file (if available) for any
> other tests in a sub-directory, e.g.:
> 
>   drivers/dma-buf
>   filesystems/binderfs
>   net/forwarding
>   networking/timestamping
> 
> But I guess all tests in powerpc/* dirs and others.

Thanks for the ping! I missed this patch when you originally sent it.
Yes, this make sense to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

As an improvement on this, I wonder if we need to walk all directories
between $BASEDIR and $DIR? Actually, let me write this and send it...

-Kees

> 
> Cheers,
> Matt
> 
> > ---
> >   tools/testing/selftests/kselftest/runner.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index 84de7bc74f2c..0d7a89901ef7 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -90,7 +90,7 @@ run_one()
> >   run_many()
> >   {
> >   	echo "TAP version 13"
> > -	DIR=$(basename "$PWD")
> > +	DIR="${PWD#${BASE_DIR}/}"
> >   	test_num=0
> >   	total=$(echo "$@" | wc -w)
> >   	echo "1..$total"
> > 
> 
> -- 
> Matthieu Baerts | R&D Engineer
> matthieu.baerts@tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- 
Kees Cook
