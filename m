Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE1168233F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjAaEf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 23:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaEfz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 23:35:55 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A639B9A
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 20:35:28 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so4254455qtr.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 20:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzFUUu2PxeLWAubEu7oUk+cl1ljeVkwcyofI8r7Scvs=;
        b=znZSnDoOe3nDYLRFlNFYnyeYC5gsDn4pxJLz+Tymq1HcbWAhX2QvQwO0kIwjdBiQif
         qGdDh2whiQPMAgM3htG+azRVdenVxkVm4OlqDqtU7TvwgzggQl69uTYddZQrrSib285g
         6HBoqIHnqCViCM0BdWaxpGydbecIzlCurs4O/Fc7NsmMSLhjSQ5kncUDGvTU5D3JuHD5
         odTMcaGJIYLOYMy8065biGmuOsMf+4uNqwfyrpAckCeKpim+IGbbhZt2CjGXmXMtFWcu
         2lcueqieTEdCKiFUI1+dQ4tZx4u+9VH/pv3S/tTxV6BVuZihPCIBNcRpCsS85mdnao3/
         KE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzFUUu2PxeLWAubEu7oUk+cl1ljeVkwcyofI8r7Scvs=;
        b=B5+1MfN0mYcinpIQTI3RnGMEniX6DyNW1yXVAqXds9m8boFMtsNaf/cM5OoTioMM58
         GunM3eWxAKTntxS+4By1CfDIDiK+WpirRbTgRpkPlhUjOzcFLSHzVHT+cw/zXSQo4d4v
         bQDB5cD7cGOojP232IAP+hYUET8XgcIE2gouKQLuBa1nN/R2/MxZA/O9zbUcVNhzn1bS
         A2wkp5doBTCvBGpaBa5KKDGyAlb6ZmiGvh6juHCZN12MnN4qE6QWLVehjNoEqdXKEvmI
         Ouiv6v0WFMUAfG+/nKQQrNpEBrkJXIYrNlojklBfd0YRVySNHD6dKoOTE6M4/kU7BXtE
         HEcw==
X-Gm-Message-State: AO0yUKV6JDtF57HREBhHFMRKPyB/FVEQYy9nUDChnrVo8hXwgY0Dvmor
        albNP483ixMMaFURWSqu4bCjsQ==
X-Google-Smtp-Source: AK7set//tmyB7YpaKmyC8Ytp0xzz12EorKGUAzk4HnQqqKsuWyeMRIUsyBqK0V+4C/qFrvF+Raq2bw==
X-Received: by 2002:ac8:574f:0:b0:3b8:3629:7cb7 with SMTP id 15-20020ac8574f000000b003b836297cb7mr20071628qtx.64.1675139728000;
        Mon, 30 Jan 2023 20:35:28 -0800 (PST)
Received: from C02G8BMUMD6R.bytedance.net ([148.59.24.152])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm9260682qtg.33.2023.01.30.20.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 20:35:27 -0800 (PST)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jakub@cloudflare.com, hdanton@sina.com, cong.wang@bytedance.com
Subject: [PATCH RFC net-next v2 0/3] vsock: add support for sockmap
Date:   Mon, 30 Jan 2023 20:35:11 -0800
Message-Id: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for sockmap to vsock.

We're testing usage of vsock as a way to redirect guest-local UDS requests to
the host and this patch series greatly improves the performance of such a
setup.

Compared to copying packets via userspace, this improves throughput by 121% in
basic testing.

Tested as follows.

Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
Threads: 1
Payload: 64k
No sockmap:
- 76.3 MB/s
- The guest vsock redirector was
  "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
Using sockmap (this patch):
- 168.8 MB/s (+121%)
- The guest redirector was a simple sockmap echo server,
  redirecting unix ingress to vsock 2:1234 egress.
- Same sender and server programs

*Note: these numbers are from RFC v1

Only the virtio transport has been tested. The loopback transport was used in
writing bpf/selftests, but not thoroughly tested otherwise.

This series requires the skb patch.

Changes in v2:
- vsock/bpf: rename vsock_dgram_* -> vsock_*
- vsock/bpf: change sk_psock_{get,put} and {lock,release}_sock() order to
	     minimize slock hold time
- vsock/bpf: use "new style" wait
- vsock/bpf: fix bug in wait log
- vsock/bpf: add check that recvmsg sk_type is one dgram, seqpacket, or stream.
	     Return error if not one of the three.
- virtio/vsock: comment __skb_recv_datagram() usage
- virtio/vsock: do not init copied in read_skb()
- vsock/bpf: add ifdef guard around struct proto in dgram_recvmsg()
- selftests/bpf: add vsock loopback config for aarch64
- selftests/bpf: add vsock loopback config for s390x
- selftests/bpf: remove vsock device from vmtest.sh qemu machine
- selftests/bpf: remove CONFIG_VIRTIO_VSOCKETS=y from config.x86_64
- vsock/bpf: move transport-related (e.g., if (!vsk->transport)) checks out of
	     fast path

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
Bobby Eshleman (3):
      vsock: support sockmap
      selftests/bpf: add vsock to vmtest.sh
      selftests/bpf: Add a test case for vsock sockmap

 drivers/vhost/vsock.c                              |   1 +
 include/linux/virtio_vsock.h                       |   1 +
 include/net/af_vsock.h                             |  17 ++
 net/vmw_vsock/Makefile                             |   1 +
 net/vmw_vsock/af_vsock.c                           |  55 ++++++-
 net/vmw_vsock/virtio_transport.c                   |   2 +
 net/vmw_vsock/virtio_transport_common.c            |  24 +++
 net/vmw_vsock/vsock_bpf.c                          | 175 +++++++++++++++++++++
 net/vmw_vsock/vsock_loopback.c                     |   2 +
 tools/testing/selftests/bpf/config.aarch64         |   2 +
 tools/testing/selftests/bpf/config.s390x           |   3 +
 tools/testing/selftests/bpf/config.x86_64          |   3 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
 13 files changed, 443 insertions(+), 6 deletions(-)
---
base-commit: d83115ce337a632f996e44c9f9e18cadfcf5a094
change-id: 20230118-support-vsock-sockmap-connectible-2e1297d2111a

Best regards,
-- 
Bobby Eshleman <bobby.eshleman@bytedance.com>

