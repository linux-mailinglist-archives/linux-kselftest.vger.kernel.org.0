Return-Path: <linux-kselftest+bounces-25708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDEA27842
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E88164593
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6C215F4A;
	Tue,  4 Feb 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="uUEuyash";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9Dqca6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FA1EEA29;
	Tue,  4 Feb 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689935; cv=none; b=FsZH4/ifa9F1bPqEt82eSqnmMXwJvZH+C4J4H/Lp3wy8H7SnJTu0HWVg8iOzgjTzRbo8JUB26Z9kY2XLxelswC/u7mzcwzrtp5OZcrFfhemeuR2Ar/jBRbxU2VbUxSn80KSqksatKPiOTa8JQeVfym4s4QE25O5O066n0aXuAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689935; c=relaxed/simple;
	bh=zH2Gb6lbW4QreOVS2zbWuHj8mn1oqVmRVEJtZltrOc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HniiFzKG0OKo0yXTsVYaC/durc8jOPHLIdXWwDocylZx+zTHgiBVCBB33EymCrlo6OYFaZ2BEckY7GA4V7ko6loAIH17r+82oJ+VwsfoMflLsoCivApoSZptxIDVsKv27iiDBtYEgnGwxxfT5dRrCGT69NbZz73kWKHF47eSd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=uUEuyash; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9Dqca6d; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A3B14114014A;
	Tue,  4 Feb 2025 12:25:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 12:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1738689931; x=1738776331; bh=Cg2avvLJz3fpRvOgBXOJK
	Zc4BalDp3n/FJStJnxiVWE=; b=uUEuyash3pHxEIb3r+FnHMw92z0rR5YNYir1O
	4s2roVkimZIgDA8h7utEVM35E3YrFusl2wzizDC/eENQKwSuC+Y/tpw9BOkPaFFa
	0WBV9AV2cmjyYbT7pSlhTIWImbGA/fevn48wtZKd2qvA5XPP3t87XSP1JRcjB2ed
	rdE2gMl/fScfKJIYWOn4F7Aed6TLln1dfmws3RFXYQ6r92SSnrlPFx5R3rZG5sx5
	xkPPedEtrnqTnV1CsK7ELyRLDgv2dkxRUtLXGwcQGi5ytOZdg1vv8GyWarZ6qnre
	Oey+GeGYX4EGAzsCtVGI/v8HSxfxfpiBryhlZTZnjGyk2MD+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738689931; x=1738776331; bh=Cg2avvLJz3fpRvOgBXOJKZc4BalDp3n/FJS
	tJnxiVWE=; b=q9Dqca6d+3w9ZiaAwHHMLyPRSDm4+AU4VKHoXqPvhPhjm/PlB1i
	h0mDlmkumLF24yx/jetYYPlf9b4fufPLOVGqmIvaphCsgjdz9e0cp+gng9W1hGe9
	IZjNrMvvIWc2Y1O5CEZqqxOoNoaCw0nE2Jhz+A+4uQ+ElZqnjVYz+vJ01BbVeeLU
	+0ANB8/MquHZqSU3ZPrXzaoeaLWycXXazeWQgj7wId8R39RSfxoCgyPxdhr3dENU
	SNXBEG66KYx8AhYfqmxFiviOxG9mvATaGnUBnKbIVqGhag8SO3CAtz8kfig3fYfU
	eGohJBn13wY63v510x1zIhRAG7YiuQMeQlA==
X-ME-Sender: <xms:i02iZzbzl5ebO-Eq3CJP9i4O_a_3jDmLjgvkBQvYu2zEgFrpnhk1eA>
    <xme:i02iZyYu82HX6xGFiuWMcxo8tJWDKHosEw3EJkpdIs2XEf8scCVT3A7qxyK9FUdgg
    d3ugFk5hoRMGF_f2g>
X-ME-Received: <xmr:i02iZ18iaaaN2wozrmCjDRQ0EeDH_yhJV_7BPsFFglRVJobhSNv5RWQgoJAIQyu9pv5BIXdOqQVTOpsdzUEHkQIgMpGlHUiCXt5dFAgvs90bDfi23HP7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmhhgrrhhtmhgrhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehiihhi
    sehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:i02iZ5poHKagSBRNaISwbN2aB6XgLt8QJI2uNjBbJZgLeXQxekSm4Q>
    <xmx:i02iZ-qpTnZgF6Vi-T4tiJZxgA6-YZ4roFF4k175VEkGJHmX7od9iA>
    <xmx:i02iZ_QwxRx-a_g1od5RD_TWDkHZUxakqW7qYgruR0WkL0l1ayZpYA>
    <xmx:i02iZ2qhfpUvaaKhf4SAf5UrCxe9Mk1Uaz3td3hhPrEo4JAsKGD12w>
    <xmx:i02iZ7CWtGsMp16gd9et3b9FsOj1GB8gaRYXpO2IGoZV_PEQ0CCADFi_>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:25:30 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next v2 0/3] bpf: Some fixes for nullness elision
Date: Tue,  4 Feb 2025 10:25:15 -0700
Message-ID: <cover.1738689872.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for nullness elision. See commits for more details.

=== Changelog ===
Changes from v1:
* Reword commit message in patch 1
* Add tags

Daniel Xu (3):
  bpf: verifier: Do not extract constant map keys for irrelevant maps
  bpf: selftests: Test constant key extraction on irrelevant maps
  bpf: verifier: Disambiguate get_constant_map_key() errors

 kernel/bpf/verifier.c                         | 29 ++++++++++++++-----
 .../bpf/progs/verifier_array_access.c         | 15 ++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.47.1


