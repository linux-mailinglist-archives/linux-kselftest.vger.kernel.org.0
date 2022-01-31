Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957F84A4ACE
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiAaPmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 10:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236278AbiAaPmH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 10:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sW7rzPQhozZJd5bIGL105H+ak+PyChDVEsMpXF5SsA=;
        b=cG8Dn2Z2l5t041xxWBFu0uYyJmYiz+myZAIv80YS30B6xrHrwx7tcX4wpMY7uEm9YzYWci
        VPbc6GHkq6ckPJ5klvNUMCoaWkbg1nMgW9KxRMTW7osuhudnIsOPzwB9XuDpfwWUNVBuwo
        hAk+Na2aF0Bjb2JpkU6hN2L/ixYuBTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-e3YW6kMOO66Ewrn53KQLWg-1; Mon, 31 Jan 2022 10:42:05 -0500
X-MC-Unique: e3YW6kMOO66Ewrn53KQLWg-1
Received: by mail-wm1-f70.google.com with SMTP id q125-20020a1c4383000000b003503e10c027so3092366wma.2
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 07:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sW7rzPQhozZJd5bIGL105H+ak+PyChDVEsMpXF5SsA=;
        b=X0QgF1DxpIurqHeGs/66E+dCFEHtNcDzHUFuk+QGuMSI/mDNkxE66M7TEM2760TOeV
         h956blxuXA2vCcdQ1FAUBHp6JVLKkmJIeHeTjk3CZsoFouWAx1IhhVqD2qSbkViHqTfN
         aQm0bnPQJYOkubH/SoZK1JggXeMBHKURzOfkUJlU3KB6myfPTwmo8TSjdBZ9jwqRKofW
         CZRL/KIoKPI9PzaihdzUV57O3F7JfTkfim3VYfxJEigZrRcf03ANqkwBbL9Pgr0YJb9/
         BH1FwNgdxwMT/yoXNUW6ZIrm97ha/eFNYExQtqqzudqgkO0ufQQf2mNNX4gn6ksEfthm
         fFPQ==
X-Gm-Message-State: AOAM531+BUMprClkcrlc2ejLoXn+cnBThnH1gD4f6m3751oH58hwBf+W
        uLcJeuuydmKriEkHrT6ZWCC8eNIjr1ne0JjCc3jAg5sIZFYCXqOC5vkjNkViLVwRuwbf7YfSCy9
        oF4ll0jU/8WLB8T3yduEjUTXUI9VU
X-Received: by 2002:a05:600c:4606:: with SMTP id m6mr18884793wmo.158.1643643724082;
        Mon, 31 Jan 2022 07:42:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxby5+LXKmhGyrUYjq8E3JvF/Tb4DHqOiKvlAvELRnZXgXmO2oDHs3fV9s7zGDIfs9YNcWdTw==
X-Received: by 2002:a05:600c:4606:: with SMTP id m6mr18884782wmo.158.1643643723938;
        Mon, 31 Jan 2022 07:42:03 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id p17sm12454713wrf.112.2022.01.31.07.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:42:03 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:42:01 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>
Subject: [PATCH net-next 1/4] selftests: fib rule: Make 'getmatch' and
 'match' local variables
Message-ID: <6c58c82747ac8351105a0d25eefc594206d414d6.1643643083.git.gnault@redhat.com>
References: <cover.1643643083.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643643083.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's restrict the scope of these variables to avoid possible
interferences.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 43ea8407a82e..f04f337dd7c6 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -115,6 +115,9 @@ fib_rule6_test_match_n_redirect()
 
 fib_rule6_test()
 {
+	local getmatch
+	local match
+
 	# setup the fib rule redirect route
 	$IP -6 route add table $RTABLE default via $GW_IP6 dev $DEV onlink
 
@@ -184,6 +187,9 @@ fib_rule4_test_match_n_redirect()
 
 fib_rule4_test()
 {
+	local getmatch
+	local match
+
 	# setup the fib rule redirect route
 	$IP route add table $RTABLE default via $GW_IP4 dev $DEV onlink
 
-- 
2.21.3

