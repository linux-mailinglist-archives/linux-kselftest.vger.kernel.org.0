Return-Path: <linux-kselftest+bounces-43793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2039DBFE0FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18EB44F8574
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985E34B1B7;
	Wed, 22 Oct 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFDjxYtT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FE2E92B4
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161864; cv=none; b=kQm0331HgnsSHT9lSqCGJDW+9gbWiMhGcw6ByCO3Pfqcbpyc0Ez6NSYcy/vi0KqCcqEj1TFvqv3lx4uVXoqAt3K0/Pb7MN+nBCSymvGMyTxH9RT8Z/RDMWcUysXjucoWoJJ9J4a2otmbTBeNsUMUaDNkqoWP4NH73MWTZthQ/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161864; c=relaxed/simple;
	bh=8MRW3yqAKMYQuQUed72t6yP7Ve4PLYvFlWdPE0tfFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZSOMvIErtEtCv4hxz7h6LMliJjmaHhIBHItysPhRQYsC02YVMB0X6OHOPvha3RXxxGF+8DHok/vAkOs7H2FEH2nYQySHqTd3llzyIUDAxxeMho73V9InM66BRiwHt42WRLvvSAHxyAgEaUrK1gyCNVzF5FfpyBS2YVfTdvSagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFDjxYtT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcac45so78705257b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161860; x=1761766660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOYCBxEypI+05Fd3SHO/clagx6FGtRLSoRwJEgGRcG0=;
        b=RFDjxYtTN41aLoyLO7yoe6rTLKP4VuhY1oelqIR4VxuY+RaY6OW8/CxRBVRQZWuw75
         hPk78Vc13jAEfRgd0+xDTVMTM+B7pvwp2nHLr+Sh8ptwkDqtX1OemUoXNB1pgxCHGTC3
         21NkSLGFQ2wB1D5qiGWo+HttVqvj3FtzlZlKY5yD3A+DazsoKiuATrqcWDoJbRVRM5Vo
         qtmKPbH9MpK9WcUhxSfDnq4FIv9xZ9lKj1jR5QI2GB3LPafS8AzSsRbkv6H4d5WFca/z
         qZB1J684ju9HCve8bJhfVkF/FZJlj5j+AuREs2nTkfh/KOdiZT2bp+RKmLaUVPJcxGgD
         mVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161860; x=1761766660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOYCBxEypI+05Fd3SHO/clagx6FGtRLSoRwJEgGRcG0=;
        b=ezHotcmF6fKV8mEBvQDDbsA5a1cMPVMycXsuUCEXzu/HiNOHs5pE3o3j0kbDepaaXx
         vGLi8fi7mDq7N2TwavpJ99rE0HPSGlNdgTglgpLr06vR/BAipQ7j85ESXhbA7cfgxIve
         okhZeqPTuCnPsDoCCXK9zYqTgV98nrsjN/lWTagOujOcT8lrBKLT0IFZ9OjjpZNzizdM
         +GI1uaSABFO+VDgl564TFuhqCGvjUH9SWFiaVy+4UhnSJShEjJnqymTg29p6s8Jg4jYF
         wfJUzMPEMDwrNBzw/7ldrs3qYpp7gC8sHr9V7W3MFiA/aBvIaFO8+WtyIvYRE2XWygZg
         vM+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbYPYwkfzagkbOUCwl2oM91iVFlOOcr6pZA+4+mnD70WtWa1fQbT3aVXedoandNQ87Dy7zGCIfrGuCGWkP300=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtB9lWLaQNwGvZQ6LLwxj1ADZuivKefYt0kJANc7q6zUX11rd
	+kW3Pa2f4j8Xx23HvsKI4W35+KlfCPcVZAuXS6PfNFkIuMiwrxbt8GTo
X-Gm-Gg: ASbGncvOL9gGY6Kuyrobsj72eyE3PNhhOzfqyKdtVfq87J1zMAyX/pYgvK9lduOobBV
	4tVEHHIEwIdJ1xB8KFdM2YHTpV+pvg/7npu+0e6RpriIc53kFFoMlvV9IYPvuJeqN9h0iQoBs5c
	OqpbegqEoirDT5TXl1dN7sOVjwsw7ylOfE5t2rxgSHdkbj0FVvVr3EVBrQLRksJ0HfhiYzNGSz1
	6lnn+PJ91eKrTYcv6MdwiAE7Q1FIixfWHDJs9cgWLnO2jeUr912F/b6ZHJ39V9AhYpgVOaygAus
	mGUU1H5JvQUNI/toA6CEGW1lFfGbECpJnq8/fmxPQzHVQpL3IcNiFrvf2/ZKmJwd/Gaoc8OxvTy
	hofg/U2YxGSYLYfOifodnTwLblZkPVJ8spwU8kXb+XJixAivtGfgDPcVpMseFN9WCPUxTCHfBe/
	xqEirPnBiq
X-Google-Smtp-Source: AGHT+IHaZkspjhYREdwfy6s1DSoZj2lZnE2ffrgRfmqH8s1EmjVlOY1M8Rp5dvU/yDbSsJG4m+8/WA==
X-Received: by 2002:a05:690c:288:b0:784:857a:46be with SMTP id 00721157ae682-784857a5917mr123672537b3.18.1761161859943;
        Wed, 22 Oct 2025 12:37:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd607f60sm354947b3.27.2025.10.22.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:39 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/5] psp: track stats from core and provide a driver stats api
Date: Wed, 22 Oct 2025 12:37:32 -0700
Message-ID: <20251022193739.1376320-1-daniel.zahka@gmail.com>
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
 net/psp/psp_nl.c                              |  99 ++++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 566 insertions(+), 17 deletions(-)

-- 
2.47.3


