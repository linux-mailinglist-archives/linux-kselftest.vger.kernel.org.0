Return-Path: <linux-kselftest+bounces-43195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CBBDE97C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 521D35069A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209E32BF54;
	Wed, 15 Oct 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxDj0rjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2832BF4B;
	Wed, 15 Oct 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533135; cv=none; b=nke0uoB5IxpIdpllQTTAEd0qfLfnNsu/kbCrzmzJ1YFUnO5lIhVYnce6FopLB+EyN2PUEkoSFzXKJwSyd9wDhXX1BLETI7t85Bxd5NojKUDJblTt5bj0m36lqvcN5+e/HaqsC+dQ3pI8M3qhtkle6MYGgYmiqtGhngRbokimSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533135; c=relaxed/simple;
	bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6iJlVC9z7OJk4/RVqR5gk4yelc2uak1/Ku9Kz01qU369LO+lGSAQLUJMqKLLhLbIwVnUkq5gUlvIyU1TI5/Ae5G0RfrlhqoRCMfdGwXuq5zS/LYO9IP/cwvPt7DdBjcjmFZfWCYOLMfD+hRfIBV0R+mlN3bge/n3nVxaeohGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxDj0rjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2016DC116C6;
	Wed, 15 Oct 2025 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533134;
	bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YxDj0rjl1UoL3QvB9IYy9Ti+/H5KZrjQG88q/ud5ejEOdDmqABZLQYbwp0IZcmSmS
	 Rgd8siyqxhlITnku6e1mg4zkKk76VjocJCE7Giiuw4c1YwUGWS6yex5f3zMGF2ff+i
	 14o4O5i8gAjksBuF4lYkFcS9vdxKGqEFMbdYCLA2D9SoftxRQB88UXm6GZGwQta/c4
	 hh/jn3bDgaxOHD5FPyIFX4UuK/0F+dVP9uP6D7ontfAXyhleKTcG+iJBHeq131l+IM
	 5XwyvzxPR06amSvKdImHzhvzky96O0L3gpr87qGB/I4IdKE5jJztksgbf/YcpG2m/v
	 PSDaoG0zJJ4TA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:49:09 +0100
Subject: [PATCH v22 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clone3-shadow-stack-v22-5-a8c8da011427@kernel.org>
References: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
In-Reply-To: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75pi+bwCAjbL4SOEMAN8349es/xLtk6I71kCb
 giyMPVZWauJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+aYgAKCRAk1otyXVSH
 0LC7B/9nIx54HlDHNp1nRJ5UhPSuJEQlD7fsJzgs/SiZHKUCElX8sk+hlRBR0vrhPE/QvIk8PVM
 vXoY11V7qjvlrt9kIqZUH3KG+0DqcQcaCK+eIsRZFr304x3oWYeUoYHPosmgOSXKEqexC26mpOR
 +qt5DZ9vdyvm/RTXZ1eaqfdJJDryVUVF1UJ78GJuFngbjDHTH4QbOP17M/1/4Fr47l4BNXCY5vy
 VkzPDQZcCdYaWS/f54g71qWcICi0ocgDFYDMjXfhdLicuQSOZbn6hQMpIRxB5r6hJOsPg6eQ/IC
 8brEdwr3Orwv/FbkVHGRE1fKpmcEgfCKfvEMoKZTa3QKjrWl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index eeca8005723f..939b26c86d42 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -35,8 +35,6 @@ struct __clone_args {
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
-	fflush(stdout);
-	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
 

-- 
2.47.2


