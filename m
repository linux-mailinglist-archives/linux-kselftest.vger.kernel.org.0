Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7839129569C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895270AbgJVDFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895297AbgJVDFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 23:05:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D528AC0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 20:04:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a12so273378ybc.20
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dNp0qCDPotSmkHaEoVXCuRq3Pqx4VZU0O1ZJ8Iq+U80=;
        b=Ijvo5p1YtmQSPz42T/ZksxA7ocT/E8p6iqrCAQ25+XvYCvcyZOlnxuzDpyTFBTZqXu
         9ZO9gqVDAQlDqddaCPd9AgqElnmfqRfqTuo2rxsp3IHYUyCMT19OHbr2tP4C8DmxVf4k
         EFFZzUdlKz568Rlv1gLhbe8k5oaxCLyHh1UMD/r2mTo7ZBEt0pmp6eczfuqT09278dT+
         BeKptrATUlcPdomiFbKIpiZxU8PCUaTZTjPPUOxUzFaEYAmdyTHzOZw27CgVj6e/U67M
         aiUW4dBXseUUNHaxoCb0BFRjGPtnOyZpNRgf5tNwCmlGiUdfQ7AN9939Skj14nHIgwHp
         /Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dNp0qCDPotSmkHaEoVXCuRq3Pqx4VZU0O1ZJ8Iq+U80=;
        b=Ryx8y9m2nK/MZAAI5fy/wfVZB26xKwo9MvCDaK525VZscj8zhL82B3yKdUaeQAyUhu
         hmHSFsemCnUeCHytwUD1gERxzaA5NQx8tjVSvf9noVbWrRhBu2aO5lmNBo5kAEbIpQVn
         KbhbopqNUu9gAuqORkUjpHunPOB6CO+yuX0NEVagY/qL5IntxFYnZ8INlQXL/u+ddFLV
         GZ5ttvKwY1+e3hjVyq24zR864myqE5XMxZUW/ie5hr5oGGtGfvDjT7flWH8Tp07TCsbW
         g1PiPGcWPzvqI7g96wbKlFd9Nun5UTipFvlKDE3ZHdt9IJbSIZVOQuMYI35Pv1g2KCDo
         10aw==
X-Gm-Message-State: AOAM530Q5TRnovhtrBn2LPeLqNQPkC14UhcPuuF5/BTc8hTTo0EaUe2S
        xAA5vVjtLL1hVZ9kzk8UukBK3TBm/9K9Uw==
X-Google-Smtp-Source: ABdhPJwpfreY8SwQr8opOczLyndMTnkZ5lh/K8xXGCt6Q0pjej5LUqgfqXLk5aIpdYkTPTsno0Xl+V7ku1O9iA==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:324b:: with SMTP id
 y72mr457861yby.451.1603335898937; Wed, 21 Oct 2020 20:04:58 -0700 (PDT)
Date:   Wed, 21 Oct 2020 20:04:55 -0700
Message-Id: <20201022030455.1871987-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kunit: Fix kunit.py --raw_output option
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to the raw_output() function on kunit_parser.py actually being a
generator, it only runs if something reads the lines it returns. Since
we no-longer do that (parsing doesn't actually happen if raw_output is
enabled), it was not printing anything.

Fixes:	45ba7a893ad89114e773b3dc32f6431354c465d6 ("kunit: kunit_tool: Separate out config/build/exec/parse")
Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..744ee9cb0073 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -66,7 +66,6 @@ def isolate_kunit_output(kernel_output):
 def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
-		yield line
 
 DIVIDER = '=' * 60
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

