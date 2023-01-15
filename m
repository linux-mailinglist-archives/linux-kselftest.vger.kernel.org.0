Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23666B309
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAORXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjAORXH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8D10AA8;
        Sun, 15 Jan 2023 09:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1CE4B80B44;
        Sun, 15 Jan 2023 17:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480D1C433EF;
        Sun, 15 Jan 2023 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803383;
        bh=snu2vKRwNILsSuA/p1f4HvWvn/feoW3bz0X5qqkIObE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JbI8kbq46MbgQKSTBvktDZe4N/Pg+kGjDLJVsVMrl2cUmjOWv9gm4VMiHqn/ZOz9B
         yhNKc0ZWw91DTeP9G7eZkOSF3IvU6EbtODBykbNJeiEPaEEp4vzNuvknWwfWDgfUiz
         cmrDc9fyBkpbHJVjuytg8m/Rknr24tlldXjqjpSG6hcRaZj/HRFzzo/xpWx8a9dZt4
         wGL2Cxtse4piIGoGvHwoiPs4De76yU+2MscPN1pPp7ZD4bWo9MM95qNUY5BUGFxbxE
         fANQqyoECEtHny+nhQcPPCk+pnZleMPpPTLf+1f79XCPGW7o5Ubut6dSQfwPq70beG
         E4boT6UU4TFsA==
Subject: [PATCH v2 26/41] SUNRPC: Advertise support for RFC 8009 encryption
 types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:02 -0500
Message-ID: <167380338239.10651.6750039494923451092.stgit@bazille.1015granger.net>
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

Add the RFC 8009 encryption types to the string of integers that is
reported to gssd during upcalls. This enables gssd to utilize keys
with these encryption types when support for them is built into the
kernel.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=400
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 7fe39e47c84f..97a365608233 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -214,6 +214,10 @@ static char gss_krb5_enctype_priority_list[64];
 static void gss_krb5_prepare_enctype_priority_list(void)
 {
 	static const u32 gss_krb5_enctypes[] = {
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
+		ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+#endif
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,


