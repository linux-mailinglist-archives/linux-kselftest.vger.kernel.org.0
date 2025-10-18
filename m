Return-Path: <linux-kselftest+bounces-43476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C3BEC6E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EBA6E37EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 04:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042812868BA;
	Sat, 18 Oct 2025 04:04:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12060191F84;
	Sat, 18 Oct 2025 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760760286; cv=none; b=hOZfLJPAxcdYH/CTKnpszmmJY6fafZpx6EgOgrkqTe+hqzKNQYkmkGoTTvpE2lB8BYWuIzkAVxEOAdV52E1VJiUNb0djyFoo8BUsUeopadeCSL2TlNC7SCoMgYprzrih7zeKK7vRcKAN9JgxtcR/hV5vFBN0nEdSdxBttoVHxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760760286; c=relaxed/simple;
	bh=CASKKxocOPmLTgVU6t9PMhMoTEnDMtR+9RUSQmyxZA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ3/zsmawzzP4T0RiUUDV9xihtejRqufEQO3d5kY+lR/ywBIeWrlhLoB0mZKxqWzb8zE2TXX/8NaiocxNBcghGy9y972jJvMwxhXDt/3AL14Cac3VBuXRfK7aH2CrboGV7FuIftDVKbr3uve1LYofDWjD7x+Jh7WCU3zuJpHdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cpSjc6w0GzYQtjF;
	Sat, 18 Oct 2025 12:03:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0AF191A0FE9;
	Sat, 18 Oct 2025 12:04:36 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP2 (Coremail) with SMTP id Syh0CgA32UHPEfNoOeb+Ag--.21556S3;
	Sat, 18 Oct 2025 12:04:35 +0800 (CST)
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
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 1/3] bpf: Add overwrite mode for BPF ring buffer
Date: Sat, 18 Oct 2025 11:57:36 +0800
Message-ID: <20251018035738.4039621-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA32UHPEfNoOeb+Ag--.21556S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJrWUGF13tr48XF13AFW3trb_yoW8Cw1kGo
	WxZa1xuF48Cr1DZrWUG3Z7GF15CryDGF9rJr43uw13CFyDJFZFqry3tFs5W3Z8Xrn8GF1D
	Cw1DJr1Utrs8Jr1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOs7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jI0PfUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When the BPF ring buffer is full, a new event cannot be recorded until one
or more old events are consumed to make enough space for it. In cases such
as fault diagnostics, where recent events are more useful than older ones,
this mechanism may lead to critical events being lost.

So add overwrite mode for BPF ring buffer to address it. In this mode, the
new event overwrites the oldest event when the buffer is full.

The basic idea is as follows:

1. producer_pos tracks the next position to record new event. When there
   is enough free space, producer_pos is simply advanced by producer to
   make space for the new event.

2. To avoid waiting for consumer when the buffer is full, a new variable,
   overwrite_pos, is introduced for producer. It points to the oldest event
   committed in the buffer. It is advanced by producer to discard one or more
   oldest events to make space for the new event when the buffer is full.

3. pending_pos tracks the oldest event to be committed. pending_pos is never
   passed by producer_pos, so multiple producers never write to the same
   position at the same time.

The following example diagrams show how it works in a 4096-byte ring buffer.

1. At first, {producer,overwrite,pending,consumer}_pos are all set to 0.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |                                                                       |
   |                                                                       |
   |                                                                       |
   +-----------------------------------------------------------------------+
   ^
   |
   |
producer_pos = 0
overwrite_pos = 0
pending_pos = 0
consumer_pos = 0

2. Now reserve a 512-byte event A.

   There is enough free space, so A is allocated at offset 0. And producer_pos
   is advanced to 512, the end of A. Since A is not submitted, the BUSY bit is
   set.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |        |                                                              |
   |   A    |                                                              |
   | [BUSY] |                                                              |
   +-----------------------------------------------------------------------+
   ^        ^
   |        |
   |        |
   |    producer_pos = 512
   |
overwrite_pos = 0
pending_pos = 0
consumer_pos = 0

3. Reserve event B, size 1024.

   B is allocated at offset 512 with BUSY bit set, and producer_pos is advanced
   to the end of B.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |        |                 |                                            |
   |   A    |        B        |                                            |
   | [BUSY] |      [BUSY]     |                                            |
   +-----------------------------------------------------------------------+
   ^                          ^
   |                          |
   |                          |
   |                   producer_pos = 1536
   |
