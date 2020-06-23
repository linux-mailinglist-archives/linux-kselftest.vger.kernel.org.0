Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92199204519
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgFWAP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:15:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731550AbgFWAP5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O11bai/WfxTMD0Tokzy2Pw6ubRFmjw4OTVAKl7T1ggw=;
        b=EKlOhTxMDdT8dK5dQchLmmAwi/ZpeWE0b7shtI5/ta2YXo3HAvmAPNnloB6ztFgmtaptqU
        ITbKHf7WDAmdNKBaWWDNWqL5a/lddArzuFjj0EKyuIemUtZVqWfPNwVQkeTZzaOB+gcXKE
        O99vt7TFfcbsn+coDQar0aECeyqhlH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372--XcLyiNbOY2WktSFxKBTyQ-1; Mon, 22 Jun 2020 20:15:52 -0400
X-MC-Unique: -XcLyiNbOY2WktSFxKBTyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 925511005512;
        Tue, 23 Jun 2020 00:15:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23F7E60BEC;
        Tue, 23 Jun 2020 00:15:51 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/6] selftests: sigaltstack: do not use ksft_exit_skip after ksft_set_plan
Date:   Mon, 22 Jun 2020 20:15:46 -0400
Message-Id: <20200623001547.22255-6-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Use ksft_test_result_skip when possible, or just bail out if
memory corruption is detected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/sigaltstack/sas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index ad0f8df2ca0a..8934a3766d20 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -71,7 +71,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 	swapcontext(&sc, &uc);
 	ksft_print_msg("%s\n", p->msg);
 	if (!p->flag) {
-		ksft_exit_skip("[RUN]\tAborting\n");
+		ksft_exit_fail_msg("[RUN]\tAborting\n");
 		exit(EXIT_FAILURE);
 	}
 }
@@ -144,7 +144,7 @@ int main(void)
 	err = sigaltstack(&stk, NULL);
 	if (err) {
 		if (errno == EINVAL) {
-			ksft_exit_skip(
+			ksft_test_result_skip(
 				"[NOTE]\tThe running kernel doesn't support SS_AUTODISARM\n");
 			/*
 			 * If test cases for the !SS_AUTODISARM variant were
-- 
2.26.2


