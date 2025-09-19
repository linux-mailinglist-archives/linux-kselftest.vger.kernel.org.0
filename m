Return-Path: <linux-kselftest+bounces-41939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6FFB895CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA91BC16B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65130EF6D;
	Fri, 19 Sep 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7200veW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F030E84D;
	Fri, 19 Sep 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283773; cv=none; b=YEbLC6jM4oCeb40CZ0SQwfnkkKNY99OkkxI1VcQqGjxmrcGrcT4u2eiXtgbysWuWAnMJ7Dxh4nbd/srp41OWavTmXxhyLn2KOnQ/kplTLFDUnwImn+SfRxgD5YMGVezEARL4ns6yrFSOG+FUh5CjPvmgbz3WgtQgyYmUqLLk/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283773; c=relaxed/simple;
	bh=S8agwRjUryD5J3lYuJKTawceF/AlQ9JPXlcvHILCP+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dar78lkbJTXVxBNYvvHidIZDE2juckH5rh9lJ0mNzikETBUBU6muF1VQ6SfsHcpGYwHSnsZkTvZfPeveXSUwIeEyI4mLjhcL1kd0ovBSyKd1Ku4I2SzmOzh8CaAka/aaRHaZUBSoJpgG/b23buo9troTR6PPneX4EJtJSUZSMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7200veW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2B0C4CEF9;
	Fri, 19 Sep 2025 12:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283771;
	bh=S8agwRjUryD5J3lYuJKTawceF/AlQ9JPXlcvHILCP+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W7200veWH/m73TiX7Po9uHXWUykRS11TML4/QQ3V188CTnJ+y7OyGdcNo+JrlurvP
	 lfBs5qH2AO81/s2IW1X8WxAqibr+0Mx9EWu/vHQLmaVzIsw6ulmDzyYoLe2bwKCB0q
	 EJMKkAejzf7mUpHwG/CJtashrCtBj/lfCVAC/JMKUc5dKfOmfw7kGWp2TE+xCb4RBN
	 KsCsGo/VlabXCrMxoiHILICmfJOjeJYeVQ2KSh/nMjq9toqAyBNc2Q+CcEDiJLAvw2
	 9gK3ZZvo5RHpzceii9wY6yYqhAEp4ll01LwVjX5gMe6y2vBBTvJSx48HVFjuvxWneN
	 W4X+tapC3xd+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:09:02 +0200
Subject: [PATCH net-next 5/6] mptcp: use _BITUL() instead of (1 << x)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-5-a97a5d561a8b@kernel.org>
References: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
In-Reply-To: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S8agwRjUryD5J3lYuJKTawceF/AlQ9JPXlcvHILCP+I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOur+45nfmjq6jbPFzIZHah7+L5z6eY/KLSTitfP7xM
 i47DsnTHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMpjWFkmJ1wNfzsDsnPl4yn
 RiSVJTPUnp5TNplF8OjHqjjl2qjJ3Ay/2W6m/P+17aGxoKW4imvE3GWlLZ8vTpzQqTpj374XTak
 VbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Simply to use the proper way to declare bits, and to align with all
other flags declared in this file.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 95d621f6d59810126cbc37b1d6baf896a40dd9bc..15eef878690b8556af21be8d959b6a2c9fe617d3 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -34,11 +34,11 @@
 #define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
 #define MPTCP_PM_EV_FLAG_SERVER_SIDE		_BITUL(1)
 
-#define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
-#define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
-#define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
-#define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
-#define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
+#define MPTCP_PM_ADDR_FLAG_SIGNAL		_BITUL(0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW		_BITUL(1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP		_BITUL(2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;

-- 
2.51.0


