Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8194535617
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 May 2022 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiEZWeX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 May 2022 18:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347029AbiEZWeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 May 2022 18:34:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D248E61
        for <linux-kselftest@vger.kernel.org>; Thu, 26 May 2022 15:34:22 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id rj1-20020a17090b3e8100b001e099ea3980so3987039pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 May 2022 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dbycd53wfkFx6wOlXEkeKq8SwIpffLRDpImC05lVbps=;
        b=j+SEgTICldnd/BNzVi+sD0qfYmtFOB70dPvJ9XXrAwUJ3rxqVCeHCkGBYHZ7uMugGw
         RsLQrLCnS0E+oS5rjDsPC6MKuYaSXuomFh7GVRykVXWZ0lhx93/r3ckTobcrRa5AZxZk
         Sd5Eh667uybkWyKhpA5NFw13I8HjlDnvDnh9vuhLH5MOebh1aadDBoD5Zcal4ZxYV0LT
         S/v7ZNF2c224Ll6Yg2xhkX2fwxJShoqxAYZNf32/RM6n99XUWGvig1Bq3lVVfh8GObvj
         psdKBDigEhzO4d84B6dXa2N733ZQTfbo3K7fRU8FuOodJjDDIcSYInblsc1XftrHYoWX
         Pt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dbycd53wfkFx6wOlXEkeKq8SwIpffLRDpImC05lVbps=;
        b=Zzh4YaRDH9T1/SWxz/RcaeFFOWduvrykScgUKJUOHONPidqwPjEwKvxt5UOgSjgSqQ
         YbpBLv4f8Uejlm8j/oTEzrtTPQWYUsoudyIMMXt9JK2eGoZxgMGgntE0sT2+Zox1N7PX
         T34D0vXqKU7dkWdiPzABdAJ+aTKmlFtL4lKGjDB/sSrSAP0yr6aYxFkgF0jQp4BsxJE2
         04UVrh926/eN6nVHNo8dZ918hnwTy4LEfmc67jFSi0u+uF5YUDWF6w9AwMLu3gSWs6P3
         e4WQ+IKw9q+CaXMIzlqlI8SSLEURTxPIQmyN9IsJl3Bfz8stV+JzH3yRlo3o7uNeU407
         6G7g==
X-Gm-Message-State: AOAM533dXBd0gDJlH9GsWTOjKDneOMPi5Ex6LVWXc4/ykE9yTGcraBJf
        Ws1MFa9jGmbSl2afSIUgCuZ3lO0y4DVeWw==
X-Google-Smtp-Source: ABdhPJxB1e3fXG0Ot53wI1nKFx+/5VDP4vCejcIdEzde3KgllVaDKk6peAdB4F6WdN2YyEq+pIVc3TjUgcFuHA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:903:213:b0:162:15c2:e4b5 with SMTP id
 r19-20020a170903021300b0016215c2e4b5mr25653760plh.114.1653604461947; Thu, 26
 May 2022 15:34:21 -0700 (PDT)
Date:   Thu, 26 May 2022 22:34:07 +0000
Message-Id: <20220526223407.1686936-1-zhuyifei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH seccomp] selftests/seccomp: Fix compile warning when CC=clang
From:   YiFei Zhu <zhuyifei@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        llvm@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

clang has -Wconstant-conversion by default, and the constant 0xAAAAAAAAA
(9 As) being converted to an int, which is generally 32 bits, results
in the compile warning:

  clang -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/  -lpthread  seccomp_bpf.c -lcap -o seccomp_bpf
  seccomp_bpf.c:812:67: warning: implicit conversion from 'long' to 'int' changes value from 45812984490 to -1431655766 [-Wconstant-conversion]
          int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
              ~~~~                                                         ^~~~~~~~~~~
  1 warning generated.

-1431655766 is the expected truncation, 0xAAAAAAAA (8 As), so use
this directly in the code to avoid the warning.

Fixes: 3932fcecd962 ("selftests/seccomp: Add test for unknown SECCOMP_RET kill behavior")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 136df5b76319..4ae6c8991307 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -809,7 +809,7 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 		.len = (unsigned short)ARRAY_SIZE(filter_thread),
 		.filter = filter_thread,
 	};
-	int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
+	int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAA;
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-- 
2.36.1.124.g0e6072fb45-goog

