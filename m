Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B542DD30A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLQOen (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 09:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 09:34:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A53C06138C;
        Thu, 17 Dec 2020 06:34:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e2so20437364pgi.5;
        Thu, 17 Dec 2020 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqJrHzwrbVCnYsklx/lbZ+b/PHnqbPpGX0MwSNjrUx0=;
        b=t+YqQn+q8oP+JS5tuezkORM/ouWFBiFsdi+TJ2+RV8BDwUIjGdimnJ4zP6IcEXt0v2
         wG4l9UEOrBetfNTetpTyxDSic549Tcxlf6Vw8PGQKgqHAk+JdYbTBQqsXtx15TavfS+d
         Ab1MAf/FkVo5LRFFPYjBWbAkyfGGo5cvR8w0b2OQ1omSzfzQXD/OLNNYpSpi+ut/rnh1
         9oWSLdgyy1izj/9AtKeGq4mk1+eh5EeGVD25kSu+vnC3iyv5uMh2mhdFRldiLOpZh7Ne
         M0o0wGqqpDioSGbAr4SJm3GdJkdr0WN/yu8g3ss31yEYTDSN548XnSC0BcyrXHcqkxbi
         KnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqJrHzwrbVCnYsklx/lbZ+b/PHnqbPpGX0MwSNjrUx0=;
        b=dj1HJRdFAKzTnYhslz3s2XS/ehgwtKR5Oy3k3FIJYFwuBUxR3QshKY/qBgnZ/Z485B
         wrrGx71VIlSCUMhLbb6Ar7jK7Xx/EkZ3L9gGm2Fb+3a2ffZi1AZdK6CHoeJUnvcA1xG8
         ju/d7ZKb2BLhOCSpkzcUBWt+4PsC4LyBq62ZT+59GPNLxKGOHy8JLnFj/FrkSc5cl1E8
         gogVPOxXihyz0XZUi/ioT++SQoTQoAueEtbeQpmhsKpEI5lZX1L5a+MgCpZXwdruPvsS
         ZUA70F1ZbL2M98aV+lT7RFGH1oL4IdY5X37A1dVctn7Q9Tzuy/3jlBfx9vBKgEiunQYB
         Gv4A==
X-Gm-Message-State: AOAM5302Zdwk7lGn2nr2fD/AnVURZs0Qd9l4yRW7W8rmVJZN+vGOTI5/
        PrDd3lNf0725U0mL6JrYl36iGrrvLDQMcQ==
X-Google-Smtp-Source: ABdhPJxyUFWlxo3vqfDdhCyYFQmcNByGDl5ae49O6LLHOXx39EpzMRWGDvdlLo8qUo3P0URQrntbKQ==
X-Received: by 2002:a05:6a00:ac5:b029:19d:97c2:d3a7 with SMTP id c5-20020a056a000ac5b029019d97c2d3a7mr30140018pfl.61.1608215641440;
        Thu, 17 Dec 2020 06:34:01 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id v6sm6102924pfi.31.2020.12.17.06.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:34:00 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftest: don't offline the last CPU in cpu hotplug test
Date:   Thu, 17 Dec 2020 23:34:32 +0800
Message-Id: <20201217153434.10945-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In my box, all CPUs are allowed to be offline.  The test tries to offline
all offline-able CPUs and causes fail on the last one.  We should just
skip offlining the last CPU

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 0d26b5e3f966..5cdef96326a7 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -126,6 +126,11 @@ offline_cpu_expect_success()
 {
 	local cpu=$1
 
+	# don't offline the last CPU if all CPUs are offline-able
+	if [[ a$cpu = a`cat $SYSFS/devices/system/cpu/online` ]]; then
+		return
+	fi
+
 	if ! offline_cpu $cpu; then
 		echo $FUNCNAME $cpu: unexpected fail >&2
 		exit 1
-- 
2.19.1.6.gb485710b

