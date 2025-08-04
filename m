Return-Path: <linux-kselftest+bounces-38229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B224B19A2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 04:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B1C3AF35D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 02:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF887202F71;
	Mon,  4 Aug 2025 02:27:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1881D5CED;
	Mon,  4 Aug 2025 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274431; cv=none; b=F4iLSyPtX72ovEtd5JyHrJ6bb33Eqre1dmcOzdUcOjAPFSPtZWkmAYk2qRcA2N9UrFWF9q0nP/zgCiab4w47fcE2MkWvnqbEtoUvE3L7hXORkcGgjFkfKL5OIhYYieVEQ797eZXnJl3I6bp+r5ZRKJVYfA6JtA5FAmp1OkfXIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274431; c=relaxed/simple;
	bh=zbLc9HNo6kfz862yttepKCrbMBfcWHmcVBEZgDvKJQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCyq+37gMZx5wXe0W145xy11uhz8Q8rkkr/kTDH1KHB7A3y+rEvwJ4OEeQU4zzNjZejoVdMQLXoOyqOZ2s8U0gRA73rdOLvEucsgH20sqIJZBmlDDHLXZ5q7hclWbQvtkczO2ZpSd3k8Tfk5hTTr5SAXFG5OHIXcrT/+xFLjhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bwL6h6GY1zYQtLW;
	Mon,  4 Aug 2025 10:27:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 86A631A0E9A;
	Mon,  4 Aug 2025 10:27:07 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgAX4BBsGpBoTUL9CQ--.242S4;
	Mon, 04 Aug 2025 10:27:07 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yhs@fb.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer process
Date: Mon,  4 Aug 2025 10:20:58 +0800
Message-ID: <20250804022101.2171981-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX4BBsGpBoTUL9CQ--.242S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UGry3Ww4UAr1rXw18Krg_yoWrKFykpF
	4Y93W5Ar9rZr17ZrySgFZavFyrGws7Zr4IkFyxJa48Zw1DKF15WFyI9FyYyr4rGr9rKr1S
	krZ8Jas7Kr1UWwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxkIecxEwVCI4VW8JwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUhjjgDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

In overwrite mode, the producer does not wait for the consumer, so the
consumer is responsible for handling conflicts. An optimistic method
is used to resolve the conflicts: the consumer first reads consumer_pos,
producer_pos and overwrite_pos, then calculates a read window and copies
data in the window from the ring buffer. After copying, it checks the
positions to decide if the data in the copy window have been overwritten
by be the producer. If so, it discards the copy and tries again. Once
success, the consumer processes the events in the copy.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/ringbuf.c | 103 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 9702b70da444..9c072af675ff 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -27,10 +27,13 @@ struct ring {
 	ring_buffer_sample_fn sample_cb;
 	void *ctx;
 	void *data;
+	void *read_buffer;
 	unsigned long *consumer_pos;
 	unsigned long *producer_pos;
+	unsigned long *overwrite_pos;
 	unsigned long mask;
 	int map_fd;
+	bool overwrite_mode;
 };
 
 struct ring_buffer {
@@ -69,6 +72,9 @@ static void ringbuf_free_ring(struct ring_buffer *rb, struct ring *r)
 		r->producer_pos = NULL;
 	}
 
+	if (r->read_buffer)
+		free(r->read_buffer);
+
 	free(r);
 }
 
@@ -119,6 +125,14 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->sample_cb = sample_cb;
 	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
+	r->overwrite_mode = info.map_flags & BPF_F_OVERWRITE;
+	if (unlikely(r->overwrite_mode)) {
+		r->read_buffer = malloc(info.max_entries);
+		if (!r->read_buffer) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	}
 
 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
@@ -148,6 +162,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		goto err_out;
 	}
 	r->producer_pos = tmp;
+	r->overwrite_pos = r->producer_pos + 1; /* overwrite_pos is next to producer_pos */
 	r->data = tmp + rb->page_size;
 
 	e = &rb->events[rb->ring_cnt];
@@ -232,7 +247,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r, size_t n)
+static int64_t ringbuf_process_normal_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -278,6 +293,92 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	return cnt;
 }
 
+static int64_t ringbuf_process_overwrite_ring(struct ring *r, size_t n)
+{
+
+	int err;
+	uint32_t *len_ptr, len;
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	int64_t cnt = 0;
+	size_t size, offset;
+	unsigned long cons_pos, prod_pos, over_pos, tmp_pos;
+	bool got_new_data;
+	void *sample;
+	bool copied;
+
+	size = r->mask + 1;
+
+	cons_pos = smp_load_acquire(r->consumer_pos);
+	do {
+		got_new_data = false;
+
+		/* grab a copy of data */
+		prod_pos = smp_load_acquire(r->producer_pos);
+		do {
+			over_pos = READ_ONCE(*r->overwrite_pos);
+			/* prod_pos may be outdated now */
+			if (over_pos < prod_pos) {
+				tmp_pos = max(cons_pos, over_pos);
+				/* smp_load_acquire(r->producer_pos) before
+				 * READ_ONCE(*r->overwrite_pos) ensures that
+				 * over_pos + r->mask < prod_pos never occurs,
+				 * so size is never larger than r->mask
+				 */
+				size = prod_pos - tmp_pos;
+				if (!size)
+					goto done;
+				memcpy(r->read_buffer,
+				       r->data + (tmp_pos & r->mask), size);
+				copied = true;
+			} else {
+				copied = false;
+			}
+			prod_pos = smp_load_acquire(r->producer_pos);
+		/* retry if data is overwritten by producer */
+		} while (!copied || prod_pos - tmp_pos > r->mask);
+
+		cons_pos = tmp_pos;
+
+		for (offset = 0; offset < size; offset += roundup_len(len)) {
+			len_ptr = r->read_buffer + (offset & r->mask);
+			len = *len_ptr;
+
+			if (len & BPF_RINGBUF_BUSY_BIT)
+				goto done;
+
+			got_new_data = true;
+			cons_pos += roundup_len(len);
+
+			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
+				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+				err = r->sample_cb(r->ctx, sample, len);
+				if (err < 0) {
+					/* update consumer pos and bail out */
+					smp_store_release(r->consumer_pos,
+							  cons_pos);
+					return err;
+				}
+				cnt++;
+			}
+
+			if (cnt >= n)
+				goto done;
+		}
+	} while (got_new_data);
+
+done:
+	smp_store_release(r->consumer_pos, cons_pos);
+	return cnt;
+}
+
+static int64_t ringbuf_process_ring(struct ring *r, size_t n)
+{
+	if (likely(!r->overwrite_mode))
+		return ringbuf_process_normal_ring(r, n);
+	else
+		return ringbuf_process_overwrite_ring(r, n);
+}
+
 /* Consume available ring buffer(s) data without event polling, up to n
  * records.
  *
-- 
2.43.0


