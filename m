Return-Path: <linux-kselftest+bounces-35187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D616ADC468
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D13AC52D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55A23D29D;
	Tue, 17 Jun 2025 08:19:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B423B613;
	Tue, 17 Jun 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148348; cv=none; b=KjZlT3Q6ChXAdkkDB+pqIlQXbKZcBPlWj7WXGkCxNQpEssdsE9SyzYJZACAQeulTso5enktnsIg7m12TAYKkkrj6LT+aaDBTrwPahpluy+H0+zS+ugh8s1DCEBxhaK9hnPgUU3lVL1gWVmRFKh63bycMzIARDdPhraYgT//4q3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148348; c=relaxed/simple;
	bh=0QBx3S4pR9yGPZRxv42Jcjnl/yxbqO2uUWAQbRqmdcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOdpFyMyycfd3w5dBO6tlnLSoSY8ZzsTsOjiUWJDze/JDo3l+evSSqCy/0z7bejPZNzlAFeIe+b74dDSUC1m2YfLgs/5PuaArX58dDCSxAOrs1XzfZD9nkyfY3e2BAn0lJ5qp/N7f8pax1LM7eh/8oOSExsoxTcIXG6JxSQjWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade48b24c97so849097366b.2;
        Tue, 17 Jun 2025 01:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148345; x=1750753145;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU9RK0FjTK1hqgTN7WX4td/gkt1srvZwQJntX2m5NRQ=;
        b=ZC8npfN19uHtt5doADPIs0dDEi6cAJAWLvWDKdd49vU58hpCZV2MLVbbLmlGT8tw9a
         +MvMdWCEhdaWMncDwwi4+dUK9JTLypINgAOsm9Us8rFNlEUwhteoQaG8ISe3ga/ibWop
         XYfYfeEk5i3bz/SAgUm0gFUEMuwlr+K3P2JHKF3FuKNhBFWMZR2pmZLX4Ud7/50B0VXc
         UwUOPvMMnuBv/Esm7E3g2Pgw1H/mSlCsn/Qstyh6k7nEoRz65KFBOlp+AWx3lQwJ39JZ
         ZpcpETD6zrOkPj8LK4oJ4PV9E2dc5svDzb4aJRFxzVgI8c2oNGjmfnmjS4g9V+O82I9q
         IWSA==
X-Forwarded-Encrypted: i=1; AJvYcCV2owwNd7lyYpIFHoqkT9iBXmpoP/Bb+vX4JqTd2WkMw3YVLerytOyWZsSLapESEMOsmXQNUZlSia+EKvnHQCEh@vger.kernel.org, AJvYcCWopoqFStz1/4rwFnIMwyVr6LzQffA0JOYWT/4bJ2Ig5dwTnyy6D4I4Kkt/yvH6aQhO6oT7ltKkdvzwO48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PQAfnsjeLweKPur1wR+arWQxv+N64X/vBQQw6BNi99g0oxA9
	nrBJ0TslLFK5YNhz1XZuiGY1n8ig8nWurkM51anfdc6oYwO8qxwyTzr8
X-Gm-Gg: ASbGnctElR9jl/gGyay57Tisj0LZN7EXRb8/NugvVGGuAxx8jzM5mMG7eKpxdeoC5eE
	o/NHsLDEHd0j9I1tyUp9r9AeMR+A5jWra14hXpArwTKrB8J250MzwSuGa3y+YOzwWMlx2s+i9+L
	Gqy517RJZqsrg9Y1TMNTQtJ2EtoJaNnPM+0VtLsrdV8gYdzVAug7nzA9/7iqbvkIx8o7sqYLcPu
	5JHtMXGpPploAtdM/AP0EcHTQNYCD7BjSiRfoKnZluckd6Vmz5gVnheeNtRtJ9A4bcPsTO0i4a6
	VJQXZFNIdYLsMdBZKSpZsewIJI972YGXnYAc6O2QkT3RK2AGjEySYR3ankrJ
X-Google-Smtp-Source: AGHT+IG9ywPdN8qyZ23q8J76IOZM0OqfE3nGcxdDTlCQCbnIyPwr4P36tPZ/M786LEOJQ6SOUX9tPA==
X-Received: by 2002:a17:907:3c94:b0:ad8:9909:20b5 with SMTP id a640c23a62f3a-adfad4b7cf4mr1235254666b.56.1750148344390;
        Tue, 17 Jun 2025 01:19:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60992edde8dsm513720a12.23.2025.06.17.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:19:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/4] netdevsim: implement RX statistics using
 NETDEV_PCPU_STAT_DSTATS
