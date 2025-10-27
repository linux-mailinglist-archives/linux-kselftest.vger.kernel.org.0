Return-Path: <linux-kselftest+bounces-44097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF79C0E1FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF54FBA44
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006802D9491;
	Mon, 27 Oct 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXmWHAeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99630215E
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571732; cv=none; b=k1sHXcvTHnAu0bZlineBVXSUbhKt92/dUSRY4lgh+CHakk0Gre9lDW91PwPz2ODgkNL8CjSSj9INuFMODm3j9EqeYf48GkcGXO2EPCcdW7jmebyBR6OpNPu5hN0ODHpOIiMebHAaRIbpfEuLOsZgTrbApDhiOMDcW5zyBvd8hAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571732; c=relaxed/simple;
	bh=wR0Abfz8DT6Ls0s64xwX6SAl40Sb+QmtlkxyI/j8JmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbZPolHnrqfQhWg1BLK+3qv1U+FWqiOt7iJtKoL76WyQRxnzPX72z63yBl1UZ7FJ4IpaYPiV8rlPgo6FT+EftPA+rJ9NGRkM/JIS3OGPnlZPCbjq0ij+pz/cq/Vl26Bcdkkau9qaKUhGflH3UGXPxUzITH2c0/BGy54VRRTxYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXmWHAeu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761571729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sVFZREsDlPEowwg74l+M7gNhm2SvfUP9cITloADbHc=;
	b=ZXmWHAeuTReY4gT4yk5TDhFVTOxp4jG/zfn2h9ePcoAgAzIPuXkgnqCj+OGRf7xiBlRg4n
	SHfZgmYmzdWpAuoeq5s2aoT/6NbH40nWL9JY5ql7z0pvZEiN6ay6dEwOO5d1Pz3Vkb+CPf
	7BZT+t4MUomaBOlfhxQrgSrui+XDoyM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-1MsEMASKMjqJdtVyaxVYIw-1; Mon, 27 Oct 2025 09:28:43 -0400
X-MC-Unique: 1MsEMASKMjqJdtVyaxVYIw-1
X-Mimecast-MFC-AGG-ID: 1MsEMASKMjqJdtVyaxVYIw_1761571722
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42855d6875fso4157410f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 06:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571722; x=1762176522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sVFZREsDlPEowwg74l+M7gNhm2SvfUP9cITloADbHc=;
        b=ERTxmZJYSOzjNs+4ZDuw5GuPyfQAeSg95Fb5m0ErL8j0bMPCgm1PGtuT0cGNiPo2s8
         mceLWZF+lKUfF/WEZzbUfE+zpZkTBdLigqxN6tGLBINpVPv89ahFWtH8TJo9EUp8NgDQ
         BbJ3zBK39qrqsz+tT0MC7TwA0J07Ba+n1b76Hl/75kZWcr+NCQITYCx5FotOYFLvhfSu
         GG80lRAeVyh5WDPglZB+hDkAVX7+KegCW/NFc+2o/Un3fXlaP/Tmzv9y0eQQ2Wat/bgN
         jxDfr3rRsS5YZKWul8BgqFc2bkAKTKGqajfD/ZtFDiR7YrJ4hnw4l4MFbfwDhrUvSPdf
         nfGw==
X-Forwarded-Encrypted: i=1; AJvYcCWBJy/NKD3MEW6ReKUQfVaIwkSgv6lXbf2VmZuXQEmTPI0dwAsPqIBsGoMw4XmfCc9Znr1MzKWUmsaQ/mCuqi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGrkXNRtt3AcQFw9cjCG9P25dv85GQGvTMDi9ltSmyEBenn10
	MGNKnM2IHuCRu1Z7DzWzqP+ipvq2Y1tly/yYrgdMvHIrzjqUpIbCZTKDrWuitEmFmyhFXzL3zU6
	Eof1CaHqa2sA0WJKYOy+MV80jQLERW4vzw+BZ1GNInIR75gziW5d4a3GyMl+hQfYmEoViXg==
