Return-Path: <linux-kselftest+bounces-44155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 164DEC121F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0184E261B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9F1EA65;
	Tue, 28 Oct 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3OfTkGF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302EC8CE
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609623; cv=none; b=QTIv9MnDGqKVoX++BIrXdNj8+r8Wf0Oz4og52hXjdFYq53tMInPA4tV6cLvFOOGTH5xYi8TXYgAa0BnIBV4IXvpuBFjaBfcrK5vOuwi0TAAPBJrRewqG90Wz8CBPanDjWIyzxHsUyJCu8ShLaJWGXHh7C2UZOs3pyJc6Vpc2nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609623; c=relaxed/simple;
	bh=44j1NMeztM3eKosxbeA0SuymPVYwCbHD5kCp3dOw4H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+o5wuJYsuX2LWkAc4iC24j2o7trQe9tbYe3ktighUCuC99I4XN/PCUvFWmb4nCHur5p5tGNBfGtrFiUaLRdou8OR3POSW9eLGmtSALyiYDJ8EMHi9XQKx0f5OW25IaoBBeg+J6POby+TGaLFyjlC716IAGOXXI0Y8zKxUlIPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3OfTkGF; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63d8788b18dso5798152d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609620; x=1762214420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jPekmeuStjVGpec/HMLm4gu4TE+ZdPOQZ7xh71HRHU=;
        b=f3OfTkGFr+a3vsvahF5NqWkhzLxXStqnOTYADS+bgza1Gj/rDKIjX+kqOzP75aoOO5
         j9+vqIfgCn3dD1F9OoA/KGTby3fCG3jaCS8P8eO9YzM7Xa1G9chcgJDC94Fg0WWP0m6r
         9LKSfpiicMkjKAxJsJirAxTUKxdBpMJUY/lHP3RNjnqHPPufRdgpaZqmzz/R65sm6Xok
         xBV6Q5DwWzOh5ziugYVTor9xgyMNvQwQB08zf/Xq8gw/3bmhXuCEngoyyixDv0JTUqwX
         qyNIm77LVWc8vBzlOKFG3mvD2wTFH3IJUyZNBpe0Tn79LVAr+OFYNEEFDSKWVN8vhDzm
         mHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609620; x=1762214420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jPekmeuStjVGpec/HMLm4gu4TE+ZdPOQZ7xh71HRHU=;
        b=BhK4/BfhRQo343PgEzf20UH0P8AphKBxUrhOVaQmVVnktIaUhg23C7KijUkt285XUy
         KLppysgIc4BUBG6hWd+2DFnF/GEikr0tPkCIgZSHiC9UNN1s5jYcmDEo6nFy4yDyGAMt
         hLsXaLTT9rAYu6punZV6uBDlhpU/McVRgCHWfIbBUskWq3jTa1KsTwCEfaKzyD1QW9il
         yVvK3N7ljZysLydyuDG7NJdeEPmFS4oKVmPNcbbzkSLf59hnajOM83UG9LPsayeddMCS
         VRBu8A9Ng22MW6blok6K+7WjijfIU8k1YE8qXz/aIkT0mQYPa6aCJwsuYphB6NtwGz78
         It0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVmehqG5B+MMsSmNJSbGRuCi8NiS/ZHXqoriwbSa6GUDJkgH6qRJWE0abEFfAnQFjvY2Gt7OmSuqYqpmK8+Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjfVzIc1q7nIvFE4xZZLHSBmmX0/G8k2vJR4ld+GxCYpJnGy6
	yY9tzhLDeW4bsTazqG8gb8uTNrTLPXkegZxig2IixgY1OcCLAbzhMcgn
X-Gm-Gg: ASbGncsY6x3RGzKXkF3PDJglUT6w26n23O8AUhDAEq46WCHki2o9imUtAg4A9UIoJ1n
	xBUHRhBjuhi0ndfwR0yXItr1hrlLY4+TgG+2jX+cvWgBek9RXOXgGilxclgFvqFGvbB5Yp1ChCD
	ElQoIigk6Cc2ExQRhKVBotxZ2deqXjc9c3mkCC1jpwhtjfTe6AEZVRxD0mV44TiAPQw/o5PKQ1U
	qrrDuANf+QJM8kLeQ8Mq+ItIOwQnH4tDUwtKB3kigTPI9paLXr9BbzE53S4Bna30dnWx044rQS+
	nKwcDPlxTVHpoLF4YVwjiekPdtiTo7bbN9mxr9OKC1dPxNSiiJBTsp+4Xu/jDu/ncrvqscSVRfW
	mGbLvB+ZxAenolrsXlu59/XplXCI+1xt9oqEs6lqq5+8aoDhEdDI1wZbWJsK8hOq+oocbsMsD4F
	Fg/J0m9TlfFNwlnvuStVaC
