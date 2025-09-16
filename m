Return-Path: <linux-kselftest+bounces-41631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519FB7EA41
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578B77B4AD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD92D46A4;
	Tue, 16 Sep 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9AFCKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778572D3A75
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066233; cv=none; b=aFowgBCHLruV71GTToAolyNFyIauv4w2jZfloVy2SK/eR9Y5BWz3pS7UJjiSZ0RboWuu1FVBBrGyONRRyvPjlSkzPjTjp3TOwwIbIJ0qotHFB4wldPUHbf7vjmPcRVu/Lty4ngM6laxcPMgxU/pFxuD8pnvkNNHApPutxFFvYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066233; c=relaxed/simple;
	bh=tDbd/upvHR/xtlA/nTwN/G43iDlA1JrzjfApfEaGGJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aMUNs+yiYHZEKzF37emJjxVBIJyVrIAbaZF+XAQiIiTx5x9StZ8WVz27/WCa9BGSVTWaCgP8AUV4l4JG/2EWXtxPR9QdPJ9m6qvwMgqxZeL+lf968LU0hlYJrgsQJI4zxPejSZEKIPJ2fgxWU3PEJVoUfPq2WTlKQfQ+MlDHAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia9AFCKj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4367317b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066231; x=1758671031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHl5WqeMYUkPQ1EC4mALAYkWrMfI/glTDyOoveTOmK8=;
        b=ia9AFCKjbl7D/YuKv9NIOwWfq205YgLlZ8U3tdvwUpEWQ/ue1DAfScrTHDqswdgAna
         122p44VCZxYphtrAJ7mtpzzvZBiQAYj/hoEwDzCtTO5MqtwujIAeIxecv6wd5ZlNDpU0
         lOYLT0VyM7xNIyO4/CGv0PeZ2zmKCoAgGTZ0IO5hxXdKsyTmdiifUP3p6vquCoHXzB0M
         fKQv6OvL1CmR37cWpUHVcdzWrciNxznnN/HYdDk3c138rSgPmTrYJL4KEM+J/acOOpLa
         1TN9hyIzc/bR3po7lJr3obPjRMuPs44mRLpQHyURW8Irn44PUNyfd36ncahTx512bwIp
         PJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066231; x=1758671031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHl5WqeMYUkPQ1EC4mALAYkWrMfI/glTDyOoveTOmK8=;
        b=ggOLSq58Ozz5kJX+SFoC3yUqR6N6Eii8xYIUSZEC2NSW1guuy+XaWA1N8IWJV4ErGk
         H0pBfT04Wb3VDr6ljD1Q6qvfTgI8/rKvuOw8WgurIXd1IMnqtbTN5Ifnlz5buRuo4eY4
         8mzzGDA7Vswr1ZQyjBn5YsGuN6bYcRMl9zqwlKOPSLlOzjrrH+npkQVYxfeEgsR9Mh0k
         lsgxdHXzwERhuUV31T1Fh9AfOUwl3+hDHlbXUEstfgH5EWhk1w+xNsXWgCNXKZgsjIK1
         ajE5n8BZxSsSPq0js2rwVHAn136n9nryr5eOoFnxXakwmPe+xWRchaEBdzQq5UsUOsPD
         naUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovi+WAGJsfuLorb+nU4zMueAkaefAmGxbreith00JMjC/ppbkeAwOs0syL9otqwkXCjCyk1NBKpTL4yRZru8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHzaGLbxgc7gKuGCAA+dQCn0R68hTRnPV6/vImMKfRhVvwCOd
	unsz7wLBc23B3oUc+VddzUOmcefMeii2usQbX/gvkiwsnjRfXu/AKFCa
X-Gm-Gg: ASbGncvt9zVO1oZUEPNBOaU31tssZIRiZeadQ0X5jUqZGBVvjJouqvl/z8DRrr0F1tz
	6sCMdu5qiuiV5xSo+5oDyOlcm3oFl+mrBiBxccQ79ZrSm6hUCu+Elw2hzjpWUjl2V1l2evlBuEY
	WgKX4sTfy2T+qayb7d6wRMsrHzNW9iKXIxgvN2ziu0H5Z3zy+PzcSVfZBO0YM09J9RyrQN4t+fY
	5yb/sIsT1K7fUKRGphV6d2pQA8n+C4QKa+4aJZuYnySueXOEpqn9n1R6SJj4gXis6lxDRye9rwp
	uat8vIgBQYF743PvKV7EbDMP6XIsoeX0EnMEi7COqltiFmU6owTfqEdMKt05uf49pSkhOBoIAAd
	wSl0R92KiH94cIWqQK3AL
X-Google-Smtp-Source: AGHT+IGZVED2rSAsJWXkVcB5IVcGYR1SeW/vsl8TxNbaoSEzfPQ4U64w5sr+Q2Xqz4mlv9BaVkDfPw==
X-Received: by 2002:a17:902:da8c:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-26813902fc2mr821225ad.38.1758066230710;
        Tue, 16 Sep 2025 16:43:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2680971b4fbsm2750045ad.104.2025.09.16.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Date: Tue, 16 Sep 2025 16:43:44 -0700
Message-Id: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADH2yWgC/23QwWrDMAyA4VcpPtfDkiPH2anvMXaQHaU1W5KRh
 NBR+u4zYdDM3dGIT7/RTc0yJZnV6+GmJlnTnMYhP9zxoOKFh7Po1Oa3QoNkLJJe5zF+6LVfZF5
 0sIzQIhiMqDL5mqRL123dmxpk0YNcF/WeJ5c0L+P0vXVW2ObbygrM35UraNCdJfbQcmh8PJ17T
 p8vcey3RSvucV1gzNg2Bhhra0F8ie0Ooy+wzRg8cOfA2c5KiasHJlOWq4ydIDc1Ooyt2+Hj7/m
 8oSdktKFGIgEHADj1svAjSLsg2MJSDlZSU6y4oijhvyDWTygHA5M3QVqhUATdPlh+1uVgwx3Ea
 DDf2OzPc7/ffwDXULXLSwIAAA==
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
 drivers/vhost/vsock.c                   |   78 ++-
 include/linux/virtio_vsock.h            |   24 +
 include/net/af_vsock.h                  |   71 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   26 +
 net/vmw_vsock/af_vsock.c                |  219 +++++-
 net/vmw_vsock/hyperv_transport.c        |    2 +-
 net/vmw_vsock/virtio_transport.c        |    6 +-
 net/vmw_vsock/virtio_transport_common.c |   18 +-
 net/vmw_vsock/vmci_transport.c          |    6 +-
 net/vmw_vsock/vsock_loopback.c          |  102 ++-
 tools/testing/selftests/vsock/vmtest.sh | 1133 +++++++++++++++++++++++++++----
 13 files changed, 1501 insertions(+), 189 deletions(-)
---
base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


