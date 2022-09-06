Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D65AF565
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIFUFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiIFUFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:05:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71F82BD296;
        Tue,  6 Sep 2022 13:01:11 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id A4272204A0FA;
        Tue,  6 Sep 2022 12:59:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4272204A0FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494358;
        bh=nWaEkFlsTxoT2qCkLeEAAJWZstzNd2OmaAn1xDktTx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXuGmpIIuRaK5ubeN/epmC7TP0PdLKlpXY6ps9ZJc116zqiws8ot0O0RNd5tCNba3
         nTYBgwtzJqVdSySys+DMBGlf7Ye4e0bvbxvoIvh34iROJgnSn0hI8Xs6QI1KFL697Q
         I/d/d2hdG5YcMHwma37GhE4IYAs24Y5qdcdCgrAY=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Geliang Tang <geliang.tang@suse.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 4/5] libbpf: Add implementation to consume overwritable BPF ring buffer.
Date:   Tue,  6 Sep 2022 21:56:45 +0200
Message-Id: <20220906195656.33021-5-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906195656.33021-1-flaniel@linux.microsoft.com>
References: <20220906195656.33021-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the BPF ring buffer is overwritable, ringbuf_process_overwritable_ring() will
be called to handle the data consumption.
All the available data will be consumed but some checks will be performed:
* check we do not read data we already read, if there is no new data, nothing
happens.
* check we do not read more than the buffer size.
* check we do not read invalid data by checking they fit the buffer size.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/include/uapi/linux/bpf.h |   3 +
 tools/lib/bpf/ringbuf.c        | 106 +++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59a217ca2dfd..cd73a89e8ead 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1227,6 +1227,9 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Create an over writable BPF_RINGBUF */
+	BFP_F_RB_OVERWRITABLE	= (1U << 13),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 8bc117bcc7bc..2362a6280fc5 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -23,6 +23,8 @@
 
 struct ring {
 	ring_buffer_sample_fn sample_cb;
+	__u8 overwritable: 1,
+	     __reserved:   7;
 	void *ctx;
 	void *data;
 	unsigned long *consumer_pos;
@@ -51,6 +53,11 @@ static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
 	}
 }
 
+static inline bool is_overwritable(struct ring *r)
+{
+	return !!r->overwritable;
+}
+
 /* Add extra RINGBUF maps to this ring buffer manager */
 int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		     ring_buffer_sample_fn sample_cb, void *ctx)
@@ -95,6 +102,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->sample_cb = sample_cb;
 	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
+	r->overwritable = !!(info.map_flags & BFP_F_RB_OVERWRITABLE);
 
 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
@@ -202,6 +210,101 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
+
+static int64_t ringbuf_process_overwritable_ring(struct ring *r)
+{
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	int64_t cnt = 0;
+	unsigned long read_pos, prod_pos, previous_prod_pos;
+
+	prod_pos = smp_load_acquire(r->producer_pos);
+	previous_prod_pos = smp_load_acquire(r->consumer_pos);
+
+	/*
+	 * For overwritable ring buffer, we use consumer_pos as the previous
+	 * producer_pos.
+	 * So, if between two calls to this function, the prod_pos did not move,
+	 * it means there is no new data, so we can return right now rather than
+	 * dealing with data we already proceeded.
+	 * NOTE the kernel space does not care about consumer_pos to reserve()
+	 * in overwritable ring buffers, hence we can hijack this field.
+	 */
+	if (previous_prod_pos == prod_pos)
+		return 0;
+
+	/*
+	 * BPF ring buffer is over writable, we start reading from
+	 * producer position.
+	 */
+	read_pos = prod_pos;
+	while (read_pos - prod_pos < r->mask) {
+		int *len_ptr, len;
+
+		len_ptr = r->data + (read_pos & r->mask);
+		len = smp_load_acquire(len_ptr);
+
+		/* sample not committed yet, bail out for now */
+		if (len & BPF_RINGBUF_BUSY_BIT)
+			break;
+
+		/*
+		 * If len is 0, it means we read all the data
+		 * available in the buffer and jump on 0 data:
+		 *
+		 * prod_pos                         read_pos
+		 *     |                                |
+		 *     V                                V
+		 * +---+------+----------+-------+------+
+		 * |   |D....D|C........C|B.....B|A....A|
+		 * +---+------+----------+-------+------+
+		 */
+		if (!len)
+			break;
+
+		/*
+		 * If adding the event len to the current
+		 * consumer position makes us wrap the buffer,
+		 * it means we already did "one loop" around the
+		 * buffer.
+		 * So, the pointed data would not be usable:
+		 *
+		 *                               prod_pos
+		 *                   read_pos----+   |
+		 *                               |   |
+		 *                               V   V
+		 * +---+------+----------+-------+---+--+
+		 * |..E|D....D|C........C|B.....B|A..|E.|
+		 * +---+------+----------+-------+---+--+
+		 */
+		if (read_pos - prod_pos + len > r->mask)
+			break;
+
+		read_pos += roundup_len(len);
+
+		if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
+			void *sample;
+			int err;
+
+			sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+			err = r->sample_cb(r->ctx, sample, len);
+			if (err < 0) {
+				/* update consumer pos and bail out */
+				smp_store_release(r->consumer_pos,
+						  prod_pos);
+				return err;
+			}
+			cnt++;
+		}
+
+		/* This prevents reading data we already processed. */
+		if (previous_prod_pos && read_pos >= previous_prod_pos)
+			break;
+	}
+
+	smp_store_release(r->consumer_pos, prod_pos);
+	return cnt;
+}
+
 static int64_t ringbuf_process_ring(struct ring* r)
 {
 	int *len_ptr, len, err;
@@ -211,6 +314,9 @@ static int64_t ringbuf_process_ring(struct ring* r)
 	bool got_new_data;
 	void *sample;
 
+	if (is_overwritable(r))
+		return ringbuf_process_overwritable_ring(r);
+
 	cons_pos = smp_load_acquire(r->consumer_pos);
 	do {
 		got_new_data = false;
-- 
2.25.1

