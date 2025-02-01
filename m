Return-Path: <linux-kselftest+bounces-25521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EEA24BAC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CBB3A5CA1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E01CBE95;
	Sat,  1 Feb 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NyGgLoWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0UBBalsA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5291CAA8D;
	Sat,  1 Feb 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439901; cv=none; b=JgQYpP0FEPJnoWk9aNjVbPH13ZMCrNY/BS0IXRSTDwL6rShAKcXoRHtNf58PTrUEIpLGybdEheo3xx2q17U4tpA8qHWr6lIdAVBpJc9lIXJ6n/KzPTF2LgKIYHfMUh7wIQ8+O8/QE0NefpNptTi/c/RcfgLnxswzf4vWoLK3S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439901; c=relaxed/simple;
	bh=aMzznVH/zO6gWL9AbFmv3f2K5tfbw7CKAX/woLm5/R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUsWVvCLuzpXqTcdRA4FckqcGW1bx6De3FNdk8H+xrpszeTVPllfSkapqBxzwYvDOjr7aZg5WCcnDanbGicG8A1Hym46thJmBOS4ot7oqs4M7YAfcqeI8UHeQUouLxAtCDHvTQg1c3IWmUKHwM9H7ZdIT0Anfta7eYh3Pr9w3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NyGgLoWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0UBBalsA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D980A1140090;
	Sat,  1 Feb 2025 14:58:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 01 Feb 2025 14:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1738439897; x=1738526297; bh=AZLbSUWnoUE8uIP+RVgir
	KFTUDsKsR9YPNWKB5NRZJw=; b=NyGgLoWlSTwCd3F0YX514IdsaeD3ar81QoMFl
	AFdtx1oW9heABhwJrMMnAcW4AQqdWuAPr1QNScC2gHZ/gcHgqTCja0egZ1gv/JIi
	Gr+TIvYSYZkEaHD8ideTz936cbemREx1vJquNtHUR2J7uWVOabjYKC7FIkb5YjgR
	m3jjZ4IG394WJL4YvvBsturd1xOKs8nf80r9qUiEjtWo59DPiIADuKg5sTf1/cQu
	dsXDQ7ayrxVQSdMoCxjr/ZNA7y4yaFECji7tlV5BjyEBLRUAIqzi8uPJ1PRCHsAZ
	8poIHv+mj2GD84BvlTM3jY7N1pKAMsZexDtF9LV0ZkgHVwRow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738439897; x=1738526297; bh=AZLbSUWnoUE8uIP+RVgirKFTUDsKsR9YPNW
	KB5NRZJw=; b=0UBBalsAeyOw7YgIRtC9ASpsDdluNly2Um7vRruSOKS9hMV4ek3
	zIm3M2HFmbzJkdJirBfcYAGiEo8YPl74ttWC3y5lrHXg8y1X01h7Z8k3v82w0RIe
	GdOZun+g2OhgL/cniQzCQIBIPmXh1sOKXWiL+Dg967QYSpC18pukGDS7ep7bpkP8
	Y8CD3y2slOK4XiJjBv+H73gozczKyPso5e15IHYJUzfIl7rnj0etG22T05zJgsu/
	7WXJg1QTzc2GTUUUaaMK4wfFI8IQ+IrVgtbLH8538/0P4pSteBilM1d6Pg2R3hKC
	gqtBCy50khRu2NX9s2wmLXAf2BSn5mrsXXA==
X-ME-Sender: <xms:2XyeZ7PMi5K5JNpp3XE0enq2E-HYZ-79kV_5hKCPDWsjgNeYEjm1OQ>
    <xme:2XyeZ18WaTa5-Hj0dpXWsTAwc3lskLVGAvjBDQMbS4qeBQOqcV00kDL1uPG0FirmU
    fjDfBDZPEIDLZZ5dg>
X-ME-Received: <xmr:2XyeZ6Q4zI2d8aGkHDHLj9dLn8_W3nngjPtrrnCtKsz-7qMNHbbLl9vvcSSzHEOP81S3IXv_ykkzPwccgkfnSerDRSgDL3dnWOnsUjlY9F_HgfBJKYNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmhhgrrhhtmhgrhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehiihhi
    sehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:2XyeZ_vh6o6SkIAOVQ0Q4mtL5_GoqnGRKYatvBV3fo3zJlTrzmS9_Q>
    <xmx:2XyeZzd-sRorQ2Bi7ott3XWOn8DQZePikcDZx6UKP0WAMAl3VJnlMQ>
    <xmx:2XyeZ73DkmIgDGDtglgJIZuUH5DeIEYjLrRFBtj1_LW0ev49WaxoOA>
    <xmx:2XyeZ_-2Mp-S3xUDbQXmTFDxIXHfGhG3IeOUjJtppAZzsiV8gUNqxQ>
    <xmx:2XyeZ0GiEIPGl7pRtr7F7BejkEZ0XIWcvr0O0oWwTsxWJluptmwddm0L>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 14:58:16 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next 0/3] bpf: Some fixes for nullness elision
Date: Sat,  1 Feb 2025 12:58:00 -0700
Message-ID: <cover.1738439839.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for nullness elision. See commits for more details.

Daniel Xu (3):
  bpf: verifier: Do not extract constant map keys for irrelevant maps
  bpf: selftests: Test constant key extraction on irrelevant maps
  bpf: verifier: Disambiguate get_constant_map_key() errors

 kernel/bpf/verifier.c                         | 29 ++++++++++++++-----
 .../bpf/progs/verifier_array_access.c         | 15 ++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.47.1


