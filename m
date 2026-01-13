Return-Path: <linux-kselftest+bounces-48799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F6D15EDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD545300AAEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128A13AD05;
	Tue, 13 Jan 2026 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Undion0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB96FBF;
	Tue, 13 Jan 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262867; cv=none; b=Utsve/TNV1AaLXN7js4agrKmKGFoyqy6j3QZFIWpgvPu39ytw9/yK1Nc64CKuEFhOPv7oW/giTiHhT5dADeXBcsdExvxRV3WmhZ6M+3wLXqEPbohtmcMUi/ZMroDbxeUH7eHy5o0kN+SEkMdonupTbVGA+3JvEX6uC/JrKFtPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262867; c=relaxed/simple;
	bh=oI/Calb0jtNmfVLjaSxuZjGEjQBQevOqBHXo8sW/hgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXFImvkyvfnjxw/0nY+1LJc+YO7ujPe6g+efpNXPITUwej7YnhQ403xnTmvbKCi1V/xz9TLlDA7h5irumVU7maC98DyoEC8w8DD7cEBtSe7iU3sqCzOOC8nHDfantZvSPajvEzv8h05nSIQYxTgDpQ/jKq+da8owYW1oLx2ZmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Undion0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCF6C19421;
	Tue, 13 Jan 2026 00:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262866;
	bh=oI/Calb0jtNmfVLjaSxuZjGEjQBQevOqBHXo8sW/hgA=;
	h=From:To:Cc:Subject:Date:From;
	b=Undion0u3CnwotyOFv3zsS3HtqNSTB3qnnnL1iBa0Ct84E32DngXW4LP9/NJAF7pa
	 j/Y7n1paRh2me0yWVNkhohUOmR9Xpmca6wflF29xXdRiKz35bZ+/4CNs3pbaNisomE
	 paVqkDECEdKTX/kCp6JPt+zmryRlknJOxEW+qnaiv4N6ZdaJqwNcQ2EdWjGjzoahE6
	 +E9IkE+830xZPUtmcd4n3EABf8Fc0VwGlrzCvkbYreVhQu6GL/+0/Tpwtjy+GPnK7G
	 2s88tG/JUsU6+r1gYzCUvwkkxApKQtw6IMjGXnTOKcAPP2nhBbOeEdvS9WruohF/uh
	 F3C7f/KD6eTtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/6] selftests: drv-net: gro: enable HW GRO and LRO testing
Date: Mon, 12 Jan 2026 16:07:34 -0800
Message-ID: <20260113000740.255360-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for running our existing GRO test against HW GRO
and LRO implementation. The first 3 patches are just ksft lib
nice-to-haves, and patch 4 cleans up the existing gro Python.

Patches 5 and 6 are of most practical interest. The support
reconfiguring the NIC to disable SW GRO and enable HW GRO and LRO.
Additionally last patch breaks up the existing GRO cases to
track HW compliance at finer granularity.

v3:
 - patch 4 - s/tso/tcp-segmentation-offload/ for ethtool feature names
 - patch 5 - explicitly skip LRO on netdevsim, it lies about support
 - patch 6 - add enum for the flush_id test configs
v2: https://lore.kernel.org/20260110005121.3561437-1-kuba@kernel.org
 - fix restoring all features
 - apply the generic XDP hack selectively (print a msg when it happens)
 - a lot of small tweaks and 4 extra patches
v1: https://lore.kernel.org/20251128005242.2604732-1-kuba@kernel.org

Jakub Kicinski (6):
  selftests: net: py: teach ksft_pr() multi-line safety
  selftests: net: py: teach cmd() how to print itself
  selftests: drv-net: gro: use cmd print
  selftests: drv-net: gro: improve feature config
  selftests: drv-net: gro: run the test against HW GRO and LRO
  selftests: drv-net: gro: break out all individual test cases

 tools/testing/selftests/drivers/net/gro.c     | 433 ++++++++++--------
 tools/testing/selftests/drivers/net/gro.py    | 163 ++++++-
 .../selftests/drivers/net/lib/py/env.py       |   7 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  29 +-
 tools/testing/selftests/net/lib/py/utils.py   |  23 +
 5 files changed, 439 insertions(+), 216 deletions(-)

-- 
2.52.0


