Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F868234B
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 05:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjAaEgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 23:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjAaEgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 23:36:14 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856539CF6
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 20:35:47 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v17so2440737qto.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 20:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YmT560oTftw19JZaSdqN79G8win6E1yvXJ4AismDYA=;
        b=fp+7E2dha4r9VCUXBWObySLYq0twxXrxh48Mf9108NaZCq1sgZ8EYxK6VLWxtguqha
         RZPLT9YxdCKjMH/GgjC/F9BPJnPI6dGV3zK6pPrRvu50o9zV/YlXb7T5ZF+GO5E2e5N3
         9KF0VXSdqC3UIfAZGW2K0hmZKfv55IR3jRlsK71WkguiVBTO0RhzVqst5vezPM93+S5y
         j2HV/noeJj3G5rPnUrmxzXLCa877lUepPQj0KLQ2nwj6ra1a5Qa1VA5K/MkkD/BEifl8
         PepRamh3hVU2kCeQ6vt730JFer0Sk8JuIJexTT7CG8uNGqYzSJ1OsEkiwVvyHW90kMcx
         dDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YmT560oTftw19JZaSdqN79G8win6E1yvXJ4AismDYA=;
        b=F0TaEoki0q2YL4Gs2JjwaxOqf8Lz08G9BPHO1/ccx9dv1V+Mc1+r3PQePltNmpuYqR
         BAUsfTvwAvMKF0XfbivVp+GLFn6Lw8khUWGxYJXJlRJlqd4XTO/57nE76hA8ocpomUMK
         23LA/FanVFEaloSbyUQ+hBmKddPCuEdBCfD3TUVuL041kwgZ/F7SnpzMF65ufmKUU+v8
         ZzUqpD3aYpMdKSXrktWsJ1LndfZoA09euZBSh4peCd4q67I1/qlD/Q/NQNGNKrJHAvQ6
         nQ+fAfezM//dPkxQ0yAJog2qTkd/adN0A6APDBl8B5P8D77SH4d+3Sxj+RuhUHAlcFIw
         1aaw==
X-Gm-Message-State: AO0yUKVs0fHnwNQD/exFgjpf6+tJeJhkzZ8LWv0K+IrR8HHWuYlLutRp
        WjM+OX48HBx2fqB2iI4/LbdWcw==
X-Google-Smtp-Source: AK7set+jOiGnB8wQtiTzhJPJ4pzCzwkUKNNkB6ogZiIUW7dzSxfuY4VlR3/gF3ab0rqhbOtSNk2zog==
X-Received: by 2002:a05:622a:1016:b0:3b8:248b:a035 with SMTP id d22-20020a05622a101600b003b8248ba035mr27029137qte.19.1675139746210;
        Mon, 30 Jan 2023 20:35:46 -0800 (PST)
Received: from C02G8BMUMD6R.bytedance.net ([148.59.24.152])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm9260682qtg.33.2023.01.30.20.35.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 20:35:45 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 2/3] selftests/bpf: add vsock to vmtest.sh
Date:   Mon, 30 Jan 2023 20:35:13 -0800
Message-Id: <20230118-support-vsock-sockmap-connectible-v2-2-58ffafde0965@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add vsock loopback to the test kernel.

This allows sockmap for vsock to be tested.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 tools/testing/selftests/bpf/config.aarch64 | 2 ++
 tools/testing/selftests/bpf/config.s390x   | 3 +++
 tools/testing/selftests/bpf/config.x86_64  | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 1f0437644186..253821494884 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -176,6 +176,8 @@ CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index d49f6170e7bd..2ba92167be35 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -140,5 +140,8 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index dd97d61d325c..b650b2e617b8 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -234,7 +234,10 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_X86_CPUID=y
 CONFIG_X86_MSR=y

-- 
2.35.1

