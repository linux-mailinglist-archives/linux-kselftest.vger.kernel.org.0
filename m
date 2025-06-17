Return-Path: <linux-kselftest+bounces-35176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2EADC2B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A314216CF35
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18E28C2A9;
	Tue, 17 Jun 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsaMczWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C082BEFF3;
	Tue, 17 Jun 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143589; cv=none; b=PSxEo0Da7WXBCtaIfAIhi9E4jyXtET/Jz97Xk5h8mBbHURUJwqWsUNweTZdTV0QalmmRSPN4REEL5fiD8UFa7RZfmlc7b3q5MmtMb0ZYcuQ+htCboydmQ9hz8xHNuW4MvHZOhV+RV/MGOJTitkzUV1vN2GK9Iag9uwX7s2fbHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143589; c=relaxed/simple;
	bh=03H/0sq759lP+5cfHeBeprRU0vCgtmziyql6vnKZd/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UehCf30Ad8KS2TGhYf1KcVnX8oa2h8+y/wZoiCMRytAE9Rzmor8b1fqGNu33V5jrfMO8O8Jhj6t8V5AW8IY4sFKHOwScmlITmHJb0VXdvW9hLoQVPrUhfEfuB16I7SKZIJTCBAUZxlNR0NZr9mCA/Lx/GD8T6C+WqcRPGywd9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsaMczWq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so829177466b.2;
        Mon, 16 Jun 2025 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750143584; x=1750748384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7R/l7a8nrZvpNx9hahrUwx11UGuESikXWszl5XPvVU=;
        b=hsaMczWq3abqbAqK4VkZgdrWrfB2zMa98lCsdwn+kjsIEsA9ea48Oyz39o9xs/oQRi
         Z5PhW8KTnpQ6DQyMa+hZZHnN3SsoyFgKAAWgHV17TiV8h4UdvXpDyEsfggnYTngdyZLk
         gxRLVyAOjB0s/CEL21TF2EMbvRygk2hgGbpCBaR8LrPrlbZTWIkvqIP0qLo+eEkWC7IV
         GvA6gr2ySmMKY0NfzaUe9VJYBpuutO6nvJz9hgsUTamKGFDTSmNHl8M7yGS3KOP8bhl4
         pbtfkYWHimWIhP5P8Ix90qLdzQpW1x1Z+xlgm4cU50m0FjCEs+VRyt+CyvDg93VYtTTf
         xFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750143584; x=1750748384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7R/l7a8nrZvpNx9hahrUwx11UGuESikXWszl5XPvVU=;
        b=YLcI5D8uT+4t1GSEEKXrhLekgEUT2SGhyUGfQ9gUhYBP1bzANGl9XFhiJQa6uXJND1
         qA76MRF+zWhXP/D7LpB3KoJDVUFF8gaaROnzpr+e6DPuV1F0Z4eLOSj8k3KmLSEzh4Cs
         WoPzUbww0wnDL/lC4LiuEZZXvXBO6F6Qt3M9TsKGAsAtyLfMlTL0g/kDPzXGHOne7i6v
         tAOoq2MJSPAXUW81vx9hTDbShWXwBxpujbCFfVLVJhzA+u5vIhtFRLR2cbHgJ8DnO09v
         QfRTqkKKI2tbDKh8FD+n7rljBToBNzu6QYJfjaY7rA6BGNwXqtLMuhKHnbRtOvV8nmOe
         wSkg==
X-Forwarded-Encrypted: i=1; AJvYcCV402PqZW+tlC/V0ctuykZI6Y5EOWWIisi7m0D1HueMqlpzKa38v7sqLDfiFpNSYFuY+7MZgC7G@vger.kernel.org, AJvYcCWrZZY1XUW3gbr04sr4aen3KuXoztg4T6USb/e8E3zttv5zvUsEC0uF48Zl0bqGtEGzZg50hSzvt4CXJQ4BqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJq/PIaX8clJI9wsT8QtnGDhnFQ6yYqKnKmq3+k6WxXKBEHgg
	Nc6jBqLGn/WevoXL9eVJoQNTcIpZBDmmnvmX2FHrhxWsnt0mbzwQ3uao
X-Gm-Gg: ASbGncs8BZNlb77gQnnCEPrYBc/OoRQbe55jDgaWDSH4d6X1CAwjlRi+RzZZdnf3k+v
	nv2P4BOBi6W+vZ1eJ01qlAjszFcxMPf8RFH5X/hNTibicLOAwYIyKdYWbpqoQG1BlNLOR7TFgin
	tu0Vn5lldPkoaEh+6qwVzyanMPQtw2m28/9knpkclyRqL+zM152OgzpdnKyv6ONKRsB6cbH4Lt7
	g5oyW7ehdSNxcCowX3mn8VXmz+jhMxXIHFWvc6VYDYF6efjrwk3a/FeQkwKOW2G1/XZ9iOomGrD
	a03EZK09goR7L1S7kVllNp0EtCw0eXLwRU6Gq9oyK8fXhSpCUW10NgIgujTZc450nsolCArIL1N
	d0ThMgTF1VaqQk+kxjIltbWHQj940IOBzH7kvYxXL0JagGp1PFIOzsibWKSI3O0B8W6HpSqM1Qd
	caErCm
X-Google-Smtp-Source: AGHT+IFeHnJ5gmnoyg6s1ztvQtYeOPF87eZmyG8AjZAxgPpTsBsBWGB7pC6CcoJAVVkdI898HFPF/w==
X-Received: by 2002:a17:907:2d24:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-adfad328591mr1220787066b.18.1750143583361;
        Mon, 16 Jun 2025 23:59:43 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff203sm803313166b.75.2025.06.16.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:59:42 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [RFC PATCH v2 nf-next] selftests: netfilter: Add bridge_fastpath.sh
