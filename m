Return-Path: <linux-kselftest+bounces-29462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4AA69A24
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F5C467513
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F89210185;
	Wed, 19 Mar 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rMCUHIYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C933985;
	Wed, 19 Mar 2025 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415727; cv=none; b=JQEDrNeq9tleV5iTXJZeB8Srrbtp556vfoqnWCfM+Ay+qRXP8+lf9USgEDdx9q9CMVDaZKwP/1yMVlhZk+JO44V2jRBXrjWfwrGLx3YXpiUbtXjbgeeRPng9OP98fdgvGEzuI7cDHS6jJ/VzzFrszpnSHALV9qeeMLZNXvb0Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415727; c=relaxed/simple;
	bh=8jCk/9j4ZNMyGh80zLlWEqEC/MCFti+IC7mQX0FumQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+VrvnKgUdKnRjkX+BZJn5Doe6Hk5Rt/CF9uRB9eTAJWddIsObIOsWcQJlb/q0mSh3+VNe1YjUv13DMSuoJSwH/mjGmrEmwJB0JxxTb+H5tWbs0kSLRs6a8JE2184HO9OvsXMGSxDtqSZWzRTt+JJK1S1AJcs9d/2pgfOjrZY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rMCUHIYR; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1742415718;
	bh=8jCk/9j4ZNMyGh80zLlWEqEC/MCFti+IC7mQX0FumQY=;
	h=From:To:Cc:Subject:Date:From;
	b=rMCUHIYR0El5fvMjc3VhPpSEtL85Ya0Lmv+2Se45rRuQr7N/7vobl632C0A/qDKbk
	 cdHBTYP76J3Fw6QWg/ou8xqilRNTssBAZKnGr8bV4v142HcC3fLKxw5/nZFrSQmzqm
	 OzF9P82664wTq2fbxfD5681KKW+Vx/RbQ7X7e7giEW2WlKHYHktq75JPoezd5st0P8
	 PbIIYdHIPhwGQpYu5Gp69B3UHKtsuS9w/og02hSeiWCu2jQrwBc/BSGxQC+qI3ZbcC
	 JC6TQnaEAW0ZKwLzunLrnZ07yiJMSo8mtMUJVuPAZyS2E3XavxQgZFhqqUKke4V3IX
	 evtx6vCbBj/qA==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZJ0VZ5fcNz170t;
	Wed, 19 Mar 2025 16:21:58 -0400 (EDT)
From: Michael Jeanson <mjeanson@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
	Mark Brown <broonie@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] rseq/selftests: fix name clash with rseq UAPI header
Date: Wed, 19 Mar 2025 16:21:39 -0400
Message-ID: <20250319202144.1141542-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the rseq UAPI header is included 'union rseq' clashes with 'struct
rseq', it's not the case in the rseq selftests but it does break the KVM
selftests that also include this file.

Rename 'union rseq' to 'union rseq_tls' to fix this.

Fixes: e6644c967d3c ("rseq/selftests: Ensure the rseq ABI TLS is actually 1024 bytes")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 6d8997d815ef..663a9cef1952 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -75,13 +75,13 @@ static int rseq_ownership;
  * Use a union to ensure we allocate a TLS area of 1024 bytes to accomodate an
  * rseq registration that is larger than the current rseq ABI.
  */
-union rseq {
+union rseq_tls {
 	struct rseq_abi abi;
 	char dummy[RSEQ_THREAD_AREA_ALLOC_SIZE];
 };
 
 static
-__thread union rseq __rseq __attribute__((tls_model("initial-exec"))) = {
+__thread union rseq_tls __rseq __attribute__((tls_model("initial-exec"))) = {
 	.abi = {
 		.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 	},
-- 
2.43.0


