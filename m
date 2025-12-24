Return-Path: <linux-kselftest+bounces-47947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2ECDB1F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 03:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1713230248A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF8296BD8;
	Wed, 24 Dec 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFPj+6da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB829993E
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541741; cv=none; b=Ze4tWztQM+q4c0S2KaQPDjxhExEuTZZcM4RjEGkNxlQRdnqY+DDGK1sDXcec9QJgVWhQTby/YLWVLAVAsOgu8g5AKVIhVMnMnG+ScxMHOBLBqlqPgWvQWY4kRXn6NsxOvnryzi6omNIqVfTbJa6gnbdcx4nl+I6F7GbMChJTkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541741; c=relaxed/simple;
	bh=4D1ql5NGQCt0c3ZbFdk1vgbuuqPn91ZETB157vg93SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z/CcUoQllua7ZltME3YimgCNjTnPbp9XrHZ7bvjnsw3r0UIKXJEDVIuyyhEwLixCY65L7TTGh88m6FGaXtgSI+usCx5D9TlV0g9ZyKsXLh3Xxrki7h/6kUygnMQxu5LKNPQQUxtLkwqGr1ksw+x39Bs1w4EHI6DwlhzzTMwBMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFPj+6da; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso67237715ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 18:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766541738; x=1767146538; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErnBMeWj6PhyaT5jVXiuqdZficH0P4n6mk5CWzq0oeI=;
        b=LFPj+6da3mMcjT52rk/CZQROt9qrB4UGCvYFSYI/S3Fhgi9evqS0/RwOUEohpL8PPy
         KUl0c8KXeXxTZhjmx8CNbIPlHkx6HLbYiRgOkYViqa/+7yRzZOHbenEE7U7qOWpGqPBQ
         nHQw6XTFSKdT/FMQYztFxt/LbJVy+vchudX8VLFvQGGmM6OkWU40jaKEsKFosPTFNUC9
         oGpOcDinlzJUUiPphEzmrYDxJRdjybQeTP/gxPQsNhaXQ7/mUeHumtuzWNG1LbBJoW/5
         CPhpIZ3BhVn6epkq5mB0lPTsa9VR27FGB0pRppAGAQjgLOT8sZJe9l/G0H3vFJIaS/5E
         VIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766541738; x=1767146538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErnBMeWj6PhyaT5jVXiuqdZficH0P4n6mk5CWzq0oeI=;
        b=qT7MVZq+ZJ+feBj3bM7JQUL9XWgFNzMfUFnPabxINSmeKNFvCjboDRvbzmo39MeE1K
         md0ZswBsuWpZLsDJ+V/QEy7DJtAoShNEeDzdkXvaLC1qMwXpltVbNQmUlQ/qNdUUurwQ
         vHMGefPWbY4fVFx8SfLN/qLI66Wa+83R8DH2bKgjd1AnxDRSQ9GfE6yUcl0YrTMrPyYr
         CR/OpBZUgdYJrC+oGOPd7Sbcc3HTKjInAo+8NS8zhJOklSpTp5iV+srmip36bLzrtZPb
         Q8/4mP+zY0x+5AirgZW0Qg2K80SJW5VGjGmu2PG93nx88r6LDhlVO4yb8K0olg5iFh7o
         RKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdiISpyT0gTrXX8JxzSV7ERHXXJGxl9P0zyffJrPLCWepSiE1IHvajE+ahKQUwkYJd6EYRcdsd/Yp5Xlr8bIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzxk3R/TQFbKG/MeOEE8teqDeKmu6MqHV3SxKFH6buLvlS/jz
	yuFQz0cwKA/AnB60IHPat6hOqMtIyXLn3UBwILv1ZZpkvh5NBjcRWc4vqY+bFg==
X-Gm-Gg: AY/fxX4SLDDWwVurckAhXYCVhh9DVxx9Jp3S2azsf754tbDvf/AESB4dDDAPDQn/tAL
	yBVxNobQbCFzEgEac+kMxVd1nia0zxbuGhi2sgENu65ekABMaJe6YFXtxYEJY/gL0Gshiy/rxwY
	8ECXpj+LXKUKDGPyBDazljUKGXG1H1UHKg7UPW7rsjdD18+g+T5jxHko4HpCXw4xoVvh5qH6qW0
	YINA1P8MY6ar4e7I8kcqU1JIoRNZ13mfHGE2oM/q5d3m+/BE1weTLvn8SFYmqLVRHCBP4MIq9bT
	eKnmUeRpCJzdIXG3Ank4+VBm7bfUt5Czb+hZCvqtXfiTGEgZUrY5Bc7VQtv0Cj9Iy0GXXk2WA/X
	/WbyfOLrn2w7eF14DpVFEBAYW8oSeWULPjbFAthVctHa1dTooAqM6qEYnJ7FHGZqD2KJfBkwWT1
	TX6p8IBgJ/8QnMCkA4yrU=
