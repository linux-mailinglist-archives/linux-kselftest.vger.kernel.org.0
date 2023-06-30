Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8167432FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 05:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjF3DRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 23:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjF3DR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110F3596
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b71ee710edso1190998a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=KPAc3EBdnLrZTuhZ0JBA91GkCQdZi1yBfADyAF7KOgyzmnpDl4S+IGni/BtmgUcrH3
         sbgYHnHSeF3KErNlwH76FXcDGpT0YJHsPG42/z5A2rpu6t71HdZ1FdW+/DfA4ASgCAHE
         ryqzVSoM0Cg4D98+NoLyA6oKWkl5NF8mEgGUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=CKfdRjkl6gkHAYHz6unhyFTus8yVvJ9uW+s1J7qgwbCIv6wo6mGLdFcr5Vs/k+Vojq
         vgVDAtkiXmCAIz5dL2wif0FIotba1a5FpRpQdNEVG0rrIoz5fXg/3Yw/5UHQ5Z3RLu7G
         3/MBel9A0oV5i8cBfvYQ1TMBL39Cy8GzBg1h5nUcrIRjGETTS76EKovNlg+mhspaIeRn
         flEcIC6TzrXPogfuM4dw5VO5Lr11oBNMNvdoLZ2AQA8l9RLPX/VKoxG28DdpzqJZzuoz
         nP3BACQTAQSEc/L1P5noLEQuVdShv9KfhK2VIpxAZwgsCLOA/dCPuzXhR84mNBWqObIv
         Kz0g==
X-Gm-Message-State: ABy/qLbiPpIKe7n6Non58Lsx4BTOvp4K5F45ei+9CMNWSKMbpEK9EJvw
        IkwoO+Ra96wbH8yTfBUrf0S47A==
X-Google-Smtp-Source: APBJJlEJphhEXB8Hvzt4GfIdNcqhB5iF/w0ojswIeIzAdwLdkQe+337jwOl6sU6apnlxbfP2RALgMA==
X-Received: by 2002:a05:6359:bb0:b0:134:cb1d:6737 with SMTP id gf48-20020a0563590bb000b00134cb1d6737mr1429484rwb.7.1688095045912;
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id jh2-20020a170903328200b001b3fb1119fdsm3668851plb.297.2023.06.29.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/2] mm/memfd: fix sysctl MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:18 +0000
Message-ID: <20230630031721.623955-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

When sysctl vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported the bug.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

Jeff Xu (2):
  mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
  selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

 mm/memfd.c                                 | 48 +++++++++++-----------
 tools/testing/selftests/memfd/memfd_test.c |  5 +++
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

