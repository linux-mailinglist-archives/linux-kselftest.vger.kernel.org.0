Return-Path: <linux-kselftest+bounces-31229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC89A94D2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4871B170951
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F41E98EA;
	Mon, 21 Apr 2025 07:31:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDE1E8329;
	Mon, 21 Apr 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220684; cv=none; b=l9bJ9HUhymKAN/SUI1Dp48AaOHrxvYr7cN1ZpDQN8iK7+YZ5kCGJW6/jTISy5LpXoXDBLgcPcW+N24ERKdJ4mlTq3b/PH7d1mNj4AVTnYi6wWmoop43bXaUu6zTpv/SXdhI7F+5DSH31KayPQJjK824sH9Z3/+xKn39+hRjqgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220684; c=relaxed/simple;
	bh=qFjcpY7G4UvAvpezP2J+wXOuhfZlC9khcrCE9vkGDFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4NnM75TICM4BLSFUf0s6TX+Dv+oHu9Qp7UHeYl4Yy5AGGigmsYXubDOBZZxdI84+SQ8X0IBjCkehpLPKsdd4j6QSSd+q04FO0xNK3HTQZT850LN1vUBPb4O2z2kAtVTcfpykYvIwELX+zRKUDdYSGO58s8tRbtqXjcudhPJNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx365F9AVoc0nDAA--.42988S3;
	Mon, 21 Apr 2025 15:31:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxn8U+9AVopeqNAA--.25751S3;
	Mon, 21 Apr 2025 15:31:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 1/5] KVM: selftests: Add VM_MODE_P47V47_16K vm mode
Date: Mon, 21 Apr 2025 15:31:06 +0800
Message-Id: <20250421073110.2259397-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250421073110.2259397-1-maobibo@loongson.cn>
References: <20250421073110.2259397-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxn8U+9AVopeqNAA--.25751S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, GVA width is 47 bit and GPA width is 47 bit also,
here add new vm mode VM_MODE_P47V47_16K.

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


