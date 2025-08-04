Return-Path: <linux-kselftest+bounces-38228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A1B19A29
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 04:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B3E7A9530
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22381F5838;
	Mon,  4 Aug 2025 02:27:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AE4C83;
	Mon,  4 Aug 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274430; cv=none; b=ikhEQI+y6rsi08DU+YEYtgDXJpX95wUdzGc6Z+rr1ncTCgFuaP+9d9Ox/sYTcB1Q1IhVxQrk1mRsc2/XLHTUJFO/kwfIIAj5lDn19kANWaXbAmYPVpi8GZ5XMjtbfsTZ4ZDfLjfKvwyPGWbDKRS5QUbgDnYzIsH4+KcEqcVO4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274430; c=relaxed/simple;
	bh=SH2VsF0c2qYDhnX+O5sTl/7AV/kWTXVbVc1G+MkUcgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpDUiy3lfnE4pdku5P1+cf+Osu2apLbBd5iIZnAleUqJOWNV1BJ2bfuMGtbug/Fbc2BGMriA+6fJJPG/Muf1alqnGY5v/mGSBGZCMfJB8YFKEuoJQQr95Rdat0EJoB9QmG6K0dNCx5e0e4M2xRpUnbDBxcocaaHejrxMwC0beto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bwL6f5x5DzKHMRl;
	Mon,  4 Aug 2025 10:27:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CC4BE1A06DD;
	Mon,  4 Aug 2025 10:27:05 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgAX4BBsGpBoTUL9CQ--.242S2;
	Mon, 04 Aug 2025 10:27:05 +0800 (CST)
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
Subject: [PATCH bpf-next 0/4] Add overwrite mode for bpf ring buffer
Date: Mon,  4 Aug 2025 10:20:56 +0800
Message-ID: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX4BBsGpBoTUL9CQ--.242S2
X-Coremail-Antispam: 1UD129KBjvJXoWruFy3GFyDZr4rXryxurWrGrg_yoW8Jryxpa
	n5KFy5trn2ka4xuwn3uF4IqryrArs7Zr4fKw47Xw15Zry5JFW5XFyI9r15JrnxJrWxJr1F
	kr90gryrG34jqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCY02Avz4vEIxC_Gr1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUh89NDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When the bpf ring buffer is full, new events can not be recorded util
the consumer consumes some events to free space. This may cause critical
events to be discarded, such as in fault diagnostic, where recent events
are more critical than older ones.

So add ovewrite mode for bpf ring buffer. In this mode, the new event
overwrites the oldest event when the buffer is full.

Xu Kuohai (4):
  bpf: Add overwrite mode for bpf ring buffer
  libbpf: ringbuf: Add overwrite ring buffer process
  selftests/bpf: Add test for overwrite ring buffer
  selftests/bpf/benchs: Add overwrite mode bench for rb-libbpf

 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/ringbuf.c                          | 159 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/lib/bpf/ringbuf.c                       | 103 +++++++++++-
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/benchs/bench_ringbufs.c     |  22 ++-
 .../bpf/benchs/run_bench_ringbufs.sh          |   4 +
 .../selftests/bpf/prog_tests/ringbuf.c        |  74 ++++++++
 .../bpf/progs/test_ringbuf_overwrite.c        |  98 +++++++++++
 9 files changed, 442 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c

-- 
2.43.0


