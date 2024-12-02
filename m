Return-Path: <linux-kselftest+bounces-22704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A378C9E06B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B4A285D8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E6205AC8;
	Mon,  2 Dec 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HRzG5eM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02E20B7F4
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152381; cv=none; b=bYGWIUixE8WL00HwjCsBWZ66XKa8V9jHcPTIRmA0/bo01DX/B3ZpT2WNh2gdcTH1mcbBssaSmyyW4VaV5KDzYbOypKcvhaDZviwEEhgEvve919NqaVSCX+Oj5cXcBR7TXh4lFPfyK/GQJDTHugaZVNLy4lUaqubPaBtNql5WiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152381; c=relaxed/simple;
	bh=ULd7HLAMrEU7KV6BqeoOuhpswSv5u3Bnny0RKVYK8Ng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TLXaoX1JFx/WCXFGDBHMvaQPH+obQSrHc52wxWuhwB6qalJAVytgqID06KxYHtWoXkQ+Zy0NmDCRhr5r4FlB/qt3ofqzLNPPnNvdzOxQOnpU33NoQKnETh/ZFGhFdnuc48299QIrwjWsd5Q1XO67xGoz9ox/FbBL1ZXBs8mI3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HRzG5eM+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434aa472617so37099195e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152377; x=1733757177; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Vd3gVYNjuhRJ+EkLKPYA3SrVkjNuvOGctsJlVkSZc=;
        b=HRzG5eM+rN3bEC5c9dngv6nbaeQY7uLvTsdETQRds75SrFdB94PtHryguNk8Z0W03Z
         BoBS4cNgEVo0UozbUwRa7NhkMKBj4h4dJ9z56toFbKIoHfRS1wXEBTnebinaOOx2zuPK
         SA04Jd/sihV6yYsT+kR+OQ38zY7ZwpMVGRRdZgSJrTWyuH1U/fvMjcmBAOkFe+tdC/d7
         AVLicmSagsOFl5OYrA5KmldpBzG0Imnx9pXldWMYWynFdYPizllTgi89ldinJzGMljX/
         Wh/KH7oSCAAUVoGNfNTtAOcdVBSeBOxz62YlmuqJbdbOwj6ezCkFb6Zs3546C7EXm/fX
         WKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152377; x=1733757177;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Vd3gVYNjuhRJ+EkLKPYA3SrVkjNuvOGctsJlVkSZc=;
        b=ETrc3iBXxDuXgorhnjw5bxaHTyn+qtkX+bKK44iwRYI1rYzj17K9ROd9InokxuGOwY
         S8JMH8gZ2XyB1AJthwCogNXIKCHiKUW6/SXihYAsoKJhra2eFLhrOF7R0Pkz9nw1SFxa
         B7Gm5gFnkdk43PxXyEAteHw5fZ1M50B9GtRuGBgiE+a+DIhBbhATuJt/yUWbhLtDqwko
         BABpYflhBY8EZdaf8tU5hM0QYZY+wTOw95+tKKEbiKv0oVzCOq0vjvRb3L4JIPWXXdvD
         gIg6I09bqp+stGOp/RKx43PB8KKKbTiljop+MWt31ElWhfM/V7PMHUomKA8OAsFu/Dky
         wcOg==
X-Forwarded-Encrypted: i=1; AJvYcCV4roMTfH7UgiXsNt1hhypEabBW1rnwrp6nB11fdruNkPvb5pjDl5Du2Sdl2hknkY5FsIV6lmSWlqItgk9dV0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBqNT9vVplz6NrsdBHKJdNt5dlnfSJXIz2r1He23tCF7bB5Tt
	OKSRrnEMbHEQum9IEShSpCLwSEz7dhgz50uhdu2DmdwFXu/+a5t0JkwlA8V/2ixJxAP+UJvYXwF
	Y
X-Gm-Gg: ASbGncvHDkcEAlJI9bYHAln5gIKHo9Ub5xKu3UEkfj6FTbRe3PWNND8DiKXsqtupICx
	d/o1I3W1SN3gn7kiNwGPB2rtssAWIPFF9yUCRdSQflhxBBXBiikwfaIc+Z/y/PJDQW776pJkKR/
	ZlMaJuNrS/VZSUgJtn/wY5Y4+LY44SVmi/j1++mpyrennM0nArw+v/yXZXMZeejvWwgVwcyAX51
	f1SiJ3etM+m+9pjalSTIJk7HfJVLBF0okgpbuEvP8meSX4TZr/Mk0asaz+F
X-Google-Smtp-Source: AGHT+IE1uYOTAQ0IMw5NkWgDzQJ6v/yYNyBXMjiLK3pFzxx7xamPLm91YqcBWW5q4Jp56fgd2QVPQg==
X-Received: by 2002:a05:6000:178a:b0:382:4b52:ffcc with SMTP id ffacd0b85a97d-385c6bab0ecmr20106790f8f.0.1733152067519;
        Mon, 02 Dec 2024 07:07:47 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:07:46 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v12 00/22] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 02 Dec 2024 16:07:18 +0100
