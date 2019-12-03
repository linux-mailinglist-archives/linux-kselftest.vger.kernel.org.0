Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3240710F9B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLCITT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37032 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCITS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so2385431wmf.2;
        Tue, 03 Dec 2019 00:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=XWJCfFkrPHe1Ba4cyqiTHzY629AzEtC9/bijTztY+Chrta5eejzLI9UnDAqC8O3LeW
         ung4QmEBfsb6D9D14RKydctfEOmEsHEtcuoY99+RUJS33soqYy9JTIxLchAunK8kkpgO
         opaLm2qYdHDUnxrF1v3C2dXBum3OiapGU/EAAlAThDMAHf1iz0j1Y/OcDvKIbN3O9UYp
         XwggjFQpIGqSLcvu/AcpPggCAIBfgJ9uEUoNPRI7l5Oh6l0nzyY0/8hDiKF+56Gc+IBo
         UO1Ig4s030zMF5/PXqqHRmYhOk55Dad/YLhjU2XQ7NRjEFCOaXzYN0JrkUBsaKDPNPBQ
         rLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=BI9EQAUXzajZhsgba7oGrRhFWm6UXaBWD8sn03rAnOWndJdxolzKDvyLr6O9DkLEAw
         DqztR13tnaywHh8WwE+N9MpcMtpwui9gJsiVV55VVjzlyJd3F9AaANwlo1JrDKocVhw+
         N0ory1GUmqIBrf1BRLg0PX6qDrY0WUj0CjXd4AXUmTGpGxh1K7vpiNqciIVxJOwkhpM4
         io9FBtvDlB2P2nFLAxdGj4011Q6pHNSz1oaEYFlUJSchq2g2e/6Es40dL7W5VJcKxW4G
         EBdvss1euilqU7c7OHzQhRJOGkBstOCqR1VFBCpLvI4hMT1u9ivnpKC1HwErTrW6tQbx
         Fyuw==
X-Gm-Message-State: APjAAAUBZLnQvFt0MEY2VEi0XD18FuedU5WilvX32mQfTfMSl2brAGS8
        iiToK+ZC/uR2NlxHjOCoe2g=
X-Google-Smtp-Source: APXvYqwtzqgb604MYHUY923Uhk6K2ccj3q0xJ14ecw55x0JbrMqhaFx9/7cnGm/XmCXNugQzRxFnAg==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr34239551wme.77.1575361156150;
        Tue, 03 Dec 2019 00:19:16 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:15 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de
Subject: [PATCH v2 2/5] kunit: Remove duplicated defconfig creation
Date:   Tue,  3 Dec 2019 17:18:58 +0900
Message-Id: <1575361141-6806-3-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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

