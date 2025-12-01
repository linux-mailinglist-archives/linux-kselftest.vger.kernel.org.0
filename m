Return-Path: <linux-kselftest+bounces-46789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D26DCC96A6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10594E1D1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BE0302CDF;
	Mon,  1 Dec 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRHchNO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3107302CB4
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584930; cv=none; b=i3KdDYkEzsJ4rWnhyrh0czeiunBqK9sIbWUHUekwvU98OHQMzAk8Emw8QikNOIFplGQNTrOaQk1Jem/7RyRKUxpIgx5N+eqUvkpGRZCFaIdTuq7gy+vXCBkESmvQWWdIqyc99Dg/NSJTaHCCSHFhUfpcGuDOp6+uFN2jH3I4mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584930; c=relaxed/simple;
	bh=coKQmnQOeVL2OgF0ptAkfJC94MDFt2dY6q7vB6WFLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJkbUhBcm+ovPDv/UQ+LFzTDiZWY2KQDebOU59jfX4fanlo29WpEn7iOBThq+UEfLKs4t0Jumzhl0zg3FnaSJ42dA2SVwP48yI6B81CQMETOT8qOoosSni2Gb0Xf4MEkjoJa5deckthG1KUstVkVEF872hZu50Jpozj/LA3tfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRHchNO7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7355f6ef12so795903766b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584927; x=1765189727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Trv2vBQvyezhPFCSlLnIlg78sYOVaGWphXC4AQCe9So=;
        b=eRHchNO78riX9WOSFDzaI6092nBLp/OYpUwukl8uniM+1J2CKZizKv7yaiGZspgKdU
         X9tM9GMVOyQG64GbCO+09+3LvypHLAV9w+d392LuQrIRpzrJk4Lk2pXcmGKW6j3DmIaR
         yLPgpPqMzw7YZsF18c22Nfm2/DTAkyTgW+veYjt3Plr5JBdzEdbW//qoVe7Z6TtGXH+I
         eGj/WWpKLMmUf3rwlY706NBHZdu/qRoFX7IOTLrNHYr6Z2BmZegx12TKK8OkqXvIqOmL
         vsZILymUye0SR9Ft4gMf4iFitgZZjaRVs9vZ9Jb6dSwjzdsFQ3H/4sfX9BPwXBsz9lco
         NLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584927; x=1765189727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trv2vBQvyezhPFCSlLnIlg78sYOVaGWphXC4AQCe9So=;
        b=BlJqmpu0deYhqiItZJYhm6SlYLzZZc2UlWRiPThOCcwRQRm8a0uXximU6Z/agcpRM+
         A7vKmvWALu6NYCYy33Da4689yI4+WwslvsLIMj8ZcKriff39ewi8aLvLBGAConhdSZ3Z
         KNMASX4G3HvmNX6HyUg6P4aFFE+iRwGapU1E5r89wPWmf1fSv3oWNPs56SlxaoeG5leG
         vJEFuR0VILdr/05e2D2GMeKSCx0ZZenSJDhKt+p1OjVxrsk5Wqi/dfUCAIaUNGdzASRR
         V5kfBF57OQDabzrEiMerH861bVIZYGd1nh4knF7JhrwY7OgNUyMqWuAIm3YX5ecWYfRn
         OL8g==
X-Forwarded-Encrypted: i=1; AJvYcCUu4n2SXxT0o1ljNsO+UZarWcyiFDQ2m2hH9zCM2ksqs/QuVgmrpLneRmjdTbP+HzoOHD+J7UN4dx1GmoTY6J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUci/qKX6MTV4ZJbv5caiW6R40MMkd33iBk4QnyAGXj7OTqmE
	i8ixsC8xD6dk43REVAFrcA0hoVVMPGssPbYfpnsCyUDDvSsm14dNwC3S
X-Gm-Gg: ASbGnctY2+btuEws/KLfbG3eTsx8vtey4xJ6soUZUd3AYNrPYrGw2FvIqzquOrUqUTV
	pJrHdpdNyN00UE4oWN3ZP/PmSED/Y7I/OEVy9Q58IMIFw3zBkJDdvOyMQAq+8SqrplsEfLOB0Vc
	2GuLURB04EcYjKfkvWGj3RK9NEF9hIJfZiEPYdULAtsXnJJ46BceI3z+VYL1ZJr5SQ0y2uUyt0D
	lZCVhVrsJEDHE7glyRNYZKkqJmxnVxDjtkcNO0shKKRXvq5N+rgrIF9/rNo4s5JhX6zmhzMx3ui
	GruV/ebnDSYRYGihbsxSy/ipapykCPuOV0T9DFja8kE8XGqbS2jhnai6OXYaULJsISKkItX8Jma
	Rnnbh47ewCJtcylLPFpSjOSG4Aew2LtcKUOdhgBJZYBYWtdqAEY8gU5tKZ23Bg3ZhYG9tOHuy0l
	WVAMBswEDopBddifjPodZh18TJBBQiGECXcsM9nsStYGWfkgZlow+1s3sM1i7wRYytUnE=
