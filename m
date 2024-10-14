Return-Path: <linux-kselftest+bounces-19652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C399CC44
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303F21C21B3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E851AB6D8;
	Mon, 14 Oct 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knvcTohY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186C1AA793;
	Mon, 14 Oct 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914808; cv=none; b=pckAYVHzsFACEOkTRPeKx1PR9FtniZSrJ0bGbyhkdM2chHTRbw6oN+Yq5Kv0DYxY2XgV0pTJP6AK0e7mVzUX0PY+XyB3glwVBaq9iYZXxVjGoFkaPiCPduEQgcCyJHNXlUwel2bp5PW9T0I4rCAKYjEGFqMkdXIMPfj75sY/808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914808; c=relaxed/simple;
	bh=uVnPvJtdREsRxDsoD6i65l7uYJYrToqneYgiuuHqBxw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XnFbeZ2lkGspukpPEfLsQRJYl4eispM+fQIK0kDMsE9mSo6xnMCuTbDka/WtNz4AYbml0YZuUqrcpauB82ikq4r6RPT+DqfqrrvtEwJZrBZrkw1pk40xf2UyO2pSfHVlY8PpOLUCT5tZqGLKOMsvqj5I6d7EMWBlBgvx8H0uc6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knvcTohY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3CAC4CEC3;
	Mon, 14 Oct 2024 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914808;
	bh=uVnPvJtdREsRxDsoD6i65l7uYJYrToqneYgiuuHqBxw=;
	h=From:Subject:Date:To:Cc:From;
	b=knvcTohYL/2WTKs1eK5goDErmbLsXy2dpmydbOjrXPgouZKsa3T6aPfjg0RwZpkrE
	 /bj0d5y2zKSRpJ2TZ+DGIC/rtafu/8iR1d+HHMn7CK/njgu1izbGX6J8kEk4JQiqXZ
	 6te/4bb17wVgpNsaiM3JR6/Z/9acUafsFBL9cK9IocHM6C6XS2eynKdA1bG/uEwon7
	 hplFrvItaFCF2+pMrpyXqaYjZn986AplRfGGDykvVkwHSsqJodhCIMIPuwP4fQ95CT
	 dAY/pGJHN4os/rg90BGuGRtxB0Ph/+sdchM4uRGYQizQSqbr0Hek/WG0snRj00EWeI
	 9elBCu83RPB1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/2] mptcp: prevent MPC handshake on port-based
 signal endpoints
Date: Mon, 14 Oct 2024 16:05:59 +0200
Message-Id: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEclDWcC/x2MMQqAMAwAvyKZDWgpWPyKOGgbNYM1tEUE6d8NL
 gc33L2QKTFlGJsXEt2c+Yoqpm3AH0vcCTmog+mM7bveYqSCpxQvSo9ypYIUg6DdnFuDNY78AFp
 Loo2f/zyBRjDX+gFkVkLqbgAAAA==
X-Change-ID: 20241014-net-mptcp-mpc-port-endp-4f88bd428ec7
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uVnPvJtdREsRxDsoD6i65l7uYJYrToqneYgiuuHqBxw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnDSV0dkZ74ozw3od71dlDMjlg/gknau4oOdylA
 Wn76OzDwDaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZw0ldAAKCRD2t4JPQmmg
 c32ZEADhguoLx3kQsQYo6PAp16Iw7+42kWy5/VMYtfT6ah8g3P6FBcv+2at45W8JAhsmGaIluud
 obMgXnqiylarBJjnrpMZiAkurfXXrLXKNjATCtXid/C5SIZN7p3ImvLP4Gu5IlzD0CoaFQnzdc6
 9wLqCpaFONoFdA+rZplinoVSlN0EbaixXQENrfrWy5l/HQDKXepvSaYq6m6Z/DJLLyMVNbkcfui
 ILM9lREBxvzsF5iBS2wzdy5DYMCfkS8l+Ik6phHFMd73k7h8l97kHMfaHkINHf2MXRE6zgX/nIa
 iiiiGYNEteqNSEwIhyI/RIe0AKTpkNjPJdRwSDh/KSBqzEOGkYGruf4+Jrs82Mjjeu8UR1UMx4M
 Nz0GRdCPtyVdV1+EyHK1yXeETusqOPC8Lf7osW6GIurhqolQlxR36ejVcT3M7h9ukK+XIBXmf9y
 o8g5zRbDwVqH/E9qp9aQpoVJqhzmeo5UJJCTR9Q+wq4tiBeuY5Ji+4q6MQPzVrmnlZrf//qp8Db
 wHI9clmkfuiGfX3/GyEMdjRBIFl32P6/yhWns9MpuERW0FEAnW8QnCroHHoYqHZFhIL6bI/G5oA
 DJgxAjkByCdanE7kGvczbdB35P73tlzbuSw2+9weXbjOdcqe9ncesW2Xm36zfdiVJrf7cSfG0i3
 Nk67piBvBJdebiw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

MPTCP connection requests toward a listening socket created by the
in-kernel PM for a port based signal endpoint will never be accepted,
they need to be explicitly rejected.

- Patch 1: Explicitly reject such requests. A fix for >= v5.12.

- Patch 2: Cover this case in the MPTCP selftests to avoid regressions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- This new version fixes the root cause for the issue Cong Wang sent a
  patch for a few weeks ago, see the v1, and the explanations below. The
  new version is very different from the v1, from a different author.
  Thanks to Cong Wang for the first analysis, and to Paolo for having
  spot the root cause, and sent a fix for it.
- Link to v1: https://lore.kernel.org/r/20240908180620.822579-1-xiyou.wangcong@gmail.com
- Link: https://lore.kernel.org/r/a5289a0d-2557-40b8-9575-6f1a0bbf06e4@redhat.com

---
Paolo Abeni (2):
      mptcp: prevent MPC handshake on port-based signal endpoints
      selftests: mptcp: join: test for prohibited MPC to port-based endp

 net/mptcp/mib.c                                 |   1 +
 net/mptcp/mib.h                                 |   1 +
 net/mptcp/pm_netlink.c                          |   1 +
 net/mptcp/protocol.h                            |   1 +
 net/mptcp/subflow.c                             |  11 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++++++-------
 6 files changed, 101 insertions(+), 31 deletions(-)
---
base-commit: 174714f0e505070a16be6fbede30d32b81df789f
change-id: 20241014-net-mptcp-mpc-port-endp-4f88bd428ec7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


