Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D57773BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHJJKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHJJKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45C2123;
        Thu, 10 Aug 2023 02:10:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-26929bf95b6so387269a91.3;
        Thu, 10 Aug 2023 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658601; x=1692263401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+H9VGuNWW1HuVdobl6UTPeoLWh92A5dHZajmlrne1vg=;
        b=NNAYxA0NfcUSL8wZji8Ds3je3VtOoz8v0SGcp7urBtRCixdaJogdN6zIC1YJyT6U/H
         gSNKWLvgY0pB3EUMbY6lZ9nTvHZ1+CSpa/sOiql+HFy4uSMsokCzI1RzRiqMv5Tih9rO
         s7LFdb+sZq3xLcO5N+rag9RaAw1Uo2QWfdT/twghqUmVAvuFsfuI4N7sBx9d00ahOwK2
         A8+r4KWrK/nxD6PCHZcqaZPjUfplnqbZurIsxfZQXeWyNoQfbTod6j6tT7I06q2xqfrN
         qM9JzQCW5JK7bl2uyGnjLGK5bV9P9BK7cC+ncIvdzDG8ruGi3CRCWOCordFm0DlDmN87
         uigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658601; x=1692263401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H9VGuNWW1HuVdobl6UTPeoLWh92A5dHZajmlrne1vg=;
        b=V9PGQOk3kbgodzqsFWcPPQwppWHQgO1hFB7+V5oyZ69SLPqSOgiFQxJwErjRKMCD8b
         JQdE934UpTNBLud7UaJPocpAo8zcn0iTurBnuVoXn+Xh4WreU6pEFjirI84mopJGA32K
         Flx2zX9f/8idTCLfti/ANtb5kHV5utCx09bcGvm58BIM1NRdY2BDVo/wRmvKTAwYWCMa
         8TTkixj7Nx9NWDB/mKNBViCEcfx5Y4ie2GdE+zE4vKWALUjafkr+aMjyA9nVDclyzx5k
         ifBfzKJK11rrSGhy7fXKHmG8kgjjquK6KMY6r3hOeh5UsZCEteC+mcQZi++DTzdTW/6h
         e//w==
X-Gm-Message-State: AOJu0YzgQH6eIh86p1g8Vw8w/dkIu4uTLRnDIYmLjNaxPn0z4MFUgvZ4
        o4IsHipWowpfHHrbFc5S+Z0=
X-Google-Smtp-Source: AGHT+IHSh2iIEqpe/4nqMvxOLL22wkUnt3AG0UDW7lKN2SUjLVLhHZiuRMGC5ya9UQK1BSmBKJdqTw==
X-Received: by 2002:a17:90b:1b0b:b0:268:1b7f:257b with SMTP id nu11-20020a17090b1b0b00b002681b7f257bmr1276287pjb.24.1691658600789;
        Thu, 10 Aug 2023 02:10:00 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:00 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
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
Subject: [PATCH v6 0/6] KVM: selftests: Improve PMU event filter settings and add test cases
Date:   Thu, 10 Aug 2023 17:09:39 +0800
Message-Id: <20230810090945.16053-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v6:
- Rebased to 74c2185c5b74(tag: kvm-x86-next-2023.08.02);
- Use TEST_ASSERT_EQ() instead of ASSERT_EQ();
- Fix a bug about x86 properties for Intel PMU in patch v5;

v5:
https://lore.kernel.org/kvm/20230720114714.34079-1-cloudliang@tencent.com/T/


Jinrong Liang (6):
  KVM: selftests: Add x86 properties for Intel PMU in processor.h
  KVM: selftests: Drop the return of remove_event()
  KVM: selftests: Introduce __kvm_pmu_event_filter to improved event
    filter settings
  KVM: selftests: Add test cases for unsupported PMU event filter input
    values
  KVM: selftests: Test if event filter meets expectations on fixed
    counters
  KVM: selftests: Test gp event filters don't affect fixed event filters

 .../selftests/kvm/include/x86_64/processor.h  |   5 +
 .../kvm/x86_64/pmu_event_filter_test.c        | 317 ++++++++++++------
 2 files changed, 228 insertions(+), 94 deletions(-)


base-commit: 74c2185c5b74fd0ae91133ad5afe8684f6a02b91
-- 
2.39.3

