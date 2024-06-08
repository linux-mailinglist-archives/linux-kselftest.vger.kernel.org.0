Return-Path: <linux-kselftest+bounces-11496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBC901388
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243221C20C73
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994446421;
	Sat,  8 Jun 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YymvjcuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kodsly0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FB45977;
	Sat,  8 Jun 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881395; cv=none; b=P4wsD7D+/9mdmr5LAbiz7Pk3PuttPqftxNI/eoAVBZZ3BgpsNBl5QVjt9HfStY+J3eCzqu8K0RXHIeqAsoECgGWrG6/8bEUHLPShI8VJs+Duj+1oxpjMerS4beFpfhxdiaV/mSgBxS06/ClYClXWVYkJBfgJBSouen+9LoJCsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881395; c=relaxed/simple;
	bh=C20nHI0ZVkHtBEeLzwSZvfHbTdqmLiDwww6U/jfCpnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH/yDCw52vVlZiAWlDwIiCzGcEhDYOx+sr6m7VX2gxlvlA/vN2wczMPmf119/hnOpwLJwIvJdylcEv3uCT2L2YK52eVdg1ADwDEzkdaE8bzVpDFASEjtsCM3rRIcv8LxnhCuhySxhjOay06TR12sJ8Vf48QN85KZRs9YxpeeTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YymvjcuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kodsly0W; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id F3DD62CC00FA;
	Sat,  8 Jun 2024 17:16:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 08 Jun 2024 17:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881391; x=
	1717888591; bh=CiQLh9M3LuA21Zq/dhBIFvJTJ6E/6gJFz8kLjmANMqQ=; b=Y
	ymvjcuHhJ7/70nGjwz27r9wY2LRsObxGnEGm/bz5FGPpsAx0HmVQBxck1CM+6XjU
	W6QOhwWxRUH5VPPoNfGt6GTBe+uoA2tOSm/z/zMbbADyAeUWFzUN6ixA0JbQPG13
	Jr7Dba7QMzVRaA9/PnpdG5SUc3/4RqVjW1j181NxhfJFtQ2hxJ3wZVXUpzduaNb4
	4eYJ7OA2A3un2I/SRjQSU0y+i1Z9tFW4zTBmzI6nYBtRm2bx4cBU0nUpqUPhMtZw
	VSA9fRCOaaQo79FOyOCySJtbgtq4/FhrqR4WflLO613bwdDVjX2YAWmWpj0RVEpd
	G2O9JFbVaDoSFAkkQBVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881391; x=
	1717888591; bh=CiQLh9M3LuA21Zq/dhBIFvJTJ6E/6gJFz8kLjmANMqQ=; b=K
	odsly0WUUgd3Yr0dJMj0oz5mq/aKLsDIShtDkW2pXGe+Dd9Wt5RJHc2IugYuYwJs
	gMpVpzlDHeMzzsaiUTQ6zXtvOAqjic3MA+JHoISEih/qVVE/9G/c/idPjyj8D+x3
	rLzICRlEflWNEJub5OehhMuwoefSL+8eqe7FMkqeFpaUudvOH3J5Xerna4CPDmRz
	3s08p7qU+mAR8mhrefLahnp25yIMS4NhHsApBtBinpFnHAq1Lqz3JCZX1ABsfigI
	o5vQHG3LrV6xUc82bQ+V9F7Cu54KB+sYAB1cLC5SiCytWmTYpP1GMP1Oj7IqYH7q
	CQkmzxfGzYCW96Glb4ZUQ==
X-ME-Sender: <xms:L8pkZvYUlHUb2PfLLGKTQ_SRH2ovPLYXmSRc4VLZVriKSu8htYsDLQ>
    <xme:L8pkZuYMoAkTLNSHw91fyTDg95WGQiQ1e0TYjHcObWUTH0jg7u7jVYOlodoIV-bXf
    Gj4X15sPCJ5yRXHpQ>
X-ME-Received: <xmr:L8pkZh96JDTKoGF6la5ThWYj4EoXA6OX98HoHjuxqi_7KF58uJUEuH3xlEnx17xOsNMfj1qS7pUkjVV-ulEiu3DwyLfEMKfJ-ElekRN2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:L8pkZlpFt7RJcHlwxPKzdGv-WbPo3v3DuwqFcd0e0jKlET7HF9pFhg>
    <xmx:L8pkZqonk9GL2joQpFWwRSJ6CvsWKfueUeg22UIT0WkFWDmbaMWkyg>
    <xmx:L8pkZrQ76e5ri7dF6NgQ4mqf8EgMD_9TCNHrIZI0EBXEKwjC2MF4jA>
    <xmx:L8pkZiq1f9mbftEroM9HXh_6hXdaT8-f9fp04qlI99Kl3ta9jRTS2g>
    <xmx:L8pkZlfvK66XncROinGRdujIbJmbMnnKLqsj29obgikaaez6ZEEsF1mN>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:30 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
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
Subject: [PATCH bpf-next v4 03/12] bpf: selftests: Fix fentry test kfunc prototypes
Date: Sat,  8 Jun 2024 15:15:59 -0600
Message-ID: <1f493cb7a7e5349f99e2badf0880b75dd6681898.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prototypes in progs/get_func_ip_test.c were not in line with how the
actual kfuncs are defined in net/bpf/test_run.c. This causes compilation
errors when kfunc prototypes are generated from BTF.

Fix by aligning with actual kfunc definitions.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 8956eb78a226..a89596f7585d 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -5,13 +5,13 @@
 
 char _license[] SEC("license") = "GPL";
 
-extern const void bpf_fentry_test1 __ksym;
-extern const void bpf_fentry_test2 __ksym;
-extern const void bpf_fentry_test3 __ksym;
-extern const void bpf_fentry_test4 __ksym;
-extern const void bpf_modify_return_test __ksym;
-extern const void bpf_fentry_test6 __ksym;
-extern const void bpf_fentry_test7 __ksym;
+extern int bpf_fentry_test1(int a) __ksym;
+extern int bpf_fentry_test2(int a, __u64 b) __ksym;
+extern int bpf_fentry_test3(char a, int b, __u64 c) __ksym;
+extern int bpf_fentry_test4(void *a, char b, int c, __u64 d) __ksym;
+extern int bpf_modify_return_test(int a, int *b) __ksym;
+extern int bpf_fentry_test6(__u64 a, void *b, short c, int d, void *e, __u64 f) __ksym;
+extern int bpf_fentry_test7(struct bpf_fentry_test_t *arg) __ksym;
 
 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
 
-- 
2.44.0


