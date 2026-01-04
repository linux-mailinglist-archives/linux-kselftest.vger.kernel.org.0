Return-Path: <linux-kselftest+bounces-48139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC7CF136E
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C713040A4E
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E73101A8;
	Sun,  4 Jan 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHXbcN5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEC277C96
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552123; cv=none; b=deCAgt5qJQHbclzsrOs5UtieZdOmuDCepDZ+IdEC1F1+Gnj7NcGBgNQ9FygynW5WHuHqYMMHN+qSankb6syVkn568G+p34y0RhB4KBr9lIq0g5rRYsiFiJKHom54mPuUUd9o+Nhou+VkUf+YpWwCTuVR/DbhGcYzERzgL4Swma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552123; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhTsB0yLJ1j+Be2Ui4WBvjp5GOT5T4e7loEfQd9E0j/UeiNmOglDCKQ5RQ358iCYVT3nSut05JFihIZRXWecyG7HHs7YJ5eRUgr1c/yeLLGEggBhIex1dd8hxm5i1Jg2T+RwegmZfAdl5G32RLaiyjURDDCUi9si8+efzUp7X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHXbcN5B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso18874192b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552121; x=1768156921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=jHXbcN5BfSHJn4YS2srysffTX6KMaF/yndSGIRWKdjzIbxTbFSnYtpmOdWdjjrQAgs
         SIlhy/0CJq4syO8pdMKtVPi+RezG8PHvxpkgVElsRsLR289Qe5fYO0JpaJJ6X/2KuPxG
         xxpKJyCNL9fG7vCU2/YBYyU/cPtcp0tEHq45tRYgd/bT0WSxfV+vILlrjhV1/9DXGaZu
         B8axy1cRtRA2G4B/I7yyH9ra7UXj+jNfglKNAjpUi4uBfdBERd3SG2w4c0Vfem82Wwt7
         ONBIfSlgGUYugZUq1s8SZLs9htaa1ODiZmoPHQDr2K1+1lEjxxolCRW7jO8oCVbBT1Qw
         qERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552121; x=1768156921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=Sp1VNxIins8lZYT/8MMuAKs+Yc3BSDuYm3F5HRMgYOb61K1Iu23E1hgwFRKXvRVENp
         tUji48WckNcZdG9BAZRze9O57LkWdaP0lQnui/3rfyhzkiJM3QsBwiRGs2MJTGaQswnI
         Dv5gdhlAJt6CPC7eRrfYPXGM9M6Cl1oh4O1aHELZGiLW4rEdZ6DOabDmuETD24JQ+pNB
         6RRwfJQgXDlks8d1Kg+nMpBSxp2TTWNuAhmb/C4vhOgSqW3XdOyZAGsjYU7aBXRNlEuO
         rmhdWIuGMcQL7R4AWNslkbgAVdJ66zPmRiCt2RGEVFQ3uqip46tGwpG4yASfM9U6M+wB
         wi3A==
X-Forwarded-Encrypted: i=1; AJvYcCVmzyeCsJmZn+N5ibZwUq8hnY/IYuQ6zbr9ns0HkPoyvs7Px/1kT22XRYdqITA1fZBly9qCy5SL4oirLRotmvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1+TQTviZkZgW/dJ9XbER9nTdKla1g7B7u5JOaZJFgcuUk7vl
	eyYnJk3uQW1hpMA3JLByl7f+T+2ezKKPU7QuK9akGzr/Es1fCsCRq1w7nP6Z4x1b
X-Gm-Gg: AY/fxX7ctuADUyjDYxx8tp69S6nTbQFLu5v0vVjPhrO6WBSTLZMIEpE7eTcyYApbRPR
	LJ/mKZDpzQwv7mecG7JQ/jPm7WsaX9SoRpjflsKi2AkNEifdHC6cNptXv0E9yc52gY8L1/IwexD
	05H2hcdNCg0oDuDbFCwrdiBjAHLbAFnxnA8gvnE4enmoG59P2JoufkqTLMPr6Ed60IMETRCPPP0
	gqC54obU2Ur1ZresKhw3AnVGo6qsmIHyvREGhE9Aer9PlAFGmQC7167JGfsWVbhGx7rUkK9EjRW
	arKMJ/VtkaXweN9cvWOfACvqifg+b8zWSVK7zfcr7WQ0xN+sOOQLayU01bXin5Haj9CxWAW//RM
	R+Envl8QGjidsnaOipslLtRZMTm8rhuz3aYvzRg62OwSmb8u1H2xhaw/aPksJbOuAHiTvM2Hod1
	TNYpcG1yVUUCZLiF4I
X-Google-Smtp-Source: AGHT+IFgDO13laBgR4LGNEYbaTLIFrlJZEzUic2bWc2F0XYpOVbwq5tHYtyBT4UbpixuVU/XuYD9zg==
X-Received: by 2002:a05:701b:208a:b0:11d:f81b:b212 with SMTP id a92af1059eb24-121722b27edmr35673494c88.17.1767552120496;
        Sun, 04 Jan 2026 10:42:00 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:59 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:14 +0000
Subject: [PATCH net-next v9 4/6] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-4-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=HHavGEkPJ8xbid2UCwSa5wsmGmUarwYg/Ad0iqOlkjCOIfK6OXlsEqlCquKnMu2uLZkvF5k82
 KjqfTUYkqz6DFl0o+9FlBaLmWTrXO83gFkEGDI5/Lfde1OTihiC74hS
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch makes sure netconsole clears dev_name for devices bound by mac
in order to allow calling setup_netpoll on targets that have previously
been cleaned up (in order to support resuming deactivated targets).

This is required as netpoll_setup populates dev_name even when devices are
matched via mac address. The cleanup is done inside netconsole as bound
by mac is a netconsole concept.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..02a3463e8d24 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -242,6 +242,12 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -284,6 +290,8 @@ static void netconsole_process_cleanups_core(void)
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
+		if (bound_by_mac(nt))
+			memset(&nt->np.dev_name, 0, IFNAMSIZ);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

-- 
2.52.0


