Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E638A8C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhETKxw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 06:53:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33761 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhETKvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 06:51:39 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1ljgFs-0004Ew-PB
        for linux-kselftest@vger.kernel.org; Thu, 20 May 2021 10:50:16 +0000
Received: by mail-pg1-f198.google.com with SMTP id 4-20020a6317440000b029021689797ccaso10209137pgx.4
        for <linux-kselftest@vger.kernel.org>; Thu, 20 May 2021 03:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSIkOsI8pThklktnXX4z9cUIRN7lX3KR2qCGDTjhrNQ=;
        b=dteMDFvEUpvXEbLnwf6R8FIQ/d/axsabgziDIFvIQ55waeQMA63sw8480vIr5GFaeO
         ImWvlS44jFIliFEbtNxEHLxkCKfEN0FL0C0PTqdCqV3B+7PQxOl8fe99ZYRS252F5C+L
         w5lP0sO5n7gKjCSZ4CvoVJyFoz7yurGN6y9m67GbLH/iuEtttUKSp6N7fJubVb4k/R5U
         0eKZQX0NgYpFLiRsa8lZkkIzg9+Z9pS1Kx7mmxKeNQlOCFqhscpw2aG+swf6hReCluqj
         7oLO4mREZ8gOVcf0LVasm01qIpT2fDcPQecgPVgUQ1yY+Ikgt8HrQhJINnlu0o29dRJj
         EYFw==
X-Gm-Message-State: AOAM532tTgGAaa7E43cLscuDWwxwH6r48suKM5/tvrmNipTq+eTZ2z7E
        e4MJVjTmk9dBekaN45dXs+MxXB2cFVrXyajRLtnXHY4OfFRnM2ZBc4hou2BqOviutIojyfZo9J5
        K6BcwJ7HWufpqjnEa+tnvzk6RCHPIB0EbeQNys8g+tjuL
X-Received: by 2002:a63:617:: with SMTP id 23mr4009269pgg.409.1621507815424;
        Thu, 20 May 2021 03:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwn7XUCN2dSuQXAeNGr6FMEIaM7LGBpuYtyC006hVb4wQ637WWz+UKG8DjSlSmjgdfmCFSng==
X-Received: by 2002:a63:617:: with SMTP id 23mr4009249pgg.409.1621507815112;
        Thu, 20 May 2021 03:50:15 -0700 (PDT)
Received: from localhost.localdomain (223-136-144-189.emome-ip.hinet.net. [223.136.144.189])
        by smtp.gmail.com with ESMTPSA id q24sm1852614pgb.19.2021.05.20.03.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:50:14 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, shuah@kernel.org, kuba@kernel.org,
        davem@davemloft.net, skhan@linuxfoundation.org
Subject: [PATCH] selftests: net: devlink_port_split.py: skip the test if no devlink device
Date:   Thu, 20 May 2021 18:49:54 +0800
Message-Id: <20210520104954.25007-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When there is no devlink device, the following command will return:
  $ devlink -j dev show
  {dev:{}}

This will cause IndexError when trying to access the first element
in dev of this json dataset. Use the kselftest framework skip code
to skip this test in this case.

Example output with this change:
  # selftests: net: devlink_port_split.py
  # no devlink device was found, test skipped
  ok 7 selftests: net: devlink_port_split.py # SKIP

Link: https://bugs.launchpad.net/bugs/1928889
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/devlink_port_split.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/devlink_port_split.py b/tools/testing/selftests/net/devlink_port_split.py
index 834066d..2b5d6ff 100755
--- a/tools/testing/selftests/net/devlink_port_split.py
+++ b/tools/testing/selftests/net/devlink_port_split.py
@@ -18,6 +18,8 @@ import sys
 #
 
 
+# Kselftest framework requirement - SKIP code is 4
+KSFT_SKIP=4
 Port = collections.namedtuple('Port', 'bus_info name')
 
 
@@ -239,7 +241,11 @@ def main(cmdline=None):
         assert stderr == ""
 
         devs = json.loads(stdout)['dev']
-        dev = list(devs.keys())[0]
+        if devs:
+            dev = list(devs.keys())[0]
+        else:
+            print("no devlink device was found, test skipped")
+            sys.exit(KSFT_SKIP)
 
     cmd = "devlink dev show %s" % dev
     stdout, stderr = run_command(cmd)
-- 
2.7.4

