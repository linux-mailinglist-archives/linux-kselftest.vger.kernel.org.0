Return-Path: <linux-kselftest+bounces-46184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED199C776A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C77524E7C74
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58952F657E;
	Fri, 21 Nov 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDtUXo+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC72F3600
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703894; cv=none; b=j1YvzJiF1FAalkXnVM33ngskcSoajaVe57VuG+gmliRAmkTduprdSrMk5o+QOb8kkpIrhc2WQUoAFxSLd6bc7Saj8fyqrt71I0S/X2aMo+YBaez77nnxs4jVKhcYB90qbzq7yPr2H0Obt/JHjXWLpoSlvTgrCPs0l+iwNVIqXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703894; c=relaxed/simple;
	bh=v+3mqn7x6EJwdMqfRO8b3MLV0/MNfhU8PKpDmTGf9Gs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JZxor6ookBLyQpUlRIsVbsF+GvjnBp/xLpNFGwVK6hQK/+t2ABowgjTjsuzwG6DZhZPcJ5Y9N+tYgEBUVaf+iO+MFHI8WhFOJLmpuH8Z3UWJPhhisGbSiVY+LpgVd1PD+lAD+8wfW+6rimEed5xCEq7hP4UgLEfm8jsB0P4OC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDtUXo+y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1947165b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703890; x=1764308690; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJj6PeCkl7WJC1b3pTRdGv6b8Jy4x+Cp3a0eEHKW85M=;
        b=jDtUXo+yM5Dm7HtN4+zskcodtJCJ23mTUlHperufFG6xFk9IcsL2XbtzBuZyJNPcSP
         oiR2nl6Kt4foHQLmPmwD7CWc0SPamKPEB29Dzwm3oTek8qvZzUgdRMOfeEMqTBqyInZY
         CYvWDPKnYKkt+3eLXxbAMANZJez9I0xUckt3raIHzy9JhHBQP8gu8ZTe9VBzX419e3H1
         GFKrsKSPEZeeh187Ix+GZmdN5YRznLLY7GRyJMGmI/0DwLMrTkEJ8oqCJzNqoCNZmVYS
         p7EiDjtsE7tlViWwN0/1Gi+EuztWf6K8R6byqpUbhBNbyeNd8zikdUMKbmqB3YHJlWek
         sIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703890; x=1764308690;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJj6PeCkl7WJC1b3pTRdGv6b8Jy4x+Cp3a0eEHKW85M=;
        b=NHec9cUZ133iOI6A4xnaUOmingSbg9jr0Bt7EomFcaqwF0cbF5kkGz4/8sOCaNCAeU
         1V5DpYiVTMAvxFYFvmVrcVtOc8KybCiORck4Cp4R+vyp7iGaBcMF6NoMSNb2hu29h+hy
         ff/O6vIUhhGNUfhTlQ5FuqNQAmchhWGzHt4aILKnsQQKY/Gkyf9CeJrz4dF5XksEuQHt
         fhkT82rlNKBn2jA2a2JJavPw2S7k7nlf9wHJM0lMhvX7cE80e6DUG0k6r2v+MGrWKSCq
         +W6rAdFguPJInJPOU4Q5U4/IYDTyW6UdANXTCtvc4sTRWgux0FFiDPqwUXVTwu7nyyDc
         DWdg==
X-Forwarded-Encrypted: i=1; AJvYcCWv9+vm+wMlFA9MDrkJIqbK71JqvxQHDCZU4ohYy4+k1APgMmM2Z8NY9K7OIiFM1TIaMf2Nv1ZyGXicFbZsyLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWDylFmibi2EPHp8WLXgiOigPN57fKZ3zuOfKXeUDNbCcQZmc
	Y4/0C4tu9esIaUQRT8Oh2jXYdRC+xyfX595pg6vr9yHY5OE1J86xAN+j
