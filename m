Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0F10E3E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfLAXZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52020 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLAXZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so19832703wme.1;
        Sun, 01 Dec 2019 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BocdlsrLrUjQrAehWv4mAG7o8KdApwLekyWEKiTyhzs=;
        b=eBXBJJOqQsgoShxc0EqW+IxlAtt6JSkE86+RlV4UWRL3wvhD/QVNGqUQlq+RKatXIN
         OJaWLgKWHQzZIqVSHJfKD5aGeNL/DJtCP+Ujro0KfrgyrkaicYPDGtTmPu+ecKvZaQq5
         CfYo1Y1LD1B7HL28modNAOvp+VQdbQcta0UOAfrj3bjHSOyFsHkEXBiDsyTM0C4o8dUW
         ksYeFgSFRR0GJ20AV9OXf76PUpv/P+mnBpvtfbb7LP2uexsMS6kugAaxMQZ2s5m1Y0+M
         LMJzoBZrExLpbu9Bmh6sUs1QrHp6DGogfyZ7+AON6ttWZ7lgKSNnYgBVaSISuQdym98z
         g4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BocdlsrLrUjQrAehWv4mAG7o8KdApwLekyWEKiTyhzs=;
        b=uf3zeO3s+ARlq9UvaX3VuWB0L5npLRk1k8QjFCWraNMxxJuvOtSzLGhRRxBJEiC6Xq
         zRVuGP/tLYpYMM6ZiIroo5V8QLRaRCSTqZfhufe9hz73aHOCTX18kB685BzZJGexRJJq
         u7uWHU/VNfr2zhekg6ber9WruA68q2On5jJ0mHRF3Zz3GedLbxoum2tbdYJe04z83j5G
         yFvt8n+njgeXgchxi2nroGGGTmMdVyzzfRSWcK4eH1oPzVorCs79zQ8nnHTKHvZ5Auy/
         SqW0pD0/bnL9XtyIriWxd27YzPjLeOsnRb/csGNKfx4NDeQBLqssKipxw1JE0IwgVKpf
         4ETw==
X-Gm-Message-State: APjAAAXTnV8zwZ28NE4JFMjflPx3X01FIuvlfQEyZ0+mG7HSAI2Z7Ee0
        KS8bWWqNsqWTTEmVYgGb11w=
X-Google-Smtp-Source: APXvYqzGHaKtd5jorQciodJy8Ctlzb3Zs/Z4kLACV2tH4wQ4fWpw5F0ZIeLXQbhFuz/jigZzYL+RNQ==
X-Received: by 2002:a1c:106:: with SMTP id 6mr24541246wmb.33.1575242745049;
        Sun, 01 Dec 2019 15:25:45 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:44 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 3/6] kunit: Remove duplicated defconfig creation
Date:   Mon,  2 Dec 2019 08:25:21 +0900
Message-Id: <1575242724-4937-4-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d6..f8f2695 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -37,9 +37,6 @@ def create_default_kunitconfig():
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
-- 
2.7.4

