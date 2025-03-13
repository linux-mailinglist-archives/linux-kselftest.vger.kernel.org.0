Return-Path: <linux-kselftest+bounces-28881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662CA5EC3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583D91885A4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE81FC7F2;
	Thu, 13 Mar 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ugtg68O7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3491FBEA2
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849288; cv=none; b=ttvSZAy1NJXLZ/zoUmYCUR4qPIV6cloGCo1FpH1vBUteMftF8vDmZuZ5UrplUNXAkCRXASf1Nytg3RdYZmFk+zFR2l7Oh1QDf7/FZAYsz0HWcRmkOOWWus0QvOAr68S9lE2a2qBz3MEsgVZ4a/2SgQmiu1XQWO7Nc+AT/iiR6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849288; c=relaxed/simple;
	bh=kfhpvvDElt6du2l15UsrfA5V34sNhDDERx8i5/QevB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=lr4RhRS5va46OD2RRjLJuDa+aZKH++akN3XulNkO+nb4mH0hwvv4bvmgAMTpBk8WN3+8kupkd3FSdF3zcWVPTpkqOhm8gJw9uY2G6wY15i27lC0PB7F3gifDLO3SzePjDwFc4YcS4I3vahOysEUMVPzdMF/Y127Lz1kPnkK1d7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ugtg68O7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so1114980a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849285; x=1742454085; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F95exAcnYQIEI1RaxPZgX7HWw0kZCG1DoITy3lJOXMs=;
        b=ugtg68O7Lml28x3t17Hl8KLVfQ1GtiFAfKhM19J4XNAJoHhwoQEwX0VQnp07qymo92
         xJ03E1gzul/82hEOdBVWd3TRznArjYOLB501Hg9RFcE0HoEnjFpoOXNZeR/RzDkTQoKY
         Rwjz6VNlcU/d3OZUTmFJj88UoPL42C9kYO/LvGDO+CwF+rEvZVWP1NWoNupDrZ45A2lt
         BvsWCOhR20MUyf3l2XZMvpVU/5buaA/tB/hC0VPrgybcOxBTuklVIK1iOJ5tojyvFMon
         MDx6wDh7oDFXsOsmbOok8RxgbIPsuw0hsHgdubB0nSXzNUTJVoNiSTiA6qZA/BrUezfi
         4ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849285; x=1742454085;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F95exAcnYQIEI1RaxPZgX7HWw0kZCG1DoITy3lJOXMs=;
        b=EOXSbTqcekblpqOJNggLD7OhswR4fCKUXLdqAQS3TCDJUbNWsLZmBSHDfXecwJ5v/q
         H2ffKEyOCMO1Atk2ps0oFNgbRMWNdFUIZsVgKUCfJBK6j2b+rmWoFOix1k9mRdCX05iy
         ZluaIzaFVJjIN8EhF1x3aAThpiJ15ZrIM9aEuPHPp3U7TwFsRRi8d0NwFfP1RWvJuWWt
         dKsqqRQeDCfR3TuuffhssBEtU0FZ6AM6HZGXGlmrWT89igmyFwhXpC+1QYHPqUAEU1Yj
         YEZsKWZ8La7YBYlYCzYBegZsyA+d+jR+KB7AhfirYo3fKPtgVWaRWawlhl58Ue//GKge
         D5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxKD0QOqDY8Apt6mdB7QVXeWHTPh+bu3NbFc2cvO5moOmvjuGVoSDQ13shf4IAx4/mJnGc7E8j7VT3yaVcMJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYnRZw/3VDzm2Pv54Qid91ILS/Nt2dYEOGC3Hh563jfgGA4dM
	DwPJzDUW4gkLH85V7npS7cbE6I3mJ6vWjPcVNsXyJQXgQhajzd0uYOIyiaRN/2g=
X-Gm-Gg: ASbGncuOIxQOLx5vu2TOCFAkRqyuHlXiwbC5oPt6SNHvi5CAswuNwA2dM0iWDD581i7
	5lzCJUpBod6ZhhsHgBL6+deDE6HwXZnr3d1OxjRBB+eLa0JCxswYEfgRYCXnH7Ljc0JR/u54JPO
	eAcHIbIF8a7LPC1g5rT93bobp2dFNTo65xvsG/SM5Y8atr4Cu0KgJDYvDuzMkWx+aSSmQ7n16XD
	qQmsaHZQ/UKQHN9EqhhkQPivV2d+L9bzHwDJs7+XOvgcogMIoJZx/K362umXKjRI7Nkp03M1KXQ
	GLfJEULOJu9E0JMs4w+9p9A+H1uGyaCYSKhYTQqIfNqxZWVv
X-Google-Smtp-Source: AGHT+IG/2TUsxjSP8SAJkKonb+AXsMlQnT1GibK5u7KLisnvk4f6w1Qgk6Dn5pj1HIS4hmUjn2b80w==
X-Received: by 2002:a17:90a:e70e:b0:2ee:f076:20fb with SMTP id 98e67ed59e1d1-300ff10c978mr15687591a91.17.1741849284620;
        Thu, 13 Mar 2025 00:01:24 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301182181c3sm3092882a91.5.2025.03.13.00.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v10 00/10] tun: Introduce virtio-net hashing
 feature
