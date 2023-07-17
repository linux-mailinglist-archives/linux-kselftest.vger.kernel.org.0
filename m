Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA24755B6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGQGYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGQGYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C255E72;
        Sun, 16 Jul 2023 23:23:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b8ad8383faso33118805ad.0;
        Sun, 16 Jul 2023 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575038; x=1692167038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTanHtsmF21cCPJwNstFoxrM+0bevkq/7IiiCQrDPPs=;
        b=EK3WdOBvqfALSyPo7gfwnfvh3UTy4sm6q2xW+jZgoiC8VOTw5kzxKDMbiED0KSAWBY
         eAbB7YA1PwBLSJYDTmjNAimy/Zse4SWlPvCQ7R9HOdQFe5Y9yCs2VqlGmJgkTPcKDW3o
         sBoMvxIHjsvUNpSd8nJ1n6b3q2/DhDOC9XDnSVVW2BDdSXtpBDeaMAe91WTiCfRVEYnn
         mtLtysl0dEtPI5j4C8ZXnCU3sVjRRGCLDN9ly28wYHI9xhr4Zf9fwzRCjR3ln5kx6uQ3
         u6iUPLlhLSJmsSPIRPCfz8duX9VvEt/nZI3PMNLEw5s5/njPAi2jfMqlh+bLXcTboIuN
         nzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575038; x=1692167038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTanHtsmF21cCPJwNstFoxrM+0bevkq/7IiiCQrDPPs=;
        b=cETtxwDHP/7kyQGsLDnBFPoNvjEoRaa55KXseczFyH9o1/WGNVBJXPDpD40WBAhgAF
         qcefUPXvvdXu4orno5kV43PNlzqF3JPG6sPyvCVZxSYLapNXvsrNEJSLTD4ojpGx4emx
         oRfE5kNaU9USQ7MWSVhYf4vFAzoyDRATpOcIfefvgXUPI2h1Pwf9Effssr0tfeewiOHK
         DWJU7QD//GyAL2cVfR/xHtnfzlVqzcw6wLtxXObRFV2qE/p8ydZRN1N4MbtE6evKJsxT
         x6Hcm6Re3fj3OSm0L3drUxqzFsGgz7AOXKeQPJnvK/oCribpv1uIAWzruqz0NOmhXT43
         ok0g==
X-Gm-Message-State: ABy/qLaJSlpcjS8tLH13Y3zrg09IzKS+BY8AxpH1ZX8ZBB6ptRdpESvh
        iA1JwxiH/QWCKAiL9+kNd1k=
X-Google-Smtp-Source: APBJJlFQ7iHoM8b7m3ZKhigdpdI44UxBvh6vSMsojz1TYxeR0aIsBndM7jl/QvE5+UPymqI50EZUWg==
X-Received: by 2002:a17:902:eccd:b0:1b9:ebe9:5f01 with SMTP id a13-20020a170902eccd00b001b9ebe95f01mr15459633plh.19.1689575037759;
        Sun, 16 Jul 2023 23:23:57 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:23:57 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] KVM: selftests: Improve PMU event filter settings and add test cases
Date:   Mon, 17 Jul 2023 14:23:37 +0800
Message-Id: <20230717062343.3743-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patch series aims to improve the PMU event filter settings with a cleaner
and more organized structure and adds several test cases related to PMU event
filters.

These changes help to ensure that KVM's PMU event filter functions as expected
in all supported use cases.

Any feedback or suggestions are greatly appreciated.

Sincerely,
Jinrong Liang

Changes log:

v4:
- Rebased to 88bb466c9dec(tag: kvm-x86-next-2023.06.22);
- Add a patch to add macros for fixed counters in processor.h;
- Add a patch to drop the return of remove_event(); (Sean)
- Reverse xmas tree; (Sean)
- Optimize code style and comments; (Sean)

Previous:
https://lore.kernel.org/kvm/20230607123700.40229-1-cloudliang@tencent.com/T

Jinrong Liang (6):
  KVM: selftests: Add macros for fixed counters in processor.h
  KVM: selftests: Drop the return of remove_event()
  KVM: selftests: Introduce __kvm_pmu_event_filter to improved event
    filter settings
  KVM: selftests: Add test cases for unsupported PMU event filter input
    values
  KVM: selftests: Test if event filter meets expectations on fixed
    counters
  KVM: selftests: Test gp event filters don't affect fixed event filters

 .../selftests/kvm/include/x86_64/processor.h  |   2 +
 .../kvm/x86_64/pmu_event_filter_test.c        | 314 ++++++++++++------
 2 files changed, 222 insertions(+), 94 deletions(-)


base-commit: 88bb466c9dec4f70d682cf38c685324e7b1b3d60
-- 
2.39.3

