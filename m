Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10279421918
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Oct 2021 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhJDVRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhJDVRA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 17:17:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A9C061745
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 14:15:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n71so22063454iod.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=4k8bYvmRsjfzFzJJCboCZs0zna0o9e8j9J5j74p//xE=;
        b=Rx2l5uJeecno9wbVOT4T4bcECuW3JJGYSr3rrb9tPpHstKbUwhAhTKhGhklTVg+o2G
         wvnvaZ/E7tnzHuTc2HBDtmqjtt23bAP8fU+olObpS9HQ8jBrAQp1E/EjAALtpDEjmgy2
         ivJ6sbq7g9FxmjaehKsLiUd0gW9C+bvG3Iwl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=4k8bYvmRsjfzFzJJCboCZs0zna0o9e8j9J5j74p//xE=;
        b=iN3d9c3hGo9erzWB9Kt/PKyopeHgNnA+a7BXKFKXuGp0NGd86lFCVmcbi39DFEQ0XG
         Fvn6SwwG8K5X0aQY5km80cg2J+EknM6eTfKf9K/RilJMe0UvCePqnl0fHqdvlD9XaiTx
         fXymyPj9ehds5LIH9AmFFMoXLHE623by1htM9wn9Unq3vrBzaG4zgt0f4+EsRo/j4GKh
         AohKynHLhaBOq2H/GmiwelyvEJqtQjNlyIHWaB0Vu+IU6QOPdHsVj6vvSuykDjiZ0jWY
         Mk9HGvwX/DtI/TgiYWHIjhvaXy4fry1A3WKwbI4j+Unhd9tP36Mr4dlYiROq+EKbyRcr
         tnbQ==
X-Gm-Message-State: AOAM530Yh3VbBtFFcxRpsMN4oNgAZsdyaBNsG8L5tejyeM3rVqZPFKir
        vJDK0Al1gmzJHG6pTBwXcrZJsg==
X-Google-Smtp-Source: ABdhPJwBDBXrlmTC5AKFUiBjQGnZsChXuhixhh2UV3rjbKfaUMPJPJtGUZjqxWhVfCjWNjtStKf32w==
X-Received: by 2002:a6b:fe18:: with SMTP id x24mr11267330ioh.119.1633382110185;
        Mon, 04 Oct 2021 14:15:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n4sm8528455ili.63.2021.10.04.14.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 14:15:09 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.15-rc5
Message-ID: <6c737cda-28aa-0ac7-c07c-5115d0968bd9@linuxfoundation.org>
Date:   Mon, 4 Oct 2021 15:15:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------242C93BA0792A9C583A205A9"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------242C93BA0792A9C583A205A9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.15-rc5.

This Kselftest fixes update for Linux 5.15-rc5 consists of a fix
to implicit declaration warns in drivers/dma-buf test.

I have been seeing this for a while and managed to fix it.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f5013d412a43662b63f3d5f3a804d63213acd471:

   selftests: kvm: fix get_run_delay() ignoring fscanf() return warn (2021-09-16 12:57:32 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc5

for you to fetch changes up to 2f9602870886af74d97bac23ee6db5f5466d0a49:

   selftests: drivers/dma-buf: Fix implicit declaration warns (2021-09-27 09:52:29 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.15-rc5

This Kselftest fixes update for Linux 5.15-rc5 consists of a fix
to implicit declaration warns in drivers/dma-buf test.

----------------------------------------------------------------
Shuah Khan (1):
       selftests: drivers/dma-buf: Fix implicit declaration warns

  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)
----------------------------------------------------------------

--------------242C93BA0792A9C583A205A9
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.15-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.15-rc5.diff"

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index 4de902ea14d8..de1c4e6de0b2 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __EXPORTED_HEADERS__
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <malloc.h>
 
 #include <sys/ioctl.h>

--------------242C93BA0792A9C583A205A9--
