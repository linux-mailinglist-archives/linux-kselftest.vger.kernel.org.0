Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650215A3AE2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH1Cg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 22:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Cg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 22:36:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FC286F3;
        Sat, 27 Aug 2022 19:36:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q63so4798729pga.9;
        Sat, 27 Aug 2022 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Vt0ILN7wMQkAMWEjrtKY9877O8UHxMRMoUBo6n0fbjU=;
        b=FB7n3W0yOW5wxgowSbdgIMg8FvMwKP+AqovJhgMjyArTk58dxRHakZgo2XQ090kyGo
         vWG5v7sg6qxFpJvxHjM3X7kqXVsfKr8HV0KsMHh/P4L+DJSLnGpF2AlvniDZB6vcAsR4
         IPBkUGh95JMdGqhOqhkcZ/9eMIqE3zBFvO+Ov/AXBarhHniKa4ea1mB3w0q2qN+GcpZX
         oYazyQESn1ypsNYjL3Tlaqji3VJ+xxAThYItzjlg/B3Dj0+U91/ZbPzYimLrI7QMimS4
         WwTw2MVwnCikOSP5SiAVdACyMSpNGjONUPs+sdiQPaE76+rQ0RSBX/X9GlmDTFJL3hS7
         S5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Vt0ILN7wMQkAMWEjrtKY9877O8UHxMRMoUBo6n0fbjU=;
        b=azFiUcDws9JcnhhsxwD8yCwafPdMouQWMgp3ASrRZwC+mwEJiOf9wKg17Fu48//wde
         WVE0ZPDYZD4EP6GD4o7JTaeO9Lpm+BJ2djoHKobYC87kuGdtj3RzVBHaE2lmQTqPpQGT
         rHRVxHfyaCcHGw36pXe8dgOC3fFm4GauYVW5zBQaUokfx8DbJCazNnrXa9SKnFMJS0MS
         p7pqKmcd31gJTD92NiGfnhBDMG2mMXE+0Q5LwOeT7O7SwLa4iBxI135ZM/MUKQr+YUKY
         Xv6R8AgC0OWqHQmS02mWdTHswyEZsWZ2q4gJ+ICplwDKy4nUIXF07cWZ3SA+/bBnfWFr
         ADZw==
X-Gm-Message-State: ACgBeo0rBXF6xGhsmnFWPQUZ9JhDBTCF0RB1dr9CbUYWCTd8fFE1g70Q
        0c5IRTyovN5Ky+kmC+3I7HiRbuTJA9U=
X-Google-Smtp-Source: AA6agR4ILNCZ7hj58HTJ4hJaJsskJSrrpogW8J4wBXBKuG7b2ZWK6QWWiPEEvMl+8GLu5BD115pVYg==
X-Received: by 2002:a05:6a00:26e2:b0:538:23a6:4d62 with SMTP id p34-20020a056a0026e200b0053823a64d62mr631612pfw.26.1661654185390;
        Sat, 27 Aug 2022 19:36:25 -0700 (PDT)
Received: from localhost.localdomain ([106.208.147.142])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b00172dd10f64fsm4368823plg.263.2022.08.27.19.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 19:36:25 -0700 (PDT)
From:   Akhil Raj <lf32.dev@gmail.com>
To:     skhan@linuxfoundation.org, pbonzini@redhat.com, shuah@kernel.org
Cc:     Akhil Raj <lf32.dev@gmail.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm/rseq_test.c:Correct gettid func name kselftest
Date:   Sun, 28 Aug 2022 08:06:00 +0530
Message-Id: <20220828023600.3914-1-lf32.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I got the following error message when I ran

make kselftest summary=1 TARGETS=kvm

rseq_test.c: In function ‘main’:
rseq_test.c:230:33: warning: implicit declaration of function ‘gettid’;
 did you mean ‘getgid’? [-Wimplicit-function-declaration]
          (void *)(unsigned long)gettid());
                                 ^~~~~~
                                 getgid
/tmp/ccNexT4G.o: In function `main':
linux_mainline/tools/testing/selftests/kvm/rseq_test.c:230:
	undefined reference to `gettid'
collect2: error: ld returned 1 exit status
../lib.mk:136:
	recipe for target 'linux_mainline/tools/testing/selftests/kvm/rseq_test' failed

As per suggestion

I renamed gettid to getgid

after rerunning the kselftest command

the following selftests messages were returned

not ok 7 selftests: kvm: hyperv_clock # exit=254
not ok 11 selftests: kvm: kvm_clock_test # exit=254
not ok 51 selftests: kvm: access_tracking_perf_test # exit=254
not ok 53 selftests: kvm: dirty_log_test # exit=254
not ok 58 selftests: kvm: max_guest_memory_test # TIMEOUT 120 seconds
not ok 60 selftests: kvm: memslot_perf_test # exit=142

Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index fac248a43666..aa83a0537f0c 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -227,7 +227,7 @@ int main(int argc, char *argv[])
 	ucall_init(vm, NULL);
 
 	pthread_create(&migration_thread, NULL, migration_worker,
-		       (void *)(unsigned long)gettid());
+		       (void *)(unsigned long)getgid());
 
 	for (i = 0; !done; i++) {
 		vcpu_run(vcpu);
-- 
2.17.1

