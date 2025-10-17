Return-Path: <linux-kselftest+bounces-43393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C0BEAA49
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE88035F037
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1162836A4;
	Fri, 17 Oct 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="GDvHiytV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20323536B;
	Fri, 17 Oct 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718003; cv=none; b=u4zq1yPewQAyys5Eb6rh/1ZqqScfiXzpnbt9trgT4G7u8aJfJQH4hLBlIiJ6n+rOX2y2yC0ZIthhmId1CZlb/EKQIhgko/G5zT6T5xFxz2Zh79itFXVl6EcRvxzJPpWtC1e32jWvz0Ht2AlFM3wJol8+tBhar5U4u4vWqnXDkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718003; c=relaxed/simple;
	bh=/SgEYq5zZ6091CkGidwkN4U+TaXlaYnsAjqJEsJKnQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4C5ns04PI2LHPNfFoYUi9Rj8Bvcv3MOBlmBUJquDT+gvWDQB6wRyieErDppYCOygjQAUkpRxW+SMCgMO1Hd5Jx+/iJ0bjG8/NPghaUGG3zWMXdOFEX2mk7Z60fa0W95ks7Uo8QSKNbWcSX8Ffh0bil0Jw570degoQ9yKuGZW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=GDvHiytV; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1760718001; x=1792254001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D2nJT0TPpGHrtCf3T2K40DMg+dwtxR+G/m4g1KLFCNo=;
  b=GDvHiytVXINQz59/zDIdOdYdSwXPMBcvb4GPRyp7oBJSFgqOa0FR9x37
   5hgaxFkSbqDjWMku/yTsgGkb8I4bzvsAV7nQKK7GtMHbcOE1igdWMxtPZ
   Zu0AZdW0TAYUJSjahMNKX8vLnb7NW5vNLZPHO17WE0ioxDF3yjri5phat
   G2zn3s+qjPTbvL698n6UPPSef/EfldRkJPwW44cUt0tD1DNYLjLRutA1N
   TMPPv1eik0UtVLOCyLsUvxMAA8QwS7fnpFEuPT1m4F0hrSWIQvGwouB5I
   iBqhhZUAeZU/hlNPoKGTkQJPpzvhtwccIHj0mwbBfziZaH2rMOze9sR6f
   A==;
X-CSE-ConnectionGUID: dnjg3YGdSkepofo0QlGplw==
X-CSE-MsgGUID: /EwhAQ4yRa6TpPU6AkX5EA==
X-IronPort-AV: E=Sophos;i="6.19,236,1754956800"; 
   d="scan'208";a="3779950"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 16:19:50 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:21471]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.241:2525] with esmtp (Farcaster)
 id 580d473a-31d3-407f-bbb8-194dd70ae947; Fri, 17 Oct 2025 16:19:50 +0000 (UTC)
X-Farcaster-Flow-ID: 580d473a-31d3-407f-bbb8-194dd70ae947
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 17 Oct 2025 16:19:40 +0000
Received: from amazon.com (10.1.212.14) by EX19D016EUA001.ant.amazon.com
 (10.252.50.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 17 Oct 2025
 16:19:35 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <epetron@amazon.de>, <nh-open-source@amazon.com>,
	Maximilian Dittgen <mdittgen@amazon.com>
Subject: [PATCH] KVM: selftests: fix ITS collection target addresses in vgic_lpi_stress
Date: Fri, 17 Oct 2025 18:19:18 +0200
Message-ID: <20251017161918.40711-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D016EUA001.ant.amazon.com (10.252.50.245)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When mapping guest ITS collections, vgic_lpi_stress iterates over
integers in the range [0, nr_cpus), passing them as the target_addr
parameter to its_send_mapc_cmd(). These integers correspond to the
selftest userspace vCPU IDs that we intend to map each ITS collection
to.

However, its_encode_target() within its_send_mapc_cmd() expects a
vCPU's redistributor address--not the vCPU ID--as the target_addr
parameter. This is evident from how its_encode_target() encodes the
target_addr parameter as:

        its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 51, 16)

This shows that we right-shift the input target_addr parameter by 16
bits before encoding it. This makes sense when the parameter refers to
redistributor addresses (e.g., 0x20000, 0x30000) but not vCPU IDs
(e.g., 0x2, 0x3).

The current impact of passing vCPU IDs to its_send_mapc_cmd() is that
all vCPU IDs become 0x0 after the bit shift. Thus, when
vgic_its_cmd_handle_mapc() receives the ITS command in vgic-its.c, it
always interprets the collection's target_vcpu as 0. All interrupts
sent to collections will be processed by vCPU 0, which defeats the
purpose of this multi-vCPU test.

Fix by left-shifting the vCPU parameter received by its_send_mapc_cmd
16 bits before passing it into its_encode_target for encoding.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
To validate the patch, I added the following debug code at the top of vgic_its_cmd_handle_mapc:

	u64 raw_cmd2 = le64_to_cpu(its_cmd[2]);
	u32 target_addr = its_cmd_get_target_addr(its_cmd);

	kvm_info("MAPC: coll_id=%d, raw_cmd[2]=0x%llx, parsed_target=%u\n", 
		coll_id, raw_cmd2, target_addr);
	vcpu = kvm_get_vcpu_by_id(kvm, its_cmd_get_target_addr(its_cmd));
	kvm_info("MAPC: coll_id=%d, vcpu_id=%d\n", coll_id, vcpu ? vcpu->vcpu_id : -1);

I then ran `./vgic_lpi_stress -v 3` to trigger the stress selftest with 3 vCPUs.

Before the patch, the debug logs read:
kvm [20832]: MAPC: coll_id=0, raw_cmd[2]=0x8000000000000000, parsed_target=0
kvm [20832]: MAPC: coll_id=0, vcpu_id=0
kvm [20832]: MAPC: coll_id=1, raw_cmd[2]=0x8000000000000001, parsed_target=0
kvm [20832]: MAPC: coll_id=1, vcpu_id=0
kvm [20832]: MAPC: coll_id=2, raw_cmd[2]=0x8000000000000002, parsed_target=0
kvm [20832]: MAPC: coll_id=2, vcpu_id=0

Note the last bit of the cmd string reflects the collection ID, but the rest of the cmd string reads 0. The handler parses out vCPU 0 for all 3 mapc calls.

After the patch, the debug logs read:
kvm [20019]: MAPC: coll_id=0, raw_cmd[2]=0x8000000000000000, parsed_target=0
kvm [20019]: MAPC: coll_id=0, vcpu_id=0
kvm [20019]: MAPC: coll_id=1, raw_cmd[2]=0x8000000000010001, parsed_target=1
kvm [20019]: MAPC: coll_id=1, vcpu_id=1
kvm [20019]: MAPC: coll_id=2, raw_cmd[2]=0x8000000000020002, parsed_target=2
kvm [20019]: MAPC: coll_id=2, vcpu_id=2

Note that the target vcpu and target collection are both visible in the cmd string. The handler parses out the correct vCPU for all 3 mapc calls.
---
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
index 09f270545646..23c46ad17221 100644
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
@@ -217,7 +219,7 @@ void its_send_mapc_cmd(void *cmdq_base, u32 vcpu_id, u32 collection_id, bool val
 
 	its_encode_cmd(&cmd, GITS_CMD_MAPC);
 	its_encode_collection(&cmd, collection_id);
-	its_encode_target(&cmd, vcpu_id);
+	its_encode_target(&cmd, vcpu_id << GITS_COLLECTION_TARGET_SHIFT);
 	its_encode_valid(&cmd, valid);
 
 	its_send_cmd(cmdq_base, &cmd);
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


