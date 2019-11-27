Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546D810A759
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 01:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK0AKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 19:10:30 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55773 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfK0AK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 19:10:29 -0500
Received: by mail-pf1-f201.google.com with SMTP id o71so1619229pfg.22
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 16:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5j8209s7wyWKdS1J+a/RMwLo3s0bXaXoyBAKaKACgqU=;
        b=sOz/WnOOzGDlwh48N4QMtKoKOE3lKBNSUMpnpOymzACK3shRbuXyHl/6WBEfn1Wb1Z
         qsMjrCZfpr7kr6XuO1/mtZa33hdJB7yx24E6EefYSGnxlB1QdK0jp2bRVEQmmKmEUDKW
         lMnckzt2Obexns9Ze5nschKzqlMM+3kQqDZAZzheas5OMSnTwgoHa/9YL9dIxqNl1TP+
         xSiPBu2VTPXnk4kOeXuMzwKoOFlxVetZaP1og88hGjN4CVIDJ+xuHI6DQqUuvoRxaPYZ
         ZDHIR2Ilyi41pNNAvdKovHJiCtFrPbMNnlH/EWPzCeSYj8Sz5rSRPrUvpRSTRn+0mhFR
         maMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5j8209s7wyWKdS1J+a/RMwLo3s0bXaXoyBAKaKACgqU=;
        b=DJPAlyfgazl5Yb55Fr41SXSzdgWaf7Wmnzc5dtLYuxkw97RVCg9+DzDxnACa/UoJPh
         7vWFJmp74u9X/5j2A1G1QLw9ls7bCxRRqURR1KpCC14+kp/bJrE6zqiccac6aZAlhiiJ
         nT0tW9QOPX/0+H2Hg8eyO/g9wTNU4bpYOvlRjtnr89Pbw3RmL+FT8CbEN37PnZTdEp+V
         cqfFLx0SpPaOsLJGK/aWo4Iu2+KC2cRBPE0uAh6593RXL2gqtZbZgyiKsRRCMJhdLn8g
         2LYjvK2y7AK76lPy02IecUManktkhOp9CrypYARnjh4GE6zKNJr/3hw4XMuzAzSm7NXJ
         RpYA==
X-Gm-Message-State: APjAAAVKmk/G//jWmWltP2XgX2ClUOqqwqy9J7lx2X86qO7C35KV0fWt
        53OJ4xBfzB4QTG/EENLcQi7GoIIsckg=
X-Google-Smtp-Source: APXvYqznTyVgi1L2GWqo1+o7/rn73OMgsdD85PFwMmy3yFo3uQGCoQX75HcSdjNurxp2gLBPb/qv2dxNkpzx
X-Received: by 2002:a65:590f:: with SMTP id f15mr1325328pgu.381.1574813427623;
 Tue, 26 Nov 2019 16:10:27 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:10:23 -0800
Message-Id: <20191127001023.63271-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
From:   Iurii Zaikin <yzaikin@google.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        tytso@mit.edu, geert@linux-m68k.org
Cc:     linux-ext4@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes the issue caused by the fact that in C in the expression
of the form -1234L only 1234L is the actual literal, the unary
minus is an operation applied to the literal. Which means that
to express the lower bound for the type one has to negate the
upper bound and subtract 1.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/inode-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 92a9da1774aa..bbce1c328d85 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -25,7 +25,7 @@
  * For constructing the negative timestamp lower bound value.
  * binary: 10000000 00000000 00000000 00000000
  */
-#define LOWER_MSB_1 (-0x80000000L)
+#define LOWER_MSB_1 (-(UPPER_MSB_0) - 1L)  /* avoid overflow */
 /*
  * For constructing the negative timestamp upper bound value.
  * binary: 11111111 11111111 11111111 11111111
--
2.24.0.432.g9d3f5f5b63-goog
