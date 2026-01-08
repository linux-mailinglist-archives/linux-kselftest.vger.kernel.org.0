Return-Path: <linux-kselftest+bounces-48465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC558D00BBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10F5301354A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EE19E7F7;
	Thu,  8 Jan 2026 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVifHYih"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03519258E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840719; cv=none; b=dV6v2Qy2NzDxX9c3Cjph3zYhFkNVy+idfW+8zFpiZVxh4gkxLIJsCVA4a0koCObDn51cBuE+hnDTSc2KLJLHpBpb+gIcy1iwA509v+VActyMwjUVsBUwqNFnW0hwm7YAkKC2H3EDPIiQ7j5IIlPjn0iF8xo7lm/QZ0McNUj7/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840719; c=relaxed/simple;
	bh=do9l6eGvvyDKINEPSQ7IHQBEOd/mowpyOxaGE0SLNeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HOLJj9eWarz2xf4GUdttgN/FUjYMh2zBiI0c4/RTKnla7304ML07jAmar/uujVshARAc8u5KhKJ6yB0nl/JyXo5yzuRq7C/VSjkGPHq6XBZv8ugYtyzeVNJpchOdds6+GsmtlGsSdLcEuerq42lDq3X/TxPO/KkhXqFeENgmVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVifHYih; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4fc42188805so28839821cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767840716; x=1768445516; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ0O3nuDBxLsxoMKJl4tF5zDnnuLWj/3NEIyxU+lc3Y=;
        b=FVifHYihtgBsKIWSUuaeRz1qARDQJesQO8MzKdzbtZGER68eiLWhD4mfi6mwMsnzIC
         sy/dnSMXUu/N+IY/srIUpeAbiv6thO1FoYpbozfLeEQFw2M+9HGjbtZwYt/sWXTZPRwk
         E2FYuZ+av5QvsfwepMvuMf87SQutODYPs+RtuJEtrMRHHE30QlOllBn8LCLj2dehtc7K
         0JIXDHlPAdpL15Czw6DRQOckQLNfr7eBoi/F52nEZ0DQ9kKt6sxmOyaF2IWmP1pgT9YY
         0uMl9u+bkpjvxBiRHa7+TdWPY4Zy+xaivW/QCwtvd/alqlHn8MtpN+RfX0DCKER5qJhQ
         M3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767840716; x=1768445516;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ0O3nuDBxLsxoMKJl4tF5zDnnuLWj/3NEIyxU+lc3Y=;
        b=pPKyP9sezm7JefSBtJpfA4KtjlG9BpJR5ev46C9Fapx1gw5QuOnfiS3UdeJa4LWdUf
         6ASvqhMFAYTGN1tUqCUrim8baTRcp9OCqSrhBYusv0YwHk81xTUzhqNTJqkIlgiS3rXM
         TDSuEx4iBvoBrJNCf61KEh5Q908t5yWnJ9XijhQm1aWpWZMC2jPI2RMKhlcFzjTu50UF
         VN5BByrAolpvhP+6Sov3+cA0MUs+wNhXl7+DJkIQ/3kgUHJfk5zgnap36pGzOn5bjru0
         hbYxuqNW19zj2XMDWCGL0hDepJZUwd4gjJpFaBkETc5RZiIc2SXsHPz3QU0kJmXRYm8n
         A6VA==
X-Forwarded-Encrypted: i=1; AJvYcCXV9iepdZgwfxdBIEEzTnU8fRDyPAJo5dW4eJb90JdCUqpRd4PnJOIpBB2ecK2gp3ddb/naXr3hgkiOcQX29ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLb+AfhmJnCe4izph2tAxxnabxwr6vpx11a1X5ff1M4b8rWxMz
	uZa9cTAH3F39tSscQN1+XVPa0LJjSqMzLbC1FO98iV77VarY/BC6jZVpx0Fb1g==
