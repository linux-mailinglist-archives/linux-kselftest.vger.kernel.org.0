Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9025D5A403B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiH2AJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 20:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2AJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 20:09:56 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CFE13F3F;
        Sun, 28 Aug 2022 17:09:53 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MG9mc3tjkzDq8c;
        Mon, 29 Aug 2022 00:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661731793; bh=nw1YRmqcdBzZBVcFj0rpWQgfxBxuosXOsCCFJ9smdJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4+1NdJrI/tzqJERKOBbSfbtER0u2uaKNniyGZh+pWeMHagb2SitqDujW+B+e/Awx
         1XF+qQpe5yl/hM336jCbX3MtBQQYEBcFgeSoGbPW3tEix+c++PWbfMkHfqJCrnQczS
         NO4tf0xZsMPqugacs7jGUkHO/N+a0BeBzmL2ZPJ4=
X-Riseup-User-ID: 2860CEA6AFDDFE6C5BAA18060787332CF5114A24920F5EDA57C2A10ED7FDC7E1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MG9mV5cVfz5vkC;
        Mon, 29 Aug 2022 00:09:46 +0000 (UTC)
From:   Isabella Basso <isabbasso@riseup.net>
To:     igt-dev@lists.freedesktop.org
Cc:     magalilemes00@gmail.com, maira.canal@usp.br,
        tales.aparecida@gmail.com, rodrigo.siqueira@amd.com,
        mwen@igalia.com, andrealmeid@riseup.net, twoerner@gmail.com,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        kunit-dev@googlegroups.com, davidgow@google.com,
        dlatypov@google.com, brendanhiggins@google.com, daniel@ffwll.ch,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        linux-kernel@vger.kernel.org, Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH i-g-t v2 2/4] lib/igt_kmod.c: check if module is builtin before attempting to unload it
Date:   Sun, 28 Aug 2022 21:09:18 -0300
Message-Id: <20220829000920.38185-3-isabbasso@riseup.net>
In-Reply-To: <20220829000920.38185-1-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change makes `igt_module_unload_r` safer as it checks whether the
module can be unloaded before attempting it.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 lib/igt_kmod.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
index bb6cb7bb..97cac7f5 100644
--- a/lib/igt_kmod.c
+++ b/lib/igt_kmod.c
@@ -256,6 +256,9 @@ static int igt_kmod_unload_r(struct kmod_module *kmod, unsigned int flags)
 	struct kmod_list *holders, *pos;
 	int err = 0;
 
+	if (kmod_module_get_initstate(kmod) == KMOD_MODULE_BUILTIN)
+		return err;
+
 	holders = kmod_module_get_holders(kmod);
 	kmod_list_foreach(pos, holders) {
 		struct kmod_module *it = kmod_module_get_module(pos);
-- 
2.37.2

