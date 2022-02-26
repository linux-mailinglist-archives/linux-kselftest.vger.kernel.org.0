Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4594C5359
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 03:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiBZCYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 21:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBZCYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 21:24:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC31CABDA
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 18:23:27 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l19so6263428pfu.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 18:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f0XyVRsy6VI+7eRXJAPqPSb00XdxH7dw8UKaExj76WY=;
        b=GbbdOdzubH9OeXiGvJCqbZANneBAor10rlDy64UkWrUddr6ky6pTk20qwBTntYhEbs
         zqPvVzlCk9wq2RGLlGlCgYYvieOosw5pCn0kDFQYlW9iHMYXvb58O/p+g6S/JX2kkVSM
         1He00hlo1YNX4NuSvLTHqFpdFrRtPOFiM9TlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f0XyVRsy6VI+7eRXJAPqPSb00XdxH7dw8UKaExj76WY=;
        b=SMRomXe3YeNvzZbX2bavVjEwvX+q90zeSGxGlHZMz2/JQLX1pyqEyJqjpAy++QzgMI
         bC9z3Q6rDdS5N3ePWhr/7oAfKXRE3w9rll68Wv0XDUZCxNIlDu01ouCchDUjgWNJ10I6
         k84cfkIDIUjHrfxQkDWzfmrv9+amdUhv/avH4eB3LLZwi+A4rEjfdcju1+7pgCmmGMGd
         C66RapPJMGOTWP2tWc+bYRrZqBwtm0YrTdbw1rtNqktFElkaVNgsDsO0svx1kG0vG+ry
         BB/hEjmrIshGq5jjc+vp74OaVP1Gtx70scXGOdJdtJ/fc5opJ/9TDBo4uzmDCTGq92T0
         e3Bw==
X-Gm-Message-State: AOAM5320zWfyWs5J0oBLtDNbY6ljdnu/jrR0phs860B6L9wQ8P8EQPGg
        i8gJX30qFZk31iD7eanZaYvPLg==
X-Google-Smtp-Source: ABdhPJyGHey3mOCBptss5gAziA/MSrAvAK5hKHAs1C85u6b/2KXCUrd4ZfmYqJyFhOM+4DuxoD5d2g==
X-Received: by 2002:aa7:9429:0:b0:4e1:5814:79b3 with SMTP id y9-20020aa79429000000b004e1581479b3mr10582289pfo.82.1645842206911;
        Fri, 25 Feb 2022 18:23:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b004df51429f31sm4914239pfz.79.2022.02.25.18.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 18:23:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 18:23:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] kselftest: add generated objects to .gitignore
Message-ID: <202202251823.138A87C@keescook>
References: <20220225102726.3231228-1-usama.anjum@collabora.com>
 <f3757ff8-0078-4cf9-c0c6-95c780b90ae2@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3757ff8-0078-4cf9-c0c6-95c780b90ae2@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:59:58PM -0700, Shuah Khan wrote:
> On 2/25/22 3:27 AM, Muhammad Usama Anjum wrote:
> > Add kselftests_install directory and some other files to the
> > .gitignore.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >   tools/testing/selftests/.gitignore      | 1 +
> >   tools/testing/selftests/exec/.gitignore | 2 ++
> >   tools/testing/selftests/kvm/.gitignore  | 1 +
> >   tools/testing/selftests/net/.gitignore  | 1 +
> >   4 files changed, 5 insertions(+)
> > 
> 
> It is better to split these patches per test - makes it easier
> to apply. Please send separate patches for each test. This patch
> doesn't apply as is.

Once fixed, please consider them:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
