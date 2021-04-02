Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8834F353036
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDBUWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhDBUWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 16:22:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732AC06178C;
        Fri,  2 Apr 2021 13:22:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so8980720lfb.9;
        Fri, 02 Apr 2021 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuM4xH1nH2MjkVsKxAPd9c0o/UVsSU6PVrCfHekMLP0=;
        b=HGiJplNIiEH49Jc+MlHgbms83lQfmWfQQvLsBsGybACK6X10jxnc1dYwNuuV15UZCX
         jhZP18OliuP+gcBgdvqhkPcbd3k65haQ3WlFQMeLfOGqdptBZYGTEFZF99j0I5pv1P3j
         7ClfoHpOBXfsphKUAz9CKwioYHbBzGASq5cx/VeAOVvjP35FDsbuulQHqQO0OPXsbJXz
         1K9ekdx3MygGIACspecePntZyfNEF9+xXWn9ufGdk1SQvcQSwGRq0qRK0zcl+2cj19z6
         c66yIaQGfx1RF0UzxmsqkgcUTe4CZeTKvthqPorMptIg+zsH3B2RWIfPfQ1ZiMTV3xtf
         HPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuM4xH1nH2MjkVsKxAPd9c0o/UVsSU6PVrCfHekMLP0=;
        b=nMARnsrTq7EH+2M8Yw5noN8+CMxaqiUFQXUPOHqZs4pVs80vJz121s+4XOnlO6XtTP
         2PGVWPS5ToLqGNEHHFhYQdgdjEUPAZqPhIilkucaLADJQwA8IKoWAIfAOkHr41Y+KktP
         BiR/cb1W0D1ATA2C6pp1WJYfiXf36K1AP+XhH06s70MBAFOD9ng6/Vgte4pgPX7vNQCv
         5Ip7/S+xnnTalhv3DBDNG0KQXa8AeCK+GYX30a3Nq8ptj8s4w16bhnz4oZ3Dkt+nbdOc
         /w/cPwnNeDqP9OJgBLKxMU6K1iVOTgU0beA+l7RGFPaGhuNj4RAnp3xCLQRr6YfZQxXr
         ulsQ==
X-Gm-Message-State: AOAM530r0J1Z5ZqV/RrDweNiqtha5jje2aboV9PzFeLxA0plDXDcnbgh
        JlZPKvp2e260Au4RkUEj/RE=
X-Google-Smtp-Source: ABdhPJw4j+0eY/DUzPzdoOF9LRcINRLYxtb4g8ug6Fp5KR0G9M/RO9DMa5S7TgsP7x1z5tA0JXaCjA==
X-Received: by 2002:ac2:57c6:: with SMTP id k6mr9832610lfo.264.1617394970033;
        Fri, 02 Apr 2021 13:22:50 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f11sm952514lfr.119.2021.04.02.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:22:49 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: [PATCH-next 3/5] vm/test_vmalloc.sh: adapt for updated driver interface
Date:   Fri,  2 Apr 2021 22:22:35 +0200
Message-Id: <20210402202237.20334-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210402202237.20334-1-urezki@gmail.com>
References: <20210402202237.20334-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A 'single_cpu_test' parameter is odd and it does not exist
anymore. Instead there was introduced a 'nr_threads' one.
If it is not set it behaves as the former parameter.

That is why update a "stress mode" according to this change
specifying number of workers which are equal to number of CPUs.
Also update an output of help message based on a new interface.

CC: linux-kselftest@vger.kernel.org
CC: Shuah Khan <shuah@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/vm/test_vmalloc.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/test_vmalloc.sh b/tools/testing/selftests/vm/test_vmalloc.sh
index 06d2bb109f06..d73b846736f1 100755
--- a/tools/testing/selftests/vm/test_vmalloc.sh
+++ b/tools/testing/selftests/vm/test_vmalloc.sh
@@ -11,6 +11,7 @@
 
 TEST_NAME="vmalloc"
 DRIVER="test_${TEST_NAME}"
+NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
 
 # 1 if fails
 exitcode=1
@@ -22,9 +23,9 @@ ksft_skip=4
 # Static templates for performance, stressing and smoke tests.
 # Also it is possible to pass any supported parameters manualy.
 #
-PERF_PARAM="single_cpu_test=1 sequential_test_order=1 test_repeat_count=3"
-SMOKE_PARAM="single_cpu_test=1 test_loop_count=10000 test_repeat_count=10"
-STRESS_PARAM="test_repeat_count=20"
+PERF_PARAM="sequential_test_order=1 test_repeat_count=3"
+SMOKE_PARAM="test_loop_count=10000 test_repeat_count=10"
+STRESS_PARAM="nr_threads=$NUM_CPUS test_repeat_count=20"
 
 check_test_requirements()
 {
@@ -58,8 +59,8 @@ run_perfformance_check()
 
 run_stability_check()
 {
-	echo "Run stability tests. In order to stress vmalloc subsystem we run"
-	echo "all available test cases on all available CPUs simultaneously."
+	echo "Run stability tests. In order to stress vmalloc subsystem all"
+	echo "available test cases are run by NUM_CPUS workers simultaneously."
 	echo "It will take time, so be patient."
 
 	modprobe $DRIVER $STRESS_PARAM > /dev/null 2>&1
@@ -92,17 +93,17 @@ usage()
 	echo "# Shows help message"
 	echo "./${DRIVER}.sh"
 	echo
-	echo "# Runs 1 test(id_1), repeats it 5 times on all online CPUs"
-	echo "./${DRIVER}.sh run_test_mask=1 test_repeat_count=5"
+	echo "# Runs 1 test(id_1), repeats it 5 times by NUM_CPUS workers"
+	echo "./${DRIVER}.sh nr_threads=$NUM_CPUS run_test_mask=1 test_repeat_count=5"
 	echo
 	echo -n "# Runs 4 tests(id_1|id_2|id_4|id_16) on one CPU with "
 	echo "sequential order"
-	echo -n "./${DRIVER}.sh single_cpu_test=1 sequential_test_order=1 "
+	echo -n "./${DRIVER}.sh sequential_test_order=1 "
 	echo "run_test_mask=23"
 	echo
-	echo -n "# Runs all tests on all online CPUs, shuffled order, repeats "
+	echo -n "# Runs all tests by NUM_CPUS workers, shuffled order, repeats "
 	echo "20 times"
-	echo "./${DRIVER}.sh test_repeat_count=20"
+	echo "./${DRIVER}.sh nr_threads=$NUM_CPUS test_repeat_count=20"
 	echo
 	echo "# Performance analysis"
 	echo "./${DRIVER}.sh performance"
-- 
2.20.1

