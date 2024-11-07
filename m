Return-Path: <linux-kselftest+bounces-21602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5AD9C0778
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23E6B21AF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56E210186;
	Thu,  7 Nov 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB/vk+ZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8F1EE019;
	Thu,  7 Nov 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986223; cv=none; b=ITuGUVCTdAMR8sPif+BaUGMyvYovNMHCWNBOyPCHSuYdwaYk9sGyz7hBNX9GobF+XzTnOFkXjwFUToHNIrzVs72W7s3aQp90MdjntrjARtTV22ou6T5kVbMOdMrJn3Gb1e93MCe5Cp+9faeC+1PYlduo2o+LfhRx26rUwFkGy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986223; c=relaxed/simple;
	bh=qRs2QLy5RFoOno8jhB1SgonJez5Q4hYoRoGt5zea3oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHLzQiFSVwMhCktW/EDrnjibLFEEnIq9XhcDsHCmo2iKr589a/98sT2zufbPh9g/fADDyOzcbxLvlgMH9k1bPx/0INu9uXK8oSQgZWdRjDg26iLZBCFgB++VRaeh5uS69pIhjE0mdJJWQQdM1QziwppejGAJ3JT8ieojy7r9Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB/vk+ZC; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e602a73ba1so603636b6e.2;
        Thu, 07 Nov 2024 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986220; x=1731591020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR7EliZ8HIjdIJ/1+gSceKWANQc9uwIkd6+yt06yH/o=;
        b=HB/vk+ZCloSEHdBiyZbiOVjiUsxBesaO2wRF0jOB8NtElxz9dz1yYW0RL61w6S3XSp
         Rrrrm6lk04YIugVyYWo0JU8Ooi0u27V7+rg5Xt6c70z4L2NlB/TODVkJHEdaX3HQBQli
         yGzL819dWlcU8h8JugX/SJCBDeH4xtuSRoPXUXnMW63R+hnf8TduO4HRgbwDVmG/i1/C
         eB06d7+V87Z4WvIsdmV6fVnlP0dFwM/szu9+QIbM2UoZCoOzzlLPFk7KSJrdgD1J3rYa
         N8ypOuQdDby5YZjN2s/yxCOXZao1t4JiI/xxNA9EyMYkXTUKs6sqLDyxrZmSZx+jPgaU
         q9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986220; x=1731591020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR7EliZ8HIjdIJ/1+gSceKWANQc9uwIkd6+yt06yH/o=;
        b=XLGIq0dEoWNWSnbeXmwqmx68OvT3lTsEZPouqzivHwyWoR1jAZtiWzTAEFDwAt/4CW
         QZ2MdBa1yc/rDCFfntkbAjufBx3r9N0HW7+/jVbqNWiWDgm5cSFFfq7YqOt+k8wwvLhF
         eVNrVLOycXFf76/NVJTDbsveLBofoMAPy1w7ng+hp76MA+fOjhU9AvjDBN7LhG2zV0s+
         Gh+oLkdDvZtCBcDta8PS+5raDVx7wCjlxn0YfOrXg6i7YAhFcFcjv+j2PLE1FqDIqXrS
         AowAV0bgoJuhgIK4hOOjhj8SEaE9xi/A8iEJCVz71sSKxVQ6uFiya+A278cn2Jl64d2J
         5UCw==
X-Forwarded-Encrypted: i=1; AJvYcCVxjHi7KjscTRc3oi76RNPa1+uZSldKsMB+Mz79Vma55A5mGeaPjbjHT6M4uS2wrpfomZ+Hq+shOIJahhMHryA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkY8cd2aHSWyCEEaUsgHZUq287o9Ekw5Vg/Jt8ygRc4R9fd/m
	4fg2YclWeZTwKBjrGOYffGrM9RJE44HNyOkZ4WFNbgZeB/SvuMXH91RI178/onA=
X-Google-Smtp-Source: AGHT+IEvkqaPEtWSW95fupk1k9ZpNhqP0he9eUltgV5yntcun78itAlESPiOjZjItpmXTd1p9D4cgw==
X-Received: by 2002:a05:6808:1528:b0:3e6:14a6:4288 with SMTP id 5614622812f47-3e78fcb757dmr1270125b6e.11.1730986219898;
        Thu, 07 Nov 2024 05:30:19 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:19 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 0/8] net: Improve netns handling in RTNL and ip_tunnel
Date: Thu,  7 Nov 2024 21:29:55 +0800
Message-ID: <20241107133004.7469-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
RTNL and ip_tunnel, to make link creation more intuitive:

 - Creating link in another net namespace doesn't conflict with link names
   in current one.
 - Add a flag in rtnl_ops, to avoid netns change when link-netns is present
   if possible.
 - When creating ip tunnel (e.g. GRE) in another netns, use current as
   link-netns if not specified explicitly.

So that

  # modprobe ip_gre netns_atomic=1
  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

---

v2:
 - Check NLM_F_EXCL to ensure only link creation is affected.
 - Add self tests for link name/ifindex conflict and notifications
   in different netns.
 - Changes in dummy driver and ynl in order to add the test case.

v1:
 link: https://lore.kernel.org/all/20241023023146.372653-1-shaw.leon@gmail.com/


Xiao Liang (8):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Add netns_atomic flag in rtnl_link_ops
  net: ip_tunnel: Build flow in underlay net namespace
  net: ip_tunnel: Add source netns support for newlink
  net: ip_gre: Add netns_atomic module parameter
  net: dummy: Set netns_atomic in rtnl ops for testing
  tools/net/ynl: Add retry limit for async notification
  selftests: net: Add two test cases for link netns

 drivers/net/dummy.c                         |  1 +
 include/net/ip_tunnels.h                    |  3 ++
 include/net/rtnetlink.h                     |  3 ++
 net/core/rtnetlink.c                        | 17 +++++--
 net/ipv4/ip_gre.c                           | 15 +++++-
 net/ipv4/ip_tunnel.c                        | 27 +++++++----
 tools/net/ynl/lib/ynl.py                    |  7 ++-
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-name.sh   | 10 ++++
 tools/testing/selftests/net/netns_atomic.py | 54 +++++++++++++++++++++
 10 files changed, 121 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0


