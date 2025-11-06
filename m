Return-Path: <linux-kselftest+bounces-44858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4BC38775
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 01:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C921A23FFB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612021891AB;
	Thu,  6 Nov 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2N2/Con"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978C86353
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388772; cv=none; b=t9zcHMlrbNFKPRh9MYdK3+kJkaPjRZnST0iyFMXK+/bQDUXimVZ8UWsQq4ld6hdODvtKQHEeISuVcFd5H9DnH4SGeDDOgO7TIg0x8SUak5fqx/F9eihSzmkbtFz44k5cm/556Qo867zVSt6Pbt6kOi/zqbtecWbVBEawpxzphTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388772; c=relaxed/simple;
	bh=sQdTyr9ih6RF2YPehPL2Ylkfg6TvbUiN4h5OUPmT3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWwtZU/3jtbhcUWO3RO0mH+D+M0bZUDYReJCnTlIi1xNl9G8B9ddZfr+75TnxXmOIrYkn6Z1/dEly8EIZRkcjV4rst6Ib0zI71aeT3BHvGUFOQoOyS7dHxJu7EeDZ44Doqw3VwOitVWaPF/b/R4FbxSZImiBzAUWa3s0PdZGQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2N2/Con; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78682bab930so5712157b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388769; x=1762993569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTuwJ7NKxX0LIJYOix0ApAXE6uhqIfJ+6m6NHZT3nGM=;
        b=l2N2/Conz/AWKaSRufK7pkjNjymehFxkSS/ZP85OaC7o+CmK2GGVt3d16wwDKfwjOH
         HC3vDt0xbFpYIrsDek46JIKKIlkPG1EUUlI2n6OwnMs299wK6YRT22/g2IYr7X1l4jGW
         ULRiewtPhO8PRNPU1823O46XYy9v5s3G85WRSkV9kduxtxeRqdFH85s9YgCOPrjfWKO0
         bsCt4uJKEs4RBgouVB9yb8Ecu+DuSvosDC9BEwYabTnbtlk0uMH4IfvyEUyL21/3VQ+J
         Ssb+dzj4LoYWHz3w3aV704j51MR3npHkRr5KQFs6xa4j2fkigX7h5/QTuYoqupvHy0+a
         zi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388769; x=1762993569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTuwJ7NKxX0LIJYOix0ApAXE6uhqIfJ+6m6NHZT3nGM=;
        b=dY9xOKN8wApq4VrtLU43ujDjxPVzymf9gfAiJJCTD3brlWhEc/FgKPi4vSxgHxwuwK
         Y980sHcE7VGbDQ5LZUlsapMQo3RVAVFJWp0GX44IePY0ccKn9ChjaIxmXmNCins/CBC6
         aR15tv7WJEyT4TNEm+G9YqNZLM5aW+5e3L10qEpOV+inCE/QaPzErtNOAfx17fwyCQP3
         mgqegGcOSzN5T1nisFVSBSD88V+Zn3HMKlVxys242bzFRbkvRQI5PDk2e2iQV7cnrOYp
         LAiAMR0xZZ1Q8AHW4ZwBaghdvMKQXQ/VDmOa7yTZgfDyyF7N1As+hFYtZAX6PWJChUAw
         vZUA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWhdC1qBzgsiWcyLjDv5d+gahVR1kuztrl/7pEGGtGkL6qWMOF/EEriXFI0rZvPSDhO+ReXKZNzdRi6x9PZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIz+zkKjHcvjEQ9mxbdG3wPY85rXfzD9Ou9DcHU+4yIgad+anX
	xB9X7dwHhwkPkNNWvCP40rJpjuEqbKQXbLyGZakz5znebRkUUFmnT6AK
X-Gm-Gg: ASbGnct2qP6GB7wmWdhhIv/fKG0WoI4AnTF0uXhT0KWGZf0HGJoDQoTXdfsk/gRuVTx
	2lqWk3v5c3zSBngZT33AvlPtHeOoEqHs0agIN7DOZWaC+j0/Eu7Qw76DUUnz76CANQPtqRZCeYg
	jVgJXJSTHxhAiqSHB8cJYDIRq8VWrrBcag1CpvDMDeLlmvtOJosQ1C6tDLMdGuQc5V1sBM7hs/3
	Za/7RqUfThCbW7XmKFDAGlzoQwThRI8oIFaL0BUF76L34Nrzb7skBGKKaLXX3Zj/UY66zPeMQLI
	PtLgLHo4HsLkl+40/dl9r3t7oLjTTsshgexRKcL8RC/uI+01FXiXfIw7s87aLzP21nxouXgFMR7
	4tANnDGXNHh0BoDxU5l0YXK8feI4beqDrFFwubWOb/kqIyqh+lN8vl+ZLMiNN3Ov9wir4F7ZW0H
	Xwp4v+XfJz
X-Google-Smtp-Source: AGHT+IHwPpyD9rXstOAxRuHWvFVIkK6uDGF7BLbIb0kUr+fXh1ZNwp1JjPufwwulH4G7kf37cBrXcw==
X-Received: by 2002:a05:690e:42db:b0:63f:c019:23b2 with SMTP id 956f58d0204a3-640b54aa11emr823736d50.28.1762388769400;
        Wed, 05 Nov 2025 16:26:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d9533csm286607d50.22.2025.11.05.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:08 -0800 (PST)
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
Subject: [PATCH net-next v3 0/5] psp: track stats from core and provide a driver stats api
Date: Wed,  5 Nov 2025 16:26:01 -0800
Message-ID: <20251106002608.1578518-1-daniel.zahka@gmail.com>
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
v3:
  - simplify error path in accel_psp_fs_init_tx()
  - avoid casting argument in mlx5e_accel_psp_fs_get_stats_fill()
  - delete unused member stats member in mlx5e_psp
  - remove zero length array from psp_dev_stats
v2: https://lore.kernel.org/netdev/20251028000018.3869664-1-daniel.zahka@gmail.com/
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
 .../mellanox/mlx5/core/en_accel/psp.c         | 233 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  16 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 drivers/net/netdevsim/netdevsim.h             |   5 +
 drivers/net/netdevsim/psp.c                   |  27 ++
 include/net/psp/types.h                       |  32 +++
 include/uapi/linux/psp.h                      |  18 ++
 net/psp/psp-nl-gen.c                          |  19 ++
 net/psp/psp-nl-gen.h                          |   2 +
 net/psp/psp_main.c                            |   3 +-
 net/psp/psp_nl.c                              |  93 +++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 549 insertions(+), 17 deletions(-)

-- 
2.47.3


