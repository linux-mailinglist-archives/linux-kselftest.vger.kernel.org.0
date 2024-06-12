Return-Path: <linux-kselftest+bounces-11772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400129057DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443E31C2326D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292F18308D;
	Wed, 12 Jun 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OT7CBeyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pN4nO9Mv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BF18307C;
	Wed, 12 Jun 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207946; cv=none; b=YSK2b/Uy+5m6XoQ9RQiZzdVQVeybIKkKRMpEsAQN41TlSpsZ6haWmQtAjj7rGrH6/BjMIDEjkSsAUMiHq3zAig1O9eiVt/JIZS/uypsSBZDvfvzpxG/YTntBQq6yQX5JDpbWvZuPL/MxKPAD+/OwFeQw8MtoWGYbILnUluPSti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207946; c=relaxed/simple;
	bh=9ndpDbUKmzld1e57daBn9wIzW6+lQLMT31Jy79KmTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTHwCCYrRUJ8mwL0WtVydAQdARtqne5O8j8wbktFX6RergrixlpykzJee3iUaFjTn8xa4POFMlYr6fL7jGDhYtT4ZGoisls68tj2oGfr6AT6w3AaSS/1eO3vGw4RN3xFfmbmE++QyBIPhkGAy8UsEbWnklLfpdZ8aIcX9Hbzoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OT7CBeyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pN4nO9Mv; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 264C42CC0178;
	Wed, 12 Jun 2024 11:59:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 11:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207942; x=
	1718215142; bh=iKt4e/7aiFkFnfvvYGqGkJ2bXvHaHPWWRphogKimbD0=; b=O
	T7CBeyxF5FxDe0xkOBfFf+VKMuuOXlQ5io1vM2xjfeDyUXBQ2z/4qd4ocXz0iQQA
	QNZtMRSzOQEq+CwcBpxGwVkYyZcc7fZTrJQzCQvxVAihTYdlHadmyJUo2GXh0Vkj
	CDklUMwfLvgSBmHuBDzhPzrzQEyu8h/gx1bx4UfKTNESr2CSK1ujJ/qoktpAYv6c
	xwyw/a3DM8Pg6709r7jsot9/hbajHlh9B2ubp4M1mlhxc4/KpnVLVNw/kyYN6jcR
	KH2A2eeU4JBuRCTapIcDEeO41ep1SQv5YZPDfUYYCkHddSIInoDKPCGjH3T0wb2B
	QRRXa3WNepCSIP+lzkevQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207942; x=
	1718215142; bh=iKt4e/7aiFkFnfvvYGqGkJ2bXvHaHPWWRphogKimbD0=; b=p
	N4nO9Mvb1N1Y/UKl+zvGWwgnxlJ8w7VCfB8DvdH+qpq/O0dmAkMlitF/P4QTInCy
	AQfpIGswlDAL3nE4rzQihO69L8HHudXbRQ1o4HUWa3KCKYpxVrYbvpCT4MON8Fne
	DPJTHB4InO4Iv/2ll/W+ThWlzA4uOYBNjnWnaLVymh6obvSMBrNmPcaqHIEZCi9I
	uDJmpJzuggfNWSX/ZiEqAA8rbQAWEKchGxlhcUKQiOVtbKcKWiIWZ5wTRQjnLf2H
	6FKe9tYxOevrIjCSVSFXruZCoFxs4nGCj6Hdr/WAInGjUd01vYKDbXMcXywfepMY
	d7XpwyMNspdh2F0yXd2nQ==
X-ME-Sender: <xms:xsVpZoyLNCFhooXfwM6I5oG0NhpefINrrAaVa_In18fkYmeG45Nh9g>
    <xme:xsVpZsROxa2u7osBtDqnr1yBM-rdTwHEVC2poLnPZQvhECMrykzfNvXvnKTSWz6IQ
    TuHmDS1kj7px3iP9Q>
X-ME-Received: <xmr:xsVpZqX51s2dmUfCx_r_PREBopFP-Oz0GeEFznejhdXNbiOPtDwQGFHZ5XBdJQ3kXulEirc3DfYwKjS0cP61FSqFB9nmoZ4w3iblThwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:xsVpZmj10Uce6Fg1M-ArZlYNNFtUZfq98UelQ4V6ynIbnfiMx-kHmA>
    <xmx:xsVpZqCxBN8axY6CqGbxQN73rolvbjPl8D48xhdkDsWypBplf4vXBA>
    <xmx:xsVpZnL9-yymC-QVaxtnoDoQCxVo9bOJHKyLTT0oK7dTMsFoqfX-cw>
    <xmx:xsVpZhDntIAbylaRZgw79WQL1CNpagAOZ-LLd1ECN_TqD0gvjjSaQQ>
    <xmx:xsVpZlXG70UBuoZMJnxkkatgzPPzPItqsVQkNhaLli1pv-_0luwGDpCj>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:01 -0400 (EDT)
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
Subject: [PATCH bpf-next v5 03/12] bpf: selftests: Fix fentry test kfunc prototypes
Date: Wed, 12 Jun 2024 09:58:27 -0600
Message-ID: <1e68870e7626b7b9c6420e65076b307fc404a2f0.1718207789.git.dxu@dxuuu.xyz>
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

Some prototypes in progs/get_func_ip_test.c were not in line with how the
actual kfuncs are defined in net/bpf/test_run.c. This causes compilation
errors when kfunc prototypes are generated from BTF.

Fix by aligning with actual kfunc definitions.

Also remove two unused prototypes.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/get_func_ip_test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 8956eb78a226..2011cacdeb18 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -5,13 +5,12 @@
 
 char _license[] SEC("license") = "GPL";
 
-extern const void bpf_fentry_test1 __ksym;
+extern int bpf_fentry_test1(int a) __ksym;
+extern int bpf_modify_return_test(int a, int *b) __ksym;
+
 extern const void bpf_fentry_test2 __ksym;
 extern const void bpf_fentry_test3 __ksym;
 extern const void bpf_fentry_test4 __ksym;
-extern const void bpf_modify_return_test __ksym;
-extern const void bpf_fentry_test6 __ksym;
-extern const void bpf_fentry_test7 __ksym;
 
 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
 
-- 
2.44.0


