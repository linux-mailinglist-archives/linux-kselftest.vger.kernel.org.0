Return-Path: <linux-kselftest+bounces-29510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC23A6AC64
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F30417DB96
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD22225403;
	Thu, 20 Mar 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHHcAMGO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17D1953A1;
	Thu, 20 Mar 2025 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492952; cv=none; b=Q/Va7SviK3Dd3nE67o00K3yw3bdpeiJdCbKF1ntALm31nDwjHV/7SSEIJ+O+77nVorAI9iy/KxifZ0ldXBbKgSV1ev9MSV+ykF5l8BQ//9Zr4UQV4jbNo3sLI/O+KP+bzcptbUWds4bwnfNHRTL0q50DhOeNEa0AOubzFqgNaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492952; c=relaxed/simple;
	bh=/+9BFHdLCi4yrHM9Vpmg4VxF40F8p5KFkeboL0OuHTY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fdu3CMLwcCC8WsjebHjEPgK4kwYC1IN4us8Qqn8F1dXBHbzLIPgHjVTIPiqcaiSOzxLSOpp5d6C1MRTk8+VnnuUQ6tl+SV5tUGZUKbSYLJtUxAukF9tvfhwxxDWP8j+MMZabX58FDDFZbOEAWuYBtZBZsRRSpH6jWRXvpHmJwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHHcAMGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE3C4CEDD;
	Thu, 20 Mar 2025 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492951;
	bh=/+9BFHdLCi4yrHM9Vpmg4VxF40F8p5KFkeboL0OuHTY=;
	h=From:Subject:Date:To:Cc:From;
	b=FHHcAMGO64EnmpJe3Qk5cTpAuMUD7ub8FgTlmSUO3w3VaJjXvrdVVyPyK4p6dHnCW
	 z8UvnZfFjGV2vF/jJkNRlIQO/Zhz3tguuVl10gK7KDwk0hKi2xM09o18uHcgWp1u2u
	 1/HBzNsh2d/6eMZ7mL0H1+9vio7Vp4670Lr/7AvuDPV2gpNjqugBGeTp0aMh3Czq6K
	 xkApSzUKuyyztwfecqvfF165wP66FFkCpQh4rUUT6+4WYvmWJ//5Czn0kUeaTWozrm
	 7nZgpyRIKc5ZmYUbD5s81/SNiC1OgscVfD5P5wUsKFI3kEorJ+Terk32g55xr2uVSt
	 XENfN0IWJ7rgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v3 0/5] bpf: Add mptcp_subflow bpf_iter
 support
Date: Thu, 20 Mar 2025 18:48:39 +0100
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdU3GcC/5XOSw7CIBAG4Ks0rEWBvl15D2NMS4eWWIEAYk3Tu
 4tNjHGnm0nmke+fGTmwEhzaJzOyEKSTWsUm3SSID43qAcsu9ogRllFKKtwagRVMPhaPr8Zz8xq
 dpQeL3a0Vo747TFgpiq4qy5IAipSxIOS0xhzRW9hFAZ3idpDOa/tYfwh0vfkvLlBMMBe0qPOUp
 DmnhwtYBeNW235NCOyjMlr/qLKoNsCyrEt517b8S12W5QkD8/kXPQEAAA==
