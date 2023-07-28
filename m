Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90ED76735D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjG1R3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjG1R3g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43C2D64
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-7748ca56133so23306039f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565371; x=1691170171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyD41TjCbmVuD3Q46FNMhjbjisbmz8hDWYj37AkUnHk=;
        b=hRWim4l1+IGA137PJlwexSNurfpuER9flcSAxOm4LsJLdw4LW3UU3afJMVs4uU00D3
         1Qt5g/3GnnH930VtMFyQBycmOwkuWCDxTkUfNRg36JNk6CjHSj/4FJQSx52zavvuSDms
         r8tm/WVlJJnSmLy94GGd+gUn1klK5b8ETym7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565371; x=1691170171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyD41TjCbmVuD3Q46FNMhjbjisbmz8hDWYj37AkUnHk=;
        b=mFc/w9ghbcRONybu9yrXQjRONh8z2KZkVtOVibljYZH2pImi4dCdfdSd8hAHg/Jl05
         YAKjmt1tN7UgoVMLzn6qPZB/SidqRLaoIX4XvBV/5Y92grXmGknyxDp953wtXaB5+JQd
         o1YSF8lISANMlLcGmCdrTRpmrSD4tjZrKmi8oYKmWIsocRtKPTHV1XimkT/DOFNo6MG4
         XwoRIysrg2axOAM2NObEL/QOLalgOydr+k9UR6oKMXA3RVR92p2Szu2jhAA2JYbHnB1/
         b5cARg7Uep62d3wOppYE22fCxD/KrNOPw6Wpr473IGhP9Jkx2O6yggSw6IrhZEb9PznW
         Dlqg==
X-Gm-Message-State: ABy/qLagGlaXdAkNRfXAXYd+WupHK/CD9iLGLfv5Y8/crpY4/GPVD5+B
        CX7Hnrb4iWzXrbyp63AnNjs6Qm5Pf0UDL7gpBkQZ69am
X-Google-Smtp-Source: APBJJlEG47QTZ1NoYk+U+Zk7I8oCNRRLU7ElqoKqeRa52rla1kFe15V3Xjtvfnln+NhSRMvp/M6PGg==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr339190iov.1.1690565371630;
        Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, naresh.kamboju@linaro.org,
        kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        lkft-triage@lists.linaro.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 1/3] selftests:connector: Fix Makefile to include KHDR_INCLUDES
Date:   Fri, 28 Jul 2023 11:29:26 -0600
Message-Id: <d0055c8cdf18516db8ba9edec99cfc5c08f32a7c.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test compile fails with following errors. Fix the Makefile
CFLAGS to include KHDR_INCLUDES to pull in uapi defines.

gcc -Wall     proc_filter.c  -o ../tools/testing/selftests/connector/proc_filter
proc_filter.c: In function ‘send_message’:
proc_filter.c:22:33: error: invalid application of ‘sizeof’ to incomplete type ‘struct proc_input’
   22 |                          sizeof(struct proc_input))
      |                                 ^~~~~~
proc_filter.c:42:19: note: in expansion of macro ‘NL_MESSAGE_SIZE’
   42 |         char buff[NL_MESSAGE_SIZE];
      |                   ^~~~~~~~~~~~~~~
proc_filter.c:22:33: error: invalid application of ‘sizeof’ to incomplete type ‘struct proc_input’
   22 |                          sizeof(struct proc_input))
      |                                 ^~~~~~
proc_filter.c:48:34: note: in expansion of macro ‘NL_MESSAGE_SIZE’
   48 |                 hdr->nlmsg_len = NL_MESSAGE_SIZE;
      |                                  ^~~~~~~~~~~~~~~
`

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/all/CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/connector/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
index 21c9f3a973a0..92188b9bac5c 100644
--- a/tools/testing/selftests/connector/Makefile
+++ b/tools/testing/selftests/connector/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall
+CFLAGS += -Wall $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS = proc_filter
 
-- 
2.39.2

