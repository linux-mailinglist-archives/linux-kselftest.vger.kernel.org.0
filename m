Return-Path: <linux-kselftest+bounces-40250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F51B3B0BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF17987FE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8F21171B;
	Fri, 29 Aug 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aOMjaQEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF3282F1;
	Fri, 29 Aug 2025 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433563; cv=none; b=fqabBJRy9mDJ3TxAljpobFH7LaPymM+OnBctlPIWttcqbzrNOQLuxtCGF+UZPKm+Cn0RkypA5pbJ2EY0W/tyvz5pGLD+ovTX7D1p8R0pv8/uHCcWB36rPnHOINhV+wLG990onZBR9RDwv/RF/87boIv0ZypyfbpOsj1+6ZLv/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433563; c=relaxed/simple;
	bh=51uAMdHVDwoFTVTVYf+NlRl0ILVmKg0xaUDXaj1Nq/M=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VdjC41LmAv/UlypbW7xqWyww2qCYXEpcFG5X0NoWVynpJijoBfJKMCar+Dd8aDSi6TMH4XPpgd1z2RvA0iNXeKJagqLL3v5Ip0ShYxmRUWeJn7evjhc93tSGOe/vXqrsTxAAmVaLu+qKX3Erj9i2qIUNO/yr6K7AKT0dHNNhBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aOMjaQEx; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756433556;
	bh=4v4LNsGqTHD7ULFJNVAcOe5ApYuY00p0ODKG+0gwLYA=;
	h=From:To:Cc:Subject:Date;
	b=aOMjaQExR/NqpBJvwP5S6twzUMB+3+PNef6rV4Q4jhG8rSF4wyDeVtksuDST3PGHu
	 z8sx1RctOGbvgIwQaOQjlRyZvf6gRlaDdWtUsKtuemgfvBJnGUQ9isCS3BdjfT7gWO
	 T43scL45iiroscDsvp18qW1YESPREiMrmWmD9HK4=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 31F13A44; Fri, 29 Aug 2025 10:12:31 +0800
X-QQ-mid: xmsmtpt1756433551trq3aing6
Message-ID: <tencent_0682AB14BD5A8D0623CA1B440881665D5F0A@qq.com>
X-QQ-XMAILINFO: MtZ6QPwsmM9XukR/3G/ZOEbVNiVQpzxTcvIYYfcSxan6lDtbR0d+Cqg/jIYw7m
	 lYXdYJUtcDEeiY8FkIHj86i19KfbwVlxz5yrq3/EfGL4eH7rcjpN68gYlKQvilJUO9tLzxywvW81
	 BQaaMDfpC9Z1Ts1IktVsZ5gQcSJuGD2K/INWb1VozDaU9DUNLID2B1wKcscIqJxkaOVsDjkUgpCv
	 eACOwi578UTQ86M9Ce47zxCPTZhmH8+iNV61yL+/UlAxBhZMGXyP55Tf4eDCxJmxlEIFIMQap334
	 JhA+ykdVjDOSSyvUW7fS/7pJrJOPeX8xvHfxaIjexQYHUIIwHk5aUNyY7Vuj5Qo1rrIu704vIHVV
	 HEExwoEQSWXu8Ftqrw6ADOVEpRrC+bhab/4CP9edReUdUHld5zhT2mDIHX+v42zMKhRUvdZ+URm5
	 xMmnIV6O7S+r4B7BHbo3TeR5eUitK3lFfpQ/AzpRdtRPzPFqA+jx7jmZqgXFMYfVJ7mRccCMBN3T
	 r+gLOQDHTNqRk44nTCknILDS8+8G/q20Yy9SYMtRIEsQF0PU/sDKOzDPLd8pIvtnxQAqAahIUkrX
	 LJjXvgNcOVSEVNHwoVpxiAYwDRE/HnXich14loNSKl7tWUlHXn49MjUxWExKh/yPvVHxqc3eo1ku
	 Y/enWhvo9cb4plNCKkMh11HkWggHkc0O8d2+4AAALE/kDSV3vUpj2cowvfyB3QFhVSCQ4eB/+SXj
	 dWxhoesPotAkueE2Bzf5jFl/Qz+fJOHEg5jW1RtxVZLb+5Ai4rAM3UjwzspO4CTrK7yMLeRkDDg7
	 huMwn4UtwVvpuJEwde9HBkhC0vDysFguoazkjHcsDGXQdXrMSAi53nDV4GgMxBKwW/ptTXrLK1tg
	 dkHWItnQs+dcybeDXSTvt5EtBKhee8tJL5QW+QNCdx93bwUvdbk2+WYgNQxcytKmjI3UV0zkeY+T
	 8aXvDhTnkjuYjU3FvGEi76x6lN7EZJ+fJHbe6aboBHdsntkAqnCprn435U6w6dUkc7VTHG68Q3AV
	 1aFTXM2QQYZrnySrvX
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v4 0/2] Fix bpf_strnstr len error
Date: Fri, 29 Aug 2025 10:12:18 +0800
X-OQ-MSGID: <cover.1756433400.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Fix bpf_strnstr() wrong 'len' parameter, bpf_strnstr("open", "open", 4)
should return 0 instead of -ENOENT.

Rong Tao (2):
  bpf/helpers: bpf_strnstr: Exact match length
  selftests/bpf: Add tests for bpf_strnstr

 kernel/bpf/helpers.c                                   | 10 +++++++++-
 .../selftests/bpf/progs/string_kfuncs_success.c        |  8 ++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

---
v4: Add comment and more selftests;
v3: Fix selftests/bpf error in v2, sorry about that;
    https://lore.kernel.org/lkml/tencent_69BD268FBA201219240B51661D5E96A8D80A@qq.com/
v2: Follow Andrii Nakryiko's advise, fix the 'wrong fix';
    https://lore.kernel.org/lkml/tencent_DF4DA83EEBFB9246E5E3357BB40911CCA005@qq.com/
v1: https://lore.kernel.org/lkml/tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com/
-- 
2.51.0


