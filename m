Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBB728550
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjFHQje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjFHQj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE84359D
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 09:39:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30d181952a2so843860f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242336; x=1688834336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pKdEbukEA9wOHrFUgiYXVQj+yJNTo3IznsPdW4CCZs=;
        b=70KA64TSRhWJ4T90MG2iHcjb3Zi3RFeXaht1Lf1EEtjdE9WlKyq2714iztw+/nGJeV
         c8AUU5Ba5YyuRguUjQL9vxdFBQhW0nKokhL0C0/OVMySpo3PZ+drHqjZA6Z3TuphZKWH
         e6MzQgH2KtlEHOVDIJN3tV3AlH9V6SACDCM9o09BcudkRO1woTyp9ZBprJy5bkxGAqMg
         HFRf5dgU4bRRIjgkzbRg/yJcEs1rMBotUSm2ZnAuShAWbM8960PR+MlkNxBgH7SD1SWV
         sv3Mwv2WD1oMZr288mNpzmRzzv+gwhb6Gs17Y2o7uAK38LE9eY3Wx3O75h+wkGQ/Rg3q
         LKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242336; x=1688834336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pKdEbukEA9wOHrFUgiYXVQj+yJNTo3IznsPdW4CCZs=;
        b=ZscwqLE1YwiOIOi+/yiRnXA8nNsLy9397WbVcmtN/KmA6MeU2HEFALViIQMZMTGAzn
         HfGF8oBYXo6vHGS38OFnwQc5ntGZfoxWdTCdWZzLNJQQC2gdr5uy0Jv4++Q4ryPQubE0
         yri928Pkx9eVjrTsbnc4JFrFAWdxWVoc7vy+fZJiuz4t0O7eA2+CBSgF53bT87Uo6O9Y
         aHEZXcUsuEnWqdgvLu9EhoMg3n6C2pGYPIcPs7i8+EwT2p46KozW/rEmmWC1jqo93zb0
         H1yLhh2O8I7mW2lhW+pZUlIkgPIY+ySqiwS2tARfc8LI82c1Czgs4aW3IFQx+rM31np2
         83Xg==
X-Gm-Message-State: AC+VfDySoW/GocvobCn5lmfPljGO2oPt5bx3AJdH0QWNiWb1JmLBxDuD
        HSU2ub1WLGQ+7yAZf6Wv9gcfxw==
X-Google-Smtp-Source: ACHHUZ7LFg83lJitnPpbKmdUbO1JdjuYAV0sJIIUNitB3YJVh/LJvrCyTbEfaTniFgABpB9mrYUZtg==
X-Received: by 2002:adf:cd8f:0:b0:307:a52c:26b4 with SMTP id q15-20020adfcd8f000000b00307a52c26b4mr7653582wrj.66.1686242335891;
        Thu, 08 Jun 2023 09:38:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:38:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:45 +0200
Subject: [PATCH net 03/14] selftests: mptcp: connect: skip disconnect tests
 if not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-3-20997a6fd841@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SSoDnMmEl+pZEVoxZerlus09SVoahC8r5yKSBz8cTUI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQZQVS717uvTyZWy2u8rtgcAqqdKmNxlD+z6
 B+jLTuc0yaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGQAKCRD2t4JPQmmg
 c1FGD/9ddiKh4tHtz6ADpgl+xu8AGJPLieuIMGl9OK2GRXKRRNlIQxqEUHKz+rDp43krnh4jwUC
 AN97ZLs6xHqne9Ovt4ymciq8nY8knbogUSHvF4wyYuN7Dacx32RGMUcaNUj7/b5FvQJxOX+/mIb
 Bj8h/b+MLkdelSNY/y6plEJdbE7Ky1BQlJlPrngZKpBRYhxl6W/I9tPBiKyeJmgkQrM6E8+hvFx
 HPS5bnKRhZyVq83W/z1IRilZL3uxV0wHhDrLk/TVH+J8rcedEN3wCbcp4RKjOhMBmS2SdKO3Dfk
 C0qwC0fNfh6wgzhGG6xehEKs1oT4o9kAdqtM/Bd+8vCYF4+nbYVeL4UEANIUUkRGaJkGpS8xE0x
 uYEezzhYda/2hwdKeICljOUzHs9oNdFjbOrpVSHH43W5HggJfnUSF64nlv48RCXnti/Qdk4w3nC
 hhMEm2utnQfRzs+wG4nEEGppqZChP0YdCxLeejCr5yWbUk+tKDOnlDgO1Jj7O5mP6vHTh25Yzk6
 68/4+JQgeiVdRR3ru3O5UerBsr+d4FCSdmg2dBWKs7+42gxHgOrTTqJnO/LrugyqfAZjK2yo0xZ
 BJdqui59b4sMXsM0MXP30Y9kFa6GiiKeF8Qi1NcE7CYToVmtUlwzNB5XxpzMI9K8fOD2IiFatA0
 zXgFkmBOpN1FN/g==
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

One of them is the full support of disconnections from the userspace
introduced by commit b29fcfb54cd7 ("mptcp: full disconnect
implementation").

It is possible to look for "mptcp_pm_data_reset" in kallsyms because a
preparation patch added it to ease the introduction of the mentioned
feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f9c36c6929cc..895114fb6832 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -797,6 +797,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions

-- 
2.40.1

