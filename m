Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4797C9963
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjJOORX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 10:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjJOORW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 10:17:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD819D6
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2b1af964dso1674428b6e.1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379439; x=1697984239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJDsjXY27F9/4dBjdxEGWiwFVrUuGxBuoNe9PuwHdgE=;
        b=LVT7RCZPtopGXV//N4v4QN95y36OxVqgNowFvlze0sLrLO6AY+UvV9ebmW/jbHqqz5
         syaPrA/jTPvstEgSyV7MUrKLU5cc8gvdKqrpSs+FZqg0+F08lBoecmRKgjy3SGj6z4Df
         c1gK+WN1vot1KINHaRYaIIPfCDJG5xfoNI6KC/8BSWZJ9cekPIS0RRk4lJGIQO1hSweq
         fIT8uUk5BJgOpRIqBOX+2UaVvj4kc1NDz/SC6ScCnWsT/dLO2ENyI/uuVypmQTOL5XNz
         wIuPFy27DGo+1w5a45UyzNi3LtvB1x6w005GeF5ZEtqC02b7axpYyCnZ8DElySmOMhZy
         ggYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379439; x=1697984239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJDsjXY27F9/4dBjdxEGWiwFVrUuGxBuoNe9PuwHdgE=;
        b=p0Pcy9pmbNgAcbYI7IUarKrs4O3gYXKAiuiYbaPI5CQr2kAa3daP83c3BD8NnKn5oQ
         df+z2UCAyadeiMR2k3T4GDWr13t5O6tPuQtjgmNMqA9FU1LnWxrc7gKGiV23fGygg8kq
         BtNHVFSrLL6kLnd2Phe6DKix3WPJpVqT4b2jX1nk7Afg8ntkPOtW6tL3Ny1MrymU8O1z
         pTSxinXkK8LdzIk0nB5CS+9kkw5hZzhrLzJQ9EM75NWClolxy/PI/Z2kmTX6yxZqmtN8
         JiK1PX6RlMgt7t/wOMN6CQqZzDcQ2ADxsqdetFrfR2/WahEAmjp+3YnR35c6kz8EjZIH
         I1bw==
X-Gm-Message-State: AOJu0YzkTy/QaXG8VPHAolJ/+TDjTxrIlktqlHF1wnNs/cVUC8Wwa7Pj
        pyBl0WHPH9rTAhd83nRAx+GP4A==
X-Google-Smtp-Source: AGHT+IGpU5uszWRjUzIjT7iHtowuf/PL2ks/58t0JISif6Khaqfb5QST4TqfG3bPtfy8oiUe2eIlIQ==
X-Received: by 2002:a05:6808:210b:b0:3a7:2456:6af6 with SMTP id r11-20020a056808210b00b003a724566af6mr39723966oiw.31.1697379439071;
        Sun, 15 Oct 2023 07:17:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id c14-20020a63724e000000b005897bfc2ed3sm6234231pgn.93.2023.10.15.07.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
Date:   Sun, 15 Oct 2023 23:16:29 +0900
Message-ID: <20231015141644.260646-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new program type will be used by tun to determine the queues to
deliver packets and the hash values and types reported with virtio-net
headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/bpf/bpf_prog_run.rst         |  1 +
 Documentation/bpf/libbpf/program_types.rst |  2 ++
 include/linux/bpf_types.h                  |  2 ++
 include/uapi/linux/bpf.h                   |  5 +++++
 kernel/bpf/verifier.c                      |  6 ++++++
 net/core/filter.c                          | 11 +++++++++++
 tools/include/uapi/linux/bpf.h             |  1 +
 tools/lib/bpf/libbpf.c                     |  2 ++
 8 files changed, 30 insertions(+)

diff --git a/Documentation/bpf/bpf_prog_run.rst b/Documentation/bpf/bpf_prog_run.rst
index 4868c909df5c..0d108d867c03 100644
--- a/Documentation/bpf/bpf_prog_run.rst
+++ b/Documentation/bpf/bpf_prog_run.rst
@@ -39,6 +39,7 @@ following types:
 - ``BPF_PROG_TYPE_STRUCT_OPS``
 - ``BPF_PROG_TYPE_RAW_TRACEPOINT``
 - ``BPF_PROG_TYPE_SYSCALL``
+- ``BPF_PROG_TYPE_VNET_HASH``
 
 When using the ``BPF_PROG_RUN`` command, userspace supplies an input context
 object and (for program types operating on network packets) a buffer containing
diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..6be53201f91b 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -171,6 +171,8 @@ described in more detail in the footnotes.
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_TRACE_RAW_TP``                   | ``tp_btf+`` [#fentry]_           |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_VNET_HASH``               |                                        | ``vnet_hash``                    |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_XDP``                     | ``BPF_XDP_CPUMAP``                     | ``xdp.frags/cpumap``             |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``xdp/cpumap``                   |           |
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..dec83d495e82 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -34,6 +34,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SK_MSG, sk_msg,
 	      struct sk_msg_md, struct sk_msg)
 BPF_PROG_TYPE(BPF_PROG_TYPE_FLOW_DISSECTOR, flow_dissector,
 	      struct __sk_buff, struct bpf_flow_dissector)
+BPF_PROG_TYPE(BPF_PROG_TYPE_VNET_HASH, vnet_hash,
+	      struct __sk_buff, struct sk_buff)
 #endif
 #ifdef CONFIG_BPF_EVENTS
 BPF_PROG_TYPE(BPF_PROG_TYPE_KPROBE, kprobe,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0448700890f7..298634556fab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -988,6 +988,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_VNET_HASH,
 };
 
 enum bpf_attach_type {
@@ -6111,6 +6112,10 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
+
+	__u32 vnet_hash_value;
+	__u16 vnet_hash_report;
+	__u16 vnet_rss_queue;
 };
 
 struct bpf_tunnel_key {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..fd6d842635d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14373,6 +14373,7 @@ static bool may_access_skb(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_VNET_HASH:
 		return true;
 	default:
 		return false;
@@ -16973,6 +16974,11 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
+		if (prog_type == BPF_PROG_TYPE_VNET_HASH) {
+			verbose(env, "vnet hash progs cannot use bpf_spin_lock yet\n");
+			return -EINVAL;
+		}
+
 		if (is_tracing_prog_type(prog_type)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..867edbc628de 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10967,6 +10967,17 @@ const struct bpf_prog_ops flow_dissector_prog_ops = {
 	.test_run		= bpf_prog_test_run_flow_dissector,
 };
 
+const struct bpf_verifier_ops vnet_hash_verifier_ops = {
+	.get_func_proto		= sk_filter_func_proto,
+	.is_valid_access	= sk_filter_is_valid_access,
+	.convert_ctx_access	= bpf_convert_ctx_access,
+	.gen_ld_abs		= bpf_gen_ld_abs,
+};
+
+const struct bpf_prog_ops vnet_hash_prog_ops = {
+	.test_run		= bpf_prog_test_run_skb,
+};
+
 int sk_detach_filter(struct sock *sk)
 {
 	int ret = -ENOENT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0448700890f7..60976fe86247 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -988,6 +988,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_VNET_HASH,
 };
 
 enum bpf_attach_type {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..e74d136eae07 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -209,6 +209,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_VNET_HASH]		= "vnet_hash",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -8858,6 +8859,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("vnet_hash",		VNET_HASH, 0, SEC_NONE),
 };
 
 int libbpf_register_prog_handler(const char *sec,
-- 
2.42.0

