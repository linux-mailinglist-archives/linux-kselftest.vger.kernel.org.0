Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21E5A5798
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2Xck (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2Xcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 19:32:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F48277E;
        Mon, 29 Aug 2022 16:32:38 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so12131211fac.4;
        Mon, 29 Aug 2022 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xoXh8ocpfMOZ1Y+oIk1mmqUrQZ2HCwgZSU9pbCZXcUU=;
        b=dCzoA1XHZW63yGO+g0NNeyXHlrLVSMEuXI+XxWvoAWv8hrm5MQQLoS4ATQJyqWHF7Y
         1XgCiBFAFy7OmGZnH4MrYpcm0+ybF8Q1FK3GMVa0XeVJpEwk/3cwp0cBBFtTcb8Z9ky7
         6R6vNP3dOmvG0/X+rEx44HP5AWw2oWCLUGvtaYe+PDEB5X6U1jY22hNBl47Tc99uDnDi
         xTyWr71EtbHwLFd71njm+6iItgL9ZQ2EhvINQ3/PKQ6c9WfT52i5Xs5LDxfkDaZGncEu
         hvc1ykTGsEAYQmZUzYfbo2kIjRlzNx88h/y47hSPSqrG//5Gm4MMSyW2WApR75duZkNz
         /cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xoXh8ocpfMOZ1Y+oIk1mmqUrQZ2HCwgZSU9pbCZXcUU=;
        b=YYnmyqijnkGfGpLIqaCyiBz1c4z6QH1HK2XzR85eGYtNpHFEmKJicKQYKVjlfdl7Nf
         ScvNxXgkYd/vZjHMPqHwSrp+/ARcIV90EeCPlR9IO7cQ53HoFGdeXUGYd2KDIGmsaQHY
         ruQbmrg3w6hYrbPsuwHGTb6+9Xwx/xBxaRtXWp7dEMnRgfg5WlubPT2SZ/Sn20oF3Upz
         edYwSHpjbFSjhFLQdAs/gGa3vMQE1LgGszkVvFerGEsswrXgTcf3tM6wJQNwQ+C2euiE
         M2uOu2eDRnjuE9My06Cwc4Y4QbLeRsAz+Wb8NDxC/x/ba45an0Te8Pcoz64hsdHmchBX
         1sKQ==
X-Gm-Message-State: ACgBeo0IwBYiykr6GhCTt95/J26DWIZRSf2rgwMZgVhUGblAArSh7dd8
        mios7MllEdO0p5TB6MZP6Hg=
X-Google-Smtp-Source: AA6agR684yaS9cpQNtGRER3KWnVZDAjnT4rlV+8VqYHlWewg0RGeeztZZOTTfFVjVUE1r1qYrPjFgw==
X-Received: by 2002:a05:6870:14c3:b0:fb:46b4:5b3f with SMTP id l3-20020a05687014c300b000fb46b45b3fmr8605594oab.56.1661815956816;
        Mon, 29 Aug 2022 16:32:36 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:dd06:f7b4:b579:6561])
        by smtp.gmail.com with ESMTPSA id bu28-20020a0568300d1c00b0063b24357269sm4183611otb.13.2022.08.29.16.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:32:36 -0700 (PDT)
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
Subject: [PATCH v3 0/2] begin KTAP spec v2 process
Date:   Mon, 29 Aug 2022 18:31:48 -0500
Message-Id: <20220829233150.3564612-1-frowand.list@gmail.com>
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

Changes since patch version 2:
   - correct version 1 change text
   - version 1 patch 2/2 had not yet been applied when I created version 2,
     refresh version 2 patch 2/2 for new context

Changes since patch version 1:
   - drop patch 2/2.  Jonathan Corbet has already applied this patch
     into version 1 of the Specification
   - add new patch 2/2

Frank Rowand (2):
  ktap_v2: change version to 2-rc in KTAP specification
  ktap_v2: change "version 1" to "version 2" in examples

 Documentation/dev-tools/ktap.rst | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

