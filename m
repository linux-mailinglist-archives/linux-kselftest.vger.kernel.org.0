Return-Path: <linux-kselftest+bounces-44581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA0EC28455
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99481895680
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047C28466C;
	Sat,  1 Nov 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElAO+T25"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFC2727FE;
	Sat,  1 Nov 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019830; cv=none; b=KDiflamdHhrdE6FSqBaH7shJT8JYVUFR/8oIP8syQXaBX/VRpYmBZ3XV3N1SqS3eBtexB8W42kQKiGtFYaZKMeFWDunYgM9Vj8daGrlo1ft155GDQF8VzPaneSvuIkOLMza4Gqb21UBdywd7IQ/wEQRBCmbcMDuQNWSerqD2j/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019830; c=relaxed/simple;
	bh=4alG/4J+Zw7vtUovcB0c4P8srDoSOCdZC4qNDI79DGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gs+qwJOgb0xdo0fWPMTfMAyt/UyOwJKuQa74/Pa60pD+UmyMBwywnzk4dKVV4UVqX9RPZbAld4AWHRGbp6nDP4/BGGtFaBrLZ40u2f+MbOqLjBMP3YCRlSxvLo01fHHN9laqQ8zTXBriZagB3vGBZmllW6VeNim6hJuIx7MFy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElAO+T25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670F4C113D0;
	Sat,  1 Nov 2025 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019829;
	bh=4alG/4J+Zw7vtUovcB0c4P8srDoSOCdZC4qNDI79DGk=;
	h=From:Subject:Date:To:Cc:From;
	b=ElAO+T259sbS4PtfmsssBEzluhML/6LPnjZ4Hr7bRblaRQaNwxS4empP39szfUUvB
	 5U4NG1RDEwaL4eD5td4370wz09h/A7FEjUnXIYUpXaa6TV06MLdBLSv6GdxqDPw7by
	 b9GcgFgm3pXnGT1C3gEwx+Bm6+6na298CbCu6ec43s8yeTjedW4Eih1B1IgfoC4imC
	 x6UtJSPOfghHk+IdQb2gnUZZlD4lswjBRacqtS4op80V1/0DrjGz/RFBCS8NwNJF46
	 U5PYaVFlBdCK5Sac43ExjXx9YazWBb57nmpGb1qRkcw2k729WUffcwSLFzIkOwn0Wr
	 fO3Zz8XWpVkAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: pm: in-kernel: fullmesh endp nb + bind
 cases
Date: Sat, 01 Nov 2025 18:56:50 +0100
Message-Id: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJJBmkC/zWNQQqEMAxFryJZGzCCM+pVxIVt05ksjKUtIoh3t
 wgu3uIt3v8nJI7CCcbqhMi7JNm0CNUV2P+iP0ZxxaFt2o6oIVTOhSPjGrIN6FdkdQHVoBF1aP1
 3MZ++d4MnKCMhspfjOZjgbWG+rhv1xhc4egAAAA==
X-Change-ID: 20251101-net-next-mptcp-fm-endp-nb-bind-cf7ab688d9f1
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4alG/4J+Zw7vtUovcB0c4P8srDoSOCdZC4qNDI79DGk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZPF9VncyUn7TkdNwk1ca59af7L6yY9W8hT+Gfw+vEg
 kPbnH5pd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEwprhf4H4a/uLW3ZMtvVb
 Lv8491RwJk9m95xbNxxDjge8ShCcpMzI8NPtcIiG1Mlu/jifP0fYH5Y5f4o4O+fCkSZWBsv7DCu
 7WQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a small optimisation for the in-kernel PM, joined by a small
behavioural change to avoid confusions, and followed by a few more
tests.

- Patch 1: record fullmesh endpoints numbers, not to iterate over all
  endpoints to check if one is marked as fullmesh.

- Patch 2: when at least one endpoint is marked as fullmesh, only use
  these endpoints when reacting to an ADD_ADDR, even if there are no
  endpoints for this IP family: this is less confusing.

- Patch 3: reduce duplicated code to prepare the next patch.

- Patch 4: extra "bind" cases: the listen socket restrict the bind to
  one IP address, not allowing MP_JOIN to extra IP addresses, except if
  another listening socket accepts them.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: pm: in-kernel: record fullmesh endp nb
      mptcp: pm: in kernel: only use fullmesh endp if any
      selftests: mptcp: join: do_transfer: reduce code dup
      selftests: mptcp: join: validate extra bind cases

 include/uapi/linux/mptcp.h                        |   3 +-
 net/mptcp/pm_kernel.c                             |  36 ++++-
 net/mptcp/protocol.h                              |   1 +
 net/mptcp/sockopt.c                               |   2 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 187 +++++++++++++++++++---
 6 files changed, 213 insertions(+), 26 deletions(-)
---
base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
change-id: 20251101-net-next-mptcp-fm-endp-nb-bind-cf7ab688d9f1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


