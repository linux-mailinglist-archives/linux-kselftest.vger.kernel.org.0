Return-Path: <linux-kselftest+bounces-46147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD117C76BF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4725D4E62B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61325221FBF;
	Fri, 21 Nov 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eDBh1/5j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A422068A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684454; cv=none; b=t4iQoHxPebuSrHqK/w6RFbiaxxdOAMDxkcVpl/yd3bS4Xuvyn2ink96JObKj4l3rWQ64rw59mWiqDjZgZR+esIjEHbNDK/bi2Xg+PHk6GY/bVs9T+a1IFa+VlT/sHiIj7J641dxdMSzmhm/duzH/S4e5PY59O6PBU0en9LVigtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684454; c=relaxed/simple;
	bh=gkVr8IobuC68eHv3Z7VDv3KtRdI5x5m7j6A4Cq1f+Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDxELL7OEKBGW7yLXQHCcbtNWJcr7LKhPHHHuZMXSKR3UhwESAQ9aTEO8vkbxHmw2VLm/CYJXgazWyd4xUolxxHwd9uaCsxxeg01Lnd0X4WWxp8oPotf6NyqRLDu0PPPokHpbF6u2RLMIaEVMHEof06LQu0jNoaxog+MSlJOYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eDBh1/5j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso14078195e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684450; x=1764289250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZEcjIjXTcoCtcoHMKS6yM6dPDyzVSynlkUTK2L1Eyc=;
        b=eDBh1/5jVornOlC3bGDMlIKrSIzcThlN/n9FqHGMJ5nq9IQo7/b0VP2iqVWQuOiZzb
         zQQK64BXXrQDbMTkuIGzzU9mCs/mHYr49+kmPJB6MgMPxs+kGVw1jUG+tzAleMnB+Xjj
         YhMLkFwmdTV9WrVcv3TtIDpJAPweHU/vnMfVdLChr1f++jxjc3q8w8b5tURZl6kXTQRD
         RMCRll8P4urM7vwZzw7q/z6tGlosAgV6NokDfXGZO2lZm9QI4nkNaIH87WyMoG0K/pV0
         Y6Rg8qdsafQ8qHYfaRZ0BZl5/NzY+QPVwk5xSBuOOvs0551eLmApCoEnZlOfyiREJ6/T
         PiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684450; x=1764289250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZEcjIjXTcoCtcoHMKS6yM6dPDyzVSynlkUTK2L1Eyc=;
        b=wtHVYGclB5Y0hMzLlKKk6zD/depEZMy1ElnkLYVTo9oqxxamezyvNrWcYvxl960L8L
         P+Il8cUeZgjV79AvHElpk5RzF8eh2kSLto2QzZWX1VxtHtVhfk4N8Me50CmsenmN3qfo
         wTEgd8uC4LWcFScA6ONgZmw6/WTpKYtn1pJRvkV4FYVGJs3OSOhJS149L0Jolpphor4R
         bg3P+WSCLNdjsVK14eOlCFO3aIZer75ci5ylYUA7WMMG9N+83llVf1vBi0/fRLZDi9ew
         NLKn8znIKPPPvPskyFAoA/OhppW9taLdeek/dJ9ChA7Qnz2vHa1+AkIWi7LZ1E9kMt1c
         ZhfA==
X-Forwarded-Encrypted: i=1; AJvYcCUasN35BZNAumbm8T7fZHRm7ffrof5gIfwT6GBOUODyglVR4lkxRxp2ttmGMYJj8gRe+g8laJ85jBA11IPW/sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL55ZamKGYdzZOj938jJ3eIRwuYHIug+nkcTgoDxM7eIe7nNbM
	ZSk2Fpjm0xSuhvfBr8ldwOc7groVxbcfU6IAkuLgoRagDde/HcS35+21LfoWck2n1qOR40hlxhW
	Eq54B316PV5XSE/2mHenkfQ2/yjmPDHd9iKkLyfwFegDggBeZ6rH1wbKJOT/+VzI0j6xgjbvsmp
	0nAh8=
X-Gm-Gg: ASbGnctYAC36A8uf+Ft4qBorEqd2ncLcfUQ2673xbJUU80fZ2Ovu3vLRWt+F5jIBWtN
	13gTYKDgpfsj3TaoS6AMiiUFBPZfcv+YndJT5S0TL13P10ziLFjErsGB9zxAWUfQrSgHGYH/frU
	U1sf3FB0CFAFgYH76ROGzcmvw65DhPDeHp686RilXBbWEcCJHEwIXMA/uPpGOlJDPe8ZRbzrc8M
	ovJjhgccWc2gBXSTPa6TYgEr+31rW1t/Jyiu87B+m1ePdsw1vypPcbQsR4aJ1i9gvQLxtmeLSSB
	PZY5JvqsDE5/LUQofwA/3WPLdkIYGTth419qa763KQHOYXsu2VMsVkoTcf3H3nb4ddgmj9Sc1Dm
	VjSFu0HgF6wxwO+JiW6/Xw3VEkAfR9iOIj2ae6Bh3E4lzeYXYpas+6xAlEHB/R2tmhtl77MGeKL
	Me2cl4p8uCr/mJo6z1ZgmqTs6d9mqXCtn4AdQ=
