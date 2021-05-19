Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9838989C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 23:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESVe5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 17:34:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E39EC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:33:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t19-20020a170902d293b02900f0c90dc011so6642674plc.21
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cOO+IbBZ9Kvoj3lhh1iacoy/r2F7rXeqm3ad3wDL1+A=;
        b=QL5KNau84Zofl1F+WtBRi/h47IQG2BL/RYC3SXQIq8xmnlbfB/ewUwBlTapbQE7zHe
         Xcwtm20YrEqg6Jw+ks9JiYc/AvXhD6zw/Qb+yL2WI0sedjOTEidDHjZqi1/FjsIbDtuF
         laNuORopKhlB75G8MLsO4mBBh4tNZ7ImWLXA+Y5IxVsTQFJGdF/O8IuIKPGTnVXAIdrt
         NQr6lXNAkGvRL5uXT8Z+QYudZPPXLbG5c9Bwg6e6njIFG7sFyDTVPhaqaPSkQuG+YuEF
         JOTX2jersLEu18Zums9wfZDXuuKBieLTu1/JGIn0g9e/NVa1jaNWDZi1umQM0Jjv7AVn
         1VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cOO+IbBZ9Kvoj3lhh1iacoy/r2F7rXeqm3ad3wDL1+A=;
        b=Ds6DNIk6LTouPoF5JJ8/gsBASxEqNtdJTE9rMWFCoxMLS6laODEO4Ig34ZC5RvLkYI
         Zzt+Fo1i6TQlcNpHJDkjobqZM+yAJ91I7t0D2JLTdw7RMWFT3eQaMip1SHMRrbNHBp+B
         VV4Qr4nm+rI9Bfuul7btjtQETWIQwx15EDVbnlfbc53tUmxHGSaWOe5rNtmRUkbBqKFg
         WRViO4h01481+0L/bjUZ555Yj+KmpC+4vPO1mbia+TSpImsmUzVFgM+PEtdahxtJbg0V
         6G9xZp5olRbGUNxnP/uKnBBh7OcnZtaX33LFdGd4clKCZF86VLxe/IqohFz90KSi8o5r
         QcEQ==
X-Gm-Message-State: AOAM532z6YrKdSFgNNfFw+H4kGE7JD284L/9gwJXu1eXPwSTo8w/278/
        SPPilcPDUm/F4ETpfXrB/b0hz2xzG9rFRw==
X-Google-Smtp-Source: ABdhPJwfEtI2Tb/Dbt51r4gCfKogUfwd+BTKpwkLXh2ttiFh3LhfopdSyM6m4UCPTJFHBUEee/JNnaiFwdUeNw==
X-Received: from dmatlack-heavy.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:19cd])
 (user=dmatlack job=sendgmr) by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP
 id w185-20020a6230c20000b0290289116cec81mr1112723pfw.42.1621460016669; Wed,
 19 May 2021 14:33:36 -0700 (PDT)
Date:   Wed, 19 May 2021 21:33:33 +0000
Message-Id: <20210519213333.3947830-1-dmatlack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] selftests: Add .gitignore for nci test suite
From:   David Matlack <dmatlack@google.com>
To:     netdev@vger.kernel.org, linux-nfc@lists.01.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bongsu Jeon <bongsu.jeon@samsung.com>,
        Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building the nci test suite produces a binary, nci_dev, that git then
tries to track. Add a .gitignore file to tell git to ignore this binary.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/nci/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/nci/.gitignore

diff --git a/tools/testing/selftests/nci/.gitignore b/tools/testing/selftests/nci/.gitignore
new file mode 100644
index 000000000000..448eeb4590fc
--- /dev/null
+++ b/tools/testing/selftests/nci/.gitignore
@@ -0,0 +1 @@
+/nci_dev
-- 
2.31.1.751.gd2f1c929bd-goog

