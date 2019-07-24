Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA273156
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfGXOQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 10:16:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44449 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 10:16:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so21009327pfe.11;
        Wed, 24 Jul 2019 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2niVLsdZKtUu10jdvC8RdtEQjbdxPl6wlDVDqafru4=;
        b=mGsmj29nBng8l3G9WUE6TqeL5PhM7V5sw7PQDuNqCPdg7k7t6yLaidwBZlFCYe/ZkU
         0pU64QjvMfcd/cDOmR3jRMVfxtXCnV8p4PyAlmcjF75KjEu341B+FpHXG57SC5VChmcl
         Jm65sd2ShUaA8ApPk4qoOSn4nLIMYlvejCioknX0xdVUxFdRzHLu62nE75JtptFYJwpb
         y83NAxY1U0h80mKZ+msygNKGuzhhh8ixZ68wJXhvSXsNZBslzGQuktcY3c7pmbKd9vPw
         fZlvBNJBZ9e++J0qM+aCLIT2x+jJlSD1q3nGm9eKgIR1bB2AmjusGMejBp6eMXudnS72
         G4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2niVLsdZKtUu10jdvC8RdtEQjbdxPl6wlDVDqafru4=;
        b=GQeAeOo0mW6La5GMHT5T2itJbLf+0fuMnn+j49rj5CqEJOwlLfK2KvEYK9Fe//9wXj
         h8PipzFTMj9S909msHIy2jpelVf646X7sBZha9VwTAb4WnwXvzXrWT+4xRffM4QXKFzA
         9zwPbKaU3LKA8vGdSdSQZHK9dt+5LULQeULDa3gJBw6HKeUJM9bzN4mqP+5/hi8NF5Om
         Ykz9pbwd7iUhEkNEp91oyLskC/0346WvH5Olf/3y5xYcsPUWWSrZSbisIslPYTqDNoSY
         f7nAHIUaSGe28B0j+k672OJ6zSqT94K4pkMVTFWVW7b2Xe1zjiDWwajTXiXp5gL0IBoG
         rmcQ==
X-Gm-Message-State: APjAAAUB64GTnDg1d6kt7rjiX4fWThN2Tcb9HYTrbP7QKx7yOepilENJ
        GLbXlRAOzHQjN7zxLDFljdo=
X-Google-Smtp-Source: APXvYqwSAT17fwPwcWVMVT9/K/beHWmtX06kb53WhP7hy4B580mMpmO7dwD3E2Cyf5G55e6B3R4MLw==
X-Received: by 2002:a65:60d3:: with SMTP id r19mr56459815pgv.91.1563977760057;
        Wed, 24 Jul 2019 07:16:00 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id f88sm45672023pjg.5.2019.07.24.07.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:15:59 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id DC3CA201374; Wed, 24 Jul 2019 23:15:56 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     shuah@kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com,
        idosch@mellanox.com, linux-kselftest@vger.kernel.org,
        rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] selftests: mlxsw: Fix typo in qos_mc_aware.sh
Date:   Wed, 24 Jul 2019 23:15:54 +0900
Message-Id: <20190724141554.31723-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.545.g9c9b961d7eb1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch fixes some spelling typo in qos_mc_aware.sh

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index 71231ad2dbfb..47315fe48d5a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -262,7 +262,7 @@ test_mc_aware()
 
 	stop_traffic
 
-	log_test "UC performace under MC overload"
+	log_test "UC performance under MC overload"
 
 	echo "UC-only throughput  $(humanize $ucth1)"
 	echo "UC+MC throughput    $(humanize $ucth2)"
@@ -316,7 +316,7 @@ test_uc_aware()
 
 	stop_traffic
 
-	log_test "MC performace under UC overload"
+	log_test "MC performance under UC overload"
 	echo "    ingress UC throughput $(humanize ${uc_ir})"
 	echo "    egress UC throughput  $(humanize ${uc_er})"
 	echo "    sent $attempts BC ARPs, got $passes responses"
-- 
2.22.0.545.g9c9b961d7eb1

