Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF17E4693
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjKGRL5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 12:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 12:11:57 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA02101
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 09:11:54 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so2331699e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699377113; x=1699981913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QENmxdgfuk+x+B3cGimHDh/NlILJUpwyA1oIPFw8pg=;
        b=ZF/q/74rYgymTn94qdOR5t5PMX/YoJBM33OSzL2fawFedIGcBy5uvBsNNG1NxKijX4
         ubtzqbvphnqMiZGdxpvfYEFzxTkra1wichVO84vqETNsRTPnRu/DUwJ7bM+ya1rDCgxR
         7RYvhZAkl+9xU9HG6uLceVzX/x6S6ByGkr3dWzkZWsGG9U8l/kRfbMD6eX8w9re99d1M
         Kh6WmKvM2cYimvtnHLDRpwtAi7EquGKnJa1aGUUEyAyRQ31sJeIdUU+SMj0Vd8cJs9c0
         gO1JyVZBhe10GxSAVzwhMzWQ9sftEL0mB7vqgDFGW0S0xJX+mTXKeSBMAMja2JeNfAOi
         cdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377113; x=1699981913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QENmxdgfuk+x+B3cGimHDh/NlILJUpwyA1oIPFw8pg=;
        b=MpldDmxyRi5+S+mI4gYSp3GrMe+0krafXeCZ4ErxLK5KBDGjCLgF/kZH0Me8OhMgeB
         ymvGYOxYa8ooL/WiEGHO8j+kTfT0H4To6GbXmhX2sRv9A9ctRVuGLwQXAaVj6zng+iWk
         y4FWiSE/CfBegWiuvCPl+eKNCVQ6n6TDIqUMdz9N9g0prjTpyiCf7rDT/3mhJrbdxInl
         uVX/RPu/xzx91kk7cbrooki7DU5cMZRb2oOyRF69/Jp92uHdzYVig5Rs6wf7A584IXho
         xcuTC2d1yG8OGXWjNnYPBGWkbE++s07PZQk4RpwJTKhnnbYd1CQMaGE2GI1Zi9m3ESHi
         Bm3w==
X-Gm-Message-State: AOJu0YxoBKL9oV6BX3hgUopE989O2pbBOfRb4QZ6iaGV7GnQGiGjM7r9
        AC6MCWl0tY/hiEouHk1SNhoSMapxcGfTGIsFgug8LvMc5DXbqSKsleE=
X-Google-Smtp-Source: AGHT+IEJNvdPeBUp+NJYfjA3rf7NwnCO74+6cg7WigXZidT4CAsxPzLequLqBpsFozlD42ASbmJtbY1WRA0sjdtFlvk=
X-Received: by 2002:a1f:b201:0:b0:493:3491:ce89 with SMTP id
 b1-20020a1fb201000000b004933491ce89mr21830541vkf.14.1699377113412; Tue, 07
 Nov 2023 09:11:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuOpsQpwwM4CC13ayc2e_e0cTJTrQSOgy=OZOBs_6aGHg@mail.gmail.com>
In-Reply-To: <CA+G9fYuOpsQpwwM4CC13ayc2e_e0cTJTrQSOgy=OZOBs_6aGHg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 22:41:42 +0530
Message-ID: <CA+G9fYsOQbdJJ=pAezrfqRT3wrwXyo6TX=rbCRgj2BcYTOdtdw@mail.gmail.com>
Subject: Re: selftests: arm64: za-fork - ZA state invalid in child
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Nov 2023 at 14:39, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following selftests: arm64: za-fork test failures noticed on qemu-arm64.
> But the same test passed on FVP and Juno-r2.
>
> Are we missing something on qemu-arm64 ?
> qemu-system-arm installed at version: 8.1

The Qemu version got updated from v8.0 to v8.1 and this test failed.

- Naresh
