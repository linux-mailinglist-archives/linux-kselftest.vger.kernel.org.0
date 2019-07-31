Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A947BEB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfGaKzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 06:55:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfGaKzt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 06:55:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so60342943wmj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2019 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TDzD4mVy0JnW8wivYuq40NvZrehE5P3+AXFL+h905R8=;
        b=WNMsbmyz6D6vL9V6DopwuW1s80Gg6oqYGLlA0GJ8RnDqXKSMBuyTYqRBqfhzj9Vffq
         wl9a5rf74ruxe3IlxypYN4x9BVxL7mlQPHncZ0jmz8pBEGtUAlq88DV0+PNuEQokidbI
         01jJzGXYdAnjNlSgmwuOLPLupEQt93/+w7eji2TzrzBQG4t/JWkd3GctA3MGZbpVADTA
         6B1ItYcMYe+vJZQmPWGongPZrKj1kDGsrDGbxHDk0PuAb1ZzpGWQQimPQogwr2ESvDcR
         JzQuXGQUq4oyde/xmWLagYhdQLfu2Nvi6w80bNdvcg/Dv+8UtAmQOMIILMuZdUy9HJdN
         Um1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TDzD4mVy0JnW8wivYuq40NvZrehE5P3+AXFL+h905R8=;
        b=ccFX0OkgP2+nny9ANfrhFZT2xIuunmX8l1dbIvW1BuZXQ88z8squ3C9GhVQF9k/d4S
         NdKCcgUn5+ew0t2F3YKP7HMGwv1Cth9mrcAa+61tJwi9XkuycD0TlWqMY2VP9P+CMnTS
         CCHPa0XIc2xuif5vIJmYnS2xcQJXwlWaR8SqCKxUkzPe+rUwLD8rDVOJksCeGLoL9yHY
         1O7NjPT1c1FkLLgkAaJX+xTAZ0M/5yUp15od16ASJNQQzGnUEUJ4/xNl1o53kZ5WP6Iy
         pjWQPUnZEg78yiNABcE2/tyTgPcPuWROwAyVIHf1S9zZvRYIOhNxaqsajdXqf44vWtgV
         ENuQ==
X-Gm-Message-State: APjAAAUSUar8oobPA0FL3qYpIca0oKZuCupMfe9YBVJovwu1cRWND3bY
        wLc4oxaRFT/nS6KvTULca0LrnFbHK/nrpQ==
X-Google-Smtp-Source: APXvYqzdekKZMBfdaKCjtzUencNZJvkLCqiIWA5u9hwHKpwmTeSFcpzTl4f4+JaBlbZ+1xTy2sL1sQ==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr93262568wmc.50.1564570546683;
        Wed, 31 Jul 2019 03:55:46 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id a84sm85426114wmf.29.2019.07.31.03.55.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 03:55:45 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        drjones@redhat.com, sean.j.christopherson@intel.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: kvm: Adding config fragments
Date:   Wed, 31 Jul 2019 11:55:40 +0100
Message-Id: <20190731105540.28962-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests kvm test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/kvm/config | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..3b1cbd726af6
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1,26 @@
+CONFIG_ARCH_ENABLE_THP_MIGRATION=y
+CONFIG_HAVE_KVM_IRQCHIP=y
+CONFIG_HAVE_KVM_IRQFD=y
+CONFIG_HAVE_KVM_IRQ_ROUTING=y
+CONFIG_HAVE_KVM_EVENTFD=y
+CONFIG_KVM_MMIO=y
+CONFIG_KVM_ASYNC_PF=y
+CONFIG_HAVE_KVM_MSI=y
+CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
+CONFIG_KVM_VFIO=y
+CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
+CONFIG_KVM_COMPAT=y
+CONFIG_HAVE_KVM_IRQ_BYPASS=y
+CONFIG_HAVE_KVM_NO_POLL=y
+CONFIG_KVM=y
+CONFIG_VHOST_NET=y
+CONFIG_VHOST=y
+CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
+CONFIG_USER_RETURN_NOTIFIER=y
+CONFIG_PREEMPT_NOTIFIERS=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
+CONFIG_THP_SWAP=y
+CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
+CONFIG_IRQ_BYPASS_MANAGER=y
+CONFIG_XARRAY_MULTI=y
-- 
2.17.1

