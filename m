Return-Path: <linux-kselftest+bounces-9790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D48D8C1237
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70281F21F02
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937F16F27F;
	Thu,  9 May 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVRNThQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C753BBE3;
	Thu,  9 May 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269780; cv=none; b=d8ORbPseknwBj8mrp3CwHhbnhag8NxIfvcqS+2y4CP+v7aWr1ZH7TEaB/qHFBDUKD5QqMGhfgxGIumz0YXEVhIbdw3UxzrdmtjP+n5e8nT1cPrFnXuHL7EdAur7X/GFulD8BjgMvaJp9dET2wy330GhJqfXrUJ1i4S9oFwJfmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269780; c=relaxed/simple;
	bh=KsEs8BwruVwGOe9SOlYG6LUOuNIu+M+XW4g+o/m2/qw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ulmnzUBwWaLiikwlifFIttDP6KW6CarJ1Qy506UAnanW6cyAHdbzsgGgA2UYP/LkXb5UCBqCQZEwt7UpUpzJuXiuL2s1+o8XGYTRO93oRs5MTTMFeDjD8zFCouF/KDGIwB5T9hNKssuk4iyRU/XGxYM7mqm8PY/+1dYqCD9uxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVRNThQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB77FC2BD11;
	Thu,  9 May 2024 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269779;
	bh=KsEs8BwruVwGOe9SOlYG6LUOuNIu+M+XW4g+o/m2/qw=;
	h=From:Subject:Date:To:Cc:From;
	b=rVRNThQwEfZwo9OU+9LtVnbOEdy+8KSTo3CQA5DPzF5rB6IJv4NpKhKguSKwCN3NI
	 5nfHu7oHzjdV4oB+o7sRLrRUVcdo7RwbE58HIo0/Isr4cBWc1ZeQIkiewhuct98b9l
	 PnQEWxqArMlBOaJrvQbmxd0Kit50UkIzu2SEjf3gn3TyKc8DvdAZLykBbGHHAik+XL
	 vLe2nWDT8dd1+u6XFNWRsU60N3gNa0b6aFQcJfc4mKi2bZFnCTSB1Z7DXFISpqIb0i
	 bgGk9qAuqNCKrloZFZjaS/Rx/DrOqfTg8BQQdpvy0beI5XB8wloxK5wt0dAiAnEp1h
	 bDr/4TUwW3L+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: new MPTCP subflow subtest
Date: Thu, 09 May 2024 17:49:10 +0200
Message-Id: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbwPGYC/5WOyw6CMBBFf4XM2jFQeagr/8OwaGEKjdA2bUEM4
 d9tiLp3eXOSc+4KnpwiD9dkBUez8sroONghgabnuiNUbdzAUpanRVriZH1wxEcUVqKmJeAPjTY
 0Fv0k5GCeGMgHlJxkWRa5kPwE0WkdSbXsvTt8DVBH0isfjHvtR+Zs5x9x9WdzzjBFYqIRrcwv5
 6K6PchpGo7GdVBv2/YGTySoZPUAAAA=
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
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KsEs8BwruVwGOe9SOlYG6LUOuNIu+M+XW4g+o/m2/qw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPPCOMqIYRhtxns1IvW83WFSmbWyekstgP4Wr4
 RuzOGVay0uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjzwjgAKCRD2t4JPQmmg
 cxeXEADD0XL++TZT5pfXXQ4+qr1Ceh0PWRhwaUCOiUx/3vt5ADEEhslAqE1QiZRu0dEkUENfoqx
 DHZSPOo6rnN9gaoL9iwXhM5I8OsVrZ5vMwru/eTIRvV3OWF+12zgwFr1GKLT+R3+af+hd4uqunW
 dvzWnj5ai4K7NSRB5Rsa6EOYjKzV4xX+pShrqIPK9exkipjwzn4RKTPoBiGoG/vcsl2tCD94/2h
 ZOxJHy9C/HMo+e0+7YwzIA25NWUJDHyRVuVNlGZCi9/o9oXqr98lWgzApEv2hf56ned5qnTud8N
 sTpt9+vGy5AbM1VHAxNz5U3B46BCRxFu+N3jIJZFde7gY5OgmPtE0v2A4Sztdu+h7ClKfc/aiVq
 E4oV54aj37jtayAwdCeusPfCLuz/7omTeTwoOTRc7gLA2J85ORE2rLlLQ4iiGld4eD2+QLyfHF1
 Q+bu9s1rFNlMzqetDRCvBax78ZJEyooxg1s8ubLR6XmCxT5kT58qupKcuzmKTwvOwwcJfF4r6fy
 YxnW72m7aBfkg47NVWBU4B0Zh0SDZE5a9DAYPv9vD93PCw9XEuZokSykHS18a6H5Q59fjfy5LAS
 /vQKGK9ARcuEcP8MShjycyIaRnrFediUKYx1ytCnjUsCkvob/+kWLMc05HlBkqbTAeSk/2NZU8o
 upvf/29ZkuI4OHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, modifying MPTCP BPF selftests, we have:

- A new MPTCP subflow BPF program setting socket options per subflow: it
  looks better to have this old test program in the BPF selftests to
  track regressions and to serve as example.

  Note: Nicolas is no longer working for Tessares, but he did this work
  while working for them, and his email address is no longer available.

- A new MPTCP BPF subtest validating this new BPF program.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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

 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 109 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |  70 ++++++++++++++
 2 files changed, 179 insertions(+)
---
base-commit: 009367099eb61a4fc2af44d4eb06b6b4de7de6db
change-id: 20240506-upstream-bpf-next-20240506-mptcp-subflow-test-faef6654bfa3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


