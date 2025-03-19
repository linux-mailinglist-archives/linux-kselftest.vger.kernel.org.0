Return-Path: <linux-kselftest+bounces-29409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F3A68378
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6871519C30B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118724EA90;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYuv9qC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D724E4A8;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354052; cv=none; b=FPsKcHaMFiBcDMATrBqGmXP7K4CKol0BSTc+8mr+07nYHQ8KrKhNqPDeABvqf541B9yKdyrzm7KzPX44b4NDkT9+s9P6Z0ywY2va/VhFyyWmRPcPBxPL+lVhSmVZj/0cDDmV/F4ozfOhA41vEx0Avrc4YtY6Z92Y/joQ1XNoXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354052; c=relaxed/simple;
	bh=etgJBoDA0+o3M60VBpSmAHMAVpuV7zSfirQ+bKuKABs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qOZsltWvHM0CRsy/TpwNvkN5SiY6frah6vZ6XyU4yybyJtH7BTZq+6u+U05VSR6KPOBIyttIyXB4pQGLLaMF7zcn6VhORB0MaGhiYJVxAL2ofQTtZFFORkHk2rPCwtq5quZ267mCvwgvRR2S6Ah21UfYfVypGH6NEAfX+ewNNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYuv9qC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E284FC4CEDD;
	Wed, 19 Mar 2025 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742354052;
	bh=etgJBoDA0+o3M60VBpSmAHMAVpuV7zSfirQ+bKuKABs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HYuv9qC+Jicrgs0ibOc2DgFnjShRyLNPFyngY9CbPl+Ooe4MmTppF9Y5aY9t12DK7
	 us8HD3WbB3RB36CU87qfsd4qPjW/Jk1vGSujYLSOzw65w4LR4nw8oj/Nhev5zh+7O3
	 9Jzy4+6Gg/kM1eaCTOS1TwtkLRg+XtMsfPM/BqWuQ9x8jHjD9rL0NIZdj34Qqa7cT5
	 Dor16FsgU7sLHQMcNQj4ZNVN7lbdV+61+p83lzLcd6LXJq24dmc76fWnZsZnl7rdAL
	 0dBwMoqAm8zwYIcxIaD+DEjJj0yCxMagYno5rGPnBn56nz1VJkIph/QtERoQy5L2n5
	 ILnpQmdH02avQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7EAC28B2F;
	Wed, 19 Mar 2025 03:14:11 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling mode
 for TCP-AO tests
Date: Wed, 19 Mar 2025 03:13:33 +0000
Message-Id: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF422mcC/4WOwQqDMBBEf6XsuduatNHSU/+jeEjiqgFNJBvEI
 v57o9Bzj8Pw3swKTNERw/O0QqTZsQs+B3k+ge217whdkzPIQqriJiQmO6EOyDS0iTgxTmEYnO9
 QClMa07RVZUrI+BSpdcuhfoOnhJ6WBHVujGZCE7W3/a7+dddRO7+TveMU4uf4NIuD/z8/Cyywk
 rq8S/NQqlGvLvuGiw0j1Nu2fQHilFlT6gAAAA==
X-Change-ID: 20250312-tcp-ao-selftests-polling-21b6bbdf77b6
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742354050; l=2211;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=etgJBoDA0+o3M60VBpSmAHMAVpuV7zSfirQ+bKuKABs=;
 b=1I9QpOTeJb1TkomhompoA8/N2Kaaw0gS1HWvq/lyucF63bZKRXvykgBMV9jCQd8aKS3oHZ38P
 toxxWCRZjYFAuJeLISBiXQjnqtzQ7QJ2dXVJrCMpAOnNX2QeqvnxTSm
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Should fix flaky tcp-ao/connect-deny-ipv6 test.
Begging pardon for the delay since the report and for sending it this
late in the release cycle.

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Changes in v2:
- Base on net-next (Paolo)
- Add a missing Fixes tag (Paolo)
- Link to v1: https://lore.kernel.org/r/20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com

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
base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
change-id: 20250312-tcp-ao-selftests-polling-21b6bbdf77b6

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



