Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BD7371A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjFTQbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjFTQbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:31:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDD01987
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so6617074e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278645; x=1689870645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5fndaTCsd6PT3EC5CenLHxKgWi3IwLDVemBAF0BQ88=;
        b=q2pBLSUbQwOIyGXJDJyXH9/APPG9JILYehEXGBtVrdehCMIJQPYgN1soPTaGiDFYHS
         2mfEDoPWghy8TFmNAz91ws5zmqwlioRYdYCDUVMOFKonC4lxNmTDd2NkWzAep9oYlzt5
         YuWq8yVVutuR3SfYpgVNj31q1qF86yxjYmLsGcTw8shdtz7JU9N+7b9Zl4ef6ZmN1auK
         FQYUXWbcajWN8SM3HwktNLfzgQR9BhFS4TBv/H7Oc3wTfA6NyNPDTcPb6xDL4lktLVIP
         SLeJ5EISwcVGkuFtdmi3aDeGYS2iIj6a3w3ALDAvdFlHu9JO+CqsKVg3A1kVhJ1iM+e3
         Lj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278645; x=1689870645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5fndaTCsd6PT3EC5CenLHxKgWi3IwLDVemBAF0BQ88=;
        b=E6MX6MaYoFCLJWWFKkg1mTjdpqCbnALh/kiGQ/8tAJ+9pF1aQMrtyeVnfnBZM4oYRR
         GtwMjnkJIcnhqMTVB4wxWnktVsJxIR7Fr3jm5RY+9ccSSz64CvJwK9M9fXYe8lyRSYOW
         wD+DMzNy8FwjACWIpEgZj7Hin929jYbYr07gv5BShDVCxSzhi9zBuX5adsOqQRKG6NIo
         CoiYtIVrOGkWda+K/ijcrebFW11cvZnJwD5VlHFuhjKcaHH26DQK01y2njI8zFikmyvh
         n3oP/86CK+A9kVMcoUBklGrs97gmCNmNWn40PygmSFiyDBpNRcxE/1B7Ch2EKbMc+y+7
         3v+g==
X-Gm-Message-State: AC+VfDwa8SzUVtJGeKiGDLxRmSLBXfw/5eFIXd7YHSaSaIiIRBI0fsGy
        SL6xYp4DbkDEpASbax53sdlkpTiXzuRLKHE45tZaPQ==
X-Google-Smtp-Source: ACHHUZ4jkZ77R/K3qBh04G50QeVYtBxMms9PSSrR07jGkUgXTykFcGyCNGGhFmqmv4gZG4x+OZBUiQ==
X-Received: by 2002:a1c:7414:0:b0:3f9:255:aab0 with SMTP id p20-20020a1c7414000000b003f90255aab0mr8922405wmc.33.1687278633284;
        Tue, 20 Jun 2023 09:30:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:17 +0200
Subject: [PATCH net-next 4/9] mptcp: add subflow unique id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-4-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3775;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=arhNlpVEVZPz8Fi4+q8mXxwbbZV5QcuvJY8S/g9f9XA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQkgn2sc06kST4kKlmP4E7In1OMaQElhhTM4
 Fde2HhL51mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c/TQEACChbctUUGpqNfqW7iKVf+cU20e8LkBV1ZtMd6NiWC8DiGFhVEFnTZo4b1pSwIbkcXugaL
 vFBH0+2gIGX1ysKArkv2a7oUb/4/ntrFkOcjWbwnzu9Dp6eA28rFpOVvUOU9ITkgGXjhGbGd0El
 q0QMf2i3trX5RHaPFP+CaOp8Yu77P9XOtXCXZjwzSpejgvRGbaJaaFfla6UuFWbfRKyV2rKN2sF
 Y5mFjp1Wed1II9x5RgPaqZ/Y096n434wErAQ0jDVJwK4csKybpt+Y/yx0UHGVNAF/I+tz0TNzg9
 Mz0WFp5RalQirX4o3ZPAxn++1b3JZYYPTb69IWM4RIYgENeJtvKxAy4RjkIe/h6KhH2vaROo7kw
 +sLZdWVIzc/NvHbuNyxcmU2s9c3ZPHpG2zsQ4M4+imcHYml0paN3o5bcWcalhu0S6DzoDFRSn+n
 PVFas9c+67YA+eqbjfZvz1p60itXmeL9ZEhrGs5O4Fxg+RVnNkXlrq0oD0y43Accyr5xBC9CvXB
 Bg4z3LXYNMSXXi0CJFmP/WEG1KpPTrFfH09kAIfUYpqUQ2zA5mhNg44JoMVUUt6u5n3OHxI+HUG
 jwCgWyRUO1JgQF/TsTu22wSyUgIf2RtHZFulWVdqFHpXWx2pRezZy+PMfTkNIlGUv8aHsN+zyi6
 UXlaa8sn3vedMow==
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

The user-space need to properly account the data received/sent by
individual subflows. When additional subflows are created and/or
closed during the MPTCP socket lifetime, the information currently
exposed via MPTCP_TCPINFO are not enough: subflows are identified only
by the sequential position inside the info dumps, and that will change
with the above mentioned events.

To solve the above problem, this patch introduces a new subflow
identifier that is unique inside the given MPTCP socket scope.

The initial subflow get the id 1 and the other subflows get incremental
values at join time.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/388
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 5 ++++-
 net/mptcp/subflow.c  | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5b8e488bce1..4ebd6e9aa949 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,6 +96,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
@@ -847,6 +848,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_socket && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
+	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	return true;
@@ -2732,6 +2734,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
+	msk->subflow_id = 1;
 
 	mptcp_pm_data_init(msk);
 
@@ -3160,6 +3163,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 
+	/* passive msk is created after the first/MPC subflow */
+	msk->subflow_id = 2;
+
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 27adfcc5aaa2..bb4cacd92778 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -323,7 +323,8 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 
-	u32 setsockopt_seq;
+	u32		subflow_id;
+	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 	struct mptcp_sock	*dl_next;
 };
@@ -504,6 +505,8 @@ struct mptcp_subflow_context {
 	u8	reset_reason:4;
 	u8	stale_count;
 
+	u32	subflow_id;
+
 	long	delegated_status;
 	unsigned long	fail_tout;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4688daa6b38b..222dfcdadf2e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -819,6 +819,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (!ctx->conn)
 				goto fallback;
 
+			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
 			mptcp_pm_new_connection(owner, child, 1);
 
@@ -1574,6 +1575,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->subflow_id = msk->subflow_id++;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	sock_hold(ssk);

-- 
2.40.1

