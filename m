Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79250713B3D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE1Rg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE1RgU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 13:36:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C463CF
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso16591875e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685295370; x=1687887370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVE6CUkf5Xm7j0hYIyU7Kgv2NM/UdT9FCbmvgEasBPI=;
        b=sOOtbh6QGU3DQCiv9d4ZMoWHoWFR3uzyNpT20ytEIvDUyU7IoNvnpydAyXUas08CKz
         wxsfgex3RPYnXg3k/pNhwTkfhP+PH+wNA5kexFQNwjwxx8s4DH96CFjblCAcqrY/p7+X
         FGR4E3sLUku8nfsqo8Rc1GH1FexmX6o7yj/DtO51suggyy7LBUkqXxfyEgrPuN9sUQV8
         3Uc+S0hih4LfPo/SLQO4mKMZu1cXIt37yN8LJEQ0XxLWP9QRH5OEYGtg+o/UQj3V8gFN
         GP3MKE2n46ffENt2yrP8ql1GeVcT887QagZPwmGmtBEqvMviEpB/a+bpd4WA0uLFwajM
         mXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295370; x=1687887370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVE6CUkf5Xm7j0hYIyU7Kgv2NM/UdT9FCbmvgEasBPI=;
        b=FRM66ETBXOuew7ayWgzY85AJPvd7pbrniuq58yQ659AOGGKEc1rPw7uBp6VsUOCBbO
         5zarpRgazc65104hCUmlSRWLyqQ9H5g6JpcfyOlgxzxTUIyUybX+ONgHhOYrd8X1L/X8
         I1h8M474kTN6C7k5AqhB5gMFY0t//Niaux1MtmzPgHmdx41YQWol1fr5JDM9UE1sxsVj
         5VufRQQ8jNuXqNe4IlsZmDk9+DyCvqouoyXZhI6lKpLhka1IZc3NaW0sQYxDCYgG1fve
         gUEGus0saW70gLztJM5etK+oBSQdIF49by7eGfqmDBhYd1kwMp6aI6hs2FDw0O6jZXPP
         zW8g==
X-Gm-Message-State: AC+VfDwnpkGd9LniYTuAz0Sm3RSvRHhC2nkt2eC6RaItadhBvRidqfJ8
        wXsMdfizPlBuHLLlKFLDCWbNRQ==
X-Google-Smtp-Source: ACHHUZ62py82yK1xV2gsxWuBbNgdsO5kSxLZabr+1/z8IIKmStOiYcvStDOy+JwFmGYQIx7TAdCL1A==
X-Received: by 2002:a1c:7918:0:b0:3f6:50e:315f with SMTP id l24-20020a1c7918000000b003f6050e315fmr6423871wme.41.1685295370010;
        Sun, 28 May 2023 10:36:10 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm15334523wmk.28.2023.05.28.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:09 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sun, 28 May 2023 19:35:32 +0200
Subject: [PATCH net 7/8] selftests: mptcp: sockopt: skip if MPTCP is not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-7-a32d85577fc6@tessares.net>
References: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
In-Reply-To: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=kQKfxu33/TKdTEp2HTz906dbSPVxanbcCaiMbKwHsos=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkc5EBYuuTgrHoIKtcSjWHisgGd2VcKMhrcPB/r
 J/SupQ1t2yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHORAQAKCRD2t4JPQmmg
 c9oxEACk8oAjyDKsO7XkrztBSp9DjP71JXrYQMhuHsaRWRfCUnlJf1XvAxwksDYdf+AwwLNVoNB
 Zk6yMPVrszOYV03Rp/aPxCevecbjJXhCnzd+hbeiHzLz/D+U6gMgLKRNwFLq6suWTKgksWEHOfY
 h9386U3a5bnxL3it7jE7NXvekXx8PZ3m/wCrdGytfvysLIjJb63V9nxSshqJKIipA4Q3IASsiJ7
 vZDhGDyIsCp452zgkrH8bakL4zN/DtcoyQHVUQEZelaZbCLPxAvGYSbRhgNacDTEQrHYY4x5CT+
 vfEk9j9WSqRTnotl+soNfihWaqGQEPpvNo4mo1Akv2JRZZ7ePxRB90726pYMHWODSCzcw1GEuU5
 peXNW2tx+J2tNXeDjWn/Ru8T2cRHL4FJ6+WeYclKCMqJ8YDW0ulrndN1nspDyogGNapP5w4Viyj
 iqknPH5QeqKaopFjseboxZJf3rmCrm/KjvktZFdbvVmKHFq/1psM0wIAOGCzABovl190qk2pxSL
 GWsEkRo7hfOQReuuTN+CbWVBvpK9LXAuOdHAw1F8IjkdQ68t1IVs82gSDgGVOcbAOW7elWi8FwJ
 ta+cxiig6K8yGmpWQCqTNF0PnX/uQhWB4pYBH71HpOI6+wUFPx67avvioOH+xUybWhxuqgUykOl
 HrKhZvkKQuoLEcg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1b70c0a304ce..ff5adbb9c7f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -84,6 +86,8 @@ cleanup()
 	rm -f "$sin" "$sout"
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

