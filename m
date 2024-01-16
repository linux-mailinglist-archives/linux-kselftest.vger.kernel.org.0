Return-Path: <linux-kselftest+bounces-3121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC082FAAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9811CB21C3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC353608E;
	Tue, 16 Jan 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKqTGYJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F7364C5;
	Tue, 16 Jan 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435251; cv=none; b=mY/tjdkF+6cZ0YjDtcPEkZUFop2HzIU9mmDSHB8fpfTFlAZsHbfzVIzy0kmnWqG/3MfXH5eKfukHOh4crDmMUAQCkqhngQJGor57DeT8DoTYB/dbATTV2MRKm4wTEyf3r2pYuN+huAtwOQ6qSlTOMFLPnJUp66+H6aFC3f2nTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435251; c=relaxed/simple;
	bh=LzRW5AJp+7yV57n3AwRqigrbJBB6NO+QeKAo/GFffQo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=VS5kTXZink6rd+Y9lmjZNj3D3KkIg91aOa1oiVWtxJLRyitA1kDSQhgjRnAY2mPHCysvBUvoMb1v7L7CoP26TlcYyZiiB8kve1PObv4Tv84sS8j5TnFciCaKyJDqsQ6sdPBKXIhpFGn1+8RaD31Kg+feMy0fiALTqQDVJd00/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKqTGYJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F5C433F1;
	Tue, 16 Jan 2024 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435250;
	bh=LzRW5AJp+7yV57n3AwRqigrbJBB6NO+QeKAo/GFffQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKqTGYJ2BWj0iQ3j5xHLXG15e9idHtNJmY+uKrpsi2rf402p75D4gn5rnjn5aKrN1
	 K0IsiqXzxVw6wzJdT3ztTFkQd++RWWeQem9szqQprF5x6CbQQ/nbPgkidE0IRcqBle
	 cFlb3Fo8CxXDo9+ht9gx3llaPumj2C+nnBq/CzPl0oEOFS3zC3xOTJMwNmMupaYcDQ
	 ar8+NgLmzyzJ8jRYIlw+O2CLwFjWitBmsTJfBaSYn7TbKLiri/d5GS9+vWTYVOkdqy
	 7Z3KawmwJBE/kG4H5LM++jv2x+sSoCMV97A/iva/+ExTF2hPu1ZGPHnp7gGipnkwQW
	 tsFHs/ziVPbjw==
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
	song@kernel.org,
	lorenz.bauer@isovalent.com,
	iii@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/44] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 14:59:31 -0500
Message-ID: <20240116200044.258335-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 28d22265b825..cbdc2839904e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4611,6 +4611,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


