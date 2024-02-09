Return-Path: <linux-kselftest+bounces-4383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB60984F04E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1530A1C22DB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1F65BA3;
	Fri,  9 Feb 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="DD7z9m3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AC657AD
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460862; cv=none; b=uLy2xCbZlewQNx5ThQV5KMONy43GHPRnPwxUkqSn24IMZ1GtwRDuFDhSB5itAr9MhROO4g+flnc3xZ+g1ttJM/ZdrWc9OiXKRYnJPS/dtzXkF678V6NK1CzDd9SNRmmQ6jb6gXK3Uwg5eSre1AyFzXYQ1WmkjV3OPo9ptdl7D1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460862; c=relaxed/simple;
	bh=ri22eEmjayNxuhuBG8fBzJMN00sxq5Jxvs3GiYc76e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+MdvW/9PXTQ65QYJf0ofRC9PixonZaK46iS2m3VPUBC4vGdRh4i2kFJG0RTZvZBW5D3STOxkVYM85gisWmk9kRPL0qRyeLFMQZE4Y13DhM7mA7QbbGaibPE1pA7awAZHG4Ca1+JdNe7WSGfJFa7vN6zWcFl+5TVDPm3aq77mL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=DD7z9m3Q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5116643c64eso1044334e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460857; x=1708065657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNljdwCtgXX7yfrlqeBRJqsYJccdvVcfZVPFTIAjXvY=;
        b=DD7z9m3Q0h2VUiY43CHhnTD3CaYZgZt/8DwAvRHPtGT4XoqqSgU1M+C8/ITsCo5IWA
         7OiPAj7QVW2D7oQFlcbihIMBUKjgKTj8nDEi/0Dd0iJfmx/3qcu/fRcTfH/AYeeFbVdB
         19imOVuQ8fia5NAUrC6hXebXRjx3GUT3vNo56lNYUlHjinSmI0yE6ncMTRhSUpPcyx6h
         cjZbe4K+xK+zzMQ/kozwvKUbBspPB6fwGIwMGBsr5YLkA5Ptx/UYv9cPjc/CwWABa5Qg
         hThzzqbU9I+MH3Enq5z4+d+MxWFixXbtgUy1Zzaospyhu+Er1DpRZDVlB1nXwrc/+XDf
         8PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460857; x=1708065657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNljdwCtgXX7yfrlqeBRJqsYJccdvVcfZVPFTIAjXvY=;
        b=vMduD5DVK5DQ+kEg1YIkzP30p2xKNYghWTW6pg6i7WDgE5OIwm3mgq8oqhZFvQfsr6
         0KBJKY7UhWIZymXeG5wx3VkeLHZZiKaSuwoOk0ykJuYl9eLLPvqIB/ANvrsfqNS6pkQI
         AlmYfDGFC6vAqZvB8BbvFHxymcrXRFxMrBqkX0IaadUhU+TmkHznSN75sYovtrMvKrGB
         xdY5qak1gy7D8EOspOJYbLs2R5bHPrnyQ54/rlgUQ1f9QcYK5rblSK+zL4Mh7EqaTtoY
         bPobB3y+fg1IYQQlVvJfHHUN2scOJEjXPAJysqJ6TF7HzqNqHOft1RejezxwRr4x6KcD
         4RKw==
X-Gm-Message-State: AOJu0YxD2kJLoWSFwm+uQOcmUSunMDtqRZBvi1HvQAOmCaIbpANKQuOy
	I0/2Oj9q1TgFgOTbzCisjr0meJYdjIjDgD4sWW2F+EhMyCuxrVgnCyIONf+PrMA=
X-Google-Smtp-Source: AGHT+IEDhflFCI5m8yckBlcrHhcrQQ3ldJE+rE+09x08ZsDb/7emc/oMoKtCCmmPX+z/DuDjiayT1g==
X-Received: by 2002:a05:6512:3e6:b0:511:6f2e:d23f with SMTP id n6-20020a05651203e600b005116f2ed23fmr303429lfq.43.1707460856741;
        Thu, 08 Feb 2024 22:40:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaL+yEba5wm8i34ZSQJNQMvgW6J8dd/cBl9IdEWc4gJ7MotgFZlcF2vvfMBwq4KUmx959cSuSlRe3Qlxhu4KfyqJb2tOoRm5+/3LKr8WMyPrWXCd0f7xaUwI4heMRaEmdtkB03hUfP5VdCbRxXOVGwsR0+FM1Q1eZoT/7ZQi1h75nUQBGOq452eMVDPqEQ8vJwybjkXHa2P2956nsp4ell4ZmZvfFkG8AKEkC5PDV4EWdVxBuTYDqOJNmx1zA9X/5CFXLdE444VW797AcovWMNx1QCzp6cwWLS/G62gqSwdVZ7fcJQ43MAnuGCwwog6JYyd6M9ml084zVece5wtDbgMfpl4Sv8asE365tfO4DEl6+vtRyJF4xLh/1HFvY125EiYDehiYJ38vOgbELtcCFGs1wHqol92ZvncDJ8YfqeD45mSFdS2XDr27wJOT5rd7XW3hSmOGw68GuLvIa3T/ZLkytmvs8fxKFIPSkDmohuOir+dLdnL5vTzPWCnggEtTBV8+3Up3TAwJMviLwjRq8UIczfXtPNcmhJcCpHztwzbuA+uoNBNHblC7eiGpy4q6IiD5jrEguUynT7b6FxUPuJSZP2dHgF7k3mj4f4LPHzEr2SG3i88ssWGkRqdrNHQ1ZI5rCrEBFNLjuxg5HalTNGp3XqhWOgEjQbRp0tTDcJBB+XKMkl+LYW0RvJXS3pvfghirr/1o+ONtKmvg7GmB48p+6rxDPAoGvj1ZFLP/6Akd+iMWgHO2//OKQD3DXKwQbHq347V96eRJyHRponH2izjQ8kzxgOZfAdrZFvAV4u8iMvFhUbNVQzAWmHSpTX+SbxrqrlkuyDYJfZ5RTU9vYpeWj1ZGKimEXlKvhwx0IsnA==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:40:56 -0800 (PST)
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
Subject: [RFC PATCH v2 1/6] mm: Add dynamic memory consistency model switching
Date: Fri,  9 Feb 2024 07:40:45 +0100
Message-ID: <20240209064050.2746540-2-christoph.muellner@vrull.eu>
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

