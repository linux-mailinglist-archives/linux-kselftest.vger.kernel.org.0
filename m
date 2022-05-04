Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75F51B13E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbiEDVof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358617AbiEDVoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 17:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F032A51E5A
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651700456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMLMeNW+kJ88AcyFjLmDqr2VYEnc9XaJ9YWOPx9/32s=;
        b=a+hgQ5ZUNRDsfDUzQxoCx8RQN26O0TuBFLElEMwcJr6qtbLhDwN+4QOFnh2yP2IB/cVdvt
        v2iaB/RuQf9NbnPh5kLft4/7TSwSbsNArRiitlfZ1h3m1m+hExhXbgTYwfTM1pA+UyG5fJ
        vawL2uupydkCLgksOrtFD2672aca32Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-0II5ikWTMYaSY17X7b4low-1; Wed, 04 May 2022 17:40:53 -0400
X-MC-Unique: 0II5ikWTMYaSY17X7b4low-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 892D18039D7;
        Wed,  4 May 2022 21:40:52 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.8.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A34C40D1B9E;
        Wed,  4 May 2022 21:40:52 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: vm: Makefile: rename TARGETS to VMTARGETS
Date:   Wed,  4 May 2022 17:40:32 -0400
Message-Id: <20220504214032.1283777-1-jsavitz@redhat.com>
In-Reply-To: <20220504213454.1282532-1-jsavitz@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The tools/testing/selftests/vm/Makefile uses the variable TARGETS
internally to generate a list of platform-specific binary build targets
suffixed with _{32,64}. When building the selftests using its own
Makefile directly, such as via the following command run in a kernel
tree:

# make -C tools/testing/selftests install TARGETS="vm"

One receives an error such as the following:

make: Entering directory '/root/linux/tools/testing/selftests'
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[1]: Entering directory '/root/linux'
  INSTALL ./usr/include
make[1]: Leaving directory '/root/linux'
make[1]: Entering directory '/root/linux/tools/testing/selftests/vm'
make[1]: *** No rule to make target 'vm.c', needed by '/root/linux/tools/testing/selftests/vm/vm_64'.  Stop.
make[1]: Leaving directory '/root/linux/tools/testing/selftests/vm'
make: *** [Makefile:175: all] Error 2
make: Leaving directory '/root/linux/tools/testing/selftests'

The TARGETS variable passed to tools/testing/selftests/Makefile collides
with the TARGETS used in tools/testing/selftests/vm/Makefile, so rename
the latter to VMTARGETS, eliminating the collision with no functional
change.

Fixes: f21fda8f6453 ("selftests: vm: pkeys: fix multilib builds for
x86")

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 04a49e876a46..5b1ecd00695b 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -57,9 +57,9 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_prog
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
-TARGETS := protection_keys
-BINARIES_32 := $(TARGETS:%=%_32)
-BINARIES_64 := $(TARGETS:%=%_64)
+VMTARGETS := protection_keys
+BINARIES_32 := $(VMTARGETS:%=%_32)
+BINARIES_64 := $(VMTARGETS:%=%_64)
 
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
@@ -112,7 +112,7 @@ $(BINARIES_32): CFLAGS += -m32 -mxsave
 $(BINARIES_32): LDLIBS += -lrt -ldl -lm
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
-$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-32,$(t))))
+$(foreach t,$(VMTARGETS),$(eval $(call gen-target-rule-32,$(t))))
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
@@ -120,7 +120,7 @@ $(BINARIES_64): CFLAGS += -m64 -mxsave
 $(BINARIES_64): LDLIBS += -lrt -ldl
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
-$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-64,$(t))))
+$(foreach t,$(VMTARGETS),$(eval $(call gen-target-rule-64,$(t))))
 endif
 
 # x86_64 users should be encouraged to install 32-bit libraries
-- 
2.27.0

