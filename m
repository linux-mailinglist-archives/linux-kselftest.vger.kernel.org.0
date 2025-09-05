Return-Path: <linux-kselftest+bounces-40845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823CB45C34
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED190584B5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437831993B7;
	Fri,  5 Sep 2025 15:13:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6231B816;
	Fri,  5 Sep 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085205; cv=none; b=oGARJlKJxvU6AcC89ZiSabcUYXBEX/e7kBHSAVFP6Cn5H8q6YayGFaT9CL9tJ1RLIKm0lwDh8TJXf4tNwp1Ryak8uWC2XD39pF64aEBdcsOKJ/ks4JZiarZDvBrqZ7KW9Bss4883m6yminnVe42HlyQV8S9Jo8iwyLA3ahv1Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085205; c=relaxed/simple;
	bh=NWOuTuw+EJ9IzR6EFtSxI8823k0Bk7UX//cx7V21zC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCk3RLEt1mkOllmcdvkT/A16yVxi8nr2KtxMd9KyrEHxJ1utIFP+C4M93JVURLcn1PC/66NZgx6m29S/5TbShq/XoIdJBQVYfqlbd3KEtyMYcYFdtcp6HsWVCogRHv6nba5NZRsbVH17I9ZJOb+84MJ30/AI7ucyXI8d6z0vLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJKbv5HV9zYQvKm;
	Fri,  5 Sep 2025 23:13:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A7AA1A0DBD;
	Fri,  5 Sep 2025 23:13:14 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnfYoF_rpoPC72BQ--.54678S3;
	Fri, 05 Sep 2025 23:13:13 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring buffer
Date: Fri,  5 Sep 2025 23:06:39 +0800
Message-ID: <20250905150641.2078838-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfYoF_rpoPC72BQ--.54678S3
X-Coremail-Antispam: 1UD129KBjvAXoWfCw1DAw15Wr4rZr4fZFWkWFg_yoW8uF1DJo
	WSva1xuF48Cr1UZrWUK3Z7GF1rAryDGFnrCr43uw13CFyDJFZFqry3JFs5W3Z8Xrn8GF1D
	C3W5Jr15trn8Jr1Un29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOy7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCY02Avz4vEIxC_XrWl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUhWrWUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When the bpf ring buffer is full, new events can not be recorded util
the consumer consumes some events to free space. This may cause critical
events to be discarded, such as in fault diagnostic, where recent events
are more critical than older ones.

So add ovewrite mode for bpf ring buffer. In this mode, the new event
overwrites the oldest event when the buffer is full.

The scheme is as follows:

1. producer_pos tracks the next position to write new data. When there
   is enough free space, producer simply moves producer_pos forward to
   make space for the new event.

2. To avoid waiting for consumer to free space when the buffer is full,
   a new variable overwrite_pos is introduced for producer. overwrite_pos
   tracks the next event to be overwritten (the oldest event committed) in
   the buffer. producer moves it forward to discard the oldest events when
   the buffer is full.

3. pending_pos tracks the oldest event under committing. producer ensures
   producers_pos never passes pending_pos when making space for new events.
   So multiple producers never write to the same position at the same time.

4. producer wakes up consumer every half a round ahead to give it a chance
   to retrieve data. However, for an overwrite-mode ring buffer, users
   typically only cares about the ring buffer snapshot before a fault occurs.
   In this case, the producer should commit data with BPF_RB_NO_WAKEUP flag
   to avoid unnecessary wakeups.

To make it clear, here are some example diagrams.

1. Let's say we have a ring buffer with size 4096.

    At first, {producer,overwrite,pending,consumer}_pos are all set to 0

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

