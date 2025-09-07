Return-Path: <linux-kselftest+bounces-40907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A067B47C0E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB723C1C8C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA0264A9C;
	Sun,  7 Sep 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl5azkgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31D1DA3D;
	Sun,  7 Sep 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259186; cv=none; b=H2gtXrCTSf9UisP9hlRCAW2SjPmOZSCZi2I3PIaQjAi6gCql/U5qFsIST49+pj6MAOf+PFYH7XtZwo7VUCFbq7bh9p7rFQF/9welZc/0qeDrA08sO34pDeMGaG7D5x5xtf8fR7vKXCvz4gB0SvELT7vln0oAKC1zLEo7t5ONSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259186; c=relaxed/simple;
	bh=iwKzv4pUY7edOHN/KUR9H+9NetHGNN81/qECaSfSfOU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jc7uVO9puizG3emwGd06AKKAwx5ivM0r0CfnY/7jPGYCIbjCfX0F2ojZ9aLXsg36HYcYm60Zb5xD639d7sf4twNJ/oO7obnV+PJSdCc/5sqsFeq+nZyPwjk757v3x/RiKdbC4e3NphI+ZqY5ZTk5YEJcMXVoyMgymZZoFLHA5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl5azkgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E2C4CEF0;
	Sun,  7 Sep 2025 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259185;
	bh=iwKzv4pUY7edOHN/KUR9H+9NetHGNN81/qECaSfSfOU=;
	h=From:Subject:Date:To:Cc:From;
	b=Rl5azkgIsvn14rQ5C5h3uWjaUsTBVJaV6GlAyJLREm9zfk1tVYawJJOzTJu+E8XIL
	 Zglm3O9x4Drrlqsv6RhtJnUU/io5oAogj2Y+WozzvuXlIXbuowL2CYSzDTxF/bIAAx
	 oBi6x6xktdgecp2JCZQ1DYLlalznrzjQ01vzEltvonXp/2fQCzDDjqenkR7D4fhn7i
	 a7LXOWyTv/qi3XZyQk0XnKijyWxdmyoMBvc9Rdy8CvaUPYY1USe5u74pQhA6si4gWq
	 hzEz4fx8NalU7DXMSqvX13aXThprnq+4rVwkoS33kEm02Zz68LE7z0ELKRkQj7a5zf
	 R+v68iadQsUwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/3] mptcp: make ADD_ADDR retransmission timeout
 adaptive
Date: Sun, 07 Sep 2025 17:32:41 +0200
Message-Id: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmlvWgC/zWNQQoCMQxFrzJkbaDOUKVeRURim9EsrCUNMjDM3
 ScILt7i/cX7K3RW4Q6XYQXlr3T5VJfjYYD8ovpklOIOYxhjSCFiZXMWw3ez3JBKuTuKyqZUuw/
 UDOMpPlI6T5TnAt5qyrMsv58r/BNw27Yd4p+83oEAAAA=
X-Change-ID: 20250905-net-next-mptcp-add_addr-retrans-adapt-565b9973acfd
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iwKzv4pUY7edOHN/KUR9H+9NetHGNN81/qECaSfSfOU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2Ll0Z3PVp3vWZZyK/H74gy9Bp+Wzt9htzlIPtf1yer
 HK0RL9Ar6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAibSsZ/lfOVxX81j2hyYy5
 XWThkdsnRAPXRW9TfbQ07sv1lxvPPuZk+GcVu/zijqvTn5xzm/E27fCvay9OHb8z92bZ/WO5Ocv
 dF6xnBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, the MPTCP ADD_ADDR notifications are retransmitted after a
fixed timeout controlled by the net.mptcp.add_addr_timeout sysctl knob,
if the corresponding "echo" packets are not received before. This can be
too slow (or too quick), especially with a too cautious default value
set to 2 minutes.

- Patch 1: make ADD_ADDR retransmission timeout adaptive, using the
  TCP's retransmission timeout. The corresponding sysctl knob is now
  used as a maximum value.

- Patch 2: now that these ADD_ADDR retransmissions can happen faster,
  all MPTCP Join subtests checking ADD_ADDR counters accept more
  ADD_ADDR than expected (if any). This is aligned with the previous
  behaviour, when the ADD_ADDR RTO was lowered down to 1 second.

- Patch 3: Some CIs have reported that some MPTCP Join signalling tests
  were unstable. It seems that it is due to the time it can take in slow
  environments to send a bunch of ADD_ADDR notifications and wait each
  time for their echo reply. Use a longer transfer to avoid such errors.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- Patch 1 has already been sent before, but the selftests had to be
  adapted differently, see:
  https://lore.kernel.org/d5397026-92eb-4a43-9534-954b43ab9305@kernel.org

---
Geliang Tang (1):
      mptcp: make ADD_ADDR retransmission timeout adaptive

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: tolerate more ADD_ADDR
      selftests: mptcp: join: allow more time to send ADD_ADDR

 Documentation/networking/mptcp-sysctl.rst       |  8 ++++---
 net/mptcp/pm.c                                  | 28 +++++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++------------
 3 files changed, 40 insertions(+), 21 deletions(-)
---
base-commit: c6142e1913de563ab772f7b0e4ae78d6de9cc5b1
change-id: 20250905-net-next-mptcp-add_addr-retrans-adapt-565b9973acfd

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


