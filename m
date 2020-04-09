Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5ABB1A2F33
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIG2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 02:28:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDIG2O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 02:28:14 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jMQfd-0006SY-8l
        for linux-kselftest@vger.kernel.org; Thu, 09 Apr 2020 06:28:13 +0000
Received: by mail-wr1-f69.google.com with SMTP id w12so5801988wrl.23
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 23:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Grm86vreVjyXAquqlbQvZFBa/TkelVHJfq7HxYo2C00=;
        b=lVp3yqYQZtlVy0M6PCYQ4xpmXzwXoePm8ZsqGLRZMTeGzHQ1icIeXiTzmq5g+a6oXV
         noxF+lDkdlhdn7QA6A/7YWWiziCqdr15VB14WhAWTiDuSJnx4rcHYE2UgJDvb+xYjG0P
         uAeKDIX9m3Ki9TaWyG7G2FixfjJNjMEd8jomzmQYSxGOsJ8NmFP/DfkQu+QANSxVKO3y
         U9aqq8DN2wrT4cLPPUEZ6u7hO2ZTTBpxeAQtzhazBgswu8OmCem95Yx2KVQCQW45j/+6
         Eb342tDFr4ruj1ciWqhMpNQVIN9LpG6pxDSrraKZEpHRLteHjPf/aC0r8XD4JM46/MEA
         RI0w==
X-Gm-Message-State: AGi0PubeTu0HI4gupIJXD7WtIhjCVZmUTOv6hrspH7qOko3GbibazNW5
        pRtsHKFMi+vq/O1Qe8aPAURwLDfSKmk5+/bzsWuHoJoUOklJO7/sTDr5422zsaJdzSiE2RAeFRc
        68mTVaOE289EjVMJHCSGxV3aWxPtIUmvgd8pPo2+Zq6ufnA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr11853749wrp.387.1586413692689;
        Wed, 08 Apr 2020 23:28:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQyxthAz+T5O7I6EbD5MfLeGRUxaOObbdGtSBFdRt4dwDRANM19mIiV3J17/2Ff2rDXxgdww==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr11853722wrp.387.1586413692360;
        Wed, 08 Apr 2020 23:28:12 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id l15sm2442959wmi.48.2020.04.08.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 23:28:11 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:28:10 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <20200409062810.GB49260@xps-13>
References: <20200327093620.GB1223497@xps-13>
 <202003271208.0D9A3A48CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003271208.0D9A3A48CC@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 12:28:05PM -0700, Kees Cook wrote:
> On Fri, Mar 27, 2020 at 10:36:20AM +0100, Andrea Righi wrote:
> > Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
> > (disabled) in the "settings" file for a specific test.
> 
> That seems to be a reasonable optimization, sure.
> 
> > NOTE: without this change (and adding timeout=0 in the corresponding
> > settings file - tools/testing/selftests/seccomp/settings) the
> > seccomp_bpf selftest is always failing with a timeout event during the
> > syscall_restart step.
> 
> This, however, is worrisome. I think there is something else wrong here.
> I will investigate why the output of seccomp_bpf is weird when running
> under the runner scripts. Hmmm. The output looks corrupted...
> 
> -Kees

Hi Kees,

a quick update on this.

After further investigation Cascardo (added in cc) found that the
culprit of this issue was the usage of nanosleep() vs clock_nanosleep()
in glibc. He already sent a fix for this:

https://lkml.org/lkml/2020/4/8/968

Without this we are getting the following error:

 seccomp_bpf.c:2839:global.syscall_restart:Expected true (1) == WIFSTOPPED(status) (0)
 # global.syscall_restart: Test terminated by assertion

I still think my timeout optimization patch can be useful, but for this
particular problem we should definitely apply Cascardo's fix.

Thanks,
-Andrea

> 
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/testing/selftests/kselftest/runner.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index e84d901f8567..2cd3c8def0f6 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -32,7 +32,7 @@ tap_prefix()
> >  tap_timeout()
> >  {
> >  	# Make sure tests will time out if utility is available.
> > -	if [ -x /usr/bin/timeout ] ; then
> > +	if [ -x /usr/bin/timeout ] && [ $kselftest_timeout -gt 0 ] ; then
> >  		/usr/bin/timeout "$kselftest_timeout" "$1"
> >  	else
> >  		"$1"
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Kees Cook
