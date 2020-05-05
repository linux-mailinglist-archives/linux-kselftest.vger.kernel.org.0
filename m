Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263291C532F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgEEK1N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgEEK1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 06:27:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D8C061A41
        for <linux-kselftest@vger.kernel.org>; Tue,  5 May 2020 03:27:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so1038447ljg.8
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4r4BzjDGTO09+pq2qJQzLpsqdYp3d0bmg7xrYt7/0k=;
        b=lxq8UsRbbA6JQHwi8YB41ue072QJ2ffr78bQkb/4GLMC458KwPgtwlcNH+7K8pq11n
         zoraXwhw9eRsviQtxRA+U4dervHMol0BBPlIVzZx/9cforLpLbgmHwtFP+/uBqR3RGfO
         CtucDsTaeq6V+hc8mK3P5FjYNUKYjKxOh5Z7HLpjOgkHftZDtQjx7tCwlFG1zVG1ve/+
         0Jw7mXl/wHOdI9vIPA5gO25bE4K+IakBue0rQ1ZRHihufkCi2AzoV5zH8nZq3YFPz29Y
         H752OVjW1oGHf4ltCmCXrQOYrGKbBDvHs8C0YNfPoKNcnoy1KeslY75+PptWpVM5voKr
         xruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4r4BzjDGTO09+pq2qJQzLpsqdYp3d0bmg7xrYt7/0k=;
        b=By/hy5H5+ZeEkzjt903h0CjKNnbXGUVBSfpRh5ZElPn+D4Qwhf/ur3o5BecKx1tUSl
         exmJwLs817tLHS1c71O+0y74/Xd686agKnTJSuyegbjkshPX3XT5dcAj8WQhDozj3yW7
         EoZxFpk6V5d4kQ0xJ13FS2xi4vfEnsLgDwcmOpXljsJ6CF2weM/ScjqDsoCnNn46VZNw
         KmJABu1UP0EO9oXE4SzCi+3TcsVuaTpshjHPVqw1IPo9HlZdYJ11/zfbfR/AAFcZ/oPR
         NplxVKZ0lyryneCf/llZpeQ29fyaNP4XA30Vt/pjmpm0TR+47RjDN1Z4e28ogjfggZ6g
         7/+g==
X-Gm-Message-State: AGi0PuaV+agQfKfvQCtr7BOS9FiQH68tEp5LVWLeFXNRi5wOjVe6CQ/Z
        myEL8sqX+ksvAqasiSX8YbWCqQ==
X-Google-Smtp-Source: APiQypJnEG5pEB+WJjoe6xM1H2pstsQj428JhTG2iNFeTSyXwOzyD5BmMDWHrEub1AqznTCaupW6Lw==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr1390091ljp.95.1588674428941;
        Tue, 05 May 2020 03:27:08 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id j15sm1799172lji.18.2020.05.05.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:08 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 1/6] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
Date:   Tue,  5 May 2020 12:27:00 +0200
Message-Id: <20200505102700.7912-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make it easier to enable all KUnit fragments.  This is needed for kernel
test-systems, so its easy to get all KUnit tests enabled and if new gets
added they will be enabled as well.  Fragments that has to be builtin
will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/kunit/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 95d12e3d6d95..537f37bc8400 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -41,4 +41,10 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_RUN_ALL
+	tristate "KUnit run all test"
+	help
+	  Enables all KUnit tests, if they can be enabled.
+	  That depends on if KUnit is enabled as a module or builtin.
+
 endif # KUNIT
-- 
2.20.1

