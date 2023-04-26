Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D16EFD1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjDZWR6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbjDZWR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 18:17:57 -0400
X-Greylist: delayed 1567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 15:17:56 PDT
Received: from ulthar.dreamlands (wan.azazel.net [81.187.77.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1C30EF;
        Wed, 26 Apr 2023 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9RDxIrsFE6CSMgp+t6u2SnqF6rodTkxLpdhyr3Uhl4E=; b=pSS8nNo5cmCtAEiOHq8OdGbsJv
        nAlWRdHYhxe9YupDYm4M8qbwFr9cbIHx2/YmGIWEMqkZ+egNKDn6ODk9j1RlwnjaocnifIQPKOTTR
        twDTBT/PGX2af2/SoaC61pBPcTpDFjEZ58YqSKtNcYKud/lnVrJrVdjQu28xgTnKsVM8VTo9ViB/5
        uzfmoNKnCs013LPas7Uuj3bSC5hdVDu4lrf5akkmy2nNuSl3dx143jjS7D0GFyac3AfySHMJAzR8t
        yNOBI+YS5GDxU4nvwTnw314l1kQmpWu/+MaHg44XHxooCfwGdc0fV7OIGNzaPYZZ9pTGqCeiGMHq7
        Z5Y54haA==;
Received: from localhost ([::1] helo=ulthar.dreamlands)
        by ulthar.dreamlands.azazel.net with esmtp (Exim 4.96)
        (envelope-from <jeremy@azazel.net>)
        id 1prn23-001kAV-0r;
        Wed, 26 Apr 2023 22:50:35 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: fix pkg-config call building sign-file
Date:   Wed, 26 Apr 2023 22:50:32 +0100
Message-Id: <20230426215032.415792-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on ulthar.dreamlands.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building sign-file, the call to get the CFLAGS for libcrypto is
missing white-space between `pkg-config` and `--cflags`:

  $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null)

Removing the redirection of stderr, we see:

  $ make -C tools/testing/selftests/bpf sign-file
  make: Entering directory '[...]/tools/testing/selftests/bpf'
  make: pkg-config--cflags: No such file or directory
    SIGN-FILE sign-file
  make: Leaving directory '[...]/tools/testing/selftests/bpf'

Add the missing space.

Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77a..ad01c9e1ff12 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -197,7 +197,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
+	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
 		  $< -o $@ \
 		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
-- 
2.39.2

