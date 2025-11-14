Return-Path: <linux-kselftest+bounces-45646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF9C5DA49
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06953A56F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518031A54F;
	Fri, 14 Nov 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="q73BjU05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA421D90AD;
	Fri, 14 Nov 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131157; cv=none; b=AqB6EnToIDncJ8W1b+H5o0QVSxNi7LQL3y1+PECFalbNKzCFb9E6SJCX7rweeIoww3jL3sFyyrxjCwZodW925POUIf4vXo7mifqC7IfeDGp9BH5k7JEZ87W+QMMDUuCTPp9f2d3ZodWSRRGUfQitsPe5b03EtC1GDmEleNEKC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131157; c=relaxed/simple;
	bh=NGFFU+LKpCz9295CO6ZOvL2+UNvHNkjvPJl3mMW4TF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmreyV/0UttddXP9qMdV/X3nzuKnMCPKAW0efh7wMjjT2TJWul2siMskAbqFLtxoR7gyIdc6pwt8VWfiDeh9uKyT3RxDyx1eeDVSlDwmHcEwHZzg0DnW9miAJ2wVT53rl4GxGpiVyMMtAkmcm1SHpOPXZl/R/FITVN8jeKdtqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=q73BjU05; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763131155; x=1794667155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tuugdbs4qPrYJbDgPmXQJ06XmUfS38Y/AWsXOl8uN2E=;
  b=q73BjU05PE7oFnpkPPHtk/njk15Q6DlnUWPIW+SovLHJHH/JSUlrS113
   /q2sOOhuPW7a0+mY3RI4D34gAOFa6ckezIZhwcWwsMEtcb4qN2BcmAAyI
   hHC5+3BxMjml6rpIapQaQAKkk60QmMlWyaWTPpm4haxFqB3vB10KZIJRi
   9pMQNmWnhINtuyQ4XC9HycLnbAgU25EorSfq7rWeF1HtxgX0GEiIvv5ar
   PsX0GkfzUlKeII8B8cfD3WeiIiq1WpTLXJZqCkha8wKK0hIVaD8Svxt1a
   NKR8ZBN5ZcE30RE9Pe/Y62gwPDn5UnEgQqVDwUAXRUBIt7Pui/5O4vsmk
   A==;
X-CSE-ConnectionGUID: o5a+tyeIR5G2RJUtFkkssQ==
X-CSE-MsgGUID: YR9i1iJSQ9qI4StgXjCJZw==
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="7112465"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 14:39:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:4363]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.84:2525] with esmtp (Farcaster)
 id f4ae6c68-9432-4b5a-b747-c7b52eb56619; Fri, 14 Nov 2025 14:39:12 +0000 (UTC)
X-Farcaster-Flow-ID: f4ae6c68-9432-4b5a-b747-c7b52eb56619
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 14:39:12 +0000
Received: from amazon.com (10.1.212.32) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 14 Nov 2025
 14:39:09 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <nh-open-source@amazon.com>
Subject: [PATCH] KVM: selftests: Add SYNC after guest ITS setup in vgic_lpi_stress
Date: Fri, 14 Nov 2025 15:39:02 +0100
Message-ID: <20251114143902.30435-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

vgic_lpi_stress sends MAPTI and MAPC commands during guest GIC
setup to map interrupt events to ITT entries and collection IDs
to redistributors, respectively.

Theoretically, we have no guarantee that the ITS will
finish handling these mapping commands before the selftest
calls KVM_SIGNAL_MSI to inject LPIs to the guest. If LPIs
are injected before ITS mapping completes, the ITS cannot
properly pass the interrupt on to the redistributor.

In practice, KVM processes ITS commands synchronously, so
SYNC calls are functionally unnecessary and ignored in
vgic_its_handle_command().

However, selftests should test based on ARM specification and
be blind to KVM-specific implementation optimizations. Thus,
we must update the test to be architecturally compliant and
logically correct.

Fix by adding a SYNC command to the selftests ITS library,
then calling SYNC after ITS mapping to ensure mapping
completes before signal_lpi() writes to GITS_TRANSLATER.

This patch depends on commit a24f7afce048 ("KVM: selftests:
fix MAPC RDbase target formatting in vgic_lpi_stress"), which
is queued in kvmarm/fixes.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
Validated by the following debug logging to the GITS_CMD_SYNC handler
in vgic_its_handle_command():

        kvm_info("ITS SYNC command: %016llx %016llx %016llx %016llx\n",
            its_cmd[0], its_cmd[1], its_cmd[2], its_cmd[3]);

Initialized a selftest guest with 4 vCPUs by:

        ./vgic_lpi_stress -v 4

Confirmed that an ITS SYNC was successfully called for all 4 vCPUs:

        kvm [5094]: ITS SYNC command: 0000000000000005 0000000000000000 0000000000000000 0000000000000000
        kvm [5094]: ITS SYNC command: 0000000000000005 0000000000000000 0000000000010000 0000000000000000
        kvm [5094]: ITS SYNC command: 0000000000000005 0000000000000000 0000000000020000 0000000000000000
        kvm [5094]: ITS SYNC command: 0000000000000005 0000000000000000 0000000000030000 0000000000000000
---
 tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c   |  4 ++++
 .../testing/selftests/kvm/include/arm64/gic_v3_its.h  |  1 +
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c    | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
index 687d04463983..e857a605f577 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
@@ -118,6 +118,10 @@ static void guest_setup_gic(void)
 
 	guest_setup_its_mappings();
 	guest_invalidate_all_rdists();
+
+	/* SYNC to ensure ITS setup is complete */
+	for (cpuid = 0; cpuid < test_data.nr_cpus; cpuid++)
+		its_send_sync_cmd(test_data.cmdq_base_va, cpuid);
 }
 
 static void guest_code(size_t nr_lpis)
diff --git a/tools/testing/selftests/kvm/include/arm64/gic_v3_its.h b/tools/testing/selftests/kvm/include/arm64/gic_v3_its.h
index 3722ed9c8f96..58feef3eb386 100644
--- a/tools/testing/selftests/kvm/include/arm64/gic_v3_its.h
+++ b/tools/testing/selftests/kvm/include/arm64/gic_v3_its.h
@@ -15,5 +15,6 @@ void its_send_mapc_cmd(void *cmdq_base, u32 vcpu_id, u32 collection_id, bool val
 void its_send_mapti_cmd(void *cmdq_base, u32 device_id, u32 event_id,
 			u32 collection_id, u32 intid);
 void its_send_invall_cmd(void *cmdq_base, u32 collection_id);
+void its_send_sync_cmd(void *cmdq_base, u32 vcpu_id);
 
 #endif // __SELFTESTS_GIC_V3_ITS_H__
diff --git a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
index 0e2f8ed90f30..d9ee331074ea 100644
--- a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
+++ b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
@@ -253,3 +253,14 @@ void its_send_invall_cmd(void *cmdq_base, u32 collection_id)
 
 	its_send_cmd(cmdq_base, &cmd);
 }
+
+void its_send_sync_cmd(void *cmdq_base, u32 vcpu_id)
+{
+	struct its_cmd_block cmd = {};
+
+	its_encode_cmd(&cmd, GITS_CMD_SYNC);
+	its_encode_target(&cmd, procnum_to_rdbase(vcpu_id));
+
+	its_send_cmd(cmdq_base, &cmd);
+}
+
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