X-Gm-Gg: AY/fxX6GsOpcpuzfYE58wHoovFRK6ikBofZGzBXDYqQKalPVl/70zs+DDVcCiLCmkMa
	2ZczNmRF5Asda/sJI8/CMn26z9hj/JzT+7Xw8T5iX1Im4GNdaVGiUPpb2ONt8TeTzrvAFjdEZ8a
	ZzDPOaRiYgtVUMPkzmptgmn9Z5ksM9gSynUryYG/QBVNz/TZG4uqxnDCBJdnX46TbCxDEwqTE8V
	nGHE4+2MziQ26AReIxlJ79XYff97TJaXx+pcIVBwA0fJro7vzXjfIYMxgnd+mUyrN9mJLFDtN+x
	fNRlXVlgOzVZbRtyoLStk5I1vqnMYNfrloDtolU4FOkNr/CTYLEC6XINGG1zKJnKFReIPB/wW1b
	0SINgLRxqB/SPMRMTQvs4VG4wnlOANMveKn/uBpz6VNPpjZw2X4vRPY1SPFo+RtAeGB5rXf7jxG
	0dNLMGiBZOPA==
X-Google-Smtp-Source: AGHT+IFTPsy9VwPhKALWTvLAxLL4YRWKWUiavLYzsq3SmgBSOEcDED2k8hwXyHd77UWp0Yyjdri5kw==
X-Received: by 2002:a05:690e:1404:b0:644:43f7:11b8 with SMTP id 956f58d0204a3-64716b33a92mr3911696d50.13.1767833919327;
        Wed, 07 Jan 2026 16:58:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80be64sm2714670d50.6.2026.01.07.16.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:58:39 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v8 0/5] net: devmem: improve cpu cost of RX token
 management
Date: Wed, 07 Jan 2026 16:57:34 -0800
Message-Id: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAABX2kC/5XSS2rEMAyA4asEr0dFfsixZ9V7lC78UJrQJhliN
 8xQ5u6FLNqQXdaC7xdCP6LwMnAR1+ZHLLwOZZgncW3cpRGpD9MHw5DFtREKFaFTHkpaQk09xDn
 GB5f+i8cwQeZ15BFqukGdP3mC71upC4cRlFeRZWsyoRaXRtwW7ob7VnwTE1eY+F7F+6UR/VDqv
 Dy2VVa5zbeqR3W6ukpAyN5YaX0kInwduYaXNI9balU7XsrzvAKE5DC3mmI2pA+83vHKnuc1IKA
 z0diYg3Pdgac/XqLS53kCBNOm6KgjRZ4PvP3nJZrzvAUEDt6lzmSD8XicdsfL8w+1toAgQ0zO2
 FaTSTv++Xz+AkyAtcrSAgAA
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
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
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
Cc: asml.silence@gmail.com
Cc: matttbe@kernel.org
Cc: skhawaja@google.com

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v8:
- change static branch logic (only set when enabled, otherwise just
  always revert back to disabled)
- fix missing tests
- Link to v7: https://lore.kernel.org/r/20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com

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
      selftests: drv-net: devmem: add autorelease test

 Documentation/netlink/specs/netdev.yaml           |  12 +++
 Documentation/networking/devmem.rst               |  70 +++++++++++++
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |   7 +-
 include/uapi/linux/netdev.h                       |   1 +
 net/core/devmem.c                                 | 114 ++++++++++++++++++----
 net/core/devmem.h                                 |  13 ++-
 net/core/netdev-genl-gen.c                        |   5 +-
 net/core/netdev-genl.c                            |  10 +-
 net/core/sock.c                                   | 103 ++++++++++++++-----
 net/ipv4/tcp.c                                    |  76 ++++++++++++---
 net/ipv4/tcp_ipv4.c                               |  11 ++-
 net/ipv4/tcp_minisocks.c                          |   3 +-
 tools/include/uapi/linux/netdev.h                 |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py  |  21 +++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  19 ++--
 16 files changed, 389 insertions(+), 78 deletions(-)
---
base-commit: 627f8a2588139ec699cda5d548c6d4733d2682ca
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


