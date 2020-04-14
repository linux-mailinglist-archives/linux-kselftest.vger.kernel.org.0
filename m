Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56FF1A8F36
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 01:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgDNXh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbgDNXh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 19:37:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4AC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 16:37:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c16so6095083qtv.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwPuKmH/oI9C7WlTBDAO1eLLHGw+bPmXi184TkjafU=;
        b=Qi+OXTWR3M+VOoHxKWPFvZq5KUuIF2h5aY2NneEvBrAsN4w6drKvJqKmM4Qi4V+wNO
         a4foeUbOhBpTfOuHkhg1rhG9eeWx7+OuH0t38UfAWlIg73vLjR1Ae60iX+zIpmdEk1Ds
         AJGjsxtxgOm+GdJKjCTtijUR+extToVz7++Nrsm0u+Y3azL19PJdxB7G+v79d229YLlq
         GHz3HxZkVyfPaoLuyWcF0RYCN7z2OKDzE1DzOVMoDXPz5VloK6+xB+uk3vxoD0PLIRkD
         +v0Lu8W/Dx7bnqA0MgicJCwSgsLyjQhm3wGmm9Jz0Mt2F/Wqsd9BEj8g8vVFM7+46HmE
         SxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwPuKmH/oI9C7WlTBDAO1eLLHGw+bPmXi184TkjafU=;
        b=gRtPvczcZclRkC1ZDVpWUblS9OhypIVJbRzNDSjTZ7l9IEsN8OGSpPun0eOil5bHNe
         sjyB1jdZISLalnIi9e0i/6dUIiYknNMyaf7qKq0co9YOYam8U7Ebe8fLbShA4ZAqmHjO
         qBl7FGezwnX8wWj12wo6BiXdg0reRAk/hK//OyXMg1wmHkOZa9olp5i5smFXEF35GCA7
         XL3J2Q1u7gSFiD8z3HepwMaC71+kh6NCygeEZ6RpvzTh5ZBzSIIkPraXz8vNlaTPpblh
         few0AIeXoEFbn1cU4qixZWO3IQCgUQENXTSePGETWh+N46njZO+Bdo+DiyxhGWcYVLQT
         PyRg==
X-Gm-Message-State: AGi0PuYKcexHHEy6k0Kvnorr6hSfGPCxKOcLgQolnqI+1iyjVFQZ69Md
        3f9DC8ifnm5ZNAa85FJxmAqJKkwhGCGLnQ==
X-Google-Smtp-Source: APiQypLEBpL7JFRTA08Ptl1zvEP1uFukp86z+t4gdFHAskwsDaP5zrTML7sftc0mtMkzp3eCIpX0gQ==
X-Received: by 2002:ac8:45da:: with SMTP id e26mr8533094qto.337.1586907477413;
        Tue, 14 Apr 2020 16:37:57 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id h128sm11333859qkd.17.2020.04.14.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:37:56 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: use KUnit defconfig by default
Date:   Tue, 14 Apr 2020 20:37:53 -0300
Message-Id: <20200414233753.94978-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To improve the usability of KUnit, defconfig is used
by default if no kunitconfig is present.

 * https://bugzilla.kernel.org/show_bug.cgi?id=205259

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 tools/testing/kunit/kunit.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..4b98f6e75e4c 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -23,8 +23,8 @@ import kunit_parser
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'defconfig',
-					   'alltests', 'make_options'])
+					   'build_dir', 'alltests',
+					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -118,10 +118,6 @@ def main(argv, linux=None):
 				'directory.',
 				type=str, default='', metavar='build_dir')
 
-	run_parser.add_argument('--defconfig',
-				help='Uses a default .kunitconfig.',
-				action='store_true')
-
 	run_parser.add_argument('--alltests',
 				help='Run all KUnit tests through allyesconfig',
 				action='store_true')
@@ -143,8 +139,7 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
-		if cli_args.defconfig:
-			create_default_kunitconfig()
+		create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -153,7 +148,6 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig,
 				       cli_args.alltests,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
-- 
2.25.1

