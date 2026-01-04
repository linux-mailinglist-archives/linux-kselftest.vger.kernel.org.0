Return-Path: <linux-kselftest+bounces-48131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77435CF1212
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58AAA300C5CA
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0FD22424C;
	Sun,  4 Jan 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqGYwy3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B1274B39
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543904; cv=none; b=TalfI59DbbDdPbkCTX9YczS6jbQqEh0hE7mFfqm6hEf+74AyOPcMhzkPE32CqCD3cJEDN5vWC1KaY/gJVDP2CvNGEUIZDCGoMZaR2hS+DQrVuAXLrXgN74IAlxeDyQr89bHaTgpFpGer/SoPpSbhOJJLkMiamxbUUB5GVFve890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543904; c=relaxed/simple;
	bh=j7cR8+ufxEC6b3PZjjtmQAAcUCXybtKLeeEyN+Kt9zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcZGIKBsy7lGUKE8Px+WOHsVdSTHNmlBX1Vnd2ZTd9mPK2Ja+OHDI2oD9LJ8GJwM1QPkSdYHi2t1lQPOA1/wO+hGuuyy5lKfQk20Kg0KNI7nPDz8PxBZUBRkB6EiufAH0WkPsAi0Cs7rbIFBPnWZjcH1WHam6E0GpS4T3dlW7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqGYwy3r; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767543899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvUp10h0Mn9exzUZ/n1dBrd2YDkqgmgwZbLLzqYBLM4=;
	b=wqGYwy3rPPwjUgcwc+Zk72fRwu9rJHd4cpXwPFYdXQyo3aLdr2BFjuogY9pVKKvMo27hRB
	MJoMlLw7LAHxkey1r+/58EPUG5f81OtXgLn0IPa8CtwgPehxf7xadVLLtvI06qmcLb0YRz
	Ett+KwBbweZPn8l+dQiGwaC6Q4/vKc4=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	shuah@kernel.org,
	aleksander.lobakin@intel.com,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access vulnerability for LIVE_FRAMES
Date: Mon,  5 Jan 2026 00:23:49 +0800
Message-ID: <20260104162350.347403-2-kafai.wan@linux.dev>
In-Reply-To: <20260104162350.347403-1-kafai.wan@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When testing XDP programs with LIVE_FRAMES mode, if the metalen is set
to >= (XDP_PACKET_HEADROOM - sizeof(struct xdp_frame)), there won't be
enough space for the xdp_frame conversion in xdp_update_frame_from_buff().
Additionally, the xdp_frame structure may be filled with user-provided data,
which can lead to a memory access vulnerability when converting to skb.

This fix reverts to the original version and ensures data_hard_start
correctly points to the xdp_frame structure, eliminating the security risk.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Fixes: 294635a8165a ("bpf, test_run: fix &xdp_frame misplacement for LIVE_FRAMES")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 net/bpf/test_run.c                            | 23 +++++++++----------
 .../bpf/prog_tests/xdp_do_redirect.c          |  6 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..00234eba7c76 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -90,11 +90,9 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
 struct xdp_page_head {
 	struct xdp_buff orig_ctx;
 	struct xdp_buff ctx;
-	union {
-		/* ::data_hard_start starts here */
-		DECLARE_FLEX_ARRAY(struct xdp_frame, frame);
-		DECLARE_FLEX_ARRAY(u8, data);
-	};
+	/* ::data_hard_start starts here */
+	struct xdp_frame frame;
+	DECLARE_FLEX_ARRAY(u8, data);
 };
 
 struct xdp_test_data {
@@ -131,10 +129,11 @@ static void xdp_test_run_init_page(netmem_ref netmem, void *arg)
 	frm_len = orig_ctx->data_end - orig_ctx->data_meta;
 	meta_len = orig_ctx->data - orig_ctx->data_meta;
 	headroom -= meta_len;
+	headroom += sizeof(head->frame);
 
 	new_ctx = &head->ctx;
-	frm = head->frame;
-	data = head->data;
+	frm = &head->frame;
+	data = frm;
 	memcpy(data + headroom, orig_ctx->data_meta, frm_len);
 
 	xdp_init_buff(new_ctx, TEST_XDP_FRAME_SIZE, &xdp->rxq);
@@ -215,8 +214,8 @@ static bool frame_was_changed(const struct xdp_page_head *head)
 	 * i.e. has the highest chances to be overwritten. If those two are
 	 * untouched, it's most likely safe to skip the context reset.
 	 */
-	return head->frame->data != head->orig_ctx.data ||
-	       head->frame->flags != head->orig_ctx.flags;
+	return head->frame.data != head->orig_ctx.data ||
+	       head->frame.flags != head->orig_ctx.flags;
 }
 
 static bool ctx_was_changed(struct xdp_page_head *head)
@@ -234,8 +233,8 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data = head->orig_ctx.data;
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
-	xdp_update_frame_from_buff(&head->ctx, head->frame);
-	head->frame->mem_type = head->orig_ctx.rxq->mem.type;
+	xdp_update_frame_from_buff(&head->ctx, &head->frame);
+	head->frame.mem_type = head->orig_ctx.rxq->mem.type;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
@@ -301,7 +300,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 		head = phys_to_virt(page_to_phys(page));
 		reset_ctx(head);
 		ctx = &head->ctx;
-		frm = head->frame;
+		frm = &head->frame;
 		xdp->frame_cnt++;
 
 		act = bpf_prog_run_xdp(prog, ctx);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index dd34b0cc4b4e..f7615c265e6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -59,12 +59,12 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int fd)
 
 /* The maximum permissible size is: PAGE_SIZE - sizeof(struct xdp_page_head) -
  * SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - XDP_PACKET_HEADROOM =
- * 3408 bytes for 64-byte cacheline and 3216 for 256-byte one.
+ * 3368 bytes for 64-byte cacheline and 3216 for 256-byte one.
  */
 #if defined(__s390x__)
-#define MAX_PKT_SIZE 3216
+#define MAX_PKT_SIZE 3176
 #else
-#define MAX_PKT_SIZE 3408
+#define MAX_PKT_SIZE 3368
 #endif
 
 #define PAGE_SIZE_4K  4096
-- 
2.43.0


