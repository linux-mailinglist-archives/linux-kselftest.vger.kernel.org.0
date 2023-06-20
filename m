Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3273726D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjFTROS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjFTROS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 13:14:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495431710;
        Tue, 20 Jun 2023 10:14:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57023c9be80so51747347b3.3;
        Tue, 20 Jun 2023 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281256; x=1689873256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=Hpl4F5ZowziueHAVmsyMSoKNc6iTCD2Mojmk8pY0lJgsNpjscL/+5GfX8ZsDyjLvNs
         wmXckqZRokb+LnYH760fKeVuR45KJja9UOu3lHnzdmgDsb3HxwCckRZoe21fOMkZTgxL
         xRUOaeABD7jc2HythQjmdlQ1/Jlmi5Rt5TUTZA5hCqGaMCviWhc81MI5DRKNCHLcZIZ4
         I5SnSONzZsH3OlzZoYMvLLNv0W/CUmycyp5bOgfMtDtLAArRdk6DZiBOV85rTXUHCj/s
         Ce3nbsBAUnn+0oLqPnAcYVvSrjUOz4JYoiMDXM6BLKY3bH9YRBau8ru8LOstweaAYll1
         DePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281256; x=1689873256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=W5vRIELjE447DSXwd6iNY0diHiPh4EbCnd6IYlthsH7+xkI8Yks6cUynnXuMqhqyDj
         8FAw4KehnAUumHscoThdGa9hDsuOxW3XO2H4Spp/cEe2RtphOM6RFc9wsyQgrC95HLlg
         9uTyq/dEIOAfaPCuVLtkdm+NeWMu6qOKobcofx+BcmjY3Ja6S2wWWOh2cyXTA2blCRAs
         ByNg4eMLj9wvTI0vM7qlzViywzyHiGqsFhxZzzvfbQIVDoX+DsO6qqBC5yO/Qn8zbRlF
         A7/F2wv4O8NpDbQiMP7LsCGTTK9h1by+/OilQ5mFY7ACzCl2AHlYleoLP6j95hSlATzO
         Q1YQ==
X-Gm-Message-State: AC+VfDxVRsoXHGuq5+Thvtwp2hJzHVPQ3SBGc1mPyuU4X7QSB2WbeTH0
        j/+T3pv36CGAybsb/4hBTjCN5JaeIVELjQ==
X-Google-Smtp-Source: ACHHUZ5ZSp3cSzS5RCOazH4/exiuD945HOst+zgnaHOKvZd3Z2UJyNoXXLwMPDFJk4/ivNSrLLWsMA==
X-Received: by 2002:a81:94c6:0:b0:56d:29cb:19e7 with SMTP id l189-20020a8194c6000000b0056d29cb19e7mr15443550ywg.22.1687281256083;
        Tue, 20 Jun 2023 10:14:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5338:88af:5817:a5f])
        by smtp.gmail.com with ESMTPSA id u81-20020a814754000000b00555df877a4csm195139ywa.102.2023.06.20.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:14:15 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters for egress.
Date:   Tue, 20 Jun 2023 10:14:08 -0700
Message-Id: <20230620171409.166001-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620171409.166001-1-kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Always call BPF filters if CGROUP BPF is enabled for EGRESS without
checking skb->sk against sk.

The filters were called only if skb is owned by the sock that the
skb is sent out through.  In another words, skb->sk should point to
the sock that it is sending through its egress.  However, the filters would
miss SYNACK skbs that they are owned by a request_sock but sent through
the listening sock, that is the socket listening incoming connections.
This is an unnecessary restrict.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..e656da531f9f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
+	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
 		if (sk_fullsock(__sk) &&				       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
-- 
2.34.1

