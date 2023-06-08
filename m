Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3E72856A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjFHQkb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjFHQj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F530F0
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 09:39:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30e53cacc10so624615f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242340; x=1688834340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czHHBif6b3JNPCEfCU3p0DvzKEkPWI28pRVwFLD3TEk=;
        b=75gqNSzuYINuHY5SCr+DHhdj+MkqUn5K3pmF8985c8b8Qmgt1IHJAZJbh3f+fzNMY+
         JUtij/ifnHZ1Px7qoQ1wFDKBOqJToPqBdYBS2zGOInSX45sAZYmn2sOZQ7zd17InT0O2
         AIAlryytQH9DnHpTSrMJF3xqZe9oT0H0DDff/9wWNrftjM751OclCeRqvFH2bTLCcEbF
         mWkV7W28ySKLRml85f2ryhONR1gaaW1AniH5+dVoNnB8yUMbjwJ+VRh+2xa/K0HfBncg
         dQN8umCqv6aPBowj7IRydRJYCEj1ITGy9KeepeK0zmgrV1BdIYcCye4Mav0dmWcqYw8Q
         axYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242340; x=1688834340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czHHBif6b3JNPCEfCU3p0DvzKEkPWI28pRVwFLD3TEk=;
        b=Gd4e3nChJeXR0ifNiCKLkyDpK8McScysFRGssrJTvEn+Y19kbHDEKg08ImIGqOjzWI
         qKfUIlpPlOSPMg5gjAATYpDFEBsBW3CkvkuSCWGc5kvzBnyfx7Gmd4EtNlYR5sPMzh1U
         bji8ME/1xj6hNLhDQo0ZWtBQuuFYUOJeAS5nWbt167xFXy3UAaIAhHHyjtjj1UHD8SHO
         68zKCEEVwBNylcW3gEi9ZH9RM8TfIs+mdi9DCCKDOXmRwpkA438zQUo3XnxGcNP4HMpP
         eU9U4acmU42yEy3pCqhniRJQ6oVDS7fu4xvYwJLKD5T/YPj8X8ERwfPHkLIvnGsAMyIe
         gP/A==
X-Gm-Message-State: AC+VfDwCUYAKN0upBzKJyBUQapPls60JfVAN2Ciu0+Y/fxUh188ij/3k
        axSeLO8zrqfm7TgcARwgTT5Npw==
X-Google-Smtp-Source: ACHHUZ5ejWfNPCf5kv9xyszkDUXkBmsLNfy8THTCbjUhm65isOwsiOMKIa209E2ordVxlqcTIstceg==
X-Received: by 2002:adf:f1d1:0:b0:30a:e70d:9e73 with SMTP id z17-20020adff1d1000000b0030ae70d9e73mr7766087wro.33.1686242339908;
        Thu, 08 Jun 2023 09:38:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:38:59 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:48 +0200
Subject: [PATCH net 06/14] selftests: mptcp: diag: skip inuse tests if not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-6-20997a6fd841@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GFhSqu6crxevOWFlUMLP/NWLyXtLoglclQ/BPatDiGs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQZ1TJ6RZ82IXZNGMBvvYLfKUyHoJAZyLbq5
 B+55fJO15WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGQAKCRD2t4JPQmmg
 c0ogEAC5De1Wak4W2bPErgQJAQgZ7UQe8hoKJnfOsYDzE3i3Q+MZg/KnWX27LHbm+JZ/40ustCj
 P8Dxhkwbsoi/Y7tLwvwo7IJJ6r8qyHalenDoNywL1J3txjNY7Alj2gXfdaDWB7UoLAsZeqVMlRt
 7iMOXgrPaSmP7a5XcfkbZnHoY4LMK11R0pM/VCdorceRiIXRjR7YoQmeX9uS+Kb5439K8HYMkIw
 wwmNkxywerdfOWOxfhbP/DM+8gp+We9hiEsD5/H4LtjARq3ECjQKniSTYOuSjZ4VlXLxbFNBtZI
 xyfoP2+Apk14eu85zmXtjIIr3OSkdqtRpatmXGX75Wn9iuR/UI1We3FnK8tTS51boHjruxs94OM
 YimNcl6q8o+xw5Y/vbUqLv5HZRRl8rG0FXPpE1vujcuW/eL2sHPNxXMvxhqGGcv+08arFHDl9Fi
 enKjaOXsuArKdRkUK9wB59EFxKRKhkaC6G2c9B3yz0pppGsJAcxSHmx5kpatXekr8xcfSPQv/Rp
 nOE1oA29xr27XV68cb7o+Whh/4XmNufUM3n8Wp6uympepL4bfuq9l0Nk7woP7MLlgtegmC9HlPc
 CVL/eGOdPukWMIzEInRCSn7lqYTZ4op2YZUtxsFBE1w8lC9ByYufMkvni19TPmhMiQFtDIUeDFU
 cLNweqj49lEMGHw==
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

One of them is the reporting of the MPTCP sockets being used, introduced
by commit c558246ee73e ("mptcp: add statistics for mptcp socket in use").

Similar to the parent commit, it looks like there is no good pre-check
to do here, i.e. dedicated function available in kallsyms. Instead, we
try to get info and if nothing is returned, the test is marked as
skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: e04a30f78809 ("selftest: mptcp: add test for mptcp socket in use")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4a6165389b74..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -173,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg"
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port

-- 
2.40.1

