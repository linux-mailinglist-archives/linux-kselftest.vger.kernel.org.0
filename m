Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71A6838FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjAaWEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaWEF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:04:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E580F5A372
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a25af09000000b0083fa6f15c2fso1758148ybh.16
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bj6yFI+Jqx4F9WsIXvREu+uXXbdhQ0Fh4KScDr1Gho=;
        b=Yn/DMYr0HkaQ+d4cI8Uskhlb1rSHfk1uMJTU4naMoFOq8V1QZB1QaxZX9tgOfeOdjs
         0BvNC169zVEnGQ+AHmX3Ae62I88wPw0i9y3l6TDy1wbEqz/BssqbIrHUUbbHyBtCpfCJ
         TgzwaXHphlxJHfqf3JraFV4m8u46E5aOyFuvLpGwXQC8TLAyzD/Cn3LDpzNPkTMQ31kH
         geknPk+VEX4D5BJqPN2ixvifi+ARrf+mx8QwECDx2e+egyI8CbkFxyOlzuEHzcFDZRez
         MAwIuA0k6FyhScbS4Ge6pKaddUXaey3ZXHTeu9rYhLqlZv/ZI2iNfqaITEWyyfKHcO39
         jDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bj6yFI+Jqx4F9WsIXvREu+uXXbdhQ0Fh4KScDr1Gho=;
        b=z4GkYukVfi4h7SPVELag44Ay9ZuqweQFdDczYovspbHu/uI6Hy9NF9YJrm+fqUQjtb
         yc2is0lu/bVrCmveXGDRKK41rmWVpie6pZf/rrAC9tNLSH1ZS/CeI2EpcpK8+wOGd52m
         iskkRBYGknKgTyV27Ax8EouPEtqsX1lfS2WQxEXmeuqxjs7RJzH6ORQYoUAUv9/3CLh9
         GYopAqFVh4+MzEU5w1TLgbNHB9wwDkakESo3W1iYkQjoq+5cBIRSx44FT2NE5yntGZle
         lbfk6Bsg90YfreYBpnaaXHT+TKanotmz8v2HOGEGu0k/HOSVrsRGYkdAr0d6E7omoMuT
         0y6g==
X-Gm-Message-State: AO0yUKVDApZg4E3zm107dV3tcLEzOMVYL1AnQErbdjE6sV5AaUsfJReM
        h1dR7W1V5/WEN5+EkDbOICNMB9gubA==
X-Google-Smtp-Source: AK7set8Mq08QZGYu9srTtL+/nEcTo9Z66I5nk7TsKTDSJkhM0fKef4gF8SEOL7x++II5Djz5q1eGyW+faw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:6cc4:0:b0:7d4:93ff:959e with SMTP id
 h187-20020a256cc4000000b007d493ff959emr56101ybc.45.1675202643190; Tue, 31 Jan
 2023 14:04:03 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:03:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131220355.1603527-1-rmoar@google.com>
Subject: [PATCH v1 0/3] kunit: fix bugs in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the KUnit debugfs logs have a few issues:
1. The results of parameterized tests don=E2=80=99t show up
2. The order of the lines in the logs is sometimes incorrect
3. There are extra new lines in the logs

This patch series aims to fix these issues.

This is an example of a debugfs log prior to these fixes:

   KTAP version 1

   # Subtest: kunit_status
   1..2
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
   ok 1 kunit_status_set_failure_test
   ok 2 kunit_status_mark_skipped_test
 ok 1 kunit_status

Note there is an extra line and a few of the lines are out of order.

This is the same debugfs log after the fixes:

   KTAP version 1
   # Subtest: kunit_status
   1..2
   ok 1 kunit_status_set_failure_test
   ok 2 kunit_status_mark_skipped_test
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
 ok 4 kunit_status

This is now equivalent to the regular KTAP output for the kunit_status
test.

Thanks!
-Rae

Rae Moar (3):
  kunit: fix bug in debugfs logs of parameterized tests
  kunit: fix bug in the order of lines in debugfs logs
  kunit: fix bug of extra newline characters in debugfs logs

 include/kunit/test.h   |  2 +-
 lib/kunit/debugfs.c    | 13 ++++++++-----
 lib/kunit/kunit-test.c | 36 ++++++++++++++++++++++++------------
 lib/kunit/test.c       | 36 ++++++++++++++++++++++--------------
 4 files changed, 55 insertions(+), 32 deletions(-)


base-commit: 766f4f2514d2d18bcbd60a058188fb502dea5ddf
--=20
2.39.1.456.gfc5497dd1b-goog

