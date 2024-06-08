Return-Path: <linux-kselftest+bounces-11499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8017901391
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3290FB2189F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7B4D8AA;
	Sat,  8 Jun 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="pehgn/dF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvseUzVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7B4CE04;
	Sat,  8 Jun 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881406; cv=none; b=Am6NY/4vbF53JbKkMLhBvfk8ygcqEvNG+hdGt0dBbUZPGKCMVO6d7TqBYcj6WhNw2QEINiv5V2ukzx8O0RjdJUGL5qiFqKBWbaw7eKuVeRduYUbnf8Lr89NXl3iz3MgaNJyrsYnj+cxoBcnAG/veHvigGqo8Yv9879wkxtMwGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881406; c=relaxed/simple;
	bh=wanEOrTfLhQjXxteqyG7oIdx67CSb0OM3DUowxi3Ft8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5LapoDG8/Ku1N1BAo1+QXBBxQeKzd/Am1Hshdur0UxIIRPwujI0EFR4tzq54ETZPXsTwNH0FVv8OFz75DFBkG8GzrMDk9Ik2x2c6BYG0NENRPdjcH0wLioyOjhvhkWLWybISlYFbfsrUQgVUhlzD6ggOxolMUwiz4/MXKSuAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=pehgn/dF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvseUzVC; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 1DE9B2CC00F8;
	Sat,  8 Jun 2024 17:16:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 08 Jun 2024 17:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881402; x=
	1717888602; bh=dLI58khaaOksRM7qlvJcsyH3aC85IQuRR85SwV1wvsg=; b=p
	ehgn/dFoavFd8PjnzSD2kBTpTLPfOraAa5glOJjgbmW4zj1oVbPzFQ08NuuPRuNp
	55y0WQauQGrywjL+UxclLFxsYc1h6piTwJ6w1ML623flPLwuc5raSo8nDBUyqTqs
	4IYqyUXPYjHizs3ZsIYDjg0cad6nybhAM+8zOJNx0PK1mYtOGibu2ZU0yhFWI/sy
	YwHu3bTSCu1B8+6agcVpO5/94ny1viFYEWU1L0no5jYDUe0FAkS9P6VzzFI2486R
	NJjvlOeGPVd93+FPzmDrXyZJnh3ozM8pquWsyxEqNKbQrhz6lZIH0HQZv6Pdtejf
	MqqfoHuMVC3tTCWVjlSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881402; x=
	1717888602; bh=dLI58khaaOksRM7qlvJcsyH3aC85IQuRR85SwV1wvsg=; b=c
	vseUzVC6L5PfU0ZB3Ve8KXqt2i037KsTBLjYx18jyHXNq4VdZbZQbxsEfW9ieYEm
	0w62WskzKIijady0H0q14HJFkg4RODE6aRPXHX9soJ4Utq8r/rx64S2Sd5W4Qwhz
	Jzh3rth2+V+zfOCYqxA7h7/dE29dzaaihN9ZWq4kP5nUhqU1KH9oW78dBWyyO+oa
	AfGVsrkfQ8d5cxLmu13GWOjbbA3oz86rUlgi37BC4AydjZZhkeYnq/A+MKLtSBrM
	Vasbi+WrBYzq9BL6rl3zZps6ibTcjeM6vusdabFbRjjOhlx4w236XIZc5jtjbi/l
	30W4OqkncIybpu5Ts48xg==
X-ME-Sender: <xms:OspkZmspMGYS8wFNko7sS226o7Zoo61D6hdxSdXHen2ALj7OL-brWA>
    <xme:OspkZrfgUQiXPaQ83QmVXncMW2Xa9Tq0HxVDZGU2SalmKzRrP46ptusLuNCZwAxbE
    6yQLouBQ12T_dleoA>
X-ME-Received: <xmr:OspkZhxw1ez5GwinnBSNqvV01PJpUoGv0DfiC921bd3m9NHM7zVs184sx-79hEtQFanPNYcbghito0Kv6f5T4LpB6AUOtwzSy3jk8o5e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:OspkZhNQTYC6NTri2u3rTgEuq5c77i92R1_sdi7WtizGU4Rc6G6mSQ>
    <xmx:OspkZm_uo570FH_L_5jmojUNdkEuFfkHHD-5aICFK12TcbiiLRVZNg>
    <xmx:OspkZpXbPmXXKrERfKMLOy0FtzqUHVhAMOI9odR_at1mPR3iXS5ztQ>
    <xmx:OspkZvftBKuFUZeO12cAgUkg3_vG1dUWCV53lWGxJsByGrz6NO-RhA>
    <xmx:OspkZpgMCMI2PER0lLGK3JppRjReq-Eia_rdlhhrkp5--DZYFmGOCaOu>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:41 -0400 (EDT)
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
Subject: [PATCH bpf-next v4 06/12] bpf: selftests: Fix bpf_session_cookie() kfunc prototype
Date: Sat,  8 Jun 2024 15:16:02 -0600
Message-ID: <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
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

The prototype defined in bpf_kfuncs.h was not in line with how the
actual kfunc was defined. This causes compilation errors when kfunc
prototypes are generated from BTF.

Fix by aligning with actual kfunc definition.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index be91a6919315..3b6675ab4086 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 extern bool bpf_session_is_return(void) __ksym __weak;
-extern long *bpf_session_cookie(void) __ksym __weak;
+extern __u64 *bpf_session_cookie(void) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index d49070803e22..0835b5edf685 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -25,7 +25,7 @@ int BPF_PROG(trigger)
 
 static int check_cookie(__u64 val, __u64 *result)
 {
-	long *cookie;
+	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
-- 
2.44.0


