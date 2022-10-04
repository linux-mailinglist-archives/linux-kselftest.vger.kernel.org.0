Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED075F4258
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJDLuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJDLuL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 07:50:11 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B436818341;
        Tue,  4 Oct 2022 04:49:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MhbSq0Kx6z9xs6H;
        Tue,  4 Oct 2022 19:43:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXU16kHTxjYVKaAA--.62750S7;
        Tue, 04 Oct 2022 12:49:38 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 5/6] libbpf: Introduce bpf_link_get_fd_by_id_opts()
Date:   Tue,  4 Oct 2022 13:48:38 +0200
Message-Id: <20221004114839.2302206-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004114839.2302206-1-roberto.sassu@huaweicloud.com>
References: <20221004114839.2302206-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXU16kHTxjYVKaAA--.62750S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43Zry5Xw1DWF4DGryDZFb_yoW5Ww1fp3
        93Gr12kr15ZrWrua4DJF4Fvay3CFy7Ww4UKrZ7Gr13ArnIqFsrXrWIvF13Cr1avr4kG39F
        gr4Ykry3Kr1xuFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4POuwACsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce bpf_link_get_fd_by_id_opts(), for symmetry with
bpf_map_get_fd_by_id_opts(), to let the caller pass the newly introduced
data structure bpf_get_fd_opts. Keep the existing bpf_link_get_fd_by_id(),
and call bpf_link_get_fd_by_id_opts() with NULL as opts argument, to
prevent setting open_flags.

Currently, the kernel does not support non-zero open_flags for
bpf_link_get_fd_by_id_opts(), and a call with them will result in an error
returned by the bpf() system call. The caller should always pass zero
open_flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/lib/bpf/bpf.c      | 12 +++++++++++-
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f43e8c8afbd3..f3d89a2bdb50 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1003,19 +1003,29 @@ int bpf_btf_get_fd_by_id(__u32 id)
 	return bpf_btf_get_fd_by_id_opts(id, NULL);
 }
 
-int bpf_link_get_fd_by_id(__u32 id)
+int bpf_link_get_fd_by_id_opts(__u32 id,
+			       const struct bpf_get_fd_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_get_fd_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.link_id = id;
+	attr.open_flags = OPTS_GET(opts, open_flags, 0);
 
 	fd = sys_bpf_fd(BPF_LINK_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
 
+int bpf_link_get_fd_by_id(__u32 id)
+{
+	return bpf_link_get_fd_by_id_opts(id, NULL);
+}
+
 int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, info);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 559af0b84299..834809d74c82 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -382,6 +382,8 @@ LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
 					 const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
+LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
+					  const struct bpf_get_fd_opts *opts);
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7011d5eec67b..71bf5691a689 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -372,6 +372,7 @@ LIBBPF_1.0.0 {
 LIBBPF_1.1.0 {
 	global:
 		bpf_btf_get_fd_by_id_opts;
+		bpf_link_get_fd_by_id_opts;
 		bpf_map_get_fd_by_id_opts;
 		bpf_prog_get_fd_by_id_opts;
 		user_ring_buffer__discard;
-- 
2.25.1

