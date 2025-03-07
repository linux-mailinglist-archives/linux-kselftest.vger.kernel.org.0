Return-Path: <linux-kselftest+bounces-28459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA0A5626A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548C218878E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791B1B4240;
	Fri,  7 Mar 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnycyZUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0218DF65
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335380; cv=none; b=CxCjBa92lVquUsr0H2Ux0kIg5X3YPgw1GLjQ7JI2ik3O4eglbve5wfKRGXx2zUMV/rCym1v21VciqMOR8YjbW4XadUfWI1hcl+BA5c257VyEm/aAjNWn7Ztkh4G5RKlWx8BTfC2JkR9aZi5hQWSe5cJjTjPoxohOfCatCoMPWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335380; c=relaxed/simple;
	bh=8iK73HDtnodJf4E+o2bk11fOzCqvrCxUPy7pZ3SGbPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COZ4hSdr/CAWfqU0A8p79M/FiLiqu0EyNTjRyqOOvvtk+MejfO8f6sULXA+euQRbJ6YEFq0NSVwfx4i4xhelmzAuGDpnGivZNtMxwjF21/ZJ1SJyNXEuWSSYSAWk3L/ZjSwXtP80Kdd3Ak2Y1zCs9uykquc9f7A5VcoIRQHbduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnycyZUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741335377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZrf9VZerfCz+3LtZgJyVuy/gTZIWP83G1q+dqmxlOg=;
	b=RnycyZUUFk19nsgapskhr7hdy8DSW3aww3HpSqe2aFNPX7NftbY90XTy5nLlobWN/SaATM
	w/UlnuKlkxqB22+iR4lQSQwRtj6Gq81xwx2hI4T+PBXpFq4kD4bWd0Gu6hxYM0mRCXTcjO
	0Q9oLlHuA/6v+m5VOUX/nPhATEMHjyI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ZItzDLt2MmC9z8ikxVVLYg-1; Fri, 07 Mar 2025 03:16:15 -0500
X-MC-Unique: ZItzDLt2MmC9z8ikxVVLYg-1
X-Mimecast-MFC-AGG-ID: ZItzDLt2MmC9z8ikxVVLYg_1741335374
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac22704d4ccso142846266b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 00:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335374; x=1741940174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZrf9VZerfCz+3LtZgJyVuy/gTZIWP83G1q+dqmxlOg=;
        b=jIsO7ostGCa99RrxbPFoBihjc9O4HGY+x/54iCaaO/b8F/gg7jmln3J19YdLh9qh+Z
         Dj9nWjA1ZZLTjtfD1JoPdCVSueUN2a6RyYHsZ+A4oA0oVyLjeGPlBQq6v8+in2ioK6+T
         GQjOfG7VKT6/Kzx+YgZBBquCsTFRniV3MmXsNV83/fQnKW25oWvW8wzYdorOICZPG+H3
         QyGydUE/45lOu25t6P2D+67YmPUuwxMierTJqMKgvgSqTMHnYl+RkFzDK1vb1lY+hS0m
         uoGWXb2XxjzTX+LGqKi5VntXHzbg4leo3WiyS8W6dld6nbwSy9MMCz9kDq2n1pXdaWzx
         21+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY/UZLQojLDtk/Hj1mjil39pZsDaC0pjQEENN3K7gSJtfSvEx3hKetsedTjtFDUGtVH8DCP3WkptMcMmyz7tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyelhYqFhwhEA7cj/yQjMh6TzY22MsEYcqm5Z0Fk4yckGywFw4B
	heys5/3mzef9M7+vBh2i/2yUXs084ffE4RqUtBbuA5whqnOUoHM++9z1rlrY56GkB0hcQR/+G/4
	/Rd966UWLLDpWChBRwpqxuszQtxdXLv1Nv0arCvnrhGzGc/Ds8rbXMgZ9Yu6OMC3ycx0MsQFBLh
	4UtZrCP2voDXzHivciptd8dHL+CQDquLmp+FgPch8X
X-Gm-Gg: ASbGnctPNuMHIzottBIQGncHuSvxCqzZsnK7O6SEEsQckqZKC7OP1op62wSzthG3jpZ
	nLDUsZlYLJKIXMryrLncerIVyGDS3HgiQuuQr9iUy+6QL2Uq07JeART2L+iDu+VQh93X/x+6etQ
	==
X-Received: by 2002:a17:907:94c5:b0:ac1:ed46:7bf0 with SMTP id a640c23a62f3a-ac2526e27d2mr239234466b.18.1741335374156;
        Fri, 07 Mar 2025 00:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgLcTM2uhO+on92z9g6p+54NDe9IMQAVzUJJCRAi3KR79ymKuEXtqOu2IjH6Kh+QOxAHohHZehq/lE/kWEFhg=
X-Received: by 2002:a17:907:94c5:b0:ac1:ed46:7bf0 with SMTP id
 a640c23a62f3a-ac2526e27d2mr239230566b.18.1741335373694; Fri, 07 Mar 2025
 00:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
