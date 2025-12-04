Return-Path: <linux-kselftest+bounces-46968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2CCA2360
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 03:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B33301BCFA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284F3176E3;
	Thu,  4 Dec 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuQ6s5Hn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F153314D0D
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816637; cv=none; b=gJ0QyhL+t2yv61DbxUlW7940whVkgU91kPMLCsXLqYKGts/Ik7OHTGzbCu7uYDRHG4mZGNIL653FHU/r559Kd6fVZXXqux3TvqJxueCiICz7+E5nypvjSicvCeEOexHrxt1baoG9KMsX+nGjAyeFovo2s1htDHz8VZGwNz4pBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816637; c=relaxed/simple;
	bh=i9rWPJ1BRPlZegR1PINTMP8i5dYmXfU+6qSQof50Jxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aO7NUcWVpBq/lImMpagP2k7EtOQhbf8BeSPg16VjBs5mAZqTqhS0DUEFwiKUkNMmIrGyDu6xMOC22ckhcQZAgzGV3SO8cdRxu1q/moN7olg2VWSDZcnogC/PsZKcJhVbqVzLiAwoASHsg8fAHKodgEEsPXHBV7Ffy/1D0AScEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuQ6s5Hn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297fbfb4e53so7868335ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 18:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764816622; x=1765421422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSyTnP2FbGdIREPxSFsXIq8s93x8aTcDdJSLn+2cqSQ=;
        b=fuQ6s5HnszUxh/kS8dnXcT8QoiqQ5LWe05lQ7bln9fw7ujHtTjFUcBlK2OTVFIzF3f
         32gNiQScCBnk2K76LNxGta/Jsqurg8YXc5CcTBWTYDnraTWb8ISEmfACNgQFXvB3Pww8
         H7nkMD39BcavVrTyVxlGLies42dZM1nCvukAtpEPq6nAdsvrSo9tNzKTkocZ5zvS3UW2
         ti5194GwkzglfBGNSjP0mFeo5RpsrVS6ls/ba+iHxcpM9B+ExyHMgi/fqseUi2Z87S/N
         HVBaMVbK2HRWZQM28tiqYpdIKgR9W/jSZ7W1baiD2lUmbOHPISW5EbKTtqJF7QJ65vDt
         s6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816622; x=1765421422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSyTnP2FbGdIREPxSFsXIq8s93x8aTcDdJSLn+2cqSQ=;
        b=YA6RmfJwYBRAAKw7dTLqoVUZUEPpOFXtI72F5PrNP3hybXL0aDYMiWLSsc2D3GhF2h
         BWtxFbbRKpXqMSLzvTIiWDDkZBq/UVfjszH7naSJLPna4SF34pHb2yQffU2Ru1KrH4cI
         jPAkU+bU5N9RPCuNFp95iMbmnEOKXuLLzljcMt/unRRxKx9aUwNJ2Qbx26/P2ep+IH83
         ZYTxHiAYs8rHQjc/YpkZ/Xrp3/LWsT223unjvQXuPWBuSWTHaRYRnWpJScn5Ct3yV4Nk
         CD/Wbq6pvPgjteNjHjmzS+IyKeEb/PwoiwFSljYdjbtmx36GNH0QGUlNvszoVXrPEg5y
         8b+w==
X-Forwarded-Encrypted: i=1; AJvYcCVfMPPtiLm9wN+WvmkNP0I0QMQEK4+pjfxTuXAqKH9y+bdoFc+qy0yGjhNoel4CW7ny53rsypI7WRt/BKh4Nrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NE8kJvMLpLVFR6CkXOR6mDTTvG7DbZnZtWY/vc22yAmfIUnQ
	egTPB+OYnxGceRRxc3/PcXhNXKLpuIengipx7OvzB77S7E+Og8QLPSy4J0wHMv4y0NZiI0AA1L6
	PZhL+fgZ6dfRvKg==
X-Google-Smtp-Source: AGHT+IF+RwUg4NL/WO7wzUqMdZLA75lB4Kko0R/cM/dJoFvWb5ppd/z3qezKD0KnEXcQmgmOSSRWiV2vCaVfcQ==
X-Received: from pgdi15.prod.google.com ([2002:a05:6a02:51ef:b0:bc8:68ae:e506])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2588:b0:35c:f727:8a89 with SMTP id adf61e73a8af0-36403876ee8mr1666667637.41.1764816621600;
 Wed, 03 Dec 2025 18:50:21 -0800 (PST)
Date: Wed,  3 Dec 2025 18:49:59 -0800
In-Reply-To: <20251204025003.3162056-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204025003.3162056-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204025003.3162056-3-wusamuel@google.com>
Subject: [PATCH v1 2/4] bpf: Open coded BPF for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: rafael.j.wysocki@intel.com, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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
index db72b96f9c8c..a5f867de6bd6 100644
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
index b8719f47428e..e2c0dcbfd02d 100644
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
2.52.0.177.g9f829587af-goog


