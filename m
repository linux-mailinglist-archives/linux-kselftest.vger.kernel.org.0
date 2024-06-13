Return-Path: <linux-kselftest+bounces-11875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B7890781E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9841F21C4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6714600F;
	Thu, 13 Jun 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ku1Qua7F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ex5hiPog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB612FB1B;
	Thu, 13 Jun 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295593; cv=none; b=OEVUk8XST9BWZgfH/+gyitVjYYh40+hqeFjk4fRC/Lu68GNEoMRHBdRE9JNBisBQe6M3anJFNuS744J58Rsi0CL644cJkLuPUFlo1JQl+5Pq2puFxtIr8qqPV2RdfsZdDHYMRn1292ZEyrACqUd2rQgb3ujY8hinsbFyThBGZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295593; c=relaxed/simple;
	bh=il9CR8RWy5mrfp/6orJ5atyRWhBkbb+ud6If3Ho1ruk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrGI6/ZXhh1jF66x1RMHpzlWxI7eNwY6hbFfhjWXa45qSjerkg5Lj8lXOCbaESE2ZMguzBdID9Y3bMGVfbINFeust0MbYwjBsZUQORfyxZNPNoOGKO5EK1Z6eEzNl7/eqKI1pJcWzLG1gMpQxSnTl6iyw1TvRyvvSCuXpX3AESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ku1Qua7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ex5hiPog; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id F3A8C1380085;
	Thu, 13 Jun 2024 12:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 12:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1718295588; x=1718381988; bh=5rMtixePuS3RXG9fhXTba
	9T3LKerJ1M2yNaJfMQKX+E=; b=ku1Qua7F6q+gf+Wl4mMA4EPg+XIn4k56jQtnO
	ir7MRm73iOJpTE5jB3/FVc4jHtRGvq8nRs02y9VFRub7NTqhSA8qhuezgZPRy589
	FZ+4EmxDBoEjws92rvd89FyyDY/ezBhiFEDsmLwC/YjBCapjbe0FFz4RkhxHdwyJ
	SydlTvrxayKo1z1/QXewJ2oaJ3TlkhnXJdeS8wiepxDYajIFdZhB8EmfBz06H5ze
	XPjiHFHz16zZusXNDL/fMfdqNrncZF/U8dvCDjYk2vTqFtJ7wkXLjV0XFnQQEWEB
	HWdzmosgl3407OR3Po84H1mWuVw7ISkFMNg1RJjvV5eLyGpGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718295588; x=1718381988; bh=5rMtixePuS3RXG9fhXTba9T3LKer
	J1M2yNaJfMQKX+E=; b=Ex5hiPogIdUbiPplzt0oMW+QTVHyGEpTYrqLLSaj1/Rs
	P5sNJ2Mv7X1SYi8Xx9THVSDtgObRvAnOeTRjaPIEe2vc0wcDlhK1CMr7QF56hB8M
	adDQzUhG5M2NCKKhogwLF35la7ZBmbKOEFhX9Fl/zv+UVtUW5JeLdHJiFkBG6NzY
	FveTzhYAFmVsg7f+2YlB7L2V6Teu8Zlw02MkRfK7qn3f8nXzQ7wk3UKWftql+YsD
	ng2KLJFAd1IaonajUBUEVlIcNw9VWKI9+/oDmo2V9q2DpNkYPkrZ9b/7N1EKyA+u
	gUNCnlmKqDU/+ZNMTQTCdOteuN4hoYk5A3UySgNqpw==
X-ME-Sender: <xms:JBxrZhNioB2l0mVkRuFWjpf_ukegMefGgena3BedRK3NYRPQuSg4kw>
    <xme:JBxrZj_w4OAJXx7W1Ug_0BJtrd-ibkvNfeant_ANKy46Ct1-2ihotMTl8TMUweVnM
    k8ZL_MY_LR3WLbhZg>
X-ME-Received: <xmr:JBxrZgQ9E-uW_OYbgwmDtK599HHllIFcU7hD984pjzPFF44g6mYgwAkfSfLD8IdJksrtxyhaTRlDWRyi_OX2Wq9pls5R4v99WGdHvTXp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JBxrZtv-lVzhGlwS21tc_kIJ1zYsR98YF8cHM_IrArIcs24Vlx5RgA>
    <xmx:JBxrZpcJ_kb6ewjILe1OMzJkKryxsFffx4MGeJrVI1ocdrDfxSfZwg>
    <xmx:JBxrZp1b4sBVXhXQryQfYJF20t7VLJOZ8PDrA7_ertyYHQ_HY-oCWA>
    <xmx:JBxrZl-hCYwHb6cbojmmM1nMc7KhO196Jeuw4jvztq_AN_Ji88IhbA>
    <xmx:JBxrZjsI80lZ3g8RNCysLBdXZdzRbUGWs_T7bvdiezGFrqGrSAm-xifm>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:19:47 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dxu@dxuuu.xyz,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "sfr@canb.auug.org.aukernel-team"@meta.com
Subject: [PATCH bpf-next 0/2] Fixes for kfunc prototype generation
Date: Thu, 13 Jun 2024 10:19:24 -0600
Message-ID: <cover.1718295425.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes new warnings and errors that kfunc prototype
generation caused.

Daniel Xu (2):
  bpf: Fix bpf_dynptr documentation comments
  bpf: selftests: Do not use generated kfunc prototypes for arena progs

 kernel/bpf/helpers.c                                     | 4 ++--
 tools/testing/selftests/bpf/progs/arena_htab.c           | 1 +
 tools/testing/selftests/bpf/progs/arena_list.c           | 1 +
 tools/testing/selftests/bpf/progs/verifier_arena.c       | 1 +
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.44.0


