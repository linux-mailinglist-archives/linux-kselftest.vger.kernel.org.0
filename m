Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794DB7975C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjIGPzz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjIGPy2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 11:54:28 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074428699
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Sep 2023 08:43:59 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bdf4752c3cso8595315ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Sep 2023 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101320; x=1694706120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb8EYqnyASMqqsnZ2iLYAah6l2OQpOCqu3iuHke0P/0=;
        b=JZgh4rdhIE/4nK4ZEhDJDlBI7DmTkKoXcugoWmpuLYry7LIb2Y9gFu5yCldeliaJVx
         4aLuIHIMN+T0lurLESK7OCw2SVwDUphl9rXWh0SCu+eku1lAhWeT5+wniyDUBsM6a36S
         8J69AAqIV5dbXi1Vyg1fE432/cxd4tuVow39e/tfsM0SqJfvydzmXHr5bMbG9sL0Ls50
         oSR5yzAfbXLrh2zw0yZR9FW95xCTYpMVCI0/wiz5++5zOm+TK6R0QmZCrCurYoRTQCjD
         i8skEDlYm9wDCXBLhSEP99wgX9/njYJzrEqiOvWscjgcrGaHfjq9RTdjqd+SXDAU3w7r
         Fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101320; x=1694706120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb8EYqnyASMqqsnZ2iLYAah6l2OQpOCqu3iuHke0P/0=;
        b=hA6Bb5KbEbT3WkQTN9X4uuFRFe/T5u6faXo0GCJNWTiYCOZCnmerEa+B8EiEClQo4p
         11Pej58egpcGaIiL1SGGfG4Dvk5pr0V71JIrI3zIe6uf9h8sZ3Gy9Pm+FyUctL3en6od
         a6F37z07UVTsZ1clgQg7ywjyEx+czW0gplnYku7lngS3Ici+HLY+52tcmiv+ZwlNCV3G
         7ZBjJM/0NcDvm77X1KLt7aNyq4yujiYue9sTwSPG1B6HyeRd+TQgSzrUyOSQmO7hTcZL
         /t0UyyhxRU8bES23dsRFX5WgEUGn8bcczjymwlDgFITqNqzOtFmuQVSQATIHwGNkoi8W
         qasQ==
X-Gm-Message-State: AOJu0YzEjfehuacRDwkcCNEf++qlU5jLZV3/mO9jx/pW8pgKKVes9dKV
        2XtGfUAyAzZnC/6+EaCbMcRGsimYB2JywayhLPUgPQ==
X-Google-Smtp-Source: AGHT+IHq9zupsfJmVjaj0Q6U+++liIcrHH5PBFa/Uec0t8DPMoJUynQPWH8/OnfYyZAhvgd1JzqsDg==
X-Received: by 2002:a05:6a20:974f:b0:14c:f4e1:d9e9 with SMTP id hs15-20020a056a20974f00b0014cf4e1d9e9mr15072708pzc.45.1694073771758;
        Thu, 07 Sep 2023 01:02:51 -0700 (PDT)
Received: from localhost.localdomain ([124.123.167.146])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b00689f1ce7dacsm11778001pfe.23.2023.09.07.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:02:50 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, beaub@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: user_events: create test-specific Kconfig fragments
Date:   Thu,  7 Sep 2023 13:32:09 +0530
Message-Id: <20230907080209.223478-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create the config file in user_events directory of testcase which
need more kernel configuration than the default defconfig. User
could use these configs with merge_config.sh script:

The Kconfig CONFIG_USER_EVENTS=y is needed for the test to read
data from the following files,
  - "/sys/kernel/tracing/user_events_data"
  - "/sys/kernel/tracing/user_events_status"
  - "/sys/kernel/tracing/events/user_events/*"

Enable config for specific testcase:
(export ARCH=xxx #for cross compiling)
./scripts/kconfig/merge_config.sh .config \
                tools/testing/selftests/user_events/config

Enable configs for all testcases:
(export ARCH=xxx #for cross compiling)
./scripts/kconfig/merge_config.sh .config \
                tools/testing/selftests/*/config

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/user_events/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/user_events/config

diff --git a/tools/testing/selftests/user_events/config b/tools/testing/selftests/user_events/config
new file mode 100644
index 0000000000000..64f7a9a90cec4
--- /dev/null
+++ b/tools/testing/selftests/user_events/config
@@ -0,0 +1 @@
+CONFIG_USER_EVENTS=y
-- 
2.30.2

