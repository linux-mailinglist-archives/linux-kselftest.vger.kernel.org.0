Return-Path: <linux-kselftest+bounces-30790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84381A88E78
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE75189B12E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70938234994;
	Mon, 14 Apr 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awhRlCt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106A23372C
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667360; cv=none; b=SqbBwQ3PbA3fwXNF9PmchyQDiCLplBoCecgcZR6wo7GAaMZLcrGezXHofQhMQvyyUcWhuJVqPj3mvGdys/1CIfzC7uQzwlyHvoTx+5A6/o6nNOVkueoQKH9/T2+LMMtOccrWq+8DW9M9v/XrntblwkmPSJQNBrGffxdoxdtKgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667360; c=relaxed/simple;
	bh=hLajejGITcuhaXBIRXTQrFTsOjzlzEWxNRGtAI1RMps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OBwwutkiQZQ9bAtUQtbfG7hGbPSE2rgcw2CTZCnzqgWy2g6s85OhV6CTE4rHTAR/sE5cGofy/apx7WcxbnIJ+qgiU47HLisPl/+TScmE4yU+c/At/K4CLD2CFXiuOrfDge+5jqub3s3CROeEM6bYvVdTdiONvUb+wSWGvNoCd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awhRlCt+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af91804dd0bso2881405a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667358; x=1745272158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo1IP0uWcijK66QdAGH5hRccKPpzDDEL85AFTPGHKFQ=;
        b=awhRlCt+RSvO839lFmcim4Hri8mSx9euu6V1570ZRb4f532wBTUNIHpZm6GJr7ydid
         mrYznaVjnKJcwASEq6fYamgdqwRuDDhyWgMUkv6yoX0N2MIjX6l93O2xnL9p2BCdFGId
         nLsZlym6x6oj4E4RLXY4wz46mbeJ89bgqiYb4UoCaH1qe1OfTW8tHi7wgQVL5MLIxne7
         5YYhPZzSdLWbakNs6wxXb8BXtBJOFS2bpDqGR90y0re4kpMiIg1RN3jfKkl+XHUm4Kzw
         MULEfvak8KJzEvGNibSWVxgQ9utksUBWlMcvZ0pHTVYq2TgEIvHZVJ9lkw6Fbv0DWVwg
         M6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667358; x=1745272158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo1IP0uWcijK66QdAGH5hRccKPpzDDEL85AFTPGHKFQ=;
        b=qNjFFFj4l11wqodAGcuch6eAcb5MhK8QMgq8g9kGBDsvlP/aZMdLATu452iCpbdCAJ
         NCIuakqNukzGmWfSTt4cXvKEfzlZ6TidoF4IJ47eAOr94T6ALCaQtnGLe9RzXYscwZGi
         heJ1B7oaPAKrIvy9geflKpI7PJiJukaaJsgmpe8E1rE4e/QlKCuYL861I2nA9sW6qjmM
         HuwwB8nTYP9UqM1AFtHh5lw+ynywD9/gpNt9LgLDuRSiTWhsDZvorPDzOcEh69xD0M3k
         BWNvq8AYcXsNG5+8auXXJfNya7h/14XdCl6gqQn02tWMnjqjsEhDQCJAg0RmV8NWMsQa
         5Sww==
X-Gm-Message-State: AOJu0YxnWthY1D0/yhx3kXYX0luAwSqwzKQ4porJosUn349Rj39ZyIM7
	NJiHXRBC5RGfzGv7vNSv5s+7YtlfnGrr0OJGkdeFppFhw/V7OOoVLG0gdRvwbSQqRk9/RLw8bcL
	sCNAQdqGGKMqKUNfFatUCPS7St1o1JooQoK9aOznU3zKu4Q78ri8X7FU5d5X2Lg34KAm3DM4fPR
	ygjBmK9joVig7Nop5+Me3GMiFWSqQp7dOkuS2J/Rg=
X-Google-Smtp-Source: AGHT+IHAofPIGSKzrHScymrPJdqDpM5RU2HCackGHmvSKi1y01zbyqaKV2rM505+l4lypM3CcWok4IqT7w==
X-Received: from pgpk1.prod.google.com ([2002:a63:ab41:0:b0:b05:1101:88f])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4581:b0:1ee:e46d:58a2
 with SMTP id adf61e73a8af0-2017978b1f2mr20956324637.3.1744667357888; Mon, 14
 Apr 2025 14:49:17 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:55 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-27-sagis@google.com>
Subject: [PATCH v6 26/30] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Add support for TDG.MEM.PAGE.ACCEPT that the guest uses to accept
a pending private page, previously added by TDH.MEM.PAGE.AUG or after
conversion using the KVM_SET_MEMORY_ATTRIBUTES ioctl().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c     | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 88f3571df16f..53637159fa12 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -7,6 +7,7 @@
 #include "kvm_util.h"
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -40,5 +41,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index bae84c34c19e..a51ab7511936 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -3,6 +3,7 @@
 #include <linux/kvm_para.h>
 #include <string.h>
 
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -215,3 +216,9 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, (gpa & PAGE_MASK) | level,
+				 0, 0, 0, NULL);
+}
-- 
2.49.0.504.g3bcea36a83-goog


