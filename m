Return-Path: <linux-kselftest+bounces-40996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50018B49BE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7553BA618
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE992E0934;
	Mon,  8 Sep 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwi9ViHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8221FF39;
	Mon,  8 Sep 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366880; cv=none; b=WcgLTRi+DdoqH7LyrvHU1UPK0VvQo9pq6C5Cwc5Ntip3o03o1t/6VKDeFUTQECX/sZYLgShOQ6MtKFqFNWf+sr8cig9eoWJ15A4bEghbe3Iv9cmPFYPaLODOXD9TXTk6kuLcEz4rrP8phX8wFeP9SCSuCcGt1GGYUnMHxuTiTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366880; c=relaxed/simple;
	bh=3NT5DqK9ceTmzwhurXujvORIaKtG4LGDHLvhlVLs6D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRsF0xqBTcJ6OFrEVswwE2qYS9l9nbNk7VBCeSmUcuScwbtufdJ9yMuQdUooTrCIYgi48Dwfa0ZsphzubUxFg0XJh0W+CGKlElwNu7WYxqOa8/5GZexzl02A6VpH4AqV+gX0Tb2fdeHbfizWAe+nolncAfLsqRk8upQ5vLkcHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwi9ViHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C6AC4CEF1;
	Mon,  8 Sep 2025 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366879;
	bh=3NT5DqK9ceTmzwhurXujvORIaKtG4LGDHLvhlVLs6D0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qwi9ViHsD9iU8yiMgLNJHe1korADT7xRHNjN9bRrN/XtrNc7G9tNGM4+Lg05XcbVa
	 dJ5HOvI7HZsqCv/tTlRldth1yR5PM4B9Fwf32CCh9eyZEsMT0zhePo6i+QsICVTQ2d
	 KvTswjIqHWJjqp3RXcgl6Fib5vOkqgxuHw3TOk+PSNuBZW4n1iAO8evXCAKkxznpJR
	 +v+xVaj8wd9M0TvrfwezPFuCZGtvdYCVwwzPaAE+Hd4qchfeiP/EgJWaAgGqwlEHwO
	 HcszR6TmnwSJsGHGkHlSZOkvxri7hrZcJBMspr1bdcCYEI8M+P2VdknI+/qXFF9XLt
	 DULdvu+XZ0lxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 23:27:28 +0200
Subject: [PATCH net 2/3] doc: mptcp: net.mptcp.pm_type is deprecated
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-2-5f2168a66079@kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3NT5DqK9ceTmzwhurXujvORIaKtG4LGDHLvhlVLs6D0=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGi/SlOhh+wwQT7Ge4EoFszL8uduOHWE1fKWYaIlycU6jdlw4
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmi/SlMACgkQfCLwwvNHCpduzgEAkGNZ
 ouDFUTOkbBgLDu+PhROiOZ+KQyJ+nqccP33ZVmUA/2EqyaXnZbf6G8qUM8yznGz8c+WCwn7iI4n
 YvycFhkkB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The net.mptcp.pm_type sysctl knob has been deprecated in v6.15,
net.mptcp.path_manager should be used instead.

Adapt the section about path managers to suggest using the new sysctl
knob instead of the deprecated one.

Fixes: 595c26d122d1 ("mptcp: sysctl: set path manager by name")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index 17f2bab611644727e19c3969fa08fa974c702d92..2e31038d6462051387be9bd8808a23230db08315 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -60,10 +60,10 @@ address announcements. Typically, it is the client side that initiates subflows,
 and the server side that announces additional addresses via the ``ADD_ADDR`` and
 ``REMOVE_ADDR`` options.
 
-Path managers are controlled by the ``net.mptcp.pm_type`` sysctl knob -- see
-mptcp-sysctl.rst. There are two types: the in-kernel one (type ``0``) where the
-same rules are applied for all the connections (see: ``ip mptcp``) ; and the
-userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
+Path managers are controlled by the ``net.mptcp.path_manager`` sysctl knob --
+see mptcp-sysctl.rst. There are two types: the in-kernel one (``kernel``) where
+the same rules are applied for all the connections (see: ``ip mptcp``) ; and the
+userspace one (``userspace``), controlled by a userspace daemon (i.e. `mptcpd
 <https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
 connection. The path managers can be controlled via a Netlink API; see
 netlink_spec/mptcp_pm.rst.

-- 
2.51.0


