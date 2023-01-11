Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C751665078
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 01:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjAKApH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 19:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjAKApD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 19:45:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06459500
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e12-20020a25500c000000b007b48c520262so14566682ybb.14
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibE48hPASiaydGO50HigqaPix7Fk3GewkWKsH3rEx8o=;
        b=QDMREWCkJW7xwXSdwyB+jy0Hy0ipF0VIiK4k8kJDtxq6zgowXQk/i6IjWKL6ha9eeM
         DWfA0Ozh3fxTNwO7PyKRchI1VCSMDQdUvbY3qk0Jd/SHc7YhFQyiQtTy8hJ8kKpU9fbk
         UEzGzch7+uPo/8/Yog51+NlZbO1J9sat3igfRISSaIPPwbu7pWEkTQyxfuSFV19nuyKW
         xOqVLLufpTspm/t+e5Fy4BQT7ZKxN1KNLwlJJHqDkSwgxj4ItZne6csXl3BPvnFZYQM1
         PmAnTJSQ3TuvKqJ9fY8Sxe6KusmVjjUWnDOAQ+BHaN6uX/zpdE+Yg6Sq8/8NmNW9jj/K
         MEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibE48hPASiaydGO50HigqaPix7Fk3GewkWKsH3rEx8o=;
        b=my5iu6UunrhiSQ3ssAkzUNsf+8pgIkLG79oxP3K13WQCt6zLvKBkeCooUM0kGYyqew
         0jPXl56ZUbg+LyVevO08wiRyhqBHhHWr+tyeGfwTtKXZnM1XcZSPeVtp+6Vm38sKm/1P
         va9cTBjVibBFyHv+YgGl5hAvIgRoZwqbYVNC2H31/ehkMuOPdXmd+EfZHPHksMZA4jNr
         QvaxHvXWiyBgsX95rVL8FUzrmVGy8Q2fSyYf/AOTVmO9QUMHZR6bbxlaC9dTLIIHgiMr
         XFIzQyPfRXhUyPBbF3jhA0rSrta2dGA+VIHF3Kcsar9/OktoWyPuVslSk3YE2zz70zER
         4Ecw==
X-Gm-Message-State: AFqh2kqr9BUL1P8Aw6jrvSqK62rhs29o03YO2Bppmo52Zo4wJwkUShpe
        C36tfQE7wxyO5O5ExgjuS10RGlAs/tBKbxRE
X-Google-Smtp-Source: AMrXdXsSWutbgAi4jSr0wcTRqmMwOHcHIKu9/EpTRTxKn638IGsKrxJvP5/oz8IgdsFvpXMqpI/YvB5GJKR2OFQM
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a25:2e0e:0:b0:7bf:e2b8:af73 with SMTP
 id u14-20020a252e0e000000b007bfe2b8af73mr805623ybu.98.1673397901764; Tue, 10
 Jan 2023 16:45:01 -0800 (PST)
Date:   Wed, 11 Jan 2023 00:44:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111004445.416840-1-vannapurve@google.com>
Subject: [V5 PATCH 0/3] Execute hypercalls according to host cpu
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
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

Confidential VMs(CVMs) need to execute hypercall instruction as per the CPU
type. Normally KVM emulates the vmcall/vmmcall instruction by patching
the guest code at runtime. Such a guest memory manipulation by KVM is
not allowed with CVMs and is also undesirable in general.

This series adds support of executing hypercall as per the host cpu vendor.
CPU vendor is queried early during selftest setup and guest setup to be
reused later.

Changes in v5:
1) Incorporated suggestions from Sean -
  * Rename the APIs to have "this_cpu*" prefix to better convey the
    intent of callers to query cpu vendor of the current cpu
  * Squash patches together to cache, share cpu vendor type and replace
    current callers of "this_cpu*" with checking the saved host cpu vendor
    in a single patch.

Changes in v4:
1) Incoporated suggestions from Sean -
  * Added APIs to query host cpu type
  * Shared the host cpu type with guests to avoid querying the cpu type
    again
  * Modified kvm_hypercall to execute vmcall/vmmcall according to host
    cpu type.
2) Dropped the separate API for kvm_hypercall.

v4:
https://lore.kernel.org/lkml/20221228192438.2835203-1-vannapurve@google.com/

Vishal Annapurve (3):
  KVM: selftests: x86: Use "this_cpu" prefix for cpu vendor queries
  KVM: selftests: x86: Cache host CPU vendor (AMD vs. Intel)
  KVM: selftests: x86: Use host's native hypercall instruction in
    kvm_hypercall()

 .../selftests/kvm/include/x86_64/processor.h  | 28 +++++++++--
 .../selftests/kvm/lib/x86_64/processor.c      | 46 ++++++++-----------
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  4 +-
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  2 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |  4 +-
 .../vmx_exception_with_invalid_guest_state.c  |  2 +-
 6 files changed, 51 insertions(+), 35 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

