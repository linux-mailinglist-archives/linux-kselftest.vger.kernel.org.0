Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C78654913
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLVXFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 18:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLVXFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 18:05:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185ED27178
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v17-20020a17090abb9100b002239a73bc6eso3870864pjr.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHWaMPgNH1Gc3dyUgtUp96T2Ds+DtSztVEOEp9eXXLE=;
        b=J1m6H/8q08TJDo6V440ml0vH1FPML4rBgC8Z8KKPyy9b9/w8p2/vuVbFAcP5/BIAJ4
         8g2gBZHdZ0kkBZpuRDrDBf6PK5MKrygPfkntIl+QYO7R3SsdNqtM7zMJJFD+QQT7Vf3O
         cZzYsjv9ugcbYt1JdD/7UhuGjKi2sO0roV3kbzu1WamewDTwrz4UtKcNrevBr7fZqtH/
         NFIWVwfuajUEi3u4L8ZDM7NCHNFAgx1b6x/mJ97l9sH5BMg4X0cRKjU9Mb8VFKkwMYvx
         lpO9dvk7LHv4xWvbOnlwithG5+PhG/ySqI8EUDrlzxI313a5QmjtI0xcWfwjMLYPijgz
         TS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHWaMPgNH1Gc3dyUgtUp96T2Ds+DtSztVEOEp9eXXLE=;
        b=LzBWxXJhRvtTAauHzHdxyjEDVc4AnZDbrlfTyLQDJAC/DAw58EJIdPx4vBEKDS1UoN
         A5yx1J8/f/r9qURCP3gauadt7OcnJ6QZQwGvfOTMb6DCR9jKDLLrOjSiPNVtcdFVvYZ8
         iKoPJCuXCbDExwpTXcgj5Mcmrw8CDs/4BAt/MihgwmOfUeX1RXGBAcHZnGw6fVgIp17E
         ICP5RkLchUJfNO1j4THrohy/fNV+5ynycD53Ta8y2qhS5Uy8EUJl6HPwgc13pWXhFjpL
         WtO/gPMzW3AF34Nzc7urDmteWQHrguxwywBHU59ELNM8LXytYXy9R5m7Xou69Wepa6L1
         aJDA==
X-Gm-Message-State: AFqh2kr9EdXQKKx97tcmQ0nqZV5eut0P1wVK0iIHlP9cLv3vSg2bGDep
        zUU5cEsExcIpC/L8+AffPtgXThhShkUCWGSS
X-Google-Smtp-Source: AMrXdXvwYXr/36+Tv89Q0SjDNBpV9g/udTWdh/80BGWKMaCWt/H1422BELxbkBKJEg7hprGc87A0aX+OAgBKgpj6
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:d350:b0:223:fa07:7bfb with SMTP
 id i16-20020a17090ad35000b00223fa077bfbmr675609pjx.38.1671750306569; Thu, 22
 Dec 2022 15:05:06 -0800 (PST)
Date:   Thu, 22 Dec 2022 23:04:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222230458.3828342-1-vannapurve@google.com>
Subject: [V3 PATCH 0/2] Execute hypercalls from guests according to cpu
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
not allowed with CVMs.

This series adds support of executing hypercall as per the native cpu
type queried using cpuid instruction. CPU vendor type is stored after
one time execution of cpuid instruction to be reused later.

Changes in v3:
1) Guest logic is modified to not rely on host cpu type and instead query
cpu vendor using cpuid instruction.
2) Existing callers of vmmcall/vmcall are not updated to avoid enforcing
native hypercall instruction across all users which are mostly
non-confidential usecases.

v2:
https://lore.kernel.org/all/20220915000448.1674802-1-vannapurve@google.com/

More discussion around this change:
https://lore.kernel.org/lkml/Y1Hhw40H58EmZ6lK@google.com/

Vishal Annapurve (2):
  KVM: selftests: x86: Cache the cpu vendor type
  KVM: selftests: x86: Add native hypercall support

 .../selftests/kvm/include/x86_64/processor.h  |  3 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 51 +++++++++++++++++--
 2 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