Date: Tue, 17 Jun 2025 08:59:30 +0200
Message-ID: <20250617065930.23647-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script to test various scenarios where a bridge is involved
in the fastpath. It runs tests in the forward path, and also in
a bridged path.

The setup is similar to a basic home router with multiple lan ports.

It uses 3 pairs of veth-devices. Each or all pairs can be
replaced by a pair of real interfaces, interconnected by wire.
This is necessary to test the behavior when dealing with
dsa ports, foreign (dsa) ports and switchdev userports that support
SWITCHDEV_OBJ_ID_PORT_VLAN.

See the head of the script for a detailed description.

Run without arguments to perform all tests on veth-devices.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This test script is written first for the proposed bridge-fastpath
patch-sets, but it's use is more general and can easily be expanded.

Changes in v2:

- Moved test-series to functions
- Moved code to set_pair_link() up/down
- Added conntrack zone to bridged traffic
- Test bridge chain prerouting in test without fastpath
   and bridge chain forward in tests with fastpath

Some example outputs of this last version of patches from different
hardware, without and with patches:

ALL VETH:
=========

./bridge_fastpath.sh -t
Setup:
            CLIENT 0
              veth0cl
                |
              veth0rt
               WAN
              ROUTER
          LAN1      LAN2
       veth1rt      veth2rt
           |          |
       veth1cl      veth2cl
      CLIENT 1      CLIENT 2

Without patches:

PASS:  unaware bridge, without encaps,            without fastpath
PASS:  unaware bridge, with single vlan encap,    without fastpath
ERROR: unaware bridge, with double q vlan encaps, without fastpath: ipv4/6: established bytes 0 < 4194304
ERROR: unaware bridge, with 802.1ad vlan encaps,  without fastpath: ipv4/6: established bytes 0 < 4194304
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
ERROR: forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4/6: tcp broken
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
ERROR: bridge fastpath test has failed

With patches:

PASS:  unaware bridge, without encaps,            without fastpath
PASS:  unaware bridge, without encaps,            with fastpath
PASS:  unaware bridge, with single vlan encap,    without fastpath
PASS:  unaware bridge, with single vlan encap,    with fastpath
PASS:  unaware bridge, with double q vlan encaps, without fastpath
PASS:  unaware bridge, with double q vlan encaps, with fastpath
PASS:  unaware bridge, with 802.1ad vlan encaps,  without fastpath
PASS:  unaware bridge, with 802.1ad vlan encaps,  with fastpath
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   without/without vlan encap, with fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/without vlan encap,    with fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   with/with vlan encap,       with fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  aware bridge,   without/with vlan encap,    with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
PASS:  all tests passed

BANANAPI-R3 (lan1 & lan2 are dsa):
============

Without patches:

./bridge_fastpath.sh -t -0 enu1u2,lan2 -1 enu1u1,lan1 -2 lan4,eth1
Setup:
            CLIENT 0
              enu1u2
                |
              lan2
               WAN
              ROUTER
          LAN1      LAN2
          lan1      eth1
           |          |
        enu1u1      lan4
      CLIENT 1      CLIENT 2

PASS:  unaware bridge, without encaps,            without fastpath
PASS:  unaware bridge, with single vlan encap,    without fastpath
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
ERROR: forward,        without vlan-device, without vlan encap, client1, with fastpath: ipv4: counted bytes 2118540 > 2097152
ERROR: forward,        without vlan-device, without vlan encap, client1, with fastpath: ipv6: counted bytes 2117904 > 2097152
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
ERROR: forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4/6: tcp broken
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
ERROR: forward,        without vlan-device, with vlan encap,    client2, with fastpath: ipv4/6: tcp broken
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with hw_fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with hw_fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with hw_fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, without fastpath
ERROR: forward,        with vlan-device,    without vlan encap, client2, with fastpath: ipv4: counted bytes 2109596 > 2097152
ERROR: forward,        with vlan-device,    without vlan encap, client2, with fastpath: ipv6: counted bytes 2121432 > 2097152
ERROR: bridge fastpath test has failed

With patches:

PASS:  unaware bridge, without encaps,            without fastpath
PASS:  unaware bridge, without encaps,            with fastpath
PASS:  unaware bridge, without encaps,            with hw_fastpath
PASS:  unaware bridge, with single vlan encap,    without fastpath
PASS:  unaware bridge, with single vlan encap,    with fastpath
PASS:  unaware bridge, with single vlan encap,    with hw_fastpath
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   without/without vlan encap, with fastpath
PASS:  aware bridge,   without/without vlan encap, with hw_fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/without vlan encap,    with fastpath
PASS:  aware bridge,   with/without vlan encap,    with hw_fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   with/with vlan encap,       with fastpath
PASS:  aware bridge,   with/with vlan encap,       with hw_fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  aware bridge,   without/with vlan encap,    with fastpath
PASS:  aware bridge,   without/with vlan encap,    with hw_fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with hw_fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, with hw_fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with hw_fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with hw_fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with hw_fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, with hw_fastpath
PASS:  all tests passed

AM3359 (end1 supports SWITCHDEV_OBJ_ID_PORT_VLAN, ipv4 only for now):
=======
./bridge_fastpath.sh -t -a -4 -d -1 enu1u4c2,end1

Without patches:

Setup:
            CLIENT 0
              veth0cl
                |
              veth0rt
               WAN
              ROUTER
          LAN1      LAN2
          end1      veth2rt
           |          |
      enu1u4c2      veth2cl
      CLIENT 1      CLIENT 2

INFO: Skipping unaware bridge
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
ERROR: forward,        without vlan-device, without vlan encap, client1, with fastpath: ipv4: counted bytes 2190092 > 2097152
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
ERROR: forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4: tcp broken
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
ERROR: forward,        without vlan-device, with vlan encap,    client2, with fastpath: ipv4: tcp broken
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, with fastpath
ERROR: bridge fastpath test has failed

