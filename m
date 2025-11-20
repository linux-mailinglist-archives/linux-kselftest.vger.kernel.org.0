Return-Path: <linux-kselftest+bounces-46119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC0C74796
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8589F4F0199
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591533DEEE;
	Thu, 20 Nov 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="t3E7MMtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAB2FE564;
	Thu, 20 Nov 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647556; cv=none; b=XWzcEEvKlMoq8cCIkk3YFMWMvXT9mL26ldvK+DPsBTvTDIt0XTv+QWYaQhxsiWoPdWFPYdgN2LbLLSUC9WVNB6isbXsSxev4SXZNaqhsjuKbpooZAGoEBZ490p7rbT7x3NzwSAZkBVjdBHR2EgZi+iqcUyeMRa22+jP6WcZPxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647556; c=relaxed/simple;
	bh=ixPxvprYxVwl+q6eByiVHJyrgj8W7Bv/FAI2mLcp8ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdnXuqZNbkZCg4fZKsXApaLPuu+k89DhFjONBelLUxzZKPaFJGoa879RC3NXpJwfVwj+oLX4Zuc2DO2lpTvEHsG4w9/a+fkhqsi1LKB6w4jWTP2CAjtd4c18Kr3KZxokUrqIgrqS53Lbz3G/GCxDLsfdV41eTu3sdJtAj3j5leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=t3E7MMtk; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647554; x=1795183554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXmsHzOTgobyrq58vAIqi/B9JB4iFP9AaCH0AN/xjgQ=;
  b=t3E7MMtkLhAwIGfIHBYL/hzevK3XvT5k3UTMnjISVrPZsA/YFfgPA3Ky
   dvhgdugnTTafJypcEOEP7gJazj6pUEAKY/3N5M0+1Q32WTXjgakQ1/p/c
   gGqankNuhcxoHbUHP0VziAe4nfpMV+mdK5GQtG2N8QGsw+BjDuQnr+mj+
   5ZKp0sAyrFLhNl5nugW1K4uKm78HkR8griswzJXj9uPt1jD2MWg7n901q
   8wR9RrLp/ArcgRgnsbEhBKA4hxVT9F+TqPYqCCMCW3Mbgu/syg0Z9oTF9
   k3hTo5Lt3VMXd7syZHmK6hJv97DU12eoXW0RIeqk/WsHTpUMzyhHGksh6
   w==;
X-CSE-ConnectionGUID: 4fBRsVRXQdK+hWPxscOfnQ==
X-CSE-MsgGUID: DN8vPk33QZyh87/qyWBELA==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7250788"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:05:51 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:4241]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.241:2525] with esmtp (Farcaster)
 id 52c7c98f-0056-413d-b56a-df46b1121cd8; Thu, 20 Nov 2025 14:05:51 +0000 (UTC)
X-Farcaster-Flow-ID: 52c7c98f-0056-413d-b56a-df46b1121cd8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:05:50 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:05:48 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 10/13] KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stress
Date: Thu, 20 Nov 2025 15:02:59 +0100
Message-ID: <20251120140305.63515-11-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since GITS_TYPER.PTA == 0, the ITS MAPC command demands a CPU ID,
rather than a physical redistributor address, for its RDbase
command argument.

As such, when MAPC-ing guest ITS collections, vgic_lpi_stress iterates
over CPU IDs in the range [0, nr_cpus), passing them as the RDbase
vcpu_id argument to its_send_mapc_cmd().

However, its_encode_target() in the its_send_mapc_cmd() selftest
handler expects RDbase arguments to have a 16 bit offset, as shown
by the 16-bit target_addr right shift its implementation:

        its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 51, 16)

At the moment, all CPU IDs passed into its_send_mapc_cmd() have no
offset, therefore becoming 0x0 after the bit shift. Thus, when
vgic_its_cmd_handle_mapc() receives the ITS command in vgic-its.c,
it always interprets the RDbase target CPU as CPU 0. All interrupts
sent to collections will be processed by vCPU 0, which defeats the
purpose of this multi-vCPU test.

Fix by creating procnum_to_rdbase() helper function, which left-shifts
the vCPU parameter received by its_send_mapc_cmd 16 bits before passing
it to its_encode_target for encoding.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
This patch has already been merged as a fix in Linux 6.18-rc6 as a24f7af.
---
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
index aec1b69a4de3..7f9fdcf42ae6 100644
--- a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
+++ b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
@@ -15,6 +15,8 @@
 #include "gic_v3.h"
 #include "processor.h"
 
+#define GITS_COLLECTION_TARGET_SHIFT 16
+
 static u64 its_read_u64(unsigned long offset)
 {
 	return readq_relaxed(GITS_BASE_GVA + offset);
@@ -163,6 +165,11 @@ static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
 	its_mask_encode(&cmd->raw_cmd[2], col, 15, 0);
 }
 
+static u64 procnum_to_rdbase(u32 vcpu_id)
+{
+	return vcpu_id << GITS_COLLECTION_TARGET_SHIFT;
+}
+
 #define GITS_CMDQ_POLL_ITERATIONS	0
 
 static void its_send_cmd(void *cmdq_base, struct its_cmd_block *cmd)
@@ -217,7 +224,7 @@ void its_send_mapc_cmd(void *cmdq_base, u32 vcpu_id, u32 collection_id, bool val
 
 	its_encode_cmd(&cmd, GITS_CMD_MAPC);
 	its_encode_collection(&cmd, collection_id);
-	its_encode_target(&cmd, vcpu_id);
+	its_encode_target(&cmd, procnum_to_rdbase(vcpu_id));
 	its_encode_valid(&cmd, valid);
 
 	its_send_cmd(cmdq_base, &cmd);
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


