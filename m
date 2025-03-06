Return-Path: <linux-kselftest+bounces-28365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97792A540BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 03:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8BB16911E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 02:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF218DF89;
	Thu,  6 Mar 2025 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiTTTlh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02D18DB38;
	Thu,  6 Mar 2025 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228776; cv=none; b=gnv10ECS+pMq6fsqNmUsARU9ts0N0RlT4IgL2TY2lD/tTWPNvOG8eagBMig6USl4awecOn9SQHQCkIrX0/K2xYCl9iMKTePKBQsianqa9P0dS9eW3NzDwUjFNUsVQNKxjjY7vWjbHW/B/N5/EjTfjHZfPRpOGcpEGR05kB84QnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228776; c=relaxed/simple;
	bh=izkSU+2I/i3y1RMGm3vgWWed7818Z00qPu4c1xHZnt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJQyELT+Xl2UcDhM3BTldFibPcntX2sJHrZdSKPlFlryMVn87mgb7dRQap15sFY1Xwd1SzjnW65n7igmoWdQts2tm16ZwT9VrMgL+P3uNfV2FF+XTPW9f9Kb1beU3VOQoV0FazRQp1urHBne8GR5rjwzl9WxI4XO4JZwi0VyEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiTTTlh1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so420917a91.1;
        Wed, 05 Mar 2025 18:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741228774; x=1741833574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9YtQFh54VZ+sDgTueTYQUzdZ15kBhlQ6E4/cM8LARg=;
        b=AiTTTlh1AmA6BAVkR/sVmuUNgjQvDnPnggip3raGHN/lCJ7wpyuLI6H9SfB/AhwQbP
         G1Ab+/Ly8xuh/11VwH8W6F7XLvVfk83Mwi/Yx2p8wQ/XdHOG2t1T6LF3LJU7V/V+/T8m
         HdClFXwtvtjmj/4zp3i2gCnAfO9D0VTUK9pvOfPLX2thcHN+jd5LEfxg7AQynVRtG45f
         tKEL1kF5thiwZY2vjZACAoNr+lE4zTsfxLzvr3y0rSv9iTOAKTbGlMUCQvUA2KHYVAXr
         QNmEK1swcQeStubfPT1XCMM8JffaK9sSpMM3dMlmkx1ReWcSXDAFVPbGvQZDdrHBsk8p
         SghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228774; x=1741833574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9YtQFh54VZ+sDgTueTYQUzdZ15kBhlQ6E4/cM8LARg=;
        b=vzLr+CGvYOzuVbNhnWRRbS4LNJXCpYP6Vtmm/4W/hhJA+QsQXk0NwMrNeH8QBThga3
         w/hRzdfsnvtEIQe0Ay1s+yxAtkABJ1Gl+MzbeilKtopZ21vpTa3x7r4kOgPlvxO5pZSS
         Rzemc9mgrE/7TmDB5FnAojYJ080Qd0Vc9r80g0Gbt4NQajQbC0/v67907cJ7kHOA6dqc
         uFnKTSM3OJww3uY/Le1oLn+XykDh1IIpDY8oyngDfRixemJJdCMIoLQDxsoH32jLW5WI
         YHSmxm0K1z/9h0ALvSwbI51UhbuKkzaJR9lgC6zBYNo5FA8CqDt4mWKC1eoLWwwyAhSO
         ZGLA==
X-Forwarded-Encrypted: i=1; AJvYcCWLklCQh6YNfZmxTz9b2WxpnhGLrR1adQDGUZ87ProVosSINlhUhG/sMwPzqXXq5x/7i/mou+SWvIT3TlalVDCT@vger.kernel.org, AJvYcCWNN1ncbS2O9HDmoNCXaKg+6lob7d5E5tgE+dDu948y3Jksu3MDj/H0QE001Si8wQqeB5u0VgdXRLeK6yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PfQttsdeSsn+4wuyhgHqDfLQHAcBJWCgJ5Wm+WjaDxWjkRNL
	p3/XiGBZFGFjfHBrN511BEv5IUc9oRlm3TFhGFU+mo1sv3ykSIUJaPhGNZz6fe0cyw==
X-Gm-Gg: ASbGncu4OdZczu1rzgFHTgPreCXkMmJQPSTNN/FZN8aRhV+xJu0JiFwLBFoeZZ/wsyK
	T1QzG9c3dnBtlQCCsNAx13IN/61dtHNuzwtX/ihZXhFdsNdrk5PbYxO81aqyCPwImTQtUHK6DsA
	7eiK9uUdWZIv9JMqWZ/2XFDBOy5TsNw7Ute3DeXER6oTnKkc3VT7fgFTi3CyT/gOWvQ4SuNbozo
	SrLmr39aRlbt07Cg9iUv4ne6KsLWhX/eCng3RoOBdNXUgv2Z3xBTmI48SAnVU4PUnDDpYVaoFb3
	zZGhzRnRuS4yFlBLGT2vb1rTlDv53IqtkeLnW4VsGZsWRm8qAZN5wUkkyAyN8y0H
X-Google-Smtp-Source: AGHT+IG8L248/PaH7DhWwyRJpS1KNBJiVoXfmsiaSih64T9LgP8z8A0hYDZdD1QRCpr6HUpoXs4wAA==
X-Received: by 2002:a17:90b:4c06:b0:2ff:6ac2:c5a5 with SMTP id 98e67ed59e1d1-2ff6ac2c754mr270444a91.26.1741228774215;
        Wed, 05 Mar 2025 18:39:34 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm1292185ad.243.2025.03.05.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:39:33 -0800 (PST)
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
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 0/2] bonding: fix incorrect mac address setting
Date: Thu,  6 Mar 2025 02:39:21 +0000
Message-ID: <20250306023923.38777-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mac address on backup slave should be convert from Solicited-Node
Multicast address, not from bonding unicast target address.

v4: no change, just repost.
v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
    Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
v2: fix patch 01's subject

Hangbin Liu (2):
  bonding: fix incorrect MAC address setting to receive NS messages
  selftests: bonding: fix incorrect mac address

 drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
 .../drivers/net/bonding/bond_options.sh       |  4 +-
 2 files changed, 49 insertions(+), 10 deletions(-)

-- 
2.46.0


