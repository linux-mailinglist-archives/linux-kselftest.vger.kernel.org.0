Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D0591892
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 06:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiHMEVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 00:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHMEVJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 00:21:09 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492EDE8E;
        Fri, 12 Aug 2022 21:21:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k2so2605257vsk.8;
        Fri, 12 Aug 2022 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uZlu9FImMQOCgngEdro2RkJDczNeSanNWoFHqqt2XDU=;
        b=jZ1sLF8/1oRBpTJo3Vm1Ga3WCOjT89MvhsuOFvuOER+q+PQNR7TxWabCwllZqPqGqI
         dbnTqdHDc177HL7yr2YHe1ncUu6W3J5GOz9qQvbqH9Pnp4DowtW+fUPopQB/p6/G9DfR
         tSHUXUzpvWIkD0F6IyeIn2YXFeAlcjcBxbsdyp9Sp5iPQrFd5+JNVwIjqNBGPlbGYCdP
         5JR5bwx7MPGr9LvuCF8W1S9wbG1Ox/VJt5W1Q975Jxv04ACfuQ+gyZazlRtmhiakrwkm
         pwjoihXxxpjQSngF1aAGiWA5dxvIMvO6Uds+P092MClzaFJOLtW4YkFWkL1hcaFwQrjz
         lDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uZlu9FImMQOCgngEdro2RkJDczNeSanNWoFHqqt2XDU=;
        b=wGq7yJ7UwAIPOJOlDvFq9dGkoqwcHpv9+s6oqiza/pscFXC2bDM5f+9m5MmJ+8bxrR
         oM7L3Tfqvbovz37rHUDHWlLhX7TkSPpZtEOO6gaQmx/p0SopF+e9AhtbcV/OZb3EmjbH
         eemRa9Ca+v2eUtQ5K7vXaNcjgWYjWNLiX8i9Rbq8dr7qoiTLNkjl6q9FBD1C68PqYgn3
         Kqie529zAhMQPP0wKjg8VBM9m+ih0HAuNlsaxRA7dQ6n2RWsw/wqtsh6Armv33dd6IfN
         sWuj7dG4Mi7UJFhhIEhWRlj7Y4/Ng840xPGUxuGEMhSYgM4A1SgRYvPNIun0gdhy76/6
         q/mw==
X-Gm-Message-State: ACgBeo1gugQQJ4DxpvIpIKWN/jRQQ8uovBkTMCm3YredOMxuRyLiK+Sv
        LtmX8UZQ3dUnySVbW0FB85g=
X-Google-Smtp-Source: AA6agR5jK5Z6FNvJ/2e1MOy/G7GhPGUJbxm53Wc3/khryYD3SeSmrw7Lb/8lqL/d7Q8BQyQuqPn7ZA==
X-Received: by 2002:a67:1a45:0:b0:356:2063:d978 with SMTP id a66-20020a671a45000000b003562063d978mr3300877vsa.41.1660364467291;
        Fri, 12 Aug 2022 21:21:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056102290a00b0038712af0dbesm2434646vsb.22.2022.08.12.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 21:21:06 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        corbet@lwn.net
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Documentation: kunit: fix trivial typo
Date:   Sat, 13 Aug 2022 01:20:52 -0300
Message-Id: <20220813042055.136832-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813042055.136832-1-tales.aparecida@gmail.com>
References: <20220813042055.136832-1-tales.aparecida@gmail.com>
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

Missing closing block-quote

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index cce203138fb7..db1e867820e7 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -30,7 +30,7 @@ We may want to use the following options:
 
 .. code-block::
 
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
 
 - ``--timeout`` sets a maximum amount of time for tests to run.
 - ``--jobs`` sets the number of threads to build the kernel.
-- 
2.37.1

