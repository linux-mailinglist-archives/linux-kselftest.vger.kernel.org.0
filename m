Return-Path: <linux-kselftest+bounces-45986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EAC6F32B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF4134FC6DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533E3612C0;
	Wed, 19 Nov 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jQUJJv3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFE35B142;
	Wed, 19 Nov 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560682; cv=none; b=P318XLg/4JaRgeS+Ip7GApf6oP+qQMJoFwFT+/lDojDlPWtmgCdavGtHkm6c/xkiQwq9yuyXxfYMUaixSBg49O8acCWvdIL/vG2he2nQ/FLbgEZMgGAdaxgpWgtVJoPzRTtHBVoyrgoSIxJ7HXZxx7kR4Eu+1Q/qzSebyvWGqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560682; c=relaxed/simple;
	bh=GHawNvWn/phGBxI62trqHe8t0fQ64barPr1ny8Ci9xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU1qxb+BqIr7XQCivcETkX5fMp6tCxmaPDCGWZnErXQjqV+6KxmS2skKCKNpgn5e3RhDJ49G/j+uCZaTi5Tduojq6ggfVfVXJhWTOLtrkwLrSBzYl0NYQi4L0GhAuHWRK/yhQs+HmZ9PHmi1hC1oYyRikDXLUKaP0g1EzmVzl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jQUJJv3N; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763560680; x=1795096680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lzpnv0u1m2nCELjHbHbtPbxJSZ+ELcyCY03eyueq0jc=;
  b=jQUJJv3NsvzTuZPpJRSFKPzIW+o4ai2BRg2LfZd3cpuL+57XrgvGTeQk
   iD3/s3YkwHNdyozPaauY2xa+kvDNlSw06wTHCgpZPuUuLYBWDZ17Sb0j3
   6uIZW3V/vi4PmSGOoj5I9F3XVmfOGH9w3tfA3TZK7vel3z2s5tla3ANda
   aEd1NoAXybeC+il1B+zTHPqtrBrbZON6W/s25fgFTlAECr6SOhDs3GKk8
   DTW+Zy1DHZzE6mjkwFTnS+jZvYLd3DvFetiWPZh4dkYcExAep2OGyYAmV
   l4SUusPe3wA7Ptn7ifDjbeaEgPcwJ9Iq/QLmvngVBBCREiu67bKMr9C5n
   g==;
X-CSE-ConnectionGUID: H7eTEbVIRnaLQvIxNFiMiQ==
X-CSE-MsgGUID: fvcmET55SiKDpntLhtopdQ==
X-IronPort-AV: E=Sophos;i="6.19,315,1754956800"; 
   d="scan'208";a="7361146"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:57:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:21699]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.156:2525] with esmtp (Farcaster)
 id 70adb8ed-f7ea-4134-8909-59c27b0a6c34; Wed, 19 Nov 2025 13:57:57 +0000 (UTC)
X-Farcaster-Flow-ID: 70adb8ed-f7ea-4134-8909-59c27b0a6c34
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 19 Nov 2025 13:57:57 +0000
Received: from amazon.com (10.1.212.27) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 19 Nov 2025
 13:57:54 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <nh-open-source@amazon.com>
Subject: [PATCH v2 2/2] KVM: selftests: SYNC after guest ITS setup in vgic_lpi_stress
Date: Wed, 19 Nov 2025 14:57:44 +0100
Message-ID: <20251119135744.68552-2-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119135744.68552-1-mdittgen@amazon.de>
References: <20251114143902.30435-1-mdittgen@amazon.de>
 <20251119135744.68552-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

vgic_lpi_stress sends MAPTI and MAPC commands during guest GIC setup to
map interrupt events to ITT entries and collection IDs to
redistributors, respectively.

We have no guarantee that the ITS will finish handling these mapping
commands before the selftest calls KVM_SIGNAL_MSI to inject LPIs to the
guest. If LPIs are injected before ITS mapping completes, the ITS cannot
properly pass the interrupt on to the redistributor.

Fix by adding a SYNC command to the selftests ITS library, then calling
SYNC after ITS mapping to ensure mapping completes before signal_lpi()
writes to GITS_TRANSLATER.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
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