overwrite_pos = 0
pending_pos = 0
consumer_pos = 0

4. Reserve event C, size 2048.

   C is allocated at offset 1536, and producer_pos is advanced to 3584.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |        |                 |                                   |        |
   |    A   |        B        |                 C                 |        |
   | [BUSY] |      [BUSY]     |               [BUSY]              |        |
   +-----------------------------------------------------------------------+
   ^                                                              ^
   |                                                              |
   |                                                              |
   |                                                    producer_pos = 3584
   |
overwrite_pos = 0
pending_pos = 0
consumer_pos = 0

5. Submit event A.

   The BUSY bit of A is cleared. B becomes the oldest event to be committed, so
   pending_pos is advanced to 512, the start of B.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |        |                 |                                   |        |
   |    A   |        B        |                 C                 |        |
   |        |      [BUSY]     |               [BUSY]              |        |
   +-----------------------------------------------------------------------+
   ^        ^                                                     ^
   |        |                                                     |
   |        |                                                     |
   |   pending_pos = 512                                  producer_pos = 3584
   |
overwrite_pos = 0
consumer_pos = 0

6. Submit event B.

   The BUSY bit of B is cleared, and pending_pos is advanced to the start of C,
   which is now the oldest event to be committed.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |        |                 |                                   |        |
   |    A   |        B        |                 C                 |        |
   |        |                 |               [BUSY]              |        |
   +-----------------------------------------------------------------------+
   ^                          ^                                   ^
   |                          |                                   |
   |                          |                                   |
   |                     pending_pos = 1536               producer_pos = 3584
   |
overwrite_pos = 0
consumer_pos = 0

7. Reserve event D, size 1536 (3 * 512).

   There are 2048 bytes not being written between producer_pos (currently 3584)
   and pending_pos, so D is allocated at offset 3584, and producer_pos is advanced
   by 1536 (from 3584 to 5120).

   Since event D will overwrite all bytes of event A and the first 512 bytes of
   event B, overwrite_pos is advanced to the start of event C, the oldest event
   that is not overwritten.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |                 |        |                                   |        |
   |      D End      |        |                 C                 | D Begin|
   |      [BUSY]     |        |               [BUSY]              | [BUSY] |
   +-----------------------------------------------------------------------+
   ^                 ^        ^
   |                 |        |
   |                 |   pending_pos = 1536
   |                 |   overwrite_pos = 1536
   |                 |
   |             producer_pos=5120
   |
consumer_pos = 0

8. Reserve event E, size 1024.

   Although there are 512 bytes not being written between producer_pos and
   pending_pos, E cannot be reserved, as it would overwrite the first 512
   bytes of event C, which is still being written.

9. Submit event C and D.

   pending_pos is advanced to the end of D.

   0       512      1024    1536     2048     2560     3072     3584       4096
   +-----------------------------------------------------------------------+
   |                 |        |                                   |        |
   |      D End      |        |                 C                 | D Begin|
   |                 |        |                                   |        |
   +-----------------------------------------------------------------------+
   ^                 ^        ^
   |                 |        |
   |                 |   overwrite_pos = 1536
   |                 |
   |             producer_pos=5120
   |             pending_pos=5120
   |
consumer_pos = 0

The performance data for overwrite mode will be provided in a follow-up
patch that adds overwrite-mode benchmarks.

A sample of performance data for non-overwrite mode, collected on an x86_64
CPU and an arm64 CPU, before and after this patch, is shown below. As we can
see, no obvious performance regression occurs.

- x86_64 (AMD EPYC 9654)

Before:

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.623 ± 0.027M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  15.812 ± 0.014M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  7.871 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  6.703 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  2.896 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 2.054 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 1.864 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 1.580 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 1.484 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 1.369 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 32 1.316 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 36 1.272 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 40 1.239 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 44 1.226 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 48 1.213 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 52 1.193 ± 0.001M/s (drops 0.000 ± 0.000M/s)

After:

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.845 ± 0.036M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  15.889 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  8.155 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  6.708 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  2.918 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 2.065 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 1.870 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 1.582 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 1.482 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 1.372 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 32 1.323 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 36 1.264 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 40 1.236 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 44 1.209 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 48 1.189 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 52 1.165 ± 0.002M/s (drops 0.000 ± 0.000M/s)

- arm64 (HiSilicon Kunpeng 920)