Date: Tue, 17 Jun 2025 01:18:56 -0700
Message-Id: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPEkUWgC/2XNSwrDIBSF4a3IHcfio7GaUfdRSjHxJnFQU1QkJ
 WTvBemgj/Hh/84GCaPHBB3ZIGLxyS8BOiIbAsNsw4TUO+gICCZapjijAbPDkvz9lrLN1LTGtEZ
 wZBKhIfCIOPq1ghcImGnANcO1ITD7lJf4rE+F1/2N8l+0cMrowHmv2pMzqh/PDntvw2GJU7WK+
 OzlXy8oo0aPVmot1XDUX/2+7y9tlkOc9wAAAA==
X-Change-ID: 20250610-netdevsim_stat-95995921e03e
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com, Joe Damato <joe@dama.to>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=leitao@debian.org;
 h=from:subject:message-id; bh=0QBx3S4pR9yGPZRxv42Jcjnl/yxbqO2uUWAQbRqmdcQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUST2VV2ss8ZKdD+wi5ZTaPVUXHOLML5c0Obeh
 PjmI7e2QEGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFEk9gAKCRA1o5Of/Hh3
 bcyHD/9sD7qMhejP0P0QOecX4XrtneMqqObWYqwy6DLwNIbRiGFV7P4lnTITFqZznWC7ujWLzb9
 zjaGaSI6LYiUL/6c3EScwVMG/g1OCYpkWBcOMUOcMW2HsJ1WC/c9F7qI8PX9YRg7VbitE2Hb16V
 LlURQj97s0TBelOEgthzaOz5flj2fAfvKLA1vNdpFsvUYtHqR1yJgVhBsrCF1SgN7bGiupNtUTv
 278qbCyQV432wtKK1D+y/crzccDP31x94li4cfDnQhpjwW0mxr38GeSD6xoWAwfZcg6dqxjGMCy
 lWUegnQCNDIGsMkO7MaKbsALT8jTxRVJM1BLvpQgxK/GcZk6ci5IXnwIcT/5xbcdNJeZcvvjlSW
 ZGGjJs70dLnTp2AwmnPgzUcJGja6Hf0MkRs/zjcwqUtbpEtASNDsyN3q2Hs1l/jwOZbmL8uilzA
 GwJMFc2JFIANDGZn6T8v+2J43nfYBLXQRvj5g2N2CcDMEKQFcpQ3HiRpeHmBmSSuvaH3I6r2N3r
 CbTYR3UvoWI7CD0LAUgXxMGo29GxHLQUeqs/GHCaT/Z3r35NwlqLY5yJnqD2T5bcEA0Jt6anD0C
 fLFPh09xSvnCvaBwGQc00/Nj9eQDz4mFoZouExwSBFj8a3tfE48thv4meW30BwfcyAiUyWIzaAY
 2qxP5ZAuhDuFYCA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver previously lacked RX statistics support, which
prevented its use with the GenerateTraffic() test framework, as this
framework verifies traffic flow by checking RX byte counts.

This patch migrates netdevsim from its custom statistics collection to
the NETDEV_PCPU_STAT_DSTATS framework, as suggested by Jakub. This
change not only standardizes the statistics handling but also adds the
necessary RX statistics support required by the test framework.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Rely on netdev from caller instead of napi->dev in nsim_queue_free().
- Link to v2: https://lore.kernel.org/r/20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org

Changes in v2:
- Changed the RX collection place from nsim_napi_rx() to nsim_rcv (Joe
  Damato)
- Collect RX dropped packets statistic in nsim_queue_free() (Jakub)
- Added a helper in dstat to add values to RX dropped packets
- Link to v1: https://lore.kernel.org/r/20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org

---
Breno Leitao (4):
      netdevsim: migrate to dstats stats collection
      netdevsim: collect statistics at RX side
      net: add dev_dstats_rx_dropped_add() helper
      netdevsim: account dropped packet length in stats on queue free

 drivers/net/netdevsim/netdev.c    | 54 +++++++++++++++------------------------
 drivers/net/netdevsim/netdevsim.h |  5 ----
 include/linux/netdevice.h         | 10 ++++++++
 3 files changed, 31 insertions(+), 38 deletions(-)
---
base-commit: 3b5b1c428260152e47c9584bc176f358b87ca82d
change-id: 20250610-netdevsim_stat-95995921e03e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


