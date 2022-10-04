Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0A5F3FEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJDJjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiJDJir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 05:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5217A89
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Oct 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664876102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5W4TgP7qLbV2GISp4bCgJFOF+0j9YbHTgVp8tbKPbw=;
        b=OIMuhrtVoAPjTnwyKsAYOgk0oHqpd9bCSKkLzkg3bqXTFEv8y+tKmqels2icBFl/WW4YuO
        eU7rsAvR0up1XpBrxY/FegrwXozf0uRKtgu2CBin/DJJBfHNcroAKVYZmQAI7Jf6DadkWy
        U2JCriPX8bzwEXVYsh4h2Gz5WEvfq9Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-xw66hTMUNLKCWaJR_WKDkQ-1; Tue, 04 Oct 2022 05:31:42 -0400
X-MC-Unique: xw66hTMUNLKCWaJR_WKDkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D841C05AAC;
        Tue,  4 Oct 2022 09:31:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98D792166B26;
        Tue,  4 Oct 2022 09:31:40 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: selftests: x86: Use TAP interface in the tsc_msrs_test
Date:   Tue,  4 Oct 2022 11:31:31 +0200
Message-Id: <20221004093131.40392-4-thuth@redhat.com>
In-Reply-To: <20221004093131.40392-1-thuth@redhat.com>
References: <20221004093131.40392-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add some output here so that the user has some feedback
about what is being run.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../testing/selftests/kvm/x86_64/tsc_msrs_test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index 22d366c697f7..c9f67702f657 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -72,11 +72,16 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 
 	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
-		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
-			    uc.args[1] == stage + 1, "Stage %d: Unexpected register values vmexit, got %lx",
-			    stage + 1, (ulong)uc.args[1]);
+		if (!strcmp((const char *)uc.args[0], "hello") &&
+		    uc.args[1] == stage + 1)
+			ksft_test_result_pass("stage %d passed\n", stage + 1);
+		else
+			ksft_test_result_fail(
+				"stage %d: Unexpected register values vmexit, got %lx",
+				stage + 1, (ulong)uc.args[1]);
 		return;
 	case UCALL_DONE:
+		ksft_test_result_pass("stage %d passed\n", stage + 1);
 		return;
 	case UCALL_ABORT:
 		REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
@@ -92,6 +97,9 @@ int main(void)
 	struct kvm_vm *vm;
 	uint64_t val;
 
+	ksft_print_header();
+	ksft_set_plan(5);
+
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	val = 0;
@@ -149,5 +157,5 @@ int main(void)
 
 	kvm_vm_free(vm);
 
-	return 0;
+	ksft_finished();	/* Print results and exit() accordingly */
 }
-- 
2.31.1

