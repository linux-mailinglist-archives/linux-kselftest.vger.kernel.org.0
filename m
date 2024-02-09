Return-Path: <linux-kselftest+bounces-4382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9284F04C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5EF1F24D47
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C4657DA;
	Fri,  9 Feb 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="mJ65RxN3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBF657BE
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460862; cv=none; b=AGFv+NwGEPwn3CI+/EsT8SzYlb/z9TsYy4+Lhf4veT7iR8yxFkaQqR3RIP7BBGKMhb/B1Y7Pf/S84vs/TDp39MzOMj4boHn3ie9j5d+HRTBb9JtYePSuSwWjy+kAvSToWApXPAO4o3fsb6V1LeYFAcf/e7zZsqZ2+LZut3Gx0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460862; c=relaxed/simple;
	bh=ifyOm/Jff2D4hC+7lPpykba0FTTiyuZ30Z/Vma6f/bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahopSIar1Lw65ZytlM7f3/5XY5jEEWPkymkGgNHn/GGhDr/oZM46JbvmJpt4H//STUBrpEcMAwYUR+FXDm+E+WIv5isXuNBAKS7WtD3GHh8W3g/vdG6y3IQO3O55BnmDsBVC1HU5jTby/SqRRFFwM/jAZL/4JMdxpotUYu0MNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=mJ65RxN3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3810e975aaso66933166b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460859; x=1708065659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka0BwVIa89CrbsNMJkPh2Vgcr3mcWFHipPKQFS87pYA=;
        b=mJ65RxN3sYP77x4R1N9FyTwmjQpcX+8J6BJ1K55yW+ueU5YyUCggc205fy85RFGi9q
         JsgndWapcHw/TGlhWzG2IQwE7CzhYhViPGJFqfUfuS+BkQq1cOYvUIFzzy5Q7K9adp+W
         bhTMbuBQjrO4qlw8PmgSDEPBrYBdqL/YSArDFgh/ZYxyRNfjYgUMxZXxOy6ZJJovH7mT
         dIHzWyH90VmBlRK+S60LMPy+knjP7Rp2TQxZKfIIdPV8lkgcC90+C5dfaCUExvlcwgP8
         3oKVQxfe0Q6Me5hwkOTHeIotrvSF2YdAp3shyxkF8EmLIXxdFS6VXgGj97NPzbc37ajF
         g6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460859; x=1708065659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka0BwVIa89CrbsNMJkPh2Vgcr3mcWFHipPKQFS87pYA=;
        b=WZLl++Xs252kXGWSryHfyNbspgx5uhOK9MpalYp0cWO1cGwMy8NzjD4p8GFKQyZnp/
         HEJd/qd+IlsyRfrC0maNwS70ap3vEuhCuPrwV5HrNR6OiPfESyNT3Nenn/w7ScjIVLsV
         eTMDUMce0sevvpz3/eBDrNSXgAPWGm98zEhRhSj6TrPp/FNXb+9IjTz8sPBpJU55dOh7
         oI5/hnuuzHiQmosyNH8pwEkHIjP+z5MG6Pkro3L00BNTlz3eNZiyceYxftu+8fjmIMSF
         I3z7EUfHvPvo7YuhZYGHixma12AWNhS/UW+nZXTFAzfekGsgqgbQqYJcjNHOEpPvTJdW
         zpgw==
X-Gm-Message-State: AOJu0Yywicj2C5SkGKngrrnldC2xlm6sWVBo6nEqQVcmA7VdoeM8GL1I
	e2UDwD03LusrENwvQ+8Uzzcv4H2j7Y4dwAOHEVyFTCzWC5MokcnSO0U+xe/MGpo=
