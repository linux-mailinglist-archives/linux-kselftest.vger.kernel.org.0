Return-Path: <linux-kselftest+bounces-42417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E064BA17F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC11741DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFC321F3A;
	Thu, 25 Sep 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQWOUHcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAB32128E
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835014; cv=none; b=MeyZRelgwRAQGsSsB2cIbIpc7C57MQ0z1EldXzMhmt90DRIQ5xxBnEzqegUF6rZqQx9nLRUc1zzTyQKj6onEDid8+3ABMiOAlnkjV1QW0EvJMW1U8NuEbe6WLWuADz0Tyaf2Mf0P9Sf9yApjZAwr0wWrPNOOiAfj4obwh1+BJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835014; c=relaxed/simple;
	bh=LxyEuMDFzksUQk0fPtNvI9DvJIJfrke26M208NlQR40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzQfX1MXEaHXmydfv/QI0aEWxJkcMJUCjA7uzYKLjXQqrhCBKiaGUqU7ciJb++uatAtg9XvanZn2+Lln0qbFUCleSKOsD8iiFzG/Kp0f5sfkDohtDhMaQHGdR3rMfe/Zhg1CTrnaprCmvGM+vuvZE5TPM3dZsjlBpWyR2Crf2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQWOUHcK; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-72ce9790acdso19085407b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835010; x=1759439810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7bD/cXkR68reqZjZW82I7JAzJyFg2BuDYNUa2xA5SY=;
        b=EQWOUHcKtrxjG8smF2K3XbnCdFoIDJhBcJCqbM6vlVPAdGZcEn4ZO9CXpnE5exaxOp
         ZP8RoV1p3xV2OeCmachQVacbTA/T4AuSlp8S1zJzZW+dK04GJR7bxjxFHPWj6YlMeGPM
         xBw2arrUFGwCptdlB2TcMxJdLtgEzsuny/6U++Ca3RmKVCB1Zeqy7JtTGjyHOPTkdyrA
         M0T4+Slo0lm1uKY0p6p+6N7VogdQG/Giszpni95OPleYbGpgxvpF668Vkky9VJtCZmqA
         Ln5O/oluvaT0KEeV5kKXRMoGM1HT5WwNN2AYrlU3kYDfwbY5EtUIxNwZjfCDDyUSHJ1Q
         QznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835010; x=1759439810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7bD/cXkR68reqZjZW82I7JAzJyFg2BuDYNUa2xA5SY=;
        b=IzTwzOVPjzO0FG/EzPagg92btVFEukfOAQYi7DipCSMxa7/z4b0mrOoL72yab8Xd78
         p2Uvdtl6qAyALXPKeD/KBwvQZhTkMnKmHC3UB/N5wrkglHDndXdJaUiYqQoKCI3CobG6
         JCa8YQ4T9kmLQtXzKwnLOxqis6zfE8FpJmvM9qJFGlM0IIyCf6p0Z+B2nSO4h6F9jd6S
         UPO3mUE32MYjBYT7h5ezjRCWG7fS22h1lUkf48skPtcdZYbPEIXmrfvmckyhRG6KV4xi
         dHOeIiSAfMd8feYyb4TGsmv8DYldt2V3Hy0zTpJc6sEIkQTgtWCrC5crrnfEYzAfys0R
         5hug==
X-Forwarded-Encrypted: i=1; AJvYcCWS4rf2SR6XiXzoDjgYlV4upGMTLZF5I+T3P2dBay+T2cfwVuD0Etegmi0PZzq2f0zFbNhnUITItMVO5CbwVho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjh0rYC1OXerKJKCJ7WDJAi7YAXa3r1Fn0yItagAbc7tYYBtAp
	3tytJJ6r8C8vgDQnp20Wrm9rcb1FXh1Vld2wH/cpOBRcrPc7x9T5f+Z7
