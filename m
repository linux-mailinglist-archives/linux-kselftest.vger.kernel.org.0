Return-Path: <linux-kselftest+bounces-49199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282DD38860
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD805303D346
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A230B506;
	Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh96nvis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08473033E3
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598947; cv=none; b=blVVuIp6o5EHyDJYsRWCTn+ViDZPajN4dylnpGFDVk7lO8saWTxUGOTaMO2NPPB1TluX1UccXSQuCQRiNYfXv7XlpCFIevZd8abr9+oUCncd7uK74+o4ntD/dl25M8EgIr21JOzJIALmWNHYh3wYqyQ37M3uPVuOIXU/7S+mpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598947; c=relaxed/simple;
	bh=Rjf7rnTE035uakNtyW6UGNTzcbWnZJRGubCnIco6OOU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=plcUfiICJg5qvkGF8gMwQp4lmDsbOG7NgBmtzm4J9FsU46ZGgAD/BZ/l7QSkJFHD3FWEnSCV23Nniqra+gO/q1TiQ3OlLjx7ViRAwQJKOgBO1y9yXkpl5TCSiKeEtrprzgYucmlayq8DctEc4zvEhGHF7LnocsTNzQRYgUq9umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh96nvis; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fb6c7874cso27351867b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598943; x=1769203743; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ep2DKzU3RV1Kudl5YaFb4t8CYT3MYwQLPMgNnEADhz8=;
        b=kh96nvisgSfNuf39bN+pJZ8aMFJJMUFDg4sU8K/N5OlnJueUHtQANCRcNRAVnDtWHN
         oR+fQ5TjVwv9GqESmrDLjXey8XNy1LIXbGE25Mt2wON3wHAJFTOhdB+6C15oaALhm+XO
         bd24rwARZ5uNOYAetMc0o8hEjRGUJfOc3uz9U72at+4VZIJsSrdFZ4HbUIpdGgbUKMgn
         aSOrWBQkmb2kWK80ZCJAJgPHCIA5qkVaSGryHs/d6Y5UIveprc0ibdweaZQAH8tvk/ZW
         wTyPf0+fOfaoxN6A3NN9UMh9dhop07YIivKg9MRU43kSigDhvnbhhO2iSUjG2960/CLN
         rZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598943; x=1769203743;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep2DKzU3RV1Kudl5YaFb4t8CYT3MYwQLPMgNnEADhz8=;
        b=vYLH8Z4OornOMzG8nPB0lr5Li717bC2L6zhBkZmLr/uJfqKBxdzi+IOL37aCxQL2W2
         lWI2dRijdCNYVY4TTqenAiLJVduNosSl6BuJq5z8DLSgiYDoSDhsw/q9NbmDzKaXXuKo
         ErfxWzj+fYMYw1CdvyFiB9IBv5OzvKLKN9d0GixRvfgEs5cNgckSE46ZPOZd4QqGjaXO
         eiPvJrTrOQgTycIgm5eOo2/XhAg/Jf4RnHV2EIh9BpXyOAyWqN2xvud8Z/gRxjlIvdLC
         MmEI2uLFtvzuLk2sq2u1yHoy0igXVU9KU1a3MogTFN8FtHaf/8xpUHv7LAcn5wWDBIGP
         5YUw==
X-Forwarded-Encrypted: i=1; AJvYcCVhDZEr8vAGHG5wIxBzrqBYxiOl6ovRMafb4v7Ci60d9JF7oOSetWjh/nJnuemATeRxid3c171CfmT5slKqLUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFim/ru3jauBeMjxtBoW4fB4WjokWCXQdkyFlB0jeek5+IuZT
	SidMGhUKmpUnhwuK5BNrBUq++fj59mKWEzfUV6JsxzIaPTAQ7nbTptLX
