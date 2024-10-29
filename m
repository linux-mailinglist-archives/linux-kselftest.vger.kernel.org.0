Return-Path: <linux-kselftest+bounces-20925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D919B473E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D5B22110
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4C1205E00;
	Tue, 29 Oct 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LoTs3zc9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B794205145
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198883; cv=none; b=j8Q3Nb8+PV8BVkloTdyJugbdIlpt3uSG3KQO4QPIWXJTq7lXwljIP/2N9uKbRS2iQ+oTvDEFELDfSppWfChVr7FJpHi2fgaLQV6OU97t10Hhn+VESWT3H5iy5ZPuzQkCJXFw0FOAuIzRuQ6tHRlPG61giehrdl648OBtrsFo5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198883; c=relaxed/simple;
	bh=Hu1KhzQ/mPXUGyE0AK7vnTBVLVxNbFml2w8/c7bCUcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fhLPQwr7sc3oXrN0k5FZeUX/66juDHEraoNmz4x8B2ELXwXcVFyKs/izAvHeLZb1m5Z1eZfcQqSIq2hdUajQXZMuibaVqmZdc4QxLlD1xX7Y91Kzq/gVsbD48KlcfPgcq81Hc5Jss2v4L+UnbEQA9vgnoSjYdSKj3T3r8lnC2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LoTs3zc9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316cce103dso69642505e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198878; x=1730803678; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFaHDr0T41HKWiMkbZ9pj+p6GJbEFF9Bz1xBJxmYU4A=;
        b=LoTs3zc9iA5VvXINEYT+KPRRsLD47WkB0AQaVozOuArANKNSuMNZ0xZX9Fk4BjVMtL
         iHJEE2OVAFocpCGZt12pbJm8yM7Xy7Ib/WguGJw/xaHHsQdTnNCmlssHXZPTjeodrf2J
         /tvkP3ZfqWLbtgQ5pXLV1XrkA++//sjYxMGXLly3mtdMGiqi9ToXIa2FNV7/aSSS/1Ym
         pHLKXfJn12pKXw08KTjFfou0+NnSXLOH988hInw2mHeOkhQMXneQj5l/o+xs9OFe38gd
         ZUOkoO9gFKE4t/robudDgJ0d7g1ROPSZALOl8VzccUwz6ebDXQFnxTK4E6W2zp/54tup
         8hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198878; x=1730803678;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFaHDr0T41HKWiMkbZ9pj+p6GJbEFF9Bz1xBJxmYU4A=;
        b=XylMJBMpWBtcqueB3kQOZpM5GRpq4MD8u30waZaSnYneIhGAGAK7VzdrUY5CXGAQP0
         qf4NauXiUK7chq7SPdfm3ydj5F8Gz7wXqa2yqdE3yX53jzy4CuP/llyk6RYmx/KlvV3u
         KMtEd4wQaF44DHDiUDQngdIpHUEMrSJBw6LnAIrB6kjRfU/9KPuv9gP9uYjqXVr9FzHN
         Eyx1swDhOFFF6PHm1kaFPqMUMnPVzgXKpjuinOrtgYpxjQYkwbxYDBQkJToZ+DVkiIy1
         dnlYs6khQdCH/BcUUaZOVe9kOpapsNQbeCYSd0BsbTxyoneK032zLrtSGsblH0Yc2zMl
         r4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZBvVJVQWmw6I5SJraaZqFb1CEG/LO2Tn7HmDxUQI9GIHHdr/qdkyFDF9kmsNYNwuWyBeLS8yko6vEbAZA32Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ha1gws4OKgN509x/0V5EjtuglJwYv8ZNH2vbjOs2vbNvM9dh
	eBysyCzJBpLp1R4DCOSFHhqucezeytTsJ7C9cM0jWj4ugjwYUoLvzXz3+RKeqmEcGfHrG19YQT7
	R
X-Google-Smtp-Source: AGHT+IENqXxnZ5AFVAQkKmGXz+A/5ptKcjzq/X/YXRc2l+r/rr2avJABfmHyzUVxhrTMAHuie4Yx1w==
X-Received: by 2002:a05:600c:4fce:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-4319ad29f7cmr127948825e9.32.1730198878502;
        Tue, 29 Oct 2024 03:47:58 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:47:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Tue, 29 Oct 2024 11:47:13 +0100
Message-Id: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADG9IGcC/1WOzQ7CIBCEX8VwFgVainjyPYwHaFfLwaWBhtQ0f
 Xcpxr+97c5+MzOTCMFBJMfNTAIkF53HvHC+3ZC2N3gD6rp8IIKJmjMmqK2pTwNSyFPJttG1ESR
 /DwGubipWZ4IwUoRpJJesWBOB2mCw7Vent7a/G4cr2bs4+vAoHZIu/CuNN5+0pCmjxljQnRDSd
 PLkB8Cs7LJdSUmc/aBCflHOMmsPSlZMKWVB/bPLsjwBqopVYAcBAAA=
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5217; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Hu1KhzQ/mPXUGyE0AK7vnTBVLVxNbFml2w8/c7bCUcQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1pIFDeq9+/uEw6XGgPu2/BnHNfVoQZvAknr
 J7YkRO6b/6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9aQAKCRALcOU6oDjV
 h7XLCACnLNc0NtK/SAcf2gwZ8rgS7k31jxJB8NWWateDObctvjkM8YiBxgofvXGwUHoliow6WQC
 DPiB/YgJBuPCoV5EHnocUAlSmjjgycEQbGDWElTncbn+r5kjwR+blZZD3lJjJ2X4e2yzsuB0z8Z
 O+YWMz8/56DJVMJE/WflXGjWeRCzFlfwOde1T7F1PS0yN/69dZci8+waBX+qhlJZApQs6n9Wtfz
 qFt26Tkbx8VmMJUZwyL0dGlMun27IIhyYGCmoFRXooYTOrVQN/PwkYoyY9GVqLyZ2rk697IvAUR
 MZ75GpYx8mhBeE/govlsGeRkXsDwZITFO3gRrZj9R3C5XHjO
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes from v10:
* extended commit message of 23/23 with brief description of the output
* Link to v10: https://lore.kernel.org/r/20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net

Please note that some patches were already reviewed by Andre Lunn,
Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
since no major code modification has happened since the review.

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
base-commit: ab101c553bc1f76a839163d1dc0d1e715ad6bb4e
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


