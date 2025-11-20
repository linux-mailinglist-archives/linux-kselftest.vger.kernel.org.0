Return-Path: <linux-kselftest+bounces-46055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A8C72015
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDC714E1A22
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DA2F745D;
	Thu, 20 Nov 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsxa+VKd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82E1CEADB
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609834; cv=none; b=jhbzWLbPl2xKavkaoeCBbn/H/paCNGS4gqeQf4aZAPfyX4OKnSeH0itLq1bnbcE1/QFHbL5N80NQps5jILPued1os4QRwt/NHD0IvOt1JCcMam8K2uWKGaMYzFe0oYBxWECjyGk4yUKDU+NHGRNWDDDScQGsRw+lCM4e7w4TsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609834; c=relaxed/simple;
	bh=ECDBbREziOCBdmljpaOyZYKnPyj7Q88QKnhf5KEHVVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cQKZJh9Nu7fvQAVYKNdLj/dRT1Y5SojUzRNuQkMWVC2cRuS0NrruuyuBgA8NL5GOvAej3FykCdqG+TtcmPsF4HLwA5dRSInilXuLTlUqAtBb+N7PLqMmd7HkPuPBvoY2QRQWE5XfOSi3VmFBzKHTEMj+0bPB/DHZO7wSODi7G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsxa+VKd; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640daf41b19so554395d50.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 19:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609831; x=1764214631; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkiaMiVquFyiirALpYhy26Yx4mEN1PZCumzzoxIfHM=;
        b=Qsxa+VKd1mpF7UMBzUypqSeI2fpL9oercFH36BLY0JFDDSV1v6mzYlAvlrroyjRbw7
         I/gd8y4I1aOQuqt89THFWvvobEQt6MjyL2cSH67gw6shL07YZaHBehY8b1UAcxooTtah
         kHGDLiRh3BGI1WbaiJaq8yrqgu3aQ4gSRH5B35xbheyVT6GvSdVZT/T2opISaSr04BhS
         s2SXG+j9E6ksMjKkWQz+Xwo2WeKSbaQRDmO+Sn4ajetlbrnhuv5qaB7Lr7mnvwFqFw6O
         UftCsGlJ8Uj45P34gk0OkTjJEaEIhbw0OvMnLxiu1/0j3qSSH3LTD03EhQf4PSCqICTW
         fYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609831; x=1764214631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIkiaMiVquFyiirALpYhy26Yx4mEN1PZCumzzoxIfHM=;
        b=L2yhJwqCU9WORNHo+tIBHPc0X46eP9YyWsDI8Ngw36Nns4sJfa23phyWnykgf1kHRw
         ySsKegJlGMwS+clDl6kroz1UWhMIo/a4ZSHQ97lX7v3u646yx5WyMRVnRTo2jv0PPghU
         +z7p9xDp6XDqSMDxws3ehrKNchsCu4aOJmbxSr+XCUfzlqfmkLCwPyjMNNhh3XhMxtFZ
         Y0HAy8K0bdyejZ/XEGVZB8Myp1oN0LxebTShDxurcnxzsQbQrvJOEGkwv1P4xf9btIRo
         e+C/G6DVx7oNxvYLdU8WvIwCvw1HZ8Hm1NohRUtPansfFRoCWy6bJ4PAJ7HxTFjcdBqa
         OkNw==
X-Forwarded-Encrypted: i=1; AJvYcCVPyZnrQ/DFqmNAdv2UBlJraRryodcu9ipdJPXD8JpDz48RnvqTOljz2Oe9xCDDIRrBxLCgpUExhtBtAls+QtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkwVJMwrkQd6TR8ghHsowi2/3oVlGLgGJdhN6hlphg8XyCyyk
	Rz96OPN5cJzTn/DVvTA2pOqkwd8NeF9mndFEgbLNxmK+n6JErkulRFkg
X-Gm-Gg: ASbGncucb9pqgRaZieC/F1i8CGgPcL2RZ5MRpOLxvReEl/mb03ixS5VUa1TovIIA0wS
	0vgoFrXK+Dl4hbAp6zQJumwNxbPwkVUT5ZGHPQHVJCE9XG9AdxTxufhBejbnX8i3FA96RPyhDuD
	O94QndgzSRocCtZf6N5jcNCJCNwVgMyk9e95N7wleHRmWmHJEmVxylkxiSzzWYCZRl/pSuoxflX
	FUysHpr2FGFJwS05V+WpJ2KKWXpZBVLlnzMgUqrUJ0YULD+e7GiQiyVpU34x/BlDf8NaRQYuKm7
	h9ORVM27obbF47hBymg9JocfiuGjCFaTXwfMt0kh+ImWCp7p0givDnXUnSV+bqJIUfhM3e3lH03
	zffg4HmMv8fK90dV55WjUMN3nIUynxcXVYPeN0wGJUi++8JdonkZhChysZTXDXToAtlHhYaQPL3
	7BHgxgfQuTo5sILgO99MK5cg==
