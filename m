Return-Path: <linux-kselftest+bounces-40121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABBB38FD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D6B1B28927
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45B151991;
	Thu, 28 Aug 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxRLwQRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE517996;
	Thu, 28 Aug 2025 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341093; cv=none; b=YvB/UQbel3Sy6WMSbzD7CmVa5q5CqqKPx3cdJMM6P3SQwYtj2zhM37zgphppfyKxklbzTkCYZWBsEGCYXsqUz16gE4WChCjKFI6IFz7nVf8RprxYFAHTx6ZJloROgiqJpIVutsWs9zVuvH0CJxgNfJEFMSWc3HhWMQiQZGtUG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341093; c=relaxed/simple;
	bh=WLcp8w+zaBXmA/HAY9pMoek7MmD7nKXW93a4Y8P399A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QrtrwCF6Ua9fZf3VTPKIJSzTmmWzR0tkzFn2/DPHEfcEryQpqq/gzEmvxnyMlTDyKkOVbIRcwey9GJcWCR4Fux7QP76ZJLBJyrjG0T3V+U8LFRLdwl0WevxHpAOg5EdC9AaZH9CwUoqg2eaGJTsjgNGTENpddkFji/F61nEl/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxRLwQRe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771e987b4e6so353173b3a.2;
        Wed, 27 Aug 2025 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341091; x=1756945891; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9HctsThcJxuYSi/BLGQnP1aOyG8A/8iQK9Wsazcq+c=;
        b=VxRLwQRePhvAIgqfxHDtPK+Pxls3IKAIGh1rkIqjosp27XckXE5GjWBIuhqzawI/m2
         Qr8+yITgN56Vn3zC3H4ADlo7BZjbMhAGzQLVU4X6gQZQN5Kxxyh1Qz1rGa5I83WRDLxa
         eww/g3d1k85qY7mrgNs91rQpwAsOhQUpZVCJ+TOf49B8yEBmv/5+ZD56BSQnTl7FEoaf
         Bnr0B4JSEdBDIMGJbMIMlF+U6DV6fBXaqnHixH/ptEqkgsXrUqFQsn5b1omGnt4kOcd6
         YbMfmBSXpwMRlD6fD4gs6ws9uTckvZiHDxVXfSb9nKMrlN8kBZAl6V5kKISaRkgKbUSm
         h3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341091; x=1756945891;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9HctsThcJxuYSi/BLGQnP1aOyG8A/8iQK9Wsazcq+c=;
        b=bH9xOJu98IsOTsMviG+YS/TQfngbL5df+oeCAVVhGBGEQsg8GRO62o2BHywNq+68qO
         iqc1SI+yaP6j3YdYBFtbWIjg5F9XdoG01YoEHjTv7x6iq4/Z3EqNoXoXSF/HYPy9uajt
         3hQd1ZnXtB7KWQNyNjPldSiTqn4K9FTLw9vvtM+NJxe0jpYqEgam3T9E74q+5F8gAJPx
         oSNL3+LQeb0AKVxJC7Qz1XT/XXihkM3EE7hnK1IjHkSbPaO9UBATVf09MdtgCk5sotto
         csGPvcQmBq2i+BoL/jB/zG9l3Qd1Nil5dNFIecLvaU5FNNxreGPj0Ld//KrVhgCJf695
         2dPw==
X-Forwarded-Encrypted: i=1; AJvYcCVDk7dRAcaEZiK+CEVcDypgkCCmmIoYIPFW1Hxo5BfcMor6k5kLgWbZPIeGHrdu4lzLrOkhjKGiXXIiQxnCsNxI@vger.kernel.org, AJvYcCVMOxLFwLVasXMAj+zz0+OKkyfubwlN8S5fROHDuN67O36ahXS9bJ6EiiGYkkCVy/kSaBWqqz4eIFsrQfK8@vger.kernel.org, AJvYcCVPNe2zQHuQm9cs1cTsoiKcUUGhtJrzqgV8FyqB9bk8pspFbGrVabFIKxSCBxk09jSgyrmJnh/R@vger.kernel.org, AJvYcCXw0es2iBAex5hHfBESFI0gtc34kfZPor48OyUbIdE/jwNsjX204x8gyEzHJEChJkVomMpGRzTconN34mER@vger.kernel.org, AJvYcCXwY6Sgz3nEhkLnzcYOKf2tCYQAtKwfPmBVtLAWI1vPxqaudg/K7O85XVgw8YIIY+heeFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMen2Z6efwB6miDss9w4kDzW0vGzCsXZDE6RyWKSD7Ln0JgViT
	ya7mYBUkXuh8MBrSAVFpi0oDFrjmPoR+y9fyIo/s1Hs74fFYJ2oYLdfw
