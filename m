Return-Path: <linux-kselftest+bounces-19054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB702990CD7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D521C22ACF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D881FE4B7;
	Fri,  4 Oct 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgT8Kir5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E61FF7D4;
	Fri,  4 Oct 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066306; cv=none; b=Bid6vTPSmHVkL+azhopTdT8AcEiSNfMQX2kXVJ1lgBUsoreeM3XW/y2OZ9CD4sIif3Pw8LkDK5Rr2c4TQcD3DdcBswrfnfLB9JsFMfnnDU9uxOFbs1a2dke8VBY2ghpN6uEtJaJe0VqLrUtA+LYuH6yVP0v78Ix1vupM+XUeQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066306; c=relaxed/simple;
	bh=KsOic2a3PljfEtgIUn6UwwlRbmoV1ZZarkrB9mb7Uf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dw01ac6L6awPBkJ/B8eLseMOiB3x20uQDiOxI1Lx8a7vB62xUJ7OleAIoeaC/oqpDbVteOGzql9+RPsMZJEMhmlWeod4ihP+LxhMOW1C07Ol0Dn9a+akkPYnohsDIWgCZkoLejQ5tHmSBnF2yoUBZS2S9VEvx5QPX+4Y8MPS7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgT8Kir5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E5C4CEC6;
	Fri,  4 Oct 2024 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066306;
	bh=KsOic2a3PljfEtgIUn6UwwlRbmoV1ZZarkrB9mb7Uf8=;
	h=From:To:Cc:Subject:Date:From;
	b=BgT8Kir5tC3sLA4ztOeGnwfdxS4yM0RLuyP4D62OK3fvdgNPfgkyMf40k6KIMG7zH
	 WnBvp80SLmhOPuYA117pTrrPP85l9lsM5PUoeBw3C3fAZedtjEVK2BKA5lzU0iyabp
	 rgroXq8MhrnhZFZMaQu4qvGWLuXWdK2Giem2r7TsdSsA/JWWgjWKxJ0Rim7WQ1P0DU
	 mRDWeq4aZQ1Nb8tZLlKUFOs0vJZgJLXg/SMEn2Pihyv5MOeoY9zn8zLDRHxcQxavy3
	 JV9LSxfWrcYAUHHYKM3w+DTQKYlu9GqGEx6MtccanS9IDgz1lcrdM0BVSzMc5R7Psw
	 BTq0fNXY/Bv6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	shuah@kernel.org,
	andreimatei1@gmail.com,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/58] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Fri,  4 Oct 2024 14:23:34 -0400
Message-ID: <20241004182503.3672477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 589e8270de462..d873da71f1436 100644
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


