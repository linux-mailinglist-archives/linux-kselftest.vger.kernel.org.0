Return-Path: <linux-kselftest+bounces-18276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D50984156
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A654A280DE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F114D28C;
	Tue, 24 Sep 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kpdz6JLD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D080C13
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168477; cv=none; b=TW3d4AUirYZ64gwPO0TZ4ty4ibh9zLiGpm/J8KnBF51tjaiF80G8EiEPGB3nnEHDLPMA3pxaVYRmr9eHx1sptzrdVmfhl8AoUC5WjadOmbqL1YICBkpOAaNqhBvcaQT/Tq+wHd1Gia03Q5EjG0A3XLIj9YK7BLQ5cea39EnNN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168477; c=relaxed/simple;
	bh=YdshsQ9wIwHRRtPCOiCd5UbwMTOFheEkbYzE34S8Kag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=DKMVEeCW5ygY+RHjjp7uI+dcDtditffCTLfpzp7gDKXKWhz+a4DzS0y1/i8gvc6MUhRNoMNqnwH8IcDIHVgP6vniIggP+P98C0qVOcdS5bu8Lzb6xbtYEwClYvJmq0qmuQ7g33wT+So6ZL+uXrHwvaLHtdbNujvbe2wIt9IzchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=kpdz6JLD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so869116466b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168474; x=1727773274; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtlB5qy8auRtRPL0RduaDGTybS6HddlcQeuq60a1IJQ=;
        b=kpdz6JLDigWZ25BTlUN5uLDMQqE4wRgoGcdSxPGWsIizBMkIlS2s0HxDyeJSoHhKbx
         G6z9iWzE2fqZyH9RZ9cyVAoi7YMkVGrwTkwU6hwYMrTq4irhvc/4SftL7pd4HLe4r60x
         c84qx3rJQ+rF3YYgyjSDQFHq+9q5yrqufSBaRvhFVqEN5qAu+oadcyRcEGMygwjLj/YW
         xsbeMvASwkuDrcwbx7R7WcTozH4CJSHDtp0wrNmp9rNQGHBecHYNfBlrDJEuNXuC1CAt
         SVZYXDxF1FOaI6t5dS1fLt4hJJ0RlxSgOJ9q0GscMXNH+ASRq86n+MbQ7nDio14tgOva
         5PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168474; x=1727773274;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtlB5qy8auRtRPL0RduaDGTybS6HddlcQeuq60a1IJQ=;
        b=HhjW9wG1yXYRnVsNpFtHi+2+6nYGUiv+tLzlETWsJGCVT7KkyLbn9vXspcgERYL6xl
         sHUGtQ+c+f57ETUQvFDlL7N/nw6Inor4UK1qT/svRVw/b6J5dXNdMcfGYFwyDIxWOw84
         dMjF6QYnvPVZw3R5ONoO2RZe4tVcbusHY5NZXq1Ha2kq23ogkN7d+7APPgny1abY3Zkw
         4TuawKlRzVqurhEdTmzxMTe2gBduGYBGs9dzboD1CS5mOVy8J6UnKn3um23SdgzVOcr8
         CWZbbgKDN5ainyVgx7BHsuHLgrLTUCuij6vjnO9li9b89a+N+7XdcBOMl4MdeIbgGwd6
         xJCg==
X-Forwarded-Encrypted: i=1; AJvYcCUs2WOKa4qFuAG/gVTqyHsOAXSMzw5k4/oHRLVd0ewMpDEwKfHkvtGE1MqI82EgaqAhs9MjFZMmuIptjreWAII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvwngTcs1s5U0CH+KkyjGtGiXqDBZzzlwjmwqRVG35BTgkxmH
	E/ZklhHlaROJd/kiImqL52YZh1vAFfNAM9pJuoTX2Fh2nFUFfjeqgMR78IQbQ+5Z6m2MIWa+oNs
	NdY7XEtl/
X-Google-Smtp-Source: AGHT+IHaDReVxS3zm/sAwED6+qiRDBe9ZLqtWPgerAJOI3AbbKp71Sg7dP4SnruIEzwhcJDcfUid1g==
X-Received: by 2002:a17:907:d3dc:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a90d4ffe2a3mr1287940066b.21.1727168474351;
        Tue, 24 Sep 2024 02:01:14 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930f188bsm58641966b.153.2024.09.24.02.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
Date: Tue, 24 Sep 2024 11:01:05 +0200
Message-Id: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANF/8mYC/4WOwQrCMAyGX0V6tiNps256EgQfwKt4mGvnwnCVV
 oYy9u6WgqAnb/nz5/vILKIL7KLYrmYR3MSR/ZgCrVei7Zvx6iTblIUCRUCgZYhRukpXtt64rqk
 qkS7vwXX8zJaTOB724pyWPceHD69snjBXSaIRoIZSIWCBRKSURNkM3PPgC2/TtLPNa+Rn0fpb9
 kzqi8USCQ1RoQwYMn9Z/WEJNljm5yctQbZGQ5LZC9TqB1qW5Q1l3BJkFAEAAA==
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Introduce the code to compute hashes to the kernel in order to overcome
thse challenges.

An alternative solution is to extend the eBPF steering program so that it
will be able to report to the userspace, but it is based on context
rewrites, which is in feature freeze. We can adopt kfuncs, but they will
not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
and vhost_net).

The patches for QEMU to use this new feature was submitted as RFC and
is available at:
https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Moved tun_vnet_hash_ext to if_tun.h.
- Renamed virtio_net_toeplitz() to virtio_net_toeplitz_calc().
- Replaced htons() with cpu_to_be16().
- Changed virtio_net_hash_rss() to return void.
- Reordered variable declarations in virtio_net_hash_rss().
- Removed virtio_net_hdr_v1_hash_from_skb().
- Updated messages of "tap: Pad virtio header with zero" and
  "tun: Pad virtio header with zero".
- Fixed vnet_hash allocation size.
- Ensured to free vnet_hash when destructing tun_struct.
- Link to v3: https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com

Changes in v3:
- Reverted back to add ioctl.
- Split patch "tun: Introduce virtio-net hashing feature" into
  "tun: Introduce virtio-net hash reporting feature" and
  "tun: Introduce virtio-net RSS".
- Changed to reuse hash values computed for automq instead of performing
  RSS hashing when hash reporting is requested but RSS is not.
- Extracted relevant data from struct tun_struct to keep it minimal.
- Added kernel-doc.
- Changed to allow calling TUNGETVNETHASHCAP before TUNSETIFF.
- Initialized num_buffers with 1.
- Added a test case for unclassified packets.
- Fixed error handling in tests.
- Changed tests to verify that the queue index will not overflow.
- Rebased.
- Link to v2: https://lore.kernel.org/r/20231015141644.260646-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (9):
      skbuff: Introduce SKB_EXT_TUN_VNET_HASH
      virtio_net: Add functions for hashing
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tap: Pad virtio header with zero
      tun: Pad virtio header with zero
      tun: Introduce virtio-net hash reporting feature
      tun: Introduce virtio-net RSS
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |   2 +-
 drivers/net/tun.c                    | 255 ++++++++++++--
 drivers/vhost/net.c                  |  16 +-
 include/linux/if_tun.h               |   5 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 174 +++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  71 ++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 666 ++++++++++++++++++++++++++++++++++-
 14 files changed, 1170 insertions(+), 40 deletions(-)
---
base-commit: 752ebcbe87aceeb6334e846a466116197711a982
change-id: 20240403-rss-e737d89efa77

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


