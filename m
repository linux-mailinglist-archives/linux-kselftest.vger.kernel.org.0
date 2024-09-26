Return-Path: <linux-kselftest+bounces-18407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DD987852
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273ECB29153
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CEC157490;
	Thu, 26 Sep 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWJ7oJRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B62914;
	Thu, 26 Sep 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371837; cv=none; b=sITt0enFOnrWS55GXlC3dQjjiny5+MirbLW+Xj4aiqYbEcRpgxCdc2X+IwkiVxT4C/rYXkjnHFLzY4EJeGgy+6p5QusSkmQ6i7PDs6K8eNIbHbHvuPyD2TlC1Y3BFhJPlJg2TvoVgHA3PTjXTufA0ZjjmlzpXZxh/msEtMTl9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371837; c=relaxed/simple;
	bh=itH3BLLt/E93r0jglYDQgk20VgtGtItF6syHN6A0AOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YRl9xrp73PvIPMjtTyDTYN3EeEgFnB0YjVbHwAQwSwzEJNSTx6Nf5rAIrqmWep1CJ1FFDaEZvIkZ5Epc1m8XqRN7fbV19DxmL1AyDd/+drRfg1T2aMIfam2RovW/VlDgzM2rDNJkxjkqiggQ20t9VpTIsHQVmAh+zfx3Y8WtfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWJ7oJRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42819C4CEC5;
	Thu, 26 Sep 2024 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371835;
	bh=itH3BLLt/E93r0jglYDQgk20VgtGtItF6syHN6A0AOs=;
	h=From:Subject:Date:To:Cc:From;
	b=RWJ7oJRjlTREds+kKyndnuza4N+SXYCHv9HybZjWJ4iM7K4QQS3F4i2YBZ6xGoEWm
	 +HClg1LnG2rc5JNHN1lQEZnakoJ1xcFMNgELYPKI1QXy4dhMAUmqi2DLs3KuQCJ8kv
	 iFZzc53iakR66Ow28mfan6hXgoWw898T17glj5zAiexACQmKb5qgXwI+XP+qz3O7FR
	 2+wuee15QATgbZle28kmzsArF03SKJrMjR+2/NwceQW5jYQYPRVW6XVOv6H/nqpFkf
	 yKO6JciQzL+MkYKzHoW+7cphKdq5yZNjaXqxfRwYR8IYlkVHfelvyEeJHR2z+hIG5X
	 wwa09v3HRkVCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v7 0/3] selftests/bpf: new MPTCP subflow
 subtest
Date: Thu, 26 Sep 2024 19:30:21 +0200
Message-Id: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-0-d26029e15cdd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2a9WYC/5XQwW7DIAwG4FepOI+NEAOhp73HtAMQ00Zrkwho1
 qnKu49G29IpJ46Wre+3fSMRQ4eR7Hc3EnDqYjf0uVBPO+KOpj8g7dpcE844MMEkvYwxBTRnakd
 Pe7wm+tc6j8mNNF6sPw2fNGFM1Bv0Ugqw3tQkm2NA312XvDfyK7z0mMh77h67mIbwtSwzVcvMD
 64Kc6eKMorcOtt60I1Qrx8Yejw9D+GwRE38kdelPM88MGgc19DkAzd8vfKK1aV8fd/eto63oHO
 M3vCw8g0TpTxknltwRmoNWtcbXqy8rlgpL+68kxKMag0ot+HlI1+V8jLzqlE8v96BlPYfP8/zN
 ybCvdfUAgAA
X-Change-ID: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3
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
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=itH3BLLt/E93r0jglYDQgk20VgtGtItF6syHN6A0AOs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm9Zo25Jz4FjSIqmemVcDlXjKtwVSpUflKS/eyV
 1hLunI58juJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvWaNgAKCRD2t4JPQmmg
 c9EDEADJiDYVq32na0xQ0tWnoD2O3tic7sDWP/vn5unTDIJZ0n42jdivn3YXCZy7Fu/sfJtBPiu
 EBWOvoJCFWMy1NPneqTvXTQ/3x/8A3UVQ3PMt7KJe4Dt+9iYb97BXOeviKO23XYwYMnJ1Nl1g3t
 +nHPV/sw3FMASWLb5iy2SPNRkFIo4vhm/iho5YFAScCNR5utEBqIIYnHqHkoKFtYpKAU3wsETvI
 lP3NktlUoAQvQJdA0PrfjvmnY3aOrPlP662GAtTrYjZ10jR0T/fOa3eP3iouti9D14MY/8PgFG9
 cMyJbGXf+wA0AQoGqIANSlsYgC/8ErTKLObBGBrPjX2MxejrmAz/wf2c4/GlvLDVwXwWE3SDN2i
 BAjSKs2Qa/tqCvbSlZT5i3HeV8ebyoNyC5ShHCZ3c6iqhj+vmVtNqWQas5S3IVASN9rqrOtgNzU
 zTI4V4rR0Ruqc/LCYgq/aloY9UD8E7YPfFQvL9Tv61R56tgDg/vsymItlgO38yi0SubQS/WXNK2
 JHSzXtm8itR63WT+SVMKh1yaIB22MKUvb/pEAA8ECsuZD5OJNsR8m7KEoEXTWLW9NrVBn9kY5aA
 voev1zJxY73+h79ZVblwzO9xy+8+Q7X2oxO2gA0l5ZSrj2sHj2UslBOLefu3lyf4Wl24g7YJlCR
 iIxEfBu/RrboSEQ==
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
Changes in v7:
- Patch 2/3: use 'can_loop' instead of 'cond_break'. (Martin)
- Patch 3/3: use bpf_program__attach_cgroup(). (Martin)
- Link to v6: https://lore.kernel.org/r/20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org

Changes in v6:
- Patch 3/3: use usleep() instead of sleep()
- Series: rebased on top of bpf-next/net
- Link to v5: https://lore.kernel.org/r/20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-0-2c664a7da47c@kernel.org

Changes in v5:
- See the individual changelog for more details about them
- Patch 1/3: set TCP on the 2nd subflow
- Patch 2/3: new
- Patch 3/3: use the BPF program from patch 2/3 to do the validation
             instead of using ss.
- Series: rebased on top of bpf-next/net
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 121 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     |  42 +++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 128 ++++++++++++++++++++++
 4 files changed, 292 insertions(+), 1 deletion(-)
---
base-commit: 151ac45348afc5b56baa584c7cd4876addf461ff
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


