Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12E9872E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405719AbfHIHYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 03:24:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405688AbfHIHYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 03:24:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so97301873wrm.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WA0xD70S4mvb/PQJqRGInCwCmljrweMt295QtIocBXo=;
        b=ECmtJohNEbHkaOvigVwh0bY5ueXewlnzoOQL3GT3J/vW0jaj8QP331qzTa6/eZe6ap
         FtgCKyWaI2sflGgqWmktF07KsIvaDVTZBEzGpnEFoqdjFHQJDHfA6TYzamqpL5yRiPdz
         uzOe419XsGH1DRGPvc6b1Wp8Z7lObTT7ntP5WtqGMZegXUN+mD85FpgToBqnZGaLapZj
         DjzTHVUT4HPBs4xXsvS1e4ie34ZZ7+rF/Et9jLybklI17im+xbwHvu4Hh3XmCSCbRa/f
         bFvlZ1E4nmQpCKjIJTF0SoLjYwmUZGLZp2NP/4mOtA88cRweUiVPLKMKKkVDkdHIRvC4
         1cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WA0xD70S4mvb/PQJqRGInCwCmljrweMt295QtIocBXo=;
        b=iqRq9VBE74KuZfbg3W/vLnx1tjAYRYNjMRLnTCHUYU1YcP2pnxRv0u24aK3n+RuA3O
         ormZ6VX88eyX9+iYkQca2J67cPT+SZeMly+cR+k4kIwitszBgpLLYBVRtGKO23IVgRwy
         rUac3pQ/L8gFfgFS7XqALyeuavmdVg1+9TGovRBf/+dnyuGRDpdkJazellfGIesdIBC/
         IPae2kTrT67slsyH9T1sDgntNv6K09DqUI8mTs5EBlU67ciAEq7jAO9+euY/VonAyVH0
         +SRoWBa1/04WcF20M7kfJnupWckU6arhekrZo0fXpalH+49PrfBryC1avHEbDvrAu7yk
         n7xQ==
X-Gm-Message-State: APjAAAVTRu6qMl8BLlPQBSQW6RzDDK9OpNSmZ5z5Kv3TpsRE6EOhXFTu
        OtAd2EbJA+lpX5GaFl4t0iuEkQ==
X-Google-Smtp-Source: APXvYqzeCO+GY7pXqejgTG/gXxeki0mTFaAubI9/NXbDdkGSDD2/esm1gSsnUs44X+UO9i0yvJ2edQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr22016063wrq.143.1565335471654;
        Fri, 09 Aug 2019 00:24:31 -0700 (PDT)
Received: from hackbox2.linaroharston ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id p13sm26232705wrw.90.2019.08.09.00.24.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:24:31 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     naresh.kamboju@linaro.org, pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 2/2] selftests: kvm: x86_64: Adding config fragments
Date:   Fri,  9 Aug 2019 08:24:15 +0100
Message-Id: <20190809072415.29305-2-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809072415.29305-1-naresh.kamboju@linaro.org>
References: <20190809072415.29305-1-naresh.kamboju@linaro.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests kvm x86_64 test cases need pre-required kernel configs for the
tests to get pass when you are using Intel or AMD CPU.

CONFIG_KVM_INTEL=y
CONFIG_KVM_AMD=y

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/kvm/x86_64/config | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/config

diff --git a/tools/testing/selftests/kvm/x86_64/config b/tools/testing/selftests/kvm/x86_64/config
new file mode 100644
index 000000000000..4df8c7f54885
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/config
@@ -0,0 +1,2 @@
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
-- 
2.17.1