X-Gm-Gg: ASbGnctfKxzAXNHrngKUEE+Lzg00zyCdlaVWWV3TsJp3Y3OYpC2J+RHdpJhOV6JHQYw
	Y8yH1GjIUbICmvgwJGu46YtiXI4Y2rkNNrzyvl/Dk0sOcZpTGhOi1KFpUodr5BGzK4AhmneBmgw
	XQIs9pSVYe6Orsfh83B5VlWXkn7U4/ZnqNr1YvODXHLWFIVFC/fviDtHAR1OiuAQD5aDL6zoJCN
	HNRL3+iLABCvmyn4x5qjNXs62CroHGHn4i/aHDPsLsHvF3bi5awoMu37E1IJ22Z2F0RWKD60NR4
	1MKHRaAmnFQIiISjsW6EItiUR0UFOF8L1feHqV9qSeTqLK6HI2KINX6/xiSpAfLTz16FpsbwCcU
	/f1AOGo1yRjkpz/iV0ejhVHB1zIk434GDzgNhv5RBkR7dp2B9kw4=
X-Received: by 2002:a05:6000:2303:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-42706c4f1b6mr26863246f8f.35.1761571722299;
        Mon, 27 Oct 2025 06:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFprCttg3VDkiyAEPc1IPkamGeSJLcCVH5i0w8DXB665/B50w1bp6pjM0NqmoJjWiuGgxo2dg==
X-Received: by 2002:a05:6000:2303:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-42706c4f1b6mr26863207f8f.35.1761571721784;
        Mon, 27 Oct 2025 06:28:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5773sm15390626f8f.27.2025.10.27.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:28:40 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:28:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>

Hi Bobby,

On Thu, Oct 23, 2025 at 11:27:39AM -0700, Bobby Eshleman wrote:
>This series adds namespace support to vhost-vsock and loopback. It does
>not add namespaces to any of the other guest transports (virtio-vsock,
>hyperv, or vmci).
>
>The current revision supports two modes: local and global. Local
>mode is complete isolation of namespaces, while global mode is complete
>sharing between namespaces of CIDs (the original behavior).
>
>The mode is set using /proc/sys/net/vsock/ns_mode.
>
>Modes are per-netns and write-once. This allows a system to configure
>namespaces independently (some may share CIDs, others are completely
>isolated). This also supports future possible mixed use cases, where
>there may be namespaces in global mode spinning up VMs while there are
>mixed mode namespaces that provide services to the VMs, but are not
>allowed to allocate from the global CID pool (this mode not implemented
>in this series).
>
>If a socket or VM is created when a namespace is global but the
>namespace changes to local, the socket or VM will continue working
>normally. That is, the socket or VM assumes the mode behavior of the
>namespace at the time the socket/VM was created. The original mode is
>captured in vsock_create() and so occurs at the time of socket(2) and
>accept(2) for sockets and open(2) on /dev/vhost-vsock for VMs. This
>prevents a socket/VM connection from suddenly breaking due to a
>namespace mode change. Any new sockets/VMs created after the mode change
>will adopt the new mode's behavior.
>
>Additionally, added tests for the new namespace features:
>
>tools/testing/selftests/vsock/vmtest.sh
>1..30
>ok 1 vm_server_host_client
>ok 2 vm_client_host_server
>ok 3 vm_loopback
>ok 4 ns_host_vsock_ns_mode_ok
>ok 5 ns_host_vsock_ns_mode_write_once_ok
>ok 6 ns_global_same_cid_fails
>ok 7 ns_local_same_cid_ok
>ok 8 ns_global_local_same_cid_ok
>ok 9 ns_local_global_same_cid_ok
>ok 10 ns_diff_global_host_connect_to_global_vm_ok
>ok 11 ns_diff_global_host_connect_to_local_vm_fails
>ok 12 ns_diff_global_vm_connect_to_global_host_ok
>ok 13 ns_diff_global_vm_connect_to_local_host_fails
>ok 14 ns_diff_local_host_connect_to_local_vm_fails
>ok 15 ns_diff_local_vm_connect_to_local_host_fails
>ok 16 ns_diff_global_to_local_loopback_local_fails
>ok 17 ns_diff_local_to_global_loopback_fails
>ok 18 ns_diff_local_to_local_loopback_fails
>ok 19 ns_diff_global_to_global_loopback_ok
>ok 20 ns_same_local_loopback_ok
>ok 21 ns_same_local_host_connect_to_local_vm_ok
>ok 22 ns_same_local_vm_connect_to_local_host_ok
>ok 23 ns_mode_change_connection_continue_vm_ok
>ok 24 ns_mode_change_connection_continue_host_ok
>ok 25 ns_mode_change_connection_continue_both_ok
>ok 26 ns_delete_vm_ok
>ok 27 ns_delete_host_ok
>ok 28 ns_delete_both_ok
>ok 29 ns_loopback_global_global_late_module_load_ok
>ok 30 ns_loopback_local_local_late_module_load_fails
>SUMMARY: PASS=30 SKIP=0 FAIL=0
>
>Dependent on series:
>https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>
>Thanks again for everyone's help and reviews!
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>To: Stefano Garzarella <sgarzare@redhat.com>
>To: Shuah Khan <shuah@kernel.org>
>To: David S. Miller <davem@davemloft.net>
>To: Eric Dumazet <edumazet@google.com>
>To: Jakub Kicinski <kuba@kernel.org>
>To: Paolo Abeni <pabeni@redhat.com>
>To: Simon Horman <horms@kernel.org>
>To: Stefan Hajnoczi <stefanha@redhat.com>
>To: Michael S. Tsirkin <mst@redhat.com>
>To: Jason Wang <jasowang@redhat.com>
>To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>To: Eugenio Pérez <eperezma@redhat.com>
>To: K. Y. Srinivasan <kys@microsoft.com>
>To: Haiyang Zhang <haiyangz@microsoft.com>
>To: Wei Liu <wei.liu@kernel.org>
>To: Dexuan Cui <decui@microsoft.com>
>To: Bryan Tan <bryan-bt.tan@broadcom.com>
>To: Vishnu Dasa <vishnu.dasa@broadcom.com>
>To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: linux-kselftest@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: kvm@vger.kernel.org
>Cc: linux-hyperv@vger.kernel.org
>Cc: berrange@redhat.com
>
>Changes in v8:
>- Break generic cleanup/refactoring patches into standalone series,
>  remove those from this series