2. Reserve event A, size 512.

    There is enough free space, so A is allocated at offset 0 and producer_pos
    is moved to 512, the end of A. Since A is not submitted, the BUSY bit is
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

    B is allocated at offset 512 with BUSY bit set, and producer_pos is moved
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

    C is allocated at offset 1536 and producer_pos becomes 3584.

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

    The BUSY bit of A is cleared. B becomes the oldest event under writing, so
    pending_pos is moved to 512, the start of B.

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

    The BUSY bit of B is cleared, and pending_pos is moved to the start of C,
    which is the oldest event under writing now.

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

    There are 2048 bytes not under writing between producer_pos and pending_pos,
    so D is allocated at offset 3584, and producer_pos is moved from 3584 to
    5120.

    Since event D will overwrite all bytes of event A and the begining 512 bytes
    of event B, overwrite_pos is moved to the start of event C, the oldest event
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

    Though there are 512 bytes not under writing between producer_pos and
    pending_pos, E can not be reserved, as it would overwrite the first 512
    bytes of event C, which is still under writing.

9. Submit event C and D.

    pending_pos is moved to the end of D.

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
patch that adds overwrite mode benchs.

A sample of performance data for non-overwrite mode on an x86_64 and arm64
CPU, before and after this patch, is shown below. As we can see, no obvious
performance regression occurs.

- x86_64 (AMD EPYC 9654)

Before:

Ringbuf, multi-producer contention
==================================
  rb-libbpf nr_prod 1  13.218 ± 0.039M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  15.684 ± 0.015M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  7.771 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  6.281 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  2.842 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 2.001 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 1.833 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 1.508 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 1.421 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 1.309 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 1.265 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 1.198 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 1.174 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 1.113 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 1.097 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 1.070 ± 0.002M/s (drops 0.000 ± 0.000M/s)

After:

Ringbuf, multi-producer contention
==================================
  rb-libbpf nr_prod 1  13.751 ± 0.673M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  15.592 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  7.776 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  6.463 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  2.883 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 2.017 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 1.816 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 1.512 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 1.396 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 1.303 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 1.267 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 1.210 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 1.181 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 1.136 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 1.090 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 1.091 ± 0.002M/s (drops 0.000 ± 0.000M/s)

- arm64 (HiSilicon Kunpeng 920)

Before:

  Ringbuf, multi-producer contention
  ==================================
  rb-libbpf nr_prod 1  11.602 ± 0.423M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  9.599 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  6.669 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  4.806 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  3.856 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 3.368 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 3.210 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 3.003 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 2.944 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 2.863 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 2.819 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 2.887 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 2.837 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 2.787 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 2.738 ± 0.010M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 2.700 ± 0.007M/s (drops 0.000 ± 0.000M/s)

After:

  Ringbuf, multi-producer contention
  ==================================
  rb-libbpf nr_prod 1  11.614 ± 0.268M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  9.917 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  6.920 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  4.803 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  3.898 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 3.426 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 3.320 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 3.029 ± 0.013M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 3.068 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 2.890 ± 0.009M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 2.950 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 2.812 ± 0.006M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 2.834 ± 0.009M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 2.803 ± 0.010M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 2.766 ± 0.010M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 2.754 ± 0.009M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/ringbuf.c           | 159 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |   4 +
 3 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..d3b2fd2ae527 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1430,6 +1430,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* bpf ringbuf works in overwrite mode? */
