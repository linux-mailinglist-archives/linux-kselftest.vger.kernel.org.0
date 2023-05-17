Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E8706498
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjEQJwU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEQJwT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 05:52:19 -0400
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 02:52:17 PDT
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165E40E6
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 02:52:17 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-yiFmWgEMNPO1yR4btlEE4A-1; Wed, 17 May 2023 05:50:31 -0400
X-MC-Unique: yiFmWgEMNPO1yR4btlEE4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5983C0F66B;
        Wed, 17 May 2023 09:50:30 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.45.224.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 808B7492B01;
        Wed, 17 May 2023 09:50:29 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [RESEND PATCH v1] selftests/bpf: Do not use sign-file as testcase
Date:   Wed, 17 May 2023 11:49:46 +0200
Message-Id: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1684316821.git.legion@kernel.org>
In-Reply-To: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
but the utility should not be called as a test. Executing this utility
produces the following error:

selftests: /linux/tools/testing/selftests/bpf: urandom_read
ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read

selftests: /linux/tools/testing/selftests/bpf: sign-file
not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2

Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77a..fd214d1526d4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
-TEST_GEN_FILES += liburandom_read.so
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.33.8

