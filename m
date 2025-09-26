Return-Path: <linux-kselftest+bounces-42469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB93BA3FE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480447B9ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6972FBDF2;
	Fri, 26 Sep 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffc1lvPT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21F2F8BF8
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894790; cv=none; b=LbZeOOaRUY/MlLgZ5O/uqDa0gWOZ6PM9kU9fgFCD5D2z0LH893/ND97fuQc4dTUPXKc6jk3J5rVVvO+L9Wf43QJvV1rYehFrR8J9s2ZQ7aXaBLPpSEHgRSyXl4Wu7hgMJKDiA5jn+6YrLIzEjIiW4nFEsvWd0BNwiID6MP632dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894790; c=relaxed/simple;
	bh=v9/YoAeo4j+XSzP7jJkloGUF9XXb6rhzguQFkxVhgBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyJt08kV32XvNYD0+SiftveMPuxFVPuORwu4zm995O9U/6bN62/CgpvIc04HVk/zbfz1YoRH6xdssgo3CRW1BsTG58ZIIGHNugaNti0s13wnkFgJ/olM4nRYw6cutZoba9lGXPhbo2pePW9rjr+VLIqGqBMB9nLuXfMG/Lmduss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ffc1lvPT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758894786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCLhKRo57nwP7lOT098V870p1QhItLboAprKUmrpy6E=;
	b=Ffc1lvPTzOw7wh6BD9RXKwwuFvx2CtYV6By/+P5ly/oWQa1Xa2lNP78Mcq6D/H7oPefmqk
	staqruW4ZUUlxkO0o6SbBETA7pg4bXCZ3CmN1ZAxLdesLPxBwgGUf2lrfO52yZ5KpZ9LZA
	gsTtb2ijH1OJQ8zKFlUoYnu4S9KqMAk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-OsyXwAwMM2m9Ka8wgK9nmw-1; Fri, 26 Sep 2025 09:53:05 -0400
X-MC-Unique: OsyXwAwMM2m9Ka8wgK9nmw-1
X-Mimecast-MFC-AGG-ID: OsyXwAwMM2m9Ka8wgK9nmw_1758894784
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so1006300f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 06:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894784; x=1759499584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCLhKRo57nwP7lOT098V870p1QhItLboAprKUmrpy6E=;
        b=Y3BWFsbzqj8iIM5GobmYakHgbWffvPb+Ks/Xvp1BwyrecRHzwR6y+3qeApjZoYr1Bz
         Z5GNtbeus+8FcB02Z94Emt09akc2V6HI7jz5zoP+Q4TBmhov+1Xr65PuQruJutu87DFH
         Dp369JCQCbTYtdW9bsz/ktRsX9MXPLAJObyjjskdjQA7glpckoVNH7zSHlesyVDCoD0S
         7j6EEwG54OwmWr/aB+wFB6lc58OQakBaJZ6tDE/YBwjo7loF7gHUCN+0exGKVt6IY0Su
         RyRWIf9dFOOVgA2ehIE7Sn7SSba6Qj43iRRvzPCs7ffhUgGiEzHa4/4NPDuXp/RaYvj0
         MeHg==
X-Forwarded-Encrypted: i=1; AJvYcCX3UFBWibzxFz7dCUT1wHYo5aHGiEwLXMSHvG5Nai709oiL1QjOGAdQRRaQc4LL1JBivr3SV3dR3+iZPrm5NBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u+Y+JF/e7VeNhTc3cvCGGknFHYpsGK6kCF+qG+5VSwxi9u4m
	Z4GqDVqCyCoFthDG7J6qBb488SvyvgeKcOk6dmEbc3Sp3gVDlXz0Q3AUK5OjBI5YJyAgZO5ptnr
	ByFAdwPiOeuKWGWYZWpscWjoJE8E5xpkvVGYEYTMPvci4z+nbFSK7kCbxpzwtUS5CTgIdrw==
X-Gm-Gg: ASbGnct+567X302EhTRPQmyI0CF2ikDhJiZaKeGjM1oM+7/fNBQwJrqb6cCu7XltS0T
	gGpWctq/xB9QfjQc4v06pIMFbXZEwgqDGvMV5aIJGta3UhdI/sIz3AkmXySRSKbIKq75jUDFlV3
	LivFNAtJ0gVHRUEU/x2LD2X2nvGrShX+hvmU61ZLh9onL3FzSfUq8cK/Smi0MW8GXX1GaNAvwwR
	ofJoqydnVxkrDLzezmaUdyaC267+0Kleq1zaHHbsqoLGzeLC1Ey0i7yonx8Brr0SHElJM9xo3um
	MaJcfwCcJ4W7zkn6+81v46yi6Ufxk2LvSMHyWh+v
