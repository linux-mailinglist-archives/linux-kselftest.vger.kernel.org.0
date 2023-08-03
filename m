Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0576EF61
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjHCQ14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjHCQ1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:27:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B33AB1
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 09:27:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3177f520802so1473738f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080069; x=1691684869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBnIPaLpUBQo0kIbt1VtWMaNdY6vXScOGJHuxsyxb80=;
        b=Tl1CBteXvZksZc6XFPE19x//hK3eTgSZXpehyGdVUlUYc1c4XhbKbtTvV/MadlUO2K
         EU0UhkI31jFrxkQX8As3FeXlFlTbvnYiX3pVV3oz45CYY3HlEcFZJTBYiiLvWVBRl3mr
         hYVdN91cO+c77JOi5iIzRLzuJHMphc8pYEzzlshs+8NrjHR6NNCTM9rGm9930shPvAlb
         CAETCrou+xDeZ3aYdgwFCJUHVMZq9lbsCssev2CHU8WxKPa7ss1HbAf2+Tqlb2ExPM+A
         8ZRMPNbSaEA5nbq8ERxGJu+9mUSOX3jmN6A/saWzGCdWdxLY1gA19wBBbJpnd+b0FxnJ
         Cf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080069; x=1691684869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBnIPaLpUBQo0kIbt1VtWMaNdY6vXScOGJHuxsyxb80=;
        b=L3eTyGlwmrlFs/j3osaVs20WR10+hJQMj93gzSvztS3pwZKXvTJHlL3V6skydTDVAq
         L7DfzjeDeMXt19hHkrfwV+MBLZPj3sUT98SHYrwpudhF+TEYWXWgObzJoIzciaNhyg7l
         2lmNESNeOnafRablhyO/cNm6E3a9xFDn8yuNxq4g+Pf9wqwh1St4mkRiip1MkwNmWGje
         iJnrTC3R/APteTgEERcebPK3rp9Reg8pXSQmxbbwKPlQPFBoXGM+qnY5q7DbKpOLcbu2
         t+OykCsp6T60u19AUVPo6kg0fKtJd98C2sZ/PKH1Ml40cj4yjFNqMoKbt5VLEKQwUeN3
         7b6g==
X-Gm-Message-State: ABy/qLag7rSrDhjGWzyZetWz/8am7fMy+zIjyLvw09IxnIFYxGx6SGlg
        N87kD9kmMObk4Gn2OS2tp523cw==
X-Google-Smtp-Source: APBJJlFrCTmGtUyj8DEzG5dbqfh/5TPifKxWOHdkGuYEm0EErlHgwew30hIE5BgUjIpCwVkn5w5guQ==
X-Received: by 2002:a05:6000:1a47:b0:317:5efa:c46a with SMTP id t7-20020a0560001a4700b003175efac46amr8097820wry.27.1691080069077;
        Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:48 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 03 Aug 2023 18:27:27 +0200
Subject: [PATCH net 1/4] selftests: mptcp: join: fix 'delete and re-add'
 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-1-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hfqRzKxGyaUEWgzy2QiBCH3NjrZO3p7pR4iRluGjJ+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCVBTSFtFVA9hiSUR5uWKhdSZZFB+b8F8YM
 07eJUfLXiaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c8IUEACLIP5dcRWU20s4Av9wjL/rYYWQRKsTzptp5p2mVJHQaDU8N8op/BVmDAKBqt/pxA8y9X2
 VdFWG08EVnJjZuHIj1asuj8ETOas4S/tTWAVgGjyHFuVIJdtR1xVZ+EO2u/sWnZ/pfe/Zn3ri2D
 BQbvLMPx/R8EVN1XTmqGZSs+Dg7Qi41bzi89gzRx01cvs9LjVUrbTnknKtALHMueq1U2YpNJ45c
 Jw8u7HTCod1UvlD8jadC8MNomMme66rAn8+8ahuPR0gnNShHrwFcfFhkVfZvV9AiwkENEcaEH/u
 psGioGwajZwJAdcFFcJa01OhDVhBPLWQSLsFGOK/uhR4bnU7oJSKm++znAatjb2q+o9PceG06yU
 8nR672vgkXXyO8M/UpHKIczRcrSJF8whkgbKQVU3TxPVYxb68cjnz9+YFiQV2jyj2UY+3vTXIxB
 YshS3lHT5S9MEUNT8YLCAlk7rwocVMAH2Mbpt46xVPbHmTLD5VxseqJqc4wcXYxTCKV/P0bwWOQ
 mvm0+M+ngNK4B3uhSLuecyfgP06r5ay2imfu2du2L8vgjoTblFI1t6ODh57SZQuHhrCycGUujN3
 k0+MbKFpIrvp3Nkij1jENsbyGVZJ5ajuhmDfiskNpdTZTK/ciVUyJB0y6ULrt2JGgAssB6nZtU6
 uRagsMcCbX2XFwg==
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

From: Andrea Claudi <aclaudi@redhat.com>

mptcp_join 'delete and re-add' test fails when using ip mptcp:

  $ ./mptcp_join.sh -iI
  <snip>
  002 delete and re-add                    before delete[ ok ]
                                           mptcp_info subflows=1         [ ok ]
  Error: argument "ADDRESS" is wrong: invalid for non-zero id address
                                           after delete[fail] got 2:2 subflows expected 1

This happens because endpoint delete includes an ip address while id is
not 0, contrary to what is indicated in the ip mptcp man page:

"When used with the delete id operation, an IFADDR is only included when
the ID is 0."

This fixes the issue using the $addr variable in pm_nl_del_endpoint()
only when id is 0.

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3c2096ac97ef..067fabc401f1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -705,6 +705,7 @@ pm_nl_del_endpoint()
 	local addr=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
+		[ $id -ne 0 ] && addr=''
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr

-- 
2.40.1

