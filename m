Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C114C872E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfHIHYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 03:24:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfHIHYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 03:24:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so4661783wma.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C5YgxiRdWg1QeF0RKI1Qt9EbdjzocEjmRbp/WRepaaE=;
        b=y6iGPlilN8Si8QhpWCJ9jAq3We6ZMX7x6l04tVExxbpkgl4qKg9Dj98hDdVl7XWf8y
         PV3WfvEwgUvjE7oGBt/zg5N+39uCB7dUHoUdKPCtiLHMgrKvCYxNX2PhKBSjqFWwgGzp
         6Qz/slTlHhh8Hrpf6CVmmYFnCBm0Xd/j2crNXq78Dy4j9qQDyafXTpX1rD1XFAwPTqyA
         eKbxucva1RMOlQQ6OpUGTEpxL29e5/jioOouxU4KYUjFKudIJaxLhzNkDHqieMfkZNOU
         E3HlzzQ9vbOJSbVzD6y9s/gyAQpxQDe+yyf4X2R6KRsl5tWkHBNOY00kybUw7UWKOdCx
         mHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5YgxiRdWg1QeF0RKI1Qt9EbdjzocEjmRbp/WRepaaE=;
        b=jOenmb4yS5EVptjCJyCLFtrWkXkCbmxA4PXaGLBCSTu6YHROFuNAw4CQSe8SKyWq1j
         sB6YxUntQeaXK1y23hZb2XJ1PlkK2mbMu3Bc9iDRt2g9CXYG2aCocJt8xh+MClm7z5ej
         l9Fk2XADVqVE/xDsS7SFMYoxk3rm8/lKMJuj8QFKrljjEdCvaQ4tg//GZrg267T+L5Ci
         MlcdPCFdzxeaRbguSEJTtsoeEs9GTryDjACULQo/gfMKoEy4TOXfobes5I4HjV3aM4CZ
         7c7ouuHbTT3GiXHCFBbKMfP9+qak1EivvUj16jG1ep+fPMGo5n3TgGn/nPsf8fUJ66xj
         HIgQ==
X-Gm-Message-State: APjAAAV+fmD0eN1IMhtS1tNC3yoU7+2lZq6eRoJvhfrl5BoaMckTAAEk
        29wdLOs3LJyggSxQsSWOO3XOEarIFd6e5Q==
X-Google-Smtp-Source: APXvYqzY/NrXDMMzWYfoIwzHh3sPo0P5ORJ4j0cOgeIwUdZDRDI4SZtMfr6mDW9pMufCtCpKa+OJ4Q==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr8407951wmg.134.1565335460541;
        Fri, 09 Aug 2019 00:24:20 -0700 (PDT)
Received: from hackbox2.linaroharston ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id p13sm26232705wrw.90.2019.08.09.00.24.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:24:19 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     naresh.kamboju@linaro.org, pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 1/2] selftests: kvm: Adding config fragments
Date:   Fri,  9 Aug 2019 08:24:14 +0100
Message-Id: <20190809072415.29305-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests kvm all test cases need pre-required kernel config for the
tests to get pass.

CONFIG_KVM=y

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..14f90d8d6801
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1 @@
+CONFIG_KVM=y
-- 
2.17.1

