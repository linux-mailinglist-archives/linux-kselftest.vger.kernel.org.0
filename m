Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8DE4B0367
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 03:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiBJCf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 21:35:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBJCfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 21:35:25 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054A0237D2;
        Wed,  9 Feb 2022 18:35:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e16so3788369qtq.6;
        Wed, 09 Feb 2022 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bASadt8NPcaMyIfVbaEV3zmrrOqc23Hli0FVTIqLwpc=;
        b=oJvVNeu1k9LLF+R+qFr1ICVHqCAgAzC3jSsE2jkw8RFSFq6rw9a7dFDrY3EbM+3EqZ
         jQRZ7rt+kRoYgfN6i3fkETP78iqsxd9IG8yt9iOQUqCaackHmIdR1lfO5RfHdoXA/pJL
         U0nUvBULNL7OMkRYV5pJrg88nfA9wSkZHHaRt38DRPpN9XHU5JPmM1p2BKtriHZIIVoF
         Wlxrkf20uvj+gEt13UFYI2emwBQiUR9PqI+U5ZZ7utiBgEUncZ/5c+LOOYgvGKjVbUAN
         VYQnfIDia+Js0HHs+zGu4uoCJ3OipLbsdW8DP2HLR18wPm1P4GA3USksqg2pGXRp9A4T
         2C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bASadt8NPcaMyIfVbaEV3zmrrOqc23Hli0FVTIqLwpc=;
        b=2ioTwgBG0dzCX3fO4TQHT6HbaeM3Z0x6vdMZoTG5gLj39Lel8ebi2ENETf1RE+I5HV
         O5365topyGUVZSMI1XTRya3v3vKusHHLfL+zCzFe1e50Y5QxgZNndIDp9p8Atd/8kMGp
         fjbLgnZCz16KED1LNPTreGtk+nAFlMX6RYjYbKnM0tuqYvbwl81fh2YsjlBbCb+gnf1Y
         u1Fw0SbmHt2Qpz5r911uO1jqopvW1hM5lLk/FDoGM648QDudqd4RqN2VKHKkf5y46tfO
         +tc37lF8D7Z4Ppi+UKjwws0iHO/j9kWy0GN1ZRntcHJXBQPq2XlbrzJr586fA+ymY5P5
         atzg==
X-Gm-Message-State: AOAM532LXaIKKFe5ClKc3tk7IxWZHH1QapPVi1fBfE6sRWpy5mOOgQkO
        n8z/ovXKoIsIDceOxCTkcto=
X-Google-Smtp-Source: ABdhPJx2JlsScS2bO3Ejpe6Zx1f1EETne7V+WEddNOe5JCmAalm8CPrqvbxKQgEyJxCNECGpfDjLzQ==
X-Received: by 2002:a05:622a:5d3:: with SMTP id d19mr3578170qtb.8.1644460527091;
        Wed, 09 Feb 2022 18:35:27 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h11sm1333374qkp.89.2022.02.09.18.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:35:26 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Documentation: dev-tools: clarify KTAP specification wording
Date:   Wed,  9 Feb 2022 20:35:17 -0600
Message-Id: <20220210023519.3221051-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Frank Rowand <frank.rowand@sony.com>

Clarify ambiguous wording in KTAP specification version 1.

Fix build warnings.

Changes since version 3
  - Add Reviewed-by: Shuah Khan
  - Add patch 2/2 to fix build warnings

Frank Rowand (2):
  Documentation: dev-tools: clarify KTAP specification wording
  Documentation: dev-tools: fix KTAP specification build warnings

 Documentation/dev-tools/ktap.rst | 49 +++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