Date: Thu, 13 Mar 2025 16:01:03 +0900
Message-Id: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCC0mcC/4XSS27kIBAG4Ku0vA6tAooCvJp7jGbBM42i2Bnb3
 eooyt1TsfPoyIvsjKmvgNL/0s1lamXu+sNLN5VLm9s48ELC3aFLpzDcF9Ey/+gUKAQELaZ5FsV
 qm50vNVjbceXTVGq7rm3+dkNZxFCuS/ePd05tXsbpee1/kes+d9ISwIFREuRRIqJSQorw0E7tY
 TyOmb/+5PA8tOsxjY9rn4u6sdJIlIR4VASE9KvVnxbBS7O+4KIFiEQauFmO4NQO4Q1SuCFk5LB
 4rUqCQmmHzBd6f+GGDKOqUyWXK4DJO0SfyIAEvyFiFGXyELIFV2mH7DdS6uMku14PFZgUY8575
 L6RBtqQY2RDxGqoVlR6h/wtshvyjHK1RDwdZUr8gV63REzl/5nztHzE4itN/WGdj9IglvMgiIq
 EgD5Csj3P4jZ4aylPRZKI51rLNAvP5Rgr56CmnlPB5THMRfDJj23pDzk7bY2tVMhRUNI5722Kx
 kXjrakWMUZrHfE1X98A0L/L2f4CAAA=
X-Change-ID: 20240403-rss-e737d89efa77
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

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
https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v10:
- Split common code and TUN/TAP-specific code into separate patches.
- Reverted a spurious style change in patch "tun: Introduce virtio-net
  hash feature".
- Added a comment explaining disable_ipv6 in tests.
- Used AF_PACKET for patch "selftest: tun: Add tests for
  virtio-net hashing". I also added the usage of FIXTURE_VARIANT() as
  the testing function now needs access to more variant-specific
  variables.
- Corrected the message of patch "selftest: tun: Add tests for
  virtio-net hashing"; it mentioned validation of configuration but
  it is not scope of this patch.
- Expanded the description of patch "selftest: tun: Add tests for
  virtio-net hashing".
- Added patch "tun: Allow steering eBPF program to fall back".
- Changed to handle TUNGETVNETHASHCAP before taking the rtnl lock.
- Removed redundant tests for tun_vnet_ioctl().
- Added patch "selftest: tap: Add tests for virtio-net ioctls".
- Added a design explanation of ioctls for extensibility and migration.
- Removed a few branches in patch
  "vhost/net: Support VIRTIO_NET_F_HASH_REPORT".
- Link to v9: https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com

Changes in v9:
- Added a missing return statement in patch
  "tun: Introduce virtio-net hash feature".
- Link to v8: https://lore.kernel.org/r/20250306-rss-v8-0-7ab4f56ff423@daynix.com

Changes in v8:
- Disabled IPv6 to eliminate noises in tests.
- Added a branch in tap to avoid unnecessary dissection when hash
  reporting is disabled.
- Removed unnecessary rtnl_lock().
- Extracted code to handle new ioctls into separate functions to avoid
  adding extra NULL checks to the code handling other ioctls.
- Introduced variable named "fd" to __tun_chr_ioctl().
- s/-/=/g in a patch message to avoid confusing Git.
- Link to v7: https://lore.kernel.org/r/20250228-rss-v7-0-844205cbbdd6@daynix.com

Changes in v7:
- Ensured to set hash_report to VIRTIO_NET_HASH_REPORT_NONE for
  VHOST_NET_F_VIRTIO_NET_HDR.
- s/4/sizeof(u32)/ in patch "virtio_net: Add functions for hashing".
- Added tap_skb_cb type.
- Rebased.
- Link to v6: https://lore.kernel.org/r/20250109-rss-v6-0-b1c90ad708f6@daynix.com

Changes in v6:
- Extracted changes to fill vnet header holes into another series.
- Squashed patches "skbuff: Introduce SKB_EXT_TUN_VNET_HASH", "tun:
  Introduce virtio-net hash reporting feature", and "tun: Introduce
  virtio-net RSS" into patch "tun: Introduce virtio-net hash feature".
- Dropped the RFC tag.
- Link to v5: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com

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
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Allow steering eBPF program to fall back
      tun: Add common virtio-net hash feature code
      tun: Introduce virtio-net hash feature
      tap: Introduce virtio-net hash feature
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      selftest: tap: Add tests for virtio-net ioctls
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |  68 ++++-
 drivers/net/tun.c                    |  90 +++++--
 drivers/net/tun_vnet.h               | 155 ++++++++++-
 drivers/vhost/net.c                  |  68 ++---
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 ++++++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  82 ++++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tap.c    |  97 ++++++-
 tools/testing/selftests/net/tun.c    | 491 ++++++++++++++++++++++++++++++++++-
 16 files changed, 1185 insertions(+), 77 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20240403-rss-e737d89efa77
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5
prerequisite-change-id: 20250116-buffers-96e14bf023fc:v2
prerequisite-patch-id: 25fd4f99d4236a05a5ef16ab79f3e85ee57e21cc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