In-Reply-To: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 7 Mar 2025 16:15:35 +0800
X-Gm-Features: AQ5f1JoMsWd52mQ25sAe2CdSF0AxW5CvjF_1Je5ZaJ6Fwt_3vbSGK6lNF7K_Srk
Message-ID: <CAPpAL=zJyfDyvL4vRKTWmas4xCJM7sR9HQsq0JjNuEuotSE3iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/6] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 6, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>
> The patches for QEMU to use this new feature was submitted as RFC and
> is available at:
> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> V1 -> V2:
>   Changed to introduce a new BPF program type.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v8:
> - Disabled IPv6 to eliminate noises in tests.
> - Added a branch in tap to avoid unnecessary dissection when hash
>   reporting is disabled.
> - Removed unnecessary rtnl_lock().
> - Extracted code to handle new ioctls into separate functions to avoid
>   adding extra NULL checks to the code handling other ioctls.
> - Introduced variable named "fd" to __tun_chr_ioctl().
> - s/-/=3D/g in a patch message to avoid confusing Git.
> - Link to v7: https://lore.kernel.org/r/20250228-rss-v7-0-844205cbbdd6@da=
ynix.com
>
> Changes in v7:
> - Ensured to set hash_report to VIRTIO_NET_HASH_REPORT_NONE for
>   VHOST_NET_F_VIRTIO_NET_HDR.
> - s/4/sizeof(u32)/ in patch "virtio_net: Add functions for hashing".
> - Added tap_skb_cb type.
> - Rebased.
> - Link to v6: https://lore.kernel.org/r/20250109-rss-v6-0-b1c90ad708f6@da=
ynix.com
>
> Changes in v6:
> - Extracted changes to fill vnet header holes into another series.
> - Squashed patches "skbuff: Introduce SKB_EXT_TUN_VNET_HASH", "tun:
>   Introduce virtio-net hash reporting feature", and "tun: Introduce
>   virtio-net RSS" into patch "tun: Introduce virtio-net hash feature".
> - Dropped the RFC tag.
> - Link to v5: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@da=
ynix.com
>
> Changes in v5:
> - Fixed a compilation error with CONFIG_TUN_VNET_CROSS_LE.
> - Optimized the calculation of the hash value according to:
>   https://git.dpdk.org/dpdk/commit/?id=3D3fb1ea032bd6ff8317af5dac9af901f1=
f324cab4
> - Added patch "tun: Unify vnet implementation".
> - Dropped patch "tap: Pad virtio header with zero".
> - Added patch "selftest: tun: Test vnet ioctls without device".
> - Reworked selftests to skip for older kernels.
> - Documented the case when the underlying device is deleted and packets
>   have queue_mapping set by TC.
> - Reordered test harness arguments.
> - Added code to handle fragmented packets.
> - Link to v4: https://lore.kernel.org/r/20240924-rss-v4-0-84e932ec0e6c@da=
ynix.com
>
> Changes in v4:
> - Moved tun_vnet_hash_ext to if_tun.h.
> - Renamed virtio_net_toeplitz() to virtio_net_toeplitz_calc().
> - Replaced htons() with cpu_to_be16().
> - Changed virtio_net_hash_rss() to return void.
> - Reordered variable declarations in virtio_net_hash_rss().
> - Removed virtio_net_hdr_v1_hash_from_skb().
> - Updated messages of "tap: Pad virtio header with zero" and
>   "tun: Pad virtio header with zero".
> - Fixed vnet_hash allocation size.
> - Ensured to free vnet_hash when destructing tun_struct.
> - Link to v3: https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@da=
ynix.com
>
> Changes in v3:
> - Reverted back to add ioctl.
> - Split patch "tun: Introduce virtio-net hashing feature" into
>   "tun: Introduce virtio-net hash reporting feature" and
>   "tun: Introduce virtio-net RSS".
> - Changed to reuse hash values computed for automq instead of performing
>   RSS hashing when hash reporting is requested but RSS is not.
> - Extracted relevant data from struct tun_struct to keep it minimal.
> - Added kernel-doc.
> - Changed to allow calling TUNGETVNETHASHCAP before TUNSETIFF.
> - Initialized num_buffers with 1.
> - Added a test case for unclassified packets.
> - Fixed error handling in tests.
> - Changed tests to verify that the queue index will not overflow.
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231015141644.260646-1-akihiko.o=
daki@daynix.com
>
> ---
> Akihiko Odaki (6):
>       virtio_net: Add functions for hashing
>       net: flow_dissector: Export flow_keys_dissector_symmetric
>       tun: Introduce virtio-net hash feature
>       selftest: tun: Test vnet ioctls without device
>       selftest: tun: Add tests for virtio-net hashing
>       vhost/net: Support VIRTIO_NET_F_HASH_REPORT
>
>  Documentation/networking/tuntap.rst  |   7 +
>  drivers/net/Kconfig                  |   1 +
>  drivers/net/tap.c                    |  67 +++-
>  drivers/net/tun.c                    |  98 +++++-
>  drivers/net/tun_vnet.h               | 159 ++++++++-
>  drivers/vhost/net.c                  |  49 +--
>  include/linux/if_tap.h               |   2 +
>  include/linux/skbuff.h               |   3 +
>  include/linux/virtio_net.h           | 188 ++++++++++
>  include/net/flow_dissector.h         |   1 +
>  include/uapi/linux/if_tun.h          |  75 ++++
>  net/core/flow_dissector.c            |   3 +-
>  net/core/skbuff.c                    |   4 +
>  tools/testing/selftests/net/Makefile |   2 +-
>  tools/testing/selftests/net/tun.c    | 656 +++++++++++++++++++++++++++++=
+++++-
>  15 files changed, 1254 insertions(+), 61 deletions(-)
> ---
> base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
> change-id: 20240403-rss-e737d89efa77
> prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
> prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
> prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
> prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
> prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
> prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
> prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
> prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5
> prerequisite-change-id: 20250116-buffers-96e14bf023fc:v2
> prerequisite-patch-id: 25fd4f99d4236a05a5ef16ab79f3e85ee57e21cc
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>


