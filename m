Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0C75AD4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGTLre (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGTLrd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:47:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B882E4C;
        Thu, 20 Jul 2023 04:47:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1bb1baf55f5so5046345ad.0;
        Thu, 20 Jul 2023 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853651; x=1690458451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pm+ZiCLxfzXJFCGZxj70SzgUnZv/5EU+mG9q9maXO+k=;
        b=Aw1EzpE/06SYOycamBZQ/PGlPEx0P1ZQnI2hn10ObSbP3Uj0V+hwonRJo31rR+XtX6
         /CMcKyh2ujLwDgW+A0zUF+QdQ3VcB/E6jnaFvBNUX9Nu4dKlpc15Zh2Wmupv4YRSvTkb
         EhNjGCiuHygnZfAJRtHn7DpyVb4FJ1QUGAi8jfkkukDa4Rk7FnShbmBVFOUKNVAWUhD6
         1ouBbz6PcNN46kURkgbN50zUWSH/GKu+azXtC/H3I+F5gz107kSbORie6V6phDGrAH2M
         imYj3x6GHLaiBHtSS8rlEND5+qzy1vK8nibOFvlv5Lvj2PbXgQyh+cqET9kvpJdOxWTC
         7z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853651; x=1690458451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm+ZiCLxfzXJFCGZxj70SzgUnZv/5EU+mG9q9maXO+k=;
        b=VYlU8+HmWMexQg9wiTN5FIZsj9V2DMYR7g1705YIx7Wy8hrGAS+BllOwXlHqY2q7BM
         IShUtl+K56FaY166Fy1AAEkLzZx/iCXuxJMPyWs12xAHrZ3QkpMvfdiKWjQrubashUOK
         2vLslf5g3XMI45dIfTrZc9/0aRfc869U4q43IWpzF9sA+666pbokN+TXOdWoIw1RYZ5+
         VDYUIX2OvLXx1iIUVRu/hK07R2NLJ1CKIDMGdbaguEPjsh9EVmwfECf/pO0RIA72eW2H
         6O/xcC7OTJv7IvGOlqon2Io+GX6yyQcJKvVMmoD0pyoP561uCyw5yfLVH+u7vkqbxCMq
         ya+A==
X-Gm-Message-State: ABy/qLbcIl5OuIdBNtu6fFivBm0kBMiv21wDm/v3iBmDkEnSjuf8SDXI
        R9jCeistqh1b/djAH4GEbSI=
X-Google-Smtp-Source: APBJJlHRIbT8QqoeXntIWVAmUI1I6Rp++nlGOf7ymddxmsa4xVWnRSocsOEv30spyKDGZuLb43Wvuw==
X-Received: by 2002:a17:902:e743:b0:1b2:a63:95aa with SMTP id p3-20020a170902e74300b001b20a6395aamr23821215plf.54.1689853651203;
        Thu, 20 Jul 2023 04:47:31 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:30 -0700 (PDT)
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
Subject: [PATCH v5 0/6] KVM: selftests: Improve PMU event filter settings and add test cases
Date:   Thu, 20 Jul 2023 19:47:08 +0800
Message-Id: <20230720114714.34079-1-cloudliang@tencent.com>
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

v5:
- Add more x86 properties for Intel PMU;
- Designated initializer instead of overwrite all members; (Isaku Yamahata)
- PMU event filter invalid flag modified to "KVM_PMU_EVENT_FLAGS_VALID_MASK << 1"; (Isaku Yamahata)
- sizeof(bitmap) is modified to "sizeof(bitmap) * 8" to represent the number of
  bits that can be represented by the bitmap variable. (Isaku Yamahata)

Previous:
https://lore.kernel.org/kvm/20230717062343.3743-1-cloudliang@tencent.com/T/

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


base-commit: 88bb466c9dec4f70d682cf38c685324e7b1b3d60
-- 
2.39.3

