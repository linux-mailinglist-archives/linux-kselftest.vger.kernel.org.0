Return-Path: <linux-kselftest+bounces-19203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0EC993FEF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FACC1C2169B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7581E3DD4;
	Tue,  8 Oct 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qp+4PYjj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB216C695
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370479; cv=none; b=seZTKnCyYVQPhFfijuLC0oSvZKS11TN3s0ZQPCaDHG5lR2+KPyYjdp2XCuMIoLI2g/tD2Jop+J7YLdSKOp471KvanCBpXUh28+VjlRvwkBqccpDnfd5LrVYL0Z8zKPXz/uZ0vxBQj8M3NqoqoDZtWVaxDlJmJDDYFSDgzj4tJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370479; c=relaxed/simple;
	bh=6j/9R+ZY3hri2Pq0LzMiZP+7u1JzeaSfqhBdxGp4lDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=RrlJUDP4EteVisV25pvF+A6OjsmZUQuu4JiWB6YDX9UW6aPbYba6GmQmcdCEFy+pV5LhYomlr2beUkaGKLyfkJQ9bbCqLutjFGYLtljbULyoxhCVwD4l8Ig2g1wSafiA7l/p2bi1mz6lte4RWoerQnmWGMk/rkMX7Z4BZRkmAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qp+4PYjj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b6458ee37so61579605ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370476; x=1728975276; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gty0dEnircfdREPGfEnkI3a1znlqYE3ZJr68g8y4pY=;
        b=qp+4PYjjKIP7yWhCdM47DkiyBzhDd1QwrCwW1dYjZ1x79FjhqkUyhTQMszvnAV7fx2
         vTdu91qzoyZIVzsIE/HcMPwRNWwlyA357gK47EJWmyJXTNU/2zIrzlVxC+8x6hS6cFBo
         j4SUfUKP663X+phL1dxePLzjRj9xxFGn9+PqK+Ppawv45f+cKfs1WbMhyGfMku1MTk1I
         bFUmRH2kOX5/oojo3huyAKA5hmyWk/UB2n4/WigRu4Wx2mzQ3rNDCEkX4+NbJFruap0+
         ZvxBPBqbHIj4F0rQ5EAkC64hEAynoyD6HBW1ImMeaM0Ji/NWhy+44QAdP9kQXJfNYcHG
         sDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370476; x=1728975276;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gty0dEnircfdREPGfEnkI3a1znlqYE3ZJr68g8y4pY=;
        b=VSZsaqBEJSaK4Q68oCjp9rRoQe9IdxAWfGyCSgQVA8NbeTVlruk+TdWcvic1GOJ7Kz
         Cmc0+qZUaHnFwBHsHGd4SwETPqzrLjO4c5+VsME1SuFTBk6zRm/ePU/0f7Otb/SKg6Ym
         5sVFA/jCCgDSPEpSck3webN0XE0ufXwuRDq7a5rs+do5AkaBETObsufh6/YWOaDwVf5a
         Wl7PjP38DTaMzyK+67gqASw49kyyHrF5mttH7qJPY146Zq4mCd2OtoQxo+yfIiy3Ijy8
         j1bPmu+PG+E9mbVOd948ghJgcu2YNw3OvDkWTLVNhhM9L6UHl2lEUmDWxwXWXgEuyrOH
         wKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5l4txdtXT550p9khf6FOLk4g6jZtwpnqvND1PaPP8ROtYUbBvZSfna8QmjLzfaIpB5ZrVfe/gsUbxAe6yL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+H3iujp+8C383ntD6gP4RRwyaoeuV0AtkqSe/N2p8S96cKID9
	m2qVKfG2TyIk3kqfr/6BbwYZkXcxTjgtXoCKYIsLpwjXv9U+StIVgLc126PySAk=
X-Google-Smtp-Source: AGHT+IHPQgocRRuVmNwy/y+36pGmysZiERFRRt/OUdpP+pXSUlRa9FCdE9Lo2jrORE0Se01AVBe7kQ==
X-Received: by 2002:a17:902:e882:b0:20b:9078:707b with SMTP id d9443c01a7336-20bfe02199emr225978335ad.30.1728370475858;
        Mon, 07 Oct 2024 23:54:35 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c13987571sm49681435ad.250.2024.10.07.23.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v5 00/10] tun: Introduce virtio-net hashing feature
Date: Tue, 08 Oct 2024 15:54:20 +0900
Message-Id: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzXBGcC/4XOwWrDMAyA4VcpPtdBkhUn6akw6APsOnbIbLUxp
 fGwS2gpefcZj0HHDrtZlr8fP1SWFCSr3eahkiwhhziXod1ulJvG+SQ6+DIrAmJgMDrlrKUzne8
 HOY5dp8rLzyTHcKuVN/V6eFHv5XIK+RrTvZYXrKsSMQjQQ0sI2CAzE2nU4zlM4Ryb6Mtp78f7H
 G6Ni5faWejJYouMlrkhC5btv9b8WIYB2/r5xWjQzhooMf8BPf1B/ISIvxEX1LMMhsSBWPcLrev
 6BaOSk/1JAQAA
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
Changes in v5:
- Fixed a compilation error with CONFIG_TUN_VNET_CROSS_LE.
- Optimized the calculation of the hash value according to:
  https://git.dpdk.org/dpdk/commit/?id=3fb1ea032bd6ff8317af5dac9af901f1f324cab4
- Added patch "tun: Unify vnet implementation".
- Dropped patch "tap: Pad virtio header with zero".
- Added patch "selftest: tun: Test vnet ioctls without device".
- Reworked selftests to skip for older kernels.
- Documented the case when the underlying device is deleted and packets
  have queue_mapping set by TC.
- Reordered test harness arguments.
- Added code to handle fragmented packets.
- Link to v4: https://lore.kernel.org/r/20240924-rss-v4-0-84e932ec0e6c@daynix.com

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
Akihiko Odaki (10):
      virtio_net: Add functions for hashing
      skbuff: Introduce SKB_EXT_TUN_VNET_HASH
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Unify vnet implementation
      tun: Pad virtio header with zero
      tun: Introduce virtio-net hash reporting feature
      tun: Introduce virtio-net RSS
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 MAINTAINERS                          |   1 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    | 218 ++++--------
 drivers/net/tun.c                    | 293 ++++++----------
 drivers/net/tun_vnet.h               | 342 +++++++++++++++++++
 drivers/vhost/net.c                  |  16 +-
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 +++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  75 +++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 630 ++++++++++++++++++++++++++++++++++-
 16 files changed, 1430 insertions(+), 356 deletions(-)
---
base-commit: 752ebcbe87aceeb6334e846a466116197711a982
change-id: 20240403-rss-e737d89efa77

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