+	BPF_F_OVERWRITE		= (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6215,6 +6218,7 @@ enum {
 	BPF_RB_RING_SIZE = 1,
 	BPF_RB_CONS_POS = 2,
 	BPF_RB_PROD_POS = 3,
+	BPF_RB_OVER_POS = 4,
 };
 
 /* BPF ring buffer constants */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..6ca41d01f187 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -13,7 +13,7 @@
 #include <linux/btf_ids.h>
 #include <asm/rqspinlock.h>
 
-#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
+#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE | BPF_F_OVERWRITE)
 
 /* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) */
 #define RINGBUF_PGOFF \
@@ -27,7 +27,8 @@
 struct bpf_ringbuf {
 	wait_queue_head_t waitq;
 	struct irq_work work;
-	u64 mask;
+	u64 mask:48;
+	u64 overwrite_mode:1;
 	struct page **pages;
 	int nr_pages;
 	rqspinlock_t spinlock ____cacheline_aligned_in_smp;
@@ -72,6 +73,7 @@ struct bpf_ringbuf {
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	unsigned long overwrite_pos;  /* to be overwritten in overwrite mode */
 	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
@@ -166,7 +168,8 @@ static void bpf_ringbuf_notify(struct irq_work *work)
  * considering that the maximum value of data_sz is (4GB - 1), there
  * will be no overflow, so just note the size limit in the comments.
  */
-static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
+static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node,
+					     int overwrite_mode)
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
+	int overwrite_mode = 0;
 	struct bpf_ringbuf_map *rb_map;
 
 	if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
 
+	if (attr->map_flags & BPF_F_OVERWRITE) {
+		if (attr->map_type == BPF_MAP_TYPE_USER_RINGBUF)
+			return ERR_PTR(-EINVAL);
+		overwrite_mode = 1;
+	}
+
 	if (attr->key_size || attr->value_size ||
 	    !is_power_of_2(attr->max_entries) ||
 	    !PAGE_ALIGNED(attr->max_entries))
@@ -205,7 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&rb_map->map, attr);
 
-	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
+	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node,
+				       overwrite_mode);
 	if (!rb_map->rb) {
 		bpf_map_area_free(rb_map);
 		return ERR_PTR(-ENOMEM);
@@ -295,11 +307,16 @@ static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma
 
 static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
-	unsigned long cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos, over_pos;
 
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 	prod_pos = smp_load_acquire(&rb->producer_pos);
-	return prod_pos - cons_pos;
+
+	if (likely(!rb->overwrite_mode))
+		return prod_pos - cons_pos;
+
+	over_pos = READ_ONCE(rb->overwrite_pos);
+	return min(prod_pos - max(cons_pos, over_pos), rb->mask + 1);
 }
 
 static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
@@ -402,11 +419,43 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 	return (void*)((addr & PAGE_MASK) - off);
 }
 
+
+static bool bpf_ringbuf_has_space(const struct bpf_ringbuf *rb,
+				  unsigned long new_prod_pos,
+				  unsigned long cons_pos,
+				  unsigned long pend_pos)
+{
+	/* no space if oldest not yet committed record until the newest
+	 * record span more than (ringbuf_size - 1)
+	 */
+	if (new_prod_pos - pend_pos > rb->mask)
+		return false;
+
+	/* ok, we have space in ovewrite mode */
+	if (unlikely(rb->overwrite_mode))
+		return true;
+
+	/* no space if producer position advances more than (ringbuf_size - 1)
+	 * ahead than consumer position when not in overwrite mode
+	 */
+	if (new_prod_pos - cons_pos > rb->mask)
+		return false;
+
+	return true;
+}
+
+static u32 ringbuf_round_up_hdr_len(u32 hdr_len)
+{
+	hdr_len &= ~BPF_RINGBUF_DISCARD_BIT;
+	return round_up(hdr_len + BPF_RINGBUF_HDR_SZ, 8);
+}
+
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
+	unsigned long flags;
 	struct bpf_ringbuf_hdr *hdr;
-	u32 len, pg_off, tmp_size, hdr_len;
+	u32 len, pg_off, hdr_len;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, over_pos;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -429,24 +478,39 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		hdr_len = READ_ONCE(hdr->len);
 		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
 			break;
-		tmp_size = hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
-		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
-		pend_pos += tmp_size;
+		pend_pos += ringbuf_round_up_hdr_len(hdr_len);
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
 
