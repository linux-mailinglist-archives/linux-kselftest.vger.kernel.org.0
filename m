Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680D34A8D1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 21:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBCUUK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 15:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBCUUK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 15:20:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25902C061714
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Feb 2022 12:20:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r59so3454586pjg.4
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Feb 2022 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hFdTtKT21mEH4+tTjoJHsFtuYVciiyYoazU8wpyypPU=;
        b=VAQag2pY8XNY+icL8MkSQJcCFVbmh0OIoz6pAukIGz20y/14mkT3Y3seARCe31vRSE
         L0ZCFVLUChexXwQ1g9FxZ4QzkJowQR9Yd8a97dEqaNZGq5vBNTofzjlmcE7U1DTs9rtI
         dzx2rlSQoaoT1j8pFA7J/DddEzNbpaT8cAK4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hFdTtKT21mEH4+tTjoJHsFtuYVciiyYoazU8wpyypPU=;
        b=AI4fXOLrvybfTqw+v/lgZJphwiSzUMkjEeP0ZB/QGa2AuGAkECzv6T+46fpF6pndzm
         MLKHQmy+bG1V1FWXETtY+0NpdgUd+rSnr67FQ6HBvcxBogkSN22BLIIZM+pX67KUYkLy
         KU4pOlAo51PWm12j/hW1knQkiWn/5W8IH5HcnQYxwViQQjqAIL/LV0iKWZVKVZiGOJK/
         7m7DGDoO8tETnTg+PKIY5yp4LxZFPxckJSAV312r0XU0OCxOO8XOiPC6I8RCgVv7HwbL
         E9H88YR5V895Te6ZDz4KsmHCutzaTtWD7hhq3H6uOcAu08mMtWo8ev2OSSteo81aZI98
         YRvg==
X-Gm-Message-State: AOAM53056e04ZvoOMpWqHXZjMSVPtvhKO3WSreOvUelTm13EqHvu0qbA
        Q1GYWJj6iEU1fUXygQtWt9MvXPVLJt/Kcg==
X-Google-Smtp-Source: ABdhPJyJT2g+j4gS0SfC2cTM8nG8u0YK8qUNeP5XnlMpUB1WFnQ7Nz6qEVoHpAd7iBZHtGo1W8Sbyg==
X-Received: by 2002:a17:902:cec2:: with SMTP id d2mr37110643plg.100.1643919609642;
        Thu, 03 Feb 2022 12:20:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x126sm18175231pgb.85.2022.02.03.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:20:09 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:20:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
Message-ID: <202202031219.792E9AFF@keescook>
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 03, 2022 at 07:40:46PM +0000, Sherry Yang wrote:
> > This didn't look right to me. That's outside the build tree, yes?
> 
> It’s inside the build tree. “../../../../usr/include“ may look a little confusing, it’s actually linux/usr/include (linux/ is top directory of the repo we git clone), i.e. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/usr/include?h=v5.17-rc2
> The file tools/testing/sefltests/Makefile can install kernel headers in default path “usr/include”. “../../../../usr/include“ is also used in other Makefile of selftests, like https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/clone3/Makefile?h=v5.17-rc2

Ah-ha, thanks. Following the other example, should it just be -I instead
of -isystem?

> > I thought there was a proper "updated kernel headers" dependency that should be used for this?
> Updating kernel headers could be one solution. Adding “../../../../usr/include“ in the header file search path could build the tests inside the sandbox.

Yeah, this probably needs separate attention. For this patch, if -I is
sufficient, let's do that.

Thanks!

-- 
Kees Cook
