Return-Path: <linux-kselftest+bounces-48667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35071D0D95C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6BD300F89F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7C27A476;
	Sat, 10 Jan 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDpCNj8k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615F274B59;
	Sat, 10 Jan 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064421; cv=none; b=mQMs5hoePeCskmzElkjnSMHjF09ZJnNpIyug4izGGxb/+8GZ+MzwjkCL/rEKjFbEimvy+zEssQSeUzhaNAalpR7HA91qTgP9kxghg5OUfotTRh5NkPhptC4yBzWjO59SjAB8ngqxZyixZ0LQb4uKZETjDRdBgPpY4bOyY7W4j3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064421; c=relaxed/simple;
	bh=V2EsbQnIGOXbiEaBQhRAkmCEvxvJGLXrXAm5c9fgeXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrFi1Zd7F8jqXJstnqZz+NFYgxDlvlIJPaIr5VGNwkB3Nbdp6ZQKW31AZKVvapsgjEWg7+wgd0HU80GoPJgwD45XCU9aezsHQ/d175n25JSYK5SDgBlPF1XaxA2zzMkAn4eP5yCdVqCzkrSoA1qdOVRMzwIN/pXFj2msuVtdcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDpCNj8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325CDC4CEF1;
	Sat, 10 Jan 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768064421;
	bh=V2EsbQnIGOXbiEaBQhRAkmCEvxvJGLXrXAm5c9fgeXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDpCNj8kZgAWpTJOtgR8EHYMVkM9W990TxrbO5nQHj4I1tnCLZlVyNZ5wc6zzj63a
	 7Z1mEc6jfXOZKMY9WjDQBp+dzJX2atByn3604GYQxnFJFfWnDPY7SPAc+GOwzWhB0/
	 IrpXHMGZnhhBSBLHA75fDXqFecv4rAyamIOvaxf7bmsrEkCWPc9vN2KoZ8HM30bwGO
	 QPszjTas/Si9CzyTXrbWTF69Lwlu4/b8Acgt5R1YD/oREOW9IX+Gj5H6riCJ0gmNgy
	 hyWEp76NVfebHSwa0K0dOuz3dlggJZ2z6hjL0b+fHqnz7/XCIB9VPK4ItofIFwRDLR
	 RhquU7OX72eTA==
From: SeongJae Park <sj@kernel.org>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: ksm_tests: skip when not run as root
Date: Sat, 10 Jan 2026 09:00:10 -0800
Message-ID: <20260110170013.88614-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CABFUUZE50X=PXAK0nFC1qhj4GhZ1FQJ2T2Jf8M0APE6s5-mgvA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 10 Jan 2026 20:44:21 +0800 sun jian <sun.jian.kdev@gmail.com> wrote:

> On Sat, Jan 10, 2026 at 9:16 AM SeongJae Park <sj@kernel.org> wrote:
> > What about using ksft_exit_skip() instead, like compaction_test.c does?
> ksm_tests is a legacy selftest binary and doesn't use kselftest harness/TAP
> APIs. It only includes kselftest.h for the KSFT_* exit codes.
> 
> This patch is a minimal prerequisite fix. Returning KSFT_SKIP already
> provides the correct semantic to the runner, without pulling ksm_tests into the
> harness model, which would be a larger refactor.

I agree such refactoring would be unnecessary for this small change.  But you
can use ksft_exit_skip() without such refactoring, isn't it?  The function is
declared in kselftest.h, not kselftest_harness.h.  ksm_functional_tests.c is
also using ksft_exit_skip() without the harness model.


Thanks,
SJ

[...]

