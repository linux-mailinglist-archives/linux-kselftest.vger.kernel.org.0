Return-Path: <linux-kselftest+bounces-17748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C769756AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60AF1C21F2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86C1AB505;
	Wed, 11 Sep 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etI66wkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8922AE90;
	Wed, 11 Sep 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067806; cv=none; b=CxZx/MoLU4t/pNpeYAqUrzwKucWmQKBz5XUmV8RGT6RYc6FWRx+ySfx8aYCI1kA5lM+dlmGpjRAefVZsIN8CgJi0lItyHxLYFl0avXXO/+CdQdFoH/xO3fYquRhS5wyeca8pq69Eq8m9NpjqR81bLWYTOiaAW/7L6mw/I+2puUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067806; c=relaxed/simple;
	bh=S+MvNjtO0ytOudQaCNbsEFFb/f2LYmj39wai1aL4pbU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pvM6SaVPYKoR+zDIP6zOjgOPyfHR3Sb8HIEZlyJDHmls/9dBxznwUl6ZrdynVssfm4p2ls9n4rjSRnNKO6T5krMlX6Yoau6g/JhsiCPj1i5SGyxGaII5cOVamSxQKwKdHYrHrtIK0IvGAK01T2NbPPlX5rnBbnAQGX5px5Smhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etI66wkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB90C4CEC0;
	Wed, 11 Sep 2024 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067806;
	bh=S+MvNjtO0ytOudQaCNbsEFFb/f2LYmj39wai1aL4pbU=;
	h=From:Subject:Date:To:Cc:From;
	b=etI66wkzVA4DEZzh4ZOwPMEyvpurFg1rMqz64QmiUxP7q7RaqXxrHzbjYkSmYhXOD
	 I+byxGp/zIwheE17qys15yy+LZycgbZGGIIFNCE7tkKG9Pu3ajXUozNFSn6IYGg+48
	 VDobE1s4j5oHjMnIifx0I1j18lSkkgmCphts7iKYggJIHjI9+5iikISMh1bGTCCk2g
	 CmZVwp8Qyp+TzPIvkE0+Zstzh4kTvkVzmwNrTAHsTZKp+aIYBmCZ7VLm73mrqCO/Nf
	 wHqygbR7GG2mAD5WAcKuX3yUY1baEdr1IjuHEDtH1Q4ELuXTFeqlOEzKvYwiXNr1Vm
	 dEnsrN7beSTIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v6 0/3] selftests/bpf: new MPTCP subflow
 subtest
Date: Wed, 11 Sep 2024 17:16:15 +0200
Message-Id: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+04WYC/5XPQW7DIBAF0KtErEuL8YBNV71HlQXgIUFNsAXET
 RT57iVWW7fyysvRH70/cycJo8dEXnd3EnH0yfehDPJpR+xRhwNS35WZcMaBCSbpZUg5oj5TMzg
 a8Jrpb3Qesh1ouhh36j9pxpSp0+ikFGCcrkkxh4jOX+e+d/IjvATMZF/So0+5j7f5mLGad77xZ
 mPvWFFGkRtrOgeqFc3bB8aAp+c+Huaqkf/l1VaeFx4YtJYraMuDK75e+IbVW/n6cb3pLO9AlRq
 14mHhWya28lB4bsBqqRQoVa94sfCqYlt58eCtlKCbTkNj//HTNH0B2RMgoXUCAAA=
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S+MvNjtO0ytOudQaCNbsEFFb/f2LYmj39wai1aL4pbU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4bRYFg84oWNrBXx+cmmchIQ++h1C1EtARPeHm
 eofBNvf4JCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuG0WAAKCRD2t4JPQmmg
 c8nREADLwqZoyLMp383gck64X1CAIasXJH6nbJJ1Eosx7sH1f9Xl2iEq8T5om8VOz29bcm0uVJq
 xVRFM9Z6tcb+UZ9CFHc1NNnKkF9kzRPLswD3CCqfw6vi3cutOJcJfnwdJ0nBMAwXpeknJs07DDt
 4tfhJ8d4EMxMDQjzabuImRUA4VQov7gC1p7KWOxKk5iIO1zCU5jyZePue+aUEr8py0gDmwhCErc
 +TASZo16CUIDdUGG4dSQDGk4MvZX6ThsgLBf/JNtlKVnWHrt2iDEi3JSHuKOsXbY9YzIHuadvss
 Kjxyubh5JPu7f6Z0uFXPAmhS0OfpLm6/PkQsK44PLH49La1B1tIuh8tIY06fmoiW7wKSy8pmIOT
 xbGZaWSFDC+30jlg+o09SsGg6ukOJxEAv0xXF3o8SoQfFIZfq03JMyEqczrWk4i6fWamfSsSA1g
 9LK8mrnBLN3aO93vHTjvFlWuAKztwKyf3oTkXneeVo8Hjo+AF5ooMybPLWclh/ySExOfghkWrXl
 l58YGye4/P5ah90yJh+w9NwOHRjZY9cE4jeISe85T4hgguGuxM9e/htWUhmjs4ypQGsGV4tpPMJ
 dO+UvQHojbYid1Y8FQnPAb9aU4u+ShdmqNUsx+BHEd3YJ8O89A3cI869Htxqu72bOwPzbDj4RdB
 srmm/D2iFKMQ8hA==
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 127 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     |  42 +++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 128 ++++++++++++++++++++++
 4 files changed, 298 insertions(+), 1 deletion(-)
---
base-commit: 23dc9867329c72b48e5039ac93fbf50d9099cdb3
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


