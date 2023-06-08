Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE75C728564
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjFHQkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjFHQjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4135A1
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 09:39:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30af86a966eso624248f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242348; x=1688834348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRNPtrh4/qtNxd83RxLqXaD6crOweapuAV2/D/pcw+U=;
        b=Un3Fkyk4WZcSeyKvPkb+USXGmQAKE4cyiEAXc1XkV8Oz+isJ+310fknpM39YJXcpT7
         xMb8dv8TEzPZlrJTxh8KqRRrXv7TBrDN0gvG0A7xPDXnQYNh1Rw0SNtiSmCjjkULgeYA
         bV824eAUyex6CxGsOM0Nzrm3rHe4AnTdoJfmTBdEfoWH8jVI+qq57StwYNBMYzq3IYp/
         d6D7GgfcYtVdRYo3t2/1hH/Bggf7z3dZbQq+anWEvc0lFKlCFX8+WZScz6KhjY+cYqkD
         peKuH37IgC+QJBF7nd29MYH9JtAILlx7F3R8hUYQb86zsA+c34eYVtDn6JIPa6HJB1hL
         m4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242348; x=1688834348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRNPtrh4/qtNxd83RxLqXaD6crOweapuAV2/D/pcw+U=;
        b=YEegyyNaIIp7AQNcAaIOvnSkEQdvQ28Ub2c9aiSBDqjOPbTvUKHC9nU83RatSE/ntx
         gGkq3rnwnlkexRwWvILy9mt2IAprUT2kmdsyas/Ka7IA596GMQ8P184Zk4urGZY7KwR4
         1POLRzxKT6ETLCsbYRlUWH4KjXUPzg4KxAmnkd0QvQb/rUzYI69L0cZWKPenr3nVCe7Q
         OGhOmdUyjNqmAJoBsveeWf/KgUk1d0riR/gFZxgsaiqC+Ooh9xFTCFG3nVM0r8qM4ErF
         YZHeaBjOGuDKtV2aZ5uoUcF7XC8avZfs0DmjQ9ARjoFRrNGEe3/h3eUgblxLWL/51BoZ
         tEVg==
X-Gm-Message-State: AC+VfDyZsKZTPhOGC/rkvctO4nhJ4PbDHsz9Q07JxUoWUHYtwNl4NSlL
        Q4SqZz7Y66YeqoJttL9K0y3A4g==
X-Google-Smtp-Source: ACHHUZ5iZJdIddG/7W2VPfdO3Ht89qbeIG8+GZVpkumfcegq4+3YDO4cSKUdXj66iQ4hYfXS1+lG+w==
X-Received: by 2002:a5d:4d49:0:b0:2f9:c2ab:e1de with SMTP id a9-20020a5d4d49000000b002f9c2abe1demr6785099wru.14.1686242348666;
        Thu, 08 Jun 2023 09:39:08 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:08 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:55 +0200
Subject: [PATCH net 13/14] selftests: mptcp: userspace pm: skip if not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-13-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Dmytro Shytyi <dmytro@shytyi.net>,
        Menglong Dong <imagedong@tencent.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=lCLnyi7to0GdP9Uc/eccM6C9A2GjbynXexM/0ZjcvOU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQa1p5uGknzfdbqipsdBEVna7eEYJQ1LesHn
 5K9Wwv69+mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c8D8D/wMnUOKRUij+6jmSfvUzmfQsZc+4SMaMFn+wgdn8svqr2AHPK7kCbmnqA6KX5zY1FH269z
 aWkyEdCkvRR6utKPf1YW/D0SBKTqPqEJCFU4TPE2bIhsvo3J7guHMcF3Xm3OO1bCyc+DLohR41S
 qbch7QxblDWd/vsQSfGkL0JdMObSonfZDc5LDX316RHptcu28eVEF7fIbYVlGw0c3F2DHr9ULDm
 z3JsxfqM2qLlpGw5Z5Sle9LEnxbskRy8+sihXK/P//IHSsV7UwsrDrna4p/ZTEGjT4499P5Z2Jq
 gXRxBGrzaI11tIiE0JkROQw7mPJbowZ1DHAdJ9ThntOVks+AgO1MKAom+yHf23vzJMYjbRrZXIW
 HjkBUUfoE+9AfIVUnRdVD6x5I012PLjb+UquMvymYnOZ6wEdslrkJROrK1LD7vNOEa79zHz8ci+
 0hlduCLvV2W3CiyILiQ6PfWzlpxYnI0FhJKBhNoi9XD8UC0Akh81nVo0hOYJMAwpGH8t3dHy77I
 NY09X5fxFc3cEF2mzeQzC2NSTM0QN4zb43J/uFfzGJbYROEuiveDhmo9m6SyrA0Hp/zmORxLlgs
 r3teRyxJMpvkN5YfYn4srB6c4XTKjsqJJOrVGf1UI03CUwKJUYOdTaxITNFNFXKWVEt67qu5WTp
 Sz9RyljYaDzfb/A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP Userspace PM introduced by commit 4638de5aefe5
("mptcp: handle local addrs announced by userspace PMs").

We can skip all these tests if the feature is not supported simply by
looking for the MPTCP pm_type's sysctl knob.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 192ab818f292..38a1d34f7b4d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,6 +5,11 @@
 
 mptcp_lib_check_mptcp
 
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"

-- 
2.40.1

