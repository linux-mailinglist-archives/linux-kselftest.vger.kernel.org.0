Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EA782B03
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjHUNzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjHUNzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 09:55:03 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660CE3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:55:01 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44d4cef5effso342779137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692626100; x=1693230900;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0BIwaProopNZhstbg9lTsI04/iv8W4aYXrom5pRfgU=;
        b=p2UhUdFkBPNSM+ZwAjfOpSAie2xqFBZ5JS5ZOHEaRTOCJAVwP+JKYbKvuzzcmlZYnz
         ZQTiKHY5oyTPCq4Q5nubkYQkwFsSO/MpG6chqdtuKxeQ2oh3SbPQgQHzs7Gf5dCKOVLb
         Ii4gk5NUCq4pDQ6NrzDPeRk3ACnkf2DCWMWfKs7Kbe+6Cx0MTOFPPPMMrf3JAW4PUN2W
         /7yFJ/BPpBH94/mUuWbKtHyTkGkOZODIokMGTHm2FcVKEoqsOUL5ZH2xuMVirsdAIkrM
         iFyqrH4ZDTYTMgycgX7HihtLJuja0dLw4FGjmdHUMfj7PVqL2GvPbwNibZ3MhbFsXqtk
         Fc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692626100; x=1693230900;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0BIwaProopNZhstbg9lTsI04/iv8W4aYXrom5pRfgU=;
        b=aaf7MLazN/nwumDGc0+KJjOUa92W653D92r8V5h3FnAvo19GP22s+eNaSEEKXW1xEQ
         r7khEXtu3qOuhFP3W5xGLkWLPCmSfBhggPJ7qj6Jfng22kH/G6R20oY26Dw7HKRrP602
         3gk+O8pq0e0agguhW6s7gFm43A4WIwMjwLIvRX7GvLlXUYSiP+mttIvJ1sY6KqJNR3SH
         AFJ7R/iYK6u3dIRSmSLFoxXGKtlcFe5rxOt/DSxwoi1eTARUV/rPMMH8o9WqsWFNKYKl
         OOqU/pLRKbTQV3yZcbfcD09GRC/8cp375IQBtkUV9bYDvDxZzIXM0YVfKDyIYsKdQtTq
         R8jw==
X-Gm-Message-State: AOJu0YyQHZaYDTNxLnA6PXbGHeqd9Pq3fj6xhoKMyrMWwzgGNjspHaDt
        5GM0ywXfSFEB2a89ucKT6xYYkbc7oJZt7jTm04yg5A==
X-Google-Smtp-Source: AGHT+IE3+XppUv1Ml0JhYni/I5RGW+uUuJuIpJ/WchgYXbES0F/6QnjcqqyZzmPd+zJHTWzUr2H6bIT0YLWulKqbkmY=
X-Received: by 2002:a05:6102:3165:b0:443:5ec3:55da with SMTP id
 l5-20020a056102316500b004435ec355damr4877341vsm.15.1692626100448; Mon, 21 Aug
 2023 06:55:00 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Aug 2023 19:24:49 +0530
Message-ID: <CA+G9fYuwQ13KhSxYS3wVpB2vU-wtfiFYzCvM5r=tog3am6--Lg@mail.gmail.com>
Subject: clang-17: selftests: exec/load_address_4096 clang: error: argument
 unused during compilation: '-pie' [-Werror,-Wunused-command-line-argument]
To:     clang-built-linux <llvm@lists.linux.dev>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recently we have updated the toolchain clang-17 version.

While building selftests exec following warnings / errors noticed on the
Linux next with clang-17. But pass with gcc-13.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

exec/load_address_4096
clang: error: argument unused during compilation: '-pie'
[-Werror,-Wunused-command-line-argument]


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230821/testrun/19213758/suite/kselftest-exec/test/shardfile-exec/details/

Steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/tuxmake_reproducer.sh

tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9Uq9EFceoQd0VL/config
LLVM=1 LLVM_IAS=1 debugkernel cpupower headers kernel kselftest
modules


--
Linaro LKFT
https://lkft.linaro.org