X-Gm-Gg: ASbGncuLySIFAyJaSqIJ3IxgEeyOG8sLEHWAYmZykn+BjRI9ZW7+80ufBmzGYFO9M8v
	tj/HVcI5CWvHjWK6juXaZm3J/ZdxNIsygoJ1hw2KSCcUQy/2dGd8SRwd4coey5I7ZbGfOeF5862
	dVP39Ycl9Tk/KW6W+1bwj9avmvEZVudB2zHdm0Ph+A+SWpYnnYVYPVuQVsbEVcLBxG5bEb58eaV
	Y4nU6IsXZdmYU3nYORd90vpXNPkHzgdqpTmUCHawvikmZ36bzoeIlXoq0CIq2s+INNSthO08lBp
	kBezBoR5KiSM+vra0aCibAGGhxLu7gM502FwLctKFdsoZ9Sr3xB+Nv7WD5B7dF0zgZ5nigOUIK2
	63WSANPYhkhrR2003B2axiabA8aMii1JXxEwcMjlROPrjA2giY401vVBh38qyNXoOFuHSloJEc1
	fObO6wrPjqhzg4UT/Lb2GV
X-Google-Smtp-Source: AGHT+IHc3KeNtHOz7PTZUGNRtj1ZDtRNOtZFXTYX5sz1GibN9Yd2lwt/TOcNHqp74LXcISyTq6hx1A==
X-Received: by 2002:a05:6a20:258e:b0:35d:c68e:1b08 with SMTP id adf61e73a8af0-36150f3f808mr1241718637.53.1763703890185;
        Thu, 20 Nov 2025 21:44:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7604dedeesm4364076a12.22.2025.11.20.21.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:49 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v11 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Date: Thu, 20 Nov 2025 21:44:32 -0800
Message-Id: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEH8H2kC/5WTy27bMBBFf0Xg2lPM8E2jKPIfRRZ8jBKhkZSaq
 pAi8L8XVo1YpbPpmjj3DC5430Xl08BVHLt3ceJ1qMM8iWNHdOhEfo7TE8NQxLETEqVBJQ2sdc4
 /YB0XrgskFSUVSSizFIdOvJ64H962vO9i4gUmflvE46ETz0Nd5tPvTbTS9r5FasJ/I1cCgl6Z6
 KnEFHx+eBrj8PIlz+MWtMo97BpYAoEKSFE6pYh9C6sdLH0DKyAgT7G3ZFWvuIX1DTbYmjUQWJY
 xOGllLnYHH671eTR3EAKawNlQTET0MPISb0KzE5JqWAMEmp3JOmqTOX0mlO4OQsAUjcfEhU1qh
 HYvbI+1QBBiTzmjVAHxE2EgewchoNVFcsLsQ2mE7kNIKKlh3cZaSi7ZHv2unavvv5jN5/e+tlE
 PCIVj8LqgTAkblvAG093PI7zQPfqerEmX33Ojz3+nceKfv4Y6LNd9jFxr3AZ27L5eT5LX1Mov/
 SW3wrYniFOBYXw9zSuPPC31MhMELpzIhWK1VR+6b5d2UqwMeR7HYTl2wcqYTY4hRJMVO22DJJN
 67YyTWqNGWfpigng8n/8Ag9OjQhIEAAA=
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
ok 4 ns_vm_local_mode_rejected
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
      vsock: a per-net vsock NS mode state
      vsock: add netns to vsock core
      vsock: reject bad VSOCK_NET_MODE_LOCAL configuration for G2H
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      vsock: add netns support to virtio transports
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
      selftests/vsock: use ss to wait for listeners instead of /proc/net
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion and mode changes

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   57 +-
 include/linux/virtio_vsock.h            |    8 +-
 include/net/af_vsock.h                  |   64 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   17 +
 net/vmw_vsock/af_vsock.c                |  290 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    6 +
 net/vmw_vsock/virtio_transport.c        |   29 +-
 net/vmw_vsock/virtio_transport_common.c |   69 +-
 net/vmw_vsock/vmci_transport.c          |   12 +
 net/vmw_vsock/vsock_loopback.c          |   20 +-
 tools/testing/selftests/vsock/vmtest.sh | 1087 +++++++++++++++++++++++++++++--
 13 files changed, 1560 insertions(+), 104 deletions(-)
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


