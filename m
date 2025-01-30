Return-Path: <linux-kselftest+bounces-25449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54469A23745
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503743A2321
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBA199EBB;
	Thu, 30 Jan 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="4u2cZ8hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w0qeQ0xh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDE1465AB;
	Thu, 30 Jan 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276451; cv=none; b=sz0U6XdhNvBuBivtqd44k87pgLCAEh9yC0/UFsT/v8IAUWlAJ4QdtSjuJsjGjgAuZniD0xIHNXRDtBnow4fmaXHOtNh/wpOSGC5Voslw4X5CaS2czxNzeVttApP6mN7+qBrkLH4f8VPN0JxsEFQ5/e6zKbRRrwbbSX5VSXLbTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276451; c=relaxed/simple;
	bh=SBI0Gy9KUpzrrtm5Bgw3GKLY1+5MIQEuxMKqii/TIcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqnwubWVMoPPmTe0onB4Xp46RTabhzIrPce/V4/1tAwBEPVd1ibaLgiio9JkkBzagGmVInI4xxdJqDsiJN8FiVX1sLruBdQvErXQaI81B2iRhFGZ0f3XVaKPpHC6A5oxyK27LgAZLgGqCzYSae1Cmh/iG2zN2PWVIIyhmEbutJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=4u2cZ8hj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w0qeQ0xh; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 2238F1D40D4D;
	Thu, 30 Jan 2025 17:34:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jan 2025 17:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1738276446; x=1738283646; bh=pYA5QQ2gujW7NKTZMydkI
	F3TfLqgo5o+zoRfFMxUleo=; b=4u2cZ8hjS0JGuwpIDpefzkUA+sq9dWUSJfY3B
	tkR7nGgog15o18cS3pO7A1AV5ePNoj0UN2RjHYucnx2lWZnwFUAHVwrVk/68ZKcH
	yrtLGStZlcOfw8VUM9LWzs1ZUpCIwHppZjj9yTkrTT5myEf92e/tOW/oEwmBBsgj
	59ZdRwNjdb8ciCYRI2gGfxyhaDMpAzIkyN8uBLlc6GcIdakdbmjyWCErd7fp9dpV
	VmSOXFBWxMUrgdLSGPjAnSMJKjNMsEVouta5hLe5or7BOYLuIYZsRbxq22ezX2mu
	qPAyrf9MGxULk4AffQShCdwc6Aojklv7xO7xc0wV1UeLOix+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738276446; x=1738283646; bh=pYA5QQ2gujW7NKTZMydkIF3TfLqgo5o+zoR
	fFMxUleo=; b=w0qeQ0xhO7gK8Gk7umXljf1tPU2Qoq9VrZDo2B0TulUXub0XOCz
	go4Kr+mkC8/oSPFcySFSwka8oUucp/LO0gEonRTM5lAWmOQ6KRdic0TBM+nMlwt/
	0kg/rL85KM++S//Y5AkCJYnGOVfAaWWJMi4khKAplp9h5Emsnp/QdP71YqJ8mcRy
	A7MuXGBxHibUWIYBzBCPmci+RhyyRdLMwx5/oJvtfHA8pdljwy4+Tg3zkt1l99vl
	yRHwPqJevPaPzI+qiLRLR8Tc5DakjPiSKJEdyvIbrO5Ge1VyjVfJ9tQM+1BiJsFJ
	c37M/j7kKjdFiCrEMtIQPJQinvWij201wfA==
X-ME-Sender: <xms:Xv6bZ0p9k0Gj5MNxpb2Y_5wOp-e5GdhxEP-Pk0gsQRDROrMBTzMFpw>
    <xme:Xv6bZ6rwimJfJ_hrE30_abgkMw4BTaujkQ-2kbKz9RHJD48i-l2fQ0MzisK8ip2gM
    MvWRI4GxEWbsbS93A>
X-ME-Received: <xmr:Xv6bZ5OMeQnpb2VpefvnX6-j8DNGTwMVpyOMOrTxlOELJe5g7qYfFL9cbCsf_E9s1HFv985gsG8Jpt5VTW3Vcy-GwNTq4yHs1PAp44VNArQgP1YjCLhF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthh
    grnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhh
    ohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:Xv6bZ75YdJMsDtWl2x4mtYZrzhoo8sDlVNvgLzUw8esaJfEc1_xyrw>
    <xmx:Xv6bZz5BsB9hFnvDXetb0uoN5jRlPto2Rm3_UmhAlt-OQqiaCsCqrQ>
    <xmx:Xv6bZ7gXuEIefgA9NZJZGZS9_EN_eiFm3oIa9Gc1h3vtXIiydB9RvA>
    <xmx:Xv6bZ9767q2HgJpX4o3JCuNmZsaiZV3ECAaRhMKPCHs3reMT3QPnWg>
    <xmx:Xv6bZ9vwx9199PgLQiqGuO7gd6Dh9AUHuyDb3vRPc2c_ZbSJtJNFvsNs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 17:34:00 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	nathan@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: bpf: Support dynamic linking LLVM if static not available
Date: Thu, 30 Jan 2025 15:33:45 -0700
Message-ID: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
libraries"), only statically linking test_progs is supported. However,
some distros only provide a dynamically linkable LLVM.

This commit adds a fallback for dynamically linking LLVM if static
linking is not available. If both options are available, static linking
is chosen.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6722080b2107..da514030a153 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -184,9 +184,14 @@ ifeq ($(feature-llvm),1)
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
   LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
-  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
-  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
-  LLVM_LDLIBS  += -lstdc++
+  # Prefer linking statically if it's available, otherwise fallback to shared
+  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
+    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
+    LLVM_LDLIBS  += -lstdc++
+  else
+    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  endif
   LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 endif
 
-- 
2.47.1