With patches:

INFO: Skipping unaware bridge
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   without/without vlan encap, with fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/without vlan encap,    with fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   with/with vlan encap,       with fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  aware bridge,   without/with vlan encap,    with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device,    with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, without fastpath
PASS:  forward,        with vlan-device,    without vlan encap, client2, with fastpath
PASS:  all tests passed

(Some problem still to figure out for my AM3359 hardware: On the second run
 of the command the tcp traffic is ok on all tests ipv4. On the first run
 the hardware is not setup correctly, some tests report broken tcp even
 without fastpath. Also ipv6 tcp broken even on second run even without
 fastpath. This may be a problem with my hardware or the test-script,
 but anyway it shows the fastpath is functional)

 .../testing/selftests/net/netfilter/Makefile  |    1 +
 .../net/netfilter/bridge_fastpath.sh          | 1008 +++++++++++++++++
 2 files changed, 1009 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_fastpath.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index 3bdcbbdba925..50afe91bc3e2 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -8,6 +8,7 @@ MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
 TEST_PROGS := br_netfilter.sh bridge_brouter.sh
 TEST_PROGS += br_netfilter_queue.sh
+TEST_PROGS += bridge_fastpath.sh
 TEST_PROGS += conntrack_dump_flush.sh
 TEST_PROGS += conntrack_icmp_related.sh
 TEST_PROGS += conntrack_ipip_mtu.sh
