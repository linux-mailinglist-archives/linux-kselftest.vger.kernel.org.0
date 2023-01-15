Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F366B2DC
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjAORUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjAORUw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD51041B;
        Sun, 15 Jan 2023 09:20:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE314B80B8A;
        Sun, 15 Jan 2023 17:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31592C433D2;
        Sun, 15 Jan 2023 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803249;
        bh=iLOk2mzfLDhDe6T0N8hVevoNtHYi7+53BiAPbvsoYlk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W5KxyYQ//anO7q2w8ZBJjprE1pFv6Kdb6EpkUkXiFsExfCs+3DpXCe5E+Io/hlIPJ
         Kq32LvQB2GYdHuFaQLtN2bmBo9TRx58rVSwBAWlCxtKP7b9bfqLtGC5HwMdCEZDlS7
         K2bLLcP4pAVfM5QbdTlvIROyPHJnOSNzTFLm9ecUEoiEeavWcKk1zHq0Ov3+XwK2WE
         IeW7FhNkwSSXxDwrkVItsDhdMRq356phnYSo9TmBqHk3s9HsFPYffanJj4ghCpT59i
         7QN0+ySO8p9gJT1c6gYM/6giiP9E3XoDDOp9DEzleAsl2LXaUwU/20n/3P2I6Qrci+
         IXL7VOe5ls3tA==
Subject: [PATCH v2 05/41] SUNRPC: Obscure Kerberos session key
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:48 -0500
Message-ID: <167380324809.10651.4282783020942642184.stgit@bazille.1015granger.net>
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

ctx->Ksess is never used after import has completed. Obscure it
immediately so it cannot be re-used or copied.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 76a0d83fe500..b982c9d495f2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -550,6 +550,7 @@ gss_import_sec_context_kerberos(const void *p, size_t len,
 		ret = gss_import_v1_context(p, end, ctx);
 	else
 		ret = gss_import_v2_context(p, end, ctx, gfp_mask);
+	memzero_explicit(&ctx->Ksess, sizeof(ctx->Ksess));
 	if (ret) {
 		kfree(ctx);
 		return ret;


