Return-Path: <linux-kselftest+bounces-19790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3499FDC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB421C27C39
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE55148828;
	Wed, 16 Oct 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rk/rN6Cc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CD67A0D
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040623; cv=none; b=u38kkJcXn10BW76QRev19CPDsq01WcxRi9eeIcoiklukhy0xA74djFiFbophPHO0Qq3dCM2T4ZVBa7NYDqUZzal3sOX6W0sHuAS/qurR950MzBzebrbG/1zm37nI4akHoj/Jw84nV+u3GriQn7p32WdfLZkckbSQucok+tRuXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040623; c=relaxed/simple;
	bh=XNv0ZWnpAOUV1m6lQAKWjplPZ1vlzWKCXwkke06zRwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bo0b1xwXpVhy7C+pfo5cqXcmk/9z703hNrxRKGRAEr64kCBwTFe19E5MhDB0an43gSVGtcPWdoL60z7f9ZzXegBSu1I4cqaUcGJt3UnAIWDg8ae37WQiI3FUOKa5U1hd+UEBCr0bY27tZBVO4y3dAowun2lmDyhNWFCZA64M+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rk/rN6Cc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so4650997f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040618; x=1729645418; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbcJ5yi7nw5Zqb8ME3EK5ofFYciTJHce59S97ju9J6E=;
        b=Rk/rN6CcKAOxmKthB78EKWfzEmRhry5G/Dkp6p0BAogI96bdLNnW3GAe4rKKlj9nYa
         h3y+YTvq4Y8zHS6uzASm7Kg1NUEE42PM99pYXQnjgI+UFVm5EqDUhjN0on2Vxqt+4RKW
         4w6/31zXfesT+jweju2lqjt7NYbwq2lNCnwS2wX3ffrfnFwlqrUJ8mKFQeYIPyDogwoI
         2GdTnxkcsYTbVvC9E3/Eh+S5qz3P/ugqmmhqhTNquBofUlIHi0if+nfB5sZt5KnJdvlD
         5Sym12TeXgl1uebOOiwB1ZVTyEA9eKDC9XYSowv5aU8LVgOWH8JAO33uIX3e26YwxRi/
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040618; x=1729645418;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbcJ5yi7nw5Zqb8ME3EK5ofFYciTJHce59S97ju9J6E=;
        b=MhP9iaWISJdQXwtcZPeHkJOoYy6LrQ2nhbYMFBmRErdDWP+XRrcaQ1KiubkHBPRLIF
         VQ4vLOmPGM78qvYbJRMHMQmCXR8cOQDxsT6X/u4ZRNlpcQLjpWNO06dYMfLTunEhjcht
         slUjx29UBywiRqy8DxyTP0JtliRRq7ney8pirRjohHmLiLHCVJ9UYRK5xkH+o1zn2EUR
         eCn40rIOcE4/1r5nOEiZMg3DQbp3VvKoRkZaM90VoCROTFweI0lVRwm8faAnVxAv8OFP
         wWwV+IRmY/GUh3dM737hxKNlEtC7GlWoKnAkIPYwDAnCheai0Jfvooa6k94sAEf0+htW
         jiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7DI/vELfmiMHn9lSFq1ObgkXAwqyWLwyhEjeTU7tiVVLyuxPxPnRhP4XJu2RsrLchm8oo4a3PEDuVGwd6MFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7TZ7vPVFIsxt7DjdumW2ZF+d6PvKPjmsT1/k43CZisapVivY
	11MvhlWl6WMbgKjUc/Y7OKeBbUl7ffsjAcfH92PI5x6FnB9J91t+94eGK+aBBWU=
X-Google-Smtp-Source: AGHT+IEtTDthd8G0px+r1xCN9WaPWbrUKiScw/cG8Ak+rVoWwVg0SVdgJ0UIm1/wXVVcD4vjz+tWbg==
X-Received: by 2002:a05:6000:ac5:b0:37c:cd1d:b870 with SMTP id ffacd0b85a97d-37d5ffa14cbmr11100830f8f.29.1729040618396;
        Tue, 15 Oct 2024 18:03:38 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v9 00/23] Introducing OpenVPN Data Channel Offload
Date: Wed, 16 Oct 2024 03:03:00 +0200
Message-Id: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUQD2cC/zWMQQqDQAxFryJZNzgdp4K9SnGRmaY1i0aZERHEu
 xsL/t3jfd4GhbNwgWe1QeZFioxq0N0qSAPpl1HexuCdD3fnPMaA4zIpsq15pLYL5MHeU+aPrP/
 SC5RnVF5n6M1EKowxk6bhLF2u/pEo7PsBoFjkZYMAAAA=
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org, 
 steffen.klassert@secunet.com, antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=XNv0ZWnpAOUV1m6lQAKWjplPZ1vlzWKCXwkke06zRwM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDucjwBJ8z/CqQU/iISN/exn/PqfsgH7Feq9
 7lzDN11n0WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7gAKCRALcOU6oDjV
 h78fB/9X8IJ4j26iHTyUy3lmSPWLvsLLZ7azrzMbAKvVc1CiRmlEEHRAzHvELbHxfKLw4aeeUve
 nFmF4L6GXwNzfU7zUQOU5ZGuUyBqswp9yAjdrQToHdvjuGhSq2Ti7gctVe3EojVWJjemit4zHpG
 o2FQXXPlS3WE9BNCL2BFLr5cEL+v7CDSpznt5PHAf5pzZg2M1kF31k1p2Y6Zc/t0DWlylP4MXd6
 BDYNoo5GEOrOSqtSxJGLpk3Mcn2Rx0EGsXmST/Ha9CcqdcmXsas3SQOS6JegRTbyjAgIhgq7JNj
 o3byncmZvHQ3PZTsABD+gacIaIRZ1cwbEi9c2ll9oJeJqEQu
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This is the 9th version of the ovpn patchset.

