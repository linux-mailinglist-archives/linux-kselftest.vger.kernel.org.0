Return-Path: <linux-kselftest+bounces-11094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9A8D793B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299221F21D2D
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E967E0FC;
	Sun,  2 Jun 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lq69jgkA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D27B3C1;
	Sun,  2 Jun 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717372538; cv=none; b=un8q7Qx6Ft3R/Vq4NbRBpnV9uppJZsIFBtwRa7FHlTVncqvfV8ke4Af0Nd8ID5UFH4icaPHziXLWrHbpl/iK21qd/r6zdlVhdr3velocy63ZQYHm64qARG5RP4XrV6MOod77EBEvq97UJv58VaKnBH4IxdcSogeAfbTAAG5oJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717372538; c=relaxed/simple;
	bh=mJ+euakUnp3ZzmgPrN7Solq3UvQbB1ZApxbo6oK7Zro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL0b8htf/4gDEzVOOeE5wtBPbeulrZOm0+m9b3ITaPpmVGy/xEouYuiNGS/IDzDgwDCeV190EgekGWfuMpaX4ASckhAmN1PqdW2sGGj3vinKmiiLRQ2RuGgZpAaX8fG/SGbm9a1449jOj2Su9Z/Z+L1N0B0kXMmxdwAb8YW79x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lq69jgkA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Dk2v/z9ECEt0zuLXLB/J689XlPsnFjnI00VCdDWthTQ=; b=lq69jgkA4A1xBl4K
	OQruK7wotMH+d1Edn1B93/qcsJCLGtc70+ZcKp+Dp9iEgOTUBuWf586EIT+puDlh1jO7MI0XF8V1d
	sgaHcnaRx8SsEP1M9nqdmsSzqfI5mmkXmbTiPSOeWe6WRVkB8ycATX8wk+T/x6VgGPxi31rqWFv35
	VJwRS/t/JWLn4hoRk20qTNlq9rMV8kfWqV62FQas8d9mRUV2W8QnhiI0iD+2nV/GanMo3CO295l63
	krC0ZT3j5ASnjUhUw444/ijBhca/ZoaQfT9aS1qfBXhtmSr3d6AWNo8aqoei/uUJAJVk0ksN1IByY
	arVymfZ0X72Aa+DWAw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDv2w-003r8b-1i;
	Sun, 02 Jun 2024 23:55:31 +0000
From: linux@treblig.org
To: pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] KVM: selftests: remove unused struct 'memslot_antagonist_args'
Date: Mon,  3 Jun 2024 00:55:29 +0100
Message-ID: <20240602235529.228204-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'memslot_antagonist_args' is unused since the original
commit f73a3446252e ("KVM: selftests: Add memslot modification stress
test").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../selftests/kvm/memslot_modification_stress_test.c        | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 05fcf902e067..49f162573126 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -53,12 +53,6 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 	}
 }
 
-struct memslot_antagonist_args {
-	struct kvm_vm *vm;
-	useconds_t delay;
-	uint64_t nr_modifications;
-};
-
 static void add_remove_memslot(struct kvm_vm *vm, useconds_t delay,
 			       uint64_t nr_modifications)
 {
-- 
2.45.1