Yep, thanks for splitting the series. I'll review it ASAP since it's a 
dependency.

I was at GSoC mentor summit last week, so I'm bit busy with the backlog, 
but I'll do my best to review both series this week.

Thanks,
Stefano

>- Link to dependency: https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>- Link to v7: https://lore.kernel.org/r/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com
>
>Changes in v7:
>- fix hv_sock build
>- break out vmtest patches into distinct, more well-scoped patches
>- change `orig_net_mode` to `net_mode`
>- many fixes and style changes in per-patch change sets (see individual
>  patches for specific changes)
>- optimize `virtio_vsock_skb_cb` layout
>- update commit messages with more useful descriptions
>- vsock_loopback: use orig_net_mode instead of current net mode
>- add tests for edge cases (ns deletion, mode changing, loopback module
>  load ordering)
>- Link to v6: https://lore.kernel.org/r/20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com
>
>Changes in v6:
>- define behavior when mode changes to local while socket/VM is alive
>- af_vsock: clarify description of CID behavior
>- af_vsock: use stronger langauge around CID rules (dont use "may")
>- af_vsock: improve naming of buf/buffer
>- af_vsock: improve string length checking on proc writes
>- vsock_loopback: add space in struct to clarify lock protection
>- vsock_loopback: do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net() instead of sock_net()
>- vsock_loopback: set loopback to NULL after kfree()
>- vsock_loopback: use pernet_operations and remove callback mechanism
>- vsock_loopback: add macros for "global" and "local"
>- vsock_loopback: fix length checking
>- vmtest.sh: check for namespace support in vmtest.sh
>- Link to v5: https://lore.kernel.org/r/20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com
>
>Changes in v5:
>- /proc/net/vsock_ns_mode -> /proc/sys/net/vsock/ns_mode
>- vsock_global_net -> vsock_global_dummy_net
>- fix netns lookup in vhost_vsock to respect pid namespaces
>- add callbacks for vsock_loopback to avoid circular dependency
>- vmtest.sh loads vsock_loopback module
>- remove vsock_net_mode_can_set()
>- change vsock_net_write_mode() to return true/false based on success
>- make vsock_net_mode enum instead of u8
>- Link to v4: https://lore.kernel.org/r/20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com
>
>Changes in v4:
>- removed RFC tag
>- implemented loopback support
>- renamed new tests to better reflect behavior
>- completed suite of tests with permutations of ns modes and vsock_test
>  as guest/host
>- simplified socat bridging with unix socket instead of tcp + veth
>- only use vsock_test for success case, socat for failure case (context
>  in commit message)
>- lots of cleanup
>
>Changes in v3:
>- add notion of "modes"
>- add procfs /proc/net/vsock_ns_mode
>- local and global modes only
>- no /dev/vhost-vsock-netns
>- vmtest.sh already merged, so new patch just adds new tests for NS
>- Link to v2:
>  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com
>
>Changes in v2:
>- only support vhost-vsock namespaces
>- all g2h namespaces retain old behavior, only common API changes
>  impacted by vhost-vsock changes
>- add /dev/vhost-vsock-netns for "opt-in"
>- leave /dev/vhost-vsock to old behavior
>- removed netns module param
>- Link to v1:
>  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>
>Changes in v1:
>- added 'netns' module param to vsock.ko to enable the
>  network namespace support (disabled by default)
>- added 'vsock_net_eq()' to check the "net" assigned to a socket
>  only when 'netns' support is enabled
>- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>
>---
>Bobby Eshleman (14):
>      vsock: a per-net vsock NS mode state
>      vsock/virtio: pack struct virtio_vsock_skb_cb
>      vsock: add netns to vsock skb cb
>      vsock: add netns to vsock core
>      vsock/loopback: add netns support
>      vsock/virtio: add netns to virtio transport common
>      vhost/vsock: add netns support
>      selftests/vsock: add namespace helpers to vmtest.sh
>      selftests/vsock: prepare vm management helpers for namespaces
>      selftests/vsock: add tests for proc sys vsock ns_mode
>      selftests/vsock: add namespace tests for CID collisions
>      selftests/vsock: add tests for host <-> vm connectivity with namespaces
>      selftests/vsock: add tests for namespace deletion and mode changes
>      selftests/vsock: add tests for module loading order
>
> MAINTAINERS                             |    1 +
> drivers/vhost/vsock.c                   |   48 +-
> include/linux/virtio_vsock.h            |   47 +-
> include/net/af_vsock.h                  |   70 ++-
> include/net/net_namespace.h             |    4 +
> include/net/netns/vsock.h               |   22 +
> net/vmw_vsock/af_vsock.c                |  264 +++++++-
> net/vmw_vsock/virtio_transport.c        |    7 +-
> net/vmw_vsock/virtio_transport_common.c |   21 +-
> net/vmw_vsock/vsock_loopback.c          |   89 ++-
> tools/testing/selftests/vsock/vmtest.sh | 1044 ++++++++++++++++++++++++++++++-
> 11 files changed, 1532 insertions(+), 85 deletions(-)
>---
>base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>prerequisite-message-id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
>prerequisite-patch-id: a2eecc3851f2509ed40009a7cab6990c6d7cfff5
>prerequisite-patch-id: 501db2100636b9c8fcb3b64b8b1df797ccbede85
>prerequisite-patch-id: ba1a2f07398a035bc48ef72edda41888614be449
>prerequisite-patch-id: fd5cc5445aca9355ce678e6d2bfa89fab8a57e61
>prerequisite-patch-id: 795ab4432ffb0843e22b580374782e7e0d99b909
>prerequisite-patch-id: 1499d263dc933e75366c09e045d2125ca39f7ddd
>prerequisite-patch-id: f92d99bb1d35d99b063f818a19dcda999152d74c
>prerequisite-patch-id: e3296f38cdba6d903e061cff2bbb3e7615e8e671
>prerequisite-patch-id: bc4662b4710d302d4893f58708820fc2a0624325
>prerequisite-patch-id: f8991f2e98c2661a706183fde6b35e2b8d9aedcf
>prerequisite-patch-id: 44bf9ed69353586d284e5ee63d6fffa30439a698
>prerequisite-patch-id: d50621bc630eeaf608bbaf260370c8dabf6326df
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


