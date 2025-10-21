Return-Path: <linux-kselftest+bounces-43695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D280BF9484
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C0384E6BAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE6244664;
	Tue, 21 Oct 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKDRURiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84699136349
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090422; cv=none; b=Lqc5GCDaJa4blDACFtZBIJzlNUlXvZpOt5a535vPXIjEuKlHx8ay6UQvzK4OIe4RJUkS2A+yVWv46stslSVUPU8mjHf4O3qJgMKuQFMnXok8MatP6vSlDtrWWHdA4IQbr9tumV4QO9+FXsmzKr/z1I4hPx2BlohvOr48y0L2mIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090422; c=relaxed/simple;
	bh=sxEe7wKQTI1cXtS+jcamtft7UKHTPnC8HBOJBSG+HpU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T7SxgqHdYLRZePFRXXekZcuG8b/wNi8tZUTPUeYneyPFM+BkpIEPIh4bSIjPhL0isTVZwUXnwmz/HWbU8OxrJ8VEz2/VY/RJvlQpl3iznXX+xkL9m5Dy4y8UJUSiKmElvYGkQFM2Rsk9y+SwyLIyIvXAPtOi7LKiEeOtasUlipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKDRURiy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2909448641eso4563075ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090419; x=1761695219; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw5ndleCETxXN3bLoBh9RnTUXlwXg1fgE17mZpwk8BQ=;
        b=NKDRURiyTemqUGQ/LSOwE/nUXeYmVUN1QH+bxnIJ1I0jCJcvlIv7OWSBvE41JlyjmH
         fLjo63Ka8a8H/G64SWhhF8fr/iNgs2Th24z10MeIWcvAoZBITJoB5FRKbn3cXoJCEfT3
         2GzJCQ4nlOGgArTvyYDL2g8JRF0m4p/xQLxTS9kztSULTuHfH9EUnaRUjG0TgSVaKwnw
         gCA8Kfvem5GA3CSaXt/jvYuJDd2T7pWkyiM+kyt0KynMYVHRwMhNEuLp+Dak1AdS7QLn
         Z7HkC8lWvx43B2xzkkfYEsgNaxI+0eCMlA35hyaWCfZXPrZE4L3oFinfCJUac9D0D02W
         YBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090419; x=1761695219;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw5ndleCETxXN3bLoBh9RnTUXlwXg1fgE17mZpwk8BQ=;
        b=LIjtSzkfL8QIhYY20MDejJq4ptRZbdlLWq3ShvdidMJDFCs6/vLLwfKkCGt5o/nrhf
         wmTvqGm9VCedOzgpMohll90SGPlI/T3pVcc2wQ7JrhV5k3Y44nMi1+idlUDTXu8j6iCr
         yw0sx+DG3qwPWo4P8gN+kZOkA1IBn/STZJu/PQVxKRFnU91bDQrKrM0j5FY6VTSWrlRJ
         GCb4eESqrvLdMsaLRRS5NpVmAMr8Z6F798rISXb7jgKkuQj5EE8v+6pCEmcRBWbSMeYI
         YYvAm6Ng/s1dDNcLSKEvn/dStmJ2L4MUbPIx9BIyBloJ5MyRLI/GSEWcPjbWrDrkV7t5
         4Cfw==
X-Forwarded-Encrypted: i=1; AJvYcCVHH2HLNFPrmssP6uko47YPPb5VTUm90C1DW02UWuiqVMbbRhXCYTfs1lIUaKyvxSSxk8bBOjlPSqSUTNnOPvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/FOuHfEmWs7MVo3JDDeOskXpthc8tQ9OmXjalEX6zc6p39qa
	+n+/4J0YGmFjWHCha/wTVAahP2OIuY5hsmFcJ8mFa6nxCHEThtl7SNcq
