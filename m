Return-Path: <linux-kselftest+bounces-19052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E577B990AE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3B1C22710
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB011DD863;
	Fri,  4 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBqxPggx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290671DACBA;
	Fri,  4 Oct 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065914; cv=none; b=seaSCsIh9svDLzFmPXu8QdK4wzmunAZxwU65JK6PHRFHMDYHS/xuzQH1FYVxw8rD6LCbfmoYKIPgqTY9nYi32wcQPpqqVEcM9T3OC6bWyFjhNBnLYk2nVfoVzKk957zDMmgkRCBbPWBqcWv0aQo2AQoWj2CMdqBXxcwB0UnFxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065914; c=relaxed/simple;
	bh=OFvuv6szrIgwq/Jr8XcEAfXXd2uT+8hTX91TIsDOwlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRMj4vIZvkGedsWNPwKHmwXXzrRbqoUX0h8KnSU9X1aXg6lwtBOoMUW7n7D7tPMbbe5tEFyZQmezA4nDgr9yW5QEVeJHlxAIbi7ve5iimXt7HWCjqGgocPktwdcvKXhrIQHh7ZcE+cNBwZpuXEkWtUXSYVgb2Bbhky5d9SXXFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBqxPggx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6154BC4CEC6;
	Fri,  4 Oct 2024 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065913;
	bh=OFvuv6szrIgwq/Jr8XcEAfXXd2uT+8hTX91TIsDOwlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBqxPggxFQhs3eB+PzhZybo77HpxydUf7/cmDz5YP2a1043rXBKM0ZfmRq9jI+eOj
	 H+xyzuNDMyKYYcYlbBbCQ0MOJNv1Q1v5rjaqeehWxuMv6WYy/zZa9/CfiFXg/ZqF/S
	 bGc9BIXvwqVMzZUtzxfuL3+ddt/mban+oClN2Cv0EOiueMjHXaCBUm/8oYt+9WaAWD
	 a/KWvbvA1LoawrcOMVzrQn1FCc/AoIFtC24hA6Wot8ErSAwYkQ896BMVSX0zl+6A3e
	 NI0evfh5lvYdJK4V3WDe76jaLuyVCgEZ5nVBX0pOlrWsfTLQ+MGhHc0rrMBKplxCE3
	 aqKIGasBnOOqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	shuah@kernel.org,
	shung-hsi.yu@suse.com,
	andreimatei1@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/76] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Fri,  4 Oct 2024 14:16:19 -0400
Message-ID: <20241004181828.3669209-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b8e188f023e07a733b47d5865311ade51878fe40 ]

The assumption of 'in privileged mode reads from uninitialized stack locations
are permitted' is not quite correct since the verifier was probing for read
access rather than write access. Both tests need to be annotated as __success
for privileged and unprivileged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240913191754.13290-6-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_int_ptr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 9fc3fae5cd833..87206803c0255 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -8,7 +8,6 @@
 SEC("socket")
 __description("ARG_PTR_TO_LONG uninitialized")
 __success
-__failure_unpriv __msg_unpriv("invalid indirect read from stack R4 off -16+0 size 8")
 __naked void arg_ptr_to_long_uninitialized(void)
 {
 	asm volatile ("					\
@@ -36,9 +35,7 @@ __naked void arg_ptr_to_long_uninitialized(void)
 
 SEC("socket")
 __description("ARG_PTR_TO_LONG half-uninitialized")
-/* in privileged mode reads from uninitialized stack locations are permitted */
-__success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R4 off -16+4 size 8")
+__success
 __retval(0)
 __naked void ptr_to_long_half_uninitialized(void)
 {
-- 
2.43.0


