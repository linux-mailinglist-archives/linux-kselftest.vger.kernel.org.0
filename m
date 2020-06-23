Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0C204514
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgFWAPz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:15:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54334 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731507AbgFWAPy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7HNJTlk13FVbVYXxMgg61ehL9LTKqH1Bt/QRg8bcjI=;
        b=Jv2fctdof76YPk7ZBQe3ygj9n676C/r4FJ3tze/JTwbTpmI4NvP/dE+TwiQsNK4oyo8DLH
        4XncBqAypo9fdeW+LJiJEge7I0IYuXgXPRQALn3hjYjsiO//BngiML7mKmaJCg9b4ZefDU
        nf7w6xZgIxIzYDGhMn/FZHk8AGLdOmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-FI_f-5zINEKjNPw_lWEEwg-1; Mon, 22 Jun 2020 20:15:50 -0400
X-MC-Unique: FI_f-5zINEKjNPw_lWEEwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0B9805EE1;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1A260BEC;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/6] selftests: breakpoints: fix computation of test plan
Date:   Mon, 22 Jun 2020 20:15:43 -0400
Message-Id: <20200623001547.22255-3-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The computation of the test plan uses the available_cpus bitset
before calling sched_getaffinity to fill it in.  The resulting
plan is bogus, fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/breakpoints/step_after_suspend_test.c       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b3ead29c6089..983ee6182e25 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -183,6 +183,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
+	if (err < 0)
+		ksft_exit_fail_msg("sched_getaffinity() failed\n");
+
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		if (!CPU_ISSET(cpu, &available_cpus))
 			continue;
@@ -193,10 +197,6 @@ int main(int argc, char **argv)
 	if (do_suspend)
 		suspend();
 
-	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
-	if (err < 0)
-		ksft_exit_fail_msg("sched_getaffinity() failed\n");
-
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		bool test_success;
 
-- 
2.26.2


