Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDEB66B30F
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjAORX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjAORX0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDA10AA8;
        Sun, 15 Jan 2023 09:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E984CB80B44;
        Sun, 15 Jan 2023 17:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58903C433EF;
        Sun, 15 Jan 2023 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803402;
        bh=KueGC4DU52yRbFQ3R4YQVv279GpKxK3k5dNVxnL4kLQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oGUxzmvWOSJF9OUHwkqL4JmbWUVBpupw5NaiIvYrtBOMxZNz9Iu9D4/ubLQNzpaiL
         kfB9kBe+F9173++rw5XPlegXV0C625EyynWhoS5xvUQ1Dr94EF/99PtvnyzRp6TMgY
         FuKl+YMQ03iMx5Xck5FK5pKuyX4EnZZOIZEWOibdZWkO1/64wkUnwMmxoFGwL7f4k+
         Pno0P/ocweeHilPhm7lDS5WIOBMINTXq7rIBtbvJLCNszqf52Kdp5gs5rpus2FwZyy
         mjS8pZFK9yIsYMOY5aCdsKnyvDlKyuve8FFDf/APu8MgPRCvTWky4HhaFhpFWksMzh
         V8rmCF+Ej+zHw==
Subject: [PATCH v2 29/41] SUNRPC: Advertise support for the Camellia
 encryption types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:21 -0500
Message-ID: <167380340151.10651.7949882607083067516.stgit@bazille.1015granger.net>
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add the RFC 6803 encryption types to the string of integers that is
reported to gssd during upcalls. This enables gssd to utilize keys
with these encryption types when support for them is built into the
kernel.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index e616ec536265..5909fef97d27 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -275,6 +275,10 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 		ENCTYPE_AES256_CTS_HMAC_SHA384_192,
 		ENCTYPE_AES128_CTS_HMAC_SHA256_128,
 #endif
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA)
+		ENCTYPE_CAMELLIA256_CTS_CMAC,
+		ENCTYPE_CAMELLIA128_CTS_CMAC,
+#endif
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,


