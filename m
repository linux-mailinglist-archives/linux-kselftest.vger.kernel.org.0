Return-Path: <linux-kselftest+bounces-18868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4098CF76
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB161F22FE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB9198852;
	Wed,  2 Oct 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eo5E7E6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23D15445D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859802; cv=none; b=n6sl0RbzYvPIErS5zBZhsFJMhNaYwnHhsQNWVklIeCMzkWMlo/GdlSglz7aAbtuX5nWHXZ8OXa0iC+gftFRueGglxmA/wvNeS7UycKBju7jOEgRHA2L+f9selQOZzPS3mv5IJsiluPKQazO2RtFdsbp3ZkN0wL9aNNyhhrcGdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859802; c=relaxed/simple;
	bh=MpI7mrqF5qm7BKtRzSoFvRHwM6kAmOy/6j/h64yUupM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jckOLTdsPfYZcoua5isr8AVSI2MMMfw3H/Rt5tSZAOMDxqtGAzIGsZ4DJZ1c3gGmghS9sHhPuwy5+Radj8CT9g+hriXX3WZAuu6IazCSuu+ZGYbsXqu5+e170vpShrKpPzqP4AVsTHdTftI03XzHMwqgFriWXvmByKeCtMbXB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eo5E7E6S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso3693104f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859798; x=1728464598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B3/lBVbvNEk5LFoU9wH75pKjPIsEI82bKBediiu3f4=;
        b=eo5E7E6S0puFMedNjfPc8r2XgngnU15SOg3I3bFCqhz68NZYLmfyCD/Sr0Rhyuu+c4
         fUSQMJ7l+RcW4PhAVcf/wGEHOlt6FEA4UarZYfuzDuOWxxUwj7AzhmYmaKvqG9QvK+fU
         u7ftBavA79QcDeVeYZHLSR/hc0GH8mfQhexP75P1zLsn3+sOt6HV/WqUMD88GW7HWAlR
         ozBOI4ORy508cmzdWs4nFYexZhsFhm/3S5vvPtyjUUDZxq/sZa3f+MoK9+RbKHpDNcPz
         Zr2VYSMmHTvTCgAfxaYjnALc9qhGuY6vRKoFUEMwmaZKZF3iMvNhLBE6LtrObWLlQ2Zn
         8JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859798; x=1728464598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B3/lBVbvNEk5LFoU9wH75pKjPIsEI82bKBediiu3f4=;
        b=MH0sq+Iv+jdHgKGJg+Iko+oUHs675PMbtuY+7dxpONGos7g0VJQN6l/lfG1y8KgSWs
         SMgLOOCrqzPouFCXwLt9Nq5Aud7l3Cp5y90VZdYavSHlG9a4WeS5FiZeQ0IJ1Ay9KPSq
         LAAI9QBBwuaAAo+cGbirHDyA567J75MM25D+7M8t35lFVmt8+eix0rEz/vmiIotSbwR2
         jwqHZNyXSdZznApJDbEyBQzvvRfpJgtecNlIlXU9YPtdus1VgD7yckFglLMfHQ3mEEPl
         WMyztewYOdUlDmq8mrBz8XXYjOUghbmIvohWAlDwVl18XKeHd9sAMjxx8AHFxTzInq29
         80zg==
X-Forwarded-Encrypted: i=1; AJvYcCXoScnTHwLUcB7lTmU2hl4oId9HzBwobG6GeZRoRDltpJjy4VhnyOtbNW9/pmdKgcX6IYYWMuIsjiiK7fxknJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVpnN33SFT0kzn1odaROOQwx473VPqxxtUReUE73pIL6uyHHY
	sIlaMgmi3WDmb5EpLjXLI7dXKgiWXPtnZFyZrnI4jFSW44kZryyilTq/DlweeWw=
X-Google-Smtp-Source: AGHT+IFwCsN1FnvW77iF7PGs3BIwvWgHaIhfsNQHJ6Ny1ncQQ876J5h4nEHS1uUiuk2BNYu4s6fihQ==
X-Received: by 2002:adf:fb0f:0:b0:37c:d23f:e465 with SMTP id ffacd0b85a97d-37cfba12331mr1308531f8f.55.1727859797964;
        Wed, 02 Oct 2024 02:03:17 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:17 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v8 00/24] Introducing OpenVPN Data Channel Offload
Date: Wed, 02 Oct 2024 11:02:14 +0200
Message-Id: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYM/WYC/x2MQQqAIBAAvxJ7bsHMovpKdCjbai9raEgg/j1pb
 gPDJAjkmQJMVQJPkQM7KTLUFdhrlZOQ9+KglTaNUho3gy7eglRoO9uPZtVQ6tvTwe9/mkHoQaH
 3gSXnD6JzLLdjAAAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6470; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=MpI7mrqF5qm7BKtRzSoFvRHwM6kAmOy/6j/h64yUupM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxQghV305E+AFXeKycS/lc6kEUT7A3CE1F2o
 l7bL0PiVTqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUAAKCRALcOU6oDjV
 hyCTB/9pubqPrOy4qqUSWk2Z8d0SgnUGUlcCc7RK/maK96+Nc+HiMytBhWLG8N0euxLSJMU2A22
 AGK/UMODhGx5kIZqCON93Ik+IoISS9KKI3i5hAborAzmSKy9QJdiUH7IO1DkM0weFXEVg+w8iQa
 fxv+zSL7LqcJ9PbuN1CbS5toFKHiTYEnnS7FaO6ZI5k+AIMuIjWrV4BKgbz3tBYVhGNjRpuudrp
 kALBx0gse2I9jKYcABhIIP6q9xzDMOgWNJR6cByqdt3Aa3Q/t9g6nmBPMLOcSkYjoF7s4WTLiIi
 asmoLmEhKX23dNiZ9YuaI9FP7A8K9P5Ap+xXRaXDqWN/90DJ
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This is the 8th version of the ovpn patchset.

