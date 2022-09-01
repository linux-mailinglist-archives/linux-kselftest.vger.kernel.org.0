Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5CD5AA0E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiIAU0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiIAU0w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 16:26:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AF7675C
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 13:26:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a056902038300b00696588a0e87so230763ybs.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Sep 2022 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=DkZMlYUjqvBBA8dctsqSfJSvv6sYsaMxoePCT/ImrrM=;
        b=sL0Crh6kUMn+rRD3i6lhoOHAXnPjqJ/X+vQBYX//7iNtMAYH5Gw8X8b5hzUI8nZx6x
         prYIYY7he1lyXa/j1SUotodLeEtBKZ8hszOFOxGTNsFGIpaR/adqzBGkTRfqYJtXFynL
         ej0YWcMOI68q8bd589d8LanYilkFraLZ4ZezrWKGH4sOJ5jVW0aypKBpEen4k91NtgBk
         XRBxQfLc4UpR7vP+O2QxFodZWWeR8SzCbD0hF+LwEXrSsXQLI+vA90FJC069ksDznfMo
         u5kHJNtbq+rUaGoIeNSQB9YMiwB0DaINvHxP86ynTr3WOJdmA1u++cRVYTBIPqhRB5GI
         sFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=DkZMlYUjqvBBA8dctsqSfJSvv6sYsaMxoePCT/ImrrM=;
        b=f94AWC8XX19oZ2m3C1wmJIsm8V3GU8rxnvJwiRTFhULYZnkJMSDbV+f+PA2KtlLhGR
         dRu5/5TlYjkla20oCfErd64D3A/bJSMb9UPw/7oU/hHA7gXtM0emCAvDL/sRGZ+6B2tk
         mLidWhpMQutAm87uf649y9bWLlO0GmUPv+2ITGcm2h4IXJuOxLgecBVSXMck1SrfhsWi
         0IW8CQm+C3Mz99N/MziZ5j55LUYDCIlOS4CwN/VTKZBBa/VO9svMGvNWK8yrFnW3QnLS
         TVdbNHTD7zLR//exrq2Xo2CBTk1xQ34whp0+9GZO4w3pJZQOEuNTvXIXhcjWcM/nYgOh
         tizA==
X-Gm-Message-State: ACgBeo1Qv1kS9nSbFKbaVVYFwCov6fMIqA/pEPTmarJSZUrof6h7s1Qh
        exg0UX5T5rJ1lpKDnJR3As7J2dN0jsLO
X-Google-Smtp-Source: AA6agR4QSPvpvHPWxR+rBUJrmSkA/ubTu8FM3TjSIH8gCd0xPRRaROY61KaJb+a7gEIGMUe5luEOmUODdbpV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ef7b:b6fc:77d6:e782])
 (user=irogers job=sendgmr) by 2002:a81:c241:0:b0:336:f5a6:2e36 with SMTP id
 t1-20020a81c241000000b00336f5a62e36mr25011273ywg.123.1662064010200; Thu, 01
 Sep 2022 13:26:50 -0700 (PDT)
Date:   Thu,  1 Sep 2022 13:26:45 -0700
Message-Id: <20220901202645.1463552-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v1] selftests/xsk: Avoid use-after-free on ctx
From:   Ian Rogers <irogers@google.com>
To:     "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The put lowers the reference count to 0 and frees ctx, reading it
afterwards is invalid. Move the put after the uses and determine the
last use by the reference count being 1.

Fixes: 39e940d4abfa ("selftests/xsk: Destroy BPF resources only when ctx refcount drops to 0")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index f2721a4ae7c5..0b3ff49c740d 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -1237,15 +1237,15 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 	ctx = xsk->ctx;
 	umem = ctx->umem;
 
-	xsk_put_ctx(ctx, true);
-
-	if (!ctx->refcount) {
+	if (ctx->refcount == 1) {
 		xsk_delete_bpf_maps(xsk);
 		close(ctx->prog_fd);
 		if (ctx->has_bpf_link)
 			close(ctx->link_fd);
 	}
 
+	xsk_put_ctx(ctx, true);
+
 	err = xsk_get_mmap_offsets(xsk->fd, &off);
 	if (!err) {
 		if (xsk->rx) {
-- 
2.37.2.789.g6183377224-goog