X-Received: by 2002:a05:6000:26c1:b0:3e4:b44d:c586 with SMTP id ffacd0b85a97d-40e4adceb7cmr6693687f8f.34.1758894783809;
        Fri, 26 Sep 2025 06:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0wfQWykC77fe0tKnWjipZaiXo2+AfUKGhVzx7dZmaVWWD2JCCx4wkHBEAM4eWx7GEC2r7Ag==
X-Received: by 2002:a05:6000:26c1:b0:3e4:b44d:c586 with SMTP id ffacd0b85a97d-40e4adceb7cmr6693638f8f.34.1758894783185;
        Fri, 26 Sep 2025 06:53:03 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm7003586f8f.58.2025.09.26.06.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:53:02 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:52:43 +0200
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
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Message-ID: <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>

Hi Bobby,

On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
>This series adds namespace support to vhost-vsock and loopback. It does
>not add namespaces to any of the other guest transports (virtio-vsock,
>hyperv, or vmci).

Thanks for this new series and the patience!
I've been a bit messed up after KVM Forum between personal stuff and 
other things. I'm starting to review and test today, so between this 
afternoon and Monday I hope to send you all my comments.

Thanks,
Stefano

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
>1..22
>ok 1 vm_server_host_client
>ok 2 vm_client_host_server
>ok 3 vm_loopback
>ok 4 host_vsock_ns_mode_ok
>ok 5 host_vsock_ns_mode_write_once_ok
>ok 6 global_same_cid_fails
>ok 7 local_same_cid_ok
>ok 8 global_local_same_cid_ok
>ok 9 local_global_same_cid_ok
>ok 10 diff_ns_global_host_connect_to_global_vm_ok
>ok 11 diff_ns_global_host_connect_to_local_vm_fails
>ok 12 diff_ns_global_vm_connect_to_global_host_ok
>ok 13 diff_ns_global_vm_connect_to_local_host_fails
>ok 14 diff_ns_local_host_connect_to_local_vm_fails
>ok 15 diff_ns_local_vm_connect_to_local_host_fails
>ok 16 diff_ns_global_to_local_loopback_local_fails
>ok 17 diff_ns_local_to_global_loopback_fails
>ok 18 diff_ns_local_to_local_loopback_fails
>ok 19 diff_ns_global_to_global_loopback_ok
>ok 20 same_ns_local_loopback_ok
>ok 21 same_ns_local_host_connect_to_local_vm_ok
>ok 22 same_ns_local_vm_connect_to_local_host_ok
>SUMMARY: PASS=22 SKIP=0 FAIL=0
>Log: /tmp/vsock_vmtest_OQC4.log
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
>Bobby Eshleman (9):
>      vsock: a per-net vsock NS mode state
>      vsock: add net to vsock skb cb
>      vsock: add netns to vsock core
>      vsock/loopback: add netns support
>      vsock/virtio: add netns to virtio transport common
>      vhost/vsock: add netns support
>      selftests/vsock: improve logging in vmtest.sh
>      selftests/vsock: invoke vsock_test through helpers
>      selftests/vsock: add namespace tests
>
> MAINTAINERS                             |    1 +
> drivers/vhost/vsock.c                   |   78 ++-
> include/linux/virtio_vsock.h            |   24 +
> include/net/af_vsock.h                  |   71 +-
> include/net/net_namespace.h             |    4 +
> include/net/netns/vsock.h               |   26 +
> net/vmw_vsock/af_vsock.c                |  219 +++++-
> net/vmw_vsock/hyperv_transport.c        |    2 +-
> net/vmw_vsock/virtio_transport.c        |    6 +-
> net/vmw_vsock/virtio_transport_common.c |   18 +-
> net/vmw_vsock/vmci_transport.c          |    6 +-
> net/vmw_vsock/vsock_loopback.c          |  102 ++-
> tools/testing/selftests/vsock/vmtest.sh | 1133 +++++++++++++++++++++++++++----
> 13 files changed, 1501 insertions(+), 189 deletions(-)
>---
>base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


