Return-Path: <linux-kselftest+bounces-20628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D309AFDBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F2C1F2367A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95C1D4174;
	Fri, 25 Oct 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b/awbBXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B71D358E
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847698; cv=none; b=BFB09TNH2kVd+7ZqSqVRvz9C+SQ66LXPiN1md64UwDiuN5cr6PLg2C4eJxkfYuL81qQjXOqLFBz4yz2SJJkfWAcUT2V3/rdp4yqAvQTcge6383zGbswpPS/j/oSC+0xTTv2COI01QhoRp83nmbeSsFHAqCySwfIM0C372VzcyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847698; c=relaxed/simple;
	bh=UH/2XoV5zBduLlAxK6ecGWo1z1jfCgCLYw+ocMqnVNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fmqWSndajutGY88QNySSGtCdVpW4CvfmsBZTmMwraX63AAaafJMlfpvBm7XDHxf5H6De0cNQL4PHYssuq3IWVj4V4qXde3yoSpxXLXGKkPpOE8B3s2QLWi6633m53suaK8Jlm1b7tzYdXVsqmy86bXiJQdweE29DOf0+zN5zJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b/awbBXg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so28213421fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847694; x=1730452494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZj3Vu7YSGt+ApMn+BwpuSUc9d6+WICm3OIG9qeK3SA=;
        b=b/awbBXgbUGOYpXeA1MoINdK6o6ANPyJf2ZX4lMqmRMBqorUmHIqkENtZgbN0W9Dwc
         h8vxLFHYicufheB4ojeRYJ1og9T4dzuUKMI9LP22VECtrXcEEuontJDherlGE8Ss9AIY
         MwXvnZQHUhxAjmhKTn7PsdBJM6Tpj28jnsERRfEsdtPvBX8bMAqUeG8wR79RJJrNVijw
         0TB63iG2to8kzhl5hV3dzKdBF8CAxvhH0FJOtrKXzwH/nht390JLM1HfbHZzbvThj5KB
         3neQoQCbfnl3FLJ+xxbTqmYA/3HSj7rmzEg6LsnxSlz/JfxK/PVqmTJCleJ3irn05IDC
         UtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847694; x=1730452494;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZj3Vu7YSGt+ApMn+BwpuSUc9d6+WICm3OIG9qeK3SA=;
        b=e8xOVOS+eRb9pv4l1k9daNBLFVrXdszRate/Cf5pYkapaXQNFDnXlgWyIZ0Cp5gBqM
         CA1dKnw6LrBuwa9fZR3jSjNr6mvH+Qgr2/7I0HVHrGFX9jEreztQ9iRXLUs45ecTDSzF
         arI2eWpmqf+wV6zCZloSHa4Obs7reO89XR61LpSp4vx/8NrcTp1ow7DAQkXalJE+uxs3
         EwjFMiUHS8qhD9kv5RWDqRZQyGWXWuydRyakuQdnaXPqGFfQubwg12xxD6lscy2yEt3E
         YY2+/KRhqMicTKScCbKlVNq9bgxG2N6cicKawT97UGNl7sY8fQTKScUXVCqLy9ZWEhV4
         grQA==
X-Forwarded-Encrypted: i=1; AJvYcCXbN0DiPGYQ7hbh2m5BoBPClob2s1QTvEMyhVT149wFzSUa48FzcdQVOSBL99XJvhTGbjQrh5uO6c6Ivcs4qGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxit/lZ7QY5TqSpEewTaBmGtur5ohfPUIEZzg/m55kmhd76Th3+
	7KCxh5KbLHKtEJGgCCqa+w5zaCV+5rxo9GSwLrB2stGlByazqC2PRwsTkezWURU=
X-Google-Smtp-Source: AGHT+IFU/xE7uz0+esnxj1cDrPxJjOHvu3pHVRIMHDDi5HUItW+lkDaZSEcCcFSiBLXxTcAY3ZrLhg==
X-Received: by 2002:a2e:a98c:0:b0:2fb:63b5:c0bc with SMTP id 38308e7fff4ca-2fc9d2e5330mr75320001fa.3.1729847693701;
        Fri, 25 Oct 2024 02:14:53 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:14:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v10 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Fri, 25 Oct 2024 11:13:59 +0200
