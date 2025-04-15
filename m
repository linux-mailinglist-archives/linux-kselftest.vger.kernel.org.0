Return-Path: <linux-kselftest+bounces-30839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D093A89BD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918E37A8CF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853C29114F;
	Tue, 15 Apr 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PDJN4S+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D42750F6
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715848; cv=none; b=XEA/c3uLu+Vx7R5PqDSvqq+mcd0kMI3l/dLDkXZr57RLnY3LXK47Ei5lSKmzWCsFDroaF/pZpNU18mIZbpz0vlcdUazaEgvGBY7OUpHyB/hyHyqn8FoVAInJ172VQLjWrxAWtvYTbMu6h3sdq4++dxcR4CjcQmtvRIM5aB6afZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715848; c=relaxed/simple;
	bh=sbPpTxry5CCWgCtr+UU4GRpcbBqdyzYfZMNI3mWxfi8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=izEBY2KEy4wdkRtrKxYZFl6XzmynqL7xXLRIdbdGqwfphuNYG1oz85iVkzqj92BpTuEuYLHrshWFF0CpkhuLu3ZkIHyh8gVjEzXlHPl7I4Qt5Fc6371DhdfU795NCk9y2pe/9FTwKKlDkwHu5zeSyxstl8h8yK8RKRQgfckXcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PDJN4S+/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so25816795e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715844; x=1745320644; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Qm4j9KsG2eHl8DeWF2MtlUuYQtO7vUGh3ZldUh2lk=;
        b=PDJN4S+/FuIi+FKJGlIAPxWK+urlpY8rCtwugz9XmJm+NSsHK+4Qn0vsc8g5eQoSxj
         KrBl/PHprt5ns2IOSDkIk3kcD4h0NBgKSt7FyMMmtVnMBlrmk+Blug5jg81a0oRehme2
         Cn1wRGvgH2lejMx5kGBV1WRr2KTzOJ6BYrIXv+34onFdnXrSEd4jRWKL2KFFJ2wnENVZ
         dSMG4bazNNj0M7ZdilsxFYRIuYYTRDQI81yUFYfsSYJesNwjaF51c1WpifiiJLE/hprl
         j03cgeUt434GGzF7HbihKFPX99ETYh81ibmCL0tYozYcWx5fL7kieMa0Hv7+GNq9QpKb
         Cnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715844; x=1745320644;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/Qm4j9KsG2eHl8DeWF2MtlUuYQtO7vUGh3ZldUh2lk=;
        b=fHHzfOEqX28GvVQa2FjgK0FE9oHYX/WatSp1QHqJGwe4LqDJbo9zSKgszFav91pLSK
         iuuGTx1sQjdr2BcZb4KIOjqzcekD809QkLNzFpwGxybarPjityH11YeM1H8cQq/FnVgc
         K7jLjEKpHuajRgIrB7F3adx8pOmsNQmIWBZtHuCh5ZGcnEzUIQzMl9A6rXP5rD++vQjE
         Ttz4xFO6/GtRMysRg/zM/R1m2u+Y+0lbBujA7/OwHtGXDTVPd0C+aiiD1vJu34prNUKP
         a4cmrAlID0Z5YdvdilbY3wZGsfvAH4MS7fzrB3A16hoWfiijJQwEf8RoNCpnMBhEhSWn
         5veA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+lR5y5gatu0p2E4AGlXyZezEvkHzxwQsn75LFBVOFLh2Vwx5FmQYKhYif9J8Nldq1HTssfhJ47MHhaXTVzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyspdbT6Dc04QR8JVoI1WTCTtX9ZFCFe0Qx0DFsjGnI8TCTsD
	MIe45yPUtjWyFFgg5B26S4+DJTuzJdfVHW5KmaemQl3HzshY44DJ9J04+/C2B8TeXKP9ij/gWh7
	iXvAl9dP+nUEK2NSN47Rxc1/BIgX8dyeWYGpYxzmCs8icb7vjAwvPU5kQwvs=
X-Gm-Gg: ASbGnctvpFOgMwnXMQ6b5I57nPHTUWkopmTP06HqfL/YTnhXGLT8DvaluhrKaIqne6q
	ayBHL0zCLbFDevNkbLju+mk+tRxy/tG/FhivMlEgcNptH29D7Ct6P/iRpI65w0u66gxwKIZeg3Z
	tyJqF8vcmi2fFF4h8wRXwbREWIgqLqM2n0Luxi4F55lGA3rba2iC6PXIEMrq4AqP/OZ4EcIhBfP
	PeVRe+uphZdGApCa5ofTvataysHqZOVoYmkp230N6oJhEFakS5QxpzEkeIboN1Yu8gEw/93Sg4U
	OOp0qRfi31xPyYYKgtfASDuJPfoTPmyEdrCZng==
