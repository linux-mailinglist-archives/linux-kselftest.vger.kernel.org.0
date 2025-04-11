Return-Path: <linux-kselftest+bounces-30573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2658A85B13
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B467442578
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3B238C23;
	Fri, 11 Apr 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK47s3BL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD14278E7C;
	Fri, 11 Apr 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369513; cv=none; b=d+26oj/eKGmPKMzyNH/jTAHy/NT7p0xgAJnp0hY2NYNaqe2YVIu/HlNcpgB9QucOTKVK2oUcXpNKcfvwi8hC3zvrhrLpB+jUMLjXMMS/pKv5pEv6A86IWgL8KFI6u6iw3GeHIrE/J/QyQBzs2Ihu1KV8VGVPPqc4rRoA+l41ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369513; c=relaxed/simple;
	bh=VtWB41B6yR9gWpr/0ENOCffQUwmUd+NKMGYJW0viGuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBw1iVMMbJ6J/tPyBlFZCfboI5yMiqCeeFVYY4NJasw/QIRuZDirupiJeq0nn7wbpukXS1cnhve2Q4CLnuEhm717nzMFpzujEHESjF1UsgyQh8C9buPmSXKcErMqbaujRB70c7gepTm1oniGcnmEer4NvIubrx8xWX09qg+1d+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK47s3BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE49EC4CEE7;
	Fri, 11 Apr 2025 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369512;
	bh=VtWB41B6yR9gWpr/0ENOCffQUwmUd+NKMGYJW0viGuI=;
	h=From:Subject:Date:To:Cc:From;
	b=GK47s3BL6TO6eSZI3cYIgxhZoPvS7Wma1lrZ+A08QkDZyqVeZZn8Rnw6hklmi6byZ
	 0+4iFZIJFX13ewBtGomzr8auNxI2/VtjIPCLXGkH0XG+EB4elfnqL5PNTf7HJa4Pzh
	 pmuyPeh/F9P0KG6StG6tivI7R7XVdv3MpOPtcg9cPcl2oAJ2VK0I2gp4lnL0jRqNpR
	 JLVtGnVrfSkiO+3dkI8VHHpvGkmIiwxkLE/3go95Rgq7e0mSRXYOffjWV1DXyAgEPa
	 DVY7cG0e5rIpSCdM3qxhLBP/qzZvFEE2nyfzurE1Qz/obzDDFQpWqWxKWOprIqTHyq
	 S2nZdxGJxvYKA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] mptcp: various small and unrelated
 improvements
Date: Fri, 11 Apr 2025 13:04:46 +0200
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE73+GcC/zWNwQqEMAxEf0VyNmCLFdlfEQ/appqD3dIUEcR/N
 yzsYQ5v4M3cIFSYBD7NDYVOFv4mBdM24PclbYQclMF21nW9MZioaq6KR64+o/idAh68okTtWDx
 aF90yWDPGMILu5EKRr9/HBH8d5ud5Af7aO8x9AAAA
X-Change-ID: 20250411-net-next-mptcp-sched-mib-sft-misc-25f5a6218fd8
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>, 
 zhenwei pi <pizhenwei@bytedance.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VtWB41B6yR9gWpr/0ENOCffQUwmUd+NKMGYJW0viGuI=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+Pdb5U2bpBiBfEBZ3e2fhQE9xAp9KPrNpHv4k
 o5YsQkT/+SJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3WwAKCRD2t4JPQmmg
 cxdbEACNQF5NuntG/ICbN52UfBKTLU7VYnvCPK3Z/k1NcInemjL1RrKTFm5nzPkou12IQr85Usz
 8HJrxerrj64vW/gGxy2r7mC+TfgrEPULzWCibUJ1/Tge9DoBZHvYdFtxQqGEnHztuxg1R/K2FSR
 NYv+Hyjie8D413PIJrFgrj2qEdVWsbR3pwATd1Ee66EwmEA9I/8vbaCunsmnRM00hkBTN9rjKpD
 xkntUZiNJsszsP8Y+XyNlunwgZQ+zGhiknl+A3vVC/mE6Zlxggax4jG7zRZHVYYPRtR1tWIA153
 izmwsN5QWIbtVySDOjhJDchBrXx2KL1hu1nOdKU9L3rAtZ/6KMXeD/OwbF2O+QsJG/ZFN4/RHVw
 i8zoEHr0rqzSMq0rj1D6eh31feTfHXXnmpY+u5FdHUQhCyIb61L1gLW21IT6XwCZFaOEZutrWZU
 xfkDNWaoLC7watL1+b59Y1MzARyZDiKXGVPlrDVBesdfFtJhVg3lrvjylx5QnnJ5szH9xw6QFUj
 jF5IZA/YIhIPiWpsbTMmKdnmPqf1Zst79yKZNBTKhUc54Yb6O0LSUXlFA+NTX4N/OLK5v1ajQ4c
 2gYhQcfOxF9aKqFZHnHoIinzAT5DJnCcvabiBvZ1hYPhWi246d3RCbY8OBaE672dGhRIKilo9Kb
 xlJ2YFfge6RupIQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated patches:

- Patch 1: sched: remove unused structure.

- Patch 2: sched: split the validation part, a preparation for later.

- Patch 3: pm: clarify code, not to think there is a possible UaF.
  Note: a previous version has already been sent individually to Netdev.

- Patch 4: subflow: simplify subflow_hmac_valid by passing subflow_req.

- Patch 5: mib: add counter for MPJoin rejected by the PM.

- Patch 6: selftests: validate this new MPJoinRejected counter.

- Patch 7: selftests: define nlh variable only where needed.

- Patch 8: selftests: show how to use IPPROTO_MPTCP with getaddrinfo.
  Note: a previous version has already been sent individually to Netdev.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: sched: split validation part
      selftests: mptcp: diag: drop nlh parameter of recv_nlmsg

Matthieu Baerts (NGI0) (4):
      mptcp: sched: remove mptcp_sched_data
      mptcp: pass right struct to subflow_hmac_valid
      mptcp: add MPJoinRejected MIB counter
      selftests: mptcp: validate MPJoinRejected counter

Thorsten Blum (1):
      mptcp: pm: Return local variable instead of freed pointer

zhenwei pi (1):
      selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo

 include/net/mptcp.h                               | 13 ++-------
 net/mptcp/mib.c                                   |  1 +
 net/mptcp/mib.h                                   |  1 +
 net/mptcp/pm.c                                    |  5 +++-
 net/mptcp/protocol.c                              |  4 ++-
 net/mptcp/protocol.h                              |  1 +
 net/mptcp/sched.c                                 | 35 ++++++++++++++---------
 net/mptcp/subflow.c                               | 12 ++++----
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 21 +++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_diag.c    |  7 ++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 26 +++++++++++++----
 11 files changed, 80 insertions(+), 46 deletions(-)
---
base-commit: 61499764e5cc5918c9f63026d3b7a34c8668d4b8
change-id: 20250411-net-next-mptcp-sched-mib-sft-misc-25f5a6218fd8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