Thanks Sergey for arguing regarding splitting PEER_SET into SET and NEW.
I decided to follow this suggestion as it makes the API and its return
value easier to work with.

Thanks Donald for the suggestions regarding the NL API - they have all
been implemented (unless I forgot some, but hopefully I did not).

Notable changes from v7:

* Netlink API adjustments:
** renamed NL API from OP_OBJ to OBJ_OP (i.e. from SET_PEER to PEER_SET)
** split PEER_SET from PEER_NEW for better clarity in case of error
** renamed NL API from NEW/DEL_IFACE to DEV_NEW/DEL
** converted all underscores to dashes in YML NL spec
** split sockaddr_remote attr into ipv4/6, port and v6_scope_id attrs
** split local_ip attr into local_ipv4 and local_ipv6 attrs
** turned keyconf into a root attribute (it was nested in peer before)
** made key_swap use a keyconf object rather than a peer for consistency
   with key mgmt API
** created specific op for peer_del notification (peer_del_ntf)
** created specific op for key_swap notification (key_swap_ntf)
** allow user to update VPN IPv4/6 (peer is now rehashable)
** converted port attrs from u32 to u16 for better consistency with
   userspace code
* added rtnl_ops .dellink implementation
* removed patch 2 as it's not needed anymore thanks to the point
  above
* moved rtnl_ops .kind initialization to first patch
* updated MAINTAINERS file with Github tree and selftest folder
* wrapped long lines in selftest scripts

BONUS: used b4 for the first time to prepare the patchset and send it

Please note that patches previously reviewed by Andrew Lunn have
retained the Reviewed-by tag as they have been simply rebased without
any modification.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (24):
      netlink: add NLA_POLICY_MAX_LEN macro
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: implement interface creation/destruction via netlink
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

 Documentation/netlink/specs/ovpn.yaml             |  387 +++++
 MAINTAINERS                                       |   11 +
 drivers/net/Kconfig                               |   15 +
 drivers/net/Makefile                              |    1 +
 drivers/net/ovpn/Makefile                         |   22 +
 drivers/net/ovpn/bind.c                           |   54 +
 drivers/net/ovpn/bind.h                           |  117 ++
 drivers/net/ovpn/crypto.c                         |  172 ++
 drivers/net/ovpn/crypto.h                         |  138 ++
 drivers/net/ovpn/crypto_aead.c                    |  356 ++++
 drivers/net/ovpn/crypto_aead.h                    |   31 +
 drivers/net/ovpn/io.c                             |  459 ++++++
 drivers/net/ovpn/io.h                             |   25 +
 drivers/net/ovpn/main.c                           |  363 ++++
 drivers/net/ovpn/main.h                           |   29 +
 drivers/net/ovpn/netlink-gen.c                    |  224 +++
 drivers/net/ovpn/netlink-gen.h                    |   42 +
 drivers/net/ovpn/netlink.c                        | 1099 +++++++++++++
 drivers/net/ovpn/netlink.h                        |   18 +
 drivers/net/ovpn/ovpnstruct.h                     |   60 +
 drivers/net/ovpn/packet.h                         |   40 +
 drivers/net/ovpn/peer.c                           | 1207 ++++++++++++++
 drivers/net/ovpn/peer.h                           |  172 ++
 drivers/net/ovpn/pktid.c                          |  130 ++
 drivers/net/ovpn/pktid.h                          |   87 +
 drivers/net/ovpn/proto.h                          |  104 ++
 drivers/net/ovpn/skb.h                            |   61 +
 drivers/net/ovpn/socket.c                         |  165 ++
 drivers/net/ovpn/socket.h                         |   53 +
 drivers/net/ovpn/stats.c                          |   21 +
 drivers/net/ovpn/stats.h                          |   47 +
 drivers/net/ovpn/tcp.c                            |  506 ++++++
 drivers/net/ovpn/tcp.h                            |   43 +
 drivers/net/ovpn/udp.c                            |  406 +++++
 drivers/net/ovpn/udp.h                            |   26 +
 include/net/netlink.h                             |    1 +
 include/uapi/linux/ovpn.h                         |  116 ++
 include/uapi/linux/udp.h                          |    1 +
 tools/net/ynl/ynl-gen-c.py                        |    2 +
 tools/testing/selftests/Makefile                  |    1 +
 tools/testing/selftests/net/ovpn/.gitignore       |    2 +
 tools/testing/selftests/net/ovpn/Makefile         |   18 +
 tools/testing/selftests/net/ovpn/config           |    8 +
 tools/testing/selftests/net/ovpn/data-test-tcp.sh |    9 +
 tools/testing/selftests/net/ovpn/data-test.sh     |  153 ++
 tools/testing/selftests/net/ovpn/data64.key       |    5 +
 tools/testing/selftests/net/ovpn/float-test.sh    |  118 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c       | 1822 +++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt    |    5 +
 tools/testing/selftests/net/ovpn/udp_peers.txt    |    5 +
 50 files changed, 8957 insertions(+)
---
base-commit: 44badc908f2c85711cb18e45e13119c10ad3a05f
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


