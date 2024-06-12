Return-Path: <linux-kselftest+bounces-11771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE739057DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B36FB290EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482C1822F9;
	Wed, 12 Jun 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nLo951JC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PglkzpGv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BA1822EA;
	Wed, 12 Jun 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207943; cv=none; b=GDX4uSb1ZCmqlAvtmh0NbCrRD0HPPmWqbP7Ql8LBmI5MV9htZy95jBCjXZ/AjrUzmDatnm6k5LuQGGYk0t+8EFzIQCYWZ5oR9F9tmFznrVlp5wQmt9mqf4ICUDJCXyYHZWrjPAkCp/7Q3F+EPs2y72NbE7rm0CNv8OCaAoWuS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207943; c=relaxed/simple;
	bh=DU5dy6CIqpni5W9PFs52ElMuDjzzVd6o6tdcoGpKBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGkviKkvP9Xs0/GE1qAgA9pUwOxek8/XCUhsmUnPIJSAdhQKBFoEZOYcDl4R6Q5MH/MZCm4vEdP6VChAQJXUk7eBl6U5aVDwdxVLdI/0xtSiyMagkwX2KZSqroHE/ZGjrLlsV/tUEBwdVvMwnbNVLalOZRrgUPzsCELnNcpBkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=nLo951JC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PglkzpGv; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 5ADB22CC0176;
	Wed, 12 Jun 2024 11:58:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207938; x=
	1718215138; bh=26A8vHe3UnZ6l6G9vH1BQWZU+wmQLBMUefgl7dTG5Ls=; b=n
	Lo951JCsqOjYBdqjdP3LqPsEVcWFBOh0OA2tLfbm9AgbcgpRwxtdWxGVqXq03fYw
	L+WJmGOFcmic1f3A2FGmBKU7utLlWe2JfM6hsZTXpQIbtX3fr+ttni5VJWhfz5Iu
	XmvyftWdNfek+LiE+T65iOQOLOV009G5Kfb2sR/DM9En3ocbpjL4vhbCWvsc9l+v
	kv66lAPqhr6JD76nsmMY9VEs/VLjxzsDYsb92broxxiXn5r5Ic2hlOZXIzjRcWi/
	aQtzi0mmM5HJOSQukI8wbkAiVKFC77SPOWJieNh+EJhiZuabKWnxNnw0iSf6yEZt
	sQA3F1LpBVE1LzvjoGW9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207938; x=
	1718215138; bh=26A8vHe3UnZ6l6G9vH1BQWZU+wmQLBMUefgl7dTG5Ls=; b=P
	glkzpGvBa05uXg59J7e/nEm+975auHXc+fe00AhapF/BjaskASE0TReX78vofvaU
	Y3dFBOv2892nb5nAIEXSYeP6XXOZge8+nuwz/3RbTrKNhhuAL/soHaZA4bxuDfn9
	Dw40zSXeIigD8toiSKgQQ0AiEfDm8OfctimfLYJa9OAFYMX8ZnlXjqsYY1Q0OEJa
	0iiyXocYUzU6fmLXgqteSimWS1km0JLpA4+Etha9AnFDal2DJTkEhBNIdXf9lwDg
	xQk9gcPLQ0DAvCauSuNKEg6kjB18PjqRNSroxOhJ87ufqDTJHBMxRWjjTTONvxxu
	6bsK/XZqOpsiLKK08MY+w==
X-ME-Sender: <xms:wsVpZpFXK9iwKAQiJGCtq0IHHGE5pxieqmKbXtIi1l-suF_mDA1zKg>
    <xme:wsVpZuWqwrrrkc8mJ3AfCPL8DnEHbakyVjysXT-ezYl_Wl53-KwEfFzOTbotH0X1X
    bQwZD4MHtUUM1NWrA>
X-ME-Received: <xmr:wsVpZrLZ6ILBzHZYFOuOI5Z8rXPAQi9v3Wj8VfXRGRAyCe2PRGl-Cghp-W6zQSJNG6k8nNleulteov_8cpDSq84fng5Hy3654gJd9cQ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:wsVpZvEItkH3klk2ku7mc--QY1LU-Pe3_tGsmJJW7ET5q1jAGznagw>
    <xmx:wsVpZvUY-v7wNQZ1H0VoZtYFVC74GapkCY2kEy8LSBTUuEhAerqPBw>
    <xmx:wsVpZqNaqzseaa5Oc1DdbjMRw8-v8Vvbp5RNPKOB4RwrewGSmYmXKQ>
    <xmx:wsVpZu2aRbZchvXbjKjRPnaGraC8AbDR0i76O1BxHdaDklVsvprZIg>
    <xmx:wsVpZuZudvAl7dP1ripCjeVBNIiCtikAZzK45dhIiSx_S17JsvZctEw1>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:58:57 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 02/12] bpf: selftests: Fix bpf_iter_task_vma_new() prototype
Date: Wed, 12 Jun 2024 09:58:26 -0600
Message-ID: <fab4509bfee914f539166a91c3ff41e949f3df30.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_task_vma_new() is defined as taking a u64 as its 3rd argument.
u64 is a unsigned long long. bpf_experimental.h was defining the
prototype as unsigned long.

Fix by using __u64.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 3d9e4b8c6b81..8ee7a00b7c82 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -163,7 +163,7 @@ struct bpf_iter_task_vma;
 
 extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 				 struct task_struct *task,
-				 unsigned long addr) __ksym;
+				 __u64 addr) __ksym;
 extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __ksym;
 extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
 
-- 
2.44.0


