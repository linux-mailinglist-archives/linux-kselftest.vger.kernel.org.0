Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9574791C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGDUo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGDUo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:44:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141AF10EC
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31438512cafso2600574f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503494; x=1691095494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zM/VNUS+GSxyOx6V27CxpYZYQ4jYm1YxpUOxZRd9I8A=;
        b=h61i2gHEXvwlv4xVG5I76YqxtCPPRCxAlkRAhg+KahxFPm/zMmBlG/dFz5c+1DIhFY
         3s9x4MMdkOJmdp6F3Pe7+zdh8bUTz4fN5LejI/c/0s6Lnuvats7i9YlDG6JpzzkQFyyT
         aA/ocMbj7RoRRjYhtAPbFRSh5Ulh+wjyj85iOMvDgAW0Qi9e6g/FhRcgwqf0xviEmA1b
         a/HtaZkv0j2GZ6E///q32Sm7og77N9LJVpsvSlpbra7ZDwwXGwm72ykOs+CY62aZVuTA
         GBWSD6kXnyLenHsJW9Bj49F7FCxQWrOD/PLDWyZaQl2FPV0e46IBtyXwrRbq2A//e0A8
         lEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503494; x=1691095494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM/VNUS+GSxyOx6V27CxpYZYQ4jYm1YxpUOxZRd9I8A=;
        b=ZVmEfmvqU16ypy47VTUhL2g0Cs1s5yeQyVqT/Ywxl8qy4nefoVQ+92emUrpTC3sl3J
         hICjH/fO5U/K4S23qt3DzMEVsiU8Lo4iQeoi9dKZ6cerUKGfLpKJQ/C8pMJjuz2AvLOl
         AfY8gyiGLvQ64VKTJc2OX8u/XPzULgqwweSUFKMpb+T9vVDjgfQF1boSci/1HTK3oDn8
         WGphFdoMuGvp5mpbM6gORmGAGcdc6ar+PtwWp4OT3hfXwCW3XH6Ayp3iR9vdOh1Wv3EQ
         2DUhdQlQyn52uorVPAP9oE6FHs9jISVi21FqFj1x//prFbMQ7Z/5xChg1BQ1NTMNwhZS
         NvvA==
X-Gm-Message-State: ABy/qLbIK6zwHcQV93MlHB95OL9g9qJDtl/h6H6dIq9qfJJKVTMTMqTt
        XD23WWTmOsvqCb0Q2hi0zTPydw==
X-Google-Smtp-Source: APBJJlGdSXcpQIMfDgBOGGMfwVCSwJ/us1OFJGrwGfPRD1Fam88RsG8trhtnp7SahNYw0AZQhZD+Ng==
X-Received: by 2002:a05:6000:1803:b0:313:fe1b:f441 with SMTP id m3-20020a056000180300b00313fe1bf441mr12962581wrh.29.1688503494601;
        Tue, 04 Jul 2023 13:44:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:54 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:34 +0200
Subject: [PATCH net 2/9] mptcp: do not rely on implicit state check in
 mptcp_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-2-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=J5WAv57HwmJMA3OE7iDPaKXo7Xfyy1+DZ5Lwakguv6E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDmYKxdDTKRfYcjsrAZtKeGtZ5U3VDxGZWm
 t0TnOIjzuqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 cwIAD/0eLvFgQrscCu7g0o+gbRiq/1pUxRVq4wBIfmoZ8Vme0leRZthZo0jmBnzaBOdHozLxAcg
 icnPVXOhXyoOvgUy5Fz+iDSMs6on18gUbgodwHmzuhEbZsVbW8WvfpEaV3zZetlUoqtB0l9VMtp
 FOpEmkR+y/gdOqpzCSC91XFx3+sVNyuLQ3nh0c747jjEUhhu3GckdV2FL0Ufo79Q+65ua9VpdLM
 RHtPtIABMlit7qo8cj5IFNRB/5BvghjfCueYrHAmFjVp8vf0VKK2eA038y+GulDO+Mis4RvC6sY
 Ie2ivpJ5vhVM5ZRQJwitEcpwf9PckyBy501gCbOYLypbET6KL4bROb6FeeIol/eV25XCv3as7Yk
 HfOzUMVT5vRyuYRu3N/eOVmpq0PAEqQIKAPDyxDjEP1nQXtsVh7q3KONcgbsankDUsnbGA3aroK
 GMGwdgI0DnEq8ESvs7H4SRuib0TPjcOOGriooyT02Y9aXdVsGW1fuFRKHnc+/Xnrqm44bNsGMkx
 Mf+ZdDVf2fFbyFm6LYpRHtCdjJqniWes4MqJCtjp8Qv1mOBfH8SqihPND3b/EgN1y22P4SK8nCf
 79SvqaI4fpfYd0qJW+c+v4H9wbo9nOpX74irOQcIwL3p1Qy8PUh/LUUbbQvrxp5eC6umNaO4hDe
 EzPA5bC9swX3I5g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Since the blamed commit, closing the first subflow resets the first
subflow socket state to SS_UNCONNECTED.

The current mptcp listen implementation relies only on such
state to prevent touching not-fully-disconnected sockets.

Incoming mptcp fastclose (or paired endpoint removal) unconditionally
closes the first subflow.

All the above allows an incoming fastclose followed by a listen() call
to successfully race with a blocking recvmsg(), potentially causing the
latter to hit a divide by zero bug in cleanup_rbuf/__tcp_select_window().

Address the issue explicitly checking the msk socket state in
mptcp_listen(). An alternative solution would be moving the first
subflow socket state update into mptcp_disconnect(), but in the long
term the first subflow socket should be removed: better avoid relaying
on it for internal consistency check.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/414
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 489a3defdde5..3613489eb6e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3703,6 +3703,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	pr_debug("msk=%p", msk);
 
 	lock_sock(sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto unlock;
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock)) {
 		err = PTR_ERR(ssock);

-- 
2.40.1