X-Change-ID: 20241108-bpf-next-net-mptcp-bpf_iter-subflows-027f6d87770e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/+9BFHdLCi4yrHM9Vpmg4VxF40F8p5KFkeboL0OuHTY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FURBUia0pErjIDFEx+UDwF+yBS8yXtXai7Jb
 cKddCNbbX6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 cxl6D/4kDNTGbiufxbHXbbAHuxC8oR8HlQ0VCX8GXspHixLuqscuUFnFWlXQsq5kBH3XLXHlWYN
 89lZ5KdzC6IoeCx6WTPdILgyH7aWQmUNo/FPb0ecXT1RwsZmXbetMGxqYqwWzewpCyLCpPEnuec
 DQlSB5v9O3ag4No2dCbms0D52YMr9NsDXIzfaWZwuWPVvW/U+ZHMRbeHtLWu/9QviIQKgDMJOgi
 195qK7RsUbGKL0vaZ9G+RE/DyVu7pMEkWPk5gLZ3/cwH5x1H4boJYGoiZ1vI/19LlNYFpR5KnH0
 Xr5U8wEt6noUkzwkRUfT8t+L8gudHAlClYpCjvx4LLNNgB7cDGf9jylYqt21R8lyFTtM6Zu2cGn
 l65R+aw9AEk/3DAmVPtGz1usrKav+n1s928OyvbD+kvfurJyr8CbriIizsfQZVc9UP3CBrecpjX
 l/Nh+cFimnY7Qty8eoxCQXOGWwwnLHFlA/lQj3bvNTHfPpWbX3QHdmrFacfn6j0dZXjgesabC8z
 rx5WiMuqPLJ5jLzNAs9jbC2phTJgIHp18ySgJViCjz65lbsNWQUkxtGeQFcabOXm/MKpmbRRIwl
 JkQUAcc3fjFCQp0Ddy+eyJYbPiBmsCdL8L7hh+KkVSwKuRKAhpKQ/jDcy1RQA4luyoe5tJoa+Nm
 3Dz57JS5G+2bpfw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a series from Geliang, adding mptcp_subflow bpf_iter support.

We are working on extending MPTCP with BPF, e.g. to control the path
manager -- in charge of the creation, deletion, and announcements of
subflows (paths) -- and the packet scheduler -- in charge of selecting
which available path the next data will be sent to. These extensions
need to iterate over the list of subflows attached to an MPTCP
connection, and do some specific actions via some new kfunc that will be
added later on.

This preparation work is split in different patches:

- Patch 1: register some "basic" MPTCP kfunc.

- Patch 2: add mptcp_subflow bpf_iter support. Note that previous
           versions of this single patch have already been shared to the
           BPF mailing list. The changelog has been kept with a comment,
           but the version number has been reset to avoid confusions.

- Patch 3: add more MPTCP endpoints in the selftests, in order to create
           more than 2 subflows.

- Patch 4: add a very simple test validating mptcp_subflow bpf_iter
           support. This test could be written without the new bpf_iter,
           but it is there only to make sure this specific feature works
           as expected.

- Patch 5: a small fix to drop an unused parameter in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Previous patches 1, 2 and 5 were no longer needed. (Martin)
- Patch 2: Switch to 'struct sock' and drop unneeded checks. (Martin)
- Patch 4: Adapt the test accordingly.
- Patch 5: New small fix for the selftests.
- Examples and questions for BPF maintainers have been added in Patch 2.
- Link to v2: https://lore.kernel.org/r/20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org

Changes in v2:
- Patches 1-2: new ones.
- Patch 3: remove two kfunc, more restrictions. (Martin)
- Patch 4: add BUILD_BUG_ON(), more restrictions. (Martin)
- Patch 7: adaptations due to modifications in patches 1-4.
- Link to v1: https://lore.kernel.org/r/20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org

---
Geliang Tang (5):
      bpf: Register mptcp common kfunc set
      bpf: Add mptcp_subflow bpf_iter
      selftests/bpf: More endpoints for endpoint_init
      selftests/bpf: Add mptcp_subflow bpf_iter subtest
      selftests/bpf: Drop cgroup_fd of run_mptcpify

 net/mptcp/bpf.c                                    |  87 +++++++++++++-
 tools/testing/selftests/bpf/bpf_experimental.h     |   8 ++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 133 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |   4 +
 .../testing/selftests/bpf/progs/mptcp_bpf_iters.c  |  59 +++++++++
 5 files changed, 282 insertions(+), 9 deletions(-)
---
base-commit: dad704ebe38642cd405e15b9c51263356391355c
change-id: 20241108-bpf-next-net-mptcp-bpf_iter-subflows-027f6d87770e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


