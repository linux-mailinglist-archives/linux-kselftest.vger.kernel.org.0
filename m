Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A243CBF3B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGPW1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhGPW1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 18:27:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5273C061760
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jul 2021 15:24:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a7so9690430iln.6
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jul 2021 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=gvJNiGrUE7iYU9YZC9wIXIfuNDiMCJEz6M/7bMn1buM=;
        b=JRiFqS3Pf2to2G/flByKuQfP6Ct24IVYzYPyGJiLJ3lzvys7bUOPystOc2NZPvfyhJ
         qN+SNiP5hiPXxbV3XiuyoNpS9nnsx/fuz8fv2HCpp6CVZNAD+credYZQXoTsYhGxFpy+
         ISqG6VCO8LxtpMnluMprSP0UI478JnHzuE4do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=gvJNiGrUE7iYU9YZC9wIXIfuNDiMCJEz6M/7bMn1buM=;
        b=olMRhhH73YeUp9COMuZ9jngkxtikzcbSTpZewv92JB5betm3xG+IBf5GxHXD0pHVCI
         G8kSAfFdR6KVRx1ekSF/O+yzwYna7atRrKAIRNhBVCacFzwCyCs85chp1XZIjb79230T
         USLP8MQ3Mw0tKmrSyXd7zm2YvuL+HZmoRCNC8RiWq95sIxTojVpPucEc1HcIu4gaOOxJ
         899aG0A/nRy0QLjmWoi4uOiTCQkeEI/zMP8BYekGT19Ah5oPN2vIZyQIokj7ZQK6bs6k
         HkrQgbUZFJN5eAe/WO4ipP6+g4bhIHRNFCg/2HqLsLpjso7oidbt3cvHW1cubwYOflBF
         49wg==
X-Gm-Message-State: AOAM530g5XPFo+FLrYls/vmMWskJzuHnouf4PiB+azo7notvaYyvbfje
        RWfcrXgj3BaVBacHjiaIsR9hhkQviefR2w==
X-Google-Smtp-Source: ABdhPJz7MZ+6UyIbQJRAwczt0iU0QAAoaj/V9J4ZsjSjYApXd012Io+SYrasLV3hMZj0+Rakdv0bGg==
X-Received: by 2002:a92:cf0c:: with SMTP id c12mr7837973ilo.56.1626474278631;
        Fri, 16 Jul 2021 15:24:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e17sm5182364ilr.51.2021.07.16.15.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 15:24:38 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.14-rc2
Message-ID: <ae8c3cdd-8bc6-fd64-ce73-9a27a60a8820@linuxfoundation.org>
Date:   Fri, 16 Jul 2021 16:24:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------81D6205E16BFBD929301D6F4"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------81D6205E16BFBD929301D6F4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.14-rc2

This Kselftest fixes update for Linux 5.14-rc2 consists of fix
to memory-hotplug hot-remove test to stop spamming logs with
dump_page() entries and slowing the system down to a crawl.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc2

for you to fetch changes up to 0c0f6299ba71faf610e311605e09e96331c45f28:

   selftests: memory-hotplug: avoid spamming logs with dump_page(), ratio limit hot-remove error test (2021-07-12 14:20:01 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.14-rc2

This Kselftest fixes update for Linux 5.14-rc2 consists of fix
to memory-hotplug hot-remove test to stop spamming logs with
dump_page() entries and slowing the system down to a crawl.

----------------------------------------------------------------
Paolo Pisati (1):
       selftests: memory-hotplug: avoid spamming logs with dump_page(), ratio limit hot-remove error test

  tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
----------------------------------------------------------------

--------------81D6205E16BFBD929301D6F4
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.14-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.14-rc2.diff"

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index b37585e6aa38..46a97f318f58 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -282,7 +282,9 @@ done
 #
 echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 for memory in `hotpluggable_online_memory`; do
-	offline_memory_expect_fail $memory
+	if [ $((RANDOM % 100)) -lt $ratio ]; then
+		offline_memory_expect_fail $memory
+	fi
 done
 
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error

--------------81D6205E16BFBD929301D6F4--
