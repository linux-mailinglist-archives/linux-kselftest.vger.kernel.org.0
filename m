Return-Path: <linux-kselftest+bounces-30280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62ABA7EDB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919EC7A5279
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1121D581;
	Mon,  7 Apr 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ru25OYRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055421ABB7
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055229; cv=none; b=l66lRLwAADfrxQg0baKY12hpHs8iS0s5SzqJ8K06fJ9k8pd+gG/twhoErCPWfbzsy1Bi60wpBuHy65AuEjjsZ2q+HL1fz+o4gGfosiuSD5cAItKFvQYpBhD7S9C1PYV5FDtxn8t04WzNkB8LZLaD2eI0x8dUEtixpsshzWzU2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055229; c=relaxed/simple;
	bh=XWDYAngEt+kjD/GdPWOJDGyRbNcrEIMzJQoNWA3AYho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eGSXc+aECFOJpslWAXH8kj/9rbwQ6DhhqwaJfJ71m41RmNi3In/nTTilUIoAGkfIBjMHR9ls6keJlgNFVJypuxLQpeVnTyUKLmR9hJi+VjakRtajtyw/kIiCskUr1TXY9W7s8MFIjzgnndMOsc/LGKj5Qz0sSMA9zMQ1+J4NUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ru25OYRg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913b539aabso2790975f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055224; x=1744660024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnReNbe06VKRIwr4xsF+HWFWA8VcPtsty0G0dBGh8Sc=;
        b=Ru25OYRgKbMfJoO+J/YKH30UlsSSCO6XQrN2h69Y6PIgUGog7MovQ+3abz41Jl2cQ7
         /KPZUxcAoWMONvETcYyQ6uSks9wMPOQFBeT+rsWMTrwQgpWTO79usBlMUbtWluWobIEU
         VGU6+umpDyFaldDZPQurwCUfD87TlFzl3NZFzl01YToODVldqSJVMmij8VnEz6CQN1bD
         s4tuiLLpL2rt1rbeLCUc8L/hLjQtNZrDJsfj+sH6GSaf16ge5nM487yqcqDcXBfJ3l0Q
         G8GNwL89zBBe7fWxfd3xxu8AjY8ch9nddGVomQcZsJX+jeVFHPHDsG1XqkFq8rgQZPKq
         w/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055224; x=1744660024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnReNbe06VKRIwr4xsF+HWFWA8VcPtsty0G0dBGh8Sc=;
        b=aDraWdcQq4/a/cH4el+OCfFYlgJlZvucfafILePZ42KO0IFvKPsH0J8CwVqjkgH/RN
         YSdlUIu2nYQrLj834tFAuQ6go9nWLYtIbBQZuB9wL5psQe7BLqSIb2gfhmYzgDtNkknF
         tveWarDhHtoG5tO4AaMZXFOEiPPTVnjLk9D+3RNSf/tJDmlda0ivKO8KuBbXKBtoNxY9
         lqE9JqUVv68hIOdK7oLozrUVHRZEB7e4aZvdThrSWe8jZPnxLH9/mRKPJlQGzw7A5/Fo
         QYi6lVDM3vEMX7QwVVk0dWaAKaXBVs5Od7/BFHmMD7sxgpQcrFxCQlrE6ikI2H8g5SyN
         QzuA==
X-Forwarded-Encrypted: i=1; AJvYcCXEW9q8m/rgNtGYSZ5qkSziuvTTFuIJrJqig/oLBhXJgDVef2cImLa1CP9mRLfUK9BbNuiLGVPRily5daJIPEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfptwo6bJB0OPpb1bM/0dx5E8zxIp+KDU1kh18rFm7jnqCLCgH
	MRp0V6ycwyxNCY8/LWcPE0rDzukhfXAoL0XzuFeCvnMoAbgalxLR/EM0d842frpOiXR2EM2YmaR
	C3h91fmvpzpsg6UbeCZDiso5BasB9Shzfe58xoUOAOd0nDZ4XPuYG3TpPmzs=
X-Gm-Gg: ASbGncsf3fdfxOdSje+GzGC3NKnbcbmZ1IiIrt7EBQvNtoV6ID834pQIyn3DYIljL6n
	1Dt4l0ymZyHOCUk958R3DrLx2ftYlmQe+TQjzSLfouI1o+p/O3BZz4j6gXB+hQshY+Svd31uZKH
	cNy2yy4KkuLIirK151tDqcajEh/3USCeAXirPEfMWM6usQ+QqqOqv9TFeeFwWj+S2dK6pVm36WL
	UJaHL9SJ5ivvWgWLmRVKrJMypcU8UO8jzYi/yGdXeUg7ldsc9/4OAus6Rw8tkNVR6zZufF1PiVb
	mFSE5ALZ/ZeqXrb7NDrHWfgObgUW9Z2pQNrhFwDZShHNTTcSRjB3
