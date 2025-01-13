Return-Path: <linux-kselftest+bounces-24330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41DA0B2D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959FA1886855
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE723A585;
	Mon, 13 Jan 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CYu1EGWw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84F239799
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760666; cv=none; b=Tc5Ia5lZx38Kf64pP48tZWYs8j1NuHE9w1wrXLl+UTvVJqHcgHdtOwnRiD3HU17b51oUd8UbChMUowg+UeofFYxbNt/+eAEXpVWUqCjQ6QucoQFUNda95HA2i+K+wsls1xqpRTN49QlX6peG3xas9s9f1KDeze9DgUyxjI+R9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760666; c=relaxed/simple;
	bh=7APpdEA4jr7ps1b8VWTegxDhvEoR42BTlzwB5PRlvl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HS2Xcs8FxkeUFCFi8Uhdb6oxGfRAtVqdvjQ0Gows8l+F9RLtei6r7MCH3vJPkYcHqKy+h4S8l0TXmN++sTqbBk+PoCX6lIodxVA9geHIDhP9bb9XV1e2KDwSWswSAxnI2F/c3gLgly/WOKKNqPZaftnP4VHfDYsoOBFnxTvJVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CYu1EGWw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2097501f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760663; x=1737365463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc5Zf1W00VNHW+KjirMIPMombgAnhdag4FiwQVcWPXU=;
        b=CYu1EGWw+Sexo6JzQu9HyoI8VLGzQTKf6WYK8Naibsd8GK6bP0GUQ8U8Ha9CKwECmp
         HTzW2Bb4fyyEqKhs/K7K+6lWA6680TWyurKQg69izFj07DMPNyD3BPrAsZ5MzSxkBVlb
         CL7O34VtgAkN5Rf9P9rLgpPV9jG7C2pWfZ+5oJX82jURFkO+VjsCrMH4ILUs0O3YaK+0
         Skh4Fdivui/s2Ar8G9Jyh09Xnk11uh1rVd8phqXW/nJ/0Pc6tr4MEvK3h/K2v5p2y0Er
         UVqvrp9Oqpnlt9Lw8w42XhamYUSkE3cxcMnM/BZqMXWeq/P/8sm7KBvSCITmeTG7ZnDz
         O9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760663; x=1737365463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc5Zf1W00VNHW+KjirMIPMombgAnhdag4FiwQVcWPXU=;
        b=rVBahuB7ttUK6c5CqzWED5/av1QiLSepu6ABTzXEJy5rbYYpq4wx3baj9Ud0TtOLF1
         CxtPiEfBYnmXqVuTD4Y4fFkJXOtHgBBC7zbRa6KYFBeestSKW4D5vJO+wOSmeyuso6+p
         xjDSPBjwqdN4+ENIv9Q4bGSwnkCaphFlQBp0fzd0K5XiDA9VCCxGSaJooGm+/hwZljGb
         LjNwC515HiV+xKORf5Cfp3kZDo7S2eH1osXYGonEF15qArNZiebGOQ+U8Z7slyC48dEi
         ony/p2VUFZYUv52l6o7OEg0F+53wHBNCykM9TXi4xPd83Pm0k3sFW4dEBSar6oqdM8kg
         7yPg==
X-Forwarded-Encrypted: i=1; AJvYcCVyPjT7rB0W5iWcOjlegGMdvERmrXoo5diluLuGm1tRX41hYROzFtEfWmr8E14Svk9o3IbJBZyH11yg83G/0wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGr2uu/SR0RxPK0W8nLJ2ck5jYBgxHgQ6p8u1BoRTJ0x+fzzx
	RoxsgRsUYulcTFywI3UqqnolAqIG52RLtRb4ne1+5I1Tk34Q0XAdas2PTJRICqA=
X-Gm-Gg: ASbGncs+Q7xdg+K71YKpDy6Kbzs03QHbscJPyAVvXlow6eCFqUo9OAQwHlTXALt7Eii
	Yk/KC6hjWjFZqnd2BIMcxJLJrfH+Q+506r7Xa5+aG5TtxYT7GipkWbPE8bZB8Ss2DOGTeB2ZSnc
	1ByR8V6H9ecztJObMmypheEDfzqxJKMXL5aVkK1JULV7AK8gIfzpsJHwyUvcSumEJMCVn8NSv3g
	0h2yBM2Mi1gvqw/rpl95oCLnGM+eWTpbkLWFD2T7miNN71gdMPHuczO3AgrT64UzwOF
