Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1630599225
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 02:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbiHSA4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 20:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbiHSA4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 20:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197EDF096
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 17:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660870605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0mjtjKvaCKjFD+8hWTDMS94mOG+sVGwcb17W8u/FnUA=;
        b=VFgPfJn5YpXYG24LEh5mlvuWIeLIILB54WPfhqP1Tl+dOYqU33U192yFA+BzpnWnopA40h
        XBhvkFrrP6Sc+/4iKEnsR1PeaOmZ/f1engJzHGqnWeyBKDlT6/4RmkPJiAfaupdbcwaVsT
        MRTKDsI4DYHMnbqAnfdUVeNDEAZ4Y+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317--evnGzXCP_CdJVefZLfQyg-1; Thu, 18 Aug 2022 20:56:42 -0400
X-MC-Unique: -evnGzXCP_CdJVefZLfQyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D370802D2C;
        Fri, 19 Aug 2022 00:56:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51086C15BB8;
        Fri, 19 Aug 2022 00:56:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peterx@redhat.com,
        pbonzini@redhat.com, corbet@lwn.net, maz@kernel.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v1 0/5] KVM: arm64: Enable ring-based dirty memory tracking
Date:   Fri, 19 Aug 2022 08:55:56 +0800
Message-Id: <20220819005601.198436-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series enables the ring-based dirty memory tracking for ARM64. 
The feature has been available and enabled on x86 for a while. It
is beneficial when the number of dirty pages is small in a checkpointing
system or live migration scenario. More details can be found from
fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking").

The generic part has been comprehensive enough, meaning there isn't too
much work, needed to extend it to ARM64. 

- PATCH[1]   enables the feature on ARM64
- PATCH[2-5] improves kvm/selftests/dirty_log_test

Testing
=======

- kvm/selftests/dirty_log_test
- Live migration by QEMU
- Host with 4KB or 64KB base page size

Gavin Shan (5):
  KVM: arm64: Enable ring-based dirty memory tracking
  KVM: selftests: Use host page size to map ring buffer in
    dirty_log_test
  KVM: selftests: Dirty host pages in dirty_log_test
  KVM: selftests: Clear dirty ring states between two modes in
    dirty_log_test
  KVM: selftests: Automate choosing dirty ring size in dirty_log_test

 Documentation/virt/kvm/api.rst               |   2 +-
 arch/arm64/include/uapi/asm/kvm.h            |   1 +
 arch/arm64/kvm/Kconfig                       |   1 +
 arch/arm64/kvm/arm.c                         |   8 ++
 tools/testing/selftests/kvm/dirty_log_test.c | 101 ++++++++++++++-----
 tools/testing/selftests/kvm/lib/kvm_util.c   |   2 +-
 6 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.23.0

