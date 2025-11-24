Return-Path: <linux-kselftest+bounces-46363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90649C7EF20
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 05:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0753A19EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FA2BDC1C;
	Mon, 24 Nov 2025 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB/jj6Nv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A774F5E0
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958833; cv=none; b=LVvSuU8twIDc5Jbb913qjduVFR6HZzAWSy3TFkiPtx7LwoaXDzFabzLiu+aww59XXHBSrX8/Fm7FSxwEVR3B+xiIgJCPNuQ5yYFKvJ4Gde6URED2ZFLGolCqn0SQ+YX+rMHVqMTjUJb7Z5vI4BQ+RwC73xMX6CaIJ3zuwczUAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958833; c=relaxed/simple;
	bh=W6PBf7PdMxwl5sxXKwCDPTJg/Po+Avybb+Aqokp7zto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/GyTqHv49aEnS4YrPtx4evbq8Ei3x/K4oRP2RQTvFHFHhfg/nkxZwPXSChtz+u8POGw/KKwC6IUqlDyJXvRDFpv25kvgqNn+lAwHtxrd8ZbkdA0gJOz9kRAkfKtdU2BUkO4YkWChhKkutDEqfyGHEdyZ9EEMuHcwyXnp/4BJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB/jj6Nv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436a97f092so4934231a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 23 Nov 2025 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958832; x=1764563632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh0e3cob9xg0UfNEEeCmm6wm0hKOqqoxoFVLHXYzIJs=;
        b=hB/jj6NvLngobFK+wDVbKit7J3iiNZ2Vt4iKdFTuwD61JBG7lsBsMMSD5YlgatB3IO
         2zKhSWfXLunH/myHDzKIEohFxMM44XKwpFvve8ndRhVLtSAyDZenNIaLa3cnCHABaJvM
         vBf8oS1w+h5D1H3aIPcglD4vRn8BYMu0cN2elrzlAOOZ1aA2k2Z9n59TWNnld3s6FClc
         nwksxy6yoPWqa4fKQHva2HaCfzdlcDXmkPHVQCPhpdE8usKDwxmKuL7tCKnPz3S1jxjw
         hIq4lJfcRJiAIObZ9aqRDMCFgvnm+eVhCzoxI02oFyhOUXq/roFPb/swCaFLJ/PZN7DC
         Rf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958832; x=1764563632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hh0e3cob9xg0UfNEEeCmm6wm0hKOqqoxoFVLHXYzIJs=;
        b=FbpJ4c3Fhhsu5oLujHfKY9qyG1W2LOduMfIWfleKC/sZwh/q2D0swSqHzEqixKqQZU
         JcqBpDTsPRsdNTJrh2DW1qqnBVUrdhI63Im93ANkBCBFEIk2sCMKfvsCsq1Lofdqp3UK
         BF0ve8q6dMtHcAPjIqNi7u9axYo2eJchKKsqPmHa7xBBA8NK1XzGMjQo8OcIq5cvqftI
         jfxOIBFSwwrC/aDoDmye/7QvAsIwHxQkRDZJkzMRvzEceUZNuiPVagEeqgcizhnjbGnw
         SXEBEDFNpHjf0T8s6SvN9xm7WP/cgMVCC90/OtfxN6ciSXvJuO1oKMnhx4HIp6L8Gfwj
         JJOg==
X-Forwarded-Encrypted: i=1; AJvYcCUmuUWbs8wvAaC0OVmWqgbD3Us/eeDIAsJanQwu1YfAq0q0W9sZx+7WaGkG88wgBR4xZ0HKDJf6mPBKHD68NCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYvNZwFp/50500O3pGhui/r4mkBpJZuVnxwaZ7UMVgcyrICAB
	tlFzN9OJ6EOAY8Gp3x3BEHw5xd72DuytF46/YjYvd4o8nawV1I00WAcP
X-Gm-Gg: ASbGncuakhnKtZ9Au116wt9b1zwJthaWUNqCufOJF3YWcfM/L3Pmi8VtcODxrcuYrTz
	1y3iPeRtT8WtbNor+wWrcYwY4F+9Hnno2ti9Xd3Wi6HWgT0rt/7c0e6pw4b0xQcaNJoxUhuVoSQ
	w2V93Tlru1hxBUDVS4UsRkpywkSJe734hNkMxOoWfxnQVGvdNEdKP0vo+AGYsqGpZaHWCqSkj4S
	cekC221PQAWr8B6KbdA/0GW2S9huQdKPNAFge4NyyIw431cUMLTtCwwm+NUjlpm2ItmEcjamvFB
	ZFwu7PqIatC3IN3+847NTK9sDIRPPXtxf9q4yIPa/gCDsvtosFs6f497lD0UpwB4V+jtDcs/cxU
	PluvY5u8I2GP0TjwZjsvUipgT6+hHBondeV2cYpwzhFzSlA6pvCwBnSPIuCAkVDoJMXoXE/EhqK
	6Qj12LpVCEbqF/mVc=
X-Google-Smtp-Source: AGHT+IFS7PubKfEnizaVitxnmb/guztAvJx+5buvOkD1qNO/uxlfnExk2UHLqs0lv44/WStooZFrYw==
X-Received: by 2002:a17:90b:5704:b0:341:194:5e82 with SMTP id 98e67ed59e1d1-34733f4449bmr8964902a91.30.1763958831714;
        Sun, 23 Nov 2025 20:33:51 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:33:51 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
Date: Mon, 24 Nov 2025 04:33:08 +0000
Message-ID: <20251124043310.34073-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124043310.34073-1-liuhangbin@gmail.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When disabling a port’s collecting and distributing states, updating only
rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
so that the rx_machine transitions into the AD_RX_EXPIRED state.

One example is in ad_agg_selection_logic(): when a new aggregator is
selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
not set, the disabled port may remain stuck in AD_RX_CURRENT due to
continuing to receive partner LACP messages.

The __disable_port() called by ad_disable_collecting_distributing()
does not have this issue, since its caller also clears the
collecting/distributing bits.

The __disable_port() called by bond_3ad_bind_slave() should also be fine,
as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..d6bd3615d129 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -205,6 +205,7 @@ static void __enable_collecting_port(struct port *port)
  */
 static inline void __disable_port(struct port *port)
 {
+	port->sm_rx_state = AD_RX_PORT_DISABLED;
 	bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
 }
 
-- 
2.50.1


