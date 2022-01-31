Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B504A4AD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379792AbiAaPmR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 10:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379784AbiAaPmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 10:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JlgLZscDoIFop5dBhXgA1KNuotqIeX45MP+1J3nAYY=;
        b=YeFsNng0zShieqie30KAPYmGtfDhnkTyhyjyaoxkaXQDD6rUrPOC4gPkKFjm/x6O+QoZnw
        Y6lLduTuQsnWqJLcTWbcw8QaBT5tS/9hMGpBTCMR5owlN/CF3Gq40ppbzNV4BN9es2qNEQ
        lcf8VhOXfLzbJ40+C7ex1hSZJsZlsf0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-7LTfXTbKPWq2gqfrPVYOfg-1; Mon, 31 Jan 2022 10:42:13 -0500
X-MC-Unique: 7LTfXTbKPWq2gqfrPVYOfg-1
Received: by mail-wr1-f72.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so803031wrr.3
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 07:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1JlgLZscDoIFop5dBhXgA1KNuotqIeX45MP+1J3nAYY=;
        b=DQcHFFCZ4OEMZHaXh2p8M9TGolC7WEm/0jDc4RObnKSIOYL/08+ePjEBuehfKd//Bk
         mJpQGJZbDflq5rLzidgKpv77dr3bEHR8Ook0ivaIw1hqbybMKFEF/mGG45ZSN3J2eHzD
         7LOejUggFW2JU0f7clP3s56hWg6bbvvft8wTVswfClvHyqbCuqgJf2FtKVtKy5KAxSqS
         zXDWYr+2uDfpWdLcSpAD2h+ke5eo5t7j6RYD8PDPSDwJqSotXU9+RhIZEBi1tYHH5Cdx
         1Nw8YxScE3+LKFK5/W52CbTIceu/Im9DvLaP2UOrU/fN/N7laJtbAS1DWDSrhXMurQe6
         oEqA==
X-Gm-Message-State: AOAM533eibZARLsge7X9LakpaOZJL9ZFI+Iz6NVVI94B1wus6y2jNbza
        tNvU7vbTz8tGEzzzTuL09n/A1VX0ecCpXbIw0td+OJTO5KsTeLGzoAKG89jB9bvReE4Qm7cUYPo
        qXGi4ND/t9zKod+uhEMv5sUAB8g80
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19027261wry.656.1643643731549;
        Mon, 31 Jan 2022 07:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygQlVQ+YgRpR5xEHj4gvtNZSfcyjb7bmNGvYeSOgWRfcZ4vdWME0LKdI1icjsxp88B6wNo3A==
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19027244wry.656.1643643731344;
        Mon, 31 Jan 2022 07:42:11 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id f13sm10379789wmq.29.2022.01.31.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:42:10 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:42:09 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 4/4] selftests: fib rule: Don't echo modified sysctls
Message-ID: <6baa96248e33682166fa295ec98a472d02f4767a.1643643083.git.gnault@redhat.com>
References: <cover.1643643083.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643643083.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run sysctl in quiet mode. Echoing the modified sysctl doesn't bring any
useful information.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 6a05e81fc81d..3b0489910422 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -200,11 +200,11 @@ fib_rule4_test()
 
 	# need enable forwarding and disable rp_filter temporarily as all the
 	# addresses are in the same subnet and egress device == ingress device.
-	ip netns exec testns sysctl -w net.ipv4.ip_forward=1
-	ip netns exec testns sysctl -w net.ipv4.conf.$DEV.rp_filter=0
+	ip netns exec testns sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
 	fib_rule4_test_match_n_redirect "$match" "$match" "iif redirect to table"
-	ip netns exec testns sysctl -w net.ipv4.ip_forward=0
+	ip netns exec testns sysctl -qw net.ipv4.ip_forward=0
 
 	match="tos 0x10"
 	fib_rule4_test_match_n_redirect "$match" "$match" "tos redirect to table"
-- 
2.21.3

