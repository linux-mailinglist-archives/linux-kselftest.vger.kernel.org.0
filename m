Return-Path: <linux-kselftest+bounces-30364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9CBA80DBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0BF7A80BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59E1DC9AC;
	Tue,  8 Apr 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjI0/QoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5542A97;
	Tue,  8 Apr 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122210; cv=none; b=W7D2TklPdPmBuPIutILV6YDekJ0fD44kQOKFzrJOx54hQrLGPfLmyYyjs1WMfZLnwIETZgDsIFQyZFtdYuLeCuJ7wJ3X8U+9IirV6o/3XoukDpv/u6h3vASfEroNY0BfOHxvgPUDCVJso4tdqEtysdhFInFkqPTz8RocS00VS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122210; c=relaxed/simple;
	bh=FebezSBtP4NjhDUqH2vxd/kBQ2s8UqGIdCeSoS/yNTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcHh/r7kr54oNxLGJCOy6k21+ut1WQw6277cJH8lf+R5yH5O+zAU0jWet54K5mhF5bWqvGI7arCF8hyoCqlhe/WST1/NIM4rUDy8X+EkgtZWvyAR4sum7mQnz2EH+AvSRgwelUKC+Y32jJvQ17+spEVgcONsP7wRVFps+EV5Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjI0/QoR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso967745166b.3;
        Tue, 08 Apr 2025 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122205; x=1744727005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Wzef7Krw082KFEOBYS4UnsPKAsj3OI72G2ulLGl5M=;
        b=jjI0/QoRa2t/jiSIJayZl1+A4SenCvuaMaPhrGmy0M/FfcmHhvdLCZs3WS4bOrn4mv
         6tdHrlPVEqWyFJPimHJGICfmR7btxrQIIDf8m9Sja/hMI/vCQNbJooOhooyo6gKj7ev8
         FPMu79hdszAuOpFyihIZjJmPOtbhIEki8oHJNfZi1cyydjWjO+aX/E/66/yKHA3Uf1cY
         nRMZvHEZ2URsKww2ISc+K0LUmD58iJEorE2g3rB9dhG4PtThor97y1lxBzO78HJAo6Wz
         2x0q6B+kTU9uKjwzzfpsrYHsQl3YjgommFWjrLWmNzR2NbyA36w7PMhm2jel8IrW2ST8
         iTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122205; x=1744727005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/Wzef7Krw082KFEOBYS4UnsPKAsj3OI72G2ulLGl5M=;
        b=eqeozuDwRsGeawyXmj2ZUZBj5skX1EpAQFJn3vSg7Y5OWj8rErkzFFj1vfamC81qbB
         Te7+67Bj0HJ+edh5YZneCneMjk8/UbbFZMu7rbxzGiatihiZgeP9hK/jHhUDxKyOKiWR
         ZZaTC+YfArdft+SpAe6Y3jLU8N8IRR/tQizEB3snW82051v5NuyxOAbRYcjguhQYntdm
         BTAww5vnNVlBI8yWrM40kL4abrduhgM/pUe2PP+yDbgbfgmPSaxb6MVjmode5LaSnGlD
         ikvnY+4b4vwSAKGTcj9LBmQQN13O2i3yXaAobdfcAIfCenUCJlKs9i161c0GIn+krgCQ
         z3DA==
X-Forwarded-Encrypted: i=1; AJvYcCUVEmio2JFlhoKQMSiQHwzG5raqmNPlB4G2/n4zN9vV0DdAEdYbk08tvvX3n9EEpivPtp52rOPX@vger.kernel.org, AJvYcCXI6J1pmnjbwYk3+lg2w117fxlJlfn6gDJPys02pGk2SctGtS+jkbABQ4/xXch4EqKE/h1/fmgWZd5zg+8Uxc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpcSUPSRqz4slffh+tCO5+5Ybs38XChLBOmtTUJPXMfuQmGjv
	aG4QhIaDYjwYwJ+lOtLuRB4PA2xjc3tsA4FoZI6UosvFlvztPfYM
