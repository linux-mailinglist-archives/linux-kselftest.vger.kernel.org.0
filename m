Return-Path: <linux-kselftest+bounces-43475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8986BEC6DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 06:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42DB74E14BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437824DFF3;
	Sat, 18 Oct 2025 04:04:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A31946C8;
	Sat, 18 Oct 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760760286; cv=none; b=JSZrvzX5G50qSk3FC0W8cM4v9lxQ4qe2sTWODdXGIXPT3Dsvql/3qNxv8l+jeZKvyfl22WWaMWbR4mww8OwwuYPBZt4xwjNV8L323kL1pJp+/IsaU9zcmcg+Aa0oBJYJzKhCSVragXxKwicjxTU3u9sq+RxiQ+jdqwIu8QoFdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760760286; c=relaxed/simple;
	bh=w2OmXz1GYaTaIzFM+thfbsMflKNe20SMlAQTjTWdBQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/7aSfd0R1d0ekNtxuPnEGcqPUnL7d8m5ELXHNTNPh5gCcvdoIudQIii+gYVWC8wC+1O12yYIEHu9iLoQt0gwEjn8u+IpJ+FNeH09z0+1jc7IvqPJOwks2UXWmn0Wb+LZEvTWvKyR087/KT1gsrc5uIbmFRGolzF8MYI24Om6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cpSjc3KbQzYQtj5;
	Sat, 18 Oct 2025 12:03:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 84FA01A0D82;
	Sat, 18 Oct 2025 12:04:35 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP2 (Coremail) with SMTP id Syh0CgA32UHPEfNoOeb+Ag--.21556S2;
	Sat, 18 Oct 2025 12:04:33 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/3] bpf: Add overwrite mode for BPF ring buffer 
Date: Sat, 18 Oct 2025 11:57:35 +0800
Message-ID: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA32UHPEfNoOeb+Ag--.21556S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxJw4DGr18Xw43JFWkWFg_yoW8Ww43pa
	n5KFy5Krn2ka4xWw1fu3W7tryrtw4kZw1rKw1fXw1fZrWUJFyrXF4Igr13Zrn8JrWxtr1Y
	k34jgr95W34jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

When the BPF ring buffer is full, a new event cannot be recorded until one
or more old events are consumed to make enough space for it. In cases such
as fault diagnostics, where recent events are more useful than older ones,
this mechanism may lead to critical events being lost.

So add overwrite mode for BPF ring buffer to address it. In this mode, the
new event overwrites the oldest event when the buffer is full.

v3:
- remove half-round wakeup, drop unnecessary min in ringbuf_avail_data_sz(),
  switch to smp_load_acquire, update tests and fix typos, etc (Andrii)
- rebase and re-collect performance data

v2:
https://lore.kernel.org/bpf/20250905150641.2078838-1-xukuohai@huaweicloud.com/
- remove libbpf changes (Andrii)
- update overwrite benchmark

v1:
https://lore.kernel.org/bpf/20250804022101.2171981-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  bpf: Add overwrite mode for BPF ring buffer
  selftests/bpf: Add overwrite mode test for BPF ring buffer
  selftests/bpf/benchs: Add overwrite mode benchmark for BPF ring buffer

 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/ringbuf.c                          | 109 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/benchs/bench_ringbufs.c     |  66 ++++++++++-
 .../bpf/benchs/run_bench_ringbufs.sh          |   4 +
 .../selftests/bpf/prog_tests/ringbuf.c        |  64 ++++++++++
 .../selftests/bpf/progs/ringbuf_bench.c       |  11 ++
 .../bpf/progs/test_ringbuf_overwrite.c        |  98 ++++++++++++++++
 9 files changed, 337 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c

-- 
2.43.0


