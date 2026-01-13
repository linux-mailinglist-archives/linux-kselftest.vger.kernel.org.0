Return-Path: <linux-kselftest+bounces-48837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221CD16A72
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 06:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66055300AAFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 05:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3A3301002;
	Tue, 13 Jan 2026 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJI2xTmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5B26056E
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280773; cv=none; b=hcDwPxA/EjFsyOxcuRx7eX8qRdAWN1u3faXfh3OCGp2iIPYT1gYjBNyLlOwm6DZNMBZwlR0jlI7yFdlMTSiNMRTXSlscaCDarjAcr1C2wlQ5HpqZwvmozYARSGFK8L9APywlNMUneniPEfBg794vRqWKJA6cZS4uhwv9q2QJess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280773; c=relaxed/simple;
	bh=CV2fwnUO8gdhzUFewWlJ97rJBZdABxHUXdkyCIJ0XlE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jusJ4Zek8KmN6ShAM2w1gegqytrcT+PDp9zJ7NSjVQhDE20aPGvNGn2T5vqAH0Np9LRnZm2BS/rZQWanI/8iY8mXE+0+oBt/y+wVafLyio1DRFf8Mkzvy/eNlZdIcQIn9MK2SRWU+fCTsBSCoLuLBe1x81IKcLOTmuFGfXDvYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJI2xTmj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563610de035so3253687e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 21:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768280770; x=1768885570; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqprqS6XZD/UF3ZjzkMVpuPhwhGmYnu66pPo4XaWWiw=;
        b=GJI2xTmjGz8xgXWoy3INcgH2juuI0xhFtYA2r1U/7IUq7GvLfg6GfPkH0jm9mq802X
         qwvEbf+nT2J3FqTD0C5PxlwJeVcgLx3S27Yw3qPrf0XJAWkEYX1SJ4jQTsh1i1BWzJSN
         WH7wp/kIw3nlakHg2WDhx1lBnslF4mRzJBIwpFTgvo1gyp8Btuoq7rwIKVieAQ5J5Egb
         r3T/GAui3rjfFcLk3o+G7D0Iw9xxuHToyc9IrX8W52ma9TDzeRdEoiRH/u5hc/l2Xe6i
         XdLKBv1VucESXC8YijytEfT85fBOTu5NM/+xXuNyAY8TfdaQB+b7ZNPSNKazGa2bUxJc
         Bhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768280770; x=1768885570;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqprqS6XZD/UF3ZjzkMVpuPhwhGmYnu66pPo4XaWWiw=;
        b=DsIiDlcH3QD8wrxIOMfBUwycumZRc0ohmgZpvLH/g67gFPphd0LXx3RxJOtersUl5p
         Je5n8guWe7YSmvJuX+YJOHyMp3Apk8uaDjLfMwXRSkFDHiluknSYl+VWbD21nBoEq5Oo
         zCgcvSPvNx/0Hd8hmCWRVHK7EY0538Ff5z7MGZ0tsIt5VdVuCivfzikiuaC/NFtTJLwu
         FxitYsla5csTA5xsPqSAWL/1R0xEkTpwnKycWbWZGvcfWXk10+WglrymVVdMaGnRfiAb
         /gwY6WIsBScdPYDllgC8CIOqjl37Lan0+kVgeB/i+eRa9ahwSZI4PNjp/3qoZrBkIyG1
         mdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvTa8clSjSMjBXsOKovYNtUQxUI5Ti64GsmGYfdWYqkmULcWoUhWTC8ZvAOSpEUlp725nnOzw5ocjVUt0w0GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AKt+DP9QW2dJj51VU+t07sCdUqMvXbphd4XraZXo4vkkJ7XM
	iixvLfc7fEGTRcblqYa7fmwwoBuytRZrWF7l3BPWYfb0LeUK+M8ylfTwFyvJTQ==
