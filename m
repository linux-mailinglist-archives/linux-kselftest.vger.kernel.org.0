Return-Path: <linux-kselftest+bounces-37973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310CB11883
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05331AE1810
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C45288534;
	Fri, 25 Jul 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRMgsNut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB552882D8;
	Fri, 25 Jul 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424942; cv=none; b=F6vtPg8bCsFUgfS6YxqfcnIlusqDp9H0XUem0u8tdoFd/uz8gB/F3Jzi4FMqtWV8phnLDs6hmZuDloKeBRHGSqvooP75SRrhZR3DiSF2hzYEjy5g1mK0oGDEL/hQ9wI8M2j60JgEhSEa0iAEDVGQpozyuUqT7g64clhdjUc12cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424942; c=relaxed/simple;
	bh=hWoJ1Cb3MWAVkZyfdvMARj2P4IFP6UvTJ/qsKN+HRr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFP+FqADAvhRi35+FwUSsVoCdGOEy407dHgXk21Kzji7RpmIWXIt2pswHM80vH+thRkq36JqKTcvpNLBmIlUdMg6Y7+nNXD4dDXDHPRHHAhBJzCkptQ/B8UmrAEFCzqDAhCo/wRjef/dDt4BG2d3LxyNtHzWY+La5HmRFlGYuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRMgsNut; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7600271f3e9so1580214b3a.0;
        Thu, 24 Jul 2025 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753424940; x=1754029740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lL6i8tXeG4f0zJistqsLTcdxD22zTgA0nGo4IZjHcp8=;
        b=DRMgsNutvrzfb/vFmI4vIL6n9RdhCXPgusScbCFtw1u50Of2GqBw9h7kp/R7RFz68q
         /cIfYJkDQTDWVlGUXswKY/d6nJPF8fknu6D3NCXUXvdvn8HIxQWLMDRbMHz6tG4Z37hU
         NBfF65FgI5SDGSUirsZxlVsUQqObFj7F+XObS5230Cm9lxIo1qBMRD0BSNtZh7VZJBcV
         QfUTxdzPCra4AlBzJEqJN/YdKjVcRqjC0wPo2m0pzu4Sh2GXMPGZpVnEWSo1L8xzNRUh
         m9F3NAb6H7E3/cN8YZTJHdfItBg0lSz5AtY28AUN7+M8Tqxq/RYSHKXqrQog18Ojv3nB
         18Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424940; x=1754029740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL6i8tXeG4f0zJistqsLTcdxD22zTgA0nGo4IZjHcp8=;
        b=ecvgzfBAk48PDdN6/SfMXkiTQP6mCw+xpNZQ8h3iwzHt3gURjhfjZ+NXyoX3eZxqfy
         apLPYxvqYUFSgjf1mDNZX/vApY3keMDLiRFnLDnM88BQ4sPEJUMTG6A41RAnWLpfEuSC
         qzPxbXsYfkt8MOGqo8rshwYIFonIcf6JArTNvkty8mguE777gG5nnEL26WM+mMGbF4r2
         AW4ACtZJvlGmdglrNW4xM9rQwCby+2z1RvQ9q47zy1n1/K//ilfnYSQZFBTqXAYfrpbt
         uu3xsF5+k6T9biq8AaB048EJuCgkCRXO4uoT40dTCVNS1IxAVkgbJJ2wvmP7fav6UIdF
         uZFg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+3zl5H6uf6KLtXvN1tG+QRoI8MP8o5ZNqy84FrwkuMsTPw+rzU7ia0NKSDyiIr163IbR4NKmiks=@vger.kernel.org, AJvYcCUhPJIZU8B2l3uDdwMO2bl/T5AYVz2ydZmzzi8XrBc7tzCWRFyHajbb721BW9uG0m1kfHD32WqRHekoo3H5zCbD@vger.kernel.org, AJvYcCXJPZ+CWtpQx21a8VA5BSPln9f+625W1Gl4QUl3Xmj+Hk6TVmMZ7q0KPW+QfKidvaG73yUWmhY+gZfz1GBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHuHL0vVi0HBQNMg5RNwn+JcNYz4XPXdhtWj0pvHCMCSK0m03
	RE4UPGEvr60TUIMTSi3egy6BsVrwApHa6PY++WGKXIUmPJLBjqidJUpuuHxBHCLY
X-Gm-Gg: ASbGnctsdvk7xAezN8ZFKLOYTpqXSJ7Q2fgtqzcjyQe6wf/JKHTUD93rV9cmTSSL9OY
	j/3PjoPG/Yze6fDSJv5whHc/RjOgL/Jv0wkcbsEFfE3R90ToNjgus2IeDEkS8wyRSjWsCPfReQo
	rx+qR8NO/kgqpqfUeRZuAFwYmm/FZTTsb9WPfeYq2oZmUtuvf4QmYqbOPK/SR8x9m+zbAOjOr3Q
	Qtuy0m/I6PLD+cnS0gf5NJETyfZOqukcyxMO72A8igiYE5H75OgGAXi8iwK/KARxKnQtgnCxLBc
	dDjfi2B7weC0tq7xHmBAzEu/fMqEbYB5TUk/lFg/iLgMQqaeBHNpnbqobDQQ9B2UJ4zAUp9ftRK
	Wm1RGxLN0YY+XcWwmaj++8Dtzp7Um7odGQ8SkeqbwDjpTnms=
X-Google-Smtp-Source: AGHT+IGAUkLGUU7XldjYa1tyK2d1FaF5Xk+jL1aOmKHA9A01tdLyzhwAEeM/IgmulMPfqKq8fqeO9g==
X-Received: by 2002:a05:6a20:158f:b0:23d:3504:38ea with SMTP id adf61e73a8af0-23d5b5ba3bdmr8476567637.8.1753424940012;
        Thu, 24 Jul 2025 23:29:00 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09b532sm2667917a12.25.2025.07.24.23.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:28:59 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] bonding: fix negotiation flapping in 802.3ad passive mode
Date: Fri, 25 Jul 2025 06:28:46 +0000
Message-ID: <20250725062848.18889-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
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

Out of topic:
Although this patch addresses a functional bug and could be considered for
`net`, I'm slightly concerned about potential regressions, as it changes
the current bonding LACP protocol behavior.

It might be safer to merge this through `net-next` first to allow broader
testing. Thoughts?

Hangbin Liu (2):
  bonding: send LACPDUs periodically in passive mode after receiving
    partner's LACPDU
  selftests: bonding: add test for passive LACP mode

 drivers/net/bonding/bond_3ad.c                | 72 ++++++++++----
 drivers/net/bonding/bond_options.c            |  1 +
 include/net/bond_3ad.h                        |  1 +
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh  | 93 +++++++++++++++++++
 5 files changed, 151 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh

-- 
2.46.0


