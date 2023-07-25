Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA8761D6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGYPdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGYPdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:33:52 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4F1FD2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 08:33:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3463955e8c6so3794205ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690299230; x=1690904030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psCANlN8ACjqTR5+3XCODQFlRe+14Lhpu8FtMgSALfM=;
        b=XwyLWIwxqnXL7pdpixAZ7q7aZfXrtB5N3jrb9CGtJQgmoaMsAFjc824pcQav2Y8nFz
         dN9U2IHD3t3dFCcUkGiv9g6fRURFGoyvqHGwYrax1UqC+4ubXYd6IgxqMJptSbhO53Ki
         hXI7K1tKTwyp2MagRqI+xh6QKutgKA+929GC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299230; x=1690904030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psCANlN8ACjqTR5+3XCODQFlRe+14Lhpu8FtMgSALfM=;
        b=djyDp2VTvZFyKa9T53ORjf4uj+waQMV3d9yWPEw9kjKwo5zIYh7edrmcoSvfPsYz4f
         Sew5f3W8IgMIgvE3lfI04FYlSst4jQv5XIEl5p1gEit3bYNNV7QnaIXMfzuVArV5T66l
         /r8QbFretV2eoP39PTs7ApZUzIsOc797+CpilrBXEdfNfHCRO+ccWpxfSF5ZMUdMPiej
         E9isdpwazx0E96alvl2kyk04uir4yUX9qCj1SOq7atQEc7XwSMrmeEymaylgNu3Aac1Z
         lx/xXRqh0gFrnhdVQq1+omVto3Eh/bHa9bqvtTb2oO9LWn2Skdwp74hW4/gOWbuKzK1J
         B51g==
X-Gm-Message-State: ABy/qLaM5Qdg56RbsBBmV6PZRj1fIxqFPmviUhEDKuNFFVEmZaEYDihn
        J5udhEgM5AbagWyjP4AOqb+zdQ==
X-Google-Smtp-Source: APBJJlF7kccJ981q5CKsoJuFOTcAmWiQ82hFVPTu/ZADMUjQKNsZTHiZLqgFuMaVxnjNgiqvLsCSyQ==
X-Received: by 2002:a92:908:0:b0:345:e438:7381 with SMTP id y8-20020a920908000000b00345e4387381mr8802640ilg.2.1690299230778;
        Tue, 25 Jul 2023 08:33:50 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k8-20020a02a708000000b0042b394eb984sm3743384jam.105.2023.07.25.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:33:50 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests:prctl: add set-process-name to .gitignore
Date:   Tue, 25 Jul 2023 09:33:49 -0600
Message-Id: <20230725153349.15048-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
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

Add newly addded set-process-name test to .gitignore

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/prctl/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/prctl/.gitignore b/tools/testing/selftests/prctl/.gitignore
index 7a657b25f686..05d5e31661df 100644
--- a/tools/testing/selftests/prctl/.gitignore
+++ b/tools/testing/selftests/prctl/.gitignore
@@ -3,3 +3,4 @@ disable-tsc-ctxt-sw-stress-test
 disable-tsc-on-off-stress-test
 disable-tsc-test
 set-anon-vma-name-test
+set-process-name
-- 
2.39.2