X-Gm-Gg: ASbGncsMnlJBlqpSLsw8PNjf4LbDUmzca7kA510sv8N9eElDMmvbseOhXzL18qwy4bq
	2bB8Q+Act4iyXUVA2NOtUoYtA3uVyc7/o8D+S1d+t7yEilL27fGigy4Y+YXayNgld7j6LoE95MS
	4xVxfUBmBq8UMpoVvFg8pf80pz5J3PlKWSpmFaCDtUvcBqI0TxKtpbAtiq8fuGeZ5On2eFo4Xkc
	fcVefZAvs4vlorsIiiSvagIM+mssLoRDFuXpgFfV7VM+rgkzB1xxfkujDWb+GmZgRTA1xM/ZDw1
	EGKPtT7nI4W+dyV9OQfGihG7/PIF1UkOnPufUDCC+fQ7Wjn6F5S5Vt5fB6C2RZ6erCRrDbRyubE
	IGxcw7tI/1JBjsrFpKZdnZ5dgm7ztgezJ+6ejV3GY/O4mrlledbk+T7hWm0UyrE8=
X-Google-Smtp-Source: AGHT+IGUPdUzZFwK2vT0Leudr14qfxoVCY5cHCPZbCN9EIVefNPB9ekluJnOPkIcRh0BoZaL2iZ14A==
X-Received: by 2002:a17:906:6846:b0:ac7:ed56:8a34 with SMTP id a640c23a62f3a-ac7ed568a5dmr900521066b.21.1744122204449;
        Tue, 08 Apr 2025 07:23:24 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f363sm928703066b.105.2025.04.08.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:23:21 -0700 (PDT)
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
Subject: [RFC PATCH v1 nf-next] selftests: netfilter: Add bridge_fastpath.sh
Date: Tue,  8 Apr 2025 16:22:56 +0200
Message-ID: <20250408142256.95206-1-ericwouds@gmail.com>
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

