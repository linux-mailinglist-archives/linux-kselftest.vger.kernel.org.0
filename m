Return-Path: <linux-kselftest+bounces-3680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2B83FED2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA92840A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2C4D135;
	Mon, 29 Jan 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfZZp4UG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C874D595;
	Mon, 29 Jan 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512162; cv=none; b=uqD34p0D7200SSGZvyEXynX9OaUm9lAypZ6HLJ1Ip0PIGd8sWbZmRQjLPkOsB/CR6nPbxV1SFwDnkVuXTXoTVSDxo7p2rHTv+gJeJD+xmMPkus+HXnv8ka68kDsdNb9btShpdsWhT3wiWNZJwzCQkRNFaXpGV9+0HHNmsvIH5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512162; c=relaxed/simple;
	bh=4mEc0Qdj8MEQ6iNz6e3agbZ+j9n6cXE7nwSZK7b9rsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f9N1zoNzNjVEbVu/AtpOqTvacoZtfxzWajp9+xg1P1Cjxoqe9b45YkhWHEcUUgC5OE+3t4rjsn3LWi6Uedib29kYXB2cJxBn4H2kS8QqhQz8AAK0XBmcqHyRzfelHXL/DqBQVRap3TTPgiyi9i+BEALlN/8TqupLbZVwXKDtXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfZZp4UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32658C433F1;
	Mon, 29 Jan 2024 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706512162;
	bh=4mEc0Qdj8MEQ6iNz6e3agbZ+j9n6cXE7nwSZK7b9rsU=;
	h=From:To:Cc:Subject:Date:From;
	b=pfZZp4UGMmCk9y1osnLgHWar6QF91nskTthvAeMhbA9PY4mhkF/DSF3AkK1YuWs23
	 xrqP3GmlYq1HttD7qBvGhXU/vw//WAaA74Uzb41gneOEnFg8twzILFyUjpLzGOcYdo
	 XwAznMD8miurFqhp96cpe2Z0UlR7Nmo+8DpgFJ3TZUlFJJVMxXWn6BaDLJPUU+b2PN
	 Nfk+RQSZAY2AnJM1THwccl31FHfDY45uGGkfYMoqWc2rHgQWrACvG3aDs5CC+UMVSh
	 piy0v5jFc51yy1mBEz2/9KOTWQId8REClo4iEqPJNBF8FxgznZoW6AMJFJDhpPhf3L
	 2zQHer4TnswbA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/3] Fix make install target for BPF selftests
Date: Mon, 29 Jan 2024 08:09:13 +0100
Message-Id: <20240129070916.1639008-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Here's the fourth try. The "make install" target for the BPF selftests
are missing a bunch of files, which makes the BPF machine flavor fail
(e.g. cpuv4).

This series aims to fix that, but explicitly installing bpftool, all
the BPF programs, and the utilities defined by the TRUNNER_EXTRA_PROGS
for test_progs.

The fact that this series even have a changelog says a lot, but for
those who care:
v4: Added bpftool
v3: Do not use hardcoded file names (Andrii)
v2: Added btf_dump_test_case files

Björn Töpel (3):
  selftests/bpf: Remove incorrect object path
  selftests/bpf: Make install target copy test_progs extra files
  selftests/bpf: Make install target copy bpftool

 tools/testing/selftests/bpf/Makefile | 31 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)


base-commit: beb53f32698ff9cd0ca442c1f856ea0ecfb82be3
-- 
2.40.1


