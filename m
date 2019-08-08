Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3428861D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfHHMbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 08:31:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40836 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbfHHMbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 08:31:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so94706571wrl.7
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=719/5DFvRfWwCLtGmiwAoLfgu4awkKtG7JiiAlJQkos=;
        b=e7eo+W1fI12hnUdWyfetUQNy8huNzKGC0JTjy2Uf12H39LvQJjs2VSYqyNWH5IowtM
         O4gs4wf1RNCEvAh4neSGwqpIbrJ1EDZa3A/kRSS5nlnBh8rja5DroiXGQG6/GnjSx07X
         tcKyenRHFV4OQHg41LLJqa4joXEWOL/hZMtVTzHh017ouCrFd7R2wa03aVkvTIguwOLw
         Diq4RiUuMUwT+kolbxDoDVmvLmgJWG8Qsnt5QBcF7HO/AVYmLbd7cIMTxtWFOUj5IJtQ
         a+ci9bA2UTszQbarL4LpCpi9a8+F3xt6nbZ6B05RoktxiufweNYAosdPGGu1AlHtJUQl
         L1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=719/5DFvRfWwCLtGmiwAoLfgu4awkKtG7JiiAlJQkos=;
        b=azj6v4o6dklpmdClVdGObBOB1bizlYxnx7sXFplDV4O17dLbBfQjw2EaKyeZYso4CU
         pKza8seQHGD/sjObnSZYAhbmdo+tVAmdjZ4O7skJqGSTmdh+kd1LX2EWKgki33jei0ls
         B46Vizr/udRwEr9AGsdn2724voqKieeI3A8izASzp3EASWhG86KMLS2UZELCBr8ZRBna
         CBM3vTWInspmOYxYs973kDPPIo2n2ViGOQrsfqXecxxgB+w8EZ3/CCEDETdzdsQCdaUD
         9LQgj7w4SVjxrEe+iYrh1zfiwWC/+MMfv+o6kNdfFJVNvtWvAuA8MvyH9EkBZCqns08s
         Abuw==
X-Gm-Message-State: APjAAAVvUT2LEod40jQRvZmRLFiuQ0ed6sW7TVpmr+82hJDbZscGF3qg
        TqjsfICVid6o2GzuRemrl+OE/w==
X-Google-Smtp-Source: APXvYqwlq7Scq3WaphemqYY+kgeK5uDkZrYgbJ3SRXsQJKsK6KIXuoAOPIVRKn+9+pdgqHpZk4NGJQ==
X-Received: by 2002:adf:9486:: with SMTP id 6mr17484262wrr.242.1565267509386;
        Thu, 08 Aug 2019 05:31:49 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id h97sm3206111wrh.74.2019.08.08.05.31.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:31:48 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] selftests: kvm: Adding config fragments
Date:   Thu,  8 Aug 2019 13:31:40 +0100
Message-Id: <20190808123140.25583-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests kvm all test cases need pre-required kernel configs for the
tests to get pass.

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/kvm/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..63ed533f73d6
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1,3 @@
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
-- 
2.17.1

