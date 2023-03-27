Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272A6CAE47
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC0TMn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjC0TM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 15:12:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA12705
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 12:11:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t19so9619910qta.12
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679944315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+fcBmNwaYYPHaFQTMyMlmEgRAw7iowZyfvTwdusqIc=;
        b=gADa5RHsTd0tWC9q7vi8VAcRiUWkdYHk5GgP5oAsTxquPj3jVz+x7m2wOss37oS73z
         pTh5QQCpLYgyc3SqeUeNTmt7khVJASffcx0hXYDDiJGqZfCZvnWRvw/Hf9TsmgqFMPVP
         Qdb515RMDb/MioZPwwKrAG9Z1jDsv6sJeydT6qMe7g6M7TnR1nbaDqP2d9pz8IhYkO61
         L1pii3ci8qpHfdSpRUI44PNb1iGeK+pt0v5VYPvQ7870ANQ9OlDzkApm5pcPbNF80osh
         FCxWyOqjsMp3lWEECMFl7pAXhkdyfC8bOamQTZeL3rzOPfXk4KBoJ8UYfrRvTdeXo7GV
         3/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+fcBmNwaYYPHaFQTMyMlmEgRAw7iowZyfvTwdusqIc=;
        b=XotpUoIfyslEnwbEYPgOk8NLLPDUz7/KiNL2fJ7MhMYrU4mRo70XGvG9u3KDOWA91D
         VjSrmEa66IPpiUJhd4n7lRU0WjfsKKaPv+8gsP9FP6PCxfTzGXoWJAeUu/03LGFJtryg
         tdpcxrjwjtrKcNqgVTdwwbpI13Lx26WuBAtCvRFqfuD6yTZraW0rfgZvmtR8/G+6mc5l
         ZZfC1+HfrYzaKR8MAc0XnWc0lQAXSbob9bl011wn6zqh99Hz0fReivu0kkBfLM5EYIDx
         8keda5kpxqg10gB+WGPoN0jQ95E1dhFQINr+rbeTzzvodKvINtWccNV2kc7FwIlThIjJ
         jMaw==
X-Gm-Message-State: AO0yUKULKDzeIbtBhTFdPJVCPGb4cmJPLIgDJBZZ+ZgJQUvdah5t6etp
        e7XmYDy5C4tskjfW8Lf18FXzZQ==
X-Google-Smtp-Source: AK7set+YB+1J9uVDVyg1O0Agv93wcxLr3a7Apewktxjq43LIUgBzdILMJKsuL86AQov6ipS8fdfdLw==
X-Received: by 2002:ac8:5f4a:0:b0:3e3:90bb:ad9b with SMTP id y10-20020ac85f4a000000b003e390bbad9bmr21749182qta.34.1679944315144;
        Mon, 27 Mar 2023 12:11:55 -0700 (PDT)
Received: from [172.17.0.3] ([130.44.215.126])
        by smtp.gmail.com with ESMTPSA id d185-20020a37b4c2000000b007425ef4cbc2sm16989236qkf.100.2023.03.27.12.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:11:54 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon, 27 Mar 2023 19:11:52 +0000
Subject: [PATCH net-next v4 2/3] selftests/bpf: add vsock to vmtest.sh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-vsock-sockmap-v4-2-c62b7cd92a85@bytedance.com>
References: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
In-Reply-To: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
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

Add vsock loopback to the test kernel.

This allows sockmap for vsock to be tested.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
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
2.30.2

