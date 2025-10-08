Return-Path: <linux-kselftest+bounces-42869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784CBC44F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73E84ED7FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C762F5A35;
	Wed,  8 Oct 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcSnmZFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5352EC560
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919211; cv=none; b=pu3NkSWvAsvDbF0TWeI8lz1xC7rLjX0TfHh+GxVLU/FuD5EkTDSfEPublpyrOHN28MpGpxzQBFREq3wnGNIBLCXnHqOv2/ysOK7ItfD1heqQX4VN0vNU+fstxugD1MgIB0JSQM/cpmjHjWsxCAwRgBycBFKemLNBU+zQUHMX6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919211; c=relaxed/simple;
	bh=AEFel8Jyuz/acM4rK1Kr9Q7YLMR6GVipoE2WsOQReR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m9lNt9n0ZxNmFnmEcyNVHtSMAugfmaZs6kjNrJlTvwWvtEudgzXw08vO0eXZctaBA0QAi788ucc+PkPW6HGepX2sKt7jmsXEzeAUzs9XLJhLqx65YCx2sy71rf5KGj1VDN6PbB2ArUeBRqgZTAD8Ie4WSqRg3w8FHqTlug10rdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcSnmZFl; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759919202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g6KcRE+7jq80YyojGjcpCzmM0DGnxx2JGBpTmSjkJUM=;
	b=RcSnmZFl17t/tG5HV3zY0RGJUPLeSikcyFaU03nYTXtQes6lCzUELJg207w0XPfMz4CHcH
	/68451It8zsEjMo/7eOXhISNnXMcUB1EFWrby2hSXnK7eJRknPUVJgYNWGwSi6qgXepnsp
	XAcqKloTYrnAZhgATz6Xl3/+3wwOFQU=
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
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
Date: Wed,  8 Oct 2025 18:26:25 +0800
Message-ID: <20251008102628.808045-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid RCU context warning when unpinning
htab with internal structs (timer, workqueue, or task_work).

v3:
  - fix nit (Yonghong Song)
  - add Acked-by: Yonghong Song <yonghong.song@linux.dev>

v2:
  - rename bpf_free_inode() to bpf_destroy_inode() (Andrii)
 https://lore.kernel.org/all/20251007012235.755853-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/all/20251003084528.502518-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Avoid RCU context warning when unpinning htab with internal
    structs
  selftests/bpf: Add test for unpinning htab with internal timer struct

 kernel/bpf/inode.c                            |  4 +--
 .../selftests/bpf/prog_tests/pinning_htab.c   | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

-- 
2.43.0


