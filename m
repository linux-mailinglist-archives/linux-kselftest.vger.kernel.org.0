Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6694F643966
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiLEXXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEXXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:23:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FB1835C
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:48 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso14623671plx.23
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iTzvLGTWLJU89YMgwwnvlvr5Kpl1FGcMOvQ/pbHMzbM=;
        b=KyLc9GV6/CUhfLU9IMoTcRlJBolS4+1t6RFTh27gP6FNWM6iBDARcbicN/NRlkk2pG
         WNxXokZ7XWgT0JLwBf+ynDuBAueLnOZ5JIBM2uEM3nLhWon+4dRxcWASghQUKXVxDKjH
         iaKcEiGQOXpuTi5eY8wv7Wwd79mDU7ZiXvV4EMZMOqU6gx6sdNTGEQU418uoFyU/MReQ
         3x+tGwBIwIcdVA4w8/hE7fxnLR5UqQWJ3W2eLdCCykT3kmulLBLBFnzZskF851JmZWG5
         ct+FjREgWuWF2RhVDJApm64ZCPyM015zcTrOuq8Y7uQ/+phMgvoX+mLMRifE6uAPHrVL
         0O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTzvLGTWLJU89YMgwwnvlvr5Kpl1FGcMOvQ/pbHMzbM=;
        b=KOYqQRU+4SQQG+jPowrHIKzCPPHCJr6ZZpl8fwZvM97ejDaJJ0ZNsO7VNYM/6XtYui
         7dkBSlCyNcP9JaGcH+by3yAr6Ssjw7cHnPcrPGH/OpOVrdSNiuumar8ejDBpdrFnku0d
         Olcj4Alxxw3QnRGjHG75cX9QTGRx9dd+JYCa+makFS7eJqMa52MrX/5wjAYWcFF15DcN
         IvFbnsZDJ5dH7bqT/m0Y1C3UC3zqdxjdbe+ERdF0AGstcPcEz96f6W5sq7KfKwamxYpx
         Mndp7KjgY4oWOE2oFzAUdyr86lm7R7It/E88A4fI7LjL3vzGXUw6VGB9PTYPc8GFVLFT
         PfKw==
X-Gm-Message-State: ANoB5plnimSgoN7VzW6zQdzmGhbBr7XNIKIkj3SgZvOzbaO7T5hPL97H
        F4zdE0IjE179wQEq9nedfY3K+V8dQFirrlA4
X-Google-Smtp-Source: AA0mqf5CdXisKqVqfLw5y4zzdp9qmnLMHkYaZESKkO1KmxpM9AyOvGpCtQMPOR8mVUx0v3ibazqfAsfgDQ3kieyR
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:7d0f:b0:218:d50e:5af8 with SMTP
 id g15-20020a17090a7d0f00b00218d50e5af8mr67751305pjl.26.1670282627518; Mon,
 05 Dec 2022 15:23:47 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-1-vannapurve@google.com>
Subject: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series implements selftests targeting the feature floated by Chao via:
https://lore.kernel.org/lkml/20221202061347.1070246-10-chao.p.peng@linux.intel.com/T/

Below changes aim to test the fd based approach for guest private memory
in context of normal (non-confidential) VMs executing on non-confidential
platforms.

private_mem_test.c file adds selftest to access private memory from the
guest via private/shared accesses and checking if the contents can be
leaked to/accessed by vmm via shared memory view before/after conversions.

Updates in V2:
1) Simplified vcpu run loop implementation API
2) Removed VM creation logic from private mem library

Updates in V1 (Compared to RFC v3 patches):
1) Incorporated suggestions from Sean around simplifying KVM changes
2) Addressed comments from Sean
3) Added private mem test with shared memory backed by 2MB hugepages.

V1 series:
https://lore.kernel.org/lkml/20221111014244.1714148-1-vannapurve@google.com/T/

This series has dependency on following patches:
1) V10 series patches from Chao mentioned above.

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/priv_memfd_selftests_v2

Vishal Annapurve (6):
  KVM: x86: Add support for testing private memory
  KVM: Selftests: Add support for private memory
  KVM: selftests: x86: Add IS_ALIGNED/IS_PAGE_ALIGNED helpers
  KVM: selftests: x86: Add helpers to execute VMs with private memory
  KVM: selftests: Add get_free_huge_2m_pages
  KVM: selftests: x86: Add selftest for private memory

 arch/x86/kvm/mmu/mmu_internal.h               |   6 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |  15 +-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../kvm/include/x86_64/private_mem.h          |  24 ++
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  58 ++++-
 tools/testing/selftests/kvm/lib/test_util.c   |  29 +++
 .../selftests/kvm/lib/x86_64/private_mem.c    | 139 ++++++++++++
 .../selftests/kvm/x86_64/private_mem_test.c   | 212 ++++++++++++++++++
 virt/kvm/Kconfig                              |   4 +
 virt/kvm/kvm_main.c                           |   3 +-
 13 files changed, 490 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_test.c

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

