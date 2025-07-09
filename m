Return-Path: <linux-kselftest+bounces-36802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F278AFE380
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D117B582F5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D7283FFB;
	Wed,  9 Jul 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID9WK1u4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71333283FF8;
	Wed,  9 Jul 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051846; cv=none; b=R+eEvSiDGxQhtNgv+8eaYeWwCevupG7vZrVi2KzMr1mUKU9zdSMOx0COGMqjLDTAChtWmq/VNgIQSGENZqTjmXYfJuJ8CB4pwERjlURlMJ0pEiVZwH7+VyoBW88tYQNjOywEi3Zc8mPOpxTn6h0gKVH8qAfL8R6EJ3wDQOViHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051846; c=relaxed/simple;
	bh=fuhRoN44sykPrxqHxaBpJ6OTNoBU3PufyP8vggC7Nfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwrR64tCSH8OPjdr8cvA2F29FRPZ6oPteJkXyM0rjj8ccEIsnjYNEeKwOgKpGhgx1sabhY22IhN98y8hENCfSerGZK6MmmXKcZPjeoHg/VqdVLZaS3oPWpy8Yn3VYPbsAVvmz7gCdAO4c8U2ApmCj1LYcLb7TaXfyDUE7LjQXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID9WK1u4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c3d06de3so6233738b3a.0;
        Wed, 09 Jul 2025 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752051845; x=1752656645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLrnzIfGVhO8TLzNIiXICdYeSbcwXW1fEiJXagDJeY4=;
        b=ID9WK1u4+LO2TOCq1oekSAkwhSeEzSnv+3S8sftcUJka9p2X8gib/ePou+NeBBe53o
         67/RYbmY6KzelEaWhfqY333ZsjRH52dSuG1u7hT7ddoY4gh63JWPJw3pWfkLLdjENV5R
         skRJb6d3bq9NUiCXTvOKImcxSfG9N6W0/MRcpK4ElZFfPmUPyZEWN4r+8ywFp3VQumJw
         m6QRPUVG7wIg7oy1vuZUC+kUF9vm+mDYJsU9//DRLsiPZI8jv3qOsLLdrpCGUPSzf/M+
         hsuKZd86ZgnUUplEnlRjwTAzuMp6orSnJdEfFYsogj/lI6SueuSRam06d8C9WCgfYr1p
         B6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051845; x=1752656645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLrnzIfGVhO8TLzNIiXICdYeSbcwXW1fEiJXagDJeY4=;
        b=Kldqs0lGw6Nih1lO4aYZqIvW5Z4N2xxRxqUUH2PpBUprRON2A7PWlh+rmAVtVOwitl
         YOe3yrAqUMA4qXR7d3OhVA6dmeHD/dg6XDNlO/h/8WhZpHL+tHSDX29UavtvzCVuejUD
         QWzIUFF/pItPte2xlrPn/Bk/4BKTRQPkE68BaidLCc6WTjv/rCkT0cLVPbQVYG1JJU6H
         CVrjIRerH5z/wJp8KegTZr6oCSzhg4EnAKPbHo2gcTQNZRFGKmSoj+3WcQYFSpbJG6zH
         30B11+txkEgn3YCjDszheHPgXLR1/FjuNdEc8dDxOxDW9VKn8BdBFZKrJhjiv8lwVsXy
         xvTA==
X-Forwarded-Encrypted: i=1; AJvYcCUVQ2wvvp2uAJI3491WRMZumKYHafk3Jtmd4SkKpHHmPIZKXlCt9erIfkNoExA5MAlmhHLpqHxW0dYE1Do=@vger.kernel.org, AJvYcCWgaUfUIZKF9kEGkHwezQhMmfsj0mDYi62iaXYK/DSFA7lVWMKVqD12vjmy+a1MdHiB5efwJgqm0B9faFVGNHbN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi98uzLGMzWhUU6qO1hGtAptFXl1cCtsfH7xxutSQMry1354Up
	7lQof5BcSnoyLaHMQgdNLj0ChkhHtpElu+YUrGtvzvNeWAkzNeuGeQ0i1fT/Ma0j0YQ=
X-Gm-Gg: ASbGncsPyO8jFxbgoL1O22+ESfL1pqJzuypiXrq5fxaGiD+WbCYI0GU9JMcklaLAFvO
	TxCZ3SePXUktDMoVhS1BsbLdzG9eNY5jFSI7dcHR9Gntd1H7EJsH2Frs+jMQW0OebC4WedY4GY7
	ydTw3ZA27gWRpTsiVJEIweBPLgL1bUkVGytTiAMk0K6xo7v9aSKOxXMnZ9u5dOTNHvzHlT03hRO
	t/DUCCGGUNWPtPDaRkFee0iPmxQch5VEP1fKBkfxPAyTz3gZFGvt9cO+bRfi3t9jEvyzqY/tkZI
	padffSMJ+K+eOrvuR5lQYqNXXFwTbyBWvRbzwm9hEA3g5V/DQEJHTO8kly7x3hWaVgIT5k3OrNi
	tbMMOitYDgJLg3h+xm8254A==
X-Google-Smtp-Source: AGHT+IEyCE8+Ny5BsBmO7ajRpWmhD4ILEhyY3kPWxWGhEVaoCXNHto2PAvgWmBNy6PzQpW/Jz2AqNw==
X-Received: by 2002:a05:6a20:7d9c:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-22cd5225ecamr3237180637.0.1752051844559;
        Wed, 09 Jul 2025 02:04:04 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74a681sm13619309a12.76.2025.07.09.02.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:04:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] bonding: update ntt to true in passive mode
Date: Wed,  9 Jul 2025 09:03:43 +0000
Message-ID: <20250709090344.88242-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250709090344.88242-1-liuhangbin@gmail.com>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lacp_active is set to off, the bond operates in passive mode, meaning it
will only "speak when spoken to." However, the current kernel implementation
only sends an LACPDU in response when the partner's state changes.

In this situation, once LACP negotiation succeeds, the actor stops sending
LACPDUs until the partner times out and sends an "expired" LACPDU.
This leads to endless LACP state flapping.

To avoid this, we need update ntt to true once received an LACPDU from the
partner, ensuring an immediate reply. With this fix, the link becomes stable
in most cases, except for one specific scenario:

Actor: lacp_active=off, lacp_rate=slow
Partner: lacp_active=on, lacp_rate=fast

In this case, the partner expects frequent LACPDUs (every 1 second), but the
actor only responds after receiving an LACPDU, which, in this setup, the
partner sends every 30 seconds due to the actor's lacp_rate=slow. By the time
the actor replies, the partner has already timed out and sent an "expired"
LACPDU.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..e001d1c8a49b 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -666,6 +666,8 @@ static void __update_default_selected(struct port *port)
  */
 static void __update_ntt(struct lacpdu *lacpdu, struct port *port)
 {
+	struct bonding *bond;
+
 	/* validate lacpdu and port */
 	if (lacpdu && port) {
 		/* check if any parameter is different then
@@ -683,6 +685,10 @@ static void __update_ntt(struct lacpdu *lacpdu, struct port *port)
 		   ) {
 			port->ntt = true;
 		}
+
+		bond = __get_bond_by_port(port);
+		if (bond && !bond->params.lacp_active)
+			port->ntt = true;
 	}
 }
 
-- 
2.46.0


