Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731AE61A705
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 03:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKECwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 22:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKECw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 22:52:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE43FB90
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 19:52:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s4so4366334qtx.6
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXNmxis4Zkl54qmET11cnpJJGJ2VNVNuEs1M8Jg/V1A=;
        b=J339RySFJwqav1kH4OJqtPfBCpgE5RHngr1ZByyAiQz4+/YWBABUyUVASMJomr0SYu
         +/F5foKscg1gwwsCfTKfij2Ydw0jz3qiioA0bCS3Yd3p567ij7S7h5eEAWB0i6OqnisH
         L7ryIg5jjZMeBqOGXon4/bnjr57Whk/rXmGM7lbqG/sr5mUcQUAlmX0gdAvzcoXjLa4Z
         01GPAoepaSNkr50uTKvqsOTte64oVvI8R31TLdS+WN2+y5fZKDowIVv+NMbmCndD0v2k
         mIzt1voNCiZGEDHKIoDSezNIbrhhg8qL/Y3pWi57CmgFApIhP99sZTHv/Oe44F/HHV8d
         HWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXNmxis4Zkl54qmET11cnpJJGJ2VNVNuEs1M8Jg/V1A=;
        b=3a5zh9T4btL1FJSba+0HwfstZehEKkKJkK0qU0WffqhaDaa2Y3r7J+zUWPK4piJtvT
         SGJMdapoV3eNpVcpQdSMKc5QxXfT/XMu40DauJY4p4jFwNAtCZr+FsoUo5J8TEPoDJm+
         OVzF9qqvXGMqdRbCxPX841v4ziqDnlYyX0O+h2c3uAkgOZ2m9XHwA5jHzxjveDvWHZmX
         hE8DcdSa8K+VicABuONdZTkSrL3z13J5DmisyOTitBVXbQdr2XUq7VC+QWMIaOGS7nWd
         wGQmZcmG7zKP5IS8lbbEV229hXvGBSQlpcOaLAu7ft4aiuotMRMP3u7NUIN3KfuqJefr
         tZaw==
X-Gm-Message-State: ACrzQf2bz5+i+AvFj1UbTU3CSkOcCpE0K7R0ko9ir8e+XqssMPGo0H3O
        BVyWdDMJ90m97eiWQiVInpnzKQ==
X-Google-Smtp-Source: AMsMyM4wFH0r7RRkGxN8+7U2AC2L41oJU/b03tdfA4/iUaRURAWce5cVa22rHQINfXrKhjSxw/2ISg==
X-Received: by 2002:a05:622a:5c8d:b0:3a5:1fcb:8326 with SMTP id ge13-20020a05622a5c8d00b003a51fcb8326mr26739483qtb.498.1667616747053;
        Fri, 04 Nov 2022 19:52:27 -0700 (PDT)
Received: from 192-168-53-12.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm805905qkb.6.2022.11.04.19.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 19:52:26 -0700 (PDT)
From:   "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Hao Xiang <hao.xiang@bytedance.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf@vger.kernel.org
Cc:     Ho-Ren Chuang <horenc@vt.edu>,
        Ho-Ren Chuang <horenchuang@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 1/4] bpf: Support reporting BPF htab map's used size for monitoring
Date:   Sat,  5 Nov 2022 02:51:43 +0000
Message-Id: <20221105025146.238209-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221105025146.238209-1-horenchuang@bytedance.com>
References: <20221105025146.238209-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expose BPF htab map's used size by counting accessed or allocated/freed
elements to userspace.

Leverage the htab->count value for both preallocated and
dynamically allocated maps. Expose the value to a new field
"used_entries" in a userspace struct bpf_map_info  to allow monitoring.
Support hash table type (BPF_MAP_TYPE_HASH).

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 include/linux/bpf.h      |  1 +
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/hashtab.c     | 19 +++++++++++++++++++
 kernel/bpf/syscall.c     |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..82ee14139b69 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -97,6 +97,7 @@ struct bpf_map_ops {
 	int (*map_pop_elem)(struct bpf_map *map, void *value);
 	int (*map_peek_elem)(struct bpf_map *map, void *value);
 	void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u32 cpu);
+	u32 (*map_get_used_elem)(struct bpf_map *map);
 
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17f61338f8f8..63659368cf0e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6215,6 +6215,7 @@ struct bpf_map_info {
 	__u32 id;
 	__u32 key_size;
 	__u32 value_size;
+	__u32 used_entries;
 	__u32 max_entries;
 	__u32 map_flags;
 	char  name[BPF_OBJ_NAME_LEN];
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index ed3f8a53603b..bc9c00b92e57 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -913,6 +913,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
+		dec_elem_count(htab);
 	} else {
 		dec_elem_count(htab);
 		htab_elem_free(htab, l);
@@ -994,6 +995,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			inc_elem_count(htab);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -2186,6 +2188,22 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 	return num_elems;
 }
 
+u32 htab_map_get_used_elem(struct bpf_map *map)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	/* The elem count may temporarily go beyond the max after
+	 * inc_elem_count() but before dec_elem_count().
+	 */
+	if (htab->use_percpu_counter)
+		return min_t(u32, htab->map.max_entries,
+				percpu_counter_sum(&htab->pcount) +
+							atomic_read(&htab->count));
+	else
+		return min_t(u32, htab->map.max_entries,
+							atomic_read(&htab->count));
+}
+
 BTF_ID_LIST_SINGLE(htab_map_btf_ids, struct, bpf_htab)
 const struct bpf_map_ops htab_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -2202,6 +2220,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_get_used_elem = htab_map_get_used_elem,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..ea4828bb22ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4203,6 +4203,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info.map_flags = map->map_flags;
 	info.map_extra = map->map_extra;
 	memcpy(info.name, map->name, sizeof(map->name));
+	if (map->ops->map_get_used_elem)
+		info.used_entries = map->ops->map_get_used_elem(map);
 
 	if (map->btf) {
 		info.btf_id = btf_obj_id(map->btf);
-- 
Ho-Ren (Jack) Chuang