diff --git a/tools/testing/selftests/net/netfilter/bridge_fastpath.sh b/tools/testing/selftests/net/netfilter/bridge_fastpath.sh
new file mode 100755
index 000000000000..82f2ddc946b8
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/bridge_fastpath.sh
@@ -0,0 +1,1008 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if conntrack, nft chain and fastpath is functional in setups
+# where a bridge is in the fastpath.
+#
+# Commandline options make it possible to use real ethernet pairs
+# instead of veth-device pairs. Any, or all, pairs can be tested using
+# real hardware pairs. This is can be useful to test dsa-ports,
+# switchdev (dsa) foreign ports and switchdev ports supporting
+# SWITCHDEV_OBJ_ID_PORT_VLAN.
+#
+# First tcp is tested. Conntrack and nft chain are tested using a counter.
+# When there is a fastpath possible between the interfaces then the
+# fastpath is also tested.
+# When there is a hardware offloaded fastpath possible between the
+# interfaces then the hardware offloaded path is also tested.
+#
+# Setup is as a typical router:
+#
+#           nsclientwan
+#               |
+#              nsrt
+#              |  |
+#      nsclient1  nsclient2
+#
+# Masquerading for ipv4 only.
+#
+# First check if a bridge table forward chain can be setup, skip
+# these tests if this is not possible.
+# Then check if a inet table forward chain can be setup, skip
+# these tests if this is not possible.
+#
+# Different setups of paths are tested that involve a bridge in the
+# fastpath. This can be in the forward-fastpath or in the bridge-fastpath.
+#
+# The first series, in the bridge-fastpath, using a vlan-unaware bridge.
+# Traffic with the following vlan-tags is checked:
+#  a. without vlan
+#  b. single vlan
+#  c. double q vlan  (only on veth-devices)
+#  d. 802.1ad vlan   (only on veth-devices)
+#  e. pppoe       (when available)
+#  f. pppoe-in-q  (when available)
+#
+# (for items c to f fastpath can only work when a conntrack zone is set)
+# (double tag testing results in broken tcp traffic on most hardware,
+#  in this test setup, use '-a' argument to test it anyway)
+# (pppoe testing takes place if pppd and pppoe-server are installed)
+#
+# The second series, in the bridge-fastpath, using a vlan-aware bridge.
+# Here we test all combinations of ingress/egress with or without single
+# vlan encaps.
+#
+# The third series, in the forward-fastpath, using a vlan-aware bridge,
+# without a vlan-device linked to the master port. We test the same combinations
+# of ingress/egress with or without single vlan encaps.
+#
+# The fourth series, in the forward-fastpath, using a vlan-aware bridge,
+# with a vlan-device linked to the master port. We test the same combinations
+# of ingress/egress with or without single vlan encaps.
+#
+# Note 1: Using dsa userports on both sides of eth-pairs client1 or client2
+# gives erratic and unpredictable results. Use, for example, an usb-eth device
+# on the client side to test a dsa-userport.
+#
+# Note 2: Testing the hardware offloaded fastpath, it is not checked if the
+# packets do not follow the software fastpath instead. A universal way to
+# check this should be added at some point.
+#
+# Note 3: Some interfaces to test on the router side, are netns immutable.
+# Use the -d or --defaultnsrouter option so that the interfaces of the router
+# do not have to change netns. The router is build up in the default netns.
+#
+
+source lib.sh
+
+checktool "nft --version" "run test without nft"
+checktool "socat -h" "run test without socat"
+checktool "bridge -V" "run test without bridge"
+
+NR_OF_TESTS=4
+VID1=100
+VID2=101
+BRWAN=brwan
+BRLAN=brlan
+BRCL=brcl
+LINKUP_TIMEOUT=10
+PING_TIMEOUT=10
+SOCAT_TIMEOUT=10
+filesize=2 # MiB
+
+filein=$(mktemp)
+file1out=$(mktemp)
+file2out=$(mktemp)
+pppoeserveroptions=$(mktemp)
+pppoeserverpid=$(mktemp)
+
+setup_ns nsclientwan nsclientlan1 nsclientlan2
+
+       WAN=0      ; LAN1=1          ; LAN2=2        ; ADWAN=3     ; ADLAN=4
+nsa=( $nsclientwan  $nsclientlan1    $nsclientlan2 ) # $nsrt         $nsrt
+AD4=( '192.168.1.1' '192.168.2.101'  '192.168.2.102' '192.168.1.2' '192.168.2.1' )
+AD6=( 'dead:1::1'   'dead:2::101'    'dead:2::102'   'dead:1::2'   'dead:2::1'   )
+
+tests_string=$(seq 1 $NR_OF_TESTS)
+
+while [ "${1:-}" != '' ]; do
+	case "$1" in
+	'-0' | '--pairwan')
+		shift
+		vethcl[$WAN]="${1%,*}"
+		vethrt[$WAN]="${1#*,}"
+		;;
+	'-1' | '--pairlan1')
+		shift
+		vethcl[$LAN1]="${1%,*}"
+		vethrt[$LAN1]="${1#*,}"
+		;;
+	'-2' | '--pairlan2')
+		shift
+		vethcl[$LAN2]="${1%,*}"
+		vethrt[$LAN2]="${1#*,}"
+		;;
+	'-s' | '--filesize')
+		shift
+		filesize=$1
+		;;
+	'-p' | '--parts')
+		shift
+		tests_string=$1
+		;;
+	'-4' | '--ipv4')
+		do_ipv4=1
+		;;
+	'-6' | '--ipv6')
+		do_ipv6=1
+		;;
+	'-n' | '--noskip')
+		noskip=1
+		;;
+	'-d' | '--defaultnsrouter')
+		defaultnsrouter=1
+		;;
+	'-f' | '--fixmac')
+		fixmac=1
+		;;
+	'-t' | '--showtree')
+		showtree=1
+		;;
+	*)
+		cat <<-EOF
+		Usage: $(basename $0) [OPTION]...
+		  -0 --pairwan  eth0cl,eth0rt  pair of real interfaces to use on wan side
+		  -1 --pairlan1 eth1cl,eth1rt  pair of real interfaces to use on lan1 side
+		  -2 --pairlan2 eth2cl,eth2rt  pair of real interfaces to use on lan2 side
+		  -s --filesize                filesize to use for testing
+		  -p --parts                   partnumbers of tests to run, comma separated
+		  -4|-6 --ipv4|--ipv6          test ipv4/6 only
+		  -d --defaultnsrouter         router in default network namespace, caution!
+		  -f --fixmac                  change mac address when conflict found
+		  -n --noskip                  also perform the normally skipped tests
+		  -t --showtree                show the tree of used interfaces
+		EOF
+		exit $ksft_skip
+		;;
+	esac
+	shift
+done
+
+for i in ${tests_string//','/' '}; do
+	tests[$i]="yes"
+done
+
+if [ -n "$defaultnsrouter" ]; then
+	nsrt="nsrt-$(mktemp -u XXXXXX)"
+	touch /var/run/netns/$nsrt
+	mount --bind /proc/1/ns/net /var/run/netns/$nsrt
+else
+	setup_ns nsrt
+fi
+nsa+=($nsrt $nsrt)
+
+cleanup() {
+	if [ -n "$defaultnsrouter" ]; then
+		umount /var/run/netns/$nsrt
+		rm -f /var/run/netns/$nsrt
+	fi
+	cleanup_all_ns
+	rm -f "$filein" "$file1out" "$file2out" "$pppoeserveroptions" "$pppoeserverpid"
+}
+
+trap cleanup EXIT
+
+head -c $(($filesize * 1024 * 1024)) < /dev/urandom > "$filein"
+
+check_mac()
+{
+	local ns=$1
+	local dev=$2
+	local othermacs=$3
+	local mac
+
+	mac=$(ip -net "$ns" -br link show dev "$dev" | \
+		grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
+
+	if [[ ! "$othermacs" =~ "$mac" ]]; then
+		echo $mac
+		return 0
+	fi
+	echo "WARN: Conflicting mac address $dev $mac" 1>&2
+
+	[ -z "$fixmac" ] && return 1
+
+	for (( j = 0 ; j < 10 ; j++ )); do
+		mac="${mac::6}$(printf %02x:%02x:%02x:%02x $(($RANDOM%256)) \
+		         $(($RANDOM%256)) $(($RANDOM%256)) $(($RANDOM%256)))"
+		[[ "$othermacs" =~ "$mac" ]] && continue
+		echo $mac
+		ip -net "$ns" link set dev "$dev" address "$mac" 1>&2
+		return $?
+	done
+	return 1
+}
+
+is_linkup()
+{
+	local ns=$1
+	local dev=$2
+
+	if [ -n "$(ip -net "$ns" link show dev "$dev" up 2>/dev/null | \
+	         grep 'state UP')" ]; then
+		return 0
+	fi
+	return 1
+}
+
+set_pair_link()
+{
+	local arg=$1
+	local all="${@:2}"
+	local lret=0
+	local i j
+
+	for i in $WAN $LAN1 $LAN2; do
+		ns="${nsa[$i]}"
+		ip -net "$ns" link set "${vethcl[$i]}" $arg
+		lret=$(($lret | $?))
+		ip -net "$nsrt" link set "${vethrt[$i]}" $arg
+		lret=$(($lret | $?))
+	done
+	[ $lret -ne 0 ] && return 1
+
+	[[ "$arg" != "up" ]] && return 0
+
+	for j in $(seq 1 $(($LINKUP_TIMEOUT * 5 ))); do
+		lret=0
+		for i in $all; do
+			ns="${nsa[$i]}"
+			is_linkup $ns "${vethcl[$i]}"
+			lret=$(($lret | $?))
+			is_linkup $nsrt "${vethrt[$i]}"
+			lret=$(($lret | $?))
+		done
+		[ $lret -eq 0 ] && break
+		sleep 0.2
+	done
+	return $lret
+}
+
+wait_ping()
+{
+	local i1=$1
+	local i2=$2
+	local ns1=${nsa[$i1]}
+	local j
+
+	for j in $(seq 1 $(($PING_TIMEOUT * 5 ))); do
+		ip netns exec "$ns1" ping -c 1 -w $PING_TIMEOUT -i 0.2 \
+			-q "${AD4[$i2]}" >/dev/null 2>&1
+		[ $? -le 1 ] && return $?
+		sleep 0.2
+	done
+	return 1
+}
+
+add_addr()
+{
+	local i=$1
+	local dev=$2
+	local ns=${nsa[$i]}
+	local ad4=${AD4[$i]}
+	local ad6=${AD6[$i]}
+
+	ip -net "$ns" addr add "${ad4}/24" dev "$dev"
+	ip -net "$ns" addr add "${ad6}/64" dev "$dev" nodad
+	if [[ "$ns" == "nsclientlan"* ]]; then
+		ip -net "$ns" route add default via "${AD4[$ADLAN]}"
+		ip -net "$ns" route add default via "${AD6[$ADLAN]}"
+	elif [[ "$ns" == "nsclientwan"* ]]; then
+		ip -net "$ns" route add default via "${AD6[$ADWAN]}"
+	fi
+
+}
+
+del_addr()
+{
+	local i=$1
+	local dev=$2
+	local ns=${nsa[$i]}
+	local ad4=${AD4[$i]}
+	local ad6=${AD6[$i]}
+
+	if [[ "$ns" == "nsclientlan"* ]]; then
+		ip -net "$ns" route del default via "${AD6[$ADLAN]}"
+		ip -net "$ns" route del default via "${AD4[$ADLAN]}"
+	elif [[ "$ns" == "nsclientwan"* ]]; then
+		ip -net "$ns" route del default via "${AD6[$ADWAN]}"
+	fi
+	ip -net "$ns" addr del "${ad6}/64" dev "$dev" nodad
+	ip -net "$ns" addr del "${ad4}/24" dev "$dev"
+}
+
+set_client()
+{
+	local i=$1
+	local vlan=$2
+	local arg=$3
+	local ns=${nsa[$i]}
+	local vdev="${vethcl[$i]}"
+	local brdev="$BRCL"
+	local proto=""
+	local pvidslave=""
+
+	unset_client $i
+
+	if [[ "$vlan" == "qq" ]]; then
+		ip -net "$ns" link add link "$vdev" name "$vdev.$VID1" type vlan id $VID1
+		ip -net "$ns" link add link "$vdev.$VID1" name "$vdev.$VID1.$VID2" \
+			                                       type vlan id $VID2
+		ip -net "$ns" link set "$vdev.$VID1" up
+		ip -net "$ns" link set "$vdev.$VID1.$VID2" up
+		add_addr $i "$vdev.$VID1.$VID2"
+		return
+	fi
+
+	[[ "$vlan" == "none" ]] && pvidslave="pvid untagged"
+	[[ "$vlan" == "ad" ]] && proto="vlan_protocol 802.1ad"
+
+	ip -net "$ns" link add "$brdev" type bridge vlan_filtering 1 vlan_default_pvid 0 $proto
+	ip -net "$ns" link set "$vdev" master "$brdev"
+	ip -net "$ns" link set "$brdev" up
+
+	bridge -net "$ns" vlan add dev "$brdev" vid $VID1 pvid untagged self
+	bridge -net "$ns" vlan add dev "$vdev" vid $VID1 $pvidslave
+
+	if [[ "$vlan" == "ad" ]]; then
+		ip -net "$ns" link add link "$brdev" name "$brdev.$VID2" type vlan id $VID2
+		brdev="$brdev.$VID2"
+		ip -net "$ns" link set "$brdev" up
+	fi
+
+	if [[ "$arg" != "noaddress" ]]; then
+		add_addr $i "$brdev"
+	fi
+}
+
+unset_client()
+{
+	local i=$1
+	local ns=${nsa[$i]}
+	local vdev="${vethcl[$i]}"
+	local brdev="$BRCL"
+
+	ip -net "$ns" link del "$brdev" type bridge 2>/dev/null
+	ip -net "$ns" link del "$vdev.$VID1" 2>/dev/null
+}
+
+add_pppoe()
+{
+	local i1=$1
+	local i2=$2
+	local dev1=$3
+	local dev2=$4
+	local desc=$5
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+
+	ppp1=0
+	while [ -n "$(ip -net "$ns1" link show ppp$ppp1 2>/dev/null)" ]
+	do ((ppp1++)); done
+	echo "noauth defaultroute noipdefault unit $ppp1" >"$pppoeserveroptions"
+	ppp1="ppp$ppp1"
+
+	if ! ip netns exec "$ns1" pppoe-server -k -L "${AD4[$i1]}" -R "${AD4[$i2]}" \
+		-I $dev1 -X "$pppoeserverpid" -O "$pppoeserveroptions" >/dev/null; then
+		echo "ERROR: $desc: failed to setup pppoe server" 1>&2
+		return 1
+	fi
+
+	if ! ip netns exec "$ns2" pppd plugin pppoe.so nic-$dev2 persist holdoff 0 noauth \
+		defaultroute noipdefault noaccomp nodeflate noproxyarp nopcomp \
+		novj novjccomp linkname "selftest-$$" >/dev/null; then
+		echo "ERROR: $desc: failed to setup pppoe client" 1>&2
+		return 1
+	fi
+
+	if ! wait_ping $i1 $i2; then
+		echo "ERROR: $desc: failed to setup functional pppoe connection" 1>&2
+		return 1
+	fi
+
+	ppp2=$(cat "/run/pppd/ppp-selftest-$$.pid" | tail -n 1)
+
+	ip -net "$ns1" addr add "${AD6[$i1]}/64" dev "$ppp1" nodad
+	ip -net "$ns2" addr add "${AD6[$i2]}/64" dev "$ppp2" nodad
+
+	return 0
+}
+
+del_pppoe()
+{
+	local i1=$1
+	local i2=$2
+	local dev1=$3
+	local dev2=$4
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+
+	[[ -n "$ppp1" ]] && ip -net "$ns1" addr del "${AD6[$i1]}/64" dev "$ppp1"
+	[[ -n "$ppp2" ]] && ip -net "$ns2" addr del "${AD6[$i2]}/64" dev "$ppp2"
+
+	kill -9 $(cat "/run/pppd/ppp-selftest-$$.pid" | head -n 1) \
+		$(cat "$pppoeserverpid" | head -n 1)
+}
+
+listener_ready()
+{
+	local ns=$1
+	local ipv=$2
+
+	ss -N "$ns" --ipv$ipv -lnt -o "sport = :8080" | grep -q 8080
+}
+
+test_tcp() {
+	local i1=$1
+	local i2=$2
+	local dofast=$3
+	local desc=$4
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+	local i=-1
+	local lret=0
+	local ads=""
+	local ipv ad a lpid bytes limit error
+
+	if    [ -n "$do_ipv4" ]; then ads="${AD4[$i2]}"
+	elif  [ -n "$do_ipv6" ]; then ads="${AD6[$i2]}"
+	else  ads="${AD4[$i2]} ${AD6[$i2]}"
+	fi
+	for ad in $ads; do
+		((i++))
+		if [[ "$ad" =~ ":" ]]
+		then ipv="6"; a="[${ad}]"
+		else ipv="4"; a="${ad}"
+		fi
+
+		rm -f "$file1out" "$file2out"
+
+		# ip netns exec "$nsrt" nft reset counters >/dev/null
+		# But on some systems this results in 4GB values in packet and byte count, so:
+		(echo "flush ruleset"; ip netns exec "$nsrt" nft --stateless list ruleset) | \
+			ip netns exec "$nsrt" nft -f -
+
+		timeout "$SOCAT_TIMEOUT" ip netns exec "$ns2" socat TCP$ipv-LISTEN:8080,reuseaddr \
+					STDIO <"$filein" >"$file2out" 2>/dev/null &
+		lpid=$!
+		busywait 1000 listener_ready "$ns2" "$ipv"
+
+		timeout "$SOCAT_TIMEOUT" ip netns exec "$ns1" socat TCP$ipv:$a:8080 \
+					STDIO <"$filein" >"$file1out" 2>/dev/null
+		wait $lpid
+
+		if [ $? -ne 0 ]; then
+			error[$i]="ipv$ipv: tcp broken"
+			continue
+		fi
+		if ! cmp "$filein" "$file1out" >/dev/null 2>&1; then
+			error[$i]="ipv$ipv: file mismatch to ${ad}"
+			continue
+		fi
+		if ! cmp "$filein" "$file2out" >/dev/null 2>&1; then
+			error[$i]="ipv$ipv: file mismatch from ${ad}"
+			continue
+		fi
+
+		limit=$((2 * $filesize * 1024 * 1024))
+		bytes=$(ip netns exec "$nsrt" nft list counter $family filter "check" | \
+				grep "packets" | cut -d' ' -f4)
+		if [ -z "$dofast" ] && [ "$bytes" -lt "$limit" ]; then
+
+			error[$i]="ipv$ipv: established bytes $bytes < $limit"
+			continue
+		fi
+		if [ -n "$dofast" ] && [ "$bytes" -gt "$((limit/2))" ]; then
+			# Significant reduction of bytes expected
+			error[$i]="ipv$ipv: counted bytes $bytes > $((limit/2))"
+			continue
+		fi
+	done
+
+	if [ -n "${error[0]}" ]; then
+		if [[ "${error[0]#*:}" == "${error[1]#*:}" ]]; then
+			echo "ERROR: $desc: ipv4/6:${error[0]#*:}" 1>&2
+			return 1
+		fi
+		echo "ERROR: $desc: ${error[0]}" 1>&2
+		lret=1
+	fi
+	if [ -n "${error[1]}" ]; then
+		echo "ERROR: $desc: ${error[1]}" 1>&2
+		lret=1
+	fi
+	if [ $lret -eq 0 ]; then
+		echo "PASS:  $desc"
+	fi
+	return $lret
+}
+
+test_paths() {
+	local i1=$1
+	local i2=$2
+	local desc=$3
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+
+
+	if ! setup_nftables $i1 $i2; then
+		echo "ERROR: $desc: cannot setup nftables" 1>&2
+		return 1
+	fi
+	if ! test_tcp $i1 $i2 "" "$desc without fastpath"; then
+		return 1
+	fi
+
+	if ! setup_fastpath $i1 $i2 "" 2>/dev/null; then
+		return 0
+	fi
+	if ! test_tcp $i1 $i2 "fast" "$desc with fastpath"; then
+		return 1
+	fi
+
+	if ! setup_fastpath $i1 $i2 "hw" 2>/dev/null; then
+		return 0
+	fi
+	if ! test_tcp $i1 $i2 "fast" "$desc with hw_fastpath"; then
+		return 1
+	fi
+
+	return 0
+
+}
+
+add_masq()
+{
+	if [[ $family != "bridge" ]]; then
+		ip netns exec "$nsrt" nft -f - <<-EOF
+		table ip nat {
+		    chain postrouting {
+		        type nat hook postrouting priority 0;
+		        oifname ${BRWAN} masquerade
+		    }
+		}
+		EOF
+	else
+		return 0
+	fi
+}
+
+add_zone()
+{
+	local devs=$1
+
+	if [[ $family == "bridge" ]]; then
+		ip netns exec "$nsrt" nft -f - <<-EOF
+		table ${family} filter {
+		    chain preroutingzones {
+		        type filter hook prerouting priority -300;
+		        iif ${devs} ct zone set 23
+		    }
+		}
+		EOF
+	fi
+}
+
+setup_nftables()
+{
+	local devs="{ ${vethrt[$1]} , ${vethrt[$2]} }"
+	local i1=$1
+	local i2=$2
+
+	ip netns exec "$nsrt" nft flush ruleset
+
+	if ! add_masq; then
+		return 1
+	fi
+
+	add_zone "${devs}" 2>/dev/null
+
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    chain prerouting {
+	        type filter hook prerouting priority 0; policy accept;
+	        ct state established ip  saddr ${AD4[$i1]} tcp dport 8080 counter name "check"
+	        ct state established ip  saddr ${AD4[$i2]} tcp sport 8080 counter name "check"
+	        ct state established ip6 saddr ${AD6[$i1]} tcp dport 8080 counter name "check"
+	        ct state established ip6 saddr ${AD6[$i2]} tcp sport 8080 counter name "check"
+	    }
+	}
+	EOF
+}
+
+setup_fastpath()
+{
+	local devs="{ ${vethrt[$1]} , ${vethrt[$2]} }"
+	local arg=$3
+	local flags=""
+
+	[[ "$arg" == "hw" ]] && flags="flags offload"
+
+	ip netns exec "$nsrt" nft flush ruleset
+
+	if ! add_masq; then
+		return 1
+	fi
+
+	add_zone "${devs}" 2>/dev/null
+
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    flowtable f {
+	        hook ingress priority filter
+	        devices = ${devs}
+	        ${flags}
+	    }
+	    chain forward {
+	        type filter hook forward priority 0; policy accept;
+	        counter name "check"
+	        ct state established flow add @f
+	    }
+	}
+	EOF
+}
+
+test_1_unaware_bridge()
+{
+	local lret=0
+	local i
+
+	for i in $LAN1 $LAN2; do
+		set_client $i none
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, without encaps,           "
+	lret=$(($lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client $i q
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with single vlan encap,   "
+	lret=$(($lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client $i qq
+	done
+
+	# Skip testing double tagged packets on real hardware
+	if [ -n "$lan_all_veth" ] || [ -n "$noskip" ]; then
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with double q vlan encaps,"
+	lret=$(($lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client $i ad
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with 802.1ad vlan encaps, "
+	lret=$(($lret | $?))
+
+	fi
+	# End Skip testing double tagged packets
+
+	if [ -n "$(command -v pppd 2>/dev/null)" ] &&
+	   [ -n "$(command -v pppoe-server 2>/dev/null)" ]; then
+	# Start pppoe
+
+	for i in $LAN1 $LAN2; do
+		set_client $i none noaddress
+	done
+
+	if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe encap"; then
+		test_paths $LAN1 $LAN2 "unaware bridge, with pppoe encap,         "
+		lret=$(($lret | $?))
+	fi
+
+	del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+
+	for i in $LAN1 $LAN2; do
+		set_client $i q noaddress
+	done
+
+	if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe-in-q encaps"; then
+		test_paths $LAN1 $LAN2 "unaware bridge, with pppoe-in-q encaps,   "
+		lret=$(($lret | $?))
+	fi
+
+	del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+
+	# End pppoe
+	fi
+
+	for i in $LAN1 $LAN2; do
+		unset_client $i
+	done
+	return $lret
+}
+
+test_2_aware_bridge()
+{
+	local lret=0
+	local i
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+		set_client $i none
+	done
+	test_paths $LAN1 $LAN2 "aware bridge,   without/without vlan encap,"
+	lret=$(($lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client $i q
+
+	test_paths $LAN1 $LAN2 "aware bridge,   with/without vlan encap,   "
+	lret=$(($lret | $?))
+
+	i=$LAN2
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client $i q
+
+	test_paths $LAN1 $LAN2 "aware bridge,   with/with vlan encap,      "
+	lret=$(($lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	set_client $i none
+
+	test_paths $LAN1 $LAN2 "aware bridge,   without/with vlan encap,   "
+	lret=$(($lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	unset_client $i
+	i=$LAN2
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+	unset_client $i
+
+	return $lret
+}
+
+test_3_forward_without_vlandev()
+{
+	local wo=$1
+	local lret=0
+	local i
+
+	[[ "$wo" == "" ]] && wo="without"
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+		set_client $i none
+	done
+
+	test_paths $LAN1 $WAN "forward,        $wo vlan-device, without vlan encap, client1,"
+	lret=$(($lret | $?))
+	if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+	test_paths $LAN2 $WAN "forward,        $wo vlan-device, without vlan encap, client2,"
+	lret=$(($lret | $?))
+	fi
+
+	for i in $LAN1 $LAN2; do
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client $i q
+	done
+
+	test_paths $LAN1 $WAN "forward,        $wo vlan-device, with vlan encap,    client1,"
+	lret=$(($lret | $?))
+	if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+	test_paths $LAN2 $WAN "forward,        $wo vlan-device, with vlan encap,    client2,"
+	lret=$(($lret | $?))
+	fi
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+		unset_client $i
+	done
+	return $lret
+}
+
+test_4_forward_with_vlandev()
+{
+	test_3_forward_without_vlandev "with"
+	return $?
+}
+
+test_5_bond()
+{
+	local lret=0
+	local i
+
+	for i in $LAN1; do
+		unset_client $i
+	done
+	return $lret
+}
+
+ret=0
+### Start Initial Setup ###
+
+for i in 4 6; do
+	ip netns exec "$nsrt" sysctl -q net.ipv$i.conf.all.forwarding=1
+done
+
+### Use brwan to make sure software fastpath is ###
+###         direct xmit in other direction also ###
+
+ip -net "$nsrt" link add $BRWAN type bridge
+ret=$(($ret | $?))
+ip -net "$nsrt" link set $BRWAN up
+ret=$(($ret | $?))
+if [ $ret -ne 0 ]; then
+	echo "SKIP: Can't create bridge"
+	exit $ksft_skip
+fi
+
+# If both lan clients are veth-devices, only test 1 in the forward path
+if [ -z "${vethcl[$LAN1]}" ] && [ -z "${vethcl[$LAN2]}" ]; then
+	lan_all_veth=1
+fi
+
+for i in $WAN $LAN1 $LAN2; do
+	ns="${nsa[$i]}"
+	if [ -z "${vethcl[$i]}" ]; then
+		vethcl[$i]="veth${i}cl"
+		vethrt[$i]="veth${i}rt"
+		ip link add   "${vethcl[$i]}" netns "$ns" type veth \
+		    peer name "${vethrt[$i]}" netns "$nsrt"
+		ret=$(($ret | $?))
+	else # Use pair of interconnected hardware interfaces
+		ip link set "${vethrt[$i]}" netns "$nsrt"
+		ret=$(($ret | $?))
+		ip link set "${vethcl[$i]}" netns "$ns"
+		ret=$(($ret | $?))
+	fi
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: (v)eth pairs cannot be used"
+	exit $ksft_skip
+fi
+
+if [ -n "$showtree" ]; then
+	cat <<-EOF
+	Setup:
+	            CLIENT 0
+	              ${vethcl[$WAN]}
+	                |
+	              ${vethrt[$WAN]}
+	               WAN
+	              ROUTER
+	          LAN1      LAN2
+	$(printf "%14.14s" ${vethrt[$LAN1]})      ${vethrt[$LAN2]}
+	           |          |
+	$(printf "%14.14s" ${vethcl[$LAN1]})      ${vethcl[$LAN2]}
+	      CLIENT 1      CLIENT 2
+
+	EOF
+fi
+
+for n in nsclientwan nsclientlan; do
+	routerside=""; clientside=""
+	for i in $WAN $LAN1 $LAN2; do
+		ns="${nsa[$i]}"
+		[[ "$ns" != "$n"* ]] && continue
+		mac=$(check_mac $ns ${vethcl[$i]} "$routerside $clientside")
+		ret=$(($ret | $?))
+		clientside+=" $mac"
+		mac=$(check_mac $nsrt ${vethrt[$i]} "$clientside")
+		ret=$(($ret | $?))
+		routerside+=" $mac"
+	done
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: conflicting mac address"
+	exit $ksft_skip
+fi
+
+set_pair_link up $WAN $LAN1 $LAN2
+ret=$(($ret | $?))
+if [ $ret -ne 0 ]; then
+	echo "SKIP: setting (v)eth pairs link up failed"
+	exit $ksft_skip
+fi
+
+i=$WAN
+ip -net "$nsrt" link set "${vethrt[$i]}" master $BRWAN
+set_client $i none
+add_addr $ADWAN "$BRWAN"
+
+family="bridge"
+setup_nftables $LAN1 $LAN2 2>/dev/null
+if [ $? -ne 0 ]; then
+	echo "INFO: Cannot add nftables table $family"
+	tests[1]=""; test[2]=""
+fi
+family="inet"
+if ! setup_nftables $WAN $LAN1 2>/dev/null; then
+	echo "INFO: Cannot add nftables table $family"
+	tests[3]=""; test[4]=""; tests[5]=""
+fi
+
+### End Initial Setup ###
+
+if [ -n "${tests[1]}" ]; then
+	# Setup brlan as vlan unaware bridge
+	family="bridge"
+	ip -net "$nsrt" link add $BRLAN type bridge
+	ip -net "$nsrt" link set $BRLAN up
+	for i in $LAN1 $LAN2; do
+		ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+	done
+	test_1_unaware_bridge
+	ret=$(($ret | $?))
+	ip -net "$nsrt" link del $BRLAN type bridge
+fi
+
+if [ -n "${tests[2]}" ] || [ -n "${tests[3]}" ] || [ -n "${tests[4]}" ]; then
+	# Setup brlan as vlan aware bridge
+	family="bridge"
+
+	ip -net "$nsrt" link add $BRLAN type bridge vlan_filtering 1 vlan_default_pvid 0
+	ip -net "$nsrt" link set $BRLAN up
+	bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 pvid untagged self
+	add_addr $ADLAN "$BRLAN"
+	for i in $LAN1 $LAN2; do
+		ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+	done
+
+	if [ -n "${tests[2]}" ]; then
+		test_2_aware_bridge
+		ret=$(($ret | $?))
+	fi
+
+	family="inet"
+
+	if [ -n "${tests[3]}" ]; then
+		test_3_forward_without_vlandev
+		ret=$(($ret | $?))
+	fi
+
+	if [ -n "${tests[4]}" ]; then
+		# Setup vlan-device linked to brlan master port
+		del_addr $ADLAN "$BRLAN"
+		ip -net "$nsrt" link set $BRLAN down
+		bridge -net "$nsrt" vlan del dev $BRLAN vid $VID1 pvid untagged self
+		bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 self
+		ip -net "$nsrt" link add link $BRLAN name $BRLAN.$VID1 type vlan id $VID1
+		ip -net "$nsrt" link set $BRLAN up
+		ip -net "$nsrt" link set "$BRLAN.$VID1" up
+		add_addr $ADLAN "$BRLAN.$VID1"
+		test_4_forward_with_vlandev
+		ret=$(($ret | $?))
+	fi
+
+	ip -net "$nsrt" link del $BRLAN type bridge
+fi
+
+### Finish tests ###
+
+ip -net "$nsrt" link del $BRWAN type bridge
+
+for i in $WAN $LAN1 $LAN2; do
+	unset_client $i
+done
+
+if [ $ret -eq 0 ]; then
+	echo "PASS:  all tests passed"
+else
+	echo "ERROR: bridge fastpath test has failed"
+fi
+
+exit $ret
-- 
2.47.1


