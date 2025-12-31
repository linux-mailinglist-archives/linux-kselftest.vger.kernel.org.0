Return-Path: <linux-kselftest+bounces-48033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0535CEC7B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7071930039DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303C308F2A;
	Wed, 31 Dec 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ2rJi2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21347308F26
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206843; cv=none; b=irVLlBC1pV4H4Q+D3gAi4+ElhILkRqKh9MJVrc6rYoaUvuAvO4yhZYwXm+f2OE3colyU0CeH3tPWbjmOSXTkLrZGYeSmnE9xOA2ok1D96BoKikkdvZmr3NXdESoYDQNg8VTM8yUi4KxCfmgbACbq3mYGH4GlQD/bSnYPWw1ygE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206843; c=relaxed/simple;
	bh=eHViu1se3YsldXmpx6sxgvswnK1NuLJRzANw/XVEnHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYd4UlIy1BUd3W3uCyu73l4Y+u6JP+prUzYH9ivtPQ0BMXgNzqhuVfwswFo5qYRQdNEp1r2a9C+gZg9Sm6eiGG77KajGBCrsqRJFTjZYb5IoahpAgDCpdGXSYdEexhsd9lSIsHYWi+r1SZwLjWe7mOO9G3yA2Km2R5g0uAWNoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ2rJi2E; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78d6a3c3b77so115829557b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767206841; x=1767811641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TR8lxCkS4eDpppOQUREYlPdk8D1i+AlunKABWTpf3Pc=;
        b=WZ2rJi2EuukMy7vmNMdi6EqPvhrmzqcNYNlvOAIrSQ1vhNgJuxhu3CwJv2hdfas+JB
         gVsvjeLnYlVVl0aoUUbJBMxlO2bDbRJ3GACggCeQW3LpbxVh3IzxsXthrMpi32C/FeiD
         DnrkKv46gKTw5HnMz8sN7QX4xO2ynPZF/IVI/5ZMJhm+rrt2ovLOqdxD4WAe80oPNa/G
         bYZuFZqlZQwGSbdIVHweEKJWBb8jxnIRjK4XfuJStypySkehVoGLsET8X35W78pZ0hg1
         pKHhGVstSQUyo7ivOPCB+OQsVzWbgvh4/92xlX93TBs7F6JU4RhpanIuedEmmcncc9kK
         QUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767206841; x=1767811641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR8lxCkS4eDpppOQUREYlPdk8D1i+AlunKABWTpf3Pc=;
        b=H+xu2lysQlOjZGSqr/ArxCFaSbqXFcUE+tVRP0d9cLx/EcBZxG2ZCLLQPTjrxmZudL
         hw4hsXYFhNKezQjxL7ifOj5ib6hWqkVcUFeEVaqsygVwIZsoVXUxEihr9Huc6BmCXbN8
         3kwdoKv33akdrU5czTkRkxU8kjhHnqbkWz84qLPyK3p7/tEw8DsasikV3VomE96Ak4+a
         HtA6v1vd600/se8Rlq1ebEn7sjMuqa1aZTvDIl3KiY/W2bWsnvdllk/rebyS0XBhobnl
         XY6Vf6D+x2mnohOe+wMBfAQ/mvOdgWiAtlQ6MVom3jVEoYLycE/OGnz+IVo/hJmxuR8Q
         TpkA==
X-Forwarded-Encrypted: i=1; AJvYcCVL0qoAMq9ar/Nkh4N9kI9LDu2GMZjD03LlEUFjnpQ2LlXfhOmIuNyCmsTWl77pcJaNM0p3Fe88/6fAxbXvz0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QrMryt6ejtds0s9XJ8e9YDRsiZ/8CPFCxNcto9lfc9ggWWf5
	HOFTy48zT/ZG8eFKH/V+VqnOPJqzhlcaQN2jIYQiMIj5W1Unf6UfS2IT