X-Google-Smtp-Source: AGHT+IEzm/ibZMvW0WDYod06cdGDdF17eottIlsNSCoG3mOTQ5rlmwiFEkCEyiy9R06vh/9NSDfGJg==
X-Received: by 2002:a17:902:f542:b0:2a0:c20e:e4d6 with SMTP id d9443c01a7336-2a2f283de1amr147271975ad.39.1766536134920;
        Tue, 23 Dec 2025 16:28:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b51esm135955525ad.43.2025.12.23.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Date: Tue, 23 Dec 2025 16:28:34 -0800
Message-Id: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUzS2kC/5WTy2rcQBBFf0VoPRWqqt9DCIZAPiDb4EU/SrawN
 eNMK8LB+N/DKIOt9HiTrdC5R1zVfemrnEap/b576U+yjHU8Hvp9R2rX9fk+Hu4ExtLvu56RDSo
 2sNRjfoBlmqXOkFRkKkzImftd1z+dZBif17wf/fdvX8/PDjLDQZ7n/nbX9fdjnY+n36tvofW1N
 VkT/pu8EBAMykRPJabg883dFMfHT/k4rUELb2HXwAwEKiBFdkqR+BZWG5h9AysgIE9xsGTVoKS
 F9TtssDVrILDCMTi2nIvdwLtLix7NFYSAJkg2FBMR3Uwyx3eh2QhJNawBAi3OZB21yZI+ErK7g
 hAwReMxSRGTGqHdCtuPtUAQ4kA5I6uA+IEwkL2CENDqwpIw+1AaoXsTEjI1rFtZS8klO6DftHP
 x/Rez+vzW1zbqAaFIDF4X5JSwYQnfYbq6PMIzPaAfyJp0vp6Gpg3NV0dPgGBMTtkj6xBdS/OWb
 ksmBgQ2ToQpF1O27te/6zzJz19jHefLRCepNa4b33efL3XwJbXK43DOrbBOGuKhwDg9nY6LTHK
 Y63miCFIkkQvFaqvedF/OfybFKpCP0zTO+y5YjtnkGEI0WYnTNjCZNGhnHGuNGrkMxYT+9vX1D
 4bMxe2VBAAA
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using the parent namespace's
/proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
created. The mode of the current namespace can be queried by reading
/proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
has been created.

Modes are per-netns. This allows a system to configure namespaces
independently (some may share CIDs, others are completely isolated).
This also supports future possible mixed use cases, where there may be
namespaces in global mode spinning up VMs while there are mixed mode
namespaces that provide services to the VMs, but are not allowed to
allocate from the global CID pool (this mode is not implemented in this
series).

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..25
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_child_ns_mode_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_delete_vm_ok
ok 24 ns_delete_host_ok
ok 25 ns_delete_both_ok
SUMMARY: PASS=25 SKIP=0 FAIL=0

Thanks again for everyone's help and reviews!

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>

Changes in v13:
- add support for immutable sysfs ns_mode and inheritance from sysfs child_ns_mode
- remove passing around of net_mode, can be accessed now via
  vsock_net_mode(net) since it is immutable
- update tests for new uAPI
- add one patch to extend the kselftest timeout (it was starting to
  fail with the new tests added)
- Link to v12: https://lore.kernel.org/r/20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com

Changes in v12:
- add ns mode checking to _allow() callbacks to reject local mode for
  incompatible transports (Stefano)
- flip vhost/loopback to return true for stream_allow() and
  seqpacket_allow() in "vsock: add netns support to virtio transports"
  (Stefano)
- add VMADDR_CID_ANY + local mode documentation in af_vsock.c (Stefano)
- change "selftests/vsock: add tests for host <-> vm connectivity with
  namespaces" to skip test 29 in vsock_test for namespace local
  vsock_test calls in a host local-mode namespace. There is a
  false-positive edge case for that test encountered with the
  ->stream_allow() approach. More details in that patch.
- updated cover letter with new test output
- Link to v11: https://lore.kernel.org/r/20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com

Changes in v11:
- vmtest: add a patch to use ss in wait_for_listener functions and
  support vsock, tcp, and unix. Change all patches to use the new
  functions.
- vmtest: add a patch to re-use vm dmesg / warn counting functions
- Link to v10: https://lore.kernel.org/r/20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com

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
Bobby Eshleman (13):
      vsock: add per-net vsock NS mode state
      vsock: add netns to vsock core
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      vsock: add netns support to virtio transports
      selftests/vsock: increase timeout to 1200
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
      selftests/vsock: use ss to wait for listeners instead of /proc/net
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   44 +-
 include/linux/virtio_vsock.h            |    9 +-
 include/net/af_vsock.h                  |   53 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   17 +
 net/vmw_vsock/af_vsock.c                |  296 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport.c        |   22 +-
 net/vmw_vsock/virtio_transport_common.c |   62 +-
 net/vmw_vsock/vmci_transport.c          |   26 +-
 net/vmw_vsock/vsock_loopback.c          |   22 +-
 tools/testing/selftests/vsock/settings  |    2 +-
 tools/testing/selftests/vsock/vmtest.sh | 1055 +++++++++++++++++++++++++++++--
 14 files changed, 1487 insertions(+), 133 deletions(-)
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


