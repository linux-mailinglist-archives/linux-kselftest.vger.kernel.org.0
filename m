Return-Path: <linux-kselftest+bounces-4996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF285B1A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 04:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21FE1F224D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5247A4C;
	Tue, 20 Feb 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VDtbfO9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4192E62C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401067; cv=none; b=MlZnDMJ6GtaeRlyRAtNHcR6jWXvW8cXfR6hiv7LzugQXrkbCryi6IWYY9Uuo5h4AujjGlE2QbECpnJdVVYUqXS2mXe0yhqM0Y81X6GZbpNXyXmHNSTrktO0RToomGj1v0SR8GG4n1mprbmEpv8xYmYjvvFbgio/k5651qF6it5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401067; c=relaxed/simple;
	bh=JyiRLKze27i/EWisJDgR5HNSiZboVQmTKOBRnTPQz+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USo4pYqmMSk5GZl9f6RVvCwbTXlfpxh79l8bt0BeUMphxr+gPQ3UsxjEaJeX+J6Qu+AFYH6ZoO40okgsJfWa/vxlvh4mHqubZeNKqn+PLRK+eUxOK5eSFIw/G5+MlRjk4K3tXI39Mrij6c8mIt86aHoLVtbgU/5YAn4oRI7pDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VDtbfO9s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d751bc0c15so45673955ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401065; x=1709005865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UkmNgftH857w2sqifeOqAr+iNHF37XOde+wq8ViDZE=;
        b=VDtbfO9sSLNSfszgw6LtF75JFQM+lVmXZmb4RtvenMDGVlROmM8+E6lfQYuL7uJ2+4
         GTth0jItp6iCjAbc2STIM/woni/k6mUDhHlH4D9DLVU2XGHkheocoF0Q1nCNxd6PIm6a
         aqx4i//cP51/Rps3LAbjVAUQ1QKzPRrQW0VS/3yf8YpG9eRJHD3shC3geFHYcZsiX5Nm
         Vj3KDYtKlZF4xSMRam9IZ2/dlRyeZk7XX1ol1N171Kpd7oDEBGvj5baR8RWaODlQbmN8
         FSVdEvt2gXB6PYaBPyBJWj8jT8hhXWRn2IJynbZA9g+IXi2s09+kmsfIYBLooAkyqgf1
         FdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401065; x=1709005865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UkmNgftH857w2sqifeOqAr+iNHF37XOde+wq8ViDZE=;
        b=lV0i04n61aYrT3wdvj+EBw9faPyZCnq0GluLCF+zDYUBR/3pkEWxN78OzAgaS0zlvK
         sZvGCYIdDcoTq+ScboikTDj5arHElueevnBRT1UNgzyxgK53YmaUXj5/mnTkDArIB+FA
         HKBltPiE7ccJ/+f0SVgls6A/IfP6uJ31sA47xgiZGex6f/MvRdnMCL6UCs/3WJKKwfUM
         /uNcSsFtzPD/nAnU/hXUglZagE6XgpxMcwlgTCi6f+1hOhV6r6bvzM05bR63jOrfUdZY
         VLY+BUWyfZLAzRELSGBRBuF7ok/vOM575K2BsTgOQy6o5PPvgFdjobrP8c0icfy3ZZTg
         JrYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0r7KZ5WAFSHXDyXOemt710l9CQrIZH/TyWVchx2db7w2N8dgUgGS6m0GYwddAXRBp8gTxeQdkJD4xcr1gucDcg5CMsd2BcjSS+BTnvpAF
X-Gm-Message-State: AOJu0Yz7ib9A26R2YXx96gY+XoFh7DRghwGdOR64d3W/QkGmOTEd1U3k
	jYqlSYgY4RAmqNETjhMTLO18jeSEw2aulDucmc6gIA2D1DYxcDb3RiZilgiFAXc=
X-Google-Smtp-Source: AGHT+IFahjx8Wl0J1qpYL1S67NT7dQm8quAfM53FT6LDzNXvorRUNHjgFtfIKe9Dezhf1ddJbvtSYw==
X-Received: by 2002:a17:903:1104:b0:1db:37b1:b1a3 with SMTP id n4-20020a170903110400b001db37b1b1a3mr16490922plh.17.1708401065669;
        Mon, 19 Feb 2024 19:51:05 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:05 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 0/5] bpf: make tracing program support multi-attach
Date: Tue, 20 Feb 2024 11:51:00 +0800
Message-Id: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed to
be attached to multiple hooks, and we have to create a BPF program for
each kernel function, for which we want to trace, even through all the
program have the same (or similar) logic. This can consume extra memory,
and make the program loading slow if we have plenty of kernel function to
trace.

In the commit 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to
multiple attach points"), the freplace BPF program is made to support
attach to multiple attach points. And in this series, we extend it to
fentry/fexit/raw_tp/...

In the 1st patch, we add the support to record index of the accessed
function args of the target for tracing program. Meanwhile, we add the
function btf_check_func_part_match() to compare the accessed function args
of two function prototype. This function will be used in the next commit.

In the 2nd patch, we do some adjust to bpf_tracing_prog_attach() to make
it support multiple attaching.

In the 3rd patch, we allow to set bpf cookie in bpf_link_create() even if
target_btf_id is set, as we are allowed to attach the tracing program to
new target.

In the 4th patch, we introduce the function libbpf_find_kernel_btf_id() to
libbpf to find the btf type id of the kernel function, and this function
will be used in the next commit.

In the 5th patch, we add the testcases for this series.

Menglong Dong (5):
  bpf: tracing: add support to record and check the accessed args
  bpf: tracing: support to attach program to multi hooks
  libbpf: allow to set coookie when target_btf_id is set in
    bpf_link_create
  libbpf: add the function libbpf_find_kernel_btf_id()
  selftests/bpf: add test cases for multiple attach of tracing program

 include/linux/bpf.h                           |   6 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              | 121 ++++++++++++++
 kernel/bpf/syscall.c                          | 118 +++++++++++---
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/libbpf.c                        |  83 ++++++++++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 ++++++
 .../bpf/prog_tests/tracing_multi_attach.c     | 153 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_test.c  |  66 ++++++++
 11 files changed, 583 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

-- 
2.39.2


