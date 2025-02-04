Return-Path: <linux-kselftest+bounces-25709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9907FA27848
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08B3A358A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90142165EE;
	Tue,  4 Feb 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lWyWPAI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZmFvuD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785F2165E0;
	Tue,  4 Feb 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689940; cv=none; b=LUJqjwJwaZ3Ij1W8soLZ0eqYhC60VVlrdwwbMXyCbK7mF3lQ7PTohOTiWrIgfa3buD0f8a61isAz+iaw6Wzy21NiRKTCHI323qO1jNO05LEh1VzGtrnYz6nK92SK+mFyAdVYM7C+Shoeraqexi0LwDMDkf0UZ8OZ5bBKo0QftVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689940; c=relaxed/simple;
	bh=CzxAEaYt6mG5yPMY3c3Gj/X69fVWF6dOOyrT3bPOnIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz9fxC2dgnj/p4UXboaL6zLn1V1l7Y5FOtZE1MetcDRRztegEI+9g4qMKmZlg0FWsSglV9YX1mlOauOkwWGGq0BmE50fgfVM3CVJScYdM8HL5OjL/0Q3Q0GIbC0WTP4d0PiVjwiwit6oORezowRplZP/0Agw6oorMIG4I0LW6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=lWyWPAI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZmFvuD8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BA556114012B;
	Tue,  4 Feb 2025 12:25:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 12:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738689937; x=
	1738776337; bh=TyZS0TcTPTckG42Nn/xQx55PAyOgJZDdGtzlzOuPYpU=; b=l
	WyWPAI3gydqF0IWoNBUQSmKvjvGlFEkxfakrLzkRrhftlpCkT5i9oIqNL7fMF71/
	ZkVzFqc55XneVzsvsPLsMZV/6P8TF+64fXdTIfWg8B5XYONAJ9Bm4cSUREDXB3RI
	eUH6+7u+S4zu8STU9AG3J/9iL6sXzmNouH7MGonP9BdfAt2LLK0BHYef+okh/+uA
	Q8Gjl1x292xZJpRXcRJRrH+eQqKRX/FMhDiVfIL0nmIttRSrz53KhZMgvpjTWGN3
	n1w8V6Qk76CCMkNMmAIJ+2TEijyUgbg7TNlSNlBDU4kKWZpnyYXoAOOr2FTVEBub
	WprGZXqiHU7W6MKuAyIRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738689937; x=1738776337; bh=T
	yZS0TcTPTckG42Nn/xQx55PAyOgJZDdGtzlzOuPYpU=; b=qZmFvuD8NZB4Mv7Bh
	9+v4AeBsGMBSVoLFefHZdFyCh7sFwxQ85mseeZah+PjIRgiPorjq3RsIMVuXGPQI
	UTZOJSpPe2Y60zAiAXbPUIjjZpzynPbyy7qww+a1/ruUH0l1UvNLbpjIp6tkxdz2
	SC00GgvLBCRQzATT/AM5LjEC7QvvG+JgG3bJoMJhHjoBcWWxfZbpP/CuWEHiHYbk
	UgPgPfqnX4Ot7S0APMU/syGb+/Fw2sFyrX5aLsGjVC6vJJgH+HYt9U/ccNoKazrX
	584FIItJC01zQHxM3fxzRTC/C3K+e5ttTP1RVv3nRFH8c4NCtgXWIPc1BIaL4yQL
	9Mygg==
X-ME-Sender: <xms:kU2iZ-c7Hk6Wa1_i8xoYMEA-vowAmj9NKKTKUvuHNBJYmcWm9xrlZA>
    <xme:kU2iZ4Mnmz_LxJk7k0sjDQ95ag7M1b0uEgAXc5KZqOU_ato3vDsNf6CoJb6WPlBsF
    Hew2V_DQlKKHJ1Ozg>
X-ME-Received: <xmr:kU2iZ_jcs3i9BGbG3ofIRNEk8sgiowGn8IohGbVPwv30WCQQVmnSDOtetidITr_i5uRdSXV_fXRBQWLqOzO769-lXTxrPaL-2u97MZIY98jiZJ4-XfAH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrsh
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsgho
    gidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhl
    rghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kU2iZ79RnwZCA2Qy-TgAC_Z67zKeZWyUGs2CAdtD2egaVUAv0ZbMDQ>
    <xmx:kU2iZ6ssny-YuuAaDUVv5qD0XlWpzw-oOHzLx0sBYhSWhkngL2N0dg>
    <xmx:kU2iZyFDckEukgJwO86poXhgqgWzYH_4mfp5VvAxcEFTeAu-tqfYsA>
    <xmx:kU2iZ5PM_3igOigVi0Yjmmk-QM4A4S-k30aEL2Etd4UDN93Zdwad1w>
    <xmx:kU2iZ6S0UYqbD98_90V8gDyoybQh88ntx41AVkZeblKSwgDWJROWsFh8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:25:35 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next v2 2/3] bpf: selftests: Test constant key extraction on irrelevant maps
Date: Tue,  4 Feb 2025 10:25:17 -0700
Message-ID: <c0590b62eb9303f389b2f52c0c7e9cf22a358a30.1738689872.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738689872.git.dxu@dxuuu.xyz>
References: <cover.1738689872.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that very high constant map keys are not interpreted as an error
value by the verifier. This would previously fail.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/verifier_array_access.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 29eb9568633f..0a187ff725cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -713,4 +713,19 @@ unsigned int non_stack_key_lookup(void)
 	return val->index;
 }
 
+SEC("socket")
+__description("doesn't reject UINT64_MAX as s64 for irrelevant maps")
+__success __retval(42)
+unsigned int doesnt_reject_irrelevant_maps(void)
+{
+	__u64 key = 0xFFFFFFFFFFFFFFFF;
+	struct test_val *val;
+
+	val = bpf_map_lookup_elem(&map_hash_48b, &key);
+	if (val)
+		return val->index;
+
+	return 42;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