X-Gm-Gg: AY/fxX67trwCaohUSHz2rf+uXV/UtRHV9gICxHlNxtofqjjDYUIgTwzeK5+v/yEV2Jy
	9BIA+1ZMIB9QFAN8/T6YQTuAADfREtVWpNEaCl5Y3esqh/cGuS5y2Myw/nIzarK+QYCWsXMptfL
	aDCT80VfYK0Scu4yUbrQeOYzIVpRHjZXYJsItCWQPW/+QsxGp/gdScaFJYy39pfdEeDIKq0H5w7
	x82O7F53RaHwGw81Zc5fCJ1viE9hBS6E6+wZT+5TUqKX2jocKVLePQdp10gkLgMnIwhqHeGDyzr
	1EOeCGK0vX8BnUxGGHwUAR5fuB9CDpNZNoNaU8/KaOP51J3bTgA8SvCp5e0PlYsfRTUbx5ZtrMr
	25f8TNVlI2ACgNl707feG+WbG1sIFrbJcvSctm+b+yn01/T7HsyLBKKapPG8ST10TUHpZ2HJbw6
	Sb5b6EpmVGGDD+x/S+OxLikk81+j/KAa9aE8VEhCLwV2a0Zb+sDVC7r8jfA2VaLbB/HqEnA1Qsw
	X8XQUXYGw==
X-Google-Smtp-Source: AGHT+IHEqCVRdOuzPfyY82vPKnN2kZ1OXtQIg2FDKVFLpbjMgQDZ7U+nzlNrk9xDlGuhRUgkzZ79yw==
X-Received: by 2002:a05:690e:11cb:b0:646:5138:620c with SMTP id 956f58d0204a3-64669c44188mr27285576d50.0.1767206840973;
        Wed, 31 Dec 2025 10:47:20 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bd6ffsm17896745d50.9.2025.12.31.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:47:20 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: fix qdisc kfunc declarations
Date: Thu,  1 Jan 2026 02:47:11 +0800
Message-ID: <20251231184711.12163-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qdisc BPF selftests fail to build because qdisc-related kfuncs are
used without proper declarations, and struct bpf_sk_buff_ptr is only
introduced in a function prototype scope, triggering -Wvisibility and
type mismatch errors under -Werror.

Fix the build by:
  - adding a file-scope forward declaration for struct bpf_sk_buff_ptr
  - declaring qdisc kfuncs (bpf_qdisc_* and bpf_skb_get_hash/bpf_kfree_skb)
    as __ksym in the shared header
  - including required BPF headers in qdisc test progs

Tested: make -C tools/testing/selftests/bpf OUTPUT=/tmp/selftests-bpf \
/tmp/selftests-bpf/bpf_qdisc_fifo.bpf.o \
/tmp/selftests-bpf/bpf_qdisc_fq.bpf.o \
/tmp/selftests-bpf/bpf_qdisc_fail__incompl_ops.bpf.o

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/progs/bpf_qdisc_common.h      | 17 +++++++++++++++++
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c     |  4 ++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c        |  4 ++++
 .../testing/selftests/bpf/progs/bpf_qdisc_fq.c  |  1 +
 4 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 3754f581b328..bed2294c35f9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -3,6 +3,9 @@
 #ifndef _BPF_QDISC_COMMON_H
 #define _BPF_QDISC_COMMON_H
 
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
 #define NET_XMIT_SUCCESS        0x00
 #define NET_XMIT_DROP           0x01    /* skb dropped                  */
 #define NET_XMIT_CN             0x02    /* congestion notification      */
@@ -14,6 +17,20 @@
 
 struct bpf_sk_buff_ptr;
 
+/* kfunc declarations provided via vmlinux BTF */
+extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
+			       struct bpf_sk_buff_ptr *to_free) __ksym;
+
+extern void bpf_qdisc_bstats_update(struct Qdisc *sch,
+				    const struct sk_buff *skb) __ksym;
+
+extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch,
+					u64 expire, u64 delta_ns) __ksym;
+
+extern __u32 bpf_skb_get_hash(struct sk_buff *skb) __ksym;
+
+extern void bpf_kfree_skb(struct sk_buff *skb) __ksym;
+
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
index f188062ed730..8f9b2d2cb9a1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <vmlinux.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 1de2be3e370b..524d3ae2c9a1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <vmlinux.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
index 1a3233a275c7..dd47820fa230 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -35,6 +35,7 @@
 #include <vmlinux.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
 
-- 
2.43.0