X-Google-Smtp-Source: AGHT+IFQfk85cLlsOAwzvB9LsrBPxxUaxLijNlenjeYIFXR9Ee1wVy9vyI3gO6fw7g9Y/b7FRD93ZQ==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr15294245f8f.19.1736760662737;
        Mon, 13 Jan 2025 01:31:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:02 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v18 00/25] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 13 Jan 2025 10:31:19 +0100
Message-Id: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjdhGcC/23QzW7DIAwH8FepOI8Nm6+w095j2gESZ+UwEiVV1
 Knqu8/N1BVNcAPz899wESstmVbxeriIhba85qnwBrqng+iPsXySzAMfCFRoQCmUychpm4skXtr
 2LpiIgm/PC435vLd6F4VOstD5JD64kuJKMi2x9Mdbp3vt5SvmcpPHvJ6m5XufYQu7/00D95e2B
 alkjInCgGjjYN+mmQpXnrndnrKBqijaBwXFNnXeauW9T+QbFmobKgtsBzIudL3XEVu5+LBYfRA
 X2KIO4+i1TmNo5eraVs8Fzdb5MZlEzjnChjW1rWc2bCmi0f0IzkAr11aW3/iwlq0GQ9jHQTnoG
 tbVts51N0taKQCrXacb1t+t5Uuqsp6t8Qm192Qd/LPX6/UHe9V8MKsCAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6542; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=7APpdEA4jr7ps1b8VWTegxDhvEoR42BTlzwB5PRlvl0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2A6+0VNKx9H7gk5suENobFMy2b+YYzOg8v7
 0PBqMNVfaWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdgAAKCRALcOU6oDjV
 hydMB/9DvAdG0+pShJ4O3fl6TCLBcp4slhWXBTr2VKtEXvnZOk9hvjeIaNmB8Uij+b/Y/Oy+/3a
 EV266eJ5b0s79KHM4Ysi+I+821v7c0S4VNgTfwrV/hFK8s1k5y2t1RbPYaC6RiY7z5r1pbZQ5N5
 KhuB6MFW/8d4YwI4kve4f2CpdkdvzpPEiBJFtRQxgKU4pSQa1xwN7kZ9kYDTMeUhyJJ0M7mFR3d
 sIujOcfnroL587yTzl5jB2TVu1UgMz1h+lGlNOVHWe2nDUyT6IpYfgER+SXVMfDJnslskt0QFau
 lqk/Xurm1OWvfV6GUEbZTkLuQ9y2MBF3wMBHDLolXiwRNJYl
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v17:
* fixed netdevice_tracker pointer assignment in netlink post_doit
  (triggered by kernel test robot on m86k)
* renamed nla_get_uint() to ovpn_nla_get_uint() in ovpn-cli.c to avoid
  clashes with libnl-3.11.0

FTR, here are the notable changes since v16:
* fixed usage of netdev tracker by removing dev_tracker member from
  ovpn_priv and adding it to ovpn_peer and ovpn_socket as those are the
  objects really holding a ref to the netdev
* switched ovpn_get_dev_from_attrs() to GFP_ATOMIC to prevent sleep under
  rcu_read_lock
* allocated netdevice_tracker in ovpn_nl_pre_doit() [stored in
  user_ptr[1]] to keep track of the netdev reference held during netlink
  handler calls
* moved whole socket detaching routine to worker. This way the code is
  allowed to sleep and in turn it can be executed under lock_sock. This
  lock allows us to happily coordinate concurrent attach/detach calls.
  (note: lock is acquired everytime the refcnt for the socket is
  decremented, because this guarantees us that setting the refcnt to 0
  and detaching the socket will happen atomically)
* dropped kref_put_sock()/refcount handler as it's not required anymore,
  thanks to the point above
* re-arranged ovpn_socket_new() in order to simplify error path by first
  allocating the new ovpn_sock and then attaching

Please note that some patches were already reviewed/tested by a few
people. iThese patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (25):
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
      ipv6: export inet6_stream_ops via EXPORT_SYMBOL_GPL
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

 Documentation/netlink/specs/ovpn.yaml              |  372 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  382 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  350 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1183 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   54 +
 drivers/net/ovpn/peer.c                            | 1269 +++++++++++
 drivers/net/ovpn/peer.h                            |  164 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   60 +
 drivers/net/ovpn/socket.c                          |  204 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  565 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  421 ++++
 drivers/net/ovpn/udp.h                             |   22 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  111 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2367 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  185 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 53 files changed, 9673 insertions(+), 5 deletions(-)
---
base-commit: 7d0da8f862340c5f42f0062b8560b8d0971a6ac4
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


