Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4315D122BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEBTro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 15:47:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35207 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfEBTrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 15:47:43 -0400
Received: by mail-it1-f193.google.com with SMTP id l140so5547548itb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlRlXXCdCQ8ojS85wg4oVL7jRwgqCApJr9d2CW9N/kk=;
        b=hlmMwKaTwo8QkQ4w59AlaHa1gPjDqmFKP51ibnEIOqxvpVM4+UHLOj35EdfiGp9C1i
         g7B7YmNkJtO8upmjc7K+jEym4Fyf4w+4UzkCuroDMQxsNLAS1DjyfCCM3mi9zNkZHmaX
         W9BdloyTGe2xFOCDO8SMbUzbt1HoTTeAB47cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlRlXXCdCQ8ojS85wg4oVL7jRwgqCApJr9d2CW9N/kk=;
        b=fJzQJpPmBcuyIjFwuZ29czqR8ydAqNYcV8hjpnUL780wAUrNFUaKBhavFmas4C7KTW
         nF16iMXg8JG463kQOQ97+ew2Qqcq403Q58uuf+xfjmr3FQg48X9tHXtLTPxHG0auIAfw
         zg9/tZDL+lEecCpxJ3/8GCgTGgnHvardIrcgMJgDsS3PgeHRmHyP0aiUs6qW+5vdTUPV
         bWDxd1DetmS9Tle+HH6fYIQ0kx7qx8TZQJ3vrbQ5qTAHHWQDf9vdVux2KLmjbyPixJVb
         9GaRzmT3MTrfIUsjewp1fk4scUpao4P0U27PFpbicIwoaqOfqxvOwHTEx4Kj27/oXHLk
         37eg==
X-Gm-Message-State: APjAAAVvSKT+jU44w3ajYGa563r8AJqTs+nfdHBgUVNtPkhIgtnDoQ1c
        cCxqhs+VvpsxlQPDnqIOzttYwA==
X-Google-Smtp-Source: APXvYqzxV1flOpU2yjAYsjvpcGQ06uNmg+YUXTWwTD4S3a4FvSgciwOuQPCWH1C2VXlxaZHzEYUFTg==
X-Received: by 2002:a02:3b55:: with SMTP id i21mr4012523jaf.128.1556826463209;
        Thu, 02 May 2019 12:47:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n4sm14741ioh.52.2019.05.02.12.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:47:42 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add sleep between detach and usbip list -l
Date:   Thu,  2 May 2019 13:47:40 -0600
Message-Id: <20190502194740.15344-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a sleep between detach and check for exportable devices to avoid
the following segfault from libc-2.27.so

[ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
index 128f0ab24307..beacf24a8df7 100755
--- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
 src/usbip detach -p 100;
 echo "=============================================================="
 
+# let detach complete. Avoid segfaults from libc-2.27.so
+sleep 3;
+
 echo "Expect to see export-able devices";
 src/usbip list -l;
 echo "=============================================================="
 
+
 echo "Remove usbip_host module";
 rmmod usbip_host;
 
-- 
2.17.1

