Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83A366B2D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjAORU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjAORUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935071041B;
        Sun, 15 Jan 2023 09:20:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA4760DB6;
        Sun, 15 Jan 2023 17:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF6FC433EF;
        Sun, 15 Jan 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803223;
        bh=BafomN1WImkk2tnPEHLusmFBeE7srAMZgK56SVJzrng=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pPcU7FkLcNWl2gXK/YRy8l5R5AVboPYOKyKKMVPosOSma0S4ALC23hY5VSc0JWxQ9
         1XgkLagXKB1swFbBtnCLkQgUW4/xpEQlRuO+iRvw9HfNWlloNUiCITkhFI+r6OXriW
         I75jlidFK74uDQnR/LBXXxCpqu+dQGxYUuL17cAd0VkSxjoPLxA2WXoEVe1T4QDwvg
         oetkt5ZU3VgT+0tds/Xl2bXZVw1v4RJwDIx3QA49DchB5OXgXMCovX7rzBQ22H3GtP
         ohxl7ksatDbvs7AjNuT0SoROhco7ZvBQqhGdMWyUijj+RnnqUE7PsafDw4taJVnE22
         nDDrKd6Q/ikaw==
Subject: [PATCH v2 01/41] SUNRPC: Add header ifdefs to linux/sunrpc/gss_krb5.h
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:22 -0500
Message-ID: <167380322231.10651.1677104790496179202.stgit@bazille.1015granger.net>
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

Standard convention: Ensure the contents of the header are included
only once per source file.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 91f43d86879d..0135139ddf20 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -1,6 +1,4 @@
 /*
- *  linux/include/linux/sunrpc/gss_krb5_types.h
- *
  *  Adapted from MIT Kerberos 5-1.2.1 lib/include/krb5.h,
  *  lib/gssapi/krb5/gssapiP_krb5.h, and others
  *
@@ -36,6 +34,9 @@
  *
  */
 
+#ifndef _LINUX_SUNRPC_GSS_KRB5_H
+#define _LINUX_SUNRPC_GSS_KRB5_H
+
 #include <crypto/skcipher.h>
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
@@ -316,3 +317,5 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 
 void
 gss_krb5_make_confounder(char *p, u32 conflen);
+
+#endif /* _LINUX_SUNRPC_GSS_KRB5_H */


