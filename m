Return-Path: <linux-kselftest+bounces-39218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A95B29DA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8071771B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7730DD2B;
	Mon, 18 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8FWk3V5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF482D7D42;
	Mon, 18 Aug 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509005; cv=none; b=paqz3LiYeVlWSme8mVCGW4BEZRL34gWOcOHKo9Mxam301mekcE1LRNtRhXKZIXiGl2pDzmfxAA5yuMX6Qj3264j9eqDkYFlPr1hwrlgSTxAIqdupPPgzfmkg7e0v7T9Ah8sTgxn6fBtwarJoINZz10uv6kp7Dc1yn3Wm9P0ucXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509005; c=relaxed/simple;
	bh=GTJsdloMm1slL0ugKJLhrrNq7KdUoq4hUGaAdOXWx2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6fz3TD7r3hk6yNXsKU1JR0oT4OIK0b33vWgi9Y6NGfvI4v0nEGp3zXy/g2ucjWOkx5h03hk94IHMDNzOc7r/Ie2OohSp9hlnGQeAlObU5DBUHTdbdvTl4E9hm1PwRm/ydKj2VEiosERaM/Aw4w8tpvUe5SJ4h4bgaA8PorvvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8FWk3V5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1512232b3a.2;
        Mon, 18 Aug 2025 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509003; x=1756113803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqi/7q5CUaFa0VX1JEGp/3xAMYM2zA1F4e32bwx3x1Q=;
        b=e8FWk3V5QSZK2/6UV9gdsMdmkgI31TA2hBgC1NVD1JDm8CgAt7OW7svGTtpXNbTxQp
         2pvc4QxrdKoPl9qyivVdEQByPKf5Zjin1TKwM6wCFg8lDLzYiTxKUxpU7jzSZuznUJX2
         bdISxO8k7fPLFeJ4uTxsmgMERIjtynNZBt2KeSG0ONazegC90WYxpb57ml7QOcv3q4RE
         JHC7P9M1v5nPIOET3XTeBSVFHrIrxABtzUQqhyQVbDcHDuJyUKFshfNRemvPpJj0N5o7
         lpPPugkXjVhc01k+Z/4q7WyEK5LAF5lEePAUauqj1gX5wNCFNd9wLLb0lkEsYqNSgnCa
         hiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509003; x=1756113803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqi/7q5CUaFa0VX1JEGp/3xAMYM2zA1F4e32bwx3x1Q=;
        b=R/dircUw4iPXnIPjPoAiTSIsP0/DtkGWo5HGAlVNyYTP+pjSNHWcRv4qHG+2P5qJfk
         KQlp+xp1VDd23mjAIAXSmWsSGXj3k7DCTgqy7ikCXb50nS8eMW1fAmemKS31789356U5
         MzPqgWJX6jB2Tj5EeL43gsPKdyv3VOsbb06QHyY3gqnVau5Hn0pK4Xg8qP2D2fJBrjEg
         9vBTTyZ6E6c092P6szNvl0f6p2VqI9Ghm52gq0BF1mftvmS9SThjsLmUEYyXxL0bNNLw
         VNAFAT+BxzzUANIOQFgfT2eDZNGCdyv99jT660MrTHQWLysYvPaellaXgANYADHI62hO
         UWrg==
X-Forwarded-Encrypted: i=1; AJvYcCUcKShErw54eEo+f9ZmfUMj2FONDgoRd++D4z2NUN0LBfsLomuHxqX53Tow2CaRfkzm9rcfAOMx2lCfrLQfn5FA@vger.kernel.org, AJvYcCXxGuEGIoxu+SqvdAXW2tEcKH3kIIwZ3HFfMXzLcI9OqDmuNOnBu0GNb0CCcppmlcWTOSOTdbk5jrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0YfyzQ7/9V5oTu2QIYk8xWt8s0b0xlhcK/KRzZMOjiV41UdQ
	hj6r/QoZvv0T5BV5H2O4HmkqsJS3KuAuggxOdYYf5ZSlwjyHg5qWT3bKrNSqveOC+2E=
X-Gm-Gg: ASbGnct+V7zsbQLNTV2EDPuAynLyd9zMo+FuVt6KoPoBgQSqSI//BhQykFskksUrPxG
	kuh6cmi7NOl58/e39cMlYUv6r/DGVOxSgX7WXf3HMJgCgybvthw0Hj/eivKETM23G+ugOy5+oqx
	YmCLdzZlsoJbMbMvrfnJvwcqpt1MCpmZ/qIMgrQL6UzApkrgoyv34Gefy+b3VqKrS7KaOOHsHPy
	CP9lZnKR3cygkNbkT1WcZ61B5ONCayxOVWBR2/YOUoxF1o4R/01C0Xqc8Is8eFStyYTgdx2RAuv
	UYHdVQ66VxuG7j3zD4Vq/BHdu1QtULnTBwIS0RUG8lMRg6vYF0avMBkuYP6Uqdc48AQF3bvfcS9
	6r9H62pcZwHVvYcXnabaLx2WMR2f+4nnrIBhmZyYVjnUlfx+Q3kAK
X-Google-Smtp-Source: AGHT+IFwWi3hdv7B80mzCFhPktE/NRKZt7D2uT48w603YVhfsUCPwkeuy3sDAXB9QP5F8jXVeuJTaA==
X-Received: by 2002:a05:6a00:1913:b0:76b:fab4:6456 with SMTP id d2e1a72fcca58-76e44858f2cmr15383702b3a.21.1755509003359;
        Mon, 18 Aug 2025 02:23:23 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45592eeesm6604976b3a.104.2025.08.18.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:23:22 -0700 (PDT)
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
Subject: [PATCHv3 net-next 0/3] bonding: support aggregator selection based on port priority
Date: Mon, 18 Aug 2025 09:23:08 +0000
Message-ID: <20250818092311.383181-1-liuhangbin@gmail.com>
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

 Documentation/networking/bonding.rst          | 18 +++-
 drivers/net/bonding/bond_3ad.c                | 31 +++++++
 drivers/net/bonding/bond_netlink.c            | 16 ++++
 drivers/net/bonding/bond_options.c            | 37 ++++++++
 include/net/bond_3ad.h                        |  2 +
 include/net/bond_options.h                    |  1 +
 include/uapi/linux/if_link.h                  |  1 +
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 93 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 -----
 tools/testing/selftests/net/lib.sh            | 24 +++++
 11 files changed, 224 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

-- 
2.50.1


