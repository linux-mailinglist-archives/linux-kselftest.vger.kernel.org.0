Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74C387068
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 05:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhERD7w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 23:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbhERD7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 23:59:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83809C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 20:58:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g17-20020a056a0023d1b029028f419cb9a2so5301718pfc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hZpHl2/ASaSntMDVPn5eUkTNoD8xr91vTOouWRe1XD8=;
        b=HGtY17basJUdo3ARIIYh7lp8MnVyfaSkoEnivW4/N/54fzep/LLwtwdAnh6RZEXAzE
         HuJs94vp8Cf11qgSxEMKjBV3QXD+yLJBCRJkGnXz81CbBsbEgWk8SNB2IXGfXp4SKpha
         2NrI9MEbXDwWo76vhFH09F0fmwIgKCws8tjJYZWq8UUnSWJvHv4kZ04tPEl1K7LcZ2Tb
         wxSMQnCukshfA+WV/m9AFyX9rOc+GlupdojfwqI7ssQ2PtmTnI9tg+jyJY7ZC+SnhAkZ
         KFH9Y2kXivMPx3/M6FB04DxEsBZtwPuj1NP5jKaK2TC0Nittn1kTE05FJ7MqwVtPibpv
         y9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hZpHl2/ASaSntMDVPn5eUkTNoD8xr91vTOouWRe1XD8=;
        b=ie59XyXJEMDN6BiOiynIq8Upc8XEo2nnF92bDXDnfbgVjmQHgQdk1J7Y02d/HCBBAa
         jEFvyu39IpeGDyJUxfsySz6nOlPBvXctOadGNumUDAMi+qbYwcNA/Mkhopy2EgesASsd
         NFedO/HPKCzW1o1hKDNojcgRgCwMTZj0/OxNljWqEipoOP8iEfqGjtMRiyQXUhn/EDRn
         Wh5kwueM0+M/beNcvc8LtIwUnMOajFc3e+tThtkee0enK/dws3p3npi2q6S76EtlbKxh
         IqwLMvNrVO7rUuWUe7jDlfa94zddft6sQR5SRUH+jgdQEEmYSP/6miSaXeHGWiehtP5o
         1yyA==
X-Gm-Message-State: AOAM530u7y5mUkJCfeTdaHv0qFchpBLCi9gl8VdCAHZ1FNPArh0FHqGH
        teDh9TcWgsTRitzw6KRpqs0R55a5J6w7zw==
X-Google-Smtp-Source: ABdhPJzEXsjaBFMjhdkgCN7Z0kWWinFCwKl9YLkXIM89lkvCy7zbKtgzX68kVr4mq4FG9gGLILfeHvjpeCp+tA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:a1ed:25b5:ddce:462b])
 (user=davidgow job=sendgmr) by 2002:a63:5504:: with SMTP id
 j4mr3016640pgb.238.1621310314025; Mon, 17 May 2021 20:58:34 -0700 (PDT)
Date:   Mon, 17 May 2021 20:58:25 -0700
Message-Id: <20210518035825.1885357-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make the default .kunitconfig (specified in
arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
default. KUNIT_ALL_TESTS runs all tests which have satisfied
dependencies in the current .config (which would be the architecture
defconfig).

Currently, the default .kunitconfig enables only the example tests and
KUnit's own tests. While this does provide a good example of what a
.kunitconfig for running a few individual tests should look like, it
does mean that kunit_tool runs a pretty paltry collection of tests by
default.

A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
instead of 14.

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/configs/kunit_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
index 9235b7d42d38..becf3432a375 100644
--- a/arch/um/configs/kunit_defconfig
+++ b/arch/um/configs/kunit_defconfig
@@ -1,3 +1,2 @@
 CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
-CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
-- 
2.31.1.751.gd2f1c929bd-goog

