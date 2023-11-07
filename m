Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB87E3745
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjKGJLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjKGJKy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 04:10:54 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1E1BFB
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 01:09:54 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so1895383241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699348193; x=1699952993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2MfTHW06s2XHpAxdT8l0iMGrrArXzb6NzKnXNeucck=;
        b=KVphLmUp4XiID8xEOMsL5Aee/B26agW1jgdY5x78Oui7letmqvvE12+TceFDpf5OQu
         Wm7CgINVBLenUSafOij+eBH6qBzdHQ98aQJ4I7HkLsPIJRS0+bA5PYbShCwpSQRADDkE
         gi164PNg3dtm4B4DCveMpZLWUdRtsMeqR5+eUtUwAiv9biloRiDmnvmZzSRcPojGXN3a
         wl6snSJUO+KKcGkPyG9JTuTNNB2+WxnNLEsgseJfUnu8z8WVJprU5F4kjttztQuFF05i
         uPEUv0GThYDUPSjuhmzLovt0jyzOw7ZVoIipzDjGCuYeKYs+/zKptbstBGcvaSmW2Cie
         rMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348193; x=1699952993;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2MfTHW06s2XHpAxdT8l0iMGrrArXzb6NzKnXNeucck=;
        b=XQuz8US3l2Cv/7blLVieClw7cHfEfvgKFjntxRs977WCwIyFwICa2DPbr/346wnSfO
         1qfJKbIPSPaiLgKIQayqmiJS/S9Z9oAik691wauGehcj7Kqk9lbDoffzSNBQBkqirjir
         JtTjBxZl9IY+F8xrBPzEZY0TASTYvr8wIJ8ThKovKIuHpIHSAlRCypy3j3Pn9wV3LDgQ
         AHN/J74K9u0xYAzYaoubedaCuPI2Om2dGyieLe1hpvD/spY7eB7WSh7Na3gWF+mgFrp/
         SJqryRMatIUcOnchiF0zluVbdXPrGiG+ubwcsHmTRrb23FrswD4e5Tahej0o3WxSU6iJ
         qxjg==
X-Gm-Message-State: AOJu0YxpJScscn+evS898gBiMVdw7dmw//QKj0Y1GY246wM1W8KIT4Vh
        CPDsZzzGT4qkuFuTfwRQtEXFwFNIJlHRTOn+090RHiMgkU7dAQOZ9LE=
X-Google-Smtp-Source: AGHT+IH3uuWOSzCZJJL8vnHL6vB9+YK2BBj2Qe5tFCvy7USCwVx9M2qvx/5XfBdg/XPBmh+tndz0I459rBh2AAiBm5M=
X-Received: by 2002:a67:b20b:0:b0:45d:b4ad:ec78 with SMTP id
 b11-20020a67b20b000000b0045db4adec78mr7173528vsf.31.1699348193078; Tue, 07
 Nov 2023 01:09:53 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 14:39:41 +0530
Message-ID: <CA+G9fYuOpsQpwwM4CC13ayc2e_e0cTJTrQSOgy=OZOBs_6aGHg@mail.gmail.com>
Subject: selftests: arm64: za-fork - ZA state invalid in child
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following selftests: arm64: za-fork test failures noticed on qemu-arm64.
But the same test passed on FVP and Juno-r2.

Are we missing something on qemu-arm64 ?
qemu-system-arm installed at version: 8.1
host architecture: amd64

Started failing from Linux next-20231106

GOOD: next-20231103
Bad: next-20231103

Please find the links to compare results between the Linux next tags.

kselftest: Running tests in arm64
TAP version 13
1..16
# timeout set to 45
# selftests: arm64: za-fork
# TAP version 13
# 1..1
# # PID: 348
# # ZA state invalid in child
# not ok 1 fork_test# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: arm64: za-fork # exit=1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
----
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2XmWvN5YW3lPR4UFwxEubBVVC7y/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231107/testrun/20969859/suite/kselftest-arm64/test/arm64_za-fork/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231107/testrun/20969859/suite/kselftest-arm64/test/arm64_check_gcr_el1_cswitch/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231106/testrun/20927295/suite/kselftest-arm64/test/arm64_za-fork/details/

--
Linaro LKFT
https://lkft.linaro.org