+	/* In overwrite mode, move overwrite_pos to the next record to be
+	 * overwritten if the ring buffer is full
+	 */
+	if (unlikely(rb->overwrite_mode)) {
+		over_pos = rb->overwrite_pos;
+		while (new_prod_pos - over_pos > rb->mask) {
+			hdr = (void *)rb->data + (over_pos & rb->mask);
+			hdr_len = READ_ONCE(hdr->len);
+			/* since pending_pos is the first record with BUSY
+			 * bit set and overwrite_pos is never bigger than
+			 * pending_pos, no need to check BUSY bit here.
+			 */
+			over_pos += ringbuf_round_up_hdr_len(hdr_len);
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
@@ -479,7 +543,50 @@ const struct bpf_func_proto bpf_ringbuf_reserve_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
+static __always_inline
+bool ringbuf_should_wakeup(const struct bpf_ringbuf *rb,
+			   unsigned long rec_pos,
+			   unsigned long cons_pos,
+			   u32 len, u64 flags)
+{
+	unsigned long rec_end;
+
+	if (flags & BPF_RB_FORCE_WAKEUP)
+		return true;
+
+	if (flags & BPF_RB_NO_WAKEUP)
+		return false;
+
+	/* for non-overwrite mode, if consumer caught up and is waiting for
+	 * our record, notify about new data availability
+	 */
+	if (likely(!rb->overwrite_mode))
+		return cons_pos == rec_pos;
+
+	/* for overwrite mode, to give the consumer a chance to catch up
+	 * before being overwritten, wake up consumer every half a round
+	 * ahead.
+	 */
+	rec_end = rec_pos + ringbuf_round_up_hdr_len(len);
+
+	cons_pos &= (rb->mask >> 1);
+	rec_pos &= (rb->mask >> 1);
+	rec_end &= (rb->mask >> 1);
+
+	if (cons_pos == rec_pos)
+		return true;
+
+	if (rec_pos < cons_pos && cons_pos < rec_end)
+		return true;
+
+	if (rec_end < rec_pos && (cons_pos > rec_pos || cons_pos < rec_end))
+		return true;
+
+	return false;
+}
+
+static __always_inline
+void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
 {
 	unsigned long rec_pos, cons_pos;
 	struct bpf_ringbuf_hdr *hdr;
@@ -495,15 +602,10 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
 	/* update record header with correct final size prefix */
 	xchg(&hdr->len, new_len);
 
-	/* if consumer caught up and is waiting for our record, notify about
-	 * new data availability
-	 */
 	rec_pos = (void *)hdr - (void *)rb->data;
 	cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
 
-	if (flags & BPF_RB_FORCE_WAKEUP)
-		irq_work_queue(&rb->work);
-	else if (cons_pos == rec_pos && !(flags & BPF_RB_NO_WAKEUP))
+	if (ringbuf_should_wakeup(rb, rec_pos, cons_pos, new_len, flags))
 		irq_work_queue(&rb->work);
 }
 
@@ -576,6 +678,8 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 		return smp_load_acquire(&rb->consumer_pos);
 	case BPF_RB_PROD_POS:
 		return smp_load_acquire(&rb->producer_pos);
+	case BPF_RB_OVER_POS:
+		return READ_ONCE(rb->overwrite_pos);
 	default:
 		return 0;
 	}
@@ -749,6 +853,9 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 
 	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
 
+	if (unlikely(rb->overwrite_mode))
+		return -EOPNOTSUPP;
+
 	/* If another consumer is already consuming a sample, wait for them to finish. */
 	if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
 		return -EBUSY;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..d3b2fd2ae527 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1430,6 +1430,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* bpf ringbuf works in overwrite mode? */
+	BPF_F_OVERWRITE		= (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6215,6 +6218,7 @@ enum {
 	BPF_RB_RING_SIZE = 1,
 	BPF_RB_CONS_POS = 2,
 	BPF_RB_PROD_POS = 3,
+	BPF_RB_OVER_POS = 4,
 };
 
 /* BPF ring buffer constants */
-- 
2.43.0