Because the development of this script has helped me find and fix a
few issues in my last version of the patches needed for bridge-fastpath,
I am sending the whole set again (split up in smaller patch-sets),
including the latest fixes.

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

 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/bridge_fastpath.sh          | 922 ++++++++++++++++++
 2 files changed, 923 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_fastpath.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index ffe161fac8b5..104dd9e5e02a 100644
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
index 000000000000..68e2f9e70951
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/bridge_fastpath.sh
@@ -0,0 +1,922 @@
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
+#  - without vlan
+#  - single vlan
+#  - double q vlan  (only on veth-devices)
+#  - 802.1ad vlan   (only on veth-devices)
+#  - pppoe       (when available)
+#  - pppoe-in-q  (when available)
+#
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
+# Mote 3: Some interfaces to test on the router side, are netns immutable.
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
+	'-4' | '--ipv4')
+		do_ipv4=1
+		;;
+	'-6' | '--ipv6')
+		do_ipv6=1
+		;;
+	'-a' | '--aware')
+		skip_unaware=1
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
+		  -4|-6 --ipv4|--ipv6          test ipv4/6 only
+		  -a --aware                   only test vlan aware bridge
+		  -d --defaultnsrouter         router in default network namespace, caution!
+		  -f --fixmac                  change mac address when conflict found
+		  -n --noskip                  also perform the normally skipped tests
+		  -t --showtree                show the tree of used interfaces
+		EOF
+		;;
+	esac
+	shift
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
+	while [ -n "$(ip -net "$ns1" link show ppp$ppp$LAN1 $LAN2>/dev/null)" ]
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
+setup_nftables()
+{
+	local i1=$1
+	local i2=$2
+
+	ip netns exec "$nsrt" nft flush ruleset
+
+	if ! add_masq; then
+		return 1
+	fi
+
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    chain forward {
+	        type filter hook forward priority 0; policy accept;
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
+	local devs="${vethrt[$1]} , ${vethrt[$2]}"
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
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    flowtable f {
+	        hook ingress priority filter
+	        devices = { ${devs} }
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
+ret=0
+### Start Initial Setup ###
+
+for i in 4 6; do
+	ip netns exec "$nsrt" sysctl -q net.ipv$i.conf.all.forwarding=1
+done
+
+### Setup brlan as vlan unaware bridge          ###
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
+	echo "SKIP: because of conflicting mac address"
+	exit $ksft_skip
+fi
+
+for i in $WAN $LAN1 $LAN2; do
+	ns="${nsa[$i]}"
+	ip -net "$ns" link set "${vethcl[$i]}" up
+	ret=$(($ret | $?))
+	ip -net "$nsrt" link set "${vethrt[$i]}" up
+	ret=$(($ret | $?))
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: setting (v)eth pairs link up failed"
+	exit $ksft_skip
+fi
+
+for j in $(seq 1 $(($LINKUP_TIMEOUT * 5 ))); do
+	ret=0
+	for i in $WAN $LAN1 $LAN2; do
+		ns="${nsa[$i]}"
+		is_linkup $ns "${vethcl[$i]}"
+		ret=$(($ret | $?))
+		is_linkup $nsrt "${vethrt[$i]}"
+		ret=$(($ret | $?))
+	done
+	[ $ret -eq 0 ] && break
+	sleep 0.2
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: waiting for (v)eth pairs link up failed"
+	exit $ksft_skip
+fi
+
+i=$WAN
+ip -net "$nsrt" link set "${vethrt[$i]}" master $BRWAN
+
+### End Initial Setup ###
+
+family="bridge"
+setup_nftables $LAN1 $LAN2 2>/dev/null
+if [ $? -ne 0 ]; then
+	echo "INFO: Cannot add nftables table $family"
+	skip_family_bridge_part2=1
+elif [ -n "$skip_unaware" ]; then
+	echo "INFO: Skipping unaware bridge"
+else
+
+### Start nft family bridge test part 1 ###
+
+ip -net "$nsrt" link add $BRLAN type bridge
+ip -net "$nsrt" link set $BRLAN up
+for i in $LAN1 $LAN2; do
+	ns="${nsa[$i]}"
+	ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+done
+
+for i in $LAN1 $LAN2; do
+	set_client $i none
+done
+
+test_paths $LAN1 $LAN2 "unaware bridge, without encaps,           "
+ret=$(($ret | $?))
+
+for i in $LAN1 $LAN2; do
+	set_client $i q
+done
+
+test_paths $LAN1 $LAN2 "unaware bridge, with single vlan encap,   "
+ret=$(($ret | $?))
+
+for i in $LAN1 $LAN2; do
+	set_client $i qq
+done
+
+# Skip testing double tagged packets on real hardware
+if [ -n "$lan_all_veth" ] || [ -n "$noskip" ]; then
+
+test_paths $LAN1 $LAN2 "unaware bridge, with double q vlan encaps,"
+ret=$(($ret | $?))
+
+for i in $LAN1 $LAN2; do
+	set_client $i ad
+done
+
+test_paths $LAN1 $LAN2 "unaware bridge, with 802.1ad vlan encaps, "
+ret=$(($ret | $?))
+
+fi
+# End Skip testing double tagged packets
+
+if [ -n "$(command -v pppd 2>/dev/null)" ] &&
+   [ -n "$(command -v pppoe-server 2>/dev/null)" ]; then
+# Start pppoe
+
+for i in $LAN1 $LAN2; do
+	set_client $i none noaddress
+done
+
+if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe encap"; then
+	test_paths $LAN1 $LAN2 "unaware bridge, with pppoe encap,         "
+	ret=$(($ret | $?))
+fi
+
+del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+
+for i in $LAN1 $LAN2; do
+	set_client $i q noaddress
+done
+
+if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe-in-q encaps"; then
+	test_paths $LAN1 $LAN2 "unaware bridge, with pppoe-in-q encaps,   "
+	ret=$(($ret | $?))
+fi
+
+del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+
+# End pppoe
+fi
+
+ip -net "$nsrt" link del $BRLAN type bridge
+
+### End nft family bridge test part 1 ###
+fi
+
+### Setup brlan as vlan aware bridge ###
+
+ip -net "$nsrt" link add $BRLAN type bridge vlan_filtering 1 vlan_default_pvid 0
+ip -net "$nsrt" link set $BRLAN up
+bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 pvid untagged self
+for i in $LAN1 $LAN2; do
+	ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+done
+
+for i in $LAN1 $LAN2; do
+	set_client $i none
+done
+
+if [ -z "$skip_family_bridge_part2" ]; then
+### Start nft family bridge test part 2 ###
+
+test_paths $LAN1 $LAN2 "aware bridge,   without/without vlan encap,"
+ret=$(($ret | $?))
+
+i=$LAN1
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+set_client $i q
+
+test_paths $LAN1 $LAN2 "aware bridge,   with/without vlan encap,   "
+ret=$(($ret | $?))
+
+i=$LAN2
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+set_client $i q
+
+test_paths $LAN1 $LAN2 "aware bridge,   with/with vlan encap,      "
+ret=$(($ret | $?))
+
+i=$LAN1
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+set_client $i none
+
+test_paths $LAN1 $LAN2 "aware bridge,   without/with vlan encap,   "
+ret=$(($ret | $?))
+
+i=$LAN2
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+set_client $i none
+
+fi
+
+### End nft family bridge test part 2 ###
+
+### Start nft family inet test ###
+family="inet"
+if ! setup_nftables $WAN $LAN1 $LAN2>/dev/null; then
+	echo "INFO: Cannot add nftables table $family"
+	exit $ret
+fi
+
+set_client $WAN none
+add_addr $ADWAN "$BRWAN"
+add_addr $ADLAN "$BRLAN"
+
+test_paths $LAN1 $WAN "forward,        without vlan-device, without vlan encap, client1,"
+ret=$(($ret | $?))
+if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+test_paths $LAN2 $WAN "forward,        without vlan-device, without vlan encap, client2,"
+ret=$(($ret | $?))
+fi
+
+for i in $LAN1 $LAN2; do
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+set_client $i q
+done
+
+test_paths $LAN1 $WAN "forward,        without vlan-device, with vlan encap,    client1,"
+ret=$(($ret | $?))
+if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+test_paths $LAN2 $WAN "forward,        without vlan-device, with vlan encap,    client2,"
+ret=$(($ret | $?))
+fi
+
+# Setup vlan-device linked to brlan master port
+del_addr $ADLAN "$BRLAN"
+ip -net "$nsrt" link set $BRLAN down
+bridge -net "$nsrt" vlan del dev $BRLAN vid $VID1 pvid untagged self
+bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 self
+ip -net "$nsrt" link add link $BRLAN name $BRLAN.$VID1 type vlan id $VID1
+ip -net "$nsrt" link set $BRLAN up
+ip -net "$nsrt" link set "$BRLAN.$VID1" up
+add_addr $ADLAN "$BRLAN.$VID1"
+
+test_paths $LAN1 $WAN "forward,        with vlan-device,    with vlan encap,    client1,"
+ret=$(($ret | $?))
+if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+test_paths $LAN2 $WAN "forward,        with vlan-device,    with vlan encap,    client2,"
+ret=$(($ret | $?))
+fi
+
+for i in $LAN1 $LAN2; do
+bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+set_client $i none
+done
+
+test_paths $LAN1 $WAN "forward,        with vlan-device,    without vlan encap, client1,"
+ret=$(($ret | $?))
+if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+test_paths $LAN2 $WAN "forward,        with vlan-device,    without vlan encap, client2,"
+ret=$(($ret | $?))
+fi
+
+### End nft family inet test ###
+
+for i in $WAN $LAN1 $LAN2; do
+	unset_client $i
+done
+ip -net "$nsrt" link del $BRLAN type bridge
+ip -net "$nsrt" link del $BRWAN type bridge
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


