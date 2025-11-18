Return-Path: <linux-kselftest+bounces-45810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98CC66E80
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 200A8296F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99937317709;
	Tue, 18 Nov 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYhnzuOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471D2D7DEB
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431231; cv=none; b=qnii9jojbu8thzet4CgglLgunHBfWVJrh96cys5HNZgxvUW9hpRAn54CP4CcVx9swknIdfydSE7IrSI8/7EqU2UfGPT3aLQZTeLrndPB89+nvcQyIUx/0k0Tt17L+jnPMRfymMg4ZZA9F4IbnNiJ2k3m0vvWj6PdXvvwfMEbsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431231; c=relaxed/simple;
	bh=ovQDADkNQi0W/K43hg9swZZLCdJrZwJqplC/tHSf0LI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AxQIAwRmK4znSycU0wtSzdoSC+JIBGamHG3WkpwiYTLaRQ2LJ8fiSL17s9pm5o4yT3HUNNB0qyh9Vcjrn21pNh8dbZxs7elHTn8HGQAI41O1yJZMxPiIjA/cpRgYWcKmSPA80scGUFvCNN216zyMw6vZ9I6SffiWTHFv9HMiBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYhnzuOJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297d4a56f97so54854185ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431228; x=1764036028; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVx76OBMnsBLSqDR3xdJaQ2u3dewlFo7syLdRHEOpoM=;
        b=NYhnzuOJSGvKXTovUxVC2Rfp1nobSQ3cImX7yhqN1uEJUZSzBAdqqDz+VqYjSFAF4y
         /tYZgibkHTi1dA6xqhpDFNeAZNJtfNDg32d0fGAo0n1N5mpUF/bwyQtr4qZ/aRozeCvd
         E/pyRsMCZtRkdbSpjKH+egdgKpMtLMxD17T4KsvmFDM8hH5B8mnJ/TN342+bjlH+sEh3
         kbBDhoNWJdJmBVHSAC8anjmC17kyym/UqcwaeyF2fKkwwfFuU1jUGk/una+AoTT+qVze
         cBwlCkYESEInZXk3cRqRI3EWOA1gEPbp+vYcxEW5rzldv6NOSNYe/jdZmqJywRPH3SdN
         UiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431228; x=1764036028;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVx76OBMnsBLSqDR3xdJaQ2u3dewlFo7syLdRHEOpoM=;
        b=hjrjJjnxwVF6WR4ugGslqMUJ1twNdbsdkwGPXyE5KlX9lf3S4T8x4KF4lwZspIOWth
         mCx8kw1UY7bg/x4kVgt+v7y+Y0FLDRszTFo9EkAFy7sS6YaM1Tzxe3G8wySHX8wQlxrG
         qqf06rzHdEHcgky82PR8RGc5bTtlMz8ybidxgmccvwLK7c1U4O0dYdfRmqONmVNQ6wvc
         nBDcX4EXVQWQZ5IzCOebesNFCqnsND1Ocwr5XEMQIoCVkWPlNsIp/dFruoiFMnl9hZ6V
         9TavHUDWgJHdTwI9prrnIqHilHCiKzsvaqxnippjh2cfAfhUpRgdHf8RnD/Elq6K8ms6
         NTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpaFUuJK46TnJ2Hi7Rerb/8wGxwZel7/U7aZOnQWuka1BtIqHv7lZvmWtMVRE9bKSfJir0OPPyKbYYelnTWwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/WQeHAx16uN/hjJjBNLXHUYMjh9jIVFv7eZzN6/KH4XRcDmT
	eBEBoTK1eHvqdg7U5sEl8BkNMVd18Gq/zPxJUFnHBC9BEhOBbLFFQPTb
