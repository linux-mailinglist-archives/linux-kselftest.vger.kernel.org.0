Return-Path: <linux-kselftest+bounces-29307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E26A6654B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1917BE5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92316EB7C;
	Tue, 18 Mar 2025 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fhnpRFz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D89460
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262067; cv=none; b=f916tOY9nlUtev5NEylGmzHKNfLCC5yfjYDYGrN+e+qZBtyqqMdwZdIXPMkH6SMdOuduYu+m0PNN1+aoS/44JCHZyzFM57XO99idTv+gqwW40BI22eQId/cjU1GW6LZW9nkajPJYrcjpfNaie034a0X32thsCZTwuL3N0KDQsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262067; c=relaxed/simple;
	bh=lZjQFJf4KrJVA4ZokHoyxvqs3+XXXnNqrO/mvFvHJWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YzTEiyxWJUk9Wvv/kZJNgKUkrC3KDHrUtI5yXK7AtjNSuipLmBfNlxrZbzf3r1yAV1bde3xytGCYBBk0MHJDu59Lbp9umacuyCcunjo32HfjCJmkp49jezckdjI6wrpHsvzc41DFpbXVUtrVJP4RI5pe2JR7s7PKbLjA9TE9S0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fhnpRFz8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4432237f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262061; x=1742866861; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwTvbhiSVruiWTt91YZCJXHYLSc3gULxZZJTdGLD1og=;
        b=fhnpRFz8g8et4K90uLrCty06q/KRTqPoO9cm/FvUNqJ1Q77Xo5vJOeQRHuek2pZwEu
         Vk0BbfVEem1NdBwApRvahodqHl2789SRVJN+XF7lctgzChwJXrOqQMH+8vyOs69PjgNt
         GDhGNXlngfhuj/y25jUos7Ix1HbOg35siXSYeQvl4xqyT8zhCdp31kxMKGDjAoDM8uvN
         MQmtQr1cHG34bdxjCJRdP4QtWwldW6/eFxA1eEicnWLtBhQ9wySKIzfF2ISjw9JznhHy
         DyHaTu54AvEJtxp/LcUS8sRLPJHMyDcKHmLwgoD5pn9t1o+dxHUuhKtZWTQAuWc8xe08
         o+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262061; x=1742866861;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwTvbhiSVruiWTt91YZCJXHYLSc3gULxZZJTdGLD1og=;
        b=KAnIuc0MvNgeaq2wZ0XC0bW8rwv257p+DvP8jufr2R+jp/Rhm4kX3nmX8bwe0+hPXc
         hUgvARalyaf9jWKGe56xGrGhhmBtPCG1FaMPLZ1ozOuaPYySg+Ae/8FrVfwlc5Sr/ivs
         Q5vBVbb+6isW6qFmpW9LP6rFbYiTgUcp5pEu3ww/icwuw63+0xd/KYj4NmPZK3OdiBxC
         y/vrbU0VtpNp0agR1yUz1zKiM+jIiCUKAN6/CcrA67tRrRUQaBhPSmKBLnKPhtG9mhP4
         wA3zGCCNfKhBlVlzD/H7D/MxarStD/aKbluEr3SSt0nuudFiw/iZSjrYQ1XqzsXX5Yzc
         xU2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZvZab8JvMS9y2vQMuIOMHT5p7WP948dqxuSZ4wBopzq57ZdF1pIivPC22Be7dh2njOhNqiYPZ5PwjCmrxDIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG0TqL1ZDmOFPz+V8KOdS2v2e72nT7ap+figbP+7GwbDfSAFy
	x05V75jAIZ7Gz9/7iWs5MDH8PDYpWZT7TsAQUhjCck8iZtul829wcyXm/GVuemUxxFMrgj8KEkq
	7W733cZchz9QW6c58NU1IE95KmnwYekXE5FOZxDYWdS610msZpWw+JRBo/A0=
