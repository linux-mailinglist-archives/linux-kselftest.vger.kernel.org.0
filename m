Return-Path: <linux-kselftest+bounces-28842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1BA5E5A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6143B4A48
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0741EF08D;
	Wed, 12 Mar 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FlgphGCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE821EE7A7
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812868; cv=none; b=lNKOoCGHL95zXih/X+6cHpaQhZdGjquW1efrCYmvECCSYQbEyyeTKczVygP1dq2tsj/uY9cSFp2uXLW/zG1LDKNNL0Ni5i9/aIfSetylJqoS8n6OlZy9q3+lkO5VIELQsGpLsyFmp4UDnwYOJVe86zQdv74flco3E/psXt9H5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812868; c=relaxed/simple;
	bh=btfUg9oN/41pa1YWzUjIaz5WlLO8+85KPov2UHEXegA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T4JZODHTxILq6D628UmbhKywC0EjNJGqNLpYk7+tAsXnqWTFjzEODwfYCS7FfQ2E9cHd0q9ocCYoGJsWevEJXenRfW6/fq4yV8rCU4dTT8u9Jp8h5qIbMP6RNlsHSEbwt8DdNeDxMs9md/xGSMpdJWTy4Cf1iBPjtXigUIsuPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FlgphGCv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso160877f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812862; x=1742417662; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mu9aU3RhbhiiPRRBIrIvRz3NXn+xxfCXiuCg5n6gHrA=;
        b=FlgphGCvNWc/aFbJCBzwaZqhwEYmurbvlFffTiVheHT8SXB5MTFnh7d5ekl/wkd/LQ
         hjNakUtBc5Y02M7R4qgkfgVKirlnLat7hcgq8CVi15OSd9lfRxpn55gCnPBbFvofbTHp
         COu0y0R6l1xoBGZJOwiO8U6s7pAjVnQJhru/vAxVhq4NBe6jaitdHvfDmxcpbh3IdS+s
         WXORo6bZFx1So87LjLJ89440CWWVv/qGZfVOYwPILBH7XPrvWY0YVuInfUReKKU9nx8a
         i6RRQ58vmi/w5lVV7Gmwq0jWYOAaJiorYlJxh1wDrXzIsQ5VtmWVi/aLu3H/H+9vbhZa
         xBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812862; x=1742417662;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu9aU3RhbhiiPRRBIrIvRz3NXn+xxfCXiuCg5n6gHrA=;
        b=AW5CuSH5oClU0lVaXT+n/H0i3bUEPcPk18YPZ56lIwWc0NX/GAZLyBDD1cQLPe48s0
         TZ3PzxLNdknkbE/Rt35Wu6lrkshiFzeBrj9lj0MqBcN1U0UNcYtWYk+lhWhLAFFuDoDj
         WX8rrCaA6KZko9xwR+Cu5riSqMrYY3UnSWZYN28kFF/3f8xEK8Z5rA83OQG+tALBPrn8
         ZfonzFAx2qucnqn3uCBL5uGcSp6vZWOtVZNYrtberXa+5qr2OglCksuJr5WWcnBAgDxV
         Kx3tVbscLyg5Ofsgwrv6lWcMFNpWdv2OTC5ISLTIOuXpuSh8iBPL5YptMJ4uWErNFRjC
         hK7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBNz7co4LdvbBWMUVclUZSB8jQbuTQnmaUMKQ16GcsonVnw2yd70CS4+res0RuBiAh/dMjnEIP2ejtDgOSom8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTEQGnX2FDtFbN19vtVLvD3DlMqSSQnzzt2PW/+asdKkEjj9E
	UnhL9W9T2vPR1aSF1Te+hhMgzg8feGM/U/8u/m/kspZkwkxwant3vVjzBOftg1U=
