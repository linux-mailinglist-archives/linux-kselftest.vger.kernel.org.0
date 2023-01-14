Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127666AC88
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jan 2023 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjANQQM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Jan 2023 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjANQQL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Jan 2023 11:16:11 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DE83D5
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Jan 2023 08:16:04 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p14-20020a170902e74e00b00192f6d0600eso16892612plf.3
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Jan 2023 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ddF4ManzZhqa5SXP5hluB+g3L8XUAVj+gr84Ax3pZFc=;
        b=p+bmH68o/76Ql/dmrbbofvKKxaKG5NUkBJh8IgLrVhzMf96WZsDP2U/DiYrf3+kyOU
         x4sqm/i+HBW9aiM1sGjDoC2MZxp42wKSk0xHCWDc6t4DbPuwUXodrlKp5FycP/Hx7AIB
         zKD5UfMukeFvBaYLOWdS6EIoJUdF8wBh7M92E/g8GvR3pADQyTrGjWcabPjQXrjWkuUN
         aq+R1kzTU0jfsdX14yh+6RYtDFXIYmJr4BRjgnC5dxrjka5937jWGwI1Pgrq5agslTbn
         kARXAeCXj+XuadQhzOLfl5MZBBKEWKFmHRJyuZ8TBNxtm3IDh6SPHv/Xj9WisZQ+IE+G
         1fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddF4ManzZhqa5SXP5hluB+g3L8XUAVj+gr84Ax3pZFc=;
        b=v1Bm4NyKEwQ4ZG5Go2CESAjNPCOrB3G/HlHghS/UiuoCcicRL/2/azQhvqmV9l4Jvw
         ZuuOdCTCDd4vnIlfWK8AQnozU/5Zc+RrwVfi98zG/Ra/Y8160/OP/HblaJU6KDGcjrm+
         jCUgpmfpEHDh+fRAJjSj02ggazGMRgi3mPDxWJbgvWG3FQyBUY8j1h2aezZmKiVg1E4U
         PnSZnXaDbXj4c66jQIbysuaeY/KxEuS0ldgBsSTqETrJYyNvRmq0uWqIaLgw3rpN83Lc
         Crp3qNlCEuJuOqOetGDUC7wGihJTsPz9hUOX59QZBbrsW9/mNpwcHLt3s1Qr/6KJ9BL5
         jvcA==
X-Gm-Message-State: AFqh2koNUm2GhR+7lCDILdQgOW4btv1AtwSRCc2yHwHTxeHKI/Pvibhk
        XstaUwsBOVye5IQuvG5TMVp9mQroNw5PGFZnxQ==
X-Google-Smtp-Source: AMrXdXt7KMCGUZ85pcsMjWqjEdVWaMat+Qb9InGkgYa79/eD2LR6U7nua3XHqx6AzqtHWcO3Cqk65U7ml8hrr34W0w==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:7444:b0:18c:1bc5:ab84 with
 SMTP id e4-20020a170902744400b0018c1bc5ab84mr262748plt.105.1673712964124;
 Sat, 14 Jan 2023 08:16:04 -0800 (PST)
Date:   Sat, 14 Jan 2023 16:15:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230114161557.499685-1-ackerleytng@google.com>
Subject: [PATCH 0/2] Fix kvm_setup_gdt and reuse in vcpu_init_descriptor_tables
From:   Ackerley Tng <ackerleytng@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Wei Wang <wei.w.wang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove discrepancy between kvm_setup_gdt and vcpu_init_descriptor_tables
by fixing initialization of limit in kvm_setup_gdt and reusing
kvm_setup_gdt in vcpu_init_descriptor_tables.

Ackerley Tng (2):
  KVM: selftests: Fix initialization of GDT limit
  KVM: selftests: Reuse kvm_setup_gdt in vcpu_init_descriptor_tables

 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--
2.39.0.314.g84b9a713c41-goog
