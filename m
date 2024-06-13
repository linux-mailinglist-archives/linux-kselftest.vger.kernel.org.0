Return-Path: <linux-kselftest+bounces-11876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F589907823
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA122848C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0451494B8;
	Thu, 13 Jun 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AuHSE0wX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7KN7GMd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E6145B34;
	Thu, 13 Jun 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295594; cv=none; b=ns/iAVPaT+LnY3Yy+MoPaouIg2BHZ4O9aHWxF5m9IuKfCQA3yIYoHdmiSYTwSJKQ4qPJNYu206NsuAznMzP1zcGIwQaqBR0gnKLAFp6PuUg1FSvkHeg6vzPxxCKPcvzQjLig0cWRXIOhLwD02GyqNEwfTvJhExUR2vKwP3WSNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295594; c=relaxed/simple;
	bh=d3SufosQ8LT0bZ8SGHYXs1ztJ5ewWIW0QjqdtzH28Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0M9U12lshMO1Br8DdwG9wA6EAE9UPuKGnStfyXu0ZoKGC3geUnN0GO2ibyMzD/1ctTG87SyPvI7RPp5dI0Tp02yL5GwDfflRBsi3W0MRI5i+W3Wx3QdoF1Ung+EVa9uzoPwXM5sJjYiT1DkgXp4MmKeJr39QUFgxsNzR/25VKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=AuHSE0wX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7KN7GMd; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 5029720025B;
	Thu, 13 Jun 2024 12:19:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 12:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718295592; x=
	1718302792; bh=VXllBy0OPIEM37txsmqZHMLIf8msa/NYcue55B8lNbE=; b=A
	uHSE0wXiX7haWc1A6vaFcNkyAjimPaYSf53X0tie9Y275Rz0d5Nx10awqhxJmzwo
	DxKbag8tNUHdGZem1IoaDe4mtPncOJOdhbNbD3bh0Cge6NUw2e0Di+OD0ACX7uv+
	f84k1tubNdkX5tC5tjxWBPg7sIx+kPNFUmt5PX33XhMBKqBxUIye0QhqNcAl82mn
	R90uCtDg7hbSt2IYwW0+9q9qFjazKieOPjZ+plO9KDtXPTG9snXpTpcK53wGbWr4
	eJqrKJbjW86AY4mZkd4hJbcnZIwIMepZkJCsrDmxvmt1rQgkV40YZUuCAi+YksRW
	yPs/KOH+U0dERGZCjNwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718295592; x=
	1718302792; bh=VXllBy0OPIEM37txsmqZHMLIf8msa/NYcue55B8lNbE=; b=Z
	7KN7GMdgJzoqn7hDkLHdIbni4eqPA/T8LvJRFaP2iFOTwYTgZ1CnwkIbc2f8Efhb
	nyE7PEoG7leOoc5PlLlB0sbf4QipU/X7GGlvWeMAE/7rQNpronxznL3vvpiXDW0J
	04uTIhVyltrgWxQoBmMa8r/30z1Ik/RCSP+Nh/WhOJJyF08sl/+y7pJYqiy7R9pZ
	DETsLd61HoM8hv18wKOD73YkulU6xWFJf4IRQUsSw9qPOXW+9xIiz1pOXNIcrTHz
	AjOdHKi3YbY3eQbvXOJBIWJgrBFHgOscde63jSJGmEaMtxkBBTyvgYOsPubsMvhn
	7Hx7YAzXtonMi6LmKC6ow==
X-ME-Sender: <xms:KBxrZggc88fBx22-jszG00wm5wFrVH4vJV93g6NFxVuoLb9QWc1AaA>
    <xme:KBxrZpA7CJ2YNfhWdgjL4MLEHO8NpdSZwlNNr3NCy3A7X3ft_cF0xfe9K3TfFAtMT
    zY6QY70ve5Nyevg-g>
X-ME-Received: <xmr:KBxrZoEUJQIVdRRU5rk2AqGoN15-LOY7PFALzqAX9MYZhAyyVoQZM63f30_SF0c_6AA4IsEznKKvKKSdDgY-o12lonwsuTg6xHkhLjN3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepleeiudehhfetffeiud
    dtjefguddtkeduleeuleevkeejiedtfeeuuedtleehvdefnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:KBxrZhQNBUQ_aaBCBymQJmlTHn8di6vZBkihe38Ru6j-fq-h4Wv3Ig>
    <xmx:KBxrZtxNmiKykVhSo_NykiI-moc9_mgSQARPqKxOPU047p4-c5oMtw>
    <xmx:KBxrZv5qXW0lmwUzgyH3j5FloabEpRJkbcuDP8P6bdv7tT2Di6GT0A>
    <xmx:KBxrZqxTrNdmmhAB-EAJ2DXYtRtMMwa-5qliN-Nxp-5peju9IlBOSQ>
    <xmx:KBxrZkjaDo_yWGyXKfIsQNbRMXWzwMPJA_vr7bE0anIsxyClBShIM8L_>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:19:50 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	nathan@kernel.org,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	"sfr@canb.auug.org.aukernel-team"@meta.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next 2/2] bpf: selftests: Do not use generated kfunc prototypes for arena progs
Date: Thu, 13 Jun 2024 10:19:26 -0600
Message-ID: <fc59a617439ceea9ad8dfbb4786843c2169496ae.1718295425.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718295425.git.dxu@dxuuu.xyz>
References: <cover.1718295425.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When selftests are built with a new enough clang, the arena selftests
opt-in to use LLVM address_space attribute annotations for arena
pointers.

These annotations are not emitted by kfunc prototype generation. This
causes compilation errors when clang sees conflicting prototypes.

Fix by opting arena selftests out of using generated kfunc prototypes.

Fixes: 770abbb5a25a ("bpftool: Support dumping kfunc prototypes from BTF")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406131810.c1B8hTm8-lkp@intel.com/
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/arena_htab.c           | 1 +
 tools/testing/selftests/bpf/progs/arena_list.c           | 1 +
 tools/testing/selftests/bpf/progs/verifier_arena.c       | 1 +
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..cf938cf8c11e 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index 93bd0600eba0..3a2ddcacbea6 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 93144ae6df74..67509c5d3982 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index ef66ea460264..6065f862d964 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-- 
2.44.0


