Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177C5F4417
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJDNS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJDNSx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 09:18:53 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A8C48EA5;
        Tue,  4 Oct 2022 06:18:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MhdRK718zz9v7Gt;
        Tue,  4 Oct 2022 21:12:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3ZV+JMjxj8ZGaAA--.6154S5;
        Tue, 04 Oct 2022 14:18:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RESEND][PATCH 3/6] libbpf: Introduce bpf_prog_get_fd_by_id_opts()
Date:   Tue,  4 Oct 2022 15:17:47 +0200
Message-Id: <20221004131750.2306251-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3ZV+JMjxj8ZGaAA--.6154S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43Zr4fWw17ZrWkGF45ZFb_yoW5Xw13pr
        Z3Gry2kr15Xr4Fva4DJF4Fy3s8CFy7Ww48KrZ7Jr13ZrnrXa1DXrWIvF4akrya9rWkG397
        Zr4Ykry7Kr1xZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4PQKQAAsB
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce bpf_prog_get_fd_by_id_opts(), for symmetry with
bpf_map_get_fd_by_id_opts(), to let the caller pass the newly introduced
data structure bpf_get_fd_opts. Keep the existing bpf_prog_get_fd_by_id(),
and call bpf_prog_get_fd_by_id_opts() with NULL as opts argument, to
prevent setting open_flags.

Currently, the kernel does not support non-zero open_flags for
bpf_prog_get_fd_by_id_opts(), and a call with them will result in an error
returned by the bpf() system call. The caller should always pass zero
open_flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c      | 11 ++++++++++-
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4b03063edf1d..92464c2d1da7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -935,19 +935,28 @@ int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
 	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID);
 }
 
-int bpf_prog_get_fd_by_id(__u32 id)
+int bpf_prog_get_fd_by_id_opts(__u32 id, const struct bpf_get_fd_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.prog_id = id;
+	attr.open_flags = OPTS_GET(opts, open_flags, 0);
 
 	fd = sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
 
+int bpf_prog_get_fd_by_id(__u32 id)
+{
+	return bpf_prog_get_fd_by_id_opts(id, NULL);
+}
+
 int bpf_map_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_opts *opts)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c60eda3c88ad..595d342fb7f9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -373,6 +373,8 @@ struct bpf_get_fd_opts {
 };
 #define bpf_get_fd_opts__last_field open_flags
 
+LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
+					  const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 					 const struct bpf_get_fd_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2e665b21d84f..c3604eaa220d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -372,6 +372,7 @@ LIBBPF_1.0.0 {
 LIBBPF_1.1.0 {
 	global:
 		bpf_map_get_fd_by_id_opts;
+		bpf_prog_get_fd_by_id_opts;
 		user_ring_buffer__discard;
 		user_ring_buffer__free;
 		user_ring_buffer__new;
-- 
2.25.1

