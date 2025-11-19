Return-Path: <linux-kselftest+bounces-45951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37309C6D3C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5428B2DE6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595B32937E;
	Wed, 19 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVT9wFUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608B32570C
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538576; cv=none; b=ZdYG/PbxGr+iJodJd8YHXO5ZOyAqqlh5Fbg6JPZx8IQ2YBN8LhK+M5nRTrn9nBryH80pgUuBM2nabqC4tOifKpk6OuhCKZ94Dvm/tw8FW4ul5UZ3wwSksYmpotxM58P1sxdVG0tm6DFPtNQzmbvfewH5Ma7/NpNTnPFB8ELt/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538576; c=relaxed/simple;
	bh=b8FscmmisLfC2hrZ743eM0Q8mvR5xh9F7WYVK3EV1tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDAoCdSGU7G9YNhSsegFjEn/kQUG6kc1TtjQLdTmiorMl0kBbf4uZ8m76Pv07bRUfx5SzP9da97QI3ufOL9VlGtJC7PUb8HmYLTHmtAwp/isqYlH4HW+8gH9lOzmCihv2kvKe3iaD/RSLFGZpYHJmUqPPyazxN83dKFq+LiR7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVT9wFUK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b38de7940so3530585f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538572; x=1764143372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TImvYlNnQRMa8IRvJ9GWsrXwTK0Q8nmLpVv9SLrtH8=;
        b=GVT9wFUKcZnxOaXMo+JgG5fXyDxf5v0pPsOoc8E5WRFhLkKzjJmLZoRIou+Hc2eGUW
         Xs8EXfgW1oPqw7Q6NUhMjWidfRFQcMvbFcz46aK64zyUDzBiCtLU8IBqPs25owz34cJN
         gE0ORa2jzr1MU+J1pZRORitYG+vHzS3NT3vZID0EhVrb+QL4/Jlu+wsfsJkXmA3r4Rla
         16Mzlqczbf0qjdVOLeV9p0HXHd3Fdthp9PcBrIpRLclrxLOwgBt31bgohxf414oGx6VS
         lgJwtjgB9PKp3KKO4hgPfRuyiTRpkGdsyB5XLS+6cZYj9eG8hvo7TSWb82IX+IoD5VFi
         XV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538572; x=1764143372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TImvYlNnQRMa8IRvJ9GWsrXwTK0Q8nmLpVv9SLrtH8=;
        b=Zl/rfYvSTalygoxfDTPI+gD2XCMMkTAKvZdivwfe/oeKt34G5//m/irC7V5Ue/fF1F
         dhLPR2MkIdaU/HkaxLPExUTryro74rLeBjkjsGogFikmcjT+Ps4iilGXpS5o/nPuvV4f
         QXx9xNz49mS9WdLFLPnJnKMWvf3L7jOzGlvceRFL057jhOlOCb1jGeOPrYc1NwqMYsOp
         q3Lcopja+n7vNZ1V8b+Sy+bUfeOqL3Iw69mYUI0sd7uUrOlm6cfF2IFaa9gDJeaTYbky
         /Io0Hz1VGOcsy2RqxoKAhTFPlpILdM378FHWt+Yr9jM5DsEzH+Bkbm/brXpdCUJcW1Jr
         AxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU099r6tsFIvc2VqfSADyRGNijJf2/h+Ratkh6vfcCQLLljgkVsmHtIXYz09lqUD3PAHdX4u+sg14KXa/lt6A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AgJQcGZRxMic4d8AoxrWdkEfCLd3PxDtoRG5YuFzqD4qYN7a
	7rMsv4Iflg2RutPZ+o1fl44iz8X8INC1y1gZsaQcQB1A+CkZ6iE2T+T+patl6t1pVc8=
X-Gm-Gg: ASbGnctqAKjlsJLEVR/U+/joaLgC4ATT87XdOlfp6r6YyDPsIk+Juc/9dcl5DP3RVZe
	60GQ96QT7LXYlDNrDw4Osgy9TxPJV5WmPtM49Qi2A2+iSuOuPnmhTFORg2BK8bV81CttJRfpjK4
	7mH5XgxpJUUeg8nX20FMaMcjEiL3xgfvhIUwZeEgWW3+3x/12OMag+eVuIIkjUrhT845NwrbHpM
	EulqfRTL2exHZcgUOD/y4riG+EyyjDv1b+WJnvVMMNWD1FrzcP4pppdTVB/wZGVqbkXaQM7oTVU
	cQ966GG6NHT2LrqoObT+e6sG3oC7oua0Ew829nQCt4GsI2Bd2ziut1raRorEpcddKnSiXIJS//C
	yARjKcx5JvGi99sjg9tRDVDhsN68cgXX/pCuPprXOKSJiRCsZvtSmHux2oAJow0640MGCv4oDOh
	aX9PSySqgUTiNP8/E=
X-Google-Smtp-Source: AGHT+IExKSEYuSjTPblU2hxyhKKajyovUPxWOzaGhBnrkrN3rrrRZSJw3ztuShNlULzBNBuZEh/Fkg==
X-Received: by 2002:a05:6000:2913:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-42b593234camr20195873f8f.2.1763538571920;
        Tue, 18 Nov 2025 23:49:31 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:31 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:21 +0000
Subject: [PATCH net-next v5 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-3-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=NaSr0aRo/KeIcHaXa24IkgHFUS2s0iyQ6sB/nOVkiyQ=;
 b=AfPaO140aeo7SeI9ECUWkGDzjLBwWiPAMfF6RVgFJC1p1ZvjcQ19wWNMVrRxj6cSX6acWoOQv
 t3krehSGJUFBLOPFXulnjSaBrIAZxriN8GXhpXcygPCr3NFSN1vyOH4
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2d15f7ab7235..81641070e8e2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1460,10 +1469,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


