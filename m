Return-Path: <linux-kselftest+bounces-28802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77381A5D8E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC041779A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D3238D57;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TboSritL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F97238D33;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=kb7AXju/H5iGq9JD4l47ZcRek1iFXAfLS7qWIjoqgiJpZH9w1cVvrT5OD7ciFj4XVIND8pQt+H8Pgcb9QpedXMmCKAl4eq0h0MkMj177WcxaZqRQ3DjNKaYu6G8cM2sFSJGT308hllfI0vnqeHU5M1JsSwoxXDNJrMoQjzbaoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=hPSTfb9hK5artlzSLHGsH/c3sy2ku9iSlzjEcPKrk+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sy3DhHr4qL+rICoKy0e0yDmXEZzeqNybikf88BJIYvr8gdcoKVik/YC8azRlj7ONSuoJ01Cwx/fRWOWiBBnPe8InBGOpVIn1WUWsveBZK+S00J7eHbO1oMlJ+2/6TdEn1Vt1JrgeLu54iyfXTBYXVIznyYlxQXUsvSLulqeHTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TboSritL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B56FC4CEE3;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=hPSTfb9hK5artlzSLHGsH/c3sy2ku9iSlzjEcPKrk+Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TboSritLTtkdH6BhWQ1xaiZO2JE/Rb3rLrxsq4EevnPv3Etg+/niyK2gNIkjstfcj
	 PFReCprT2IhUf59vzR9uRWt5/Lx8/6gezfnfmDIT0wUvai85D1/v2TqSbvE5dfLjzP
	 rz9glKSnJwstLywWnLLu8LBdL3hMIKDw26ZCHByli7jMRiSnTNKrQr96/rGp3YTwUV
	 QCN01IMut+cDILnIMfPMHkaNTakYvP4YWkghMbdCG+L0U2uGFjjdGo3cvNz1hfCtg5
	 7XsqDqTOGi++9dUjF+hNftyLfU0xMYcpAkxMBcBG019osRCi55bc/pPzKj1fte9cuc
	 77OtBJgUo84pQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBAC28B28;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
Date: Wed, 12 Mar 2025 09:10:54 +0000
Message-Id: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ5P0WcC/x2MQQrDIBAAvxL23IVoaQL9SunBNWuyYFVcKYWQv
 9fkOAMzOyhXYYXnsEPlr6jk1MHcBvCbSyujLJ3BjvYx3o3F5gu6jMoxNNamWHKMkla0hiaiJcw
 zTdDzUjnI71q/IHGDd5fklJGqS347rx+njSscxx8JUWgHiAAAAA==
X-Change-ID: 20250312-tcp-ao-selftests-polling-21b6bbdf77b6
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=1696;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=hPSTfb9hK5artlzSLHGsH/c3sy2ku9iSlzjEcPKrk+Y=;
 b=goNN8v5fCXHA4SzoupYXXme+VIQSH5K1KWQaq37LtGpwmpDDksGy/vCmDRxAh+jCypEWNBzOs
 u+9v/IIbeWcBZXIuqGSjYII8dZOkTLIfBt7CrZQEuIePtMj+AJrRiaw
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Should fix flaky tcp-ao/connect-deny-ipv6 test.
Begging pardon for the delay since the report and for sending it this
late in the release cycle.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Dmitry Safonov (7):
      selftests/net: Print TCP flags in more common format
      selftests/net: Provide tcp-ao counters comparison helper
      selftests/net: Fetch and check TCP-MD5 counters
      selftests/net: Add mixed select()+polling mode to TCP-AO tests
      selftests/net: Print the testing side in unsigned-md5
      selftests/net: Delete timeout from test_connect_socket()
      selftests/net: Drop timeout argument from test_client_verify()

 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  58 ++--
 tools/testing/selftests/net/tcp_ao/connect.c       |  22 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  17 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |  76 ++---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 114 ++++++--
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  |   7 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      | 315 +++++++++++++++------
 tools/testing/selftests/net/tcp_ao/restore.c       |  75 +++--
 tools/testing/selftests/net/tcp_ao/rst.c           |  47 ++-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  30 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  | 118 ++++----
 12 files changed, 552 insertions(+), 345 deletions(-)
---
base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
change-id: 20250312-tcp-ao-selftests-polling-21b6bbdf77b6

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