X-Gm-Gg: ASbGnctWiwyAsf+Swmg0PyvBmGtIv+dbOh+VV+D51s3U5EgQLsJiqMP+dHhp7dZ4O1e
	utJwkER4Diik2RiwQso5KMYH4kqyLL7nMcJinIZ6XgSRAVVvuPVYzkQKcyXTxpXGIFd6SC8fFFv
	aszfETZCkt0711YjsmR6d4/PsrQ6Z/lT+TMlKnQI7EczUmoGY0fM1squ8IPZd+1SIJ2FcfZJYSt
	/rv/mmSLBWUEAAHfrrwNQbibKnFWZKmpHWzadlWkUo7+0+vDLswcWGJoR2ddIVn5mfRoNkRrSVN
	DSUtPb9mgMpnvRURCkTM43TRr3SRxhwbqGyU1qTsYXjqOWMm93tJGEs0BwDiVltpDBiriF7vEMT
	yMyThnybgb+cbGKuEIiYFxx2MbUbqWrTSQdQdExX2BEloqp0wEvYvKl42WXhwQPkz2zAabO+JQh
	vedAtuXaqTb+tFOEvB7frHBaiBu9RhYSa+wX0Ss5dDwg==
X-Google-Smtp-Source: AGHT+IF7Uf2cA0H763wcpfM8c2BvJusAhNtuNoeokeQtMtPq2BvcYn2Yzf/fD8cA1Y9Uz/jeKUNxvA==
X-Received: by 2002:a17:903:3503:b0:295:54cb:16ac with SMTP id d9443c01a7336-2986a6be3dbmr189216415ad.18.1763431228387;
        Mon, 17 Nov 2025 18:00:28 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346b8sm154957275ad.16.2025.11.17.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:28 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v10 00/11] vsock: add namespace support to
 vhost-vsock and loopback
Date: Mon, 17 Nov 2025 18:00:23 -0800
Message-Id: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADjTG2kC/5WTy27cMAwAf8XQeVmQ1MPSoijyH0UOetCJ0dhOL
 ddIEey/F+suEtfJpWdhZiSCelVV5l6qOjevapa1r/00qnNDeGpUfozjg0Bf1LlRjGxRs4W1Tvk
 HrMMidYGkI1NhQs6sTo16nqXrXzbfdzXKAqO8LOr+1KjHvi7T/HsLrbSdb0pD+K9yJSDotI2eS
 kzB57uHIfZPX/I0bKKV93B7gBkIdECK3GpN4o+w3sHsD7AGAvIUO0dOd1qOsHmHLR7LBgiccAw
 tO87F7eDTbXwe7QcIAW2QbCkmIrobZInvQbsLkj6wFgiMtDabaGyW9FmQ2w8QAqZoPSYpYtMh6
 PbB42UdEITYUc7IOiB+EgzkPkAI6ExhSZh9KIdg+xYkZDqw7cY6Sm1yHfrddG69/2K2nt/3jhP
 1gFAkBm8Kckq4Yy9/l3uWn7/62i+3DR+k1rh9kXPz9Sblm7TKU3fVVth+BMSxQD88z9Mqg4xLv
 S46ghRJ1IbijNNvuW/X96VYBfI0DP1yboLjmG2OIUSbtbTGBSabOtPalo1Bg1y6YoO6v1z+AMh
 5bdXUAwAA
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using /proc/sys/net/vsock/ns_mode.

Modes are per-netns and write-once. This allows a system to configure
namespaces independently (some may share CIDs, others are completely
isolated). This also supports future possible mixed use cases, where
there may be namespaces in global mode spinning up VMs while there are
mixed mode namespaces that provide services to the VMs, but are not
allowed to allocate from the global CID pool (this mode is not
implemented in this series).

