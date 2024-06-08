Return-Path: <linux-kselftest+bounces-11497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8890138B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69AD1C20A65
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F047A73;
	Sat,  8 Jun 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Llrm7/1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jr6BhXAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB14776F;
	Sat,  8 Jun 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881399; cv=none; b=hHFg5mi25//qKnVjyCnO6l0RCaqx9LsosZTK7zTo3LcDs23W80oHQEH4YIb1LepjEVR+qgR08NNVUYYZzYNWz/D3Sg/utPUQOfiQj/LTM6WuS0g+OFWyVz8ogFGU0l6Kn0SG3MEEJ/DdYeEQlHFkcYZHUwO+Hhk5oqN0vPA6L7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881399; c=relaxed/simple;
	bh=fBPXvgQBNpmEAIneidG+g4NUcTeJDU/Ff0Ik5m1ytq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inCiYdCQKVA+l8q7UY0gO/VmtGlbbwlrkPKQ1Cg3EPIqtUnMZ42g/0x+YFCqt6yqrUwgh/yp/Cq1JSPSxu+EwHi0DmVi52ycL75cMwX2GvMHV5M9M9gKwJhUaEGPSgYkymObx+RVON52sYU8MOdvmHPVkBG44gkvDHlcSdOVuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Llrm7/1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jr6BhXAq; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 9BC402CC00FB;
	Sat,  8 Jun 2024 17:16:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 08 Jun 2024 17:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881395; x=
	1717888595; bh=ezeG0+F5tOubWbkL94aTK4e46SIjo+JWMalcSljhHdQ=; b=L
	lrm7/1aCIWsUC97UpM+oMLf1BIAE1mEUkwtS/pIwYOSo/f1lhDE5S1kedyDUh/ur
	Q8EMU3CogVenLrucqrwUDDojNEmYdOfZsXdVuY8JAReBeLGcdhe+pIH6v/I3A3qm
	L2V/FzEfiq7Fre1PTCIM8NiN3mp6xFCBGbWcbSKIL55k5pwknXenrD/Gux0L0IIS
	a4CwT8lW4O4w6+PpVAxoeiE/XbWE7O0PzMQmVwzpwYJqjC2XByFCfQ1IOOzu5jYL
	jaqnXVoUI5mtdbmaWMLVhEfoZn2LJwqoGjyoey8aVwoxSBeXJT2SmT22+sAxfx0K
	HNdx1QxY630V8QlKwAVEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881395; x=
	1717888595; bh=ezeG0+F5tOubWbkL94aTK4e46SIjo+JWMalcSljhHdQ=; b=J
	r6BhXAqvAWDmZU4rxKVLUk6Ufd8KuVhtZ5JKjxQKkxDY59qabjlFy+kSKANVx5Mg
	nvJOSzINSJKWyNhURXDfH1w+RNPuZlWU++PRKU1nA2swbNCEnd90i8viUoPMRTSG
	RoXY82feyMSDArrrhFYBZYzyIsxQIyS09yTom0tLnR+sUfocDvEejEAp52zNIKQj
	HUVaZpsOvL3QEhvvwLfOBmaKfQmKWjg8YWGKUWdKvpXo8tX1CxGYdEPnGZweLrUL
	WZ9TF7AkDY4nropAfZJLETtbQGRen/3jd4eGvfPrGx0nPyo5G7Rs8IqYDIS/EiLr
	O3KSf1rVr9DcBqk27+W8w==
X-ME-Sender: <xms:M8pkZmnJZTDrqYmScBZVfb-4JQijRwBIl2sHMnnBZyMiLnr92sYo_g>
    <xme:M8pkZt0zDRFFX9NdxlPcUB6Zd6tq0GirNl2UYfd-FQiCRzuahvz957L6TDbB-SJVt
    hAgzbIoNS5Nmf1QKA>
X-ME-Received: <xmr:M8pkZkr7U4ygKBC28HLnrPDkL1Dw55btspeKtcl3KT-AyRyy-GHPubng9xLVOPv9nPJvOTC71yHoPyq-aYOvFH0ktkamCrPgffLToX4->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:M8pkZqnmoUzyKtP-TjX3rdIFvRyAGMsroQhQANkwUpFRU01WWfRXgA>
    <xmx:M8pkZk3QOoTXo1-Tro96mK6P8Oc-CHg5QRqlbknRubAJNNulvhlWcg>
    <xmx:M8pkZht7EnIzTLlNkq5_CbbAKtLSdvDfFFPDpYPc5urLFcFzYIHNcg>
    <xmx:M8pkZgU--oVnnA33X7IouUuWfq7vPRHiJv2uQnWI9nnU60XuWhYZkQ>
    <xmx:M8pkZl70gGu5ekA00_lKkeeo49eNDhH82G1N8ZK_0uRkRorUciNL2BJc>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:33 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/12] bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
Date: Sat,  8 Jun 2024 15:16:00 -0600
Message-ID: <ca7b772eed1684909e4131599fc91a6f0ff3e9ab.1717881178.git.dxu@dxuuu.xyz>
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

The prototype in progs/nested_trust_common.h is not in line with how the
actual kfuncs are defined in kernel/bpf/cpumask.c. This causes compilation
errors when kfunc prototypes are generated from BTF.

Fix by aligning with actual kfunc definitions.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/nested_trust_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/nested_trust_common.h b/tools/testing/selftests/bpf/progs/nested_trust_common.h
index 83d33931136e..1784b496be2e 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_common.h
+++ b/tools/testing/selftests/bpf/progs/nested_trust_common.h
@@ -7,6 +7,6 @@
 #include <stdbool.h>
 
 bool bpf_cpumask_test_cpu(unsigned int cpu, const struct cpumask *cpumask) __ksym;
-bool bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+__u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
 
 #endif /* _NESTED_TRUST_COMMON_H */
-- 
2.44.0


