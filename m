Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB531FAD0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgFPJuD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPJuC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 05:50:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E706C03E96A
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 02:50:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c3so23980272ybi.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IEOhiucuBJ/KD8n8JX6Fqs7j+NCQAoB88CGBLL1yHLU=;
        b=ON70wM29pNL8PMIrB1afYrBLyKFOeka3Vl5NxJ00ntOpkJGImvXTgMk+hDrT0eo+A6
         takau6hHHwRDZ2ylDPK141S73OaTI+hGqoITLzmDA7LoqPpavV+kekGnh+iVbSOQusSj
         iexRlk84fHEAFEYNqvTon0kOjyh6t97mxbq4WP2oifCi2CUwCEKke0voQb0nIVQ1f2w6
         80kR7g3OT2Z0e3Q2bpeskk/WLnRn5yjamHf6j1pFV6Yb/DXPvJImx1h2M/HmUEubVsSx
         rc1GR8Mpg1xZTFv11/a/pKBxRUOjvHb24ZIrBQBUlhntdz8NOc16MGTplZ8CtVzBTFvO
         fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IEOhiucuBJ/KD8n8JX6Fqs7j+NCQAoB88CGBLL1yHLU=;
        b=VlLkjKGM4/VuN9x+8PYahg0qn02y4XuRltVXUE/ozFD+LaSP1OFe2l+vbhEmzjdAdz
         JW9z0tLIDAe6AXBG7wM+laEyrALVysVMDu4SYJYhk29aOnd0ftx2FqoKH3dm7hcgAPnP
         jfQgmbSFVgJYbpK6DGQUr4NGHalth7X02ECF62camcpR7A2DaBwOUe9jPYaXco3xojWK
         G7OYzT9ZAq7VwqjxAeZiXcNJeU+W0AcNOTr+7vWdpwzcOgW2bwz+L2LToa/8sevOazbY
         HPu7hCjfb0Y5Ttl2YdX/WoyNcrHEaIQOEH1t+7CqTXQStF1PcaMp4DRhmGoUUPBpPct7
         u5CQ==
X-Gm-Message-State: AOAM531LlAzH2aX/OBcbcMTJv6j8BOXht4bmHEHMkicurLcDpvAEV+/t
        MQges+ieNFgiY/ICRmy5UxUZFv6Ofw==
X-Google-Smtp-Source: ABdhPJwI1NfCdqG00Qq++my5I/CvMzNwn79kMguUXhY5VGw1tqdWTsUlT+ft5O8RsGtOI+TwGXbq+Cypyg==
X-Received: by 2002:a25:e795:: with SMTP id e143mr2911433ybh.181.1592301001423;
 Tue, 16 Jun 2020 02:50:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:49:24 +0200
Message-Id: <20200616094924.159539-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] torture: Pass --kmake-arg to all make invocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We need to pass the arguments provided to --kmake-arg to all make
invocations. In particular, the make invocations generating the configs
need to see the final make arguments, e.g. if config variables depend on
particular variables that are passed to make.

For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
compiler that supports KCSAN.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 93e80a42249a..d6e5ce084b1c 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -32,11 +32,11 @@ if test -z "$TORTURE_TRUST_MAKE"
 then
 	make clean > $resdir/Make.clean 2>&1
 fi
-make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
+make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
 cp .config .config.new
-yes '' | make oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
+yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
 configcheck.sh .config $c
-- 
2.27.0.290.gba653c62da-goog

