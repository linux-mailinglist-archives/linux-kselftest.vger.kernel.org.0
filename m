Return-Path: <linux-kselftest+bounces-39664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8BB311BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DC5A2539C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBF2EC559;
	Fri, 22 Aug 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Aw86Od/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DC2EC544;
	Fri, 22 Aug 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850998; cv=none; b=TSGA8RE/fJP8lMUS+Slfxl/c7fs1G2fespuxSGeRFN5c1+yqUu4vPAXk+bj7WHNwP7wbnMBfWLjQVGZhzUwPvTk1AFRD0g6KokbtQ1YT76Jtsa38zsZVL0X3eow3so4JINL3NchvAfZQALZRbS/AwJSSLjpFVFgi5HHrcgRMatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850998; c=relaxed/simple;
	bh=5GRdMvMknEDtQxLhJ0PglmBblpugxYHK0GugaJg1PIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAOKJi7LEybp1iM/dFc4/ci4CJsq8DdeYjL+Qq4vNoySug6/4W0CKS+ikNRkFncNUfd3sHj7S1CYN0S1ttp+NCRlsLWuiUibk+zCfLtQns2lbIm+7IEQ0rwCuEKSQOmt555MWZC1vEOnlyXmt6JYm4sZfzbqbGMF3lXNev7fNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Aw86Od/f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755850995;
	bh=5GRdMvMknEDtQxLhJ0PglmBblpugxYHK0GugaJg1PIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aw86Od/fsjrieQijnYclqM5PWDqAiTAmVQaTrMwbtNwhSwuvHfvm2DJgYvL7eHoAw
	 YUILuEv70EPIlE1MAO+a4o5sCE6kzXSboqmQRZqjnRh/5byudc5X95/piGi6Nuyut9
	 YDEVbJPbaoi5PP6RD/OELr36M52nYsclRJ8MVcuRG/q1OVNls0yCS3zpUd79Fz6/pF
	 VOc6XGOYfSeCrlzMvStb3gfh+v2HDL5+3mVhwTkX+0p2Ut3FpXDmgYsrL+27E1287C
	 yHQxkFKOkkA07d+oWmY+C4K+kd+v5bSh2BuFO4mpj8bJasMALBOQnYKClV8llxNPXl
	 uWP6fHLdsqynw==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 810C417E12FF;
	Fri, 22 Aug 2025 10:23:10 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	kevin.brodsky@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v3 3/8] selftests: kselftest.h: Add unused macro
Date: Fri, 22 Aug 2025 13:21:00 +0500
Message-ID: <20250822082145.4145617-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822082145.4145617-1-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unused macro instead of using the complete verbose unused compiler
attribute. The raw __attribute__((__unused__)) is quite long and makes
code too much verbose to the kernel developer's taste.

Add always_unused and maybe_unused variants just like kernel itself
have.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Add always_unused and maybe_unused instead of __unused macro
---
 tools/testing/selftests/kselftest.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e4..274480e3573ab 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -92,6 +92,14 @@
 #endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
+#ifndef __always_unused
+#define __always_unused __attribute__((__unused__))
+#endif
+
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
-- 
2.47.2


