Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E451B2F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379803AbiEDW6j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379754AbiEDW5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 18:57:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22D53A64;
        Wed,  4 May 2022 15:52:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id c125so3053592iof.9;
        Wed, 04 May 2022 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yECAIQpVJu3JU/pGNaIuw7xSCvhNujVf2mLOqXUlas=;
        b=CGY48g7LDIwrxmADUwlOZtS9Wuf0SYUAqOrZ9BasTt7ZJ9tTTeIkGuUxAO5Sl/sIn1
         y9Y6irebmgIp4PCpAzz0jinfWLs5g/gj2VoqFRQw4S4nv7LddF4l8pTVg/BQ9cpPfpDd
         LmjOfVPFvivNNPAwCZdjSqYKZcTorfM9FDpwz5MjLcr3cSWx0l7cRoQnBLZtAMyxAZQA
         Xk4aWCWPzwNhKnUYPeZ2eAv6Je1OV9XzLhddTQ5nvUA3+qMjHo2B++HZSH7VkU/BZlYb
         XK9KRk5mRLuex9xxjgpx6OFr8x9SiKEooCF8ARWGi24rvvel+jXdlrnCwIskIu13hAVF
         Ku6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yECAIQpVJu3JU/pGNaIuw7xSCvhNujVf2mLOqXUlas=;
        b=G6cfWq5YXhYQ/MgmYEXD5Yne8wdakgLRzseRR2pYJPaQ4OCwkov26L4QA1A0G1Wptb
         hsHGiPGXEo+Tl23Q62u9X0LP8M9Xs6aDxHc74tF2S84iri1c2QZev/lgGiPEdx/KEsM7
         lIc6k2KU3oEDp2YDy82z6xYRge7tvdPzv3ThocqRiQmFGhAVxKHanlOyLo5AjsZAkd0b
         LkNNkw6Ds+Tf+kB5HckQdKB25tFsB0SkTzSFdgggMDVi3iChCW13rSgeExnKPUGCmLdQ
         JDSC9Bo0UME3W8/WgQkBXetC5xH74NRiXNaDPv5T9qSWWQUjyGnp2pr41jS9IXtZtRWu
         RLQA==
X-Gm-Message-State: AOAM532/8lWmPkvSjz0edacOpgQKiQM1UwontEAe709RCtspyaA1Zx1g
        zhiWqr0CmUodFiG87E7xqIA=
X-Google-Smtp-Source: ABdhPJxnAWQpfsmSZqFrknjlSk2A6xtbXqmlrrzpyFWqHtAyHnWVW1cVZBGNUO0IuuNuZ/Wee5QP0Q==
X-Received: by 2002:a05:6602:2d0d:b0:659:aa9e:95a0 with SMTP id c13-20020a0566022d0d00b00659aa9e95a0mr9104400iow.106.1651704719875;
        Wed, 04 May 2022 15:51:59 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:94d4:5fe2:e117:e7c3])
        by smtp.gmail.com with ESMTPSA id i25-20020a02b699000000b0032b608e2926sm66372jam.9.2022.05.04.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:51:59 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] begin KTAP spec v2 process
Date:   Wed,  4 May 2022 17:51:50 -0500
Message-Id: <20220504225152.1451440-1-frowand.list@gmail.com>
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

The process to create version 2 of the KTAP Specification is documented
in email discussions.  I am attempting to capture this information at

   https://elinux.org/Test_Results_Format_Notes#KTAP_version_2

I am already not following the suggested process, which says:
"...please try to follow this principal of one major topic per email
thread."  I think that is ok in this case because the two patches
are related and (hopefully) not controversial.

Changes since patch version 1:
   - drop patch 1/2.  Jonathan Corbet has already applied this patch
     into version 1 of the Specification
   - rename patch 2/2 to patch 1/2, with updated patch comment
   - add new patch 2/2

Frank Rowand (2):
  ktap_v2: change version to 2-rc in KTAP specification
  ktap_v2: change "version 1" to "version 2" in examples

 Documentation/dev-tools/ktap.rst | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

