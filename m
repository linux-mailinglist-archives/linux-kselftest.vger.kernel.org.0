Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFE1AA3B
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 06:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfELENN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 00:13:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41122 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfELENN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 00:13:13 -0400
Received: by mail-io1-f65.google.com with SMTP id a17so7533458iot.8;
        Sat, 11 May 2019 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSYRW6EihL7Ktm8gIvRh8QznEhcOtxZGm5DrS5LcSqE=;
        b=Li5bV64fgZXD35fWlJGgxhDJYKB+XhIXiJmsTqjCpffjjcyzMYTaInfRU1aSiKAhMj
         nSsjcd1geDTlqY2VYlCKkhLGA8tzSn19V4Kt1I4OU1s76C7U9CqNbt7H7qCPmuYfX4RE
         7ZXULc/kQcbE8D6MiPEI/VEH+eY/ijhuootZQzNscRJdI0Kv44f1fGchA7XUUc5QoLOI
         wrMSmVzRatm8qmx6wvW481NqNDKD38YsBVOXkTpWMILLuPFX7oOFMxn8NaTaFQMXXYRP
         p1WRkzV0UZg2/k0K/jQaVtGuBO827osckVrOu1LG1ZF29GtP978as5DpZl7NxwAITGcz
         wlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSYRW6EihL7Ktm8gIvRh8QznEhcOtxZGm5DrS5LcSqE=;
        b=aUAvh0SFoPSFwFy5Wn0XnxMdWhkIWAk0OYxtCRQIoJn/uOZAT6N1hyheUwjeBjMQ3G
         INwI/ZNm8VVEf6BKVSb7FIz5q72PQwOmkDnCzhWdo/AHarujBmqvAUgquRc8QXGFXoRj
         DO7hcyTlaKlLNDHGHugPJ0YphwS7wNCL8bE/lLpQuQg138NoQ2Rx22uGPYoHBuTg5Hma
         tu9JozKlwX3qyjuyXo2EX+KdSug7PO5Vs28Dk/gqyhzXmYd1KKH2JxTqf/+eZEckC3Un
         8x6P7cgwCVT91RbDmTLK3X7o2qaszZ5BWLA9ZymisK1XbjOYKK8vY1zS200ul1dgJD2A
         kryg==
X-Gm-Message-State: APjAAAW/pb1qYlBegprYCpWTAoHAPfYVw1AcxwY1kXh47rj4ctrM4DdR
        Dv09AoMbrDdMx9rJBCJUc6U=
X-Google-Smtp-Source: APXvYqzvFWn5MsXBuEOCw7n+mmg2x8HjUeiNd9/NuY1A/cW25q6DIu/4mJuOMrF/CFvhXd+bn3jXzg==
X-Received: by 2002:a5d:91c7:: with SMTP id k7mr11535785ior.237.1557634392780;
        Sat, 11 May 2019 21:13:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id r62sm704401ita.37.2019.05.11.21.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:13:11 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     shuah@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH] selftests: kvm: Add files generated when compiled to .gitignore
Date:   Sat, 11 May 2019 22:12:35 -0600
Message-Id: <20190512041235.29840-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following files are generated in /selftests/kvm/ after compiling and
should be added to /selftests/kvm/.gitignore:

	- /x86_64/hyperv_cpuid
	- /x86_64/smm_test

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 tools/testing/selftests/kvm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2689d1ea6d7a..81e9cb775ab8 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -6,4 +6,6 @@
 /x86_64/vmx_close_while_nested_test
 /x86_64/vmx_tsc_adjust_test
 /x86_64/state_test
+/x86_64/hyperv_cpuid
+/x86_64/smm_test
 /dirty_log_test
--
2.20.1

