Return-Path: <linux-kselftest+bounces-11773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411999057E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3245288F82
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521031836C2;
	Wed, 12 Jun 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LDM6cxob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dz4paSqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D84183095;
	Wed, 12 Jun 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207950; cv=none; b=eXbr68CzR71mJe+9K73UCAdKVWA3xd0Pgh/Nxx3ZrB8miO354vx7gxiPFOZPMf1LpUcmzI+93O9338osFzd/dQScX/r+QHYSMvl0R+NmqhV75CeomxHnq/KgtcG1QXdvCU5IgCLOWWC398gEQJGTea6EVhLMSwkk66UUKvqCfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207950; c=relaxed/simple;
	bh=fBPXvgQBNpmEAIneidG+g4NUcTeJDU/Ff0Ik5m1ytq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXS55EUujan5zdqWWZDHONPWhUiodv5exrfZXt5hAXs2wBlaxIIxRvXGLZPeAxaE/VVC872zPYPU3t7EdfvuUi5wx1t8b/tsGTGMMbIqbAeI3kgRsqHraiWl/yF21hS2TIooaw3mmeu1eHwq5AnhX/2nlX+LkvT97259EsjDhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LDM6cxob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dz4paSqZ; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id CA2202CC017C;
	Wed, 12 Jun 2024 11:59:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 11:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207946; x=
	1718215146; bh=ezeG0+F5tOubWbkL94aTK4e46SIjo+JWMalcSljhHdQ=; b=L
	DM6cxob1DdyXiGpyaVE11sdCe38E3Nr6j1VJpKcZAmCn2k9j+e8/kElhCY8uRrOn
	DObb8uO6IoYaATyFciPediAgRyjKLSA/lqRkN7lfquCsdYzFOlXwqZ0sbRYTlkah
	n/Mc11cU56jce2swsigNSffbqXrskBXm4f6Z/ooPZaEH49K+pXeSXs0XFCnN2dUo
	Ov4OJI6lkoLF6jyB7dns+dlKYoEQ/kaMyDH40IXYEU3kbEGjVX6Y2mBX2w9NlyNk
	WIJJ4GelV6YME4gnUNtKnPSXDoVsaoEAFgeWHAlwPrNWehim27sApShgn438RQdC
	e42xtLrE858xh71S74b7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207946; x=
	1718215146; bh=ezeG0+F5tOubWbkL94aTK4e46SIjo+JWMalcSljhHdQ=; b=d
	z4paSqZ+m6tPjW0vwXzyQ4SkBXG+DrG5duaLPJCRqc/fC9/Msb4EnXHCcX2eILHN
	Rf60UhbqEYTorUhdG5vSzZ8NAj8gq5yUNZkK2WM1cywBftluNOAFkYAkMRoYVS+4
	22aLqW/b40ZTCl08YCgd98FmnI27RP04fxgrlxqyrC4KKpYNQqkuaGhmdiTYIn3t
	BF+4u33VC00YSsbd7Kh2MRTLDUTRlUaQlULgt/oMLSKgo3Ht+VII1CQcK0VcrY6y
	5QMzlhaAthDhylgGyRDdPsONyFcSjo+d78hZvugjzJKMGh2/FfbzVnWmfmVODH6D
	O0y8TMhZxoVIMVBioVmMQ==
X-ME-Sender: <xms:ysVpZgoQcat0NH5RNY2P9IEv3Z0_D2tlkvkMmWlAzfy26vjYCfFi9A>
    <xme:ysVpZmrsulBgmdSI4AZrnBnG-rsx6dd1cBcJwqTt8zwXcuwso-uZld0lYtJJDOU7c
    NKTJHB3IEXs6NxIbg>
X-ME-Received: <xmr:ysVpZlM9FiVScouxxHHUyjeCiyjL0Wj5gEHY5EbC_XmvV149hiPLgdf6FenlKP0lndlq2DssJoxDnqRNPQetQn9Zcov3iVzzHX9nqbd9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:ysVpZn4a-Iw_hOAWCd7vkAVizwuStrWMfEw1tUDU-0E7VtNWNPsMKQ>
    <xmx:ysVpZv4_3NnTSJAw5eJ62AdBohWrXVJUdvsBc7tZSbY597zTcRMGfg>
    <xmx:ysVpZngPVGet3ddXcWnvoRlFJjZeIHzF6eoMbZ42jOjwsbsvmLxveA>
    <xmx:ysVpZp737UlglDSS3NZlojDBx1eapNg-33Etwi0CQqcZ-zv9xgK5Pw>
    <xmx:ysVpZpuQrgsXajQHwrGaSlrRKKcXzTuz9hei5H4c6EOl4nXbRpAZB6l7>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:04 -0400 (EDT)
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
Subject: [PATCH bpf-next v5 04/12] bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
Date: Wed, 12 Jun 2024 09:58:28 -0600
Message-ID: <437936a4e554b02e04566dd6e3f0a5d08370cc8c.1718207789.git.dxu@dxuuu.xyz>
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


