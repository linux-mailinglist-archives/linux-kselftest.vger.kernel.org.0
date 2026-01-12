Return-Path: <linux-kselftest+bounces-48729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15717D1192D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39B130EA27A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D434B19A;
	Mon, 12 Jan 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSDeJSk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197E34AAE8
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210876; cv=none; b=iupSuBCPbgP9f1ZDiROsPQXNELvHnBiJtc9HVrv760dUkEpD94xlIDV3pqoN24HO5b4WPInq7mBqo96BG0o3OLX2W/kjLN2UYD0VMq7I439024KO1hCW+ub+pCxedOT7ixlEDiV07/IWTJwI9EquARQXEP2Y7SuNJAsh0gnXmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210876; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vr+vDOOgWe02gbxA0buXCEPBu2xVF0nkQMoWUuw8Xs0w33u4hrkmWqQV8cagSV6bLP5xOaFLzzKxl5XdW4BA4vuwrzvDKrO+XD/adHKqBX56S0VRaJmBNpintw+atN/32rZZ0ewyo7mAvA+ugdphE9lh29MRwkAfhduchOtYek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSDeJSk6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8718187eb6so117141166b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210870; x=1768815670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=fSDeJSk6UbcouQREN8szTwgwXT7/oN3dbamr9B5x8ykQKVu+JN3o9WqPalWaHCNSO3
         WddeZlN7uUdMHNvnNuvzU/49Iju7ZI6eG/2Pub3oxNmwh43GDr4P+n7HnHToNeVU9NQW
         vX4Ur4okH0gswRREWihDMbGR8wdnrOv0yh9oEk7TQF6k6sCEQiSVYK7+6Z8MMZzlxIeb
         dhnYiBbtKLqSNGNNhDfA1JOwywJpe7/IXzmK8xPvsZxsSSkxnoULitSeT1SmTkexzP3g
         Vm0V1NfhL+SNjMWBa3vvX1Ekk4Ih7/lApfgWODl8/kVZ+ZG34oHCrLR1l9uarqBsXise
         6oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210870; x=1768815670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=U8MwVzH9vevJqwd4ZiI9iIPfKSuJYSwNpKSXGqh3IONbLf6hRgNH9U/lh7jDaoprgT
         27yyW7MI9vlPJvZj7ehjjpVx3t4afHeCNYq8VvDOfVUmEVj4AZy8JbdJ2BNI5URlmyYl
         RlvnJ9JKPniUMwiCUnORxnyEC+xJIuQeVcsklIEUNNfrqUZqIrLT02VFD0YZRyO0tolE
         9L/fFqL+tvf1KpIqKzqJcVRbGv3o8iNTqyJIujt/pnxIXOTNEgyFofBmJhyp28pmscEU
         0PqlNVWtikVZaiuAwoIYvCy78P/Ey73LoOGpuqc3ijrlDjS2Nzbr4IPnHMr0yUlCPxuB
         Pf9w==
X-Forwarded-Encrypted: i=1; AJvYcCUkbnqgDJ5XBUkYujRSzt0zBTm0O7jm++jbej/rp1v0ABTsAtrqB43+EqFybJC/XsZ59LcezqvC8I7dE7mhFFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsyDly9XRM93oEELl3QUg9DZdcBtnuOowRXvCOgOTDtMb93vm
	Kl+h/rGQP5uA3cu9BGHPnio6GnEiEOEmm7j+c8GYUe/sm5fwstd40OCr
X-Gm-Gg: AY/fxX6swIQfNmjxpivkBGABzOBs4WDLyOzelGBz5A2Sk1RABEfuCdpvJa5H58+ReMe
	5sJduRu5KOGD0F1P5Xt3FHtsQlPKy6ulEZZ+O+iFcaoTxbjZjdAC0rtajEYdPyhralnifZ2DItu
	yqZ4Lax1gsAddJOUJNTqioI+WdRINiT/1LkPv8gT7x5ZZFbXftVkQ+xCX8F3w+lwa2y+Ru4VvBT
	kalsVEW91zY4PjZrDg5ygJ4+q6nhGRgu+SY9097F90oAFyD5m5sXTStXW5yhDTMVEtuZD25pHqd
	gIZR5P7531DI69UeOXLRlj0iQlpcKFF/dxCV7rf/125Fmif6XB6//AXrUjwRgEdctDQR5oTkIhc
	wiBZ+6wKZViKyFH+EV5y8sYExXXdQRkx9RbxtaJpOJE25RlNAFZIoLaVUdRwJo1VHWU7k8ONmCz
	n/2PmMBld419cCJA==
X-Google-Smtp-Source: AGHT+IFgXG9FtTcTI9askJdKeBxyq33PRdfuWUfeE7I+aLtTeSoRzhvi45RlIzresGDM0bGDZBuCdw==
X-Received: by 2002:a17:907:96aa:b0:b87:2f29:2075 with SMTP id a640c23a62f3a-b872f293a8fmr29106166b.28.1768210869514;
        Mon, 12 Jan 2026 01:41:09 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:08 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:55 +0000
Subject: [PATCH net-next v10 4/7] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-4-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=mJMvftO9vWbVYBySQMvlOwCMj5f4rBUZtkx2lrLq584MFm+ltB+706sfwMCzDJQBx7wk+Xlci
 w5HTBqvAje/B7OnUjjgU7ShiKQmeex/RTuKoFvg47OT8MDh8V3xwf3q
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