Before:

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.310 ± 0.623M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  9.947 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  6.634 ± 0.011M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  4.502 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  3.888 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 3.372 ± 0.005M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 3.189 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 2.998 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 3.086 ± 0.018M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 2.845 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 32 2.815 ± 0.008M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 36 2.771 ± 0.009M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 40 2.814 ± 0.011M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 44 2.752 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 48 2.695 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 52 2.710 ± 0.006M/s (drops 0.000 ± 0.000M/s)

After:

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  11.283 ± 0.550M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  9.993 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  6.898 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  5.257 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  3.830 ± 0.005M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 3.528 ± 0.013M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 3.265 ± 0.018M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 2.990 ± 0.007M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 2.929 ± 0.014M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 2.898 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 32 2.818 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 36 2.789 ± 0.012M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 40 2.770 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 44 2.651 ± 0.007M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 48 2.669 ± 0.005M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 52 2.695 ± 0.009M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       |   4 ++
 kernel/bpf/ringbuf.c           | 109 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |   4 ++
 3 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f5..9fbbbc3dc490 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1430,6 +1430,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* Enable BPF ringbuf overwrite mode */
+	BPF_F_RB_OVERWRITE	= (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6231,6 +6234,7 @@ enum {
 	BPF_RB_RING_SIZE = 1,
 	BPF_RB_CONS_POS = 2,
 	BPF_RB_PROD_POS = 3,
+	BPF_RB_OVERWRITE_POS = 4,
 };
 
 /* BPF ring buffer constants */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..821929da778e 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -13,7 +13,7 @@
 #include <linux/btf_ids.h>
 #include <asm/rqspinlock.h>
 
-#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
+#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE | BPF_F_RB_OVERWRITE)
 
 /* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) */
 #define RINGBUF_PGOFF \
@@ -30,6 +30,7 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
+	bool overwrite_mode;
 	rqspinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
@@ -72,6 +73,8 @@ struct bpf_ringbuf {
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	/* points to the record right after the last overwritten one */
+	unsigned long overwrite_pos;
 	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
@@ -166,7 +169,7 @@ static void bpf_ringbuf_notify(struct irq_work *work)
  * considering that the maximum value of data_sz is (4GB - 1), there
  * will be no overflow, so just note the size limit in the comments.
  */
-static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
+static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node, bool overwrite_mode)
 {
 	struct bpf_ringbuf *rb;
 
@@ -183,17 +186,25 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
 	rb->pending_pos = 0;
+	rb->overwrite_mode = overwrite_mode;
 
 	return rb;
 }
 
 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 {
+	bool overwrite_mode = false;
 	struct bpf_ringbuf_map *rb_map;
 
 	if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
 
+	if (attr->map_flags & BPF_F_RB_OVERWRITE) {
+		if (attr->map_type == BPF_MAP_TYPE_USER_RINGBUF)
+			return ERR_PTR(-EINVAL);
+		overwrite_mode = true;
+	}
+
 	if (attr->key_size || attr->value_size ||
 	    !is_power_of_2(attr->max_entries) ||
 	    !PAGE_ALIGNED(attr->max_entries))
@@ -205,7 +216,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&rb_map->map, attr);
 
-	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
+	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node, overwrite_mode);
 	if (!rb_map->rb) {
 		bpf_map_area_free(rb_map);
 		return ERR_PTR(-ENOMEM);
@@ -293,13 +304,25 @@ static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma
 	return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGBUF_PGOFF);
 }
 
+/* Return an estimate of the available data in the ring buffer.
+ * Note: the returned value can exceed the actual ring buffer size because the
+ * function is not synchronized with the producer. The producer acquires the
+ * ring buffer's spinlock, but this function does not.
+ */
 static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
-	unsigned long cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos, over_pos;
 
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	prod_pos = smp_load_acquire(&rb->producer_pos);
-	return prod_pos - cons_pos;
+
+	if (unlikely(rb->overwrite_mode)) {
+		over_pos = smp_load_acquire(&rb->overwrite_pos);
+		prod_pos = smp_load_acquire(&rb->producer_pos);
+		return prod_pos - max(cons_pos, over_pos);
+	} else {
+		prod_pos = smp_load_acquire(&rb->producer_pos);
+		return prod_pos - cons_pos;
+	}
 }
 
 static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
@@ -402,11 +425,41 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 	return (void*)((addr & PAGE_MASK) - off);
 }
 