X-Google-Smtp-Source: AGHT+IHH314AlS7FqyZVnCSlqrHSAgQaiPYFmza57Ue+t+cvW1Pu6BH0m04FYnXaWl/3sKaEjZwQTg==
X-Received: by 2002:adf:9cce:0:b0:39d:6f2b:e74d with SMTP id ffacd0b85a97d-39d6f2be8b7mr7032649f8f.39.1744055223747;
        Mon, 07 Apr 2025 12:47:03 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v25 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 07 Apr 2025 21:46:08 +0200
Message-Id: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAr9GcC/23SzW6cMBAH8FeJOJfUnrHHuKe+R9WDP4Yuh7IrW
 KFU0b57B6KESWsOSHj8898289qtvEy8dt+eXruFt2mdrrN8gP/y1JVLmn9xP1UZ6MCAs8ZAn11
 /3W5zz/KgLxRdgk5m3xYep5djqR/dzPd+5pd791MqOa3c5yXN5bKv9F77+jtN8y4v03q/Ln+OP
 Wzx8G9plj7SttibPqXMsQL4VP33641nqTzLckfKZo2i4E9qjdg8BI8mhJA5NKzVNiprxVZ2FIc
 SMEErF04L6oKkIBYwjmNAzGNs5aK26rgWxVIYs8tMRAwN67TVe3ZiOYHDMlpytpXrlZUzntaLR
 esYSqqG7NCwpK3Opd0yGmOtRxqwYcO79TLJKBvEupABQ2BPtmUHbVHZQawdjak5FsiVGjae9vN
 5974aqPqaRkgupP8tGGUhnBb2voo4IiFaM6BrWDgt6lw4eiOHLNvxXi6yYVFb1Vew90YgQ5SLS
 WhKwzptB2Xd8Y+KS9nLK/zTG4/H4y/X01B0EwQAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6235; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=XWDYAngEt+kjD/GdPWOJDGyRbNcrEIMzJQoNWA3AYho=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cus3ny7vJSkIiMwta2Pelvf5xftjzbK77eV2
 p506InckOmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrrAAKCRALcOU6oDjV
 h+ynB/9B4q+83pXaRxynl5Vcovwjr+LCYsCklftGTIhGZakYSg0VoXDPPcV7YGeN2/TjS9pZXin
 coDCKdLPEVx9PT1xR6mpNYz4EvLSvPFwa5xSyUh+A14+rfwtYsK81f/nb7LlDNcMc3YT9O5N7Xi
 DZrqUIOpwy7zvXaGeIAn6QaPMu2QdQBkYKsZewBSsalqOYInV43TBOVeuUiKHc62j0v7qIB3zb2
 6nuhhF3gvSSs3aVmr2jSE4ylcM0uD8VflpH+D07s4VZn5At/zYfJ/zl+z11ev8t+FP0bRpX6q/o
 PV8c7xbNPJsYkHI9uzoGYl53r1sAVmSsm3ZQ/Fu6IIQQ0iQV
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v24:
* disable TCP disconnections of attached sockets (tcp_disconnect()
  returns -EBUSY) - similarly to kTLS.
* used rcu_replace_pointer instead of rcu_dereference_protected+rcu_assign_pointer
* dropped useless skb->ignore_df = 1
* dropped unneded EXPORT_SYMBOL_GPL(udpv6_prot)
* dropped obsolete comment for ovpn_crypto_key_slots_swap()
* dropped calls to kfree() in ovpn_aead_encrypt/decrypt() (release is
  performed in ovpn_encrypt/decrypt_post())
* dropped NULL check before calling kfree() in
  ovpn_encrypt/decrypt_done()
* converted seq_num from atomic64_t to atomic_t (IV exhaustion is now
  detected in case of wrap around)
* call consume_skb() on skb when dropping keepalive message (it is not a
  failure)
* made REMOTE_PORT mandatory when REMOTE_IPV4/6 is specified in
  peer_new/set call
* ensured ovpn_nl_key_swap_notify() is called only once, even when
  parsing a batch of received packets concurrently

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
 drivers/net/ovpn/crypto.c                          |  210 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  383 ++++
 drivers/net/ovpn/crypto_aead.h                     |   29 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  330 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1258 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1364 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   86 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  239 ++
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
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2395 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  113 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 56 files changed, 10022 insertions(+), 5 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