X-Google-Smtp-Source: AGHT+IFUsYW7hYLEsGViwAV+3gSRUjYStxH02gAJMXNSlf/oVnRvsCZ+DsOFchdok41u9ZKOmJE2Wg==
X-Received: by 2002:a05:600c:5494:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477c0184c3amr4926295e9.10.1763684450102;
        Thu, 20 Nov 2025 16:20:50 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC net-next 00/13] ovpn: new features + kselftests
Date: Fri, 21 Nov 2025 01:20:31 +0100
Message-ID: <20251121002044.16071-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

This patchset is just a respin of my latest PR to net-next, including all
modifications requested by Jakub and Sabrina.

However, this time I am also adding patches targeting selftest/net/ovpn, as
they come in handy for testing the new features (originally I wanted
them to be a separate PR, but it doesn't indeed make a lot of sense).

This said, since these kselftest patches are quite invasive, I didn't
feel confident with sending them in a PR right away, but I rather wanted
some feedback from Sabrina and Shuah first, if possible.

So here we go.

Once I get some approval on this batch, I'll send then send them all
to net-next again as PRv2.


Thanks a lot!

Regards,


Antonio Quartulli (1):
  selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3

Qingfang Deng (1):
  ovpn: pktid: use bitops.h API

Ralf Lici (10):
  selftests: ovpn: add notification parsing and matching
  ovpn: notify userspace on client float event
  ovpn: add support for asymmetric peer IDs
  selftests: ovpn: check asymmetric peer-id
  selftests: ovpn: add test for the FW mark feature
  ovpn: consolidate crypto allocations in one chunk
  ovpn: use bound device in UDP when available
  selftests: ovpn: add test for bound device
  ovpn: use bound address in UDP when available
  selftests: ovpn: add test for bound address

Sabrina Dubroca (1):
  ovpn: use correct array size to parse nested attributes in
    ovpn_nl_key_swap_doit

 Documentation/netlink/specs/ovpn.yaml         |  23 +-
 drivers/net/ovpn/crypto_aead.c                | 162 +++++++---
 drivers/net/ovpn/io.c                         |   8 +-
 drivers/net/ovpn/netlink-gen.c                |  13 +-
 drivers/net/ovpn/netlink-gen.h                |   6 +-
 drivers/net/ovpn/netlink.c                    |  98 +++++-
 drivers/net/ovpn/netlink.h                    |   2 +
 drivers/net/ovpn/peer.c                       |   6 +
 drivers/net/ovpn/peer.h                       |   4 +-
 drivers/net/ovpn/pktid.c                      |  11 +-
 drivers/net/ovpn/pktid.h                      |   2 +-
 drivers/net/ovpn/skb.h                        |  13 +-
 drivers/net/ovpn/udp.c                        |  10 +-
 include/uapi/linux/ovpn.h                     |   2 +
 tools/testing/selftests/net/ovpn/Makefile     |  17 +-
 .../selftests/net/ovpn/check_requirements.py  |  37 +++
 tools/testing/selftests/net/ovpn/common.sh    |  60 +++-
 tools/testing/selftests/net/ovpn/data64.key   |   6 +-
 .../selftests/net/ovpn/json/peer0-float.json  |   9 +
 .../selftests/net/ovpn/json/peer0.json        |   6 +
 .../selftests/net/ovpn/json/peer1-float.json  |   1 +
 .../selftests/net/ovpn/json/peer1.json        |   1 +
 .../selftests/net/ovpn/json/peer2-float.json  |   1 +
 .../selftests/net/ovpn/json/peer2.json        |   1 +
 .../selftests/net/ovpn/json/peer3-float.json  |   1 +
 .../selftests/net/ovpn/json/peer3.json        |   1 +
 .../selftests/net/ovpn/json/peer4-float.json  |   1 +
 .../selftests/net/ovpn/json/peer4.json        |   1 +
 .../selftests/net/ovpn/json/peer5-float.json  |   1 +
 .../selftests/net/ovpn/json/peer5.json        |   1 +
 .../selftests/net/ovpn/json/peer6-float.json  |   1 +
 .../selftests/net/ovpn/json/peer6.json        |   1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 281 +++++++++++-------
 .../selftests/net/ovpn/requirements.txt       |   1 +
 .../testing/selftests/net/ovpn/tcp_peers.txt  |  11 +-
 .../selftests/net/ovpn/test-bind-addr.sh      |  10 +
 tools/testing/selftests/net/ovpn/test-bind.sh | 117 ++++++++
 .../selftests/net/ovpn/test-close-socket.sh   |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  81 +++++
 tools/testing/selftests/net/ovpn/test.sh      |  57 +++-
 .../testing/selftests/net/ovpn/udp_peers.txt  |  12 +-
 41 files changed, 855 insertions(+), 224 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/check_requirements.py
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json
 create mode 120000 tools/testing/selftests/net/ovpn/requirements.txt
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind-addr.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

-- 
2.51.2