X-Gm-Gg: AY/fxX7s38GpCv4oDTYld/F7T4WBwPbqqxXMOkuw8lmlqlF5CDxNc+Fw6+jQLmaFKXW
	mK5VM4KIbYubh73bgDYB2ba4kdnmicGH6dhrWpLasHANsM0gqfQ5eb4EjnjDtfzY12HTfOCDaI4
	P1lSkvpF2s42YAkWqW01HYcbyyB0D+xcTvW39lCik2EdoqZuricudkFRHLgdD+ii3agp6ucq0rk
	6vCUgi2GEXgtA0Lv7Ms2X+/0xsaOKmXc1/4BHAFgAGnJM4vqMpuDCK9mMfTysXuMzYYK5Hp1RZu
	byiqYjBP2KaoGpFpfs2EAVCK711LC+af9WXMQqGPY1oMbV3pFjKG6ufpYxbjE1XX63licXNI+TX
	J5obiTg6CPd4UKVGcXSH0VcX6GlA0j+jEB2jj3t4EWutCEqZUlAg8LJNu3n4rBhWnI11Kb5lVmz
	CIEwyA/t8xTg==
X-Received: by 2002:a05:690c:d85:b0:792:725c:a37d with SMTP id 00721157ae682-793c66dfc9amr32763477b3.16.1768598942631;
        Fri, 16 Jan 2026 13:29:02 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f66cbsm13580337b3.13.2026.01.16.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v15 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Date: Fri, 16 Jan 2026 13:28:40 -0800
Message-Id: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqtamkC/5XTS27bQAyA4asIszYLkqN5eZV7FFnMg0qE1nYqq
 UKKwHcvrATxdJRN18LHXyA4b2qWaZRZHbs3Nck6zuPlrI4dmUOn8nM8PwmMRR07xcgGNRtY50v
 +AetpkXmBpCNTYULOrA6deplkGF+3ed/VWRY4y+uiHg+deh7n5TL92UIrbd+3kT3hvyNXAoJBm
 +ipxBR8fng6xfHnt3w5bYNWrrFrMAOBDkiRndYkvsW6wuwbrIGAPMXBktWDlhb3d2ywLfdAYIV
 jcGw5F1vhw8f6PJodQkATJBuKiYgeTrLEe9BUQdKNNUDQizO5j73Jkr4KstshBEzReExSxKQma
 Otg+7MWCEIcKGdkHRC/CAayO4SAti8sCbMPpQm6zyAhU2PdZi0ll+yAvtrOR++/zNbzda/dqAe
 EIjH4viCnhI0lvGPaXR7hTQ/oB7Im3a6n0VRp3h09AYIxOWWP3IfoWs21bpdMDAhsnAhTLqbs2
 p+Xa5GIW327wmiy1lySFq6P4vr+qCf59Xucx+X9ZT9er38B0H03bjkEAAA=
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Changes in v15:
- see per-patch change notes in 'vsock: add netns to vsock core'
- Link to v14: https://lore.kernel.org/r/20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com

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

 Documentation/admin-guide/kernel-parameters.txt |   14 +
 MAINTAINERS                                     |    1 +
 drivers/vhost/vsock.c                           |   44 +-
 include/linux/virtio_vsock.h                    |    9 +-
 include/net/af_vsock.h                          |   61 +-
 include/net/net_namespace.h                     |    4 +
 include/net/netns/vsock.h                       |   21 +
 net/vmw_vsock/af_vsock.c                        |  328 ++++++-
 net/vmw_vsock/hyperv_transport.c                |    7 +-
 net/vmw_vsock/virtio_transport.c                |   22 +-
 net/vmw_vsock/virtio_transport_common.c         |   62 +-
 net/vmw_vsock/vmci_transport.c                  |   26 +-
 net/vmw_vsock/vsock_loopback.c                  |   22 +-
 tools/testing/selftests/vsock/settings          |    2 +-
 tools/testing/selftests/vsock/vmtest.sh         | 1055 +++++++++++++++++++++--
 15 files changed, 1538 insertions(+), 140 deletions(-)
---
base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