+static bool bpf_ringbuf_has_space(const struct bpf_ringbuf *rb,
+				  unsigned long new_prod_pos,
+				  unsigned long cons_pos,
+				  unsigned long pend_pos)
+{
+	/* no space if oldest not yet committed record until the newest
+	 * record span more than (ringbuf_size - 1).
+	 */
+	if (new_prod_pos - pend_pos > rb->mask)
+		return false;
+
+	/* ok, we have space in overwrite mode */
+	if (unlikely(rb->overwrite_mode))
+		return true;
+
+	/* no space if producer position advances more than (ringbuf_size - 1)
+	 * ahead of consumer position when not in overwrite mode.
+	 */
+	if (new_prod_pos - cons_pos > rb->mask)
+		return false;
+
+	return true;
+}
+
+static u32 bpf_ringbuf_round_up_hdr_len(u32 hdr_len)
+{
+	hdr_len &= ~BPF_RINGBUF_DISCARD_BIT;
+	return round_up(hdr_len + BPF_RINGBUF_HDR_SZ, 8);
+}
+
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, over_pos, flags;
 	struct bpf_ringbuf_hdr *hdr;
-	u32 len, pg_off, tmp_size, hdr_len;
+	u32 len, pg_off, hdr_len;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -429,24 +482,40 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		hdr_len = READ_ONCE(hdr->len);
 		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
 			break;
-		tmp_size = hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
-		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
-		pend_pos += tmp_size;
+		pend_pos += bpf_ringbuf_round_up_hdr_len(hdr_len);
 	}
 	rb->pending_pos = pend_pos;
 
-	/* check for out of ringbuf space:
-	 * - by ensuring producer position doesn't advance more than
-	 *   (ringbuf_size - 1) ahead
-	 * - by ensuring oldest not yet committed record until newest
-	 *   record does not span more than (ringbuf_size - 1)
-	 */
-	if (new_prod_pos - cons_pos > rb->mask ||
-	    new_prod_pos - pend_pos > rb->mask) {
+	if (!bpf_ringbuf_has_space(rb, new_prod_pos, cons_pos, pend_pos)) {
 		raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
 
+	/* In overwrite mode, advance overwrite_pos when the ring buffer is full.
+	 * The key points are to stay on record boundaries and consume enough records
+	 * to fit the new one.
+	 */
+	if (unlikely(rb->overwrite_mode)) {
+		over_pos = rb->overwrite_pos;
+		while (new_prod_pos - over_pos > rb->mask) {
+			hdr = (void *)rb->data + (over_pos & rb->mask);
+			hdr_len = READ_ONCE(hdr->len);
+			/* The bpf_ringbuf_has_space() check above ensures we won’t
+			 * step over a record currently being worked on by another
+			 * producer.
+			 */
+			over_pos += bpf_ringbuf_round_up_hdr_len(hdr_len);
+		}
+		/* smp_store_release(&rb->producer_pos, new_prod_pos) at
+		 * the end of the function ensures that when consumer sees
+		 * the updated rb->producer_pos, it always sees the updated
+		 * rb->overwrite_pos, so when consumer reads overwrite_pos
+		 * after smp_load_acquire(r->producer_pos), the overwrite_pos
+		 * will always be valid.
+		 */
+		WRITE_ONCE(rb->overwrite_pos, over_pos);
+	}
+
 	hdr = (void *)rb->data + (prod_pos & rb->mask);
 	pg_off = bpf_ringbuf_rec_pg_off(rb, hdr);
 	hdr->len = size | BPF_RINGBUF_BUSY_BIT;
@@ -576,6 +645,8 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 		return smp_load_acquire(&rb->consumer_pos);
 	case BPF_RB_PROD_POS:
 		return smp_load_acquire(&rb->producer_pos);
+	case BPF_RB_OVERWRITE_POS:
+		return smp_load_acquire(&rb->overwrite_pos);
 	default:
 		return 0;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..9fbbbc3dc490 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1430,6 +1430,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* Enable BPF ringbuf overwrite mode */
+	BPF_F_RB_OVERWRITE	= (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6231,6 +6234,7 @@ enum {
 	BPF_RB_RING_SIZE = 1,
 	BPF_RB_CONS_POS = 2,
 	BPF_RB_PROD_POS = 3,
+	BPF_RB_OVERWRITE_POS = 4,
 };
 
 /* BPF ring buffer constants */
-- 
2.43.0


