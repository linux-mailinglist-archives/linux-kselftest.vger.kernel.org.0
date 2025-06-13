Return-Path: <linux-kselftest+bounces-34888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F126AD89AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1A3B5C30
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF512E0B7B;
	Fri, 13 Jun 2025 10:40:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FD2D6626;
	Fri, 13 Jun 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811216; cv=none; b=FvLFIOwzO9tY/U4/8tJ244CoczIHxJzFal/qPzD6kVVj2toObankPBK3vIqNeivCgTdzUSEDfIfjhK8NHasjGrHOs447af1xvRvTzn86uZ6unI1aUTrUDRap2ZJavdzWa27XrfF6hMsMPUJ+wwU9YKF+gLFy1B4SBTZ0SkE5AQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811216; c=relaxed/simple;
	bh=dAmZ3qugqm+tiM4ynpTDxe/j00JCVxfOXyXsbGJgpmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3cWAw+cQaOB+UniiAJm4nyHK14GMENbEeMqgEv3LQprI0wX5THwOQOANEY/OZkOqXK3+vuAey2Sl3dB/15wnQQu0Hqdjon6jXB6ZgVCHdpxdjbrlfJr6EDkLF5GRwxXuz4qDk/8jQIpYyA0zsRMhoT0Hwoqc8C4kUnuXeajRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so3961770a12.1;
        Fri, 13 Jun 2025 03:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811212; x=1750416012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIftDfMkceMxkxLhUUGaa3UujsACegogYhkf66yFFwY=;
        b=rwhMcQQdo3uskliG4Du3XDp3cqUANNCFyrOnp3WguspWMwt8SPPOWSQ0BNk6/pfRkC
         Hv9Dm0ndLtQylKWX74yg982H+V9wC0Btv0IzhFRYe7y8Fww4hgaC1gjnjj8pVdhqPwMH
         zhY5fA30d+snfYjUz9dtA2KDKlUGWvUkuUZMH7E1tB37UHcIbZkomtrAzI3LkiJq9k/P
         Qx8MIGoTR7A/pYEePwPjAVrYulbF6laxlvVJdLnXdA1PFdVMZNfbxjz/QFhS5SgzstY+
         zU0rVkMva0qKTEbZ593SuoZljpO7JJ+Em8AU4dEQc2KcfUSlq8yaoOFlUphx3wbrIYWz
         rIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWL+uLM98j+r5J+bBfa6xUCwTX8dmIW5ZIX9kOyRTVS1DbVbT+3ypRLV7h5i4GURAa20vTsdN1JolQ4U8lvwXyw@vger.kernel.org, AJvYcCWfOKJMok1Mi9y5HG1WxBlJ8uxIF/lHi4ug1y/ly43zMGkOlRf0jqCCi7rBDGcW9nKRJB33Ze/CUnASOeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGlg7DvgsEnza8r+txzS6um4A8Z9bWy8OOQ2ch/ZDcgPZndOBp
	wDsphYqtidNgX7XiMQxPVDsCn4m99uVDKQ8UFcvYJ8KwQDcpgfN2Ejhh
X-Gm-Gg: ASbGncsB+bcUostEP4FHEsCyV8E4orfYLXl3UL+GIwgqLN0cprjPD95JiqkvMUlSakc
	8tZ1giCfLBINBO1pCv3ElAVFopgk+wbskFtPKQc+K3oFvCKea+CVbVc25btX498M3kGLhOl90vd
	uIvLVfCS65PNn4p5k1M/oMsAKT4pmxb4IFQG+Fqkqx5/f96vt+gJs3nmHMOO9J1ma7YAoHSo/2O
	pw4Qis5cdt/cP2T6MasW2Z0j14J/FpxR9Er7cTL0nnIlTKkpcneBRl4Llr/AVYtj52Fgr7vD5SY
	pLCS0udC1hlJyNAo3Ys8s9w8/Jdlpy45TXgR1y2Txv6ezbwgdcrY
X-Google-Smtp-Source: AGHT+IHHLSxc+xUJPuRayRXWCFW4lX+3QUdIMVKbHCIL/fvUFW5YJUU3X6gP/F5kK5iSyPTfIl+CHA==
X-Received: by 2002:a05:6402:350e:b0:608:3f9c:c69d with SMTP id 4fb4d7f45d1cf-608b4a7c399mr2332923a12.33.1749811212380;
        Fri, 13 Jun 2025 03:40:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a5e6dbsm1003566a12.51.2025.06.13.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:40:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 03:40:01 -0700
Subject: [PATCH net-next v2 4/4] netdevsim: account dropped packet length
 in stats on queue free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-netdevsim_stat-v2-4-98fa38836c48@debian.org>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
In-Reply-To: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=leitao@debian.org;
 h=from:subject:message-id; bh=dAmZ3qugqm+tiM4ynpTDxe/j00JCVxfOXyXsbGJgpmk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAAFO2iWF/G4Co1VLP3kJ/3FmBGSs+dhxvnm9
 X/32O2iMy2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwABQAKCRA1o5Of/Hh3
 bYceD/9RSs3B2x6tkmwgOaxcn7t6EGV6Aax2U2pXKenLOuor0s4TGqDgAXDsd7Kj4K/Wa5Aaz2H
 eHRp6jlqFwBzBwm5HXOxJvMcE8RAkTmsXuHEE2H0FhZXDM/wlMTrEiWEe61e71/ZjOKMECqCtrJ
 BqmUJ4Sqf7gD3U0nNt5BEFtytSkchlOykttP1Ngv9xWL6cTVw8Cv/0+obnHxcuRiCO5phuoDhhy
 v5ddD3sQJ3FZTHtFOFZ+SOGTIfmdWKrF5Aqh4b0pLe9NAkcbkA/kIoWBZrhrtqpe7RzKb2o2Pmr
 +gVYcG0JnGt47tjGmmav3YRVI0S7RMq2sH2NLz69hFEzX49j+PXueGhPIi5cqO0BwgdhwvyHF4A
 RWoo5/Y0RIDqrAaFM9wvpiyKlyhdskSmZoMUmfpkrfC9Uf9i2qKY7Rt9sE/04ZXkuiGWzSQeFOK
 oJ07oVPuAI3IRE1Gfq0rYg38/3UX3nrX1cEgvAnUkTKLeJq+/UeSpRjN6P0pI8SBrp6H0sB2ar9
 qt10icejHZ+Dw001S6aLwJwHmr5mB15A+KBmmFRMg1uARrpOm+hgRscdn6qfMLAkLNZJ2Khecz+
 oXuD8qORBVpfYBaHZruyD7wnys4+CDFjSTkVoAhTfdzp8FbJC68c0L6kXHQVks0T0fglydbmEXI
 4vZGlxTdxGfCoow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a call to dev_dstats_rx_dropped_add() in nsim_queue_free() to
account for the number of packets dropped when purging the skb queue.

This improves the accuracy of RX drop statistics reported by
netdevsim.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index de309ff69e43e..6e8fb8922ace2 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -634,7 +634,10 @@ static struct nsim_rq *nsim_queue_alloc(void)
 
 static void nsim_queue_free(struct nsim_rq *rq)
 {
+	struct net_device *dev = rq->napi.dev;
+
 	hrtimer_cancel(&rq->napi_timer);
+	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }

-- 
2.47.1


