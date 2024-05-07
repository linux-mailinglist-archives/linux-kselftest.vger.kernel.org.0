Return-Path: <linux-kselftest+bounces-9585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A58BE033
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 12:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B911F22BF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF51509AB;
	Tue,  7 May 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc2l0Tl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3214EC77;
	Tue,  7 May 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079220; cv=none; b=mJ32/EGIMXbIDcg8YjjGHQ6eO5cePja9B9ukxJxuLIOCmDQDeuHPnOvB/+7f07hi0gXA3dY9swAwlmfNyVD26dL2SrHeHaPFpnGShxng8TX260vt/As0JDAf6MrQ1+8I4is1ePA4GT6iXRYcCSsrkqOYXST0v5EQamqP8PrxVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079220; c=relaxed/simple;
	bh=DDtXv196sRdXkSns3p8qkThzlerAR6hPwCoy0eKwf1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L+0PUEARI8xpNcdaocdYNaQVsTlHM+2PJgq0rAT12KxlBHC7jOlhXi0R+M/Vp8x7dwHKLtOeeJ5CWUAhabY3NK1s54Qf6xPSEyve+N8/bO7hXTNO6d+MOZm3RP/82j3cfB3eT7bSOBF+hlwyNt3nTlzQTYLUa3mWWupTPLa5cqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc2l0Tl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4FC2BBFC;
	Tue,  7 May 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079220;
	bh=DDtXv196sRdXkSns3p8qkThzlerAR6hPwCoy0eKwf1o=;
	h=From:Subject:Date:To:Cc:From;
	b=Lc2l0Tl52xnX1scDwjpbITc4zdvgHvkTeYIdFY8HCHHaXfKCAHcg4kdXNxM3WSN0i
	 gc31g0jkfUwF+lsF58lYqbdu1djXAcCiA7qHy/bWU/h6g3Hy6M6AzCS13SwZ//Y/aj
	 0g8c8PtEgexm/tKf+GgQLsOZa6TtyMxFkBMzergRoOIOOlro/N4F2UhdguKZinWjXK
	 5Z1PBDFGwfnzkiwg0gxwyjolJsY3VPJO7cG+aK/8fNRsaup09H7dxEfJFtlxmKQM44
	 R6vdnkjPJHeIe8ErtXWD3o/PbMJOY0xyOC+XYDMagQDwQKYiQnHhPuwmPnlMtGTDBv
	 t8Dl1jI5B8TEQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next 0/4] selftests/bpf: new MPTCP subflow subtest &
 improvements
Date: Tue, 07 May 2024 12:53:30 +0200
Message-Id: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoIOmYC/z2NywrCMBAAf6Xs2YXYRw7+inhI2l0N2HTJbrVQ+
 u8GQY/DwMwOSiWRwqXZodAraVpyhfOpgfER8p0wTZWhdW3vBudxFbVCYcYojJk2w7+axUZBXSM
 /lzcaqSEHYu+HPnLooDalEKft+7vCrwC34/gA2ZwZXYkAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, 
 Nicolas Rybowski <nicolas.rybowski@tessares.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DDtXv196sRdXkSns3p8qkThzlerAR6hPwCoy0eKwf1o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOggtO/Cqc1Fa0yeK9U1dM6TuwUP3NS7h5UWQL
 /9w5S4BGBmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjoILQAKCRD2t4JPQmmg
 c+7sEACXzbvsXdwki+w0gLTftwninrBAg5VPvkKu6zYdk12OO4hptnDsYhF8lhAlVwlzAXQEhbm
 bdzyKgf4F3DCDPTuQuDeG1mEquvx9K8DtVOKf2EsXrUZsRwnp0+Br5JPA6MEYDmRTOrKnBepLXx
 ZXVQPLd1ISdFgHCyRjt2eb3OEBDp0O6lQxrxEZZwS3PKWtg/0H2/niKwKMKP8OZh7yFgnWGZDNi
 kmTOZEaH9tIhMigeJUV5iVIhz+mXr1XHXTD2DPI8DMPPfMGodnhDBRrQwnl+syg5k2xITETu2yH
 qPS9+3NZutNaLv7U+jfJCBlRykD8sv53Q93dieWRh6saG7CaRWHmFXTOyVlxFiMqHWZXWPwa4q9
 kMexvQkimZHp0nzQ9TvPhIm51QyunMlHQg34KCaRHoCDgfGtocecAZ82PvhbSFbghUQne6xf595
 4ScH71GNWejxWdyUIgTELIdQxeXlTlloBk+bcmpPj/9bFCg3557fgmp0T3POXcnbPzdvNqVC7dK
 TFkLAuLnNNYq1uclD7eia1Qfa33cANUX6kMM1wZrnfkfm196UJpKgVPt0Ak+84mm6sJYsJqZejU
 OPoNpaxV6dJAjPXBWVAKdtK3Tg7qS52g+N/GipnXNOh0w8kbhSEk6C9976xRvtT4WAP7X5ydHqk
 0/134ECvKFsarpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, modifying MPTCP BPF selftests, we have:

- SIGINT support

- A new macro to reduce duplicated code

- A new MPTCP subflow BPF program setting socket options per subflow: it
  looks better to have this old test program in the BPF selftests to
  track regressions and to serve as example.

  Note: Nicolas is no longer working for Tessares, but he did this work
  while working for them, and his email address is no longer available.

- A new MPTCP BPF subtest validating the new BPF program.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (3):
      selftests/bpf: Handle SIGINT when creating netns
      selftests/bpf: Add RUN_MPTCP_TEST macro
      selftests/bpf: Add mptcp subflow subtest

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 127 +++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |  70 ++++++++++++
 2 files changed, 193 insertions(+), 4 deletions(-)
---
base-commit: 329a6720a3ebbc041983b267981ab2cac102de93
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


