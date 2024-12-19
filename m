Return-Path: <linux-kselftest+bounces-23592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989C9F7E5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BDE7A039B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA3225A37;
	Thu, 19 Dec 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km/DHh7f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EF5FDA7;
	Thu, 19 Dec 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623412; cv=none; b=WErmVtjAM3JHN6nndbuLOFk36qoSs5znLk2XrmLJGStLZgP82bntUhc0+fL3cdD46MYaLhsyADD4zwGtE0UBwEV3PLC0PLCcHSRBVfBnAWIUWx02ZVil8zuSABpeBbfbZCbJv9XY2XkzVjftq5/lIB0OE/GhNDUZHuuacaIza1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623412; c=relaxed/simple;
	bh=ByHZDWm/9oQxpS7J0BmM2h6vlsvLdXRtU9K5mcxznWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KSm2Cy8oL6E1xnbMtLWoi15OtpzroMGdwuN4jGO3LWh5F3WB6Urq62w8I2MRRwypePgiQOr63ItQpNHA/YqHtIYFFEIo3egMc7A/ZAbwLES4Dka2+80Qu7s5WylhtIqr6I4Ni5BtT9G/ObcOir4EKtjzWDCUhyMvFZBL3V5PUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km/DHh7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C856C4CECE;
	Thu, 19 Dec 2024 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623412;
	bh=ByHZDWm/9oQxpS7J0BmM2h6vlsvLdXRtU9K5mcxznWQ=;
	h=From:Subject:Date:To:Cc:From;
	b=km/DHh7fATGgr4fBgJLFrps3oW1jJ/IoXaBK1aOP43pW9kXANhozTpx5g51rAwbJ/
	 NgY1hXztqkAmLo6TTpFViQZLVjKdi/KJmc1PIP6LAT9N2QjjMK3Zgw8yeE6QIbs2s2
	 nwwW3f4h/e/LTGfchrGdGDCQbaMT5j8oEOgTHOetXtqJ6kQ1Rb1W6uiuz89ncHlZuJ
	 /ROs6J7n+NyTXMryjKvcJZCKkY6u5y60dWxZEWDLn+dNskn0CkrEnLlYGWkHXbP+wQ
	 +FFxi3XbWr/Bg6ueoRSJInhwAHUEv4ODUaV346Y25A6Xq5VslgUkWoCIk7JZDIiruv
	 kYURjbnzhhL0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v2 0/7] bpf: Add mptcp_subflow bpf_iter
 support
Date: Thu, 19 Dec 2024 16:46:39 +0100
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8/ZGcC/5WOXQ6CMBCEr2L22dW2yI8+eQ9DjJQtNGLbtBUxh
 LtbSTyAL5PMzuabmSGQ1xTgtJnB06iDtiYZsd2A7G+mI9Rt8iCYOHDOKmycQkNTTBLx4aJ039N
 VR/IYno0a7CsgE6Uq2qosS0aQUM6T0tNac4EfYZ8IUKe01yFa/143jHz9+a9u5MhQKl4c84xlu
 eTnO3lDw876DuplWT6QVG5D5wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3024; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ByHZDWm/9oQxpS7J0BmM2h6vlsvLdXRtU9K5mcxznWQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECtpeo+j21fMlV+xLe4gynFHDQ5Np17OQ/Eg
 4CUTEyc1zWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArQAKCRD2t4JPQmmg
 c4NKEACSSRan4ojginG5BBXr1WordyYwpR0I1iG4+qZmflYWqpa7/kSAXGWC8Jq8eGD5PSgv8Cx
 udUhLaywCyTvdSuA9VAVa1VMqNDJn8HOCeMCygAuxg+kJqR/DrLWH8FpttdbjQVW5vzspdcxVBq
 JqplaF6dq7yKPoMtLCmziTHf/OvD1UGxXdangCq9eKtZ4M/M3F75xgnHEOAYCviX6SGuCcfkj16
 jhkWqFp+qdhBHe5B9uomaGxmLyaLogu9pIsB+qqhIszYyLixGdviPboEdlZvEwwvaIVLm/d+Lhn
 IGuzmyuJ9a6BSwcI/aAhjOHvwo0h7CK1HTx0gwWlml4Yu+ss+qmQEXT2FXKprsROyIiBv+JRyi2
 ZcODUquG7/T9FpZvIJrBNuL1WI8qG6CCTHyQPCAp3F//NEscMe2QxfDbg+jzX2i2H96pSfRZyhT
 EZ7Fg1KnQpfNLDKWcaLEd0ovJDbsg35fQbLDXYZvm/Nv3vsOEQ8DGmEcWpKI870IG7+xFAfNIUD
 LJkZF029MLwoij9H2LVQcb0oqO855cMRV7MMEK8ZshVkQa2BR8AHXUwoY6NTGcOVt7F3Cy4KGEc
 uK1UFEApNtsbVBt90p2FHdKOST3bySpEdhiSI+n4SW39kL6gk5iE4NEKBW0w7YUktjM3aFOXJKT
 /gSyR19+w9Lm15A==
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

- Patch 1: extend bpf_skc_to_mptcp_sock() to be called with msk.

- Patch 2: allow using skc_to_mptcp_sock() in CGroup sockopt hooks.

- Patch 3: register some "basic" MPTCP kfunc.

- Patch 4: add mptcp_subflow bpf_iter support. Note that previous
           versions of this single patch have already been shared to the
           BPF mailing list. The changelog has been kept with a comment,
           but the version number has been reset to avoid confusions.

- Patch 5: add kfunc to make sure the msk is valid

- Patch 6: add more MPTCP endpoints in the selftests, in order to create
           more than 2 subflows.

- Patch 7: add a very simple test validating mptcp_subflow bpf_iter
           support. This test could be written without the new bpf_iter,
           but it is there only to make sure this specific feature works
           as expected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patches 1-2: new ones.
- Patch 3: remove two kfunc, more restrictions. (Martin)
- Patch 4: add BUILD_BUG_ON(), more restrictions. (Martin)
- Patch 7: adaptations due to modifications in patches 1-4.
- Link to v1: https://lore.kernel.org/r/20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org

---
Geliang Tang (7):
      bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
      bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
      bpf: Register mptcp common kfunc set
      bpf: Add mptcp_subflow bpf_iter
      bpf: Acquire and release mptcp socket
      selftests/bpf: More endpoints for endpoint_init
      selftests/bpf: Add mptcp_subflow bpf_iter subtest

 include/net/mptcp.h                                |   4 +-
 kernel/bpf/cgroup.c                                |   2 +
 net/core/filter.c                                  |   2 +-
 net/mptcp/bpf.c                                    | 113 +++++++++++++++++-
 tools/testing/selftests/bpf/bpf_experimental.h     |   8 ++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 129 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |   9 ++
 .../testing/selftests/bpf/progs/mptcp_bpf_iters.c  |  63 ++++++++++
 8 files changed, 318 insertions(+), 12 deletions(-)
---
base-commit: dad704ebe38642cd405e15b9c51263356391355c
change-id: 20241108-bpf-next-net-mptcp-bpf_iter-subflows-027f6d87770e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


