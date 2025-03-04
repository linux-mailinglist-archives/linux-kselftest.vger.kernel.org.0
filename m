Return-Path: <linux-kselftest+bounces-28111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5357A4CFF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59F8171BDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132C1C683;
	Tue,  4 Mar 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CRjAlYeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752F3234
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048470; cv=none; b=WDvU9MErhL8w+0rx9/ilCe9W1uKWsOxlaQ5x+g7tkZwUYEWTJJCCx3U5vMMoyDuhhiGexjCVwfW/0TnDof70ttOexnq343ADICQDvAK0CnNAp2EJOxSWYofFpaPBZsq08TjsG8ULqCmj7Td+FUN+cWpoU7BlL6TY9v4pPsP92L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048470; c=relaxed/simple;
	bh=TLKjbM01ue0nby1SWB0flz5kAYA3S3BxIQ/QF7KTRQo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rc4g3+DOE4iw95B5L6i4qgDH/lZghAIzf21seMwg/6/NimT0tf+okmnCF5GXR5a/2fypA+DKJqc0ajE9EdL3hQ3/cY217brFq4kn0GWoFxKlEwp6wAa1X7hF1DhrojazT64hh9v6QYLn7KK1atneVWnn/bImZRPw29k2pKvvG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CRjAlYeZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so1955e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048466; x=1741653266; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bG550rzrzIBBMoJfqzs4YIM+0VCYBaHeDhMgO7U7ULw=;
        b=CRjAlYeZrCSoZWtVc5tnUm6+jv/XBfdQkNeSCRUoFRggJYHRYKXp/Vq3ffiiibQvo0
         XCBnBqIGO1gYrXi60BiBPShln1JyivLUQgfpeh7qatKr9PzwOIeUNCqIa119+Sk9JIox
         UPPLExqCTiSBfVQw3HEtrn73fv7zt5U7sgeSrTVHHtrlm4Y95NJAVDmFgTi42dthIeS0
         1YG6uXi+uyomyxpsFudjj4rut4+46cw0hqux/lXcQdUnej2cfcpdVfOFdi4S5t8BfKAK
         2AG/o2YXVzeC9nqo6/NPaz9VWVPD2WhdNeyPVIDMQNYvNQCrQQo0LpQDunbUdWs4qK08
         +NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048466; x=1741653266;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bG550rzrzIBBMoJfqzs4YIM+0VCYBaHeDhMgO7U7ULw=;
        b=JuMOkt6N61l7wovNvRkJ0bsP4bfZhQWPV6eDhPHbiIqCR5LCvcXu5QSkI3yVRfVglj
         VvHydc4YxMJnC/WoF3Wy0YRRoE5RgNk3LPdSD3OjHHypeFEWZkieRcCM5/BZB3Q6qwmn
         ZuDzUyW1hNRvlZ9ju/RiLVqPEsaTjaEUYZ9b1hYvL5sDmDqy9GT+sMFFBn0lKmtNXfvB
         HYIUm8MUbXQz+5Vc7jSELTs6kDKrjtrtA9Tcz/Gyj+wpfri3FE07WBu0EQJaE77w+Llf
         4H/nPStFhHOf7lshu7lt+0bRAUAvTlERXaVEMtDgeQFr3USKZxmQe4euBzcUE6wcHGKP
         rTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWF1Pgc4BmT7dP11zHAsqgl9SvkqrcdzdcBydRGm9VXOW1L6Cbsc5nzXdDoZ6AVYwr7r5OBIDIq/zNGH9nFwAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnB3wLrCeevquA40MMeSnNbYVyDyjqog1tWZHNAdSXtnjOfj5c
	nhX0AZtynsaST0QOUS0+MbkmFcwSoWhzl31dKhbpRmhu0MsOFgx2My9Ur4f1jvc=
X-Gm-Gg: ASbGnctgROyjWk2NmOMf/XvCPAJLYQVe2YgWBiH0HD8mZa4D7aXidG4+KbUOLpk2uP8
	H+QWRihOUQidQZFeOZVYPfpKCySnguWnLCtJ5Ufqg+bq3JKTZB1ridOL3zwgVXpKEshtOOTkEmO
	Y7SY+XPF0IK4dY6eGjsWYlaKaAMVK85ZIM4fPoKkPPm27THZ7byFRSeXMLI8ZTxlRxoJAwl9TjK
	DPz8tBAM309ggNxVt17lbH41TGcgIIJbDtpPaLd+ixBZD+ZX5izDs1w4Qei2QYeb/MaYBIyvCCl
	luHjjKH5n376ZXvSaGVplugrYtpg3ndm1k/2re12TA==
