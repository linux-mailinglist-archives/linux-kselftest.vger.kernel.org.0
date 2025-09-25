Return-Path: <linux-kselftest+bounces-42373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF8BA0DAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035D11C204BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61F315D58;
	Thu, 25 Sep 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9SOKRCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D848315D27
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821353; cv=none; b=G5TvkL+3m6QfLp+BUxIO3BegoieANZwEdY1+YWfhBJIS1Cq2SOXCuIsY5zot+BQxlvAh8scL3mpVCNtxPhKcqEFxNPp8GxE2witKYbSPCykJaFMGmAjnng3a01i6vLKQtficVhVqjVcHY+dUhG5OsyFDWhXNJbKtppMQ6OOO1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821353; c=relaxed/simple;
	bh=0y5fQGm8eE/UeEH9i6wG4uQhn+iU8S7fLI3PEGfFu4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptGTlTv6vUGKCbyrPqzfJHyzrzEm0IZIHPm9k2MHFFTsFgDUVuagBbxpiqrPZCZTcwkZqGw2C82u4MFyDXWP/7k+xB5q5Umjd/3tb8O63+bzl06MfBIXHYlPusaIh4TiZnNWW9pQAmBbtMECQ8CSYEdzMbGA3ILfUuesoFrWzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9SOKRCJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1081537b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821350; x=1759426150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDgCQyedB71H0kfnvZA2kT6wk/MFKRoB6HJA4SpT7vo=;
        b=z9SOKRCJSjXbF2PYnfP6G01Ww9RknMg1h9V2mFI3ZJhR3KDt11utsZnzq04pI2YQhp
         NUiqJvpk0g7myVqjhThmtx+Ah4cO0zsNCc9/ERr8X7w7p3AY5P4ob8o6rjccvzqVAf7K
         Xv31rze/9K9c7bUrLXKxDu7Bfx5mGq1P9ZGvnVIcqWjud+OZUMI8o9gnTHfFWZqclxPf
         1mCPXfWXeFkv7NiU3jYgMauZECkav+VveEZzXfbkcn8Zxy29BJZJjuG4vRTbViI5RRAA
         xtNLapa4VfMokkjeIYahZ63Yx2ZinkmL3N77Ze4SnAhuApcCAvQOY7tQ0a1VU5aIEbKd
         2YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821350; x=1759426150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDgCQyedB71H0kfnvZA2kT6wk/MFKRoB6HJA4SpT7vo=;
        b=HTYF/zJJl/zbuVsj3ErkdMnQKGIcRMF02TFPZmKeRlCrebF7k6DxB3a0iVYGUOnLC8
         T1XrWlqVJJvBD0wsqDVtfdP2AlS1h9qvMJlQDkYoFUpYrUXKbX+E2TkvNtQlEKtnXRX9
         dqsNSYdcSp6ptiBGWorCjc7NNACfea7MsahdnqATgIxQ7SVv/oui2QhCwUMOB+EtBpDB
         pYerikyJZOwrpsaGToN346eAdZMXchvbwzsIc0dkFtWBHzyj9ZbADY0dKWyLaDr4HQHQ
         ldgCzKT9GJqu15JWGIHGQikJTi2DJE+NkO6lv33+fRUkTooHxbHJG8ot2aGFaC84zHy8
         fqZg==
X-Gm-Message-State: AOJu0Yy4XmBr3MQzNLKQ+efeFxqONVA+me7fpjTr8TUij2n+ca0ZuKGN
	a0V6AhfaRzZLY9nstxw0REGg7kHZgboGvfuoGkQaxk5pMH1IfpewtWBvaf5WJ3s8xesQ1YMJFNQ
	LEQ0/K24JWqvOfx+woH53532MzQfGd0+kMEu0Y9HYDuYi0RJPvcXIkaf6ruRjk/E2Igl03U2rTz
	PW7IOJgx9IdkNW4oPA4FJ/8huCXwQL98oeWpxI6I7jxDI=
X-Google-Smtp-Source: AGHT+IGey0Bsncdv1pAniAZkU2NZXSHwDQbbIp9oQ5u4q/yxWwSNnNZ1y7mDiI1SKf8/XgDfCngCoRAD3A==
X-Received: from pfbhg12.prod.google.com ([2002:a05:6a00:860c:b0:776:2281:3189])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1906:b0:77c:ddd1:749e
 with SMTP id d2e1a72fcca58-780fcea3c28mr4322193b3a.19.1758821349624; Thu, 25
 Sep 2025 10:29:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:34 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-7-sagis@google.com>
Subject: [PATCH v11 06/21] KVM: selftests: Add kbuild definitons
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
2.51.0.536.g15c5d4f767-goog