X-Google-Smtp-Source: AGHT+IHEOU6uhY0872obOeCg7UUipndO0NvC1yiY2mqs83o/mIpworn7pUKCrn5T0+gJY9mnhTcEvQ==
X-Received: by 2002:a05:690e:d86:b0:63e:3420:5654 with SMTP id 956f58d0204a3-63f6b9b2f42mr1844475d50.1.1761609620489;
        Mon, 27 Oct 2025 17:00:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c441fe2sm2724061d50.15.2025.10.27.17.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:19 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/5] psp: track stats from core and provide a driver stats api
Date: Mon, 27 Oct 2025 17:00:11 -0700
Message-ID: <20251028000018.3869664-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces stats counters for psp. Device key rotations,
and so called 'stale-events' are common to all drivers and are tracked
by the core.

A driver facing api is provided for reporting stats required by the
"Implementation Requirements" section of the PSP Architecture
Specification. Drivers must implement these stats.

Lastly, implementations of the driver stats api for mlx5 and netdevsim
are included.

Here is the output of running the psp selftest suite and then
printing out stats with the ynl cli on system with a psp-capable CX7:

  $ ./ksft-psp-stats/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
  ok 7 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
  ok 9 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ok 12 psp.dev_get_device
  ok 13 psp.dev_get_device_bad
  ok 14 psp.dev_rotate
  ok 15 psp.dev_rotate_spi
  ok 16 psp.assoc_basic
  ok 17 psp.assoc_bad_dev
  ok 18 psp.assoc_sk_only_conn
  ok 19 psp.assoc_sk_only_mismatch
  ok 20 psp.assoc_sk_only_mismatch_tx
  ok 21 psp.assoc_sk_only_unconn
  ok 22 psp.assoc_version_mismatch
  ok 23 psp.assoc_twice
  ok 24 psp.data_send_bad_key
  ok 25 psp.data_send_disconnect
  ok 26 psp.data_stale_key
  ok 27 psp.removal_device_rx # XFAIL Test only works on netdevsim
  ok 28 psp.removal_device_bi # XFAIL Test only works on netdevsim
  # Totals: pass:19 fail:0 xfail:2 xpass:0 skip:7 error:0
  #
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 1 to 0x3
  #  Set PSP enable on device 1 to 0x0

  $ cd ynl/
  $ ./pyynl/cli.py  --spec netlink/specs/psp.yaml --dump get-stats
  [{'dev-id': 1,
              'key-rotations': 5,
              'rx-auth-fail': 21,
              'rx-bad': 0,
              'rx-bytes': 11844,
              'rx-error': 0,
              'rx-packets': 94,
              'stale-events': 6,
              'tx-bytes': 1128456,
              'tx-error': 0,
              'tx-packets': 780}]

CHANGES:
v2:
  - don't return skb->len from psp_nl_get_stats_dumpit() on success and
    EMSGSIZE
  - use %pe to print PTR_ERR()
v1: https://lore.kernel.org/netdev/20251022193739.1376320-1-daniel.zahka@gmail.com/

Daniel Zahka (2):
  selftests: drv-net: psp: add assertions on core-tracked psp dev stats
  netdevsim: implement psp device stats

Jakub Kicinski (3):
  psp: report basic stats from the core
  psp: add stats from psp spec to driver facing api
  net/mlx5e: Add PSP stats support for Rx/Tx flows

 Documentation/netlink/specs/psp.yaml          |  95 +++++++
 .../mellanox/mlx5/core/en_accel/psp.c         | 239 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  18 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 drivers/net/netdevsim/netdevsim.h             |   5 +
 drivers/net/netdevsim/psp.c                   |  27 ++
 include/net/psp/types.h                       |  35 +++
 include/uapi/linux/psp.h                      |  18 ++
 net/psp/psp-nl-gen.c                          |  19 ++
 net/psp/psp-nl-gen.h                          |   2 +
 net/psp/psp_main.c                            |   3 +-
 net/psp/psp_nl.c                              |  94 +++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 561 insertions(+), 17 deletions(-)

-- 
2.47.3


