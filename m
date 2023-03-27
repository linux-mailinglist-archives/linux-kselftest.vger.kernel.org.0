Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029B6CAE42
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjC0TM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC0TMZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 15:12:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533651710
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 12:11:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r5so9643885qtp.4
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679944313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7QgF4SPMByI95xKzR5JGt1MbjLLP8ljYyAalP24SZ0=;
        b=fj9ssUNvI0n6VKKx7zevE6u4UkHwEvocg0Hwc+ADRIU82d6JgjBqmN8nQCar5UMtmK
         c3wYyRc/0lYfxRMiHLOGqojq7mSU+v0qyN7P5q793z4033nycPbedcUKGr4pQcb3/dr9
         2AABL2LLCF3J6o49Ugq/FZHqbBDaq24f3OQfsvWOmQIgQT9L2kfL12Bcy4hiN+O+lzAt
         dVMpMikros3nEcW9kg31ahO8Am7qSRuh3LEjDhcGT/XCCSj6+NyX3/ohlvdd0U3ylYHD
         1ESXpfdvTsQ5mczGInyzTOkj43Ug0vegCxekafyazAeF9TlncJbddRnDRwvLnPXkKkjm
         3VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7QgF4SPMByI95xKzR5JGt1MbjLLP8ljYyAalP24SZ0=;
        b=vZo8I3AbgYkrSo3uZXT1A/ZKK8Arz4NzjD9iIi8XH69u2pOVXKhBnhNKN76i78oOQG
         80YovOEXgli1O0m5Kzq1kRfBQ7yJhR+DB6G9KHiWxSaFq2XDpidOLFKQoHyk73N2PsJ0
         RxmwZJ0TEqxF047VEn+c5TK6l+F+jIzN6wVpchKJtHIfcFG1h3NrvcVywK8RF99UqyHN
         KbhVRkYhRdFcLMk0Tu2kbvlgqD0zvhT6qzq/QqNjQzwl0XAOpULcn+1klhtDhcotKoyi
         bj20pOl4Sd5AboJD6zDcIxUZQAzpslq/9hvYT/wHGLea8XxxjLQYrluuFemQYBsmLUm0
         +tww==
X-Gm-Message-State: AAQBX9cEPNi0CWJHFrN0cyYCSmRZJEqq8trJdVKJmp8H2utH7XNScF03
        c3RrCekcwgeWHi/TNvYSzgIM7w==
X-Google-Smtp-Source: AKy350bgbPKaehPavn4jrWcChc00F0kRsdrrQ9tfFTF5o7GVzpAXwL0VK3B2pUdIMuH1t8ze8fyp6w==
X-Received: by 2002:ac8:5f53:0:b0:3e4:e58c:d321 with SMTP id y19-20020ac85f53000000b003e4e58cd321mr9356681qta.33.1679944313444;
        Mon, 27 Mar 2023 12:11:53 -0700 (PDT)
Received: from [172.17.0.3] ([130.44.215.126])
        by smtp.gmail.com with ESMTPSA id d185-20020a37b4c2000000b007425ef4cbc2sm16989236qkf.100.2023.03.27.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:11:52 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next v4 0/3] Add support for sockmap to vsock.
Date:   Mon, 27 Mar 2023 19:11:50 +0000
Message-Id: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbqIWQC/1WNQQrCMBBFr1Jm7eCYBIpeRVxkpqMNYloypRRK7
 27izs2HB//xdjAtSQ1u3Q5F12RpyhXCqQMZY34ppqEyOHKevOtxtUne2OYTZ/TEdCXpSYYLVIe
 jKXKJWcZmcThz+Ffaay76TNuveoesC2bdFngcxxfYw958jwAAAA==
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We're testing usage of vsock as a way to redirect guest-local UDS
requests to the host and this patch series greatly improves the
performance of such a setup.

Compared to copying packets via userspace, this improves throughput by
121% in basic testing.

Tested as follows.

Setup: guest unix dgram sender -> guest vsock redirector -> host vsock
       server
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

Only the virtio transport has been tested. The loopback transport was
used in writing bpf/selftests, but not thoroughly tested otherwise.

This series requires the skb patch.

Changes in v4:
- af_vsock: fix parameter alignment in vsock_dgram_recvmsg()
- af_vsock: add TCP_ESTABLISHED comment in vsock_dgram_connect()
- vsock/bpf: change ret type to bool

Changes in v3:
- vsock/bpf: Refactor wait logic in vsock_bpf_recvmsg() to avoid
  backwards goto
- vsock/bpf: Check psock before acquiring slock
- vsock/bpf: Return bool instead of int of 0 or 1
- vsock/bpf: Wrap macro args __sk/__psock in parens
- vsock/bpf: Place comment trailer */ on separate line

Changes in v2:
- vsock/bpf: rename vsock_dgram_* -> vsock_*
- vsock/bpf: change sk_psock_{get,put} and {lock,release}_sock() order
  to minimize slock hold time
- vsock/bpf: use "new style" wait
- vsock/bpf: fix bug in wait log
- vsock/bpf: add check that recvmsg sk_type is one dgram, seqpacket, or
  stream.  Return error if not one of the three.
- virtio/vsock: comment __skb_recv_datagram() usage
- virtio/vsock: do not init copied in read_skb()
- vsock/bpf: add ifdef guard around struct proto in dgram_recvmsg()
- selftests/bpf: add vsock loopback config for aarch64
- selftests/bpf: add vsock loopback config for s390x
- selftests/bpf: remove vsock device from vmtest.sh qemu machine
- selftests/bpf: remove CONFIG_VIRTIO_VSOCKETS=y from config.x86_64
- vsock/bpf: move transport-related (e.g., if (!vsk->transport)) checks
  out of fast path

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
Bobby Eshleman (3):
      vsock: support sockmap
      selftests/bpf: add vsock to vmtest.sh
      selftests/bpf: add a test case for vsock sockmap

 drivers/vhost/vsock.c                              |   1 +
 include/linux/virtio_vsock.h                       |   1 +
 include/net/af_vsock.h                             |  17 ++
 net/vmw_vsock/Makefile                             |   1 +
 net/vmw_vsock/af_vsock.c                           |  64 +++++++-
 net/vmw_vsock/virtio_transport.c                   |   2 +
 net/vmw_vsock/virtio_transport_common.c            |  25 +++
 net/vmw_vsock/vsock_bpf.c                          | 174 +++++++++++++++++++++
 net/vmw_vsock/vsock_loopback.c                     |   2 +
 tools/testing/selftests/bpf/config.aarch64         |   2 +
 tools/testing/selftests/bpf/config.s390x           |   3 +
 tools/testing/selftests/bpf/config.x86_64          |   3 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
 13 files changed, 452 insertions(+), 6 deletions(-)
---
base-commit: e5b42483ccce50d5b957f474fd332afd4ef0c27b
change-id: 20230327-vsock-sockmap-30b090c70cd1

Best regards,
-- 
Bobby Eshleman <bobby.eshleman@bytedance.com>

