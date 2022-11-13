Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8812626F55
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Nov 2022 12:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiKMLqr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Nov 2022 06:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Nov 2022 06:46:45 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5792B1FE;
        Sun, 13 Nov 2022 03:46:43 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso7630296wmb.0;
        Sun, 13 Nov 2022 03:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgLDEPBAsaqSd32xdssMnO2SIr7s6T8Rai6MM1Udg1w=;
        b=zA8lqqBDAQp4F662bQitbN5nT5/Rc5iUKJtXbiojzeTVgisPcK/WYeTHKpjEvSzVek
         WzvDGvVOn186miUfxpMy4dJ+IGsaBolVrYhg/DzZ5mr08lh6VKGMUH8shZfEM/7Bejzj
         i+TxkqryPvZUnkLdiUqhxH+BX6TTzsGiv1H6P1ALYYDYc6YhRT7EaV6P/LXCqjel9V6z
         /37Gg1n51rRoLybQ0mJCauKxWBj2xO1wQLmb90vavCk3GgfUrSGxf5w3m0nlruMYItfS
         1E01Ko+3ofMqMTMft6+YzpsUzBwiBSZaGqZknTDoTtvFDJAqhTpGgOKxf1B5k3+Mgmla
         jXzw==
X-Gm-Message-State: ANoB5pnLL0Mn2iljztFTUuCVjoQ0k771PoBJykE8ZMsiSjzFgjYvuvGS
        6js64SI1/kUGQXutNMYXknc=
X-Google-Smtp-Source: AA0mqf5B1N6a18eU383YCZU1EaWR5KFenAxcLsdu6//CnAXFKk60213F0hAbvbglyCCqTm2vXIJtHQ==
X-Received: by 2002:a05:600c:4b07:b0:3cf:7267:5b40 with SMTP id i7-20020a05600c4b0700b003cf72675b40mr5661772wmp.164.1668340002304;
        Sun, 13 Nov 2022 03:46:42 -0800 (PST)
Received: from localhost ([2a00:23c8:6c0c:ff01:8fbf:89fd:a697:2959])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003cf54b77bfesm15808803wms.28.2022.11.13.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:46:41 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, cgroups@vger.kernel.org
Cc:     leit@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/cgroup: Fix gathering number of CPUs
Date:   Sun, 13 Nov 2022 11:44:49 +0000
Message-Id: <20221113114449.18693-1-leitao@debian.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_cpuset_prs.sh is failing with the following error:

	test_cpuset_prs.sh: line 29: [[: 8
	57%: syntax error in expression (error token is "57%")

This is happening because `lscpu | grep "^CPU(s)"` returns two lines in
some systems (such as Debian unstable):

	# lscpu | grep "^CPU(s)"
	CPU(s):                          8
	CPU(s) scaling MHz:              55%

This is a simple fix that discard the second line.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 526d2c42d870..564ca8c33035 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -25,7 +25,7 @@ WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
 CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
 [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
 
-CPUS=$(lscpu | grep "^CPU(s)" | sed -e "s/.*:[[:space:]]*//")
+CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
 [[ $CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
 
 # Set verbose flag and delay factor
-- 
2.38.1

