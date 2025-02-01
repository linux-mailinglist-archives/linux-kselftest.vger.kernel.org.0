Return-Path: <linux-kselftest+bounces-25522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7705A24BB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E866E3A628D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF61D434F;
	Sat,  1 Feb 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="d6bJAWqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsvQOi5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410341D151F;
	Sat,  1 Feb 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439906; cv=none; b=qfJJ/ptKASSVLvSfyo6/S6OfF/Jw6snei9KfVHyll1+RC83995re3Z0SjocFlBxB/w/TWfCJSp7b2L7KUEf11lP81aGttLDrcCaoJtgCmsiPXM4jIeDu1FH0FYE6+h7LkDUzpOzQg1S1pSftwNnd0jb6bwaf44TW/+NMw32+tLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439906; c=relaxed/simple;
	bh=M8s7IqSxHfrB7fFre1WVBbdOEA58s6gNXQoH8hf3SDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obJq4ztBRFhv5ox/oMHfJXKOs8pq60Ac3P6wcD7TA6KIQGKuX/S3JXg7V0AiURbs8pI0mEfdtEH+XTtONOY3GnQvwCNOcWKHhoG1CZwtM7M6mhCv/OVKl/LdpjlHzhakV3ktADKblOZqewloIRNEORjZIGvjfBSPKtN+0po3Pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=d6bJAWqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsvQOi5I; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D7A11140090;
	Sat,  1 Feb 2025 14:58:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 01 Feb 2025 14:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738439903; x=
	1738526303; bh=ws5aTwt92i+jLTIShvXJrsRXjDQOQ6p0zriyk6l9RX8=; b=d
	6bJAWqyu/4/5Nf/rUIqUCBL4QT/XCnETshQyIpZ3BPBGfPaEmn9/R/RGnM2f7n/R
	3FFB3ppUUD/0acQloiR7V8uZSLHqYQHrMBOj4IG047y9ZNSCcLIEyV6Zq88LARU4
	XeGH/2Aeao/bvQuaM63WUJHe64xPet6rXRDTs6q2LiHLEpRjQN6VYDn2fCCnHnsT
	90ueCw0LRsZJrYsTf3zYY6Z7Mixn09w29BU68/G5niricowbFQeokv7uwwv/06/p
	4jwaVjj9YhjcCsfnfeLkqC3G4xrlaa87ak6vK5ZAW/EEMMFQXo1tUq6ndWLWuAQE
	Ch80rZbjwRIDYVfgvf76g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738439903; x=1738526303; bh=w
	s5aTwt92i+jLTIShvXJrsRXjDQOQ6p0zriyk6l9RX8=; b=EsvQOi5IuhzddvvX2
	WaFadPRnfG6bhGLinIZFLuPW6s1VmfGn3HegaE68lMSTXnERxszSXySNR0A86noH
	YiWCQ264f9wOKZ3Is5SSybVZD2YLSvphnbDhq4dcFwEcTFbBedmmPkta4tUjKiYA
	18DmnwZO+QknpehvqmX+R4mmi+3/4TNksdcty781ZkeFipRQitiscuPQuHbDTNHp
	7ufiAQsnBc3kN/O401RuksWBmJ/fdO2YbCtrAn8aOoo6VUfYqG1d3inWzKL+xygq
	xI5mm7bebvw3x+rXb5UcYIKQtjMQ6ip672AbbAhdo5TxD9TBkoLDBUHPQsWjNChG
	VckaQ==
X-ME-Sender: <xms:33yeZzLwdghTQ1uKw1DclcMg6jw8Lq-CwSzL2YCUt9L5ld_tENadhg>
    <xme:33yeZ3JNf4hFQQq3de-BTeKIV6Xrn8tSHYupBDC-K4dSRRb9Ecvg6_VNUK5pqk5EV
    5eVNlTOCGKty2uGzg>
X-ME-Received: <xmr:33yeZ7u9QLY8WKQGlp8CduRahUOi-gP0b2BfCY2fkSbW1c8s9rdNpsHwXzazailX1H_KYlEObFNp37sSD57Cifu0fzgl8yZnGsE9Nal_Jp0-WDnGNYBN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoh
    epvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhes
    fhgsrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhh
    ohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:33yeZ8Y2ThsG9qnrb7PNkNM7TQ6nhPVVTgJMnstdjDQC0w_D1WnkOA>
    <xmx:33yeZ6b6TlTFnlybjBYqfXXMxOgKZqgjez-NodUrK9AEvUF560L4tg>
    <xmx:33yeZwB5wGDjmkNmHe_xUK7MK3DRJEqLXbkrDrBaQSHsCsSOl-DANA>
    <xmx:33yeZ4YWRx2z08BcnhL_ssDnMNjHOGIEXzFfmvxtl4oaO--h5xo54g>
    <xmx:33yeZyNV5UuruVHsVCdZgoNgmcGrp6eP2yUs7b5JNCQwdBGh2w5v9eF6>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 14:58:21 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next 2/3] bpf: selftests: Test constant key extraction on irrelevant maps
Date: Sat,  1 Feb 2025 12:58:02 -0700
Message-ID: <d6f48c9cb8b7981fd037a19a8cfbba5def40f2ea.1738439839.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738439839.git.dxu@dxuuu.xyz>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that very high constant map keys are not interpreted as an error
value by the verifier. This would previously fail.

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


