Return-Path: <linux-kselftest+bounces-10899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FF8D4636
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626E81F21A00
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A64D8B5;
	Thu, 30 May 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaVUsmKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529C4D8A0;
	Thu, 30 May 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054886; cv=none; b=SxlfGPIlrg9kbftNMOHThQLenvIRz7Tl+5QGV982nOxz35J9qZRTQD+4wmAvF1SzXMzNJZ9ONs4fWz80Af+mLcsz2CnoZNSrcKK6t3VmI9UTlo8TDfzu1XShlH4W+7zu6mNJgXswBfg21b/zxlLEW1FhhK7L15M3i5E6bLQL6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054886; c=relaxed/simple;
	bh=9U5nEZdd1Y0T+h6AXKi3ESI1oRaRrYk/nMTOIFwucpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK9z1xFbzRmrrnIP6ypu5eKvewBxclXGroSzWxcF4berq5Gd2YVDkavvYAK9/p5Vv5NgtXfGzuCtSuZyCsbu7d6Qt5FB6Cy+JWTNrFd4Yye6xDBIk2f44YiuMHwNIC9bfDZaZKJ562V1Yq+eyTd7t53gMB6QVoRQwpHqTJbOyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaVUsmKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9072FC2BBFC;
	Thu, 30 May 2024 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054885;
	bh=9U5nEZdd1Y0T+h6AXKi3ESI1oRaRrYk/nMTOIFwucpo=;
	h=From:To:Cc:Subject:Date:From;
	b=HaVUsmKGuzogfvGJuUxo/AjvZ98P9YyRl+2z+RgccXM9k0E5bpAyTjbw8QUaBn7Qz
	 46ebRL3+X4Vl2Wc7W+SoYsSLXShF4RztPXIvDC5QOFdJK1jHYHBeeEcZh4GkrGOWoH
	 7c2nosHCpwkk9BCILI8W6jqmBNqMaBaOvNxqPsyEivZH0mSuIoXcSB2m5t0NxgMquC
	 oAIuyeQg4hQxUvIglh/hTnkUfLKhh5tH1KF6JbV5bISAH2oQ8GY4pz5ZdEy6J66wFf
	 N+syJDTjlzp83+hniIcpBn70Eyts7HncUDxQTxexWyG2QKlgx0VxGFxPNCL1Y9PPDY
	 ZDYtmm15GnJtw==
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
Subject: [PATCH bpf-next 0/5] use network helpers, part 6
Date: Thu, 30 May 2024 15:41:07 +0800
Message-ID: <cover.1717054461.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For moving dctcp test dedicated code out of do_test() into test_dctcp().
This patchset adds a new helper start_test() in bpf_tcp_ca.c to refactor
do_test().

Address Martin's comments for the previous series.

Geliang Tang (5):
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add start_test helper in bpf_tcp_ca
  selftests/bpf: Use start_test in test_dctcp_fallback in bpf_tcp_ca
  selftests/bpf: Use start_test in test_dctcp in bpf_tcp_ca
  selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca

 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 140 +++++++++++-------
 1 file changed, 85 insertions(+), 55 deletions(-)

-- 
2.43.0


