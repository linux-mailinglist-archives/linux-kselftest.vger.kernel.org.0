Return-Path: <linux-kselftest+bounces-7283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA12899DEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4C9283C1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970E16D4C5;
	Fri,  5 Apr 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4I8sVlg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832F1DFE4;
	Fri,  5 Apr 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322396; cv=none; b=LeLOAC9EaPUi7Fu2vv2InEJVdu0S2ial6aThB0m94YTeyG29XDucWlMhQh4VtmDqdxICwgYsgBqqkxvXOUmft/+qZwbQqvf8iHJX80ezLJLRrhOCL4kIlXC3x8KqQyhEmpn+aB2BrnFNd78vmYvWjcsRo9Ziqn/UlMXcE3j4MeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322396; c=relaxed/simple;
	bh=aiTtOgawA1gl+sKd/BL+KKsnX7hyyYugKZCpLonIlAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=necKBGHKqE4XQGjV5CAIZBTGx1cQYvI+uxgrBJJxZsLrTrCbbVna+pOrIHuvxN9ftCuUtWKYGHwdN4A6j+sel81PX0nQ2118EHQ5zgalyz19EXPXQr03bb5hyUvPheiIMlfTx8S53v3DsHisjT6xjEYQBuVJSkc7CN5Nlw9panw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4I8sVlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D319C433F1;
	Fri,  5 Apr 2024 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322396;
	bh=aiTtOgawA1gl+sKd/BL+KKsnX7hyyYugKZCpLonIlAk=;
	h=From:Subject:Date:To:Cc:From;
	b=j4I8sVlgrQ3jetssQjEvZ926rndqiioLxqiNtHYXfK1GV1hjwD4EBfbQAvpERTKsH
	 XDoA+HdX1ovylqxGPDOeS1uSEVfhQZaiX8DP/14b/Uf2ZkVmT2W5BwChg2MF2tIaMr
	 pmoluv2TrZb48BnvEpz8U1duOplkukiFmOoFwN+jiRtbfHFYcLTkoAy+ybnGjDK0rk
	 axF+BeY6gALyi7pYSIC01mZKPG2X/1A1ZWNlcnloTKKANGNRCiK8XpGX3pkfLmvTTR
	 axm06j/PTigcgp4klJwNzdnyjT26B+WKPbf/QINQ0mKDKSd81f8sXW5ZMzQ30Egm73
	 uvL9qh8jgxj4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] mptcp: add last time fields in mptcp_info
Date: Fri, 05 Apr 2024 15:06:20 +0200
Message-Id: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz3D2YC/z2NwQrCMBBEf6Xs2YVNW6X6K9JDWje6YNKQrFIo/
 XcXQQ9zeAzzZoPKRbjCpdmg8FuqLMnAHRqYHz7dGeVmDC21PfV0xFeuWthHTKyWVfFfxaxzxqe
 viirRlikseJ6oO7mBaQgOzJoLB1m/j1f4OWDc9w9b+edaiwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aiTtOgawA1gl+sKd/BL+KKsnX7hyyYugKZCpLonIlAk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD/dYTs4Nh1M3Y3r9Yx3wcV7xGdpd2pup/0HIL
 HFlecIH0z+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/3WAAKCRD2t4JPQmmg
 c2UoD/9m56ReagBAujFA3sYu5/Z8OuB4jsQqPGMSSoHZpLzAlx8QacdEAsbVgLioaf3b1btSBoY
 09W4qNP8uwrLYx25BecWFoe+PzFsecCNjUtYgfCdMlQnt+sbbzpwgfgyELl0fFHsgNewI8VVqD2
 Yxtv/A4VBB6MitPaS+QQ/MQD2j0pqOB/+lNZtd6c9PKkYzpyjxp6iWMlUfTbKIl8bLWZlp+/7lx
 bheh5G9+wUtipZn6VpINqfxuVXOACFTILk5as97XeEE/xq9yMwchWqwa6w7kY6lzc7zRGx16W2g
 i7x0BhMLfhpmQcFUNmwZL5MTgOs3O7C5TCYUiULeEA8JElFlYDvmppLI2knW2h2MeA1GfoiphSI
 iADfUf0CW+surlAvS4F2MMVMFVaktJGCYfM/Mk//kFBrUU7+UrkX+booNvx6fkCXTjMSAEL6WeG
 YWN0opPw4K5nJGC6/rMHnrwfOYtyilBffMHY28qW/vI2aaXmLakCEkexSiPolLjqB77ZhPIVsvg
 w+VD+ApD5yKG9bgB9MSjDfJaYm3w9d9k/kBpcJJac9w6+wePpL0TlRE/4HWyCkxZLoA3yMgn+Pc
 baTUNW2bTz7I44mT0VcO36MEvVA/6VQ6iJt05T/fmxZDO56T0k8AGKbwH/cSMAveeGRbu36LGN1
 rynsFVEpFmsERFA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These patches from Geliang add support for the "last time" field in
MPTCP Info, and verify that the counters look valid.

Patch 1 adds these counters: last_data_sent, last_data_recv and
last_ack_recv. They are available in the MPTCP Info, so exposed via
getsockopt(MPTCP_INFO) and the Netlink Diag interface.

Patch 2 adds a test in diag.sh MPTCP selftest, to check that the
counters have moved by at least 250ms, after having waited twice that
time.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: add last time fields in mptcp_info
      selftests: mptcp: test last time mptcp_info

 include/uapi/linux/mptcp.h                |  4 +++
 net/mptcp/options.c                       |  1 +
 net/mptcp/protocol.c                      |  7 ++++
 net/mptcp/protocol.h                      |  3 ++
 net/mptcp/sockopt.c                       |  4 +++
 tools/testing/selftests/net/mptcp/diag.sh | 53 +++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+)
---
base-commit: d76c740b2eaaddc5fc3a8b21eaec5b6b11e8c3f5
change-id: 20240405-upstream-net-next-20240405-mptcp-last-time-info-9b03618e08f1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


