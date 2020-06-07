Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04C71F1015
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jun 2020 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgFGV5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Jun 2020 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGV5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Jun 2020 17:57:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD5C08C5C3;
        Sun,  7 Jun 2020 14:57:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j18so5006539lji.2;
        Sun, 07 Jun 2020 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqzE13DBGUWBWdCJ5g5XYcpEIrvBncjQd6Y+cm1LVm0=;
        b=A1kcJcX9iH7BYSCidWQt8QJqrhpVkHmiMEn2kXteAL6QaN5K00uDeWRQas5Gw/ftHH
         WH2IU1ymgjSDYDOdC9iLXN8Hs+7lXvDbE7M8+REwhu6Mo9GDNCkGTU908xQa61FjlPMN
         iL0NNQALqkuSzQI3TzrdfMyuD9ccumhZXWsqM/VYB1czUV/FFPNq5t9jZlwXy5dQqrxr
         IOFxdcIhLTxCmeMk+hSmdjE5TuHLlfyhLTj19MpCZ1IuALCjIL3qEMZdDWTg+jbS8ka/
         c7fPjoxSDBlfZQsciVe9fGZrVqG7Juoz1jGsCEbAI/fjNlZzEM/bFZfEzq3/lDjgBAgt
         pcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqzE13DBGUWBWdCJ5g5XYcpEIrvBncjQd6Y+cm1LVm0=;
        b=oLEQjr/CTc2L8WA6NLGXestHqqGnrHN3PEXLYNSgKyfZXryJA9jKNs7pQFyIdbFEIM
         CVxEUnG7sWQ9F+Uicwtyl8sCyZrPV+Rmpqw/JXgWQEV22qi0g6eeIqP0jS6s2M/60FCI
         OR6T+MzOqAXdEk0xaoAQpnWLHP1UAB4bEkizwFAMn5lgEk6DzpVNg8HQYW5GqJA7tODJ
         pMEFR6rPZgJFMUoI9Y1i1q2Dr+TOiyzIRhKpTcqes/CEkaI6DnKC0A8iJ/6ag+g2wvbv
         Wpm8fpITHwce6+QOECreBxqYvvuKkpEdYGqpnWClE7dUjU7GRLgVvjiWUq778DkVoOz3
         Lksw==
X-Gm-Message-State: AOAM531lzXNK86UD2PQYApxT/LiARNcGsznMlTqNNWChWMJO6yw42Ndh
        +nEfj9+GS2N6cU0IXNPM72PNO7USWYc=
X-Google-Smtp-Source: ABdhPJxYKPYJvSofcSn1dR4YwY1CnR0Kj2Oc001gie3aIIbT9BPfFiWFdMW9F/uoy8U0qTn/wGtb7g==
X-Received: by 2002:a2e:b5bc:: with SMTP id f28mr8785854ljn.451.1591567041703;
        Sun, 07 Jun 2020 14:57:21 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id l14sm3897804lfk.30.2020.06.07.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 14:57:21 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     brendanhiggins@google.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with space
Date:   Sun,  7 Jun 2020 23:57:15 +0200
Message-Id: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
parsing which did not like the spaces in the string.

Fix this by updating the regex to allow strings containing spaces.

Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Maybe it would have been sufficient to just use
CONFIG_PATTERN = r'^CONFIG_(\w+)=(.*)$' instead?

 tools/testing/kunit/kunit_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..02ffc3a3e5dc 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -10,7 +10,7 @@ import collections
 import re
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
-CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
 KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 
-- 
2.27.0