Message-Id: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbNTWcC/22OQW7DIBBFrxKxLgmMjQlZ5R5VF4M9iVkEW2AhV
 5Hv3omjpFbV2TGf99/cRaYUKIvT7i4SlZDDEPmh4WMn2h7jlWToeCFAQa2VAulrOZQxSuKpTNu
 4GkHw7zHRJcxr1aeINMlI8yS+OPGYSfqEse0fTa/scMMQH2Qf8jSk7/WG4lb+adPN21acVBLRk
 +sADHbmPIwUOdlz3WopWm1QML+oVsz6ozWVstZ6sv+wesu6DauZ7ahu3LG1FcIf77IsPwYAsrh
 DAQAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8057; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ULd7HLAMrEU7KV6BqeoOuhpswSv5u3Bnny0RKVYK8Ng=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1hiB9ATBpF0pj/Q883zgoCjJtMeRKvIVWHw
 CS8ODLAB3iJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NYQAKCRALcOU6oDjV
 h/04B/4/WGk8gs11+J7Pvs9EYOjDNT2oP9GIBG4svwm6iAHgIx/3lRVR2KQmklrXWWUNQPvmIXe
 5u4WBvNb53axTi2XiXaMfuN+FafHtLEhZWENz1Bl0jHmXtDkvg/Olza8TPbjLQXIPBA6ow9guXf
 EUdQi+6b2lIobbPIY3k0qo0Hwq3dP741aRoFVFlPAOxmHJETAtbIWkjrbxPDMYsGIwIHigNwAI/
 IFGT3YbubQFz9hAtPp0Ziej7YhE6uDsKGh7CvNN8WUnXV1tuqUn8I3l8sDKud+BQG+ymyDgkMPi
 E4nOjhrUhwwApXMCSfongzgzagMLtrFj3JYTiSL+KYpM6X+w
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This is the 12th version of the patchset.
Hopefully there are no major flaws that will require more resendings.
I am sure we'll have plenty of time to polish up all bells and whistles
:-)

@Sergey, at the end I think I took in all your suggested changes, maybe
with some adaptations.

Notable changes from v11:
* move 'select' entries in Kconfig from patch 1 to where those deps are
  used
* mark mailing list as subscribers-only in MAINTAINERS file
* check iface validity against net_device_ops instead of ndo_start_xmit
* drop DRV_ defines in favour of literals
* use "ovpn" literal instead of OVPN_FAMILY_NAME in code that is not
  netlink related
* delete all peers on ifdown (new del-peer reason added accordingly)
* don't allow adding new peers if iface is down
* clarified uniqueness of IDs in netlink spec
* renamed ovpn_struct to ovpn_priv
* removed packet.h and moved content to proto.h
* fixed overhead/head_room calculation
* dropped unused ovpn_priv.dev_list member
* ensured all defines are prefixed with OVPN_
* kept carrier on only for MP mode
* carrier in P2P mode goes on/off when peer is added/deleted
* dropped skb_protocol_to_family() in favour of checking skb->protocol
  directly
* dropped ovpn_priv.peers.lock in favour of ovpn_priv.lock
* dropped error message in case of packet with unknown ID
* dropped sanity check in udp socket attach function
* made ovpn_peer_skb_to_sockaddr() return sockaddr len to simplify code
* dropped __must_hold() in favour of lockdep_assert_held()
* with TCP patch ovpn_socket now holds reference to ovpn_priv (UDP) or
  ovpn_peer (TCP) to prevent use-after-free of peer in TCP code and to
  force cleanup code to wait for TCP scheduled work
* ovpn_peer release refactored in two steps to allow implementing
  previous point (reference to socket is now dropped in first step,
  instead of kref callback)
* dropped all mentions of __func__ in messages
* moved introduction of UDP_ENCAP_OVPNINUDP from patch 1 to related patch
* properly update vpn and link statistics at right time instead of same
  spot
* properly checked skb head size before accessing ipv6 header in
  ovpn_ip_check_protocol()
* merged ovpn_peer_update_local_endpoint() and ovpn_peer_float()
* properly locked peer collection when rehashing upon peer float
* used netdev_name() when possible for printing iface name
* destroyed dst_cache only upon final peer release
* used bitfield APIs for opcode parsing and creation
* dropped struct ovpn_nonce_tail in favour of using u8[] directly
* added comment about skb_reset_network_header() placement
* added locking around peer->bind modifications
* added TCP out_queue to stash data skbs when socket is owned by user
  (to be sent out upon sock release)
* added call to barrier() in TCP socket release
* fixed hlist nulls lookup by adding loop restart
* used WRITE/READ_ONCE with last_recv/sent
* stopped counting keepalive msgs as dropped packets
* improved ovpn_nl_peer_precheck() to account for mixed v4mapped IPv6
* rehash peer after PEER_SET only in MP mode
  addresses
* added iface teardown check to kselftest script
* Link to v11: https://lore.kernel.org/r/20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net

Please note that some patches were already reviewed by Andre Lunn,
Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
since no major code modification has happened since the review.

Patch 

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (22):
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

 Documentation/netlink/specs/ovpn.yaml              |  368 +++
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   14 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  383 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  212 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1178 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   57 +
 drivers/net/ovpn/peer.c                            | 1278 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   58 +
 drivers/net/ovpn/socket.c                          |  180 ++
 drivers/net/ovpn/socket.h                          |   55 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  579 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  397 ++++
 drivers/net/ovpn/udp.h                             |   23 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  110 +
 include/uapi/linux/udp.h                           |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  182 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 49 files changed, 9601 insertions(+)
---
base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


