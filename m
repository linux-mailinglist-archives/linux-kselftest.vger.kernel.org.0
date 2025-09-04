Return-Path: <linux-kselftest+bounces-40735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04ABB432FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9588B5649B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BFF28B4FA;
	Thu,  4 Sep 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1EWDlQ8D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C928935C
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968914; cv=none; b=hVtk4UZ0GSVqs4DAmxMJH7BMvMKouFtVthgicHwJlK0eYFyITbNX3yCJbWag3865T+SxrA+T6a0XUDcMhd9An56bHNhOYItlW3j0SIqxgEtdF8UhySfPXDxxVnMZARbQgeiGYh1G8wQ9RVH846fxvDptAAeRWRLoXIuTwEzct6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968914; c=relaxed/simple;
	bh=jTAk0VRpOVV4bc0UhlAMxjyl0WAtBQgyMPsTPcfAW2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kj5ZN049vvLMP+zAwBmcuXorpAG6PT8KidV4x0Q4QJYTMVAAP7uuE/MK8sGG/66xXc6zyewb0NMVoqfBooJwpkgYsvqwkp4DQXDb9z5mqw2HM7Q9jXDoTOuLWePLgQbIkAjEMfEmJHsW2qU7rDgQg7e2mbhG9YmBpAUUheksIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1EWDlQ8D; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-249118cb74cso9046835ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968912; x=1757573712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BNUyviqUil8XBJbXZDuQ3pKbq0VlqMJJavKpGuaG4I=;
        b=1EWDlQ8DXnJpXX/L0K3Yobmk5UDc0JDWkin9dR8nha6JkLYuohLW+vT1v3qRZyMUNu
         4Z2jkJQEGdHUsmPTG6E2W577bPvnDFbsYOnBPGncumnHRSKpEg6IlNp8nA2jxBzKkCcQ
         7ZhaL3ly0abhZgpiQfgTFZRwocaX39b2UD5iOjIDCf139R87Iq8HPdcv6QhAg6ZGzlDq
         Lg0ZU83dFU4he3Jq4GiTe/VmAsfFVG7YE+ocVRok2wnnGALThqEYBMwD7CXvLE11Z2sz
         maEja5ANyXbFjmi6q/FvdRN0K1mxE5FbI6rQcbEaVneeKXoHGqkEuXC8+C1rs+TiBXAX
         jXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968912; x=1757573712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BNUyviqUil8XBJbXZDuQ3pKbq0VlqMJJavKpGuaG4I=;
        b=IPmjWhutgXlFr7r8+RfEJLiM845qV1P1kBrifCJiJkXt+jKljRCrxP8hATuRdDRpbQ
         R0Pbsl75ATrVKFU5FNAxQRYDPpKVNL1P6eAUQhsXUjQDozk/RlEHAY30eLHKiZJd6jMe
         M2EeLIC1Qwjcadc5cW/R3YTldsTOUe9r+WoDuYsLjl5NRxPu9a5pdTVh/QHQIzYHjGfF
         Fu//3gpLj/9/GaOxWfRSoFPiPrhvYGJsn2hZrBHizYPmSCVQWxOwh4SK50jOOlo6zdyu
         6vFhfnedZ4RSpuyLnfu29BPk5rqREHml542TQ/Hr9eAxP74gp3TPq3YKI0x97i+QFm/A
         cGow==
X-Gm-Message-State: AOJu0Yyo43RkPx+FNvXQ2F24twWSH3CV8L4cKgzd6kOAzNQjNowsB9PC
	h7n26AJLZISmY/Ryu8kDYMeACFxiZfBAENblOachi0/LyaSYRbTGpBadB8VwvSPR+GjGBmoyCJl
	96yV9DcGYtFWlJEcrMgUzW6zzGqXWKeyFOHkz+YP7zhc5TqSnn8V0OfO4zVZrnMGAaaPZ2ZZYjh
	KuZID0aOsaXNvp7ywmYzjRPtYrqrqGkWimU+1B/dBrVBw=
X-Google-Smtp-Source: AGHT+IH5hLY38bpfnaQsbJuP8cpIl0UsXd1oicIeqNFK0OMpEiH24w+v7AklRI93GhnSPuMBYNIePkxKxQ==
X-Received: from plblm13.prod.google.com ([2002:a17:903:298d:b0:248:9b66:3356])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:28c:b0:248:811e:f873
 with SMTP id d9443c01a7336-24944ab8f4bmr241345565ad.36.1756968912276; Wed, 03
 Sep 2025 23:55:12 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:36 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-7-sagis@google.com>
Subject: [PATCH v10 06/21] KVM: selftests: Add kbuild definitons
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add kbuild.h that can be used by files under tools/

Definitions are taken from the original definitions at
include/linux/kbuild.h

This is needed to expose values from c code to assembly code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/include/linux/kbuild.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/include/linux/kbuild.h

diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
new file mode 100644
index 000000000000..62e20ba9380e
--- /dev/null
+++ b/tools/include/linux/kbuild.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TOOLS_LINUX_KBUILD_H
+#define __TOOLS_LINUX_KBUILD_H
+
+#include <stddef.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem))
+
+#define COMMENT(x) \
+	asm volatile("\n.ascii \"->#" x "\"")
+
+#endif /* __TOOLS_LINUX_KBUILD_H */
-- 
2.51.0.338.gd7d06c2dae-goog


