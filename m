Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482E72ACDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFJQMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjFJQMN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658193C1D
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so20275555e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413519; x=1689005519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwBS5XsIXb7JpQCDDkpG6qW44kDRssUwnX3b+fqWvBk=;
        b=iVFgPBSAcrATRVA+d/IBU5wmB4/sLJigUZokDq0fFxcSzFo9gEeGCGrDwJTWJ6R4q/
         cxT3cjKGJEsMiP482CgcNNUJn8wIC1BSiLCgwHNz5A6nl7zHTkxfD105IxbpnGULHl+D
         w7JzvG22cLk38HjWhP/G/wOqZJWfTfeUjOEugF6MXax6zwiPy5FkBI4Emq2NJzmryo2a
         YgiNqGNxrPLHKQo16gtTJBVKitS9xLs2NPgeC0TpB6EmpdNg/TiiNNDVf+8qHNz+KH5j
         p2QPPyGTwv7czz782XjfldneBtK/DqRFMSyYfL+FNdQfav9L4BJ8uHYHFvt+58bSnv0/
         WGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413519; x=1689005519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwBS5XsIXb7JpQCDDkpG6qW44kDRssUwnX3b+fqWvBk=;
        b=X3X8LUsRzzPSClg0RwJemQ4ixH/UlKvqD51VXwcNV9rq0SGvavLT4YAzBxdRtOGDxf
         ByWTZkolbOCes3LX8BTCJkwJ+gHZxOK8tgS1aKMFBIYsKnb3p4ghZDtmPJFDFET7kP07
         weAFjxQ7x5KVveHySMK+ob/yRtUV/c94uvDgwSX5VoNZT96zHTaUGgY2U/Yv+5yi+wka
         lvjCSKHbJendxL+wh4aS8y2fXrEu/lvHW+B6zyirdbR1q3V377siWh/st6+L2pidr6vY
         1RRFm0lG1iDN82TfdXDKRspNyNBB9v1QbrQhegtwnjFW2ukRPeovcaTeY5NaLrK+9DSj
         eDPQ==
X-Gm-Message-State: AC+VfDw4eWxVm3sguovWK2c3HdPPOrW4EIaIFM0WenBFBzZ0edsEImcn
        fhTJqsVGkQrfRrE7th0thdrTBQ==
X-Google-Smtp-Source: ACHHUZ6hZJ5NptZEQr7LUv7QJ9KNWT0th1+dElnufHYec1/1yJtGyeIlbJQDIxDyoATGkemjIx22Kg==
X-Received: by 2002:a5d:56d0:0:b0:306:37ac:ef8e with SMTP id m16-20020a5d56d0000000b0030637acef8emr798312wrw.56.1686413518905;
        Sat, 10 Jun 2023 09:11:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:11:58 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:45 +0200
Subject: [PATCH net 10/17] selftests: mptcp: join: skip backup if set flag
 on ID not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-10-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=KOwpP27/0y6dtujUDn5E+rsa3xHnBdzaOiL6LOjRD8g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+02DQFIemtIevGukKRqk4zhZgRlDuMPm8l
 vM1lsZHrRGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 cxE/EADgZVu3gMyjdr9M8ZBEYOrU5gn6Lmyl2oVw4rY9KNRnI/YUq6JoXAU6dXmd+X/h5vkJ7JJ
 WcP6rXfL8VzSJ/4UoiVzP/vE69rc/ifUPOTPUhHpRH+9toeOQ0vWD17E2CdTbXIgdfDX8EV8TzP
 LZIzbawWBVbVfhtQJm+fP5MrT7A+3b/g/yjVUTw/4tgAQy2dfLMWiUltITxlFR8KdY9qZauyOa1
 955yp8+YvhhzEIhFIqQzJnBNsa8fSV5PsjTFL7hI9vAknu09xl2eqyJrgFSHrqMSze9dBqpZUjA
 mDgJMXp6/7yHe8e1pahhqdIsH9LWaqi6nGHEUoRlmzJBLyLqVtUCp8wm422seuEOtH+udawHo2M
 s3SPPMzjisKqyPdNAL6PVHt/rhvVz3V+cLhRB3ScjpOiXEKCgg441pAkvSJcjeYEn9sxCSQ4tzl
 KO3SgWcyDnbbn8nYhOK4ACxiMkYpI1EBx5WtMudwr+ukKaJCUe4YFAzQ/iJ7+jTZ8esMKD0RlLm
 luV6HzzguXhhDjVGzlP8qCsx6Js97LIJcMImCUr7t/MaWqaeWSIA0lv13BhmSg7dzWvQl5177CT
 rQo97sNAFbpo1fM88kLuZiSXxjEl+I1szrkzZoQAw3bJ5H/Q+y0P+6mFKzLupMbIE+ZHV80/1dC
 mxnx11IDV+PmiZg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Commit bccefb762439 ("selftests: mptcp: simplify pm_nl_change_endpoint")
has simplified the way the backup flag is set on an endpoint. Instead of
doing:

  ./pm_nl_ctl set 10.0.2.1 flags backup

Now we do:

  ./pm_nl_ctl set id 1 flags backup

The new way is easier to maintain but it is also incompatible with older
kernels not supporting the implicit endpoints putting in place the
infrastructure to set flags per ID, hence the second Fixes tag.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: bccefb762439 ("selftests: mptcp: simplify pm_nl_change_endpoint")
Cc: stable@vger.kernel.org
Fixes: 4cf86ae84c71 ("mptcp: strict local address ID selection")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7f860a93527f..adbe297a95cf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2679,7 +2679,8 @@ mixed_tests()
 backup_tests()
 {
 	# single subflow, backup
-	if reset "single subflow, backup"; then
+	if reset "single subflow, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
@@ -2689,7 +2690,8 @@ backup_tests()
 	fi
 
 	# single address, backup
-	if reset "single address, backup"; then
+	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2700,7 +2702,8 @@ backup_tests()
 	fi
 
 	# single address with port, backup
-	if reset "single address with port, backup"; then
+	if reset "single address with port, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1

-- 
2.40.1

