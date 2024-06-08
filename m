Return-Path: <linux-kselftest+bounces-11495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A7901385
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB601F21B5D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D4433DF;
	Sat,  8 Jun 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="c68s+j/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eg9jpA67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415740879;
	Sat,  8 Jun 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881391; cv=none; b=eiqFkTv5llUqrHhNyuxkTub9NQUtyUlZEZ2Nu8v2OZjb084DmSRZGcAyoR36Z7RYLcu0I1kzqOLiEB7hUXi9TlWXF4KFBqe+vygJdlx1kJDGCA69FzB8Tq7uh3SiFSqbLzcadeB6HBWlTvsIUxCklanEBFFXG8Mmb8TuXHfbpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881391; c=relaxed/simple;
	bh=DU5dy6CIqpni5W9PFs52ElMuDjzzVd6o6tdcoGpKBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thmPPH8mSifwBjXoEtsFza+wnsPxMZvROZ+0iHkGb8woieB1MHhTV7pXdMwb8mv1jy3HZzlZgAzEluCOUNmi588C8Y9j+kjn9cLPLSA1jhz3Tdc3bqcWPyR6UOQRgreqXukMpgr8CgepxWvqD6JbYoHmlPmBB/o9PE8crIv5e8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=c68s+j/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eg9jpA67; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id 603642CC00F8;
	Sat,  8 Jun 2024 17:16:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 08 Jun 2024 17:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881388; x=
	1717888588; bh=26A8vHe3UnZ6l6G9vH1BQWZU+wmQLBMUefgl7dTG5Ls=; b=c
	68s+j/Hmn7FrSX46X473w6/h/u5LolUxnQJHnTYqlOMuNMsbTS0duRbygUeQqFXk
	Lt3QgZYioxSb/YY/mdwC0GSv3dZPDGZWdGk44ZjXnCtj9eKQB+d0FJvSspxpn1dX
	xy8wvA9tgHv2GeKz964aPfJFdMWBOosRYbh88ZU/8rcf43yeIrCt2KlQmxO1V2Pn
	sIELtyu/6UVW2Oeg3ryADijddzQvE9rXubVO11OAKEwNn0F/RbkGUNyTLn+4WtW/
	Gi9aAIkG8QKLQ0FxdSuFb5G9oO3f4+6j9OWBnNnYIkCSongPWp5O7VJTVNUx8hY9
	iSRcPVBBE0v/Awu8ozuZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881388; x=
	1717888588; bh=26A8vHe3UnZ6l6G9vH1BQWZU+wmQLBMUefgl7dTG5Ls=; b=E
	g9jpA679d7bNOtU7L37u49ZL2iuXbUS86KrFv2sjTGA90SmQOPZPwbhLchumkOuc
	6aEe/+O41FRVp80UvAbH/UOcKJ6ILrbQ23MGAGcRPPTj7zeGX5vqGg0GZHaeOcHR
	CiG2c7aPGeVmUFAQni0CS5idAnLpXr/NIa9EFxtYQW9uzOr8ks2+gMovrfm72gtA
	Nq6eteIgf+Va7vqC23XvTu1Ry1Z7syVMCyCp/8AxHWoP9q91S7wUMcCKXEMAdJt9
	eYddV8QQcd3Wd+Wgv/ZJRXgzK6gcpdS5CoqhcgW8koEsmVKMTEMPW3FE1BlOjO/0
	NrzPhROOsa8nPq9CHvO5Q==
X-ME-Sender: <xms:K8pkZtnatLvWKRcg9tPNwsYVYxX3qI9A7RO74SHZzjoSFQYXsF8nvA>
    <xme:K8pkZo1Aop72fhrZinXrxK37pjVmXts5HHi88_y5sPgoaPcNLgk4Ggc4VScdc0I4t
    jRBspnHYwWHR0rMfQ>
X-ME-Received: <xmr:K8pkZjqCcBDlJcPEWQJOGGD7p-o8moSWfoAiSWXAbTpwg72zRq17T5J0vCVDskB3C2sy_T_SOCAhB1vH9atkTnGbtrZAMWXCm96RVyI1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:K8pkZtn6QrNQZyUbYXHnLWjKG78Ovjy7hYjUlv82CejO4k6tgqLVZw>
    <xmx:K8pkZr2IMyuOTGB6-JzjEVUERvGWs-2sEMttTfViInQUlo2O17TKpg>
    <xmx:K8pkZsui7SbgRLr4i8oOGbg7fvAtjuXZh7z8N_V4B04A6ms2RczE1g>
    <xmx:K8pkZvVDMqMezVYduIiFbdj6MXrQWKU3ySGZkkPCQT1nZzaCx5VpHQ>
    <xmx:LMpkZg4uDty80sV-2_aaNzgUIuFZmK-M7CFf6lXn0Hfxuup3mHFouho_>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:26 -0400 (EDT)
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
Subject: [PATCH bpf-next v4 02/12] bpf: selftests: Fix bpf_iter_task_vma_new() prototype
Date: Sat,  8 Jun 2024 15:15:58 -0600
Message-ID: <91fc7716f9ad70d226e93039956f22fd05c934b0.1717881178.git.dxu@dxuuu.xyz>
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


