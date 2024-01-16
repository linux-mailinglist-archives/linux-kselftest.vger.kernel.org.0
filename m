Return-Path: <linux-kselftest+bounces-3110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7D82F7AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435921C24ABE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACFC50A81;
	Tue, 16 Jan 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h29uViUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B250A7C;
	Tue, 16 Jan 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434568; cv=none; b=FlDDLeVlntVDSb/0nLyKfbGhIviAjyb5kyHUAz9AfmklzYcDl5jg9PBatzz4boPPkUqBipA2o3U3t0Xp0AwpdNeP6LZZgT+mv4+gzc3e0rgjXCC12S5qnBLLzQzIC4JnBGRVLfhv8tEB4LEAvPV1jZG7KLSeaDtfY/xYsmtYPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434568; c=relaxed/simple;
	bh=cppTFyF5tp/6PgVGk68fBKjFZSL7jxnFJu001UhRQWk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=MmoeFNlHN/DxYxv6g9e8QaROltUWehF/+DGF/GnjHJa224mLYGiHDO/BgJlov8ZjduOvfuhtX5EJ6xsqKk/J7HCNkVrQRQhfXgzVztGO5cahcJh4FZ3LhTM955spymA78nH7AiVjMcqZ8LbUrolPnQbKNr8flm7LjTx9iYnbffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h29uViUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1E9C433F1;
	Tue, 16 Jan 2024 19:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434568;
	bh=cppTFyF5tp/6PgVGk68fBKjFZSL7jxnFJu001UhRQWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h29uViUDnIGfHroRR7flgKCZggWaVMpujmwl/jc7QYUaTw7w+7Nt3XZoMa53ZUUJs
	 2yPlA++I2kQjuk9nO0NpeWfT/rmn5XQPxXE63ogoBZOsq9iqoO5zM1VxNdfMZ2ycQT
	 NOzcSGDhN7VGh8AWLztiDT/aOJNIE2hurDTKEcheeyYjmv2WYBVBkKlMY0ZKgNXM5T
	 L/2gci9UbLFQqegmlWCzgyewB/2lVVyULpyuVvBZDEOjqslsPRzBPsDF3UMwolifjM
	 sqK4kzeTCtwCB3br9RLW2t/VLisihbCT0yrmGCiYpPKuTTqeYdi6u20ubMtF9HADS9
	 myvVx2KQYK7Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@kernel.org,
	alan.maguire@oracle.com,
	lorenz.bauer@isovalent.com,
	iii@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 004/104] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 14:45:30 -0500
Message-ID: <20240116194908.253437-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit f4c7e887324f5776eef6e6e47a90e0ac8058a7a8 ]

Some compilers complain about get_pprint_mapv_size() not returning value
in some code paths. Fix with explicit return.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231102033759.2541186-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 4e0cdb593318..1b8e967f2604 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5265,6 +5265,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


