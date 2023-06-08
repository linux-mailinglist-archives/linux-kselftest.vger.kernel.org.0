Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B672856F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjFHQk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjFHQj4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350883A8B
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 09:39:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ae4ec1ac7so612308f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242350; x=1688834350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNE3c3ow4HLujfggwGvIZJSwJNji9SiemeAOxLRnRII=;
        b=QBhxRYZe+sDDvDUsNJjopzpa07zO083BpgMmUtvp8LWYVwwBYS7FmmvSEQE77qCzvZ
         ZYU1eWAZg8prFk8gBMIOaos6NZoMorlowucePZq+gRETnY85v3aZ9UIZ49gtGjqOALTq
         ivk5UL74n5qLS6ec7J9pOKFbrGqMN0mokMhZhMYbNaIS2h2p5mQd72rdInBKhsrkZJEH
         gWGiq8J7urRmLTHqu+BNbRk+JaTOn4oNWQwQHwwMxeIDtLIXsIh4td4yE1hHxZIhI22R
         P2wbFuNXOAZ+WGTTQJUnJVzgNZeuA50d+eCv6zaKVw0GINWnLq+FL4AF2+80WqWkZVUa
         WMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242350; x=1688834350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNE3c3ow4HLujfggwGvIZJSwJNji9SiemeAOxLRnRII=;
        b=Q9/COMc61lSp2OISejGrlRKpyXDodU3cL4/S61DLyK+S1sfIkJCavDHGiYHs/9l5yv
         wLvR19z9+O9Gj4Fvww1KfmVZrKVA1/YFsqYa32NDj9iOYGmgzSMCbEtIt3izoKS64uFL
         oJCYbqSv8GmzRXTXBeVtC6nVacs6Ht7Hvuh7W7Jla1XebJoNqNO4GdkGgGrqeHfc9CuO
         1cfVpPi2WNiX0Ublc8dbMp3UfthS7bjhAbcZ8oPEDEaXGM3c2mDPrK/cwiv8hfbaQpCO
         H5hffq0NZVjN4ssV0GcTnU/8SrMRZYYaHAaCNqkOIKj/HlgrU3m2BM7OKkkQjjIUB0EL
         EizQ==
X-Gm-Message-State: AC+VfDyDrcwhCaVkDQZCaKc9c68rQHOQuJMucuJ9+2yk+fXQjMFns9xg
        7FPKBt6IWJk88sIV9AiphuYCsw==
X-Google-Smtp-Source: ACHHUZ7+cIAw9f13UW49Yep2x/jmYvDc9Tud1mRnFBJpyjSXpkmlj8OETX6PMVaC9uzChIccBULycA==
X-Received: by 2002:a05:6000:1245:b0:30e:44a5:804c with SMTP id j5-20020a056000124500b0030e44a5804cmr6781125wrx.35.1686242349930;
        Thu, 08 Jun 2023 09:39:09 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:09 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:56 +0200
Subject: [PATCH net 14/14] selftests: mptcp: userspace pm: skip PM listener
 events tests if unavailable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-14-20997a6fd841@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=NWyBgeQZowz6Mkkcv8bC8ZQEUyyS/33h051YnreudYI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQaQ6XKgvIOs3AtSThNX3TE9Q4HnIMUp5Mg8
 ykKZMhFB22JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c3d3D/0TgbzsP1x3hX8RCjC04xExB7CAB1pmuCfxS660YCvb/EUzJ5KbojK1H5Ywo+UQPuzEzOV
 rGRF5YFrPUru/OszmZyRpagcdCYtS58nmzc02RKiQ83dTteCy+72wNRc9QDA43P8TsPfmwc56xL
 dt9g2UqY0KwX1syMl7DX5N6i8hm9SmzkrdHc2qFZPjNaB1waeLlEL5gvDfzoCekXzxfb4VDF1fA
 z/J3cuPERmwdnW6o8tzhUMl2atgKbIQJkmR+Yb5ZfPzLtg0IfLfJkz+1nizaAV72/KDEnuaaWP0
 RqOWdH6VDThhzd9jPdeUO7B2fnYD3UYNR3qhx2Bo2xWOCltbXMoDobpz1N0uh3/75n3AfczBq/d
 KqfA1rlNtLsRgHp6iDQDMTecTwvVz6wKSW2fWjDxmxgrJcJGfjoBsN52KL81ZoxF+Y9bkshhjs4
 jw+sfNAN/HCgYfCOd6ZnOfttdXb/tDKsKEW23z3X+OtGVCjyqGnrr7OWhnBRALADYkrNIJRX7zb
 SCaL4JvdJAwY2lhuMH1dW4kujJdT8ZRH7Bm2nIP/jev7D06rUAJ49JEdpLX0RekF2zdJa/DnIsM
 k1FsfLFJlxhZhnHpILiyDUIk+FKCRIUChvW7KN2QaCvbyF+Kj3gH8Tkj+McMLIsHAOFW1w6Hfqq
 G0gyKJc2tQFdgsg==
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
supporting all MPTCP features.

One of them is the new listener events linked to the path-manager
introduced by commit f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature and skip these sub-tests
if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 38a1d34f7b4d..98d9e4d2d3fc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,6 +4,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
@@ -914,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 

-- 
2.40.1

