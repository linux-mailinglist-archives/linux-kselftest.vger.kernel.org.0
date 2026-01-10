Return-Path: <linux-kselftest+bounces-48663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604BD0CEA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 05:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A64E3031713
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 04:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB2224AE8;
	Sat, 10 Jan 2026 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwBCE3Je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AF1E5B95
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017735; cv=none; b=XLLy3A3acEffPMCU7W8YRWTObm9L3OYluE1NABI13+25iNxHLylgmZyfV1559S9KW3ZHmYgOesegl6tt6M0UNNbuYzdhP/NTJ8L4mT+k0Xdr2Ls6S4ZpyUmX85C/aHs+nfab6/QYyYqAl4T7fFbnnOZ/SjPgqvFBQjn4vunyx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017735; c=relaxed/simple;
	bh=zRMaG2UZoaDAk8JWg4Py4arxiWvpQFKHkL9OU1MsMMQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YHwHYCxzi4bGtBTY7I1HV4IEBx4heuR40yKxw6wLnMQBlO+y4+O55qPioucdiE3lhznLhfFfRWXJvUWupNEUKWYKtSR+9l0jXM5LsMKbVbDaX1IQjQvs8B/N/KBv62PwB8lpe3912E3rasLqiSFtmOZiX6Rb8rDFJJrDtB1GKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwBCE3Je; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5636274b338so1246548e0c.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 20:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768017733; x=1768622533; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzuCZ10ab2Iorj0lcSOmaTCThwhF5YTUtr2Jp++0Xa0=;
        b=jwBCE3JeDtidtV2euN660u1ukXxFSYT7ne9TURdyEC2mVW5XMRHYaKOvTluGo2X2h4
         noRCtqUHuRFFuz9PzYgrV13WE9o3EBPmkQYcJRrwYKIWjfQ/EXU2dPCCeZlf9uM5aBiD
         2e4cw1KxMk52mANgHDic/P5RkFR6q1SOpW7yDHyK46Og5Gde2aJI6kToQ4qMK1IP3Ihe
         VmJpmP6fMR1Gc31pNxv+PomnWCiBYdAxpO6u52yZH5mBkAzhiF1APlh+yskb5TAmJEG+
         YUyEGdVO3tdoi+EAJRcmIWgbO8kJ5Rg/DVxYPneeLwQ0jcNt8NMu5GHSsnyE8Q1JqEpt
         Bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768017733; x=1768622533;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzuCZ10ab2Iorj0lcSOmaTCThwhF5YTUtr2Jp++0Xa0=;
        b=T0eC5/bY6oAFklhUZVjg9WjlS8ZHD4d3GhhKzLwSX0V4Z4LvCr/OGOtO9eIri7Sxkc
         /nI0+Gkg+jkwBE/RzCfAFcnv0StpmjzjDQppUYIbClip4hz/QxDaAOB8G7Ig7UFnMvHg
         tDH7H7ccuOwOuknau97hoWssnTcH9jZP4G2bm5txfzbak7qQzqjoE80w5MRGl9wBt5iB
         nDqAqxuZzi3b9H4duWzltOz8qewF5BC624ZtTuwDIviom7ZAsVZUYbs870Zmzc37k6Wh
         B3OjA6quHmb0pzrAqCWWxMqtoCWukHKWSz5vHAYG1M8Nh1DGaaoT72sG5liKA1ADnJ4v
         pSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlqFVtfcPu82HFUfyZaUqvJXg1HKkd3Uz0YN2Y2IdvA7C31znf1GFx/absqcN0DIeO1Ap91N+yT5lpidIZi7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/ok6sc2nRc6YALJ4jrvG6+yKFs6NLs+vomEDO8epUBVqU8F1
	TWhvKNSOfraw3n9fFplByDRifVB1AvS14RzVwhEXGFUuozaj/AoQAx8thZdFTg==
X-Gm-Gg: AY/fxX5gb7LrhJRXb+kfz4Pvv9v8F1IRJN9gNkbUfS4tsjf6gemA7i6xGElIgzy/XfR
	73jHTdipaNTCuIGNKttlAMDpmP/3qdjxsbhjhGXWNq5ZyQxkgUR5WAZRltZGy+QKHWvLkGk4Ubp
	MShzSh/YvVlqDvKPRT6XtRbACMgciBABQ58tVBhJbPwpoAVxuGGDewEFij/B29fVzd8QyC3R87h
	8IIDnciwBaHHyC3LgcljDueKUHQrsuHk5EICMm7gLmYBT30fZXPjJfIpYuOCaGCNRbWZ29tRu5j
	wNGoZUltwWXporqP2JOYzRQptDM752BfaEZNbbqJIp16jlvaQf2Y8FzJiLzaK+ooNVLN9iD97QH
	HBXFdmebbpvIzHc4ECRkjb4j8kuuowHXWqcyMM+72M1vTlgYJED2nIulSP1IxvJtjhtGFeFrGl/
	PG5kGk6yisLQ==
X-Google-Smtp-Source: AGHT+IEz37L2wQQJA4qX8j5KYwrwN9NH1ecV7Azu8uWOr9xF8kdhENvXLiTeJfu5CUWtgau8Fq/JnA==
X-Received: by 2002:a53:d005:0:b0:645:5297:3e5d with SMTP id 956f58d0204a3-6470d31648fmr10030592d50.46.1768011539825;
        Fri, 09 Jan 2026 18:18:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790ae603282sm43469157b3.13.2026.01.09.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:18:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v9 0/5] net: devmem: improve cpu cost of RX token
 management
Date: Fri, 09 Jan 2026 18:18:14 -0800
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOi2YWkC/5XSS2rEMAyA4asEr0dFfttZ9R6lCz+UJrRJhtgNM
 wxz90Kgbcgua8H3C6EHK7QMVFjbPNhC61CGeWJt4y8NS32YPgiGzNqGCRQanfBQ0hJq6iHOMd6
 p9F80hgkyrSONUNMV6vxJE3xfS10ojCC8iMStyholuzTsulA33LbiG5uowkS3yt4vDeuHUuflv
 q2y8m2+VT2K09WVA0L2ynDjo9YaX0eq4SXN45ZaxY7n/DwvACE5zFbqmJWWB17ueGHO8xIQ0Km
 oTMzBue7A6z+eo5DneQ0IyqbodKeF9nTgzT/PUZ3nDSBQ8C51KiuMx+PYHc/PP9RqAYGHmJwyV
 mqVDrz75Q1ytOd5BwheJG+ckVx5s+Ofz+cPGcVR5jEDAAA=
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v9:
- fixed build with NET_DEVMEM=n
- fixed bug in rx bindings count logic
- Link to v8: https://lore.kernel.org/r/20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com

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
 net/core/devmem.c                                 | 116 ++++++++++++++++++----
 net/core/devmem.h                                 |  29 +++++-
 net/core/netdev-genl-gen.c                        |   5 +-
 net/core/netdev-genl.c                            |  10 +-
 net/core/sock.c                                   | 103 ++++++++++++++-----
 net/ipv4/tcp.c                                    |  76 +++++++++++---
 net/ipv4/tcp_ipv4.c                               |  11 +-
 net/ipv4/tcp_minisocks.c                          |   3 +-
 tools/include/uapi/linux/netdev.h                 |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py  |  21 +++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  19 ++--
 16 files changed, 407 insertions(+), 78 deletions(-)
---
base-commit: 6ad078fa0ababa8de2a2b39f476d2abd179a3cf6
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


