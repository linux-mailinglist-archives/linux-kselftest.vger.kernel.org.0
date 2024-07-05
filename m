Return-Path: <linux-kselftest+bounces-13237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45FE928A08
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC071F22EB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE5154455;
	Fri,  5 Jul 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+jHveHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6414D2B8;
	Fri,  5 Jul 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187107; cv=none; b=Q9sphdWOmTt4AxlKdTZWwX7ZP8hVrZFwJSs5uHvW8DWpSHptNFnN7isf1Sjm0K9ynPjCw3vc6yQeqeqYw32X9aiySOYhruAy4sln8GRcoc/ahOGBoxLJbQU6m8RAzb0x11019SIAdJ0OwaKzLfjKRuuBSgis8areGH566h/r7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187107; c=relaxed/simple;
	bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNV7p1tBfmRuxMVY2+CzGhQvKJmNdrH1De0vGLptA34ObuMRM/0sIuh23A/wpF54cBszDo5jk7y8Xk+uRINcqGENH3SrJdSQUhtaq0fYD+o2hhKfYFbDTpmAg1PAnDFlQm4u020HMArK6C8VutkwMxfpjerXMl1NpjCZSRaAT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+jHveHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB69BC4AF11;
	Fri,  5 Jul 2024 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720187107;
	bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+jHveHwkXY+CiXSr4nEQhDxyZYfXNRYPawIeh3hWq68kBtjRuqgygRzYMfiKB38C
	 zhkkU+XFnw+mQ5HZi+Yh5kFy+7FBgRAdXVbG0DrxbqMOIcKyZ6KOCpoGjdB463+Jrd
	 ouT02icDl36H8wQ8zicD92bGHPP6d1hZgUex5PGQg3E9go3OfftqoXc5qUopMSP9Xd
	 sm7g7n9gDwqjefm2VK+WATzhjt3JIqkbMhBGjF+uF0cHHDWysHIEcjEdD8QX3JulgX
	 /HNYgdTX2I8LXGhEeTk5z7Zy+n/FBGjkfRqquwYuWDHimpdW9NHdeOVhye4CqJNIyt
	 vl/rwRptXPo1A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 05 Jul 2024 15:44:52 +0200
Subject: [PATCH bpf-next 1/2] bpf: helpers: fix bpf_wq_set_callback_impl
 signature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-fix-wq-v1-1-91b4d82cd825@kernel.org>
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
In-Reply-To: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187099; l=1192;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
 b=aEuQ8LRz2zkWCf81XAaAcE6Oew8VwVkkUrZWdIV+xJPTbKhBDIUR1z7v4elK0NSLvh++p3qs/
 Knb29Frb3ofCcatLJCO/LQfjhot+L+/Aqx0adjheU74FDsYUKRcKalM
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I realized this while having a map containing both a struct bpf_timer and
a struct bpf_wq: the third argument provided to the bpf_wq callback is
not the struct bpf_wq pointer itself, but the pointer to the value in
the map.

Which means that the users need to double cast the provided "value" as
this is not a struct bpf_wq *.

This is a change of API, but there doesn't seem to be much users of bpf_wq
right now, so we should be able to go with this right now.

Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 229396172026..5241ba671c5a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2734,7 +2734,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 }
 
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+					 int (callback_fn)(void *map, int *key, void *value),
 					 unsigned int flags,
 					 void *aux__ign)
 {

-- 
2.44.0


