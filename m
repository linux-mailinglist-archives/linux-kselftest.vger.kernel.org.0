Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353665499B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLWAN5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLWAN4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:13:56 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B053264BE
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:13:56 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso1726562pjb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GPSysGAZa55nuUkb2Ih+MCRLyMCYc0jfLWIStqar/Ew=;
        b=Q2fp2fViZYQmjABDbOlNm+s4gHb7QMx+a9N99tHJpeKoNus7beuKwA84TUJdATLbdG
         sq3uqywv7wl+E2hEsT77xyG3MM+ZjxMrWEls3jNvyoGMZoQrN3nhsk1y8GLKDLimki0a
         e3P+Jj0S6ijxEsAZ6P79qLcJoe9hN23jbdCiPY6qMe7NvoqbaaiaFK7YWTmFs8NItvSp
         vlXJ1QhtlP8iPcA3XKnpmVGytYowLIxnHf5d931eFQd7XCESJdUV9yQdwZJoWVL+mnAZ
         mv/VB4rCVS5MqMSC15EKTPI0ivkamF6RXmuJ423+pW7pdf62IC1lGxOkdjdp2WsTr9bk
         IJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPSysGAZa55nuUkb2Ih+MCRLyMCYc0jfLWIStqar/Ew=;
        b=XuW+h2/CP7FEJD+QGkGRt+SXCAOrw+dFC0bNe/RlN8Ja1W/sVJOOFyTnmL8j5qR6Rh
         rUR0Tn4wTQgRwtuIdDxfMjkRQazeyFKFvq5eBa9KVXTbD90mPFrkEG3mix0PENZw9jn4
         lrquTw8QyItauPe9ZlmZ0KoMbiQaixGErjY4cahaDlk/NyzlNTqMr1XAoDvmLPdfW2JA
         yZ06Pl7gsWJ3yRUAoxlbFTmTjeDmNpToyIIAxF8PaMyqqIJUW5ZWz46YUdEdYTPqD+7x
         MSEO4rwvKDVoS3liKra83LM/Dg8pK/MFEy65hJO8GX1D0PFyC19V6g/Z/LaZf2mzqFW4
         C8fg==
X-Gm-Message-State: AFqh2kopbU4tw/L/k1IbKTxByRPQnfCFwyjqZYP6mT+DcMqSARRCvpTv
        4/rjmZJliYI7hOmzt7ohyGItWVUMdk/iCCdw
X-Google-Smtp-Source: AMrXdXvKB4/hjodXCCmAf88j534jf/MqKWZgd91wpCO6eXU20E9ur8obGtj0TYzGdpYu2fh7hDZKmWl8JHbo5vsQ
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:8081:0:b0:56d:2e71:449 with SMTP id
 v1-20020aa78081000000b0056d2e710449mr491383pff.46.1671754435394; Thu, 22 Dec
 2022 16:13:55 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-1-vannapurve@google.com>
Subject: [V3 PATCH 0/8] KVM: selftests: SEV: selftests for fd-based private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series implements selftests executing SEV VMs to target the feature
implemented by Chao via:
https://lore.kernel.org/lkml/20221220074318.GC1724933@chaop.bj.intel.com/T/

Below changes aim to test the fd based approach for guest private memory
in context of SEV VMs executing on AMD SEV compatible platforms.

sev_private_mem_test.c file adds selftest to access private memory from
the guest via private/shared accesses and checking if the contents can be
leaked to/accessed by vmm via shared memory view before/after
conversions.

To allow SEV/SEV-ES VMs to toggle the encryption bit during memory
conversion, support is added for mapping guest pagetables to guest va
ranges and passing the mapping information to guests via shared pages.

Updates in v3:
1) Dropped RFC tag.
2) Pagetable mapping logic is revisited to reduce the APIs and passing
the information to guest is simplified.
3) Additional changes to execute hypercall as per cpu type are added
4) Selftest implementation is based on revised non-confidential VM
selftests.

Link to RFC v2:
https://lore.kernel.org/lkml/20220830224259.412342-8-vannapurve@google.com/T/

This series has dependency on following patch series:
1) Series mentioned above from Chao
2) Selftests testing fd based memory for non-confidential VMs:
https://lore.kernel.org/lkml/20221205232341.4131240-5-vannapurve@google.com/T/
3) Selftests to add SEV VM creation and execution from Peter and Michael:
https://lore.kernel.org/lkml/20221018205845.770121-3-pgonda@google.com/T/
4) Series to execute hypercall natively:
https://lore.kernel.org/lkml/20221222230458.3828342-1-vannapurve@google.com/

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/sev_upm_selftests_rfc_v3

Vishal Annapurve (8):
  KVM: selftests: private_mem: Use native hypercall
  KVM: selftests: Support mapping pagetables to guest virtual memory
  KVM: selftests: x86: Support changing gpa encryption masks
  KVM: selftests: Split SEV VM creation logic
  KVM: selftests: Enable pagetable mapping for SEV VMs
  KVM: selftests: Refactor private_mem_test
  KVM: selftests: private_mem_test: Add support for SEV VMs
  KVM: selftests: Add private mem test for SEV VMs

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |  88 +++++++
 .../include/x86_64/private_mem_test_helper.h  |  18 ++
 .../selftests/kvm/include/x86_64/processor.h  |   4 +
 .../selftests/kvm/include/x86_64/sev.h        |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  88 ++++++-
 .../selftests/kvm/lib/x86_64/private_mem.c    |   2 +-
 .../kvm/lib/x86_64/private_mem_test_helper.c  | 228 ++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      |  80 ++++++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  |  25 +-
 .../selftests/kvm/x86_64/private_mem_test.c   | 187 +-------------
 .../kvm/x86_64/sev_private_mem_test.c         |  26 ++
 13 files changed, 562 insertions(+), 191 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c

-- 
2.39.0.314.g84b9a713c41-goog

