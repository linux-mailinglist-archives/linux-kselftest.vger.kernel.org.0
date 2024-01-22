Return-Path: <linux-kselftest+bounces-3305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDC835E8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BFC289BDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013A639AEA;
	Mon, 22 Jan 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNTdXCgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DD3A8DF;
	Mon, 22 Jan 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916840; cv=none; b=idE7V28NUReijziUCRgqpNjpQ9yCyLDwJjras5v3ByCo33fRalVngcrssOL8EjbptUNAfB/eEzZGvyOGim73XGIpyCoNcHH559g2HUnnZxeuQ2wXjwaFsZ35ZLzhkQVDni9cKBTdM0RrKtQALMj6xmKxVe/VVIRmtZpcDynFBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916840; c=relaxed/simple;
	bh=bCbMxYqsNc6ysevtODH1LdEzA9cmGSP1KVajSHQPjJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHul7jb1m/u6v4OLLh/66WBKxlSfozEt2h2RTdbSOFP4TuDKJz/ykfuEdPK8cwKV8cMS8tm+2uvM7nqn/F5Syk/XzmKq42KoUaa396JQBdXO6ff16dUyu11BOlZILSR/3AOmCOn8JMLomRVLqxahK/CkrLQOKlDuPW9kkcQCwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNTdXCgF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916840; x=1737452840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bCbMxYqsNc6ysevtODH1LdEzA9cmGSP1KVajSHQPjJU=;
  b=FNTdXCgFDEajK0J+b4+fNPpxe5+s51uH2XqYPM3n/4RxGn1+ABwZgHvI
   qacCUMnlG1uDyHcLeKUCYQXBp7q7pZu/56jljYDSlvXu7sOkII9gXkEDf
   AzWhg0NOWbu1wYFMu4E3/ojdcSTMnSz1Ryuvh2PPh2/DnLmeUxT2XJJLT
   jbtuDrmtvou523Zo+2jCXrBBVmSNLiIm8Xc6P3MkHEeoOVjXVb3SH88mt
   jgiuwt3yiJ6dyeqoRnmWM0syD1C0fd0/fzuyETd6LQxCw3VVuIaD2qCuH
   8pP87cw7w58JaImtMXQUBLL4SYKGI3gfKSr3STeVnFOSIALbwGPR6JoGK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641905"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641905"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535499"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535499"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:47:09 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	wchen <waylingii@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Like Xu <likexu@tencent.com>,
	Peter Xu <peterx@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 08/12] KVM: riscv: selftests: Switch to use macro from csr.h
Date: Mon, 22 Jan 2024 17:58:38 +0800
Message-Id: <4806503d3e8fe4b727eb6df72c8fdd087355495b.1705916069.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
References: <cover.1705916069.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5b62a3d2aa9b..6f9e1e5e466d 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -7,8 +7,9 @@
 #ifndef SELFTEST_KVM_PROCESSOR_H
 #define SELFTEST_KVM_PROCESSOR_H
 
-#include "kvm_util.h"
 #include <linux/stringify.h>
+#include <asm/csr.h>
+#include "kvm_util.h"
 
 static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 				    uint64_t  size)
@@ -95,13 +96,6 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
 #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
 
-#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
-#define SATP_MODE_39				_AC(0x8000000000000000, UL)
-#define SATP_MODE_48				_AC(0x9000000000000000, UL)
-#define SATP_ASID_BITS				16
-#define SATP_ASID_SHIFT				44
-#define SATP_ASID_MASK				_AC(0xFFFF, UL)
-
 #define SBI_EXT_EXPERIMENTAL_START		0x08000000
 #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
 
-- 
2.34.1


