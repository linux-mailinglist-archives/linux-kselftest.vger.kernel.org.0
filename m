Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43363710D20
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjEYNTv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 09:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbjEYNTu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 09:19:50 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82887191
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 06:19:48 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-438f80597d8so315043137.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685020787; x=1687612787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxwYtGB9RBUo2ARBEDaRy/j62e5UsedQQydMRI+nQLA=;
        b=MMcqVtbtrkBNeoUv3HforN2Tm6L6iCwCIBv793tAV7Ufz+ANrbu/ezmTA7UZp8mXC9
         lH57eB6u4V4f3StbMW1WCizBsB+CJpTnCn7Yi/QsuWgeWKHxcF3/ELMDVukdHwpEu9qC
         Fjprx7sB6aEz6BcNaTkAwUDS7PmPBpQBTlHhiM0SFDFb1R9HC3uTuG8HjVOF0XVF1EM0
         BRUD0y7jNUgTE9+NGSGJ2FR9V/6ix5KcLWm8DH3hEN3Sjinzosx5kYKz9zIZ/cZemS+N
         klVuoSk/wGC1vBt0es3psdtY+hJkt7sQUMg8CViSOYXwXEq4rWbCK4RfyntGFTHYg8O9
         UHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685020787; x=1687612787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxwYtGB9RBUo2ARBEDaRy/j62e5UsedQQydMRI+nQLA=;
        b=DpxjmBwZ7fB2ln8gmodT74mtNj9wYRBKZ3i9aynUkU1oc2/NT1OGnbWU2S/FToFP4z
         cQHYEbG77zxtcS9HbF6YtKzbj6Yo8OGZ1UmsZdBfKug+yArCpK48bPVkj1A5/jUg+IUq
         Jka0k6V7OBBrP4loaZ6j6lmCdoX6S9qKV3eZxI5hBkF/6+wSdNgzBckMCnIt/1GcF4kg
         A81X3B7w1li6JBa405tUQBuHIhrjJLwTlVGUu64+3Zw/q7t3n4dyEKWzPc/ig8PvWCcK
         T3BkINXQ2vZpt9KXk9dMWUcJ96i6GqZY0S4y89bTywpx5lXg25MLDW/Pl3Tg1ZYBGw27
         bCVQ==
X-Gm-Message-State: AC+VfDxn4APkxaLAJju+E/qLZfeV1urFdzpBN4SRgCXH6KjJks5616mq
        +9IiHTaIRPhs+iOWhQRNuAwR6NOLQc+G3x0xHICFyQ==
X-Google-Smtp-Source: ACHHUZ42Drc7sO+IRPZGz/5d/uVry/K390ESSzAk3GBhH6r+qU6dbeXUk2WO+qVRetwGo9sXfBaagpUHwTE1H2R+ODo=
X-Received: by 2002:a67:cd82:0:b0:430:2d04:4691 with SMTP id
 r2-20020a67cd82000000b004302d044691mr5130904vsl.23.1685020787396; Thu, 25 May
 2023 06:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
In-Reply-To: <20230516134447.GB30894@willie-the-truck>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 May 2023 18:49:36 +0530
Message-ID: <CA+G9fYtZjGomLjDi+Vf-hdcLpKPKbPmn4nwoPXvn24SG2hEJMg@mail.gmail.com>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     Will Deacon <will@kernel.org>
Cc:     broonie@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Will,

On Tue, 16 May 2023 at 19:14, Will Deacon <will@kernel.org> wrote:
>
> Hi Naresh,
>
> On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > Following kernel BUG noticed while running selftests arm64 fp-stress
> > running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.
>
> Is there a known-good build so that we could attempt a bisection?

[ Sorry for the delay ]

Since this problem is intermittent, It is not easy to bisect.

On Linux next this fp-stress BUG: has been happening *intermittently* from
next-20230314 dated March 14, 2023.

On Linux stable-rc it started happening on 6.3.2-rc1 and 6.1.28-rc2.

Here is the proof showing the intermittent occurance on Linux next,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=3
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=2
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=1

Here is the proof showing the intermittent occurance on stable-rc 6.3 and 6.1.
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3-rc4-1628-g48aa7b4284af/testrun/16730800/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.22-1202-g2b7e1f92aa55/testrun/16814751/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/

- Naresh