X-Gm-Gg: AY/fxX7UBe1JcvujM5I/pfv1nqApGUw0TkFpCKO4UkjBUxjAyiHloUsVWz2LSyNKVGy
	KBupoKx832/VQRW03tat7snDNESEyLbSbQLVBGe+ePxo3mOHWSKc6yovas6W8/mKsmGr6RqapJR
	B0SIsUANPBHa1xpbgxAJ3wMa0mBPwDDbr+XLQKJRkSY8bIlmBSXscwDHJQ6asp5bL8UIIatMlqA
	UhzGrnUv+sVT4xnboLXAButNw85R0oaWasBBcJ888TYeKQNLxc8r5EjGxpusGVEgQZi193sqE3P
	hjt0xFJah2e33Vr4hB7gFzivcUknm/2I75PsnLxfGTK5as+iK6z0Im9dKTnfhRtsbqoV1OzNJjf
	DD4jLzOEPOJfhX0VEuzIw1vWbQ323uHjFPi6h2ciYJYWZNpGxfNyG5Uh3ISfbuw4WUv2eRcd6XN
	qWvugefo0Ryw==
X-Google-Smtp-Source: AGHT+IHEvqz6F5p7PryBFdPW7drnRDd9TzB6bNh+ElUhlxBsvZhx+8dgAoo5zTxbfe4+m0mCDXbGmA==
X-Received: by 2002:a05:690c:39a:b0:78d:b1e9:85ce with SMTP id 00721157ae682-790b5703932mr163750627b3.59.1768273976093;
        Mon, 12 Jan 2026 19:12:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d24ae23sm49625307b3.0.2026.01.12.19.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v14 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Date: Mon, 12 Jan 2026 19:11:09 -0800
Message-Id: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+3ZWkC/5XTS27bQAyA4asIszYLkvP2KvcospgHlQit7VZSh
 RSB715ECerpOJuuhY+/QHBe1SLzJIs6Dq9qlm1apstZHQcyh0GV53R+EpiqOg6KkS1qtrAtl/I
 NttMqywpZJ6bKhFxYHQb1Y5ZxetnnfVVnWeEsL6t6PAzqeVrWy/x7D220f99HGsJ/R24EBKO2K
 VBNOYby8HRK0/cv5XLaB23cYt9hBgIdkRJ7rUlCj3WDOXRYAwEFSqMjp0ctPTY3bLEvGyBwwil
 6dlyqa/DhY30B7R1CQBulWEqZiB5OsqZb0DZB0p21QGDE22KSsUXyZ0H2dwgBc7IBs1SxuQu6N
 tj/rAOCmEYqBVlHxE+CkdwdQkBnKkvGEmLtgv5vkJCps363jrLPbsTQbOej919m74W21280AEK
 VFIOpyDljZwlvmO4uj/BNjxhGcja/XU+nqdF8d/QECNaWXAKyicn3mlvdL5kYENh6EaZSbW3b1
 /dnOcvPX9Myre9v8/F6/QPnmSjR+wMAAA==
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

Changes in v14:
- squashed 'vsock: add per-net vsock NS mode state' into 'vsock: add
  netns to vsock core' (MST)
- remove RFC tag
- fixed base-commit (still had b4 configured to depend on old vmtest.sh
  series)
- Link to v13: https://lore.kernel.org/all/20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com/

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
Bobby Eshleman (12):
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
 net/vmw_vsock/af_vsock.c                |  297 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport.c        |   22 +-
 net/vmw_vsock/virtio_transport_common.c |   62 +-
 net/vmw_vsock/vmci_transport.c          |   26 +-
 net/vmw_vsock/vsock_loopback.c          |   22 +-
 tools/testing/selftests/vsock/settings  |    2 +-
 tools/testing/selftests/vsock/vmtest.sh | 1055 +++++++++++++++++++++++++++++--
 14 files changed, 1488 insertions(+), 133 deletions(-)
---
base-commit: 2f2d896ec59a11a9baaa56818466db7a3178c041
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


