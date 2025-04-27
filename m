Return-Path: <linux-kselftest+bounces-31729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC47A9E003
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698B47A91B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF85245006;
	Sun, 27 Apr 2025 06:45:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C441DE3AC;
	Sun, 27 Apr 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745736348; cv=none; b=EA17Nkg5WG7czcBnbJQVg20ZEZ+dOUHqE1L4UX4HWTWfPXnkZ0bU4eXHTbQqR1Gn46NzkJB9ozeJKBP6A5CkOfn+yAoc/wSprjE8T9OVAU7CDx5ZPya0xUpQZMtK3a61tzY0aOSGICtt9VhkPOT1c/Uov4Wfqo2QHRAY8HP14eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745736348; c=relaxed/simple;
	bh=Q4Fa58qNeNMb88PphhtZlaG+lZnhEipZ/Kcu1dhmQkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6tiRrvE/Iw47/6GyTXkAh7VfrIsjUcwK4TXsqsqXcp814FVfghnZHBYrGHK3UPf5sSuNW3QRgDNlV4QNUp7UvMTx2qnaQBjHkReYhHnBUT/VLZ/IJIFei+ZMDt43KT3i2OPciZBueC//HvMU39+yx+O4rqj51QIBWe/Wvvb61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxDGuV0g1o8hvHAA--.2015S3;
	Sun, 27 Apr 2025 14:45:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxu8SP0g1oAEKYAA--.52357S3;
	Sun, 27 Apr 2025 14:45:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v11 1/5] KVM: selftests: Add VM_MODE_P47V47_16K VM mode
Date: Sun, 27 Apr 2025 14:45:31 +0800
Message-Id: <20250427064535.242404-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250427064535.242404-1-maobibo@loongson.cn>
References: <20250427064535.242404-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8SP0g1oAEKYAA--.52357S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, 16K page is used in general and GVA width is 47 bit
and GPA width is 47 bit also, here add new VM mode VM_MODE_P47V47_16K.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..f8faed8c8024 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -177,6 +177,7 @@ enum vm_guest_mode {
 	VM_MODE_P36V48_4K,
 	VM_MODE_P36V48_16K,
 	VM_MODE_P36V48_64K,
+	VM_MODE_P47V47_16K,
 	VM_MODE_P36V47_16K,
 	NUM_VM_MODES,
 };
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 815bc45dd8dc..5649cf2f40e8 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -222,6 +222,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
 		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
 		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
+		[VM_MODE_P47V47_16K]	= "PA-bits:47,  VA-bits:47, 16K pages",
 		[VM_MODE_P36V47_16K]	= "PA-bits:36,  VA-bits:47, 16K pages",
 	};
 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
@@ -248,6 +249,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
 	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
 	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
+	[VM_MODE_P47V47_16K]	= { 47, 47,  0x4000, 14 },
 	[VM_MODE_P36V47_16K]	= { 36, 47,  0x4000, 14 },
 };
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
@@ -319,6 +321,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	case VM_MODE_P36V48_16K:
 		vm->pgtable_levels = 4;
 		break;
+	case VM_MODE_P47V47_16K:
 	case VM_MODE_P36V47_16K:
 		vm->pgtable_levels = 3;
 		break;
-- 
2.39.3


