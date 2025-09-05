Return-Path: <linux-kselftest+bounces-40844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997EB45C2B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA481C203D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121031B819;
	Fri,  5 Sep 2025 15:13:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2931B80D;
	Fri,  5 Sep 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085204; cv=none; b=Uy7OyGz97vFvdlhEmnN8mQfd+MDUH9+gQYIo5NWXnjneFcte9mPQ336NmaGQy+zWv4N+8gCn7YN1UN1uhkLsfgONXjKZ/FnNmxJsuY8ssL9ReX4Oqhdr4XJXxwUS+9R+DnAkPEXgenzG8XuPhSPHlS8dGXW76ird+gSATFAlPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085204; c=relaxed/simple;
	bh=aX0skoyK6lzyBnPPEwaSlTRzaALmW1WARz4u1Q7KPC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT0IpfL1IVpfAeoh70+/+Fq520g6HmsZ2cuiOCloKEKMj6q4iDdoEYQMloqGlzQvNZwWTecJI9O0XCfxtss4qnEQZWHuT4gc4OHkYwGpQt76eLuKyu2ve/kSb394kVf1aeMNWZu/uYJKOXHjreCibqL60GGu6VkeJavdsnAYC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJKbt5YPbzYQvGy;
	Fri,  5 Sep 2025 23:13:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 42B651A07BB;
	Fri,  5 Sep 2025 23:13:13 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnfYoF_rpoPC72BQ--.54678S2;
	Fri, 05 Sep 2025 23:13:11 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/3] Add overwrite mode for bpf ring buffer
Date: Fri,  5 Sep 2025 23:06:38 +0800
Message-ID: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfYoF_rpoPC72BQ--.54678S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4kGFWUCr4rtrW7tF43KFg_yoW8GF17pa
	n5KF15trn2kFyxWw1fuF4IgryrAw4kZr1rKw1fXw15ZrWUJFWrXFyIkr15XrnxJrWIqr1F
	k34qgryrW34jqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCY02Avz4vEIxC_XrWl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUhiFxUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

When the bpf ring buffer is full, new events can not be recorded util
the consumer consumes some events to free space. This may cause critical
events to be discarded, such as in fault diagnostic, where recent events
are more critical than older ones.

So add ovewrite mode for bpf ring buffer. In this mode, the new event
overwrites the oldest event when the buffer is full.

v2:
- remove libbpf changes (Andrii)
- update overwrite benchmark

v1:
https://lore.kernel.org/bpf/20250804022101.2171981-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  bpf: Add overwrite mode for bpf ring buffer
  selftests/bpf: Add test for overwrite ring buffer
  selftests/bpf/benchs: Add producer and overwrite bench for ring buffer

 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/ringbuf.c                          | 159 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_ringbufs.c     |  95 ++++++++++-
 .../bpf/benchs/run_bench_ringbufs.sh          |   4 +
 .../selftests/bpf/prog_tests/ringbuf.c        |  74 ++++++++
 .../selftests/bpf/progs/ringbuf_bench.c       |  10 ++
 .../bpf/progs/test_ringbuf_overwrite.c        |  98 +++++++++++
 10 files changed, 418 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c

-- 
2.43.0


