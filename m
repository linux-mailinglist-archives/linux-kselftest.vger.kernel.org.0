Return-Path: <linux-kselftest+bounces-39820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF68B336A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 08:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1194189655A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3828643A;
	Mon, 25 Aug 2025 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZWoMPQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855C2853E3;
	Mon, 25 Aug 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104331; cv=none; b=NcVGMe5reNlY7Km3yEC9BnpnG/uyxUCF+HCoGcwiJjbV6mHgVYvcsaubUo2lgTtPmrdIcQ4u9UXGYtTtGFE5zxpcHWxykFr5OM5oAHLRXwp5Pbq11d9CE8A7tS/Gld2/PL2a9HPuJ0AbCtX4+F1pApdMa7ou5xu5eWMyvTPD0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104331; c=relaxed/simple;
	bh=lgm48j0LxiZ+Pf2OUoeceaz2ddw3IU9NJDwxFCYD6PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy9Bd5SF/HpzUwmvjGpR3oUWCXryaoMBB302Y3mf/lkClTlhC+mH9Zma+WC5AK9xsj/va8PlIn7an4Pjy8mrmBKjowhNUccYJrBWql/bxF3XqeVOvCuF5WP23upixnJDGKrks1Gzr6gx8xBOue762+8ZcrmG7jCZV4gFBI0OiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZWoMPQA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3253f0c8788so2631605a91.0;
        Sun, 24 Aug 2025 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104328; x=1756709128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjft4ixMpvbnl2BVYpJ9X+b+BY8k2BxI3Ck3omoW+Ss=;
        b=EZWoMPQApxcrmZFWA91SKFbxVs7UofXjbxeHL41WdcW7Z5q4imH+61OnGh0IWOegux
         aNg3+9sHbpL1NsnCffRljpeFlZjIwToihTbZUEikMAdGI5lIsHwDel1Dau46GpUTBidb
         d/f6ssUWecmuHekQsK2sECoD0qxrFo8o23FwpX14e4RuHL9PijNt3Wg6zXO/yWc4YFUQ
         VWdm1jCKAoFuKPk/6GVYtxvAdW3gEICel/vuc6JxmrlB2gBBHqT2WZFlGYeLZgZ3E+ww
         IA94qu5V5Y60Kq0QmBYxigSkcOqCxtnPT7dPzQJ61tC94qRVtAMFlPS0DtGUBjMCs7H5
         iMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104328; x=1756709128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjft4ixMpvbnl2BVYpJ9X+b+BY8k2BxI3Ck3omoW+Ss=;
        b=cNHky2tRHNePp7iD+bieXnRzP5ahnVZr1UlrfjCT4bnFM0NKSHxhEaEE63udCrPw2j
         +JK56Rs5DHEYkWPCr9i+y3fdEJjxPsMgDZcdQRD5twJXJqFgEq5nYCRnVJbQIavj4AsK
         UY3xs9slib0J5/UcZ2S1Py3csbQKlfTRCZpHWfaTCnBu+vPIt0WUacBvuCPCXcdTJlKa
         rVGFaoHVnOzQWv1GMEvdGBfc/JWPhShGPIfXTdP457B1PF2ck9hIhWR3LNR18VgfNB+z
         MLIYtMH1gFCEonAX3X1nETcz3NhOF+hU/AS7daFD+ex+e+PZYg1epT2eeEh+rgxMU6TA
         JyBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJiJFAqPw9IO2K9wyW2kZKUY3/PXBdxvefi137q64D4SUGLMY/zHkCP6S/k1GTFIN361+C5rtbaZtArgA5tbZ9@vger.kernel.org, AJvYcCW1cX4B/lwKuq7MFEPtrJfrk9AHxtlRqzS5HctscRO024LZQtSUcgmBmEzKvc2nPNvOofViLzq0bNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2x/bbyQLEFGHRGtZK2KUV3CEx4O8Ko6zKguBkDZaVGQl1hBEm
	6lN07g3teVqqXOsEvu7C+XIeEQDl2EIj0F5AHaqvuJN1hQ0G94BI36rO69OnkD1p
X-Gm-Gg: ASbGncvALd4LrNXib0UttpKFX6RmYm0xxthiU31QMdAhdP7VHSt05dFM0rC2FmZjobQ
	d642pF1f0TTe2XCp7RcNATsoRoSYHXtpJYUJVI1lUnYWEQQ7VJNEA/FNzo1nIh3XkTOmiMHqLP8
	KWqtUfuBfswg1WEqyCt2HGxhnr/PPCRoD/wmhxo9/PlBHVwgbLp/M2qbMqb1PDbGDf3MyWDbHmR
	1JPK7xG05Xrl1Bq71BXGmAt27y+UCJBPX3kweh9rwZiu960eIL5xBQaVnm6d/6YqVjsUEopnPyz
	COIbUi8thmM9zuKuXNMS67Ilh+nQs2ofym4i2nuJ0/UsAJgpB49YOmITyuaZmYGP0OxBSGCXkqQ
	GcmCaq+EMfOrpsilICA3Q+FwYDMfLQbuODnIU6XJSZQ==
X-Google-Smtp-Source: AGHT+IHnBWjQ5YlWQ94EJw8g46D8w3QGcYrWyJWKy+NFbrbpxf0yYLAf16LNP4Jk9zktX9SYTTUaPw==
X-Received: by 2002:a17:90b:2f8b:b0:321:ab54:14fd with SMTP id 98e67ed59e1d1-32515d26c36mr16051744a91.0.1756104327548;
        Sun, 24 Aug 2025 23:45:27 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm5978118a91.18.2025.08.24.23.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:45:26 -0700 (PDT)
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
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/3] bonding: support aggregator selection based on port priority
Date: Mon, 25 Aug 2025 06:45:13 +0000
Message-ID: <20250825064516.421275-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new per-port bonding option: `ad_actor_port_prio`.

It allows users to configure the actor's port priority, which can then be used
by the bonding driver for aggregator selection based on port priority.

This provides finer control over LACP aggregator choice, especially in setups
with multiple eligible aggregators over 2 switches.

v4:
a) fix actor_port_prio minimal value (Jay Vosburgh)
b) fix ad_agg_selection_test comment order (Paolo Abeni)
c) restruct selftest, reduce duplication (Paolo Abeni)

v3:
a) add comments when init slave port_priority (Jonas Gorski)
b) rename ad_lacp_port_prio to lacp_port_prio (Jay Vosburgh)

v2:
a) set default bond option value for port priority (Nikolay Aleksandrov)
b) fix __agg_ports_priority coding style (Nikolay Aleksandrov)
c) fix shellcheck warns

Hangbin Liu (3):
  bonding: add support for per-port LACP actor priority
  bonding: support aggregator selection based on port priority
  selftests: bonding: add test for LACP actor port priority

 Documentation/networking/bonding.rst          |  18 ++-
 drivers/net/bonding/bond_3ad.c                |  31 +++++
 drivers/net/bonding/bond_netlink.c            |  16 +++
 drivers/net/bonding/bond_options.c            |  37 ++++++
 include/net/bond_3ad.h                        |   2 +
 include/net/bond_options.h                    |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 107 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  24 ----
 tools/testing/selftests/net/lib.sh            |  24 ++++
 11 files changed, 238 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

-- 
2.50.1