It re-introduces the RTNL Link ops and brings some changes
to the Netlink API as well.

Notably:
* removed CMD_DEV_NEW/DEL from netlink API
* re-added rtnl_link_ops.newlink implementation
* removed all 'value-start: 0' from ovpn.yaml
* added CMD_KEY_GET in Netlink API to retrieve non-sensible key data
* used key-get in notify attribute of key-swap-nft
* ensured that all netdev references are tracked
* added IFF_NO_QUEUE to device priv_flags
* set netdev devtype to ovpn_type
* added implementation of .ndo_uninit
* used workqueue to release socket (TCP detach may block)
* removed inclusion of linux/version.h in main.c
* removed commented inclusion of linux/rcupdate.h in main.c
* fixed file path in MAINTAINERS file
* properly sorted files in MAINTAINERS file

Please note that patches previously reviewed by Andrew Lunn have
retained the Reviewed-by tag as they have been simply rebased without
major modifications.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (23):
      netlink: add NLA_POLICY_MAX_LEN macro
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on
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
      ovpn: implement peer add/dump/delete via netlink
      ovpn: implement key add/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftest: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml             |  362 ++++
 MAINTAINERS                                       |   11 +
 drivers/net/Kconfig                               |   15 +
 drivers/net/Makefile                              |    1 +
 drivers/net/ovpn/Makefile                         |   22 +
 drivers/net/ovpn/bind.c                           |   54 +
 drivers/net/ovpn/bind.h                           |  117 ++
 drivers/net/ovpn/crypto.c                         |  172 ++
 drivers/net/ovpn/crypto.h                         |  141 ++
 drivers/net/ovpn/crypto_aead.c                    |  356 ++++
 drivers/net/ovpn/crypto_aead.h                    |   31 +
 drivers/net/ovpn/io.c                             |  461 +++++
 drivers/net/ovpn/io.h                             |   25 +
 drivers/net/ovpn/main.c                           |  337 ++++
 drivers/net/ovpn/main.h                           |   24 +
 drivers/net/ovpn/netlink-gen.c                    |  212 ++
 drivers/net/ovpn/netlink-gen.h                    |   41 +
 drivers/net/ovpn/netlink.c                        | 1039 ++++++++++
 drivers/net/ovpn/netlink.h                        |   18 +
 drivers/net/ovpn/ovpnstruct.h                     |   61 +
 drivers/net/ovpn/packet.h                         |   40 +
 drivers/net/ovpn/peer.c                           | 1197 ++++++++++++
 drivers/net/ovpn/peer.h                           |  165 ++
 drivers/net/ovpn/pktid.c                          |  130 ++
 drivers/net/ovpn/pktid.h                          |   87 +
 drivers/net/ovpn/proto.h                          |  104 +
 drivers/net/ovpn/skb.h                            |   61 +
 drivers/net/ovpn/socket.c                         |  178 ++
 drivers/net/ovpn/socket.h                         |   55 +
 drivers/net/ovpn/stats.c                          |   21 +
 drivers/net/ovpn/stats.h                          |   47 +
 drivers/net/ovpn/tcp.c                            |  505 +++++
 drivers/net/ovpn/tcp.h                            |   44 +
 drivers/net/ovpn/udp.c                            |  406 ++++
 drivers/net/ovpn/udp.h                            |   26 +
 include/net/netlink.h                             |    1 +
 include/uapi/linux/if_link.h                      |   15 +
 include/uapi/linux/ovpn.h                         |  109 ++
 include/uapi/linux/udp.h                          |    1 +
 tools/net/ynl/ynl-gen-c.py                        |    4 +-
 tools/testing/selftests/Makefile                  |    1 +
 tools/testing/selftests/net/ovpn/.gitignore       |    2 +
 tools/testing/selftests/net/ovpn/Makefile         |   16 +
 tools/testing/selftests/net/ovpn/config           |   10 +
 tools/testing/selftests/net/ovpn/data-test-tcp.sh |    9 +
 tools/testing/selftests/net/ovpn/data-test.sh     |  157 ++
 tools/testing/selftests/net/ovpn/data64.key       |    5 +
 tools/testing/selftests/net/ovpn/float-test.sh    |  122 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c       | 2136 +++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt    |    5 +
 tools/testing/selftests/net/ovpn/udp_peers.txt    |    5 +
 51 files changed, 9163 insertions(+), 1 deletion(-)
---
base-commit: 6d858708d465669ba7de17e9c5691eb4019166e8
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


