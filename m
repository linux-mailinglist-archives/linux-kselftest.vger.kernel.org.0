Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05365F441B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJDNTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJDNTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 09:19:00 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AF47BAA;
        Tue,  4 Oct 2022 06:18:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MhdSn4P0cz9v7PG;
        Tue,  4 Oct 2022 21:14:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3ZV+JMjxj8ZGaAA--.6154S6;
        Tue, 04 Oct 2022 14:18:38 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RESEND][PATCH 4/6] libbpf: Introduce bpf_btf_get_fd_by_id_opts()
Date:   Tue,  4 Oct 2022 15:17:48 +0200
Message-Id: <20221004131750.2306251-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3ZV+JMjxj8ZGaAA--.6154S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43Zry5XFW5GryktF4rAFb_yoW5WFykp3
        93GF1Ikr1rXrWrua4DXF4Fyw13CFy7Ww4UKr97Jr13ArnrXanrX3yIvF13Cryavr4kC392
        gr4Ykry7Kr1xuFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj3-RYgAAs0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce bpf_btf_get_fd_by_id_opts(), for symmetry with
bpf_map_get_fd_by_id_opts(), to let the caller pass the newly introduced
data structure bpf_get_fd_opts. Keep the existing bpf_btf_get_fd_by_id(),
and call bpf_btf_get_fd_by_id_opts() with NULL as opts argument, to prevent
setting open_flags.

Currently, the kernel does not support non-zero open_flags for
bpf_btf_get_fd_by_id_opts(), and a call with them will result in an error
returned by the bpf() system call. The caller should always pass zero
open_flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c      | 12 +++++++++++-
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 92464c2d1da7..f43e8c8afbd3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -980,19 +980,29 @@ int bpf_map_get_fd_by_id(__u32 id)
 	return bpf_map_get_fd_by_id_opts(id, NULL);
 }
 
-int bpf_btf_get_fd_by_id(__u32 id)
+int bpf_btf_get_fd_by_id_opts(__u32 id,
+			      const struct bpf_get_fd_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.btf_id = id;
+	attr.open_flags = OPTS_GET(opts, open_flags, 0);
 
 	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
 
+int bpf_btf_get_fd_by_id(__u32 id)
+{
+	return bpf_btf_get_fd_by_id_opts(id, NULL);
+}
+
 int bpf_link_get_fd_by_id(__u32 id)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 595d342fb7f9..559af0b84299 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -379,6 +379,8 @@ LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 					 const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
+LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
+					 const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c3604eaa220d..7011d5eec67b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -371,6 +371,7 @@ LIBBPF_1.0.0 {
 
 LIBBPF_1.1.0 {
 	global:
+		bpf_btf_get_fd_by_id_opts;
 		bpf_map_get_fd_by_id_opts;
 		bpf_prog_get_fd_by_id_opts;
 		user_ring_buffer__discard;
-- 
2.25.1

