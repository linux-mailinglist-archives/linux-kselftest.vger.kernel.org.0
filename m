Return-Path: <linux-kselftest+bounces-48567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03140D067CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89B93035F59
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6833CE90;
	Thu,  8 Jan 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCbnL6gW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A7334361
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913012; cv=none; b=oMGKrWijDZ+gO8QcCSLZu9pmq72A3F+zaAYNFC0bwUpju3sCHavUBmn2FjwOmW9ZoN33bHTP1wWoupKqxOucUn2X0wcPY/NWOautxDybWZVDmlDfe3PLnu3mAtbJideKsE6sWlYxjg8ff4LxKq3JbqC9iJNoaPfgUNRJgmpe5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913012; c=relaxed/simple;
	bh=kuVmwolLprvgFQC5gK2CvP6uE4+/Xs3CDYIOcSnFIuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZKu8ezKKBPMsutYzLwWdPJyTeWn9QO8VqTgmJVrs7fzCXLKF2AWiQUW2Er5dTtAgj8kwKvYbXJbATvp9O4ebSp/GAr6pf3nQRXJ6s4XvKX9/r1Sy7TBbCcsZ4o1vx1D1MJGFPxgvDx1i1/Ws7QxqL4PCH+DcGI1TgPybH5E6M+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCbnL6gW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac39bd5501so2751606eec.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767913010; x=1768517810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuaylGKmhlV4n+kOnxwaacUMm3XMBF1qN/OxctemuKo=;
        b=jCbnL6gWyHuDCKcaPrAAtyioE9hZB9mzzsjjpJfXVpFFlBrH3VPv98CY0IeeWCkgbh
         EvJYr39s8LfREbVC9B+1hCJ1Nk3x0QzJE8MTaDC2CgWRlEt7bl7ZR79s43q9b4rh6wng
         rGzEnwApZXrWlU1X1LCVdSYB6mgBsnZ/MXkdIksl1iaF6MpWQ3hS9HAOuaZWwxJtdsGd
         JKbJwLGYY4iSDIS303QQGNUmQGuCGSyMVTTfGi99QxPWIR4gSzu3GxnflfeRGhb+ktS4
         5/7fxTD7ScJcD3U8zNoktpZGrp7Ypz5kcSpNc3UM5gMPRplLaFQC4nTS6Qw50/wYW7tP
         hHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913010; x=1768517810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuaylGKmhlV4n+kOnxwaacUMm3XMBF1qN/OxctemuKo=;
        b=HOx7Y2proEYoElrLuGSTcIt/OZ//dPimdny+h+611+GmU/NYBTg+1Y6bkhQnVrUm31
         nxWFgV40z8spvLL3iVzoVfk5WVm5K7/ECizRvicJK1SXYDSCn2/r4TyOXTjP5JW7zoOa
         BhU+GLoiz5AJK7A9cvaEP5lBfO4fulSMftrBci6bYjUC+T76nQwSCGGEK2UDPx45ZMbM
         UI3x6t8op5p+1exr/4T4HpXPBtLMxiWt35Ds8Z5hdboAv9Hrzj7AZ/+gUARlsIb7Az26
         FkqDS1uqkpr2f3zOBLXI9b0aea7ZzQW2breRbkwEh7yDSEbo/Ph5hoCbwSuYr0TIpRM7
         DEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9oH4P4gpg01DdkUfprba/hzXQyMv/9zq918FN5gbl6EqZzlTa2AOTRlaz6TK1CoU81rwuPmfDMqvDyRyzdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAD8ExJ7V+tSlag/naO/sG+OaCW+mxw9mdbsWn8V/lXhU3A2o
	50ufqmje1Rat8wfAMFpok3S0yrZpofcQVbQucibd1eTR/90tvQuCbTq+7YwpJ6ZjfboQ8SQV+VV
	+laKNoaPKsgHxHg==
X-Google-Smtp-Source: AGHT+IENQBlDEvxTyqSWqxJtIK7u6/aN3XKMd1H9vZCTl6QBchXevnwExPMON9th5RerMP1jT6OOwF5oFTEgqQ==
X-Received: from dlbcf27.prod.google.com ([2002:a05:7022:459b:b0:11d:cf87:f4ee])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ff46:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-121f8b9e460mr7435141c88.49.1767913010038;
 Thu, 08 Jan 2026 14:56:50 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:19 -0800
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-3-wusamuel@google.com>
Subject: [PATCH bpf-next v2 2/4] bpf: Open coded BPF for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add open coded BPF iterators for wakeup_sources, which opens up more
options for BPF programs that need to traverse through wakeup_sources.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/bpf/helpers.c            |  3 +++
 kernel/bpf/wakeup_source_iter.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..ca34d7614c3a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4518,6 +4518,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
index ab83d212a1f9..149baecfe436 100644
--- a/kernel/bpf/wakeup_source_iter.c
+++ b/kernel/bpf/wakeup_source_iter.c
@@ -90,6 +90,40 @@ static struct bpf_iter_reg bpf_wakeup_source_reg_info = {
 	.seq_info		= &wakeup_source_iter_seq_info,
 };
 
+struct bpf_iter_wakeup_source {
+	struct wakeup_source *ws;
+	int srcuidx;
+};
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_wakeup_source_new(struct bpf_iter_wakeup_source *it)
+{
+	it->srcuidx = wakeup_sources_read_lock();
+	it->ws = wakeup_sources_walk_start();
+
+	return 0;
+}
+
+__bpf_kfunc struct wakeup_source *bpf_iter_wakeup_source_next(struct bpf_iter_wakeup_source *it)
+{
+	struct wakeup_source *prev = it->ws;
+
+	if (!prev)
+		return NULL;
+
+	it->ws = wakeup_sources_walk_next(it->ws);
+
+	return prev;
+}
+
+__bpf_kfunc void bpf_iter_wakeup_source_destroy(struct bpf_iter_wakeup_source *it)
+{
+	wakeup_sources_read_unlock(it->srcuidx);
+}
+
+__bpf_kfunc_end_defs();
+
 DEFINE_BPF_ITER_FUNC(wakeup_source, struct bpf_iter_meta *meta,
 		     struct wakeup_source *wakeup_source)
 BTF_ID_LIST_SINGLE(bpf_wakeup_source_btf_id, struct, wakeup_source)
-- 
2.52.0.457.g6b5491de43-goog


