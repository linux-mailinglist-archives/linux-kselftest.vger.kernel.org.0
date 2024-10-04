Return-Path: <linux-kselftest+bounces-19053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBD990BEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5953D281151
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE52178FF;
	Fri,  4 Oct 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjIer+bi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810162178EA;
	Fri,  4 Oct 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066126; cv=none; b=qI/LhQ/XBn+jfqLqLLN1SW/y0miGZSj0zvZBiWzNGqBgcWa9mrKnG5dsUONhRMEKySyJr+CGcVq8aZzvXjv3w3m0R2pJlOIBvzLYGhSkW2HkO0roc8q7xZ4WQkNqQghf4dYdFz+XpKbvs9mi0UeZ4ERBO5/Vx+2vxmd2DScc3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066126; c=relaxed/simple;
	bh=OFvuv6szrIgwq/Jr8XcEAfXXd2uT+8hTX91TIsDOwlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjjkwwNDclqKkySY+Utc3nURYRW7uA1+9QHTH+Y0NOPCkPdxX6RbDtkviKpn6I49/UGobD2aDP8sz4dxF3h91iZBr4LP4ASM1CujlAicjrmDg9R3yzdwl5nkBYl2ma98hG96lh3tEjDjYr2nVQ/LnecnPiyGxnE01goo1EkjRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjIer+bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E352AC4CEF5;
	Fri,  4 Oct 2024 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066126;
	bh=OFvuv6szrIgwq/Jr8XcEAfXXd2uT+8hTX91TIsDOwlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjIer+bivlS+ewMBMa8QXncyikylguiV0zZhnjwBE3IAu1RLQuZa5yfmG5k6VTMJk
	 ryQ2p12tDi5Kqu9mZ0PAA5U6ZmfghpYXb5P4804jNuW9bPz6fA+QTxFROrZVrvoLVo
	 P0KlbWrgw66OCDI18mqcRrFwXHlRvmoPYsuV0DavtcXzv9gZJTZt6rBVp817e3MnW1
	 D3QdIkbz5yUtz7EZiu561C/m239j3ztTWtzSGsu7SBYmO/JbuiCS98qAXSgNpnvmOQ
	 z2tjJzBhesP6zibXnSQhE1kfmxxAbs2mBJhiTQb6FV+WEYmZ+wyhCqZpVGFOiqHsY1
	 6SyhmlpM8jJYQ==
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
Subject: [PATCH AUTOSEL 6.10 02/70] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Fri,  4 Oct 2024 14:20:00 -0400
Message-ID: <20241004182200.3670903-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