X-Gm-Gg: ASbGncvWy3dYyUNUnCyLvMNFJRpkHkE8ipIdWAIPjKyThnmmzO1snaQFuYG8KZoxj+Z
	y6BaKQpWdOe7M1NTOu2RcPCAwLXUw2u9MF1/mAwEhSGW2X8yozFbQCk7lmQbJ7aix6JZJVlMqLV
	AEs6zcInJ3PyyaFCPDsfZKY8nmciw5vSGXLvwVbVp/a6aQ06riEXfvDxi7Uuqj0IbV16uwteFmB
	72MPbfBAQ64OQqMi/tVewW6jzA3Bk7PdkcJHHYZ54uYGdMs1ybPSV1xLlPV8uT+lS7Cp/B0uurl
	C908XDnlhNzgNrZh7kmgKSOckz+mlv3WQ8rb96VjM0tGF5e3wGNbB9Vvn7Qroxx+d5Kg9Z6AHIj
	vM/N4iErVZoFj28UZmKj0Jj13HvoW72/esmm+1cybqni0Iu1fhfB904gGkQAKpmWj2flBu4cjFp
	V0UvEs2ck=
X-Google-Smtp-Source: AGHT+IEDbF+/Dj97AVhpexNYTsm2IoLFSCvC/PjoVJW6IERDPyrMK6v/77DhuigwZGTSesjCjyxumg==
X-Received: by 2002:a17:903:2446:b0:271:9b0e:54ca with SMTP id d9443c01a7336-292ff83ff59mr21081185ad.13.1761090418711;
        Tue, 21 Oct 2025 16:46:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm120732845ad.79.2025.10.21.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:46:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v7 00/26] vsock: add namespace support to
 vhost-vsock
Date: Tue, 21 Oct 2025 16:46:43 -0700
Message-Id: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGQb+GgC/23QS2rDMBCA4asEraOiGT0sZZV7lC70GCeitV1sY
 1KC715hCnGVLIfhm1/oziYaM03sdLizkZY85aEvQ3M8sHj1/YV4TmVmKFALiZov0xA/+dLNNM0
 8SI+QEARGZIV8j9Tm23bunfU0855uM/som2ue5mH82ToLbPvtpALx/+QCHHgrtbeQfHA2ni+dz
 19vcei2QwvucVNhLFg6AR4bKYFsjeUOo62wLBgs+NaAka2kGqsH1qIuq4INoXcNGozJ7PDx7/u
 s0E9IcKEdRQ0+AMC5o9k/gnoXBFlZXYKKGh2VVzpSeBXE5gmVYPDaikCJdKiCZh+sH2tK0PkWY
 hRY/li8CDowT6gEjUpIQUTr0i64rusv5EEAon8CAAA=
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

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
allowed to allocate from the global CID pool (this mode not implemented
in this series).

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
1..30
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_ns_mode_write_once_ok
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
ok 23 ns_mode_change_connection_continue_vm_ok
ok 24 ns_mode_change_connection_continue_host_ok
ok 25 ns_mode_change_connection_continue_both_ok
ok 26 ns_delete_vm_ok
ok 27 ns_delete_host_ok
ok 28 ns_delete_both_ok
ok 29 ns_loopback_global_global_late_module_load_ok
ok 30 ns_loopback_local_local_late_module_load_fails
SUMMARY: PASS=30 SKIP=0 FAIL=0

Thanks again for everyone's help and reviews!

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
Bobby Eshleman (26):
      vsock: a per-net vsock NS mode state
      vsock/virtio: pack struct virtio_vsock_skb_cb
      vsock: add netns to vsock skb cb
      vsock: add netns to vsock core
      vsock/loopback: add netns support
      vsock/virtio: add netns to virtio transport common
      vhost/vsock: add netns support
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add namespace initialization function
      selftests/vsock: remove namespaces in cleanup()
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: avoid false-positives when checking dmesg
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion and mode changes
      selftests/vsock: add tests for module loading order
      selftests/vsock: add 1.37 to tested virtme-ng versions

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   48 +-
 include/linux/virtio_vsock.h            |   47 +-
 include/net/af_vsock.h                  |   78 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   22 +
 net/vmw_vsock/af_vsock.c                |  264 ++++++-
 net/vmw_vsock/virtio_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport_common.c |   21 +-
 net/vmw_vsock/vsock_loopback.c          |   89 ++-
 tools/testing/selftests/vsock/vmtest.sh | 1320 ++++++++++++++++++++++++++++---
 11 files changed, 1729 insertions(+), 172 deletions(-)
---
base-commit: 3ff9bcecce83f12169ab3e42671bd76554ca521a
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


