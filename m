Return-Path: <linux-kselftest+bounces-18478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063898861A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11A9B219D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32118D650;
	Fri, 27 Sep 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAuzruMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22A189502;
	Fri, 27 Sep 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442852; cv=none; b=To2oiB6Xx1wuae+DkaDUU5kh56lhwPiEYALPup3Qd6kaK7bB3/s031tMpvDTCKFgipq6vVJzzk9V97uJmeO8B3n2YadmX+6/EfnNMFBb6aL1AOubW2I+NbzkUolkhsztaweaLs8sA+m+nN9mL0MzlJZfAdoc4Ax5xFz9QzfwatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442852; c=relaxed/simple;
	bh=8pMZwnUpWYbMv5a6Ys7FBJs8RZEhlrFBSSH8QX77gP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7ir2z/ToqgIkAdEyMKHzLk3tyZh7kNvCrztN0lhJy8jg/M/ZkYgk0v9UaEWCQ8IlW6R7mM+adsoIjTCO17jl0kqlxjRD5Ks788F62GOYRe7lR+RNfwr1cePonDjAXhiZUlt8H0iWcTO/3csJ/qSkExz0UHcCNZvSXsDBgojrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAuzruMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F07C4CEC6;
	Fri, 27 Sep 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727442851;
	bh=8pMZwnUpWYbMv5a6Ys7FBJs8RZEhlrFBSSH8QX77gP4=;
	h=From:To:Cc:Subject:Date:From;
	b=NAuzruMaylwxNLXYEombG2Q63XYZuh7ra2rE41KnwWlD+3OY2aUP8oDj1p8SNEj2d
	 mgZpRubwXSN4IH/noP/GcjUA8swurAkiJJNsT7XQbhtGThlSZimsNRY2szPjj8Zrse
	 fa/v/cs52p0ghTTQMxbXpa2Cg27wjCAg1bqMGHLq2KozgJWlSjOLcFEDa6ZPsIBlI4
	 pe5FLNHI+LEveVLIqDHWoG3/z4KYBTumN15mYCYSpNnBAq9rg4PCL1oxRsKqnw11Mo
	 vug3zOxvrRbxtcDtTE5DPFGHXlueB0l1FJDFv1tM5YKl/Kw3ac46aS8fWFxRh8MSmb
	 TPGT0AUvT651A==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
Date: Fri, 27 Sep 2024 15:13:52 +0200
Message-ID: <20240927131355.350918-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

libbpf does not include the per-arch tools include path, e.g.
tools/arch/riscv/include. Some architectures depend those files to
build properly.

Include tools/arch/$(SUBARCH)/include in the libbpf build.

Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 1b22f0f37288..857a5f7b413d 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -61,7 +61,8 @@ ifndef VERBOSE
 endif
 
 INCLUDES = -I$(or $(OUTPUT),.) \
-	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
+	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
+	   -I$(srctree)/tools/arch/$(SRCARCH)/include
 
 export prefix libdir src obj
 

base-commit: db5ca265e3334b48c4e3fa07eef79e8bc578c430
-- 
2.43.0


