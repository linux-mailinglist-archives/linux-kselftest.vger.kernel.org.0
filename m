Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFE6E88B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 05:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjDTD23 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjDTD2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 23:28:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D494202
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso714941b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681961276; x=1684553276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=EbJ7DiX0KNLClu6JNpZIDUdsu5ZAfzUcUtofGd3c7gYYeF16zc/59GXJ+AutZPz5w3
         1ifFTsK5hJK7jS8Yuwo7Jpyx5xPPQBukFkmUdFtOl7Q+AjoYuvx5dbhYnTTITWFdLbT0
         0yQKRpLKV/NLt/a9TXPz/ywKmiu4fth5/3NewCfewonuQbTDHwV12xSpaKQu3zXBdLTK
         Wkanbypedh5FCjD5x9rM26Np8iyWJ5A6WTwsT0eUl7SY1+Mb/AXTqtug1T3xcMgQl0nK
         yW1wBdq39B32F1H77/uS5PhpH+H1TGtEQ217Ncm+uuavogm6WqfJlu1T+jxqmG4+Bqhw
         b38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681961276; x=1684553276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=NrPHfmhsSbhuh1eT71QE96hPAxkgbSs4HmN9RcWcFPmp/nUbJY0WOXSv4Vo3h+C+b+
         z/PKEtSCE2Sc1YF7/d2RAKwD2JON8DRueHXsvXNf7fNDCdiGnZYLKfENclRbrI4VhoSs
         jPhe9vkRQWIXqmZF3Oedg0iyRM3uGsJCE9X9mISZkqQ2c/klq73n8cDdhROlPGQKfEKR
         F6lnEEtvm/zjqzqQmKX4GmuDGQtAUfGZO6GFJc59ij4o5fSGi2rDu0gAjrId8E/nasVX
         2x1HwRf+dzUg3lNrH2oNM9ra3MGY2tqSpF6VxLTrW3FpZd7MRz1TJq1X4LV4aNHIsNQI
         vBZQ==
X-Gm-Message-State: AAQBX9d7VUrFFHxR8WPy/w8wB+RwtiOz/OPQofiWPfzMpK1Dl2RRcPcq
        Nj/E98l6n2ykEsNHequv1Yn8WQ==
X-Google-Smtp-Source: AKy350Zzlox3kqFQwaEZJ1yWV/Qr9yqOXqttJ3x49/9gX0Cj/UedEau5H5gSR+U9pHNT8o+cBv2Pjw==
X-Received: by 2002:a05:6a00:189c:b0:626:2984:8a76 with SMTP id x28-20020a056a00189c00b0062629848a76mr7091693pfh.34.1681961276413;
        Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a655a4f000000b00517abaac366sm115231pgs.74.2023.04.19.20.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: support access variable length array of integer type
Date:   Thu, 20 Apr 2023 11:27:34 +0800
Message-Id: <20230420032735.27760-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230420032735.27760-1-zhoufeng.zf@bytedance.com>
References: <20230420032735.27760-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

After this commit:
bpf: Support variable length array in tracing programs (9c5f8a1008a1)
Trace programs can access variable length array, but for structure
type. This patch adds support for integer type.

Example:
Hook load_balance
struct sched_domain {
	...
	unsigned long span[];
}

The access: sd->span[0].

Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 027f9f8a3551..a0887ee44e89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6157,11 +6157,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		if (off < moff)
 			goto error;
 
-		/* Only allow structure for now, can be relaxed for
-		 * other types later.
-		 */
+		/* allow structure and integer */
 		t = btf_type_skip_modifiers(btf, array_elem->type,
 					    NULL);
+
+		if (btf_type_is_int(t))
+			return WALK_SCALAR;
+
 		if (!btf_type_is_struct(t))
 			goto error;
 
-- 
2.20.1