X-Google-Smtp-Source: AGHT+IH8yYoWVII6khS8h+8sQrhGDyrAVixpdkgGu86G1KHIs6yNIq2UX7dgcv4T5GReTr0+Klgzgg==
X-Received: by 2002:a05:600c:500e:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43f3a93ca20mr168689935e9.10.1744715844527;
        Tue, 15 Apr 2025 04:17:24 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Tue, 15 Apr 2025 13:17:17 +0200
Message-Id: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1A/mcC/23TwY6cMAwG4FdZcS6tYycO6anvUfWQBNPhUGYEo
 9FWq3n3GqotXjUckCD58sfBvHWbrLNs3deXt26Vx7zN10UfkD+9dPWSl5/Sz6O+6BDQOwDsi++
 vj9vSi14UKiefsdPZt1Wm+fVY6nu3yL1f5PXe/dCRkjfpy5qXetlXeh/78ivPyy4v83a/rr+PP
 TzS4f+mOf6X9kg99DkXSSNiyGP4dr3JoiOfdbkj5eHAUAwndaC2DDEQxBiLxIZ11iZjndpRPKe
 hRsrYysXTojkgHVCLlKYpEpUptXLJWlOuI7Ucp+KLMLNgw3pr7Z69WsnoqU6OvWvlBmO1xtMGt
 eS8YM0jsBsalq21ubxbIQDnAvFADRvfbdBJYGxU62NBilECu5YdrCVjB7VuAhhLqlhGbth02o/
 17n018BjGPGH2Mf9vEYzFeFrc+yrRREzkYCDfsHhasrl49EaJRbcTgh5kw5K1pq9w743IwFwqZ
 ILasN7awVh/fKPqcwl6i43ewHBaD7bevTcyeMkysOjf+dE+n88/WIaUcE8EAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=sbPpTxry5CCWgCtr+UU4GRpcbBqdyzYfZMNI3mWxfi8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBBQAckOt6vfxIyF6KK+reBagMNQowymUaID
 99NfdT8KLSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 h1yXB/wNYMT39s/KrQ9PWrcPRn73l+K0oPE9qSz4gTyjVwDMOdAXwZM7h/Z9r1XwevxZanfe+f1
 C8MktoYwOOYinQWjIyuPVbErq9P0N212u4lDwQbFAEgZpNhJkulBGzJqXFR2LWCsqj5iGFZ55D8
 qjCjictRbMNh+G0f7Hq6B/zO/xAsS6NlAAvkQ0OsPXmhq0gUCtQ8xtyePMiXehRPG5KzE3fpeFJ
 TtxUxmWq96XDs20ENVb28jYmc61VL6ng3Ids+ZNTWmQFBnd6jlVRf6I1yTPtphvnXMEj/vJ4hD3
 Ycz4we7OI8IFrNsd6fyYZurkhVWcv17v7qH9NwL/9uYUCzxs
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v25:
* removed netdev notifier (was only used for our own devices)
* added .dellink implementation to address what was previously
  done in notifier
* removed .ndo_open and moved netif_carrier_off() call to .ndo_init
* fixed author in MODULE_AUTHOR()
* properly indented checks in ovpn.yaml
* switched from TSTATS to DSTATS
* removed obsolete comment in ovpn_socket_new()
* removed unrelated hunk in ovpn_socket_new()

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
 Documentation/netlink/specs/rt-link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  210 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  383 ++++
 drivers/net/ovpn/crypto_aead.h                     |   29 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  274 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1258 +++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   55 +
 drivers/net/ovpn/peer.c                            | 1365 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   86 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  233 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  598 +++++
 drivers/net/ovpn/tcp.h                             |   36 +
 drivers/net/ovpn/udp.c                             |  439 ++++
 drivers/net/ovpn/udp.h                             |   25 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  109 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   31 +
 tools/testing/selftests/net/ovpn/common.sh         |   92 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2376 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  113 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 56 files changed, 9940 insertions(+), 5 deletions(-)
---
base-commit: 23f09f01b495cc510a19b30b6093fb4cb0284aaf
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