If a socket or VM is created when a namespace is global but the
namespace changes to local, the socket or VM will continue working
normally. That is, the socket or VM assumes the mode behavior of the
namespace at the time the socket/VM was created. The original mode is
captured in vsock_create() and so occurs at the time of socket(2) and
accept(2) for sockets and open(2) on /dev/vhost-vsock for VMs. This
prevents a socket/VM connection from suddenly breaking due to a
namespace mode change. Any new sockets/VMs created after the mode change
will adopt the new mode's behavior.

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..29
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_guest_local_mode_rejected
ok 5 ns_host_vsock_ns_mode_ok
ok 6 ns_host_vsock_ns_mode_write_once_ok
ok 7 ns_global_same_cid_fails
ok 8 ns_local_same_cid_ok
ok 9 ns_global_local_same_cid_ok
ok 10 ns_local_global_same_cid_ok
ok 11 ns_diff_global_host_connect_to_global_vm_ok
ok 12 ns_diff_global_host_connect_to_local_vm_fails
ok 13 ns_diff_global_vm_connect_to_global_host_ok
ok 14 ns_diff_global_vm_connect_to_local_host_fails
ok 15 ns_diff_local_host_connect_to_local_vm_fails
ok 16 ns_diff_local_vm_connect_to_local_host_fails
ok 17 ns_diff_global_to_local_loopback_local_fails
ok 18 ns_diff_local_to_global_loopback_fails
ok 19 ns_diff_local_to_local_loopback_fails
ok 20 ns_diff_global_to_global_loopback_ok
ok 21 ns_same_local_loopback_ok
ok 22 ns_same_local_host_connect_to_local_vm_ok
ok 23 ns_same_local_vm_connect_to_local_host_ok
ok 24 ns_mode_change_connection_continue_vm_ok
ok 25 ns_mode_change_connection_continue_host_ok
ok 26 ns_mode_change_connection_continue_both_ok
ok 27 ns_delete_vm_ok
ok 28 ns_delete_host_ok
ok 29 ns_delete_both_ok
SUMMARY: PASS=29 SKIP=0 FAIL=0

Dependent on series:
https://lore.kernel.org/all/20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com/

Thanks again for everyone's help and reviews!

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eugenio Pérez <eperezma@redhat.com>
To: K. Y. Srinivasan <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
To: Vishnu Dasa <vishnu.dasa@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: berrange@redhat.com
Cc: Sargun Dhillon <sargun@sargun.me>

Changes in v10:
- Combine virtio common patches into one (Stefano)
- Resolve vsock_loopback virtio_transport_reset_no_sock() issue
  with info->vsk setting. This eliminates the need for skb->cb,
  so remove skb->cb patches.
- many line width 80 fixes
- Link to v9: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-0-852787a37bed@meta.com

Changes in v9:
- reorder loopback patch after patch for virtio transport common code
- remove module ordering tests patch because loopback no longer depends
  on pernet ops
- major simplifications in vsock_loopback
- added a new patch for blocking local mode for guests, added test case
  to check
- add net ref tracking to vsock_loopback patch
- Link to v8: https://lore.kernel.org/r/20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com

Changes in v8:
- Break generic cleanup/refactoring patches into standalone series,
  remove those from this series
- Link to dependency: https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
- Link to v7: https://lore.kernel.org/r/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com

Changes in v7:
- fix hv_sock build
- break out vmtest patches into distinct, more well-scoped patches
- change `orig_net_mode` to `net_mode`
- many fixes and style changes in per-patch change sets (see individual
  patches for specific changes)
- optimize `virtio_vsock_skb_cb` layout
- update commit messages with more useful descriptions
- vsock_loopback: use orig_net_mode instead of current net mode
- add tests for edge cases (ns deletion, mode changing, loopback module
  load ordering)
- Link to v6: https://lore.kernel.org/r/20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com

Changes in v6:
- define behavior when mode changes to local while socket/VM is alive
- af_vsock: clarify description of CID behavior
- af_vsock: use stronger langauge around CID rules (dont use "may")
- af_vsock: improve naming of buf/buffer
- af_vsock: improve string length checking on proc writes
- vsock_loopback: add space in struct to clarify lock protection
- vsock_loopback: do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net() instead of sock_net()
- vsock_loopback: set loopback to NULL after kfree()
- vsock_loopback: use pernet_operations and remove callback mechanism
- vsock_loopback: add macros for "global" and "local"
- vsock_loopback: fix length checking
- vmtest.sh: check for namespace support in vmtest.sh
- Link to v5: https://lore.kernel.org/r/20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com

