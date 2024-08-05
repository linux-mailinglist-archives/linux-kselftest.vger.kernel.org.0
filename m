Return-Path: <linux-kselftest+bounces-14788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C49478B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 11:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965F11F2264A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51076137C37;
	Mon,  5 Aug 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnBIguov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5B10953;
	Mon,  5 Aug 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851609; cv=none; b=fXN+We9cGg0/fOK7Sps/5v6SXSCUix6Ir7cVokWaVTsohT5un42vfdsFX0ua0mLvXx55AvUXcX4nc8cbB2qzNR8g4SSNpf5igI3nxL6AHp4zt4au3ZtHN7OXcg9zNm8B6oZV9nyO2rvSw/sNyll4B6xUnSuTkOcHIQc4Ichznmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851609; c=relaxed/simple;
	bh=SU0EHwZ6lgMt+LIxNwzJIdzR27SS/eEgLSHXuN8l1D8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nd8U0Ou0QvjU2PVW4us5veoxS4u8KzgP609T62HcxWKqx6xLRSmp8rmxdLj+RRaYwyIAEke/g2jFYAlIV2w/P1K/mLGPlsQzpFWgMNfCjeHZuLBv9T0lRjV3QpAwMLK0CD142gOZ5yrKUsFMnzmK0H4UOCcc5b7RMWTKJ+dJm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnBIguov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B544C32782;
	Mon,  5 Aug 2024 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722851608;
	bh=SU0EHwZ6lgMt+LIxNwzJIdzR27SS/eEgLSHXuN8l1D8=;
	h=From:Subject:Date:To:Cc:From;
	b=EnBIguovbyUcwzkJOJXwWMzn0xNps4zAz9ocN1XAzXUfGjCporW5VfrykVaA1gLgx
	 bhT1iAGo0LZ/AcDKCRFE4Htg4c58MVM8Eobw/2xtWwyYoKe7y2Pa4aTbDzzzR33M/6
	 siW62CHDjROeJLrAp+uRRqXNTV/mbnOyst1/vM0Dj7HGpt1zOASKanhRBEg42hUszS
	 jg0AWub7wvR0DmOuIKaPoJ4oGW7TbbHXVAAtPeXrWTCBsglHTyRXxecLLKFPbN4k1m
	 UNjwlZyyxKbpRi4vj0mRFfuKoH5De0NWvXInNIJO98TXiJlNOjBh2UL/n4fSALtZyI
	 u4RjKBtizXvug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next v4 0/2] selftests/bpf: new MPTCP subflow subtest
Date: Mon, 05 Aug 2024 11:52:55 +0200
Message-Id: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPegsGYC/5XPyw7CIBAF0F8xrB2DlD5w5X8YF4UOLVFbArRqT
 P9dbHzGVZeTm5x750Y8OoOebBY34nAw3nRtPPhyQVRTtjWCqeJNGGWcpjSD3vrgsDyBtBpavAR
 4RycblAXfS33szhDQB9Al6ixLudRlQqJpHWpzmfp25CWQfUwa40PnrtOQYT3lTzif2TmsgQIyq
 WSluSjSfHtA1+Jx1bl6qhrYNy/m8izynPJCMcGL+Nwfn3z4nCZz+eSxXlaKVVzEGvHDj+N4B0b
 rJjqzAQAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SU0EHwZ6lgMt+LIxNwzJIdzR27SS/eEgLSHXuN8l1D8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsKEMQhEAHkTbJuBf+rR7NGABX2J2IuEMznpEX
 SmGcNbNmJGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrChDAAKCRD2t4JPQmmg
 c5rKEADBOjPgICkTVHdgLmnWT8LBxJSMepN/eWpObbvQMKGtVE9PKh9Q40MvD+uu7fnbUQ2xvED
 ovy6uoTHOJzFO0gpxwCdq/TjwSyqOXj0cCFGT6rbkq5BWOX7BNb0OMdLYqx33RtE47LyWLBnlr3
 p7csCM8eQU4WRYueuGbbqn4caQE/NMiRvHtJlSmvjhi+yuOtls2VJcy9K+ENw8sKKDCB4WpvKC7
 bU4TWVXpfZsBgJWxpns1UGiMx1h1ZhFwTtLEVZ7r4ThxjMIL/0CXr4Bu1HQAG812P76tUhqOcIG
 mUqCAB9xhcbQNBf6g7WXWhFKADaS0WtuCmXUtDX8fk2E2ihA3xE6MBmilgTDoWtmOTDk0aLCWzm
 Lg9P357enp/N5FEzo6jGO3u6JkCtbKq0qg2pizhiE73MmDqvyx1ZriZiylTFii8C4OSpBuXlB+7
 YvAAj2gsdzMV2K6J3pZrRCQ0o259yAvMmprceD87O+1gM+nqbYrfVbk2Jjd8hBpdumF7EZXiWXZ
 qnqVrjx5JYGtDgBJPZI3dwUDPPJOfNciEPQN9fptVU03VhkrfAIW/0a4JCS9i1vyzEPbUcXA4Tr
 Zvou6qLMnCHsLebhgPEdCJS3SypvVI6GDimNqg/G6cZ+JcdKAbYQM+vcr/8qoXF+Gyq/cNzzPAu
 wv9ar4/GmRN5C5g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, modifying MPTCP BPF selftests, we have:

- A new MPTCP subflow BPF program setting socket options per subflow: it
  looks better to have this old test program in the BPF selftests to
  track regressions and to serve as example.

  Note: Nicolas is no longer working for Tessares, but he did this work
  while working for them, and his email address is no longer available.

- A new MPTCP BPF subtest validating the new BPF program added in the
  first patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- Drop former patch 2/3: MPTCP's pm_nl_ctl requires a new header file:
  - I will check later if it is possible to avoid having duplicated
    header files in tools/include/uapi, but no need to block this series
    for that. Patch 2/3 can be added later if needed.
- Patch 2/2: skip the test if 'ip mptcp' is not available.
- Link to v3: https://lore.kernel.org/r/20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org

Changes in v3:
- Sorry for the delay between v2 and v3, this series was conflicting
  with the "add netns helpers", but it looks like it is on hold:
  https://lore.kernel.org/cover.1715821541.git.tanggeliang@kylinos.cn
- Patch 1/3 includes "bpf_tracing_net.h", introduced in between.
- New patch 2/3: "selftests/bpf: Add mptcp pm_nl_ctl link".
- Patch 3/3: use the tool introduced in patch 2/3 + SYS_NOFAIL() helper.
- Link to v2: https://lore.kernel.org/r/20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org

Changes in v2:
- Previous patches 1/4 and 2/4 have been dropped from this series:
  - 1/4: "selftests/bpf: Handle SIGINT when creating netns":
    - A new version, more generic and no longer specific to MPTCP BPF
      selftest will be sent later, as part of a new series. (Alexei)
  - 2/4: "selftests/bpf: Add RUN_MPTCP_TEST macro":
    - Removed, not to hide helper functions in macros. (Alexei)
- The commit message of patch 1/2 has been clarified to avoid some
  possible confusions spot by Alexei.
- Link to v1: https://lore.kernel.org/r/20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org

---
Geliang Tang (1):
      selftests/bpf: Add mptcp subflow subtest

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 105 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |  59 ++++++++++++
 2 files changed, 164 insertions(+)
---
base-commit: 3d650ab5e7d9c4d7306e4c116f8aa9980bf13295
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