Message-Id: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdhG2cC/z2OzQ6CMAzHX4X0bHVMIJkn3sNw6KDKDnZkIwuG8
 O4OjPbW/vr/WCFycBzhVqwQOLnovOSlVKcC+pHkyeiGfACtdFUqpdFW6NMkyHmudd+YijTk7yn
 wwy2H1R2EZxReZugysRQZbSDpx93pxy4vcrIrRxdnH95Hh2QO/TetbP5pyaBCIstm0LqmoW79x
 JLJOdtBt23bB40W80bLAAAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5960; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=UH/2XoV5zBduLlAxK6ecGWo1z1jfCgCLYw+ocMqnVNo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GRGMG9lIDFKE9rlxAG/TJt0fE3ewF8wegg7
 bnMfj+CfXyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthkQAKCRALcOU6oDjV
 hwLHB/9sZQyPeS3/4xDRI+ZfcY+XS9d7wt/PMMPb3IAsmHaBs2Wj7unsdf02o8h8JmZo74FsdmT
 dMvi6W5GokbS+jwGwzcuAtpEyf3jAW3jtIQl7Ls377bOwg9V08+DYrHO8YCVsvgMJ4erU21rZaD
 oazUfy7WCGwUOOpTznw+Gyx6gce8mh7z3Pca3Zdm6o1ZZe4ABPwcIuOje+fBccBqnNXKj7idXiC
 m2wmaFBXigvQuDtqDel6vEKPnP5AMD1r9Mfu2tkFSq0XoDDGRlgxHNgOyAlOSG1UQG2vAVIABRc
 GM2GJxg3GkmZvhqYbzL7nzSLkfuy3rnnZAnxbb+M7XAYCGJa
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes from v9:
* fixed potential deadlock between peer float and keepalive worker
* simplified skb CB layout to avoid allocating large mem area per pkt
* fixed double free along encryption/decryption error path
* fixed crash due to race condition in keepalive worker for p2p mode
* mitigated race condition between TCP socket init and first strp rcv
* added CMD_OVPN_KEY_GET doit handler (it went missing in v9)
* removed double 'select STREAM_PARSER' in Kconfig
* removed double include of socket.h in io.c
* sorted new OVPN section in MAINTAINERS alphabetically
* sorted F: entries in MAINTAINERS alphabetically
* switched to state "Supported" in MAINTAINERS
* added ending newline to various error messages in ovpn-cli.c
* rearranged ovpn-cli.c for better readability and maintenance
* ovpn-cli.c now compiles with -Wextra -Wall -pedantic
* renamed selftest scripts
* test-float.sh is now a stub that just calls test.sh with appropriate
  params

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
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  362 +++
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   14 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   54 +
 drivers/net/ovpn/bind.h                            |  117 +
 drivers/net/ovpn/crypto.c                          |  214 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  386 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   25 +
 drivers/net/ovpn/main.c                            |  337 +++
 drivers/net/ovpn/main.h                            |   24 +
 drivers/net/ovpn/netlink-gen.c                     |  212 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1135 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   61 +
 drivers/net/ovpn/packet.h                          |   40 +
 drivers/net/ovpn/peer.c                            | 1201 ++++++++++
 drivers/net/ovpn/peer.h                            |  165 ++
 drivers/net/ovpn/pktid.c                           |  130 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  104 +
 drivers/net/ovpn/skb.h                             |   56 +
 drivers/net/ovpn/socket.c                          |  178 ++
 drivers/net/ovpn/socket.h                          |   55 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  506 +++++
 drivers/net/ovpn/tcp.h                             |   44 +
 drivers/net/ovpn/udp.c                             |  406 ++++
 drivers/net/ovpn/udp.h                             |   26 +
 include/net/netlink.h                              |    1 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  109 +
 include/uapi/linux/udp.h                           |    1 +
 tools/net/ynl/ynl-gen-c.py                         |    4 +-
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
 tools/testing/selftests/net/ovpn/test.sh           |  183 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 52 files changed, 9494 insertions(+), 1 deletion(-)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


