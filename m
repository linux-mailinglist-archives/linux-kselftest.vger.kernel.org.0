Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2680358EA92
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHJKmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHJKmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 06:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80D706C754
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660128121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9bKhNJI7G6HPFM7ZC8g4f1RPMl031HWjaKYN/Cgan+A=;
        b=aPCYH67JsBdv9GfUcuvyKc9JLniBAowtMQqE119GQlGvJO/QpQDYRNSSXmf3/Tj7U3ofY+
        HAPiYY/CIRPuv+kmNxS618yXATk8vkX+FPRfwJxNhPEA7osOD8sTMZxFfJ8rBfme112x+H
        5ixUqPMfKfD7ASQMzXeJ60VyVStf7so=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-vNqntwxVNh6f0s2lJnO8VQ-1; Wed, 10 Aug 2022 06:41:58 -0400
X-MC-Unique: vNqntwxVNh6f0s2lJnO8VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91AFC2999B2D;
        Wed, 10 Aug 2022 10:41:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1D304050067;
        Wed, 10 Aug 2022 10:41:52 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, fweimer@redhat.com,
        shan.gavin@gmail.com, maz@kernel.org, andrew.jones@linux.dev,
        mathieu.desnoyers@efficios.com, pbonzini@redhat.com,
        yihyu@redhat.com, seanjc@google.com, oliver.upton@linux.dev
Subject: [PATCH v2 0/2] kvm/selftests: Two rseq_test fixes
Date:   Wed, 10 Aug 2022 18:41:12 +0800
Message-Id: <20220810104114.6838-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are two issues in current rseq_test implementation and the
series intends to fix them:

- From glibc-2.35, rseq information is registered by TLS. It means
  rseq_test is unable to register its own rseq information. PATCH[01]
  fixes the issue by reusing "../rseq/rseq.c" to fetch TLS's rseq
  information if possible.

- sched_getcpu() relies on glibc's implementation and it can simply
  returns the CPU ID cached in the rseq information. In this case,
  it's pointless to compare the return value from sched_getcpu()
  and that fetched from rseq information. PATCH[02] fixes the issue
  by replacing sched_getcpu() with getcpu().

v1: https://lore.kernel.org/lkml/8c1f33b4-a5a1-fcfa-4521-36253ffa22c8@redhat.com/T/

Changelog
=========
v2:
  * Add "-ldl" to LDLIBS as Florian suggested.
  * Reuse "../rseq/rseq.c" as Paolo/Mathieu/Sean suggested.
  * Add comments to sys_getcpu() as Sean suggested.

Gavin Shan (2):
  KVM: selftests: Make rseq compatible with glibc-2.35
  KVM: selftests: Use getcpu() instead of sched_getcpu() in rseq_test

 tools/testing/selftests/kvm/Makefile    |  5 ++-
 tools/testing/selftests/kvm/rseq_test.c | 60 ++++++++++++-------------
 2 files changed, 33 insertions(+), 32 deletions(-)

-- 
2.23.0

