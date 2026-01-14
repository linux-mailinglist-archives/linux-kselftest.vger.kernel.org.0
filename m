Return-Path: <linux-kselftest+bounces-48909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D575D1CB8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 07:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9447C300F063
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0C2DEA98;
	Wed, 14 Jan 2026 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkz+PnHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848336D51A
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373406; cv=none; b=BKwabbX4ztDyR9yXc9jirLKEjNcPNiXlddkXcLZxqbKwffigjZ5kH4DkesTt/L5aVHU6/TIKlkeQ7Is+6UIijNf+r6/fHxGntGd2VyYdXZPwuXp/WU5BMsKOo+F/1SQiSuN+Op7+Fizs5tTXqDa69jJb7qeamaKkV/BFpImwSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373406; c=relaxed/simple;
	bh=BayOriLPbqMfaHBFOoZc4HEtQYI5iJpN0d5/54XKytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBUqyQ36Lbxt4u+sN64RFFrs0ehd0I/N27j6500WDzzQYFdVhxActwihjWUjg5eaBkwvsd3hZBmp7Ne+QbR+4RH8mrENApHrdsD1AuuOYcSibEauxg+zB+u6qS3V/4sU69N4v4jsk+3d0EBtgoLSJ0atWQY3GSMWi4O2CKg8hTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkz+PnHT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09d981507so3995545ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 22:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373390; x=1768978190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpHskSlCFaOI6dQ6xmzezOZiBd5LtqsF5PG55W/Nq/0=;
        b=fkz+PnHTytLUVld3vlYbXEg2ifBuEyeCjAsYbFh00CNdhECXdZgn6hcffsTeIfq7QS
         PvXhw/LnO2vqMW6S0rPLS8TMtTJwwWcYHz1RInzwUPuyMl7J33wra5s8cTBl5yuzbzhd
         yyO9VViLuLWi2yPiOFHiErWRkkTfyhVJyKGYSRQhTlQdN94RlCRlRsIH8G6PQ/eA5E2n
         4CJ22/LfsjoaQT+3SvNNstqg46G4Iv82SXF1fBGh9u0DRz23Ob5xAKbP9cRJ2dIyMNm/
         qATPcmFaPDGzncWUq55CTJi/oJxeiDjk6zNqtXz1iSRcE2Ns+sbcgywOxwzvGiNxQ8xv
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373390; x=1768978190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpHskSlCFaOI6dQ6xmzezOZiBd5LtqsF5PG55W/Nq/0=;
        b=EnyFUi0j5/eIOZCli6VnmfJ8/lBu7BywjGtTkqcIVfzH0xlU1+s3KLcJnYR3xU5FQK
         bep1ldAyYfmX3ia8xWbHTujzovjP+O/LdYIfwpebL/aCLt2Oqgmz+vms96+yBUGzDkLN
         DHxezvjzl3Sk6U7Mlnd9n2gRLeZNv/kkpih7mBdU6Yc41Z7pkcxkQHKcISsLu6bGroBs
         sGh43C0eFDrbO1LSzGcf89J+n8+oT+vkMOgqpNDZ+p5E3SVNNMk0xu183Dfj35XSg+hr
         a8DVMpF6njuIKkmidBXA8n5aAdlaI36VSxcSiTAOcRwnWsyngKCReSoi3lyptowvoArO
         Sk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxR6SbQf7qmxeAYmeXt6xH57qcP1PHpQ9THiPDTxJB7AYwS+SoBse5GRH8Faui51Sc8pqrdV4OThiyBKTLZew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PlvaPx4Ab37RJTPRDTE2E5nT9W6S/Q8Lw6jEIT8Pr78+BpRN
	XTFkDV+Dw1F18DZq6zO2NjJ3scxdiuE6yK4/x/ZlRtHsU3JKiiRLB0w6
X-Gm-Gg: AY/fxX7ut/PUw+tXpVknrGSfN41org44NmZIYRROT6vzTM79o0Z2X6N0dq8R5XYynQm
	YMwrE9llOon2IoxguANBqS4S9v3J/zoY4H+a/m/27sn9FJJjsH+RfNr4vnVrSrpoz2iSe0W5sOE
	HXhPwgXGeuhya7W6obtXcNvwcqKqk9ZzvdYk0b2PQjdcahcDmjSqcs0Wj1aTM3S7BRgrZFu7E2B
	0WQYmZJkGLlH8E3orWKtoBCjLgBVJTeBTDpdgTT6XHAF7RITgBOjVtV5D6UMYJB/oeshd5g9QpJ
	6ZKXvoYPV8R0t3anaySpM2VoyolNMFn5lwe0wNkIbLTv2YlS6ZSI+a/m0zSTKj6Zl/PU/EbpySI
	9KAHI9pajNZFfh8nL49B33/BxaU/P2ch24lBhFIo33abAxjPSlaUKy7K71Gg9rHBc0jVnlfOuwg
	aJbl6vkO3ytRQEjwE=
X-Received: by 2002:a17:902:e184:b0:2a0:9047:a738 with SMTP id d9443c01a7336-2a58b51b64amr33338845ad.19.1768373390001;
        Tue, 13 Jan 2026 22:49:50 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:49 -0800 (PST)
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
Subject: [PATCHv2 net-next 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
Date: Wed, 14 Jan 2026 06:49:19 +0000
Message-ID: <20260114064921.57686-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
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

Let's fix this only in ad_agg_selection_logic() to reduce the chances of
unintended side effects.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..bcf9833e5436 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1926,6 +1926,7 @@ static void ad_agg_selection_logic(struct aggregator *agg,
 		if (active) {
 			for (port = active->lag_ports; port;
 			     port = port->next_port_in_aggregator) {
+				port->sm_rx_state = AD_RX_PORT_DISABLED;
 				__disable_port(port);
 			}
 		}
-- 
2.50.1