X-Google-Smtp-Source: AGHT+IFKpR/FkxuF8iJIp+zHB2TEb80Y93lcc8kYP3bFlmrPbGL1JL+3IZD61Ppr98fvNX1s6GOhrQ==
X-Received: by 2002:a05:690e:4009:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-642f8e16330mr648848d50.33.1763609830900;
        Wed, 19 Nov 2025 19:37:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798bd22fsm4151977b3.25.2025.11.19.19.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX token
 management
Date: Wed, 19 Nov 2025 19:37:07 -0800
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOMHmkC/5XQu26EMBCF4VexXO9EY2ODTbXvEaXwZQhWwkXYQ
 bta8e6RKBJERz3S9x/Ni2daEmXeshdfaE05TSNvWXNjPPRu/CRIkbeMS5QajbSQw+JK6MFP3j8
 p9980uBEirQMNUMIMZfqiEX7mXBZyA0grPYlGRY0VvzE+L9Slx1585yMVGOlR+MeN8T7lMi3Pf
 coq9vtetSgvV1cBCNGqWtTWa63xPlBxb2Ea9tQqD7wQ13kJCMFgbCrto9LVia8OvKyv8xUgoFF
 e1T46Y7oTr/94gbK6zmtAUE3wRndaaksnvv7nBarrfA0I5KwJnYoK/fE527b9Ahk4QLRzAgAA
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series improves the CPU cost of RX token management by adding an
attribute to NETDEV_CMD_BIND_RX that configures sockets using the
binding to avoid the xarray allocator and instead use a per-binding niov
array and a uref field in niov.

Improvement is ~13% cpu util per RX user thread.
    
Using kperf, the following results were observed:

Before:
	Average RX worker idle %: 13.13, flows 4, test runs 11
After:
	Average RX worker idle %: 26.32, flows 4, test runs 11

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
optimization. It is an optional attribute and defaults to 0 (i.e.,
optimization on).

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemb@google.com>
To: Neal Cardwell <ncardwell@google.com>
To: David Ahern <dsahern@kernel.org>
To: Mina Almasry <almasrymina@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Corbet <corbet@lwn.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v7:
- use netlink instead of sockopt (Stan)
- restrict system to only one mode, dmabuf bindings can not co-exist
  with different modes (Stan)
- use static branching to enforce single system-wide mode (Stan)
- Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com

Changes in v6:
- renamed 'net: devmem: use niov array for token management' to refer to
  optionality of new config
- added documentation and tests
- make autorelease flag per-socket sockopt instead of binding
  field / sysctl
- many per-patch changes (see Changes sections per-patch)
- Link to v5: https://lore.kernel.org/r/20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com

Changes in v5:
- add sysctl to opt-out of performance benefit, back to old token release
- Link to v4: https://lore.kernel.org/all/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com

Changes in v4:
- rebase to net-next
- Link to v3: https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket
  leaked tokens
- drop ethtool patch
- Link to v2: https://lore.kernel.org/r/20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com

Changes in v2:
- net: ethtool: prevent user from breaking devmem single-binding rule
  (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- remove WARNs on invalid user input (Mina)
- remove extraneous binding ref get (Mina)
- remove WARN for changed binding (Mina)
- always use GFP_ZERO for binding->vec (Mina)
- fix length of alloc for urefs
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- Link to v1: https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (5):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: implement autorelease token management
      net: devmem: document NETDEV_A_DMABUF_AUTORELEASE netlink attribute
      selftests: drv-net: devmem: add autorelease tests

 Documentation/netlink/specs/netdev.yaml           |  12 +++
 Documentation/networking/devmem.rst               |  70 +++++++++++++
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |   7 +-
 include/uapi/linux/netdev.h                       |   1 +
 net/core/devmem.c                                 | 121 ++++++++++++++++++----
 net/core/devmem.h                                 |  13 ++-
 net/core/netdev-genl-gen.c                        |   5 +-
 net/core/netdev-genl.c                            |  13 ++-
 net/core/sock.c                                   | 103 ++++++++++++++----
 net/ipv4/tcp.c                                    |  78 +++++++++++---
 net/ipv4/tcp_ipv4.c                               |  13 ++-
 net/ipv4/tcp_minisocks.c                          |   3 +-
 tools/include/uapi/linux/netdev.h                 |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py  |  22 +++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  19 ++--
 16 files changed, 401 insertions(+), 81 deletions(-)
---
base-commit: 4c52142904b33b41c3ff7ee58670b4e3b3bf1120
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