X-Google-Smtp-Source: AGHT+IEEHP4rL3Sj1+GYE7Fo6ygWB0QcyraLE1NGXG/wp+tc287QqK8dlK7mdnK/MWMZmvzdWi8b6w==
X-Received: by 2002:a5d:64a6:0:b0:38d:d299:709f with SMTP id ffacd0b85a97d-390eca80553mr13646978f8f.48.1741048465914;
        Mon, 03 Mar 2025 16:34:25 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:25 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH v21 00/24] Introducing OpenVPN Data Channel Offload
Date: Tue, 04 Mar 2025 01:33:30 +0100
Message-Id: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpKxmcC/x2MzQrCMBAGX6Xs2YX8tFZ9FfGQ1E+7B7chCaVQ+
 u5GjzMws1NBFhS6dTtlrFJk0QbOnjqa5qBvsDybIGfcYLzpOfa8rEm5fhLbwfvxivFyNp5akTJ
 esv1390fjGAo45qDT/HsoKiu2ysnScXwBduW4InwAAAA=
X-Change-ID: 20250304-b4-ovpn-tmp-153379e78603
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6776; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=TLKjbM01ue0nby1SWB0flz5kAYA3S3BxIQ/QF7KTRQo=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOnHvDp2RIvu1opfq/0nV0pdmD9jvsqLDf5GjrzSP+cor
 r4keTqtk9GYhYGRg0FWTJFl5uo7OT+uCD25F3/gD8wgViaQKQxcnAIwkQpnDoYFXNwXxOdl+TYf
 9hV2jI/QOCJWzPFNfkFs9lvnrQf3J9V3XC6++VOX8c6aA3w5uf5cb41E+jzebC/ul0q5n6ii89p
 cbOaroDJmzjsOCQqZcxtm+0j7HKjWT2R3/N9yKJHT/dXliBaX/zf3dDAlc0ZEmyzRauha+utw8p
 4e/4tMEsm/tjlt6DpstV2AfXt8hdvSZzpx7M5OU6+LTVf5p+CcG97x8XhpcXzpiZeu1q1Pd/zty
 Sk8cSmkKjTikSNvc6X89vpFPYKzN25TCFjiUeB79kudxx7T7S9aCycvXeQata22etnNPZdOc17Y
 zKnEspnJLHSWvL5+fOW+ZfvnTaiYlVV2Zpr/V9k6oSBnAA==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v20:
* removed newline at the end of message in NL_SET_ERR_MSG_FMT_MOD
* dropped udp_init() and related build_protos() and directly use
  .encap_destroy [instead of overriding sk->close()]
* defered peer_del() call to worker in case of transport errors, as
  we may be in non-sleepable context
* used kfree() instead of kfree_rcu() when releasing socket as we
  just invoked synchronize_rcu()
* fix comment in ovpn_tcp_parse()
* invoked peer->tcp.sk_cb.prot->release_cb instead of explicitly
  calling tcp_release_cb. This way we don't need to export it again
* moved call to peer_put() after call to peer->tcp.sk_cb.prot->close
* moved switch(mode) inside ovpn_peers_free()
* simplified skip logic in ovpn_peers_free()
* fixed check to avoid passing a negative delay to keepalive's
  schedule_work()

Please note that some patches were already reviewed/tested by a few
people. These patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/ovpn-net-next

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

To: netdev@vger.kernel.org
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
To: Shuah Khan <shuah@kernel.org>
To: sd@queasysnail.net
To: ryazanov.s.a@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
Antonio Quartulli (24):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ovpn: implement TCP transport
      skb: implement skb_send_sock_locked_with_flags()
      ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local UDP endpoint
      ovpn: add support for peer floating
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  371 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  408 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1249 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1352 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  244 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  592 +++++
 drivers/net/ovpn/tcp.h                             |   36 +
 drivers/net/ovpn/udp.c                             |  442 ++++
 drivers/net/ovpn/udp.h                             |   25 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  110 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 net/ipv6/udp.c                                     |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   31 +
 tools/testing/selftests/net/ovpn/common.sh         |   92 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2395 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  113 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 57 files changed, 10065 insertions(+), 5 deletions(-)
---
base-commit: fb05579a176f7bccc8d279665fc0e46dfed43dfb
change-id: 20250304-b4-ovpn-tmp-153379e78603

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


