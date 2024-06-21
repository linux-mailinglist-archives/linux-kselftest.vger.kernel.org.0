Return-Path: <linux-kselftest+bounces-12438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C25912285
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E7BB21615
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4EC172BD3;
	Fri, 21 Jun 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1IFKJQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B07171E45;
	Fri, 21 Jun 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966144; cv=none; b=fB3GUk124mTUdmiyDQdqsAmHWkKpkaLKvOEm/DBoN8h7lhYngCTUp/NQhw68z5leWEFxKHRUx7toNIuwDEbYGE5MyzNftGta1KozC06mstjAO65CkaQ733r7q7+bAE4U+MY9JWQyjz7XZHdUM1bj/fyNoFWUezMCNjJJ43srrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966144; c=relaxed/simple;
	bh=AaehpElsu9uVeddHCjSKZkFv2lz1mZQ9H0hLmc4u73c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsZ64IGZzMEJLY8pPhnahvBjcy5VUvqGaPwbr1aCcH5uWZigqwJiJirzRdeMFBr07YE2J4yfDN+3+u52jIbdDqeO3oV7Z/PooPN11XAE/prGaqAeZEl7zyZsKwYQxmL5B/MOKOhm2rD35ISCDuNE3dfOYHGKIkd3eFCO8sNa6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1IFKJQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52462C4AF0A;
	Fri, 21 Jun 2024 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966143;
	bh=AaehpElsu9uVeddHCjSKZkFv2lz1mZQ9H0hLmc4u73c=;
	h=From:To:Cc:Subject:Date:From;
	b=i1IFKJQQJfZ1WrKtBjvjmZJQ/Tj3gx9fdJdF4gxaUEQ/vIL1qg/KCLe8Kfxcnftnq
	 JuUicy5mqzUUhvj0D2HwNGxpxE6XY0zsqg4GhSb7jsbPvN4FoL0XDf1N++EqXhQSl2
	 j4MYmefL171nqXytJGIRcJawCBvacmO58Ez3dzxSeH5QMS8oSVoBTNMvOSzWhWDRDF
	 PwIjtsVpFRu51cownUiXRER3kMemUXc8ZRVuzWFkgPARX5trOR6fRPFxEDFPfar1a4
	 VFnYJ0pPnT2xnf1PgNC5M+b4vZNg7XMV8JYAp/HreXI35/AuLFiTT3iVgby4kTmy6B
	 sLaSjWczuITNQ==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/6] use network helpers, part 8
Date: Fri, 21 Jun 2024 18:35:23 +0800
Message-ID: <cover.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch set uses network helpers in sockmap_ktls and sk_lookup, and drop
three local helpers tcp_server(), inetaddr_len() and make_socket() in them.

Geliang Tang (6):
  selftests/bpf: Use start_server in sockmap_ktls
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Drop inetaddr_len in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 .../selftests/bpf/prog_tests/sk_lookup.c      | 144 ++++++------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  32 +---
 2 files changed, 53 insertions(+), 123 deletions(-)

-- 
2.43.0


