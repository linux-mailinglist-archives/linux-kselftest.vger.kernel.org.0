Return-Path: <linux-kselftest+bounces-7675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9698A07D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECE81C21889
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD013CA88;
	Thu, 11 Apr 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtJrBQsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F013CA84;
	Thu, 11 Apr 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814208; cv=none; b=PTVFWHuoTO4mu7GMRr7UA21K4dAQ1s8Bbp0zQPpkpdlruXxBeXvVv3Jxnqf6acZQjuv7cVZJGZlG4KXpH6AnHRDldk2WJaaGJdEULB+ptPHxUJuPoX0VjCyFVK35BnaZS5ZAT5zXRmHf7ykdcdKfBVON2Dm9ERiDFxdG5NcFzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814208; c=relaxed/simple;
	bh=Ppq489d3kgP23QUKTdPgMw60F9L/3oiXpl7j50kX9JM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amMdXy5v9kZmUwTfDPfsj210bkEBee4yFqA+KVkf4/K3jVHmHDzMCAtGWlDyK4HPRIgFbvWovR8IRoMoTyOhfUzpgLZu729IF5Z++6Fmj4CK7g+33sieXGnL75CPhKHgBaNWKRcIF3/zxYLQzaOs2y+CAzdIN0xOgIV0jvvVtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtJrBQsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA02BC433C7;
	Thu, 11 Apr 2024 05:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814208;
	bh=Ppq489d3kgP23QUKTdPgMw60F9L/3oiXpl7j50kX9JM=;
	h=From:To:Cc:Subject:Date:From;
	b=NtJrBQsft+w/4IyuEYPDh5ZO9t+Kpl4ZbpmbSIqqBEhK5SfMaB/ABhbZCPvJUcnoU
	 HTRIB1HhxPq4fJaWpyW0mCQKK3tHv9lz4oixPcfpi1HJtvnS7Q+YoqqKxzc+/wEgZ2
	 FfOm3EuldkU3SFCrRGzJpRTBr1ajMCQTpxJZXP15cLTVCed1YIR9r/hcZAsovhjPes
	 ZGYrTShehlAie54p6BbO8Z3T4ggph5qcGlQOsRkuoQLlU3KIRsfYeYt9/mfGy46K1/
	 MCVVEvzDVG7fymMQHN19RKb/8nY0CTMuQ/APRI7xvPANdOrFbm+Z2aVwYZh9cYGhSI
	 w7TMA8kwQ3I3Q==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] export send_recv_data
Date: Thu, 11 Apr 2024 13:43:10 +0800
Message-Id: <cover.1712813933.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - address Martin's comments for v4 (thanks).
 - update patch 2, use 'return err' instead of 'return -1/0'.
 - drop patch 3 in v4.

v4:
 - fix a bug in v3, it should be 'if (err)', not 'if (!err)'.
 - move "selftests/bpf: Use log_err in network_helpers" out of this
   series.

v3:
 - add two more patches.
 - use log_err instead of ASSERT in v3.
 - let send_recv_data return int as Martin suggested.

v2:

Address Martin's comments for v1 (thanks.)
 - drop patch 1, "export send_byte helper".
 - drop "WRITE_ONCE(arg.stop, 0)".
 - rebased.

send_recv_data will be re-used in MPTCP bpf tests, but not included
in this set because it depends on other patches that have not been
in the bpf-next yet. It will be sent as another set soon.

Geliang Tang (2):
  selftests/bpf: Add struct send_recv_arg
  selftests/bpf: Export send_recv_data helper

 tools/testing/selftests/bpf/network_helpers.c | 96 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 71 +-------------
 3 files changed, 98 insertions(+), 70 deletions(-)

-- 
2.40.1


