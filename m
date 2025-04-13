Return-Path: <linux-kselftest+bounces-30643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36BEA87147
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC103B93A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666818A6DF;
	Sun, 13 Apr 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuF1CAQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2A22339;
	Sun, 13 Apr 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536896; cv=none; b=WllgF0pQiffRZa1U7vicBjmUnoX7KmXy5LVScEWRLpaIY7CuPN6wm3Sgrrq7Uc32yfk4LdKuYVlt6gRcW6SxtNIDeGk9vVl/t+tHFDO6/4ZKb6eXjv2zL+W3Cm0t+SW632aSAepNnSdC3GXkiKL5sAELbHfhWKH1ydYhccihd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536896; c=relaxed/simple;
	bh=bitNoWLp7gWRg5g3H7/7vRwGv+5PlqpKDCihNEeI1PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E57U936ckJFhpoHBivz9vpnL2ZKuX3v6B3xq6xQkpVtYXBft0LC33aFQrYoCab/kSnwr7kTvW71x3n4ztiBMRi6sz0vScH79EamjSrzazhtHBrpeMTNZ442vVrHUPTFS+EE207LyEKfHkqJkyoFFXCJMvH4tV/+cOL7fkXFhYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuF1CAQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4367C4CEDD;
	Sun, 13 Apr 2025 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536895;
	bh=bitNoWLp7gWRg5g3H7/7vRwGv+5PlqpKDCihNEeI1PI=;
	h=From:Subject:Date:To:Cc:From;
	b=kuF1CAQtsrXBGbQndw03q+6GhmDLAn4AEl92yuTs/omUI9nGrov1zvtEeYanzbehR
	 uOzNyiBbtwTdDR+u3hGU2VmSb55h0thyrkBkhG4myXrJqTTuizgpKBccJTSWAij8Ir
	 kMQIgBfAHJWT/p3fqvs+R19rvzFmC9SN7nU+2i/UZpeXYjqKWwdAel4yPL08XI2Pfb
	 9OeE8/C1Pi0wVKnM0DKT88Yr2fTJ0pbmg2nA/ZT4UU4YhMxZZ29JOroX/sff58G+d+
	 Q9t9B3vfJcavQhDMkvFLqwNG+X7Ck+hAoBfZfSBfStCTjHh7Bx4vf/qly/b+1G1my3
	 WQirhLvL4vY/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/8] mptcp: various small and unrelated
 improvements
Date: Sun, 13 Apr 2025 11:34:31 +0200
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeF+2cC/5WNwQqDMBBEf0X23C0mNRJ66n+IBxs3urRGyQaxi
 P/eIPQDepjDzDDzdhCKTAL3YodIKwvPIRt9KcCNXRgIuc8edKlNWSmFgVLWlnBakltQ3Eg9Tvx
 E8TljcaiNN12tlfW9hfyzRPK8nYwGfnNoczOypDl+Tviqzv4PzqqwRGs6Z11dm8rdHi+Kgd7XO
 Q7QHsfxBQcWmDTdAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bitNoWLp7gWRg5g3H7/7vRwGv+5PlqpKDCihNEeI1PI=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4Uxrk5MUMws5vC38B+qvG6yK5zMRGc26Ihb2
 rf9ONzbQkaJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFMQAKCRD2t4JPQmmg
 cw11D/9O2c/5YvA3oj5JlckLYrx9Gz7AK7HdgdmA69YHskA7ILX2Lt5+9wIeAPStNGv9EAluFG3
 NqBMQBhiM74glMwVqw11S1mrJtFkxqfLPRbaTDa6vsER7aW4LV5TL/DQKdzh/yfPi3a5IszWLQZ
 UX73tvX/uobBxFUXF/6Ix7HCtzk0l98FN3IUR3EeqmicnxmKG/DEdpS9YBncxLqWlYRmH9kli1j
 UFFQc6jk+JC04ba2mOBNILg8C8kkfUV3DTzK5ylZYa8DoMVIL4Irz45KZfcLBVd51PaTvpN8uL1
 eOMGj1WF0QfKPaXM2cArMT4PCIgcoR+ZoYiaQPFYiLhFgT2a57pY032iEzRnPt4bzocmkDAMPAM
 aACsSDEiwmEaZ+aAT5tIlBpf/BbkOBfzIKj8OwHy2AItPV4VEiK+JcmZ96vz6VVNU8KMcnYBbp3
 LAVNSTgazbQ+4o8v4f5Qd95UrpL5y7hbNgaud+j7MBAPfrX7sFqiJ99OMJGv11mrIv20ID4+JIE
 yCnH+MCbfBJwBA4f/DaJ1kIhlFvkKFOfWzrMgRuzIILVHcw+L98A7xY7pWQY474FzM5WOG7FjCq
 eh5F675x5j9ofjGhtBnyDYpHiUjxzJTGD/k2srA0xSrl+uKpDRbDkFw2g+5iciUbZOm/00L6GhW
 6k7bAP74Ckvpq1w==
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
Changes in v2:
- Force b4 to use 'git show' with '--no-mailmap' not to modify patches
  2 and 7/8. The code has not been modified.
- Link to v1: https://lore.kernel.org/r/20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org

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
base-commit: 6a325aed130bb68790e765f923e76ec5669d2da7
change-id: 20250411-net-next-mptcp-sched-mib-sft-misc-25f5a6218fd8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


