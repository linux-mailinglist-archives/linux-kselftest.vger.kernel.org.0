Return-Path: <linux-kselftest+bounces-43556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1726DBF1F69
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9DF18A6ED1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01BA242D9B;
	Mon, 20 Oct 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pxbV8tPk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54223EAAB;
	Mon, 20 Oct 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972417; cv=none; b=I7ld0bN+WDKpTu9yUlBfHe9vkL5uoOkPqtzBp+jYQHKD+SVuiQ9THT3lVA9MlOFbWwhE5HxVEHVGflL1TrUyJPGI7e27iqoPeJqYnEJHQjCr+W9PK2exu/896OY/hyJNzkYJXOJpSguliGQZTnNLaOOv9dpb6s/yyk8onnaSegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972417; c=relaxed/simple;
	bh=umqW0Su3mLgwV6fDB3f5scKb3yM+a0GtQB9z8Pir5BA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1CqrZv0D9lfEtMzYQNHuVw186KVPYtL2EOa8YLDrM8xeWbUY88ykfDAAbmoK58dczfaynivxXNRODKUxxr/IW5IsHh+0+x3BEZ1PQcuMM0RFW1nTSgEzFyeGjGvh/2ONqUoG2ehndyquaHTpzTFJ4fhfdOI5l6m+FRqJnwg7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pxbV8tPk; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1760972415; x=1792508415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gjPB+Bz27Q5z0Ba9I6xi0rD3qbYFKGm+c9Yj1X4Z/CE=;
  b=pxbV8tPki3gbsqQf8+VHsyB5CSA5rBCDY7NbJ49LBJDdR2WQe/JymWbf
   amP1gm/yFbqkEA6F4Y/q4WW8z+amnH8+hp+KXX+D0LJceHI3nMZUuOSAR
   M5IzPQAqBConjywAJ6Z5KpkjUdIOq07/YbmtpWxo3gIP1lfYiXUiJkzdL
   jzvUlid1pI5qmhMcUAQQw7gpFzNTfZAQQ/0oQqeIUGrDhie7xWxC56hxu
   Cp5+GERc2wJm7vq4nHKf/DYjmBb3M0VB41wdWOqyXNT8Kcs4gIpmTfMXA
   jktqCGmn84ORQb7DeB05fvpPWEfjsYqCxsTA/XETek1oTFWh50lnh0RZO
   w==;
X-CSE-ConnectionGUID: KOhXRf8ITDKSFms8uQ1ymQ==
X-CSE-MsgGUID: LysR5xzsT9i64tOhdjre/w==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3771860"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 15:00:00 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:10334]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.241:2525] with esmtp (Farcaster)
 id b84d140c-d300-48b5-86c1-2c9b5370694b; Mon, 20 Oct 2025 15:00:00 +0000 (UTC)
X-Farcaster-Flow-ID: b84d140c-d300-48b5-86c1-2c9b5370694b
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 15:00:00 +0000
Received: from amazon.com (10.1.213.24) by EX19D016EUA001.ant.amazon.com
 (10.252.50.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 20 Oct 2025
 14:59:55 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <epetron@amazon.de>, <nh-open-source@amazon.com>
Subject: [PATCH v2] KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stress
Date: Mon, 20 Oct 2025 16:59:46 +0200
Message-ID: <20251020145946.48288-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D016EUA001.ant.amazon.com (10.252.50.245)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since GITS_TYPER.PTA == 0, the ITS MAPC command demands a CPU ID,
rather than a physical redistributor address, for its RDbase
command argument.

As such, when MAPC-ing guest ITS collections, vgic_lpi_stress iterates
over CPU IDs in the range [0, nr_cpus), passing them as the RDbase
vcpu_id argument to its_send_mapc_cmd().

However, its_encode_target() in the its_send_mapc_cmd() selftest
handler expects RDbase arguments to be formatted with a 16 bit 
offset, as shown by the 16-bit target_addr right shift its implementation:

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
v2: Refactor the vcpu_id left shift into procnum_to_rdbase() helper.
    Rename and rewrite commit to reflect root cause of bug which was
    improper RDbase formatting, not that MAPC expects a physical
    address as the RDbase parameter.

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
___
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c b/tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
index 09f270545646..0e2f8ed90f30 100644
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
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


