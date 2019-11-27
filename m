Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682B810A790
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0AhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 19:37:24 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54818 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfK0AhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 19:37:24 -0500
Received: by mail-qt1-f201.google.com with SMTP id r12so13651451qtp.21
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kDJP03s8s8T9Vmv8o/f6MTS/LgroUMLjoGB1CZ2BzSI=;
        b=H4ljBdij21KypDxw//C1Oqw1ZUz5l+ZxCH1qIFJX/wMZ/YUyLYLJMqVqvk78lIYfXH
         xB8gkircyK8b1+mUTYRhFZyu85C8xkr2zGuMoW+LLSY/AvhjjDLiCVOpggz+T9M2Ugw8
         cCokicxmEeRktS0w7yCEd9bTdCdTrWm1XfCO/dF5aPfeSTD+UAHzGy0xBiX9iGvVxYOm
         YgWKD/pL0EuDfTB+/WuAz7py5ZlzL1KjM4X/Rg5HVgl086txLy36rKGzuFMYLYyGWRT+
         KWLH4AOuC8+U4DTRaa6Js3d7pNS3O2jUv/CCfTA3LGt6O9vy22ZAziFsEtLFMb2GSZ6j
         aABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kDJP03s8s8T9Vmv8o/f6MTS/LgroUMLjoGB1CZ2BzSI=;
        b=tPlgrf5maiv5Rc5kAUkfRECmznl67XTdwTca0UFO4aaPQiPbV4NOh2O2zliUUrSiJB
         BH0HFu7CuxTsKYGJ50sgVuLpAqI1ZDO2emYnZy+ExouLaMNFeiFrEREkhdZikctRq2gI
         j22mANxXayLJFPzT0bWGAUBMjEXyxCwG1hJ+J47o6A5sUX6wtf2dnKzZIWhK3KIY5nY4
         UZop9hduH7If+h4VXU6V7Pt+6xiR7NmaNy0Qtioj62rfFwxFKmiQx3/kmrL74q4UKcAB
         WGPf6JPqFC/pMgjmi+Fj6/5djuPDvttRYZ4WifzDlpasMIJz86uXYiHCJKWfyIjxaKgN
         1Bng==
X-Gm-Message-State: APjAAAWpaiIbYZfC3gQkUwX1I874c5CIuZ5s+G5q2LvUthWLNT1MFcEB
        m46lPCreNbZ5kPWdu2oCJ15tlMrVdoU=
X-Google-Smtp-Source: APXvYqxnf7Zk9iRXiPguDd1hC8mrvt7yS3lTSrT2kR8ANqLHZNS4+q3rKgHlyR+WgtAWJYxZSH4X+VGf+D/A
X-Received: by 2002:a37:b703:: with SMTP id h3mr1345799qkf.79.1574815042647;
 Tue, 26 Nov 2019 16:37:22 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:37:15 -0800
Message-Id: <20191127003715.108479-1-yzaikin@google.com>
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
Original error:
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == -2147483648
timestamp.tv_sec == 2147483648
1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: msb:1
lower_bound:1 extra_bits: 0
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 2147483648
timestamp.tv_sec == 6442450944
2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on:
msb:1 lower_bound:1 extra_bits: 1
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 6442450944
timestamp.tv_sec == 10737418240
2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on:
msb:1 lower_bound:1 extra_bits: 2
not ok 1 - inode_test_xtimestamp_decoding
not ok 1 - ext4_inode_test

Reported-by: Geert Uytterhoeven geert@linux-m68k.org
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
