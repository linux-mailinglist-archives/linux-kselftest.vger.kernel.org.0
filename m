Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D944756488
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQNWR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGQNV6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C743199B
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so41186095e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600105; x=1692192105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNpnmzuYMAKwrCxb2z/tH+HC3idxZwgWFXVOTSz9bCQ=;
        b=DmrHdWM4SJ8p/7y3CQTgZ2PRhIeELaNzcJXZy1OyMUE8aTlE94YNVPnLC0hd31L2de
         plQxfClK/Oaey14A2/nTBllh+BFxmFray0H9WcaifLuE/ua4GacnI1NQKG/pndwgW4ne
         VlnrJ400vS24WbgtDFweb+5i0kLsaTO0X1IV4QUoFmbXU95KrJwNoDF5XNvZCRl+2XBy
         zhLyOpVAtk9SreRTvUE/06Ml9qGtPHRKh5TZ+lp8RdRip8iDOhmnPOhZ4x0Sg2hXPWP0
         vtY54zsEIBW4ByhOeARixykxFQlRn2iohFFUXfC1iHAaXawZSlWzoc5NpBfNrI+BvpNm
         i/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600105; x=1692192105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNpnmzuYMAKwrCxb2z/tH+HC3idxZwgWFXVOTSz9bCQ=;
        b=Gb2y5kKU9lK+BAiihwQuG/E3UYZs8HJEbP8LKuc2UredE3fleo4pWqKkDy3SbAZYqC
         JjVrfSVBKEqy2NxuilP8NADXMfoP7vJGKKXUVvKVpsdyKGcNHBvTTllH8wdI9TliyDOk
         9NdGAi+3K8o2rlFumNXFnSPdNDHgcHDic6kuc1+/w61GH535oIUfqF2N4MReC2TWEAtV
         SvCKw/jaVIu/pI2C6DE5CfFcDnb55XIDFZXTK9pjSqob4dxbqgaKUR68DjL/MR8gBI3G
         7tQKscQMqnN8FtHk79Kz3Vf7xhqpqDA69esONe2g6kmdOil+ITwWj8Nz6Du/YEBkfY9Y
         eRXw==
X-Gm-Message-State: ABy/qLZIfhu1GljvGpr+vvsueTv3VgWt+k/KGfVJg2iZX5CPk3HjkQxc
        EWzc4NGPWu8NKMgdHEMZE04ZAw==
X-Google-Smtp-Source: APBJJlFQCsQqlfLxjo9DA0r7PUcvECDspN5Dcuczg+W/lNUZFG3e/JQOGGGAXiOQ1UhblcHjjmXu6g==
X-Received: by 2002:a5d:4b12:0:b0:313:f94f:3b15 with SMTP id v18-20020a5d4b12000000b00313f94f3b15mr10492925wrq.2.1689600104948;
        Mon, 17 Jul 2023 06:21:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:44 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:31 +0200
Subject: [PATCH net-next 11/13] selftests: mptcp: simult flows: format
 subtests results in TAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-11-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=omBnUHRU9N3QOZYPdUCMphvA7FerRHVuKdmTtTNH2r0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdfFA7VqtWidJmBkSXruI3mkrTSPePM+LSl
 Ny2sl4xKQiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c2tzD/0aXD5RjfWLRekq1u49sOHl86tY4l5b0mdd4JI4Qe00RWSvhQrIZvfK6nRF+Rq/HVNoLwm
 cte2dIyBatY9PQKUrcBOiX5V5oA8vzwF9G7ZPS0+DJk1JvRn6pbqbm5/YDHX+t36aGRH5NRQMPE
 sdspTSAsAw/HyZeQNWc9Eh8pVglolalW2mwdku0XZA6gyYtcP/DcFZ+0W4t9L0G5J+yfE32TJYu
 TFUNcEeb73xb7eQfTaoY1xHQTKhTDtjwaShdSnXmtj3miKslhTpSNlNLFgchu4OlbPnaJMDVb3W
 kNawnAylF93fuDzunMmIf/PDzE8q99HiXIYO6sHkaNfSyX4ZfFUdKD2hx48E1qZZM4X27DWz1HV
 duXnF25va1i8F5ecaG0GBabr6whZd51nF6vpoZCovSmK7v5XakiaHjNhpWEI1uV0wOx+i6eTvIP
 eAXg8HQMlXOby8fG2kQMg396WRA2V4DW7R73KVqZP7O9lc8pymTDyH7VahDz7NFJGKDbblFxzjy
 0QCczvpPBR8HDSCpsQ4/lmx+0p1YL401QkfqbczpHDB8KO59it4yWBsv/KZHMYCyogsY4wN0p79
 VpucBK5T/Ptd6D7XQMbS4TlIk55LKNU3M4lTyt/CKm8VmXlD8VRVhBF9kvAU8n6FY0H9V/6mKQ+
 xB6r9Dnf3cRIwgw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in simult_flows.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 36a3c9d92e20..ce9203b817f8 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -261,6 +261,7 @@ run_test()
 	printf "%-60s" "$msg"
 	do_transfer $small $large $time
 	lret=$?
+	mptcp_lib_result_code "${lret}" "${msg}"
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
@@ -269,6 +270,7 @@ run_test()
 	printf "%-60s" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
+	mptcp_lib_result_code "${lret}" "${msg}"
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
@@ -305,4 +307,6 @@ run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
 run_test 30 10 0 0 "unbalanced bwidth"
 run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
 run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

