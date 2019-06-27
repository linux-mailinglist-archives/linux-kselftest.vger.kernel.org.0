Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D713658E91
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 01:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfF0XeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jun 2019 19:34:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38309 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0XeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jun 2019 19:34:24 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so8612566ioa.5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2019 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l89hBvZrEHLPxhxyxMlfDGOIe5uXPNhT8ICPgxlxf2E=;
        b=LaEBtdw97EYwVjhQ2He+QVwcePOM+u4DJj74JjBzsoEmaYokSHAj68OTsYT1baTKfn
         0CpDvbNi+OFuNBVzKms0fRzzPcUbOQPoKyCTOXBKfdq9EjiNpTBFupVWEeGRNzo40xcq
         BQTtO2ZMq69zkSGlhefUHt3X8816bflaE3pSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l89hBvZrEHLPxhxyxMlfDGOIe5uXPNhT8ICPgxlxf2E=;
        b=OLg7fZE/RmbH3anUkTSFZgY3omnjF6FauwsFD7qzl4Rv9UKbjkMGSALKfdhR8awf5X
         nzzSZsBd6oEdrOujEPizAy11j73AkY0rZIdyOb++UadORnkiV8fl67M9df9LyOTJ0o19
         E9Jd2pHvpOQu+XnjEAZzaLAAzOSq/kZZytTG9QPjOQCWm/6jY22I+HMupAxwlcL2O2MW
         fJKjeoEHHqtoYbuVOoU9MhVT0to316GzxBLXTfO56WPtrhT4boPlJvthwTuucaTJtX7t
         qCIkuJOQYg9303OW/yM1YsYJ2GJnDYykd6qbyAPIMh0BcrlOASB1LHJKQ8cpRrK2Kcl9
         TEmw==
X-Gm-Message-State: APjAAAUJcpk9gAcbsSkB/7fW0NdGoB6Ro0h/WXZUdZWdZJkSw+wuNlXL
        iOSZS3EcqZCDwF0UdZhZ9wv0jA==
X-Google-Smtp-Source: APXvYqwj4rkWd8isFJNVQVTJ3enNTztWl/NXzCy6FgXuC6/2rhi87XUFdhvu6dzltHCuykaP0MNqJA==
X-Received: by 2002:a5d:885a:: with SMTP id t26mr3561199ios.218.1561678463873;
        Thu, 27 Jun 2019 16:34:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i23sm538506ioj.24.2019.06.27.16.34.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:34:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, allison@lohutok.net, gregkh@linuxfoundation.org,
        alexios.zavras@intel.com, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: timestamping: Fix SIOCGSTAMP undeclared build failure
Date:   Thu, 27 Jun 2019 17:34:21 -0600
Message-Id: <20190627233421.30340-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add missing linux/sockios.h include to fix the following SIOCGSTAMP
undeclared build error. In addition, remove the local defines for
SIOCGSTAMPNS and SIOCSHWTSTAMP and pick them up from linux/sockios.h.

timestamping.c:249:19: error: SIOCGSTAMP undeclared
   if (ioctl(sock, SIOCGSTAMP, &tv))

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/networking/timestamping/timestamping.c     | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/networking/timestamping/timestamping.c b/tools/testing/selftests/networking/timestamping/timestamping.c
index 0fbed67bf4f6..aca3491174a1 100644
--- a/tools/testing/selftests/networking/timestamping/timestamping.c
+++ b/tools/testing/selftests/networking/timestamping/timestamping.c
@@ -32,6 +32,7 @@
 #include <asm/types.h>
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
+#include <linux/sockios.h>
 
 #ifndef SO_TIMESTAMPING
 # define SO_TIMESTAMPING         37
@@ -42,14 +43,6 @@
 # define SO_TIMESTAMPNS 35
 #endif
 
-#ifndef SIOCGSTAMPNS
-# define SIOCGSTAMPNS 0x8907
-#endif
-
-#ifndef SIOCSHWTSTAMP
-# define SIOCSHWTSTAMP 0x89b0
-#endif
-
 static void usage(const char *error)
 {
 	if (error)
-- 
2.17.1

