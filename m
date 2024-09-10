Return-Path: <linux-kselftest+bounces-17582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E10097397B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EF91F26B8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829411940B9;
	Tue, 10 Sep 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqBdauAM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572F188CBB;
	Tue, 10 Sep 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977601; cv=none; b=XLjvtNlyk7qutK71NdPGvsO6k17udREOoj/sJu6g/HTEQROWyHjzcVVFDwzjYSXKu62pT6tL0pzOnvCEFvXb0DfTKgBTJjXKwPvISiz3lsiXN4a6QzYR1TprWC04y/5koDYYYcJXEq3dF9KoM60G+E/84to+b0gPK+M/v8Cd6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977601; c=relaxed/simple;
	bh=EY6C6vC2fDW5kBoYe1ZRGlO69fKhrWNRx78fdUOVLH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YFW3Mftwd6B/M2vUTR8kn26tRvXfSp70l5TIEW+5lobtYGk3GjjBCouxW4uLNjQsH7PgzXg5H9mrdKtTbQebdQVLCi7x/JaWBZ6kLZwIu2Pl50ck2wBQIYKfzVOrANsiuD8/5GiS7H9oft7yRt1DPleC5UdbjQaByFWL2yX2iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqBdauAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643EEC4CEC3;
	Tue, 10 Sep 2024 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977601;
	bh=EY6C6vC2fDW5kBoYe1ZRGlO69fKhrWNRx78fdUOVLH0=;
	h=From:Subject:Date:To:Cc:From;
	b=eqBdauAMqqCsiuy6fpjVOTN71eKCkwV9f43DGVMFIaZBdCQ7bVzA9ZkJPNg+w3Yby
	 NgtqdPgvKlr3zSHZyNgRC9GKq9Der930IECgw9xU/xSZKqIY5UgrhUqPhGeZwCjZ0Z
	 ZsrlsGI9ZtUNDF2rgc/E8wxlP4jJkxvjOnDKo6jaCuVmilxnJWbX9wragzOefdJv0V
	 w3MvlKr14SU+8zNNl19wSToA0ifayETp9HWyY1CvsXoT5KTfQ4hblft1M1xAVS0O81
	 Igbomssb1GygoJl1rDiwgotmLcDgbYOBanX2ts11c8ug9TyFRLyoc/2O515LIIFs+m
	 0LvYA4v7fUYLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v5 0/3] selftests/bpf: new MPTCP subflow
 subtest
Date: Tue, 10 Sep 2024 16:12:58 +0200
Message-Id: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-0-2c664a7da47c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtT4GYC/5XPwU7DMAwG4FeZcsaQpU7b7MR7IA5J6mwRWxolW
 Rma+u6EChhopx6t3/p++8oyJU+Z7TZXlmjy2Y+hDvJhw+xBhz2BH+rMBBfIJW/hHHNJpE9gooN
 AlwK/0SkWGyGfjTuO71AoF3CaXNtKNE43rJoxkfOXpe+F/QhPgQp7renB5zKmj+WYabvsfOPdy
 t5pCxxIGGsGh6qX3fMbpUDHxzHtl6pJ/OXVWl5UHjn2Vijs64N3fHPjO96s5Zuv681gxYCq1qg
 7Hm98z+VaHisvDFrdKoVKNf/4eZ4/Ac/s4LIWAgAA
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
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EY6C6vC2fDW5kBoYe1ZRGlO69fKhrWNRx78fdUOVLH0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4FP6e5Bh0Pe45sPEbqyoxtomJKdLusq6++O6m
 6FZ6oKhy26JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuBT+gAKCRD2t4JPQmmg
 c3vIEADmiFZuICUM3vrvYZm5gz0vZts5fZPDDFipnAkCvz1BzYpTOptUEJpY5jdnJqui1isYYbs
 B5YmEDQKQ20q1ygtMetXM1JuggFS2YOX1gLsGgr5Ssc2UkfOV6ZqDZ5LG6RTy+FMTgz+xF30nVH
 obBnTzw++PPttYuK1QuF1C5tFWNAxCr5csri4rk3FfM4c8rZQlujA6nwYOZOVrhLCULiTNPot8o
 sRb7JNnWwrkBO3rJJ1VJRH8hXvP5xxR696JIQYhIiNTHxp2ezVZFmehtMerITc+UlRrcLyxzaSm
 ivSwkdLlLM5Px1PICMrxl9mEbSt4JAdzd8Hfv4t2qZc47VlJVpRaE+YBFgwMatpUZ8U9Kb/v8Zk
 mwYBZq3viSjVBZzRBTCKsPn0m+wc/SY7Zvv6E2d6huVucGWLaVki5MhC/iqZLGVeX+H3wBtsTGI
 Rhi/wb3mZTPK/j95Zk/4Rux/ev+wMl1Orf1eMTssqcZqGLsNPgXVSlecqvm5Bk/5ppJUW15DGDh
 yw/7Sjhjdt9uGYoEva1rRPcQswzGwsBl8WApCvS14dDz7PTeKLDULF95CODSO6W9HDLso7CZeHO
 6BT1ANxLok7hMHFzqqsxmI1AhfFRvXvNHv+0YH+rpHOArozdI/cHlFTCCKIQob+sWMc4R6wk8Ca
 twD6O+W+PNiZz7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, modifying MPTCP BPF selftests, we have:

- A new MPTCP subflow BPF program setting socket options per subflow: it
  looks better to have this old test program in the BPF selftests to
  track regressions and to serve as example.

  Note: Nicolas is no longer working at Tessares, but he did this work
  while working for them, and his email address is no longer available.

- A new hook in the same BPF program to do the verification step.

- A new MPTCP BPF subtest validating the new BPF program added in the
  first patch, with the help of the new hook added in the second patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v5:
- See the individual changelog for more details about them
- Patch 1/3: set TCP on the 2nd subflow
- Patch 2/3: new
- Patch 3/3: use the BPF program from patch 2/3 to do the validation
             instead of using ss.
- Link to v4: https://lore.kernel.org/r/20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org

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
Geliang Tang (2):
      selftests/bpf: Add getsockopt to inspect mptcp subflow
      selftests/bpf: Add mptcp subflow subtest

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

 MAINTAINERS                                       |   2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 126 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     |  42 +++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 128 ++++++++++++++++++++++
 4 files changed, 297 insertions(+), 1 deletion(-)
---
base-commit: 6b083650a37318112fb60c65fbb6070584f53d93
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


