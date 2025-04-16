Return-Path: <linux-kselftest+bounces-30932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79FA8AEB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 05:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E9B3BFDDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32122B8A8;
	Wed, 16 Apr 2025 03:55:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2B2288D6;
	Wed, 16 Apr 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775710; cv=none; b=dxpSFRHfaNK3rc0/E0NrVEIKaluBRmpkEG/pYKbUuCEYNzn1lbW1VVTjLBUXY/qBUHvAvSruvCCY3MNnPG4GSoIR8eYY7lM7LZLRjEEf5LivYjulJ6GrXhP8adL61aRvF80oxG8RwrbLfq/HzPPhLX+0HGpyM5KcMfvtnAND3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775710; c=relaxed/simple;
	bh=w3FkjR5czfE4/cnL5UgfQx8rD8ipfK4DqjVobHgR7bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0r9ZwUMGNFDgqwbMQdefpNG3skioWsYAyfHbL0itL5JEPPuevZFQOcbxrMjwy+b9CedqFO+da2T81B01xAsIn65KAl68JCQZtq6RtqXQr7K82R3UPNQGfjJ6M58TJW7TH8KRwuPdYHeD4/BOPKBGoCsnfxDM/+j7W0Avnq8NgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axz3MZKv9njDG_AA--.53998S3;
	Wed, 16 Apr 2025 11:55:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxLcUQKv9nvh2FAA--.62153S7;
	Wed, 16 Apr 2025 11:55:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v9 5/5] KVM: selftests: Add test cases for LoongArch
Date: Wed, 16 Apr 2025 11:54:55 +0800
Message-Id: <20250416035455.25996-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250416035455.25996-1-maobibo@loongson.cn>
References: <20250416035455.25996-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcUQKv9nvh2FAA--.62153S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Some common KVM test cases are supported on LoongArch now as following:
  coalesced_io_test
  demand_paging_test
  dirty_log_perf_test
  dirty_log_test
  guest_print_test
  hardware_disable_test
  kvm_binary_stats_test
  kvm_create_max_vcpus
  kvm_page_table_test
  memslot_modification_stress_test
  memslot_perf_test
  set_memory_region_test
And other test cases are not supported by LoongArch such as rseq_test,
since it is not supported on LoongArch physical machine either.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/Makefile           |  2 +-
 tools/testing/selftests/kvm/Makefile.kvm       | 18 ++++++++++++++++++
 .../selftests/kvm/set_memory_region_test.c     |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 20af35a91d6f..d9fffe06d3ea 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -3,7 +3,7 @@ top_srcdir = ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH            ?= $(SUBARCH)
 
-ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64))
+ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64 loongarch))
 # Top-level selftests allows ARCH=x86_64 :-(
 ifeq ($(ARCH),x86_64)
 	ARCH := x86
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..7985bb42d2c1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -47,6 +47,10 @@ LIBKVM_riscv += lib/riscv/handlers.S
 LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c
 
+LIBKVM_loongarch += lib/loongarch/processor.c
+LIBKVM_loongarch += lib/loongarch/ucall.c
+LIBKVM_loongarch += lib/loongarch/exception.S
+
 # Non-compiled test targets
 TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 
@@ -190,6 +194,20 @@ TEST_GEN_PROGS_riscv += coalesced_io_test
 TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += steal_time
 
+TEST_GEN_PROGS_loongarch += coalesced_io_test
+TEST_GEN_PROGS_loongarch += demand_paging_test
+TEST_GEN_PROGS_loongarch += dirty_log_perf_test
+TEST_GEN_PROGS_loongarch += dirty_log_test
+TEST_GEN_PROGS_loongarch += demand_paging_test
+TEST_GEN_PROGS_loongarch += guest_print_test
+TEST_GEN_PROGS_loongarch += hardware_disable_test
+TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
+TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
+TEST_GEN_PROGS_loongarch += kvm_page_table_test
+TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
+TEST_GEN_PROGS_loongarch += memslot_perf_test
+TEST_GEN_PROGS_loongarch += set_memory_region_test
+
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index bc440d5aba57..ce3ac0fd6dfb 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -350,7 +350,7 @@ static void test_invalid_memory_region_flags(void)
 	struct kvm_vm *vm;
 	int r, i;
 
-#if defined __aarch64__ || defined __riscv || defined __x86_64__
+#if defined __aarch64__ || defined __riscv || defined __x86_64__ || defined __loongarch__
 	supported_flags |= KVM_MEM_READONLY;
 #endif
 
-- 
2.39.3


