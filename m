Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662C4A4AD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379258AbiAaPmN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 10:42:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379784AbiAaPmM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 10:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slqi+eFgPyIV91fplcPLPuJfZVr8h1BVcJVDtOG3dfs=;
        b=WmGC0IhVsqq2Fjvuq0HxWAuxybYAeYyTO95UpsAmDGJYNTW6ZcnEaUwhgZxd2cqeyIgKWc
        zxjoHdIdiauyWzLtOXLDFnE3SmIPQoQACPxRYV02OBYN/o9sxRTpzuDIN6ZMYz92iKy/iU
        TOwD6Y7e9jYWTGMTpePNmwNWlvvIdJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-R04qHEVNNs-ZvnGfiqSLjQ-1; Mon, 31 Jan 2022 10:42:10 -0500
X-MC-Unique: R04qHEVNNs-ZvnGfiqSLjQ-1
Received: by mail-wr1-f72.google.com with SMTP id x4-20020adfbb44000000b001d83e815683so4955538wrg.8
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 07:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slqi+eFgPyIV91fplcPLPuJfZVr8h1BVcJVDtOG3dfs=;
        b=vh8NjKQkHiWbBWYLJ8izM7Npc1y1lUYygu4HrtXM+9gz6y0bdkY0w2vuZelhXUKr/s
         NDR2wR+22rjdaYCjhk8HQRTOeRXPFdfc8KtdYSPsDmWqtqVGq8f0wVLdMR3lBzSKX9vL
         wzXJNPE7uw8/vMh1KEmH9K2j6deIHxpjYJn/rFwUMewiJTCHttmCFsMfn+KoYPWqAmgV
         QGSaqttFfCKgs2rkoCk7lPlJEYj1QV7s4OJQ5Go7vi//6W4bRFETYOs1JGWkxqiqzfP8
         xsr1NU24/LKP+8Uv6VjsTRezeDsiWD7r02rUnToaLUmtYG+5j2pCpTesSoY1k4CdNYsK
         UbiQ==
X-Gm-Message-State: AOAM5311bJGTsbW6LJVuYXVR+DNHyezhSLjApkUkdtwxEkGm0tDxQv0K
        y6QOr6kViKJBROpAHRN94r2zNKDHGpyyDZ/+fKXwzAEKjE1Dq98gKmgJHO2pD1c85/22fOU3oyB
        oI9/15Z5urW07QgcG9Sh5VaXNhFPl
X-Received: by 2002:a05:600c:3217:: with SMTP id r23mr18796169wmp.159.1643643728867;
        Mon, 31 Jan 2022 07:42:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMLn8ts+Ww3+PnE/eJvxpKnuFYaYejpPPPVrdfW9EaLvIgjdFDBxVx65LUYPgD/7F0PC720g==
X-Received: by 2002:a05:600c:3217:: with SMTP id r23mr18796158wmp.159.1643643728737;
        Mon, 31 Jan 2022 07:42:08 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id p8sm13210073wrr.16.2022.01.31.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:42:08 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:42:06 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>
Subject: [PATCH net-next 3/4] selftests: fib rule: Log test description
Message-ID: <acbd79f04f87f0605f04264bfd2d101e1bfc75df.1643643083.git.gnault@redhat.com>
References: <cover.1643643083.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643643083.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All callers of fib_rule6_test_match_n_redirect() and
fib_rule4_test_match_n_redirect() pass a third argument containing a
description of the test being run. Instead of ignoring this argument,
let's use it for logging instead of printing a truncated version of the
command.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 012f9385d68c..6a05e81fc81d 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -104,13 +104,14 @@ fib_rule6_test_match_n_redirect()
 {
 	local match="$1"
 	local getmatch="$2"
+	local description="$3"
 
 	$IP -6 rule add $match table $RTABLE
 	$IP -6 route get $GW_IP6 $getmatch | grep -q "table $RTABLE"
-	log_test $? 0 "rule6 check: $1"
+	log_test $? 0 "rule6 check: $description"
 
 	fib_rule6_del_by_pref "$match"
-	log_test $? 0 "rule6 del by pref: $match"
+	log_test $? 0 "rule6 del by pref: $description"
 }
 
 fib_rule6_test()
@@ -176,13 +177,14 @@ fib_rule4_test_match_n_redirect()
 {
 	local match="$1"
 	local getmatch="$2"
+	local description="$3"
 
 	$IP rule add $match table $RTABLE
 	$IP route get $GW_IP4 $getmatch | grep -q "table $RTABLE"
-	log_test $? 0 "rule4 check: $1"
+	log_test $? 0 "rule4 check: $description"
 
 	fib_rule4_del_by_pref "$match"
-	log_test $? 0 "rule4 del by pref: $match"
+	log_test $? 0 "rule4 del by pref: $description"
 }
 
 fib_rule4_test()
-- 
2.21.3

