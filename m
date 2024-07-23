Return-Path: <linux-kselftest+bounces-14089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF493A448
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5560F28243A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8A31586DB;
	Tue, 23 Jul 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShdnN7dd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404F1586C9;
	Tue, 23 Jul 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751734; cv=none; b=UORGZKxuMQZXTYC8nFk5G20SSMOdqTSKQtvV8fPwn9UyG0FqAiYey5J+PoOFHjboAjYYiqllySN0o7l9f2KtxXyxSJRUmeWeX5oDZTlJ+K5hOuBy/xdtmkO0iOfGxjq6+XZiqUst8LvkT55Ldh6B3eM8Z5T+AVszY1IrH/Igw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751734; c=relaxed/simple;
	bh=+8630yexoVuxUvNFbPLwu8abD4gK79XhhzYX4yU2Te4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fu7D/9rhK7KX3iwR9ts8mWXx1wgRt2DzA4cxvS8jyniNAUL5a36Izgb4/hAfEHKZJobmggpVE4cotODCXKqwMej/icqHhsO8FE2VMzVthQc20njgmJfJoCO+YiBqYeA2S8IGPmq1Ehu9h2UvAiBBVISTtZ/sLZGI2CEwbQSeJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShdnN7dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D684C4AF12;
	Tue, 23 Jul 2024 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751733;
	bh=+8630yexoVuxUvNFbPLwu8abD4gK79XhhzYX4yU2Te4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ShdnN7dddNzIP47xK2+MUrTcatdElzfwqFIXEaNuTluYy1h8wgU8XH81GxW34QUyb
	 4+4dbx3h4SX/7IOpoNv1TeAd5rweSvSDgx3Wrh2K/4VOAvNW8pZNfQUv4/3blqXMPr
	 gd2hCa5eaYNr14vO00grKcM3nGJegNoRJEeXKIYDhhvBr7bwJfHM6HckDXPE42zF3f
	 L2/q6jHYSCrSu32Mi9tA9fdIJ/hx2mXr/WixX4KuUoOh5BpXIwbQ2sAOxDnHdJJx+o
	 EZyQK5x8M1W4XXY175m5mnaVD2n3vyhbdX9q0OOMolFt2BnmmTK5sUD7x9tycPeDlk
	 U+dwGDz3KatYA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 23 Jul 2024 18:21:52 +0200
Subject: [PATCH HID 2/4] selftests/hid: disable struct_ops auto-attach
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-fix-6-11-bpf-v1-2-b9d770346784@kernel.org>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721751728; l=1526;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=+8630yexoVuxUvNFbPLwu8abD4gK79XhhzYX4yU2Te4=;
 b=LbvGWq1ut/0R4rvXiqr63QXXewdqVAjgtztnEOLAx7oAMj6mLE0SsRKJKdXSFd8goDeoo2chD
 CeYhwyBiiAfBvylgJ2bu8w/wSg3jwdadNHin30Ub2l2CAuiNB+Pn0gq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Since commit 08ac454e258e ("libbpf: Auto-attach struct_ops BPF maps in
BPF skeleton"), libbpf automatically calls bpf_map__attach_struct_ops()
on every struct_ops it sees in the bpf object. The problem is that
our test bpf object has many of them but only one should be manually
loaded at a time, or we end up locking the syscall.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index dc0408a831d0..9c935fd0dffc 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -532,6 +532,7 @@ static void load_programs(const struct test_program programs[],
 			  FIXTURE_DATA(hid_bpf) * self,
 			  const FIXTURE_VARIANT(hid_bpf) * variant)
 {
+	struct bpf_map *iter_map;
 	int err = -EINVAL;
 
 	ASSERT_LE(progs_count, ARRAY_SIZE(self->hid_links))
@@ -564,6 +565,13 @@ static void load_programs(const struct test_program programs[],
 		*ops_hid_id = self->hid_id;
 	}
 
+	/* we disable the auto-attach feature of all maps because we
+	 * only want the tested one to be manually attached in the next
+	 * call to bpf_map__attach_struct_ops()
+	 */
+	bpf_object__for_each_map(iter_map, *self->skel->skeleton->obj)
+		bpf_map__set_autoattach(iter_map, false);
+
 	err = hid__load(self->skel);
 	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
 

-- 
2.44.0


