Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44E780401
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 04:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357349AbjHRC62 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 22:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357343AbjHRC6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 22:58:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AE210D
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40ff796e8ddso3446011cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692327494; x=1692932294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B//PxqTOcLRZSFYVWOXGViYC9OULMJhe+RhXHERECls=;
        b=tmv/IW4eAJDthaFDwjvi9IaSF4Rcud5RPAMq/Cw6bY18saA/WzMcE2wsVXdr2M9HuI
         ELfdKCcPerKH0tBnpuC8ZnlQx1DdOGyQU12dGiagEAyQZXRak7SX8KpqDsdc4b4Igmcw
         3dfj9Vwi3iaCkZkmtpe6IaOU7anpUGK0uLf/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327494; x=1692932294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B//PxqTOcLRZSFYVWOXGViYC9OULMJhe+RhXHERECls=;
        b=TkadSeL2B0+14T6YBNYnT8ZKxysBXVSAFAvteYVSezeOnaMUTe5wA4rL8xk8JLtCyL
         Eka3zYYjrHnRUPdLhiYm0M0KVZfncjQ4F9/sMWaffH05SneQD5j6//89GMXS1puZ4wXC
         7zt3I0/jGzSeLy4ne9XVtpwUGM9vydu4kE9HtMZoEcxe87BG0Qx8+gIroxMB5RhZ//SP
         kubuaUY6UByqKENBGKlRZ+PKeeeJSsYnPYHPYHw7KNyjVECNOypxU73sSFgH/8PCUGBI
         +y/C2X4U89zibbARhfXdXkc1MzHyXw+cSqNZxMnDOhgIxLdXb5Fsffouqzb/xrzPyiUo
         GIWA==
X-Gm-Message-State: AOJu0Yyq+7YEjVFnYVSL75uZh1rVsLxnx3LFQkZO28/T+DkzFD9hIzHI
        F1o+B/daraXz+wBIgaYaqgzmUw==
X-Google-Smtp-Source: AGHT+IH7rjUWj757WVMp0Qqu31Vckq9gjzUG4qfABg1kPLHXqiniH9ZGEnmCzeHgJSsJdQ3Rc6uMDA==
X-Received: by 2002:ac8:5742:0:b0:408:2e66:3a1b with SMTP id 2-20020ac85742000000b004082e663a1bmr2008883qtx.3.1692327493979;
        Thu, 17 Aug 2023 19:58:13 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id m17-20020a0cdb91000000b0063d3744c5c5sm350536qvk.5.2023.08.17.19.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:58:13 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:58:11 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
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
        Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 bpf 1/4] lwt: fix return values of BPF xmit ops
Message-ID: <0d2b878186cfe215fec6b45769c1cd0591d3628d.1692326837.git.yan@cloudflare.com>
References: <cover.1692326837.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692326837.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

BPF encap ops can return different types of positive values, such like
NET_RX_DROP, NET_XMIT_CN, NETDEV_TX_BUSY, and so on, from function
skb_do_redirect and bpf_lwt_xmit_reroute. At the xmit hook, such return
values would be treated implicitly as LWTUNNEL_XMIT_CONTINUE in
ip(6)_finish_output2. When this happens, skbs that have been freed would
continue to the neighbor subsystem, causing use-after-free bug and
kernel crashes.

To fix the incorrect behavior, skb_do_redirect return values can be
simply discarded, the same as tc-egress behavior. On the other hand,
bpf_lwt_xmit_reroute returns useful errors to local senders, e.g. PMTU
information. Thus convert its return values to avoid the conflict with
LWTUNNEL_XMIT_CONTINUE.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
* v5: discards skb_do_redirect return instead; convert
      bpf_lwt_xmit_reroute return;
* v4: minor commit message changes
* v3: converts skb_do_redirect statuses from both ingress and egress
* v2: code style amend
---
 net/core/lwt_bpf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 8b6b5e72b217..4a0797f0a154 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -60,9 +60,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 			ret = BPF_OK;
 		} else {
 			skb_reset_mac_header(skb);
-			ret = skb_do_redirect(skb);
-			if (ret == 0)
-				ret = BPF_REDIRECT;
+			skb_do_redirect(skb);
+			ret = BPF_REDIRECT;
 		}
 		break;
 
@@ -255,7 +254,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 
 	err = dst_output(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	if (unlikely(err))
-		return err;
+		return net_xmit_errno(err);
 
 	/* ip[6]_finish_output2 understand LWTUNNEL_XMIT_DONE */
 	return LWTUNNEL_XMIT_DONE;
-- 
2.30.2