X-Google-Smtp-Source: AGHT+IFEN03if+6niuHDJ7y6KQ3qH470BeXh3gKz+Sb465eM/2K3LAMO8sCRGXg+1jKiB4FL7oHnjw==
X-Received: by 2002:a17:906:2e91:b0:a37:7b4:9538 with SMTP id o17-20020a1709062e9100b00a3707b49538mr530857eji.33.1707460858580;
        Thu, 08 Feb 2024 22:40:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGzRsAZwmfQ3VpSld4acgsFVB8Z2BpFxm5NYoupbUP/wDHZUcHWD0xshhR8SzfywjNN/6uiHCGHWB3luBB7eAro95MsHdnxJbi/UsaoOWSi/QX7Yt3BGzNKdp5rZMZI4ZCaJrcG3SSADnGciJhN51oKuauuTPK+/oaFDQEq9fFxnkTdCcgWwxBRc2/qEVCRnTSSXWdN9Dhwxos973APpZ8ybYob1XLGih9Ej/b67MnvWZBSQzE/otQIR76P/XvNjg/eVczYytDfWZXVLUrGDTLltumZbxt+67DG9vbcnDKew0X/chAbTQfYrTYpkLRlj0kwsodyv04SaDJ1gad2bOJTPEQtGLPKz2/YsnmOLREsvkoageVxwSbJhiDF30C7qkgV++HU2WIkmb+wOIuU3Ck3GzZIMla0sFstAz8dXyRNm+yDeUoEflVK0q1lKALfz8tkUBEGc6omFxBsljE/KqQwVHtBdygQ8fNqUfMEWoT03c74tkohgGFw1IsWg7MdAVF9WedboaLk5CYiTXW9RAWxMEBDsDVChXyTdHCz2NF7PPk1QYS+zBnkZyypbUI02tKIE7oorhJtzbg0Vkuslqhe7u5XzLFZLe8WE7GD35XxR1jGkVb1zdSYPBxCzO/3LmeKOWXN12YDTlnDMFgGmKCvKNAs5IipyIg22VgBDA/GW0iNeAax58E0aap/Swu9mxIkfNzrAZOSnJRYq6ZR6wASlI8grPksL2Sabilobn98XkAJ1WuIQ5fOHUl+iRQMsuItpiI724RZwSPd/uKOZnbK/M+PBA+0pYuXqXUK9gz+7NrViKr8a+JhLSAFif+ZnT4CZaNekMrga7Hjfyh9xRRxpJzHHYAXrXnPSDDbJWFZw==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:40:58 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Brendan Sweeney <turtwig@utexas.edu>,
	Andrew Waterman <andrew@sifive.com>,
	Brendan Sweeney <brs@berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Hans Boehm <hboehm@google.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH v2 2/6] uapi: prctl: Add new prctl call to set/get the memory consistency model
Date: Fri,  9 Feb 2024 07:40:46 +0100
Message-ID: <20240209064050.2746540-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch defines a prctl uAPI for switching the active memory
consistency model of user-space processes.

The implementation follows the way other prctl calls are implemented by
disabling them unless arch-specific code provides the relevant macros.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 .../mm/dynamic-memory-consistency-model.rst   | 27 +++++++++++++++++++
 include/uapi/linux/prctl.h                    |  3 +++
 kernel/sys.c                                  | 12 +++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
index 3117c3d82b2b..1fce855a1fad 100644
--- a/Documentation/mm/dynamic-memory-consistency-model.rst
+++ b/Documentation/mm/dynamic-memory-consistency-model.rst
@@ -47,3 +47,30 @@ at run-time:
 * Only switching from a weaker to a stronger model is safe.
 * The stronger memory model affects all threads of a process, when running in user mode.
 * Forked processes derive their active memory model from their parents.
+
+User API via prctl
+==================
+
+Two prctl calls are defined to get/set the active memory consistency model:
+
+* prctl(PR_GET_MEMORY_CONSISTENCY_MODEL)
+
+    Returns the active memory consistency model for the calling process/thread.
+    If the architecture does not support dynamic memory consistency models,
+    then -1 is returned, and errno is set to EINVAL.
+
+* prctl(PR_SET_MEMORY_CONSISTENCY_MODEL, unsigned long new_model)
+
+    Switches the memory consistency model for the calling process/thread
+    to the given model. If the architecture does not support dynamic
+    memory consistency models, or does not support the provided model, or
+    does not allow to switch to the proveided model then -1 is returned,
+    and errno is set to EINVAL.
+
+Supported memory consistency models
+===================================
+
+This section defines the memory consistency models which are supported
+by the prctl interface.
+
+<none>
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..579662731eaa 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,7 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_SET_MEMORY_CONSISTENCY_MODEL		71
+#define PR_GET_MEMORY_CONSISTENCY_MODEL		72
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..a1b92a38f889 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -146,6 +146,12 @@
 #ifndef RISCV_V_GET_CONTROL
 # define RISCV_V_GET_CONTROL()		(-EINVAL)
 #endif
+#ifndef SET_MEMORY_CONSISTENCY_MODEL
+# define SET_MEMORY_CONSISTENCY_MODEL(a)	(-EINVAL)
+#endif
+#ifndef GET_MEMORY_CONSISTENCY_MODEL
+# define GET_MEMORY_CONSISTENCY_MODEL()		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2743,6 +2749,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_SET_MEMORY_CONSISTENCY_MODEL:
+		error = SET_MEMORY_CONSISTENCY_MODEL(arg2);
+		break;
+	case PR_GET_MEMORY_CONSISTENCY_MODEL:
+		error = GET_MEMORY_CONSISTENCY_MODEL();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.43.0


