Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852F83C3196
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jul 2021 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhGJCm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 22:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235231AbhGJClm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 22:41:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED4A1613BE;
        Sat, 10 Jul 2021 02:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884737;
        bh=nrRvggJviXFfdy9LsU0DWs5Wxc2DOv6ikzovAtFzfGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niYLsVpJ5/5/9Ufm7f5xudvGUXpEgEivJdfjwk6mHG4cdpr77zjU91GQKmqjZMCDD
         W7CGfTvf+A5U/+9Duej4fsfGswrRgGi0TVlH2q60GnOAzt6pCnMY3e8tr9HuBbbPTq
         N152wOTVxpnEh4KsPV49dGoM8U7F3kfJB7PpUGaHO7PNLy6Wjf2+GV8lV0m2yBp22s
         J3ekLono9Np+34wC3fUJrGS8KniPaMVvJe0LAl647WBdRLKBy1BPejQ7BpiCAFKZyE
         Hyg9QPCPOfaq65t+fVZKelXSndDmxi02cRK5A6um98rWRNFHpO1jg8ODdyS3gPwnGT
         55o5nIgzAOQ0A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Shirisha Ganta <shirisha.ganta1@ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/26] selftests/powerpc: Fix "no_handler" EBB selftest
Date:   Fri,  9 Jul 2021 22:35:54 -0400
Message-Id: <20210710023604.3172486-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023604.3172486-1-sashal@kernel.org>
References: <20210710023604.3172486-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

[ Upstream commit 45677c9aebe926192e59475b35a1ff35ff2d4217 ]

The "no_handler_test" in ebb selftests attempts to read the PMU
registers twice via helper function "dump_ebb_state". First dump is
just before closing of event and the second invocation is done after
closing of the event. The original intention of second
dump_ebb_state was to dump the state of registers at the end of
the test when the counters are frozen. But this will be achieved
with the first call itself since sample period is set to low value
and PMU will be frozen by then. Hence patch removes the
dump which was done before closing of the event.

Reported-by: Shirisha Ganta <shirisha.ganta1@ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com <mailto:rnsastry@linux.ibm.com>>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1621950703-1532-2-git-send-email-atrajeev@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
index 8341d7778d5e..87630d44fb4c 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
@@ -50,8 +50,6 @@ static int no_handler_test(void)
 
 	event_close(&event);
 
-	dump_ebb_state();
-
 	/* The real test is that we never took an EBB at 0x0 */
 
 	return 0;
-- 
2.30.2