X-Gm-Gg: ASbGncupWqPEe7hBYEBfZyf+/hGcOeAr8sWDp33kEU5k/+e+fOTqUd65JgIa0XVlpgg
	YDAMxeFi73gafsfYCD0oKvLlSGBT58YPxZ69rySo2FlOKoIFwlR04gpffMO4TcPE96XYBlHCXHQ
	znbL5tkE9uwkvy8MPkiE0PAFJLYR76huz8YrOqgCXsWoXCxupP/kl8EeM6uRpbTntvt+R5BAs3W
	kCPoeCciUayeJwQ/Z1aku/SdsTAu8EHrHVuDVhApJuBxEc8TOcyjMnoHSD/PJR1t5po5cFSK8KN
	jYhNhZ7a+qbTeJ6nl5tZxRBGymrJZhrVPT3BPAhtczQPr1UzkkpAn4dViSoaMsU80SzYmoZU8of
	hG/HBuSrcDswZAD56/z3WKieldNqpSJ0=
X-Google-Smtp-Source: AGHT+IHs9LwMQpc1IxqLW8fNG8ELaPePPweRQPqLIdBba7WVId//2MjnheRA5Onk4KQ2IIYc2moJ4g==
X-Received: by 2002:a05:690c:e0b:b0:748:3829:eafe with SMTP id 00721157ae682-763fe286a01mr45402587b3.21.1758835009904;
        Thu, 25 Sep 2025 14:16:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bb916ac8sm7479077b3.3.2025.09.25.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:49 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/8] psp: add a kselftest suite and netdevsim implementation
Date: Thu, 25 Sep 2025 14:16:36 -0700
Message-ID: <20250925211647.3450332-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic test suite for drivers that support PSP. Also, add a PSP
implementation in the netdevsim driver.

The netdevsim implementation does encapsulation and decapsulation of
PSP packets, but no crypto.

The tests cover the basic usage of the uapi, and demonstrate key
exchange and connection setup. The tests and netdevsim support IPv4
and IPv6. Here is an example run on a system with a CX7 NIC.

    TAP version 13
    1..28
    ok 1 psp.data_basic_send_v0_ip4
    ok 2 psp.data_basic_send_v0_ip6
    ok 3 psp.data_basic_send_v1_ip4
    ok 4 psp.data_basic_send_v1_ip6
    ok 5 psp.data_basic_send_v2_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
    ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
    ok 7 psp.data_basic_send_v3_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
    ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
    ok 9 psp.data_mss_adjust_ip4
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
    # Totals: pass:22 fail:0 xfail:2 xpass:0 skip:4 error:0
    # 
    # Responder logs (0):
    # STDERR:
    #  Set PSP enable on device 1 to 0x3
    #  Set PSP enable on device 1 to 0x0

CHANGES:
v2:
  - fix pylint warnings
  - insert CONFIG_INET_PSP in alphebetical order
  - use branch to skip all tests
  - fix compilation error when CONFIG_INET_PSP is not set

v1: https://lore.kernel.org/netdev/20250924194959.2845473-1-daniel.zahka@gmail.com/

Jakub Kicinski (8):
  netdevsim: a basic test PSP implementation
  selftests: drv-net: base device access API test
  selftests: drv-net: add PSP responder
  selftests: drv-net: psp: add basic data transfer and key rotation
    tests
  selftests: drv-net: psp: add association tests
  selftests: drv-net: psp: add connection breaking tests
  selftests: drv-net: psp: add test for auto-adjusting TCP MSS
  selftests: drv-net: psp: add tests for destroying devices

 drivers/net/netdevsim/Makefile                |   4 +
 drivers/net/netdevsim/netdev.c                |  55 +-
 drivers/net/netdevsim/netdevsim.h             |  33 +
 drivers/net/netdevsim/psp.c                   | 234 +++++++
 net/core/skbuff.c                             |   1 +
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |  10 +
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |   5 +
 tools/testing/selftests/drivers/net/psp.py    | 593 ++++++++++++++++++
 .../selftests/drivers/net/psp_responder.c     | 483 ++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  10 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 16 files changed, 1432 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/netdevsim/psp.c
 create mode 100755 tools/testing/selftests/drivers/net/psp.py
 create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c

-- 
2.47.3


