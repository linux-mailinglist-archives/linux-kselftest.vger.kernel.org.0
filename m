Return-Path: <linux-kselftest+bounces-11774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E199057E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF111F21E01
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA51836E7;
	Wed, 12 Jun 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PIaB6Z74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0wZQ+Wx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FE1836C8;
	Wed, 12 Jun 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207954; cv=none; b=ShMLjqLbUv/+Dr14NIR33kvUs51dYyW2kZ7mHM7QqxrHj3L0aUMinwE601ys4/fK+UGgczKf5ZijXGOmkhRWbT4NDbi3EhfSocOIZuYdVYG/I9CyO0lPlUE/ET5U85ucGgUiLwxNFH7JX63AVjI9lHPl7c+yjqBpTFKrM0xww3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207954; c=relaxed/simple;
	bh=ijnUl0Hs27kSZo5nKTCwOlVMiTcVZASzt7fhb1OM00o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqTdo2ByYzZtH2zbOkLBcf7nrM25nNavkDym6GiDnLHspXjVNGioNuhKctdpQIGvj8RzmeSLMNAnQg/IXUHGpy5saJVXqyW2dIYV5VsA4vcpHbRvbndsWMxPfOTdC/FfNpdKNu/c4JEx6UqCgN7NiH4Lm54HfXXqXJKzkx3lYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=PIaB6Z74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0wZQ+Wx; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 7DFF42CC0175;
	Wed, 12 Jun 2024 11:59:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 11:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207950; x=
	1718215150; bh=P8U/vSNSp1TElUyC4OwmdinUUv2kbxRZJWBSbm83Cm8=; b=P
	IaB6Z74zv9lxJ2WggbNRvaciu/0NhqbWv8y2/2JRSQ8Zeh1XoAQSqLOmPjWCsnLo
	g07Tk8yQOQluFzRHnsOTT3KNcsi8NbuKoVNPKolHTjxL5sTN+iX1sCbGlh9IZTHC
	8hPhVioy/hgN1ek2+9zqiJa5Ot5hGa8/BiUsNlGH2PILO5TQW5PCDe0kDQybt72w
	fSu6dN2y+qbiyyNHsRkGx4K8kb33Vu71t7EaV9tSm2TkbfISJeQBvBR0JAI10CxA
	guqiELKZhMVM31vQ6hIGdU3ynRGW6JX1aZghSLxEPOqSOF5+YgIJWWVgthmn8R6Z
	rN9yyz1uGAsgvRiu0jPHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207950; x=
	1718215150; bh=P8U/vSNSp1TElUyC4OwmdinUUv2kbxRZJWBSbm83Cm8=; b=G
	0wZQ+WxxEgS4VkxCwlSGr/Dkyyni9eb1YYkfQj+k36/4QuxO0Xs1e9PiS9gBYcwZ
	JjkP2E72qNJA+L6pvR3JZHDB/b+JoZGGqv7Y9FbcVRaKBVKeLoZJWLT0zMfscJqu
	WEZxjsuI5Fqptj5UnN56IsjIOePbEOnzzMJf0bVWXlCkkrTKlSXQbbmHHFcjAymf
	WIW41Su6OqzIbP6X2tVXyBAb6ddzKxY0O1cATYQW/6U90eehS01nhJ7peL8TO+zR
	vlVWT2EbjKYlGTb96PFnoMHu4Cipn/huV8ZteavgZhDyqMSd3X5ENEzZP8qPzmZV
	7+pOauaNEnvYZWRlgN4EQ==
X-ME-Sender: <xms:zcVpZnQcp5OMB6HKrCK8Dza2VBDF2EHfEJW6eD-VkAfnQwWHAzB3-g>
    <xme:zcVpZoxxnRwRmLXuol9z40HGRPTB7MRw_jDNENiQCToUaxrNt_X29n7M8cdJargb9
    wgvelSnDCI1TZPAdA>
X-ME-Received: <xmr:zcVpZs14fa9jUKPfDre77vLTiZ_TKia7En-427cliyNaXLQrcHVMTt8V6Aku74MLdUv0QqrTwxUuMROi317xsmafQBbUxTsFgwMRbxBq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:zcVpZnAJ1NpMaDw_pDpTswQDNmjzEIlABPc8msLIAbzwdjNMMmyhnw>
    <xmx:zcVpZghpRryzZdR7xeKLfxNB4s5IZ53wTZIpXCJzoBlonF17IP66Hw>
    <xmx:zcVpZrqEnrBvJLauyGGWqAfxbdZ7wR308hN51ZMtO5uGfnr67ecR-g>
    <xmx:zcVpZrgw07ipeeh6M9cYRij8KPNuextXBobXy9YRH5TlbgHfXgw-rg>
    <xmx:zsVpZp2Qi1DRSMhQdQxvE-mlGelNXcssGQ-WMv3iXZS8KHiuYpTILUDd>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:08 -0400 (EDT)
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
Subject: [PATCH bpf-next v5 05/12] bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
Date: Wed, 12 Jun 2024 09:58:29 -0600
Message-ID: <0497e11a71472dcb71ada7c90ad691523ae87c3b.1718207789.git.dxu@dxuuu.xyz>
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

The prototype in progs/map_percpu_stats.c is not in line with how the
actual kfuncs are defined in kernel/bpf/map_iter.c. This causes
compilation errors when kfunc prototypes are generated from BTF.

Fix by aligning with actual kfunc definitions.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/map_percpu_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/map_percpu_stats.c b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
index 10b2325c1720..63245785eb69 100644
--- a/tools/testing/selftests/bpf/progs/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
@@ -7,7 +7,7 @@
 
 __u32 target_id;
 
-__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
+__s64 bpf_map_sum_elem_count(const struct bpf_map *map) __ksym;
 
 SEC("iter/bpf_map")
 int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
-- 
2.44.0


