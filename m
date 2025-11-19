Return-Path: <linux-kselftest+bounces-45985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA97C6F35B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5F9D4F01D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453C34846D;
	Wed, 19 Nov 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="GHxF/N3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A38370316;
	Wed, 19 Nov 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560679; cv=none; b=QiRabCaFocLIQMjNKMKWCGfWy0ef+7j2ZVY/z9Bf2KEMR/+q2G+RN3o2YTUe7v9nHK54EdaIVPwgZrhvGDj8DokoeiKgHY6UP2KEcJy0dYQIvOVK+EvT7pymNqYNZSPFNigPnN2Prj1s/5kguyNEOSfTeKPw6SiHZWNvpAQU6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560679; c=relaxed/simple;
	bh=ByCe5Wk1WZHnITWxGLTBZHA4ULg8negffLBSEe5L7Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0x19pQ4PGCnC9StT+onALAXoFFhWyyI4W2ch9IVpAN/Ei2n5e7AiAHJu5SpoMSiXX9/mDs7hZfFydG+ziH8A4JNhd3bBmn8aAEDOFcZtQEv+nYU9NWHDPE29bt3lkiqBFpotrt79STU/xI+TDWBqyzDiPGyMbJJo2nlyktnRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=GHxF/N3f; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763560677; x=1795096677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AD/fl1UNdfZTs54F3wc7D+0CkLxzucfjuLtGwXGbOso=;
  b=GHxF/N3fGax5eaVyAVN9PaljpyBKXPRShbGb+FbBPnHh4lRFiWkpKoaO
   dbWOJAXmKfh8VOWIJMdEo/lGDeACt4hmqgiLCYAef889PIA+JKlwU8dW0
   zwBorECwM6BRot8spTz4azOkn+KCvnJX6kxt2kN0/C+Z8PmFIJh39oa8G
   /OG09BH+0Wyc0ND52dnlzlvCBxKqPYbpdvGs6np1V8BTLoDwmoowRi3MS
   rhyDI1sY1n/GYTgA+GC7sc0nGEbltQX3cuQwp0sPvpgHUIB9LsNI788CL
   kjLDMcNdOLJ172+C8Vzd54BH3bGukhKovq8XgdY6wHXRCzka/rQc6v6j5
   Q==;
X-CSE-ConnectionGUID: JkfJsYlnQre4cKlhFs4gng==
X-CSE-MsgGUID: VCWMbrieREe6jc83VLzlfg==
X-IronPort-AV: E=Sophos;i="6.19,315,1754956800"; 
   d="scan'208";a="7255520"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:57:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.161:2525] with esmtp (Farcaster)
 id d5cebf11-5ff8-4133-9c24-8c5a2ae6742a; Wed, 19 Nov 2025 13:57:54 +0000 (UTC)
X-Farcaster-Flow-ID: d5cebf11-5ff8-4133-9c24-8c5a2ae6742a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 19 Nov 2025 13:57:54 +0000
Received: from amazon.com (10.1.212.27) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 19 Nov 2025
 13:57:52 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <nh-open-source@amazon.com>
Subject: [PATCH v2 1/2] KVM: selftests: Assert GICR_TYPER.Processor_Number matches selftest CPU number
Date: Wed, 19 Nov 2025 14:57:43 +0100
Message-ID: <20251119135744.68552-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114143902.30435-1-mdittgen@amazon.de>
References: <20251114143902.30435-1-mdittgen@amazon.de>
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

The selftests GIC library and tests assume that the
GICR_TYPER.Processor_number associated with a given CPU is the same as
the CPU's selftest index.

Since this assumption is not guaranteed by specification, add an assert
in gicv3_cpu_init() that validates this is true.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 tools/testing/selftests/kvm/lib/arm64/gic_v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/arm64/gic_v3.c b/tools/testing/selftests/kvm/lib/arm64/gic_v3.c
index 66d05506f78b..50158d08117b 100644
--- a/tools/testing/selftests/kvm/lib/arm64/gic_v3.c
+++ b/tools/testing/selftests/kvm/lib/arm64/gic_v3.c
@@ -304,6 +304,9 @@ static void gicv3_cpu_init(unsigned int cpu)
 	redist_base_cpu = gicr_base_cpu(cpu);
 	sgi_base = sgi_base_from_redist(redist_base_cpu);
 
+	/* Verify assumption that GICR_TYPER.Processor_number == cpu */
+	GUEST_ASSERT(((readq_relaxed(redist_base_cpu + GICR_TYPER) >> 8) & 0xffff) == cpu);
+
 	gicv3_enable_redist(redist_base_cpu);
 
 	/*
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


