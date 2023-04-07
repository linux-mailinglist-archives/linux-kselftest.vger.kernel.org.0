Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036106DAA62
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjDGIq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjDGIq6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 04:46:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0D8A79
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Apr 2023 01:46:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so864466pja.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Apr 2023 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680857213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVi0AWiu1zAkxzg8zSlzsBAWbtMyPsv5tFRVM1WnV2A=;
        b=YjtReY6YH5PgBWUNe8+Zz4g/S7AxXP6Ok/jQUc4jyUj8R+tDpnsYdLbh8/iMw2v+Jv
         P23WAr2SOl8H6ECcKcyL7BfAoR+jwoW5qbOL9VtenUVOu/XpVntsOtakSPjqNpj9SBfI
         2btr4MW/LNfAmx4og6Fbif4/zshs0ZWo3bs8VJT4aeAh9+Z/rTf6LQ/Ewh8uNxiIyqh8
         /NvMpNeaBAFmvi635Gy7rT3iNd7KLX9AbDcfGQkw/CyU8p55KmHTE/GF27WcJebT51A3
         xWjGoGrkccsgK0wUmabcpFmK6SbB7An3As2nt521xR37SML4gDfm6L2iCFCySbEIU8HK
         KQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVi0AWiu1zAkxzg8zSlzsBAWbtMyPsv5tFRVM1WnV2A=;
        b=Awz/4mOi6LSOgmpbKP6yMphyfjgmk1uXyx/CefYzaExAnwdEm+xtPUbyq9SrzRrwXy
         aQsDqWoiboTZ/VjggYzQ6fZgnJs5HzkjSFnPqKij6btGsYuy0nUVjjDTAe9kbI269NBJ
         9+uk9qm24UVXxpjnOq+RmPwBdKpHOxxO2Opb/TLwwqcaUg/Y/D2PZsE11LU1aaMKAopA
         y3g7TibgSlw2BuTGVedd5nDQtMgD1xiX7NRI9OX7yuHN6LvcwoIxsveDmtYhyQSm7lSC
         ICxKdLJn1JSe+LSp3tCbm9AzBm2vbHhUitsDgCQ+njIzF58hutgetBg/+s/uzL3UYRCH
         IgdQ==
X-Gm-Message-State: AAQBX9e3Bwlk9WoVjyFn8aAX1Xp+o+pL9kIrFbVMX1haZ1R/aadbcdrF
        PQ6q6slD/bZaa9Tj6FIzIS5PQQ==
X-Google-Smtp-Source: AKy350bzeTj5bfaWlrevCPwRsEkQ42Pd5eqaKyCwfP9XiQJ2/nx1laJP+4SSVAhR8jdFnKHsZw+QhA==
X-Received: by 2002:a17:90b:4a0a:b0:23b:3d6e:1ed with SMTP id kk10-20020a17090b4a0a00b0023b3d6e01edmr1732441pjb.13.1680857213186;
        Fri, 07 Apr 2023 01:46:53 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a5d0d00b0023b3d80c76csm2333676pji.4.2023.04.07.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:46:52 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v2 1/2] bpf/btf: Fix is_int_ptr()
Date:   Fri,  7 Apr 2023 16:46:07 +0800
Message-Id: <20230407084608.62296-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230407084608.62296-1-zhoufeng.zf@bytedance.com>
References: <20230407084608.62296-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When tracing a kernel function with arg type is u32*, btf_ctx_access()
would report error: arg2 type INT is not a struct.

The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
in tracing programs") added support for int pointer, but don't skip
modifiers before checking it's type. This patch fixes it.

Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/btf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 593c45a294d0..17c65de1e48b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5913,9 +5913,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	/* t comes in already as a pointer */
 	t = btf_type_by_id(btf, t->type);
 
-	/* allow const */
-	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
-		t = btf_type_by_id(btf, t->type);
+	/* skip modifiers */
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
 
 	return btf_type_is_int(t);
 }
-- 
2.20.1

