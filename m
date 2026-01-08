Return-Path: <linux-kselftest+bounces-48565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD1D067C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED7AF3008C7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF593382F1;
	Thu,  8 Jan 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuML2+Cz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4EE334361
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913001; cv=none; b=L+HkSWHJPSF0qeFJWj8mNEp2oVCN5jFpYqt43PnzeoQXKifJOf6+LbVYkWfsoFO3VgxxKYRj8sYhJ4ZVoR6dJVoUiWIBxRL3qRxMES0NPfZbOapZp3OqcmlF4f7idJBi+MPKNdzH5/4yP7cTELKBuAxETrwff2nkVBLC1SaCNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913001; c=relaxed/simple;
	bh=F5rLUx30ihLzNCsKKK+9lJkThou5C7DJgWMvbfY/DVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nmpVHd+rxd1NMeYhBvF33kc1UViJPrPpTyLfjQHPc68uRMFxw1MKtxFQ3IuQaI30ZLTdKVdXwETROhibipGZlYfENV0AQ0Otqn0hntCisHYhruQinNZsGMmagq1BM10tygQ/EaxLzw5gnLueiEPOabv2TulWhvPIzxDZYEWYg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuML2+Cz; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b048fc1656so4772784eec.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912999; x=1768517799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c2rtpYcP3DAOdbt732zx7+jr91irIrA8WZ/Xzq8bqJI=;
        b=nuML2+CzD8lZ59v+NlefqhkF62fgQVTjiCsFeX4C+04Q8OkeijSkXubPps9St/hUJL
         PdtqY4NKyzFDeffPq+OgkxVVBDIhgRElu57RCO0Q81IJahkjg0hyWu2lqeIcn4MvALpW
         I73O5vBe3Hwdk1gDISo5gPVBz+FcV8rJseyZZSvcmkh8gssRA11JhPbE331n91L3pn3N
         4SaponmL8zC7racmgAeKOIquQCHJWSSS8bzGGvRbOQatztvIyPKmSJFFQY9K7xY5Ruzj
         oKfCGq71t5evjS6AVWtTAPMwIH/PuODp8waf/iFMnm3BAr+E56xtx8yAezW8f36n52wv
         420g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912999; x=1768517799;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2rtpYcP3DAOdbt732zx7+jr91irIrA8WZ/Xzq8bqJI=;
        b=dBQvc7zT+nhTf5cLaL0rVqY3K/oXqKPSfvdjqmPHqgmD3tmGzhgqR2QUefNpVDGX/k
         EVmDopsH6kKw/sXql13nhtyYLnn0wAsIpe+Hxow/MbpFBucdYRfXiEilS6m99YdjiT1c
         y5VXBdelogQTvjWT2eAmCNOXNTE9GScH0PtDxNq6Yw/8rZ1iOOMYRfZVGNxh5hIGFAv+
         JiAmeqWJZHLgvF2GAdp3CvYaQvgxcW1Kmt7kkkoGs/D7+TvRCuQkZ0KdbplWkVbF34A2
         P3+z45LpV4HHW2J94mhoYt/bAEL7GOaInC4DrH+0aK862qrpND7hWcDI1yaqbx/o+GTZ
         s6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUew/Fhwjiw7cRD30WcWlEKObNHIMY1Gh85w9oslkcMRIp/3VjyeQCpbvDcfv2iWaLt27NGhhoxWjS4oV12WaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IMCXa5wusgufA4V9n4/xxEn+bSCb5THS4NLDKo9z00xZNBXt
	nN/Y3MDpvzwF91u1++c6Mb8gHfdh1g5I+RZngv21IThbxo77qAenLn3ghomFSEc7BlcE7tVTP7i
	/xvoYK3zukKezOg==
X-Google-Smtp-Source: AGHT+IEPMqVeidF/HQfzF5blhVJjcK7ooy1GXBw2OmQH8gfNq2+feiN8Uwq5zuBT5zWfoWRHgipKuLoi2G0jtA==
X-Received: from dyew16.prod.google.com ([2002:a05:7300:4350:b0:2b0:4f93:391f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2093:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2b17d2ba856mr5980637eec.21.1767912998679;
 Thu, 08 Jan 2026 14:56:38 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:17 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-1-wusamuel@google.com>
Subject: [PATCH bpf-next v2 0/4] Add wakeup_source iterators
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces BPF iterators for wakeup_source, enabling
BPF programs to efficiently traverse a device's wakeup sources.

Currently, inspecting wakeup sources typically involves reading interfaces
like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, and
each wakeup source have multiple stats, with one sysfs node per stat.
debugfs is unstable and insecure.

This series implements two types of iterators:
1. Standard BPF Iterator: Allows creating a BPF link to iterate over
   wakeup sources
2. Open-coded Iterator: Enables the use of wakeup_source iterators directly
   within BPF programs

Both iterators utilize pre-existing APIs wakeup_sources_walk_* to traverse
over the SRCU that backs the list of wakeup_sources.

Changes in v2:
 - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
 - Update copyright from 2025 to 2026
 - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel@google.com/

Samuel Wu (4):
  bpf: Add wakeup_source iterator
  bpf: Open coded BPF for wakeup_sources
  selftests/bpf: Add tests for wakeup_sources
  selftests/bpf: Open coded BPF wakeup_sources test

 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/wakeup_source_iter.c               | 137 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 323 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  | 117 +++++++
 7 files changed, 589 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

-- 
2.52.0.457.g6b5491de43-goog


