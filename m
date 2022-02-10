Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898B4B19F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 00:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiBJX6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 18:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244876AbiBJX6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 18:58:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A442B49
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:58:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y8so10436929pfa.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YR8IQtD/vI0Y1e+M6XizQtHy3b7jDPUDq92ShhvVhXY=;
        b=WvA699vcudQ1Hqvg534eT88SqkZZUu9XbncYlIq5YSfbGxBOgf79rNjbQdJgyRASIM
         IqXbeJNG9EwbVYDcgKbqz8oFuhmymUJc7Q9wEocpEmasEjTf4UA1D230t3+ca8bhyhvT
         oJ+nwmJJMXpfwpxuSESZteARqV4U//GOcancE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YR8IQtD/vI0Y1e+M6XizQtHy3b7jDPUDq92ShhvVhXY=;
        b=rlAcqd0EofFGQEjMZ3MXGqKMo3uFfmlYZB2snsrUcT0kBq1G3pCwbD8kLDsdW4mlrV
         kgKFC6PKJMRKXs9c5Wde5/KlrHPiFmv9s3tr8Fz9suOsuQSE83emsqNp2a+DirHeDOHf
         GooovcxJelde47USUMuTkiixRWiEBPWZyZfPmmY88kb8eXKYpW5nd0YmK080/hhgLTow
         PG94IIx15SwE86NxGis3/wDCgHP5zmS/2twXLplecrsbPSZkn6mQ3nDPp1xDLAA1ZZ2/
         eaJV84JB4ainSQIHCTtVQm/dLVw+mKpiyr1FIOolO53WCHy+4KLjT/EAgnPF7/Cf0KBp
         EINQ==
X-Gm-Message-State: AOAM531cy4iwQfmmU6nuOkOJ9e/Hfhps8rwm4NHOkA6tWkipL+un6vHV
        nWtL3Q5NmIPiOd/cPoYoxEnISw==
X-Google-Smtp-Source: ABdhPJy5GMvA9RQgKwwGxZBjLxt0zVyf7HQK+78xkNaQvwD4gItRzhujUXj26y9sjkcRX+zQA5Fdng==
X-Received: by 2002:a05:6a02:119:: with SMTP id bg25mr2380854pgb.351.1644537510931;
        Thu, 10 Feb 2022 15:58:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12sm17362167pgk.29.2022.02.10.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:58:30 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:58:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Sherry Yang <sherry.yang@oracle.com>, skhan@linuxfoundation.org,
        shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        christian@brauner.io, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] selftests/seccomp: Fix seccomp failure by adding
 missing headers
Message-ID: <202202101558.497F6FC@keescook>
References: <20220210203049.67249-1-sherry.yang@oracle.com>
 <755ec9b2-8781-a75a-4fd0-39fb518fc484@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755ec9b2-8781-a75a-4fd0-39fb518fc484@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 04:14:17AM +0500, Muhammad Usama Anjum wrote:
> On 2/11/22 1:30 AM, Sherry Yang wrote:
> > seccomp_bpf failed on tests 47 global.user_notification_filter_empty
> > and 48 global.user_notification_filter_empty_threaded when it's
> > tested on updated kernel but with old kernel headers. Because old
> > kernel headers don't have definition of macro __NR_clone3 which is
> > required for these two tests. Since under selftests/, we can install
> > headers once for all tests (the default INSTALL_HDR_PATH is
> > usr/include), fix it by adding usr/include to the list of directories
> > to be searched. Use "-isystem" to indicate it's a system directory as
> > the real kernel headers directories are.
> > 
> > Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> > Tested-by: Sherry Yang <sherry.yang@oracle.com>
> > ---
> >  tools/testing/selftests/seccomp/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> > index 0ebfe8b0e147..585f7a0c10cb 100644
> > --- a/tools/testing/selftests/seccomp/Makefile
> > +++ b/tools/testing/selftests/seccomp/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -CFLAGS += -Wl,-no-as-needed -Wall
> > +CFLAGS += -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/
> 
> "../../../../usr/include/" directory doesn't have header files if
> different output directory is used for kselftests build like "make -C
> tools/tests/selftest O=build". Can you try adding recently added
> variable, KHDR_INCLUDES here which makes this kind of headers inclusion
> easy and correct for other build combinations as well?

Ah, if that's true I think there are some other instances in the tree
that need fixing too.

-- 
Kees Cook