X-Google-Smtp-Source: AGHT+IEpYaDw6CB+PRG4a7CypPzPVOz1eYsdJhEGj+ut8QOSYl9UkcEcJaF3eu3S807y5FJLxRb/8A==
X-Received: by 2002:a17:906:fe49:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b76719d0982mr4315736866b.58.1764584926734;
        Mon, 01 Dec 2025 02:28:46 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d31sm1193157766b.9.2025.12.01.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:46 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 0/5] net: dsa: deny unsupported 8021q upper on bridge port configurations
Date: Mon,  1 Dec 2025 11:28:12 +0100
Message-ID: <20251201102817.301552-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst is quite strict on how VLAN
uppers on bridged ports should work:

- with VLAN filtering turned off, the bridge will process all ingress traffic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper. (...)

- with VLAN filtering turned on, these VLAN devices can be created as long as
  the bridge does not have an existing VLAN entry with the same VID on any
  bridge port. (...)

This means that VLAN tagged traffic matching a VLAN upper is never
forwarded from that port (unless the VLAN upper itself is bridged).

It does *not* mean that VLAN tagged traffic matching a VLAN upper is not
forwarded to that port anymore, as VLAN uppers only consume ingressing
traffic.

Currently, there is no way to tell dsa drivers that a VLAN on a
bridged port is for a VLAN upper and should not be processed by the
bridge.

Both adding a VLAN to a bridge port of bridge and adding a VLAN upper to
a bridged port of a VLAN-aware bridge will call
dsa_switch_ops::port_vlan_add(), with no way for the driver to know
which is which. In case of VLAN-unaware bridges, there is likely no
dsa_switch_ops::port_vlan_add() call at all for the VLAN upper.

But even if DSA told drivers which type of VLAN this is, most devices
likely would not support configuring forwarding per VLAN per port.

So in order to prevent the configuration of setups with unintended
forwarding between ports:

* deny configuring more than one VLAN upper on bridged ports per VLAN on
  VLAN filtering bridges
* deny configuring any VLAN uppers on bridged ports on VLAN non
  filtering bridges
* And consequently, disallow disabling filtering as long as there are
  any VLAN uppers configured on bridged ports

An alternative solution suggested by switchdev.rst would be to treat
these ports as standalone, and do the filtering/forwarding in software.

But likely DSA supported switches are used on low power devices, where
the performance impact from this would be large.

To verify that this is needed, add appropriate selftests to
no_forwarding to verify either VLAN uppers are denied, or VLAN traffic
is not unexpectedly (still) forwarded.

These test succeed with a veth-backed software bridge, but fail on a b53
device without the DSA changes applied.

While going through the code, I also found one corner case where it was
possible to add bridge VLANs shared with VLAN uppers, while adding
VLAN uppers shared with bridge VLANs was properly denied. This is the
first patch as this seems to be like the least controversial.

Still sent as a RFC/RFT for now due to the potential impact, though a
preliminary test didn't should any failures with
bridge_vlan_{un,}aware.sh and local_termination.sh selftests on
BCM63268.

Also since net-next is closed (though I'm not sure yet if this is net or
net-next material, since this just properly prevents broken setups).

Changes v1 -> v2:

* added selftests for both VLAN-aware and VLAN-unaware bridges
* actually disallow VLAN uppers on VLAN-unware bridges, not disallow
  more than one
* fixed the description of VLAN upper notification behaviour of DSA with
  filtering disabled

Jonas Gorski (5):
  net: dsa: deny bridge VLAN with existing 8021q upper on any port
  net: dsa: deny multiple 8021q uppers on bridged ports for the same
    VLAN
  selftests: no_forwarding: test VLAN uppers on VLAN aware bridged ports
  net: dsa: deny 8021q uppers on vlan unaware bridged ports
  selftests: no_forwarding: test VLAN uppers on VLAN-unaware bridged
    ports

 net/dsa/port.c                                |  23 +---
 net/dsa/user.c                                |  51 ++++++---
 .../selftests/net/forwarding/no_forwarding.sh | 107 ++++++++++++++----
 3 files changed, 127 insertions(+), 54 deletions(-)


base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
-- 
2.43.0