X-Gm-Gg: ASbGncvD8MJITEj8n2+hVs4VrkINPDXU/Unzpx2m7D2dJTwqQuuwIldJ3cOoSPyZiVI
	UPCmESUbSY4bFDGd6v3IGyOQ/a9pcgsKJYDx8XD8CdYgb6aLy8asWo44XtGRqdkOxPf/xHmmrgG
	ZN4mrbcI4YmAgqgzam4tA/m4fFndeKtRHX96jEFmVPhyttu6v8pjVe4djPe6F3aosl7P1Kbu95K
	OEicXuZ9v5DctD/Y49DRSK9nbnlC4oWw9LdOJVxJBLCxYhBJ98sZoFpKl2C/1CnwB4sJI4+d1YB
	vQv9PViXibXSu8Bu2UFoMdK8up+OW4zOXyXJTQNplw==
X-Google-Smtp-Source: AGHT+IFqJXpl5w87iGlMxZrWukzDo3uX1kpXNeLOAuiSlj+OOo4AfW5bpYwJedsQVKLMYee4KTBJ3w==
X-Received: by 2002:adf:9b96:0:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-3971ee43798mr11803190f8f.43.1742262060655;
        Mon, 17 Mar 2025 18:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v24 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Tue, 18 Mar 2025 02:40:35 +0100
Message-Id: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPP2GcC/23SwW7cIBAG4FeJfK5TmIHB9NT3qHoAM3R9qHdlr
 6xU0b57x44STxR8w8PHP6B57VZeJl67H0+v3cLbtE7XWRbgvj114yXNf7ifivzowICzxkCfXX/
 dbnPP8qEfKboEney+LVynl+OoX93M937ml3v3Wyo5rdznJc3jZT/pvfb9b5rmXV6m9X5d/h09b
 PHwb2mWPtK22Js+pcyxAPhU/M/rjWepPMtxR8pmjaLgT2qN2DwEjyaEkDk0rNU2KmvFFnYUhzF
 gglYunBbUA0lBLGCsNSDmGlu5qK26rkWxFGp2mYmIoWGdtrpnJ5YTOByrJWdbuV5ZueNpvVi0j
 mFMxZAdGpa01bm0W0ZjrPVIAzZseLdeNhllg1gXMmAI7Mm27KAtKjuItdWYkuMIuVDDxtN+vu8
 +VwMVX1KF5EL6asEoC+G0sM9VxIqEaM2ArmHhtKhz4ZiNHLK04708ZMOitmquYJ+NQIYojyahG
 T/bx+PxH8VPjxXXAwAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5729; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=lZjQFJf4KrJVA4ZokHoyxvqs3+XXXnNqrO/mvFvHJWo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8pXbdagjfILa6AELrrbTvER4XIMN5BB5JXu
 8BKsbrXcSKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKQAKCRALcOU6oDjV
 h768B/9wIqsm919+AFAAYns8BQU5B6ZKVUUQcwgG6qOnvMspVEPYeHXHTlpREJN8/RY0BZHT1Qt
 nOyCk+UKFn5gy8MRI+Xzq5D0Ixz4RJoB/SAUnnRa7deb38Be9S6rfNsYLwaz2To1S15M8ZUmige
 tM2jN9IptQU6IyeynVIPySW7Bv5KS0l64VQySkSXrcJ3WIpiJl4FRuprbpBxgFqkWGuzDXh2ZTW
 bpO/4i9s3hYkQvEgWVuSGjzX6cB7K8ntOYEOHSq6o1WL594QLj8YqC/T4syZZmchlgXOjRT/GRO
 a3Ng5QnODH80SaLHcmTi80ZZF3551Ojk6zUEO+eHgNGhPTiP
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v23:
* dropped call to netif_tx_start/stop_all_queues()
* dropped NETIF_F_HW_CSUM and NETIF_F_RXCSUM dev flags
* dropped conditional call to skb_checksum_help() due to the point above
* added call to dst_cache_reset() in nl_peer_modify()
* dropped obsolete comment in ovpn_peer_keepalive_work()
* reversed scheduling delay computation in ovpn_peer_keepalive_work()

Please note that some patches were already reviewed/tested by a few
people. These patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/ovpn-net-next

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (23):
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
      ovpn: add support for updating local or remote UDP endpoint
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  367 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  409 ++++
 drivers/net/ovpn/crypto_aead.h                     |   29 +
 drivers/net/ovpn/io.c                              |  455 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  330 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1250 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1364 +++++++++++
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
 include/uapi/linux/ovpn.h                          |  109 +
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
 57 files changed, 10054 insertions(+), 5 deletions(-)
---
base-commit: 702e3fa16cd42ba712825e8d6171ea4755bc0491
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


