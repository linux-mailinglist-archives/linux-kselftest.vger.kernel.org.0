Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0877F4A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350092AbjHQLBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbjHQLAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 07:00:43 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593A30C0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 04:00:39 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447823dd96fso2241211137.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692270039; x=1692874839;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZfMepvXg3qvtrbHn0BjG22kHp9b7uQ/uXEZyK1q+hE=;
        b=G2/DX7qptVpsyagL0UIvZrbSuYLIkaH0lNb5G03nLnUs19Nt1GAMlDFR1DPUHQYwf8
         D7jYv63MYLnoL8z22BgkKDjH/Bz+y73zWTTMWpo7X6fkV6R+iGXkR7uUx1U0J7rLRksV
         yxyA5BZU6HVfnN3FEW8ZrawF6mI8A/4tTHpXUBvvV3qoxFZW4CFTJwcKJFNN8OyQw1uh
         UtbN0xSpd6gepWwlhgqMJRZ2IVnaKVtVzchbp9dugTT1ZAX6cYM7sDy9oJBZx6LsNoAx
         BEjeVC7xWWo+9AN58o/g9oR+yWM0NseAUTAALWV9f9i/0x0sWclCVOK3hV9YZ4rpNvnu
         8zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692270039; x=1692874839;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZfMepvXg3qvtrbHn0BjG22kHp9b7uQ/uXEZyK1q+hE=;
        b=Liu3elxKOsA7alVGzILqxMsT5UnbKXsgu4+8gVi64agRgLKSIyfmaJRBqy7JRuH6+N
         5PMCmWhW6hoka+DnkbX7S+1dJCGbJ0YwMV8wCWV1sDRW0Ffjt5RCUBYeH6B+V13WHZ1X
         ol293Quia1EYRJ7AbbP6DiGImOcFQqstQkqA2Vz4YSTHU+osmeJLHW1NUoCpmDFdNn87
         arbdbIZxIL+Ys1cevC6NSIBS60LzqTls/7MRkxhPn738x/naoocRWoWBmp8IaVvC+WPo
         SH15IsM8TLqQ7Do7COEU5cMcBT/75wlD6Mv511SI6J7EjaWh3C7s+67u/TwLruaqRo7l
         CgvQ==
X-Gm-Message-State: AOJu0YxHva92F3pmn00PeMgxKLIZUru/M19t/sE1McymiwWWJ8lxSlwp
        JPHqLHocwP/EQWPxq1fIgj2q2Q/WJNDHV8buOF9mYQ==
X-Google-Smtp-Source: AGHT+IFqL6u8k9ycO0ncWBs+dW20/DPk/E5uRvud3mCrHpEvhoOVAaag9XvvewRBCOlJAMngLcBac5965k8GukIKOlw=
X-Received: by 2002:a67:bb08:0:b0:446:9cc3:ccf with SMTP id
 m8-20020a67bb08000000b004469cc30ccfmr3337886vsn.28.1692270038874; Thu, 17 Aug
 2023 04:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Aug 2023 16:30:28 +0530
Message-ID: <CA+G9fYuW2tu3Tu_8rMoXK_anMJO8t9qw2vhxfQrLXY04rCRPqA@mail.gmail.com>
Subject: selftests: timerfd.c:64:7: error: absolute value function 'abs' given
 an argument of type 'long long' but has parameter of type 'int' which may
 cause truncation of value
To:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While building selftests landlock following warnings / errors noticed on the
Linux next with clang-17 toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------------
timens/timerfd
timerfd.c:64:7: error: absolute value function 'abs' given an argument
of type 'long long' but has parameter of type 'int' which may cause
truncation of value [-Werror,-Wabsolute-value]
   64 |                 if (abs(elapsed - 3600) > 60) {
      |                     ^
timerfd.c:64:7: note: use function 'llabs' instead
   64 |                 if (abs(elapsed - 3600) > 60) {
      |                     ^~~
      |                     llabs
1 error generated.
make[4]: Leaving directory 'selftests/timens'


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/

Steps to reproduce:
tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/config
LLVM=1 LLVM_IAS=1 dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org