X-Gm-Gg: ASbGncsQFLiXX8gEuIo/LqwAXZ/fFO3e33DoioMs5Xn5Y3+riZaXtFV1ZitNn5tVNXv
	LMXSlWJpwPD8FRj5QB+mSU8JAh4L3b1Hk6Y2cT2TFgNMBYdd/ekyE08Q+yILtXO1qBP5EShBwIA
	80vmIa9N0WVv0CIVZuUhVYGPugJeDetL28dCHXJ8TmQKEwQGb8zu7kcqT0hUjUI4eyHtO4Mr+ve
	t7TbpYDgEORYycMA0GVXEt+Ah0hyexBJzfNaTnUejeChwro/Pu7QMiDy1vTWxkvzdEuuMw+DcGp
	U8AYe1R5XU0Btan85XhO+SW60ApLVQmKuEhmXWjtet29MNv0uSugcWxlDcFgjoYRhZW2+/LHPI5
	joDCvHAGjw0IJY6Ue8fBHoxfTD/P+jQ==
X-Google-Smtp-Source: AGHT+IEuHK0KgR/sXohe6p4eF0GWxTovRCPiFteOV7ib1rSXIIfYKHGd7bgV4BCeVh0RQYmXt9voLA==
X-Received: by 2002:a05:6a20:6a25:b0:243:a96a:2c83 with SMTP id adf61e73a8af0-243a96a30d3mr2437153637.53.1756341091441;
        Wed, 27 Aug 2025 17:31:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5a0bf9sm3243919a91.13.2025.08.27.17.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v5 0/9] vsock: add namespace support to
 vhost-vsock
Date: Wed, 27 Aug 2025 17:31:28 -0700
Message-Id: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGCjr2gC/2XQTWrDMBAF4KsEraOiGf1Y7ir3KF3I8jgRre1iC
 ZESfPcKU4iqLofhe2+YB4u0BYrs9fRgG+UQw7qUQZ9PzN/cciUexjIzFKiFRM1zXP0Hz3OimPg
 gHcKIINAjK+Rroyncj7g3tlDiC90Tey+bW4hp3b6PngzH/ohUIP5GZuDAJ6mdhdENvfWX6+zC5
 4tf5yMoY427BmPBshfgsJMSyLZYVhhtg2XBYMFNBoycJLVYPbEWbbMq2BC6vkODfjQVPv++zwr
 9DwkudE9egxsA4DJTcs9CXRWCbKwuhYo67ZVT2tPQXmtq3Babgns3gfcCy79Ejfd9/wHftRy1F
 wIAAA==
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision only supports two modes: local or global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using /proc/sys/net/vsock/ns_mode.

Modes are per-netns and write-once. This allows a system to configure
namespaces independently (some may share CIDs, others are completely
isolated). This also supports future possible  mixed use cases, where
there may be namespaces in global mode spinning up VMs while there are
mixed mode namespaces that provide services to the VMs, but are not
allowed to allocate from the global CID pool.

Additionally, added tests for the new semantics:

tools/testing/selftests/vsock/vmtest.sh
1..22
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 host_vsock_ns_mode_ok
ok 5 host_vsock_ns_mode_write_once_ok
ok 6 global_same_cid_fails
ok 7 local_same_cid_ok
ok 8 global_local_same_cid_ok
ok 9 local_global_same_cid_ok
ok 10 diff_ns_global_host_connect_to_global_vm_ok
ok 11 diff_ns_global_host_connect_to_local_vm_fails
ok 12 diff_ns_global_vm_connect_to_global_host_ok
ok 13 diff_ns_global_vm_connect_to_local_host_fails
ok 14 diff_ns_local_host_connect_to_local_vm_fails
ok 15 diff_ns_local_vm_connect_to_local_host_fails
ok 16 diff_ns_global_to_local_loopback_local_fails
ok 17 diff_ns_local_to_global_loopback_fails
ok 18 diff_ns_local_to_local_loopback_fails
ok 19 diff_ns_global_to_global_loopback_ok
ok 20 same_ns_local_loopback_ok
ok 21 same_ns_local_host_connect_to_local_vm_ok
ok 22 same_ns_local_vm_connect_to_local_host_ok
SUMMARY: PASS=22 SKIP=0 FAIL=0
Log: /tmp/vsock_vmtest_OQC4.log

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
Bobby Eshleman (9):
      vsock: a per-net vsock NS mode state
      vsock: add net to vsock skb cb
      vsock: add netns to vsock core
      vsock/loopback: add netns support
      vsock/virtio: add netns to virtio transport common
      vhost/vsock: add netns support
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: invoke vsock_test through helpers
      selftests/vsock: add namespace tests

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   30 +-
 include/linux/virtio_vsock.h            |   12 +
 include/net/af_vsock.h                  |   89 ++-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   25 +
 net/vmw_vsock/af_vsock.c                |  312 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    2 +-
 net/vmw_vsock/virtio_transport.c        |    5 +-
 net/vmw_vsock/virtio_transport_common.c |   14 +-
 net/vmw_vsock/vmci_transport.c          |    4 +-
 net/vmw_vsock/vsock_loopback.c          |   76 ++-
 tools/testing/selftests/vsock/vmtest.sh | 1092 ++++++++++++++++++++++++++-----
 13 files changed, 1475 insertions(+), 191 deletions(-)
---
base-commit: 242041164339594ca019481d54b4f68a7aaff64e
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


