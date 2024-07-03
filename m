Return-Path: <linux-kselftest+bounces-13139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C0E9268AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E31B1F22431
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736A1891B6;
	Wed,  3 Jul 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ5EHx3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA81862A8;
	Wed,  3 Jul 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033091; cv=none; b=IWUe9uJs85ATphXpwutGc8Kk/SrOkMA3GB9J7p/BIYjHEY/Q9tKi1WhooPO8bL5sR2caDf1R6Y3ZgDA1kuKuYsuXNptVr+I4bX9pDh79cHA9WJ3hA2jdWJIMokqtt7r9c3SxWJf7Z3cP3UQ3awaMxu5BYFUIMCwj1eQDCn3FNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033091; c=relaxed/simple;
	bh=bZ+FF7jFYurRxn42IBLLrS+aiNewIzNM9FuhK9vjhvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OZaZqVbT7X3lp91FZB1GpfvycP5EJvAxaL4CMP4OcuVfMOTG7m+VrHQ5Y57l3efamRaa1TPO00Vj/OGc8/lJFcyOPFzJqUbDSzp5AfKf9MaWMiEjum0TLjyiwGJS0lJ4X3nCy9R6j7WAv1Yg6XSv49rC0Es2cDUkuvWESTwkT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ5EHx3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94211C2BD10;
	Wed,  3 Jul 2024 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033090;
	bh=bZ+FF7jFYurRxn42IBLLrS+aiNewIzNM9FuhK9vjhvE=;
	h=From:Subject:Date:To:Cc:From;
	b=rJ5EHx3yT/x84MN+Y79yBSLQQNELfBNLtHaEYHbiSUUzTSZQMrBOcT+uTmQrwbsFf
	 0x3Df2hpEDmwlR4w4+G664gH+Cu+cylyiWSQI5eyqEWz7avQ+1xPSUYcpOs+0mKv3v
	 o/n2hvo/MMLhx8VwGxJmGPyeCQNn8sLhW7NdSQCKzrjfXSSl+5klcxvBk+wl5Im5+O
	 ebm+IPIfvMc+1nnTS/786z02sMSYZcAWgutHH3MkERWQC/tRvk0FdDf0lyRXRLQITy
	 DZXT+lagNZlVdmLeaUbK0jxDWZMqyLAsf+jOYB1XC/j1wRt1RS0AczYXDEVNKfY8CJ
	 Ug2O35cngApWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: new MPTCP subflow subtest
Date: Wed, 03 Jul 2024 20:57:31 +0200
Message-Id: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABufhWYC/5XPTQ6CMBAF4KuYrh1TSvlz5T2MCwpTaITStAUxh
 LvbEDW6ZPnyku/NLMShVejI+bAQi5NyatAhxMcDqdpSNwiqDpkwyjhNaAqjcd5i2YMwEjTOHr5
 Vb3xlwI1CdsMDPDoPskSZpgkXsoxJMI1FqeZt70o+ArmFplXOD/a5HTJFW/+Gs52bUwQUkIlK1
 JIXeZJd7mg1dqfBNtvUxH75Yi/PAs8pzytW8Dw898ev6/oCEyic2lQBAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bZ+FF7jFYurRxn42IBLLrS+aiNewIzNM9FuhK9vjhvE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmhZ89Fh6xY3cTrKVHLOr6Aa6xHeZRYzLbsRrCo
 Db2pTuDwhqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZoWfPQAKCRD2t4JPQmmg
 c/FZEADRysYPl3rHZhHEBuq0fSIfrla7Q3hKwMXmNu8PrDmG2DfvVTqXVhZoau6S41G7uSKGk0l
 wCDS9wL7ntMJwI/YwpbgvQUeMyBk0SL6hpZMLjHUlGlQ0uEUKaBP4mT9+Fe8Sovc1p8caIzueoD
 3WMvRJjske9O2S5yX69zEJmtfLBzNu7aCV+lqxMhDqeLeIcfJS15NCX5IzQ0Xv1/T7wfsRFk1+I
 6fm6pjlDmpXRYCL2f2htAYL2SPc++CTPRFyc/hssfWm4mDI2EpraSpTOWIbEGtE4ZLA3rW069l3
 VNi9+F7jwsFaWIQYB1NemhRGzJz5mZTcQ2s4CZkOM0OJZWOs2R4H2zqRfuZF24e1/onVB5I3xbW
 EOF0bkzTO2XBTs3EsJbVjJveqZGkz2DT7pw0wOekXrlVPxtY8g0ipfj+Z+GjCmMUSEaalfAaQII
 74W4smE416JXN63ywnisokX5dBKrtBHkiaf5O+Otov/3eXylD7wtplyKGtTqhb00QZafrfnP/F6
 FFrb/cNdcV0yJdV9s95TQqFgYy2KE08j3CncyoRIGDOjzbxWjU/fxUpkpvLzAeBgS+b2v39nJw8
 RmLozNWj7Ql0N8gc+MJ+iMNRfCt/twQwTyp3+/rnUzXVRD+39sN+SMBqesDk+oSeQ4+Atl3kTzv
 vJ+W6whg0mG6mLw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, modifying MPTCP BPF selftests, we have:

- A new MPTCP subflow BPF program setting socket options per subflow: it
  looks better to have this old test program in the BPF selftests to
  track regressions and to serve as example.

  Note: Nicolas is no longer working for Tessares, but he did this work
  while working for them, and his email address is no longer available.

- A new symlink to MPTCP's pm_nl_ctl tool is added in BPF selftests, to
  be able to use it instead of 'ip mptcp' which is not supported by the
  BPF CI running IPRoute 5.5.0.

- A new MPTCP BPF subtest validating the new BPF program added in the
  first patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
      selftests/bpf: Add mptcp pm_nl_ctl link
      selftests/bpf: Add mptcp subflow subtest

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

 MAINTAINERS                                       |   1 +
 tools/testing/selftests/bpf/Makefile              |   3 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c     |   1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 104 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |  59 ++++++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
---
base-commit: fd8db07705c55a995c42b1e71afc42faad675b0b
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


