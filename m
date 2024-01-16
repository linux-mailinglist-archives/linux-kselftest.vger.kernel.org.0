Return-Path: <linux-kselftest+bounces-3115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFC82F926
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771E5288EC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25782C18F;
	Tue, 16 Jan 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoBTw9BX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19128E3C;
	Tue, 16 Jan 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434918; cv=none; b=GuoAFodsSAVIfwgnWn5tj28HYCzw5XePj1XG2lRU5yfQyQE6Q7dXQpu7qGVfsy6FaSAqiF5ocajKeOWIFIBjt/4QPAF4nKwdNvdLm0le6QkLv95ucZZYrmN3kn1gnX2VaeiOO4t9w3OT1yseEnvgCgdWe4NPBLJlJxAqNDIrZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434918; c=relaxed/simple;
	bh=MZQH1zXJnEF6NTCM+pUacR32OUFSVz5NxC1J+UXHjrk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tiZFfNxxrRy529R1i+YNqOk21MeBSxd9NlDTxh6DAwO2Kt+bAS67pxMJhQ97mf6qK2l3OtQ5sG1FD46fEA8jOh74E0Ygcxp9/5x+7LU+7+a4KW2Oz1t364KIy9Zn/RcmG+mK5PK36rphVLJ7KqwF9VovE8p1K3tY/9iZVmU4I0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoBTw9BX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E41C43390;
	Tue, 16 Jan 2024 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434918;
	bh=MZQH1zXJnEF6NTCM+pUacR32OUFSVz5NxC1J+UXHjrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoBTw9BXg9FctsnP2kjmuQt9yIw3QMXdoG1RMLLGEyb+lsPWiWARRI3xPGve+JqjZ
	 hxkBjl1YspAB9YA2z6tP7g88+pW1MkcgyJ0Xx44Kl+v/K3suA2XwbfeeH93cQ82RWE
	 s2HGQiTZv1t+MAcwNhTN53mvRla18La62f5rGZwNiRZj2RWscDo7taxS9OGghMjqqh
	 31hreo0NkdenoWALEwUakPo/ni2VOlaTEHoTC8cs0Kjg5h4z4AAh9Rw95rnCsKOGNa
	 EZyy6MpobL3kIyhgOFzjT/brxidBIrMADl4UJAm53veIxYfYeSZBeHZR8+kh73Ac7T
	 kxFz+n3o1w/yA==
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
	lorenz.bauer@isovalent.com,
	iii@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/68] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 14:53:01 -0500
Message-ID: <20240116195511.255854-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index d711f4bea98e..47cb753ef1e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5211,6 +5211,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