Some architectures have support to change the memory consistency model
at run time. This patch adds a new field 'active_memory_consistency_model'
to task_struct that allows architecture code to store the active model
as a per-process property.

To avoid useless overhead, the mechanism needs to be explicitly
enabled in the architecture's Kconfig.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 .../mm/dynamic-memory-consistency-model.rst   | 49 +++++++++++++++++++
 Documentation/mm/index.rst                    |  1 +
 arch/Kconfig                                  | 14 ++++++
 include/linux/sched.h                         |  5 ++
 4 files changed, 69 insertions(+)
 create mode 100644 Documentation/mm/dynamic-memory-consistency-model.rst

diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
new file mode 100644
index 000000000000..3117c3d82b2b
--- /dev/null
+++ b/Documentation/mm/dynamic-memory-consistency-model.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+Dynamic memory consistency model switching
+==========================================
+
+:Author: Christoph Müllner <christoph.muellner@vrull.eu>
+:Date: 1 Feb 2024
+
+This document gives an overview about dynamic memory consistency model
+switching for user mode at run-time.
+
+Memory consistency models
+=========================
+
+A memory consistency model is a set of guarantees a CPU architecture
+provides about (re-)ordering memory accesses. Each architecture defines
+its own model and set of rules within that, which are carefully specified.
+The provided guarantees have consequences for the microarchitectures (e.g.,
+some memory consistency models allow reordering stores after loads) and
+the software executed within this model (memory consistency models that
+allow reordering memory accesses provide memory barrier instructions
+to enforce additional guarantees when needed explicitly).
+
+Details about the architecture-independent memory consistency model abstraction
+in the Linux kernel and the use of the different types of memory barriers
+can be found here:
+
+	Documentation/memory-barriers.txt
+
+Two models can be in a weaker/stronger relation. I.e., a consistency
+model A is weaker/stronger than another model B if A provides a subset/superset
+of the constraints that B provides.
+
+Some architectures define more than one memory consistency model.
+On such architectures, switching the memory consistency model at run-time
+to a stronger one is possible because software written for the weaker model is
+compatible with the constraints of the stronger model.
+
+If two models are not in a weaker/stronger relation, switching between
+them will violate the consistency assumptions that the software was
+written under (i.e., causing subtle bugs that are very hard to debug).
+
+The following restrictions apply for switching the memory consistency model
+at run-time:
+
+* Only switching from a weaker to a stronger model is safe.
+* The stronger memory model affects all threads of a process, when running in user mode.
+* Forked processes derive their active memory model from their parents.
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 31d2ac306438..36d40502b421 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -43,6 +43,7 @@ above structured documentation, or deleted if it has served its purpose.
    arch_pgtable_helpers
    balance
    damon/index
+   dynamic-memory-consistency-model
    free_page_reporting
    hmm
    hwpoison
diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..89d4e27f9b80 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1479,6 +1479,20 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_DYNAMIC_MEMORY_CONSISTENCY_MODEL
+	bool
+	help
+	  An arch should select this symbol if it supports switching
+	  the memory consistency model at run-time.
+
+config DYNAMIC_MEMORY_CONSISTENCY_MODEL
+	bool "Dynamic memory consistency model support"
+	depends on ARCH_HAS_DYNAMIC_MEMORY_CONSISTENCY_MODEL
+	default y
+	help
+	  This option turns on the support to switch the memory consistency
+	  model at runtime on a per-process-base.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..5cbd3a3b80ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -979,6 +979,11 @@ struct task_struct {
 	/* Canary value for the -fstack-protector GCC feature: */
 	unsigned long			stack_canary;
 #endif
+
+#ifdef CONFIG_DYNAMIC_MEMORY_CONSISTENCY_MODEL
+	unsigned long			memory_consistency_model;
+#endif
+
 	/*
 	 * Pointers to the (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with
-- 
2.43.0


