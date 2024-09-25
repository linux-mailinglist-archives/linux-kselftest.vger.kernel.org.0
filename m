Return-Path: <linux-kselftest+bounces-18346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E3B985AD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E61B23091
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C0188926;
	Wed, 25 Sep 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly7QgBXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16C188907;
	Wed, 25 Sep 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264758; cv=none; b=jc8oGaixDjZdeisyJNY8LptUbNWfWGNM7pDM7mcv94uxO+gQCHAXbbb6xZuO7zD26pbG2oCy7ZmroggOobZf1C13ByspN6PW/g9xIA+7XNRIGKX5Jkf6mSLoKCsgDBNuA7B8AYiTQ+9p1RJsXuGUmIZmwTAgkVxxxZhkkXu+09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264758; c=relaxed/simple;
	bh=k9RDrPj+Z2firOORPKM9HyK8UpTlqYHTGGRiT3jYDFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUkopRbNbo2VboBeuZ73JpaD3JYtK47nqGZMfkd7kwHU5jJQQvuwaVU0AWgGH4U3qIlrVB8Ab1fz8uMt549jNhlYKfFpcSd9MULRyaCCkvmHdqYbt6s05PMMA5znzjID5C07BB1dyT9INfpxpsPQNXmEelp89TLceUx12US2AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly7QgBXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64329C4CEC3;
	Wed, 25 Sep 2024 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264758;
	bh=k9RDrPj+Z2firOORPKM9HyK8UpTlqYHTGGRiT3jYDFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ly7QgBXT28jlqT/UK+RDgO6Jt/ynuKX1WOPRdgAiNWr6oh0eFEGPa0rivNZAEYUvV
	 a1xcXZ2l3iaI2zCAkYcednxTtdIQya9+oJ1hXWjG68A11kLDNyveHW8ueRymGkfGLB
	 lzS685/WkeJPaKzrchyDT/QQ6vdqoEAl2LNfxLKMsLI44BJ9pe38LVkFlhEPidpF4s
	 7zCktnKur101Z84fZaehXVSY6Ys0x3k/kA/Ud49JJbGsZFPSuYIurAejENGwJnecp2
	 yoXiwiztE+8VgkUmubKlbUaHf/TNxkeh2PXTicJEZ39h8JsotMvTezyRUEcoQFbu5v
	 0CXPFzM+7ojdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	martin.lau@kernel.org,
	geliang@kernel.org,
	bentiss@kernel.org,
	jrife@google.com,
	alan.maguire@oracle.com,
	dxu@dxuuu.xyz,
	davemarchevsky@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 147/244] selftests/bpf: fix uprobe.path leak in bpf_testmod
Date: Wed, 25 Sep 2024 07:26:08 -0400
Message-ID: <20240925113641.1297102-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

[ Upstream commit db61e6a4eee5a7884b2cafeaf407895f253bbaa7 ]

testmod_unregister_uprobe() forgets to path_put(&uprobe.path).

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240801132724.GA8791@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fd28c1157bd3d..72f565af4f829 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -477,6 +477,7 @@ static void testmod_unregister_uprobe(void)
 	if (uprobe.offset) {
 		uprobe_unregister(d_real_inode(uprobe.path.dentry),
 				  uprobe.offset, &uprobe.consumer);
+		path_put(&uprobe.path);
 		uprobe.offset = 0;
 	}
 
-- 
2.43.0