Changes in v5:
- /proc/net/vsock_ns_mode -> /proc/sys/net/vsock/ns_mode
- vsock_global_net -> vsock_global_dummy_net
- fix netns lookup in vhost_vsock to respect pid namespaces
- add callbacks for vsock_loopback to avoid circular dependency
- vmtest.sh loads vsock_loopback module
- remove vsock_net_mode_can_set()
- change vsock_net_write_mode() to return true/false based on success
- make vsock_net_mode enum instead of u8
- Link to v4: https://lore.kernel.org/r/20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com

Changes in v4:
- removed RFC tag
- implemented loopback support
- renamed new tests to better reflect behavior
- completed suite of tests with permutations of ns modes and vsock_test
  as guest/host
- simplified socat bridging with unix socket instead of tcp + veth
- only use vsock_test for success case, socat for failure case (context
  in commit message)
- lots of cleanup

Changes in v3:
- add notion of "modes"
- add procfs /proc/net/vsock_ns_mode
- local and global modes only
- no /dev/vhost-vsock-netns
- vmtest.sh already merged, so new patch just adds new tests for NS
- Link to v2:
  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com

Changes in v2:
- only support vhost-vsock namespaces
- all g2h namespaces retain old behavior, only common API changes
  impacted by vhost-vsock changes
- add /dev/vhost-vsock-netns for "opt-in"
- leave /dev/vhost-vsock to old behavior
- removed netns module param
- Link to v1:
  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com

Changes in v1:
- added 'netns' module param to vsock.ko to enable the
  network namespace support (disabled by default)
- added 'vsock_net_eq()' to check the "net" assigned to a socket
  only when 'netns' support is enabled
- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/

---
Bobby Eshleman (11):
      vsock: a per-net vsock NS mode state
      vsock: add netns to vsock core
      vsock: reject bad VSOCK_NET_MODE_LOCAL configuration for G2H
      vsock: add netns support to virtio transports
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion and mode changes

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   57 +-
 include/linux/virtio_vsock.h            |    8 +-
 include/net/af_vsock.h                  |   58 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   17 +
 net/vmw_vsock/af_vsock.c                |  294 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    6 +
 net/vmw_vsock/virtio_transport.c        |   29 +-
 net/vmw_vsock/virtio_transport_common.c |   69 +-
 net/vmw_vsock/vmci_transport.c          |    7 +
 net/vmw_vsock/vsock_loopback.c          |   20 +-
 tools/testing/selftests/vsock/vmtest.sh | 1037 +++++++++++++++++++++++++++++--
 13 files changed, 1514 insertions(+), 93 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20250325-vsock-vmtest-b3a21d2102c2
prerequisite-message-id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
prerequisite-patch-id: a2eecc3851f2509ed40009a7cab6990c6d7cfff5
prerequisite-patch-id: 501db2100636b9c8fcb3b64b8b1df797ccbede85
prerequisite-patch-id: ba1a2f07398a035bc48ef72edda41888614be449
prerequisite-patch-id: fd5cc5445aca9355ce678e6d2bfa89fab8a57e61
prerequisite-patch-id: 795ab4432ffb0843e22b580374782e7e0d99b909
prerequisite-patch-id: 1499d263dc933e75366c09e045d2125ca39f7ddd
prerequisite-patch-id: f92d99bb1d35d99b063f818a19dcda999152d74c
prerequisite-patch-id: e3296f38cdba6d903e061cff2bbb3e7615e8e671
prerequisite-patch-id: bc4662b4710d302d4893f58708820fc2a0624325
prerequisite-patch-id: f8991f2e98c2661a706183fde6b35e2b8d9aedcf
prerequisite-patch-id: 44bf9ed69353586d284e5ee63d6fffa30439a698
prerequisite-patch-id: d50621bc630eeaf608bbaf260370c8dabf6326df

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


