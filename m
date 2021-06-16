Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5A3A9E50
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhFPO7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 10:59:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhFPO7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 10:59:37 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andrea.righi@canonical.com>)
        id 1ltWyw-0004dL-C7
        for linux-kselftest@vger.kernel.org; Wed, 16 Jun 2021 14:57:30 +0000
Received: by mail-ej1-f71.google.com with SMTP id m16-20020a1709066d10b029047b77529dc3so199566ejr.16
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 07:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8a4xq8lMfa/LYfpYCOAoKmUJPps9DKcxfcjZnPhoHfw=;
        b=TawFILXZmIId/LE/6BLhXJdmlBFx5i93qisk4pM0axGISrWLojoHij/2InCi6Gk1o2
         ZuZB2kociHvAwsFU5u1QJjmDnFdj+33J4lLUVAbogMfpaZzJ0AxqBxGllNwICzKu+S9j
         veO6sJpf8Hspkod56L3bVNIpAGoErXUC3+x5qKZhZgGukBLWpCUDKsuTbPtRquPaqR4v
         TZ5oWykzbwDyKyMtBQJkuMj8M5xQe9lD+iBVogQTaoXRZoEp02fYr2WU7nfOfSB+PZbU
         SiqoF/5H5Hm3/Dh5vT4b6xZUJ98hYLpZ7tvufn1bQWBzsSQr1fTs3XYXfW9lGueh6U8c
         wBEw==
X-Gm-Message-State: AOAM530kdqv+R23/JN39ZUrY0LA98Szt69HstF64wmZ8ImEALSCzqlTw
        7xewgj2h/a89ohFL1gDPc6jLNYc/+mGpLqyPs07jd5fDMfOiCye0etr/0JS0XCTOiogwVa5jA6B
        5dys8VjwMldJmwd6eb9N2TWMJGavvIHerLZtZWnLihkavtg==
X-Received: by 2002:a05:6402:40cc:: with SMTP id z12mr9324edb.202.1623855449144;
        Wed, 16 Jun 2021 07:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0x+c1CqYwSTRfdh/qpSq2BG+BtPzscae96/sH0AdsUtHuvEFm+xaOmkVdZvXxu0t3A449FA==
X-Received: by 2002:a05:6402:40cc:: with SMTP id z12mr9305edb.202.1623855448906;
        Wed, 16 Jun 2021 07:57:28 -0700 (PDT)
Received: from localhost (host-79-46-128-215.retail.telecomitalia.it. [79.46.128.215])
        by smtp.gmail.com with ESMTPSA id p13sm1777726ejr.87.2021.06.16.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:57:28 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:57:27 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: use bash to run udpgro_fwd test case
Message-ID: <YMoRV6IOOVhS3nEi@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

udpgro_fwd.sh contains many bash specific operators ("[[", "local -r"),
but it's using /bin/sh; in some distro /bin/sh is mapped to /bin/dash,
that doesn't support such operators.

Force the test to use /bin/bash explicitly and prevent false positive
test failures.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index a8fa64136282..7f26591f236b 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 readonly BASE="ns-$(mktemp -u XXXXXX)"
-- 
2.31.1

