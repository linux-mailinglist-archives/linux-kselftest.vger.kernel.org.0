Return-Path: <linux-kselftest+bounces-5370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DF861D5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A811F1C230F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4914690B;
	Fri, 23 Feb 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv8xDIxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC97823CD;
	Fri, 23 Feb 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719537; cv=none; b=nWoq1XCobAnsBnQ5j9G/62QT6iZDarcq6FAYWYT5egkXitvC/1Qb4HbUC2+9CKXA3U0JusLf2/45omB9FRtGpxL4NO3VSZV/vhlJlf/sFSAzru9Ehe3b1BPEx4Oh4fLH5JjZuktg7Q/+YUaOpQYtVgL5OhmxlMaxhaQRNDVfMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719537; c=relaxed/simple;
	bh=OSjpPRzTqbZ3a9okUwWjddq7mgz7QRjbWWThZ88G4m4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eNEPTk/8CGtT0zEpffmRaCmb5D1sEu2oFOowNNMEJwp/F4uizm66NJ/H6o+DY9pcJYoRtCjAeit/8swWmxZz7t4zzD9AOJa1DJiJuL3dpvNAdL2PNGHjJA9h8W4K5CslZhVJGp8xuu/RQYmiwLJola4bXDRY1ArefQ0Wmlg9JGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv8xDIxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92795C433C7;
	Fri, 23 Feb 2024 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719536;
	bh=OSjpPRzTqbZ3a9okUwWjddq7mgz7QRjbWWThZ88G4m4=;
	h=From:Subject:Date:To:Cc:From;
	b=cv8xDIxotWY2cM/hqHvIaYn77e/DGw8ySKKlu/Z5ILxjJHCyodGw8ClgUTfzRt4Al
	 MtRfN3y802Gb7EAPdsQP3jIVpHRdHlX3p1d41hUdWLcZa2QZTSlv3QN2/pu3YFQHij
	 XaCBIk8MK4nSxUTAX+bqTr+N7z/Jort4dRnfWUstIiJnbbuVnrIxBVJbpPtpzNbsM0
	 IVDPfo8fjB5KHPZKJ4ru2KZw80IyBIUBmyT/z01eZh8uPMjxQXgLTV7H5e+ybpA2Mj
	 meyZFS+mwvPXyJ9l80tOpw+4xljkOjcanaNI+YWHZTWlImBZGSnLIsJ0y2cKncDTAK
	 QmpBUw/Bz8jIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] mptcp: various small improvements
Date: Fri, 23 Feb 2024 21:17:52 +0100
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHD92GUC/z2NQQrCMBBFr1Jm7UCMpRWvIi5i+tVZJA0zsRRK7
 24QdPEXjw/vbWRQgdGl20ixiMmcGxwPHcVXyE+wTI3JO98770/8LlYVIXFGbVsr/68kFllS0Xl
 BQq7G4zT0wY3DPYYzNWVRPGT95q70E9Bt3z+zbD2kiAAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OSjpPRzTqbZ3a9okUwWjddq7mgz7QRjbWWThZ88G4m4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qwaPOdQQ/ylED+kPthFbTEqIOTcOjIPWCe
 irt0BPH0KiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c/xFEACx+Gxmlr4U5auuWXNK8BBoLvsFJuEVn5L4B3J9+M+NhC1rmRgNvAraqMhT79FQVmIYiqp
 pIUdIMaw2L2ojMr7vkmyza+iouo0EnfhQqfKgfpL1rA8ckH5+iDBQeNovKhUSbE9NdF3VAMvV3i
 tr4aYwV4/T151azt4hprJyaq+d95LBXHyuTGIYtMcqm1QUbPzMn6w+rYLaUaS8Kg9+vjU344yeI
 r7Rbj5FrJxo0O6AUEI5sr8gTV+khwo9568DZj/NCo75Vh5O6m7N199XcLHjbUFaA3JwSZMPRT+7
 PwVJMIksjqiAJ4cWjjQRNylEK2bwHJTPZ2HkWUFkWqDmJihHMnKQr2xMUTNjMCzA+3CCTHSiyPq
 QGV+agGZrfZAE3gN0FZJ8b0Ul04fIvAkh6qNWhObKO3wiiUFvLqkflCXlGYL59Dk0boYyMYCwaP
 dMoch3oDaAx4oPMlxii+cO5t4ieLSojoaif+KzF+1/xW2x+YBQm2kql+NDQbUaQuJL554EHPmDt
 UzSGcBfn0/twZ2wkdFV7AyygG+hygKtGXtJJP2N+ZisPxVIyXOJgu2B0/KA/tEZszdy/2mCtQa+
 yjf49N9ajceGg2y5QazQLt9xpbadGkvtEGUlxVdUCg+JzUBYkZa9Sk9Y4jSmPzWZircQ+N0dz3I
 85J5lv46eB29Bdg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series brings various small improvements to MPTCP and its
selftests:

Patch 1 prints an error if there are duplicated subtests names. It is
important to have unique (sub)tests names in TAP, because some CI
environments drop (sub)tests with duplicated names.

Patch 2 is a preparation for patches 3 and 4, which check the protocol
in tcp_sk() and mptcp_sk() with DEBUG_NET, only in code from net/mptcp/.
We recently had the case where an MPTCP socket was wrongly treated as a
TCP one, and fuzzers and static checkers never spot the issue. This
would prevent such issues in the future.

Patches 5 to 7 are some cleanup for the MPTCP selftests. These patches
are not supposed to change the behaviour.

Patch 8 sets the poll timeout in diag selftest to the same value as the
one used in the other selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (4):
      selftests: mptcp: netlink: drop duplicate var ret
      selftests: mptcp: simult flows: define missing vars
      selftests: mptcp: join: change capture/checksum as bool
      selftests: mptcp: diag: change timeout_poll to 30

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: catch duplicated subtest entries
      mptcp: token kunit: set protocol
      mptcp: check the protocol in tcp_sk() with DEBUG_NET
      mptcp: check the protocol in mptcp_sk() with DEBUG_NET

 net/mptcp/protocol.h                              | 16 ++++++++++++++++
 net/mptcp/token_test.c                            |  7 ++++++-
 tools/testing/selftests/net/mptcp/diag.sh         |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 22 +++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 21 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 ++++++
 7 files changed, 61 insertions(+), 14 deletions(-)
---
base-commit: a818bd12538c1408c7480de31573cdb3c3c0926f
change-id: 20240223-upstream-net-next-20240223-misc-improvements-7d64a076bca8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