X-Gm-Gg: ASbGncuZZ7Xg/W16LSXgYwY8205idA+R2hDLQV8ttu5XyNFKLZU6KKrr7QGY1LhkXwD
	VIBjxB0xmwo+s961OoxltFOPTKaUqOMS8esl9p5cBxAK5Z+gIPpZQ1ELLBKg3rtbvh3kIW8lD/a
	Qyow7wCYpmESUb7S5Lrq+XVniaTn+IbN1N2ZBHoDA+aZ4/moa9aShZmRvKy1b5t3Ec3nec/myca
	7BY7j7CPFXRoWDn9IE37tcWc2OtIzNwSAZUyNh9V5SLJREo9W9t2fOH/lQE9xiw/JX0RxSrN3f6
	cL7f0KBsaqx653Fq7P2veK6PU1ow/HrztGOlSUNEMQ==
X-Google-Smtp-Source: AGHT+IEdk03aZVfpQXE4Swl6cc0KDrhC9OdIosfNWjX7yjLs03l0krXYsixVoKLL1PV+QrEd6iZbEQ==
X-Received: by 2002:a05:6000:18a3:b0:391:2e19:9ab with SMTP id ffacd0b85a97d-39132da8e5dmr18015410f8f.47.1741812862498;
        Wed, 12 Mar 2025 13:54:22 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v23 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Wed, 12 Mar 2025 21:54:09 +0100
Message-Id: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHH00WcC/23SzW7DIAwH8Fepch4b2HyEnfYe0w4QzJrDkiqpo
 k5V331Opi5UIzdifv4D8rWZaeppbl4P12aipZ/7ceAF4NOh6Y5h+CTRJ/7RgAStpAQRtRiX0yC
 IPzSd9TpAw7tPE+X+srV6bwY6i4Eu5+aDKzHMJOIUhu64drrXXr5CP6zy2M/ncfrezrD4zf+mK
 fuXtnghRQiRfAIwIZm38UQDV5653ZayKFlQMDtVkm1snUHpnIvkKlaV1hdWsU2krW87hwFqubB
 bKB6IC2wBfc4OMWZfy8XSFtdVyNa6HHUkay1BxerSlmfWbCmAxi4rq1Ut1xSW77hbwxaVJuhCk
 la1FWtLW+ba1RJKqZRB22LFurs1vEkW1rHVLgI6R8aqmm1Li4Vt2aosZYq+g5hsxfrdPt53nav
 WJpNChqBd+G9BFhbcbmGdK48ZLaKSLeqKhd1imQvbbEQX+TjG8EM+2tvt9gPG4rmBmwMAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5956; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=btfUg9oN/41pa1YWzUjIaz5WlLO8+85KPov2UHEXegA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR15cJY46a/p5rdV6aVCiS2OBZjW6gOMR+2d
 s5KAWfQO5eJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0dQAKCRALcOU6oDjV
 h/boCACHZdc8O+4ulqEEXQrx9KChx+9MBtTOKR3yrEfWaR+xHNWWYezrLSJL4+lLIHHXaoTuj7w
 OzHSiDJBF8HxIPgO+t/q35HIW1pp0DDIX5TGBIaWpv7UyhKGetUzQduwiO8W5F9/seSvZ7caEHO
 X0s7B/mmyDVwIgIuGtPFjLQy7ymHUvMImpsoOalyPXHBCrb82vlEtGNRPfKUQHbRuIawQoW7OkO
 udg1BDo6ovtd881jYV8PZV78Y6FesuLI9ydLj5hyvCIRMqy6aaUVhbfBMv9tMM3UgF2rgF+fLi/
 MUIWy9tftIQrjPWk0FqcR7gvvlA9gponGi+bUODWuv00P4MC
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v22:
* ensure local endpoint is copied only if one is specified (compile
  error)

Notable changes since v21:
* accessed crypto_slot->primary_idx via READ/WRITE_ONCE
* made ovpn_aead_init() static
* converted link tx/rx packet counters from u32 to to uint
* ensured all u32 NL attributes are read by nla_get_u32()
* ensured all u32 NL attrivutes are written by nla_put_u32()
* reset cache upon float or local endpoint change
* dropped check for delta > 0 in keepalive worker scheduling
* improved comments in update endpoints logic
* converted local_ip to void* to avoid useless casts

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
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1249 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1367 +++++++++++
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
 57 files changed, 10072 insertions(+), 5 deletions(-)
---
base-commit: 40587f749df216889163dd6e02d88ad53e759e66
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


