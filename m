Return-Path: <linux-kselftest+bounces-3123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4282FB40
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2893B23730
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F3162E3D;
	Tue, 16 Jan 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyrZMZXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E03208CC;
	Tue, 16 Jan 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435395; cv=none; b=dR0p9Umm3hdSGISPUcCd646Xc9iLxtZKOph9juDlHvHCVsOBUFAnrNjy5+9NaJN0A/dShKlmoObF8xC8oj6Nv2EUbysWH4UoxDkQg7jDVnKgQkYYUuFCVyaUjTzbvrCz70VvXLnUZfGIhzum/syntF39B4SAkaLVWcdeKyDoWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435395; c=relaxed/simple;
	bh=BwnwBU7JWyvjjAQpV6uUNVu5W+f4CEV6UTTxNhVrl1E=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=UNSeNe8zG+t4CsPOMMH7JOO8s8YkLFl6HQMWZPByQ0/+LxRWL9J5E96EroIbiYcVrRhRm6+InvOSeXS1D69vRhl/CVLIhM+pCcUesBPkXP+hCGsARnvzYditbg8I+nmgIIbzNs7ZBeuqpag++UTVyTnEpc1yrjXu+0CFmyXEmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyrZMZXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400F2C43399;
	Tue, 16 Jan 2024 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435395;
	bh=BwnwBU7JWyvjjAQpV6uUNVu5W+f4CEV6UTTxNhVrl1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyrZMZXJ6+1R8E+AYko4ibZunxDRjwth3Zs9b2795X5Wvxo9nIXmwxfg99TrknRgj
	 /vZprhojIxs+qcgrXeD1oXrcZ9ssfa2dWyC8YkzQYi8Rh4qMKiXnt3xvnj4Y5iphPA
	 aEUSRR2ngviszUXysBKuuIFDlTrTOPYbsca5gFRyoZTHgpJRhfd9MiwkWmwnnb5h5f
	 uh/yajhKnXUwwC8Ani9EvpQMSJ9MhySxO8TVjpebdZjMy7e61ufLsie84NVEa9QRkI
	 uoynDmRcbOoOLveNYDkaucRbfzpvhGKsp8H5s371bcaMGDiKV06NQMnrxMtuWjyK/Y
	 jFz0ffSxr+mbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/31] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 15:02:11 -0500
Message-ID: <20240116200310.259340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
 tools/testing/selftests/bpf/test_btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index f641eb292a88..a821ff121e03 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -4663,6 +4663,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


