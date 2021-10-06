Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC723423C35
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhJFLO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 07:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237952AbhJFLO2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 07:14:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A81FE6109F;
        Wed,  6 Oct 2021 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633518756;
        bh=dQoNTEQYL4mO1SFmtlB5mefAnZVLn9uHE6dcZM60Qjs=;
        h=From:To:Cc:Subject:Date:From;
        b=RqkAFHVXzo8m7rutjI9nGK4gRg49FJmDG6QSbcQru5fflwfreBryWRhVFeAIL/mED
         z3erpDzjRbBcJVc5kbxoqGQBd5bfWjU6JM97FIRgLt+swDbcygMmad6jF8naXnwi7D
         ajij2HC5KDepOSxqzWE+xDr1t4qzl55wUUccGM5tcEWad1fQpxF8ywwDR+aAo0TncH
         2Q+6u6UtJeodXNl+7vj8D2yeY+BTJZZeKDIeVPf5Ol/puGX+KtPjlux9IrQhk1v7CH
         AQ4wyNWM3bL59yHhGzqrq5v6/vfmXdrr5tlwXB0Si6Gbui6XkPmlXkZnXkaUT5kkO8
         X4n4fOwncSAkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH MANUALSEL 5.10 1/7] selftests: KVM: Align SMCCC call with the spec in steal_time
Date:   Wed,  6 Oct 2021 07:12:27 -0400
Message-Id: <20211006111234.264020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Upton <oupton@google.com>

[ Upstream commit 01f91acb55be7aac3950b89c458bcea9ef6e4f49 ]

The SMC64 calling convention passes a function identifier in w0 and its
parameters in x1-x17. Given this, there are two deviations in the
SMC64 call performed by the steal_time test: the function identifier is
assigned to a 64 bit register and the parameter is only 32 bits wide.

Align the call with the SMCCC by using a 32 bit register to handle the
function identifier and increasing the parameter width to 64 bits.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <20210921171121.2148982-3-oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/steal_time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index fcc840088c91..7daedee3e7ee 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -120,12 +120,12 @@ struct st_time {
 	uint64_t st_time;
 };
 
-static int64_t smccc(uint32_t func, uint32_t arg)
+static int64_t smccc(uint32_t func, uint64_t arg)
 {
 	unsigned long ret;
 
 	asm volatile(
-		"mov	x0, %1\n"
+		"mov	w0, %w1\n"
 		"mov	x1, %2\n"
 		"hvc	#0\n"
 		"mov	%0, x0\n"
-- 
2.33.0

