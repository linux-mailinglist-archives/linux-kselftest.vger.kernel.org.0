Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8E747D22
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 08:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGEGdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjGEGd1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090E10FA
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 23:33:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b74b37fbe0so5298743a34.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=YwXhEKM0bu8FLh1wIz59SqsCgWkobp8aMDaj1CHNsuATyIC4RfmsCuv+E2a0nBcO3E
         WDTMK08X82N1aLjr5w800Rmi5KkdfuSXoG5l/ZsyDV8RgeW0Y9gk8RsRABpvUrPPItNC
         oAJPB8tv5xMpX8RQvRgMYbfppt/cgVN4dJ6u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=UmZ1m7lT5M8h6/pXnl65EkKn4FdkCbvQt8NZBDZkmpk6dpeFZJgPvRpN0Fn72P0Wyh
         4n1u6f7PTpY5gRUIgbymjmTHW8u9CtD+ssReAOPW5BIaH3npzH3DdRvrWtDqB8USZCej
         8NfFsaUnD+7+w5BGXhPpDfL/8HEOa7sxIl48QK796f7z4YHAz4R+gc7NEEOjd2OFDF9v
         jvfueVBLZjJ8OzZCntkny0qUDkuO96llfu9GVi9l2eRVmwTHh8HLWoKlT5PNpk4ejyLn
         IlEG/iX9kW2rbhYMHi84dB2y9jnWEL9yu9gaz9gEpjkU5iluu27yhSxYxO1HVL7RjkcA
         2MXw==
X-Gm-Message-State: ABy/qLbl9bYnHbr3xZU2+97JJuFRyEJRMClW2w8AUu3J+vIb+mTQANuj
        rKnv38gN5PNLeuRGht1+T6/W9Q==
X-Google-Smtp-Source: APBJJlGWMaUVY0TTBQBklTknGLh3stDvEgk0pSskAi32YTtDZEDoFGMo+Ddm6TezqBzUtzqDD1VujQ==
X-Received: by 2002:a05:6870:ac9a:b0:1ad:4d4:34c5 with SMTP id ns26-20020a056870ac9a00b001ad04d434c5mr17360781oab.39.1688538801499;
        Tue, 04 Jul 2023 23:33:21 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id h18-20020a63f912000000b0051b36aee4f6sm17145711pgi.83.2023.07.04.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:20 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:15 +0000
Message-ID: <20230705063315.3680666-3-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230705063315.3680666-1-jeffxu@google.com>
References: <20230705063315.3680666-1-jeffxu@google.com>
MIME-Version: 1.0
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

From: Jeff Xu <jeffxu@google.com>

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Closes: https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..dbdd9ec5e397 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.41.0.255.g8b1d071c50-goog

