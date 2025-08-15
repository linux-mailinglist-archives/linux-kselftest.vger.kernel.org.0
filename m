Return-Path: <linux-kselftest+bounces-39059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A42B2790F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F71E189A1F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C129E0E6;
	Fri, 15 Aug 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSlWa+bU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE729D292;
	Fri, 15 Aug 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238812; cv=none; b=RrhvaEVpPc8mbRmBCPLCGFmzzqMyuOKTKszFXJfYErjglyj/ZhpzVXkcJIqe2Qvf/cUDcDIC+/K2dkRLCnmtYMZ5z0zzJxpINT91q27ieIyE5D4C4SPAzCjpZq11l+4J1gBNeJ9cHPKdeGUO1g8qg4GVdFV4naXdYOpRDfV939c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238812; c=relaxed/simple;
	bh=M1qD99cVuowaMMpYyTGgdDNgWN0orzoh16rsQLyUYPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvX6tQBtTsAhSWR29jDXWmqIi6xM+Fw6n64PfZRpm8toebNGDv3oCsPoZs1bScSyaW/gchkbWc+ykYS/fW//OfS7PfFEXZd/7KMDbxE56JriBGZt+lniLiSFtIALtMKhH7mPIzFxdOXYTQVxHEtnMA81iZAyDfwOfmiroEPq9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSlWa+bU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so2097457b3a.0;
        Thu, 14 Aug 2025 23:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238810; x=1755843610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+6CK4pJH6IHQzTvx0Xqq3B1gHNjIgNq+9zUFXP0jZs=;
        b=OSlWa+bUUyO2nkuVHH3SYRxelowPsK/lFGnmeVZ4szzk1y1a2xJa1LibFN7sSqrq9a
         8CeDTnQubMn0N+ZQ1wWYcB2UuAjltj8dkpRinq5PT5zC0JFnrhScYdrzZp5r1GG/OQCp
         E1zP5KNRPyinPiHsKu8SpAUV/Ttms0Rb651au0KlyABR2QPbYlfi7/AjhKUG6XtjgbSi
         Hjh7X62sPP6SvPkxL12UX1vUDh0CDFOBiHEM3KqGJmJgfMAcMKH2PcAJsx8Ui9qLUZxH
         On1Ntx7LGIbDxZUBSbmXYj/DKxpwUkkx53Zmw2Tg55H74ftGsUPy9IMFzba1myZr5MLX
         4Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238810; x=1755843610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+6CK4pJH6IHQzTvx0Xqq3B1gHNjIgNq+9zUFXP0jZs=;
        b=qzcvxkf7ad6mFdA9R+tKE60hf+R6qBI7EJD24mEllW54srCkXruOPBx6rTiS9OuOZm
         f7k3PFZewm/Q0EMnqSFz5vKaEjYeVM2dQORZoAxhd7FQ38y94snzlUzcz+Eq7dJE2sis
         1dl2T9nCdrspFKx0QqVJ8snS1M0ubFKGtMn74dnn02hzVTXHr858xW4cHivb2UnuJPq7
         qkxP7WM55UJ1Yvz1bxXlrRlrQ/qolT5EVwvJBPZpVUzFO/NC0YZr8P6lik/U5YDYdt14
         9VDmNmRP6FXREIyIlfPpAw1nUjGtOnKj0PEwG2EGo4qo1dRaa7zK4stt6FYWLRUhvz6D
         oFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMiTYZTrTQkZQogPDkKLsWDmCuBWWqb3VXcEVZ98UeRZfSDKG4khm2EC+oGl7ytZ3B/cPsJWC4TDtSAAo0SxBy@vger.kernel.org, AJvYcCUmhdqjReUWk9dRpbthykZwZqyOxKFIl3XVwhZYJOmmwjUrFnVTk0JLDsnrO0GJXfNI1WRrTrt4If0VWcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywqzl4Xz+DLSc7+UMuIfpBXaTWg17mU3JBzUwaUSkX0bt8XMpx
	Nfe05ZX0IXeOCW1mqzutNUJA4aa5w2/Hx9Euu2vBISu/Warvbve7VJBm8PG5QIFb
X-Gm-Gg: ASbGncuWQnCKCxS8Wc9FM3ph/pbDJsNHuVJ5fbZ/DoGdBRWWrawly4yVFeAIVhYRygo
	OiB5QFjO+nMgBGHvToRhbJPVeZTm+CGj8WNp5+onkqNrEWzSFyZgEVtcExBVjvoZc3OPLhWx/yD
	DmU89h9NJ6WyDwO7Ze6BuLsMydVoC+ANtS/mwUcUnO7UUyLnf8g3A5AR0S1e3scIIj+jaWTa+md
	4mAgiWIWbBKg6P6bsxX/qmlV14L+5pvagEcSVdyo3e0mMliuuxze4bxGMq/LMi/W9E1LBm6Pfrd
	MgxUz23KwU520yHqQZWj+LrCNwFXLmtY0SW09wt8C9qCbdeJeradwhIp9SQR+8PclO6MzkY8jSb
	Pj4MLnnJSKqbWMojuKuak3KJf43MFFX0cYOLxDJAIYvvY/O62CvYj
X-Google-Smtp-Source: AGHT+IGd53oaXH1+v/3izS/t47bREhjBLJ78OaqnTfsmXgwyTnMuXeYsrqdLr/dvuLoj5aY1mRtcgQ==
X-Received: by 2002:a05:6a20:158a:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-240d2934bbbmr1708057637.11.1755238810353;
        Thu, 14 Aug 2025 23:20:10 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76df62sm425206a12.41.2025.08.14.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:20:09 -0700 (PDT)
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
Subject: [PATCHv3 net 0/3] bonding: fix negotiation flapping in 802.3ad passive mode
Date: Fri, 15 Aug 2025 06:19:57 +0000
Message-ID: <20250815062000.22220-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes unstable LACP negotiation when bonding is configured in
passive mode (`lacp_active=off`).

Previously, the actor would stop sending LACPDUs after initial negotiation
succeeded, leading to the partner timing out and restarting the negotiation
cycle. This resulted in continuous LACP state flapping.

The fix ensures the passive actor starts sending periodic LACPDUs after
receiving the first LACPDU from the partner, in accordance with IEEE
802.1AX-2020 section 6.4.1.

v3:
a) const bond_params for ad_initialize_port (Paolo Abeni)
b) add comment about why we need to sleep in test script (Paolo Abeni)

v2:
a) Split the patch in to 2 parts. One for lacp_active setting.
   One for passive mode negotiation flapping issue. (Nikolay Aleksandrov)
b) Update fixes tags and some comments (Nikolay Aleksandrov)
c) Update selftest to pass on normal kernel (Jakub Kicinski)

Hangbin Liu (3):
  bonding: update LACP activity flag after setting lacp_active
  bonding: send LACPDUs periodically in passive mode after receiving
    partner's LACPDU
  selftests: bonding: add test for passive LACP mode

 drivers/net/bonding/bond_3ad.c                |  67 ++++++++---
 drivers/net/bonding/bond_options.c            |   1 +
 include/net/bond_3ad.h                        |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh  | 105 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   1 +
 6 files changed, 159 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh

-- 
2.50.1


