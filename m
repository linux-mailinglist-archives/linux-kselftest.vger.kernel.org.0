Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7027C995F
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJOORO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOORN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 10:17:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF815C1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1086101b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379431; x=1697984231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+b0dEMOY183z9dPBZcXWdZ+T7lbIwplG3M4Qto5H1o=;
        b=oOKWrKzvXwy6Iss50tPht/+1c1HJyTCKCwA46I9tiPP/IHCgdCNzKNIcGQ0J6Gv3M+
         VHM2g+vzcIOHQrwnU8mEKqiJsjbflHEdg2GpV1SwawE+py0vyHW0/oFH+02d4tKUGAu1
         6Q+y6T7ZRoJj+E5/pxcm7XtkwaavFP54+G5/l5ZxbmraAuPggemAJtmYWlfFyKkcNDVC
         XA/piv1AsZaMtRWAZuG7ytz49tnZLSw1zvZZ0OUqa8d6kBcpELJ+wpuO47U+QAGqw5+Q
         53T+VH0nTLUy0nP9Ac8/nlxctORyojWWh+uL661MD3da5xDNKlPHV+z+5WZBepDGf54s
         88DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379431; x=1697984231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+b0dEMOY183z9dPBZcXWdZ+T7lbIwplG3M4Qto5H1o=;
        b=OD59wmVVEjwq1AX7gsB1ztX0wgSP0uxNJ8P/iq5t/kuWWdd/e5qjqEhTU66Q9NBtUF
         77pltaS6CGo2RARrO744YPMuBn2CoIqdk12GtPlGIjomTYY0YmyvLXa3EcLNuOV5tN1e
         zIAiaHP/kLvv7JXVVJqGTF4Um8/Ot/RltiXJhZnieJyp+qOKrK8Eh+e0v8OnFgeojLQs
         HIpUFUwtd8AsfKDtUokp+j2s8Z4olSUdeEdw3qCg1OQXci0G+pXoj0I7yD5GFy6xKQaO
         5sFIbLXiB0XOiEVsAqMoH0gSbbGVpqHEb4zxUjAuXtLS8TZSj9XuXzOsF4spdIsKp9m/
         pl6A==
X-Gm-Message-State: AOJu0YxaEvaQwFbBnaXVesB5AAJ2DSMzw2HruKdOoivG+msSvz4rtrtT
        WHQweHxlPquoZn9iZhXrYW4EJQ==
X-Google-Smtp-Source: AGHT+IF8ctbxzi/yLoYKR8nfTMdLlPrANNX0a4fFaaxK61sDbvY5BiX2bAhQb9DCFQvUS99Sir6h0g==
X-Received: by 2002:a05:6a21:6d92:b0:13a:dd47:c31a with SMTP id wl18-20020a056a216d9200b0013add47c31amr6752797pzb.20.1697379431188;
        Sun, 15 Oct 2023 07:17:11 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id x6-20020aa78f06000000b006b3dc56c944sm3993752pfr.133.2023.10.15.07.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:10 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 0/7] tun: Introduce virtio-net hashing feature
Date:   Sun, 15 Oct 2023 23:16:28 +0900
Message-ID: <20231015141644.260646-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Extend the steering program feature by introducing a dedicated program
type: BPF_PROG_TYPE_VNET_HASH. This program type is capable to report
the hash value and the queue to use at the same time.

This is a rewrite of a RFC patch series submitted by Yuri Benditovich that
incorporates feedbacks for the series and V1 of this series:
https://lore.kernel.org/lkml/20210112194143.1494-1-yuri.benditovich@daynix.com/

QEMU patched to use this new feature is available at:
https://github.com/daynix/qemu/tree/akihikodaki/bpf

The QEMU patches will soon be submitted to the upstream as RFC too.

V1 -> V2:
  Changed to introduce a new BPF program type.

Akihiko Odaki (7):
  bpf: Introduce BPF_PROG_TYPE_VNET_HASH
  bpf: Add vnet_hash members to __sk_buff
  skbuff: Introduce SKB_EXT_TUN_VNET_HASH
  virtio_net: Add virtio_net_hdr_v1_hash_from_skb()
  tun: Support BPF_PROG_TYPE_VNET_HASH
  selftests/bpf: Test BPF_PROG_TYPE_VNET_HASH
  vhost_net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/bpf/bpf_prog_run.rst            |   1 +
 Documentation/bpf/libbpf/program_types.rst    |   2 +
 drivers/net/tun.c                             | 158 +++++--
 drivers/vhost/net.c                           |  16 +-
 include/linux/bpf_types.h                     |   2 +
 include/linux/filter.h                        |   7 +
 include/linux/skbuff.h                        |  10 +
 include/linux/virtio_net.h                    |  22 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/verifier.c                         |   6 +
 net/core/filter.c                             |  86 +++-
 net/core/skbuff.c                             |   3 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |   2 +
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.aarch64    |   1 -
 .../selftests/bpf/prog_tests/vnet_hash.c      | 385 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/vnet_hash.c |  16 +
 18 files changed, 681 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vnet_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/vnet_hash.c

-- 
2.42.0

