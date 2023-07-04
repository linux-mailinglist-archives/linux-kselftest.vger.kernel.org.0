Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29574791B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGDUo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGDUo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:44:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40410E6
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so65921855e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503493; x=1691095493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9+vtbDr/83fQnYq7vQfS8obpzLNRgRXKiB0wIBmyH0=;
        b=dDcIwKrxO+HEq9ri/Cq6iieSfRxEKcKW4RwIVnf3DXJZpfr2p9BB2lzfQ8tHsaItOd
         MvUD5fRsKgQsDGk+pYer9hH84a90D2cibTDaVtGQssa9gpBmTwwLaYhUqtzZwgYNmxxn
         oR8GQxHrq8QvUBPYICwr5TvF2f63HIXmIH8IAlgwy2rKhuzUlmrhKs2OqQo1knReekkh
         +5tOjzW4OZdWTWODHSaL+f8IOatR9FyzB/wlGd3KwAEZCU4/QC/DrLzoB1VhOD7x/CSZ
         8SxYBdg4lXjzA7/WQwQSQ4mbbi9MJEbFzeG7FoB8PbiLPGO2ZNzG7ksaz4eyeP1hPsI2
         /WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503493; x=1691095493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9+vtbDr/83fQnYq7vQfS8obpzLNRgRXKiB0wIBmyH0=;
        b=IFJPMWZSgkzflL0QeZO+1972Gp/tC5EypeQd+fc1kKWPPnfbH6yZWuV6vTySDEypiK
         NIhE5UefO13KXuu2qgvfs7j7i8grtWu44FhAwKA9SU/zjGfJbKpAaGOpulnj76wBcmCb
         0R9JtrN93nNdKkc3xOAn2MA29xmWGynyHz373GIBOjQ4C3z0ba7NzgP70GjSlYYC7ypZ
         3nc4TtZOU6URQo4gxUF1JklQVsWp7LEfS18UL0qZH9GiEamFxoK5VMoqXjPKsxHFHb3H
         bK92vGF73CfXMU804pR/RGCKv9JRMiiY5dY/EtEEUqerphVY+YeKAZoPYTpq8ZBRfWi7
         qTTg==
X-Gm-Message-State: AC+VfDznJyYwDAewq5ZsmtWDzvYe5znGsnubT8Zqp2DXQ53pQMvHpjaX
        okejYu8Ra2Hjq9K6y+9cXxTmbryqzYtbtiUBt9xBhw==
X-Google-Smtp-Source: ACHHUZ4CWWrnvcHozRW3+LOF08ie6qtbTcP4Cmm6gefqwBg+2lEGmq2vk5XfoPcotZhZqiqAAN1wMw==
X-Received: by 2002:a05:600c:24d:b0:3f7:f884:7be3 with SMTP id 13-20020a05600c024d00b003f7f8847be3mr11702546wmj.4.1688503493621;
        Tue, 04 Jul 2023 13:44:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:53 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:33 +0200
Subject: [PATCH net 1/9] mptcp: ensure subflow is unhashed before cleaning
 the backlog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-1-d7e67c274ca5@tessares.net>
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
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=78yDWCcA8nZMCwaJymS1SUQrRgt/rwieryZs2j/mBnQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDTTJdrfCKEn0rRGWIZvU/RbuXBa0c61Ver
 f1XK72qPSKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c3OED/4yrhdxKWXDzRsPfRLPgPa5JSSeswZ5hDKLF8OS5fBmwoSdJdwsr3QS2cVZZ6pNudKf3En
 1IFzsMVNZmQxJPzJsens5nkKdp+++70BSMP+td5jpugtM6lj/xAHtjEBdxVnJqS7zaXFzs7Fqo/
 AlUYpsiBK/kvqK9rsyxHoygepYVFHi3Wi2drfzJISvEc2dqBxfVaEgr0QNSk9gBBRQNAIidt8Qo
 4FaP6D6pcDtcTGDLHBygt6zWt0dscev9L4LonP/ot4WJG2WX/1a+UXKmiCJKZjNPPfLB5MmX9ef
 kEhsaD1q5HB27+6yQXqFqYA0oBp1QN+bfoKFgbO1yk3X2XXojtvliebBTA3Lb5viA0nrMp9EKR9
 GZ5cKuZIe+dtY9WnjWV3j7C2I2Z5r5Hq64P9LJUXAuWalpDw2fetRPZQ9ykcBhgt5Th3ZN7u9/2
 HI3Z3E3KvDsJWKE9h4dQXggYe1rqNvb9DCoZSE5zAX1qk4sohtZnIL1EHHeNceeRo5nUoxYCh8Z
 pCJ5iFOdblW4MVMPLRz4ns+JX80nqFnzgQj09Po0hM/saBgiYTV/RQJq2dgUL1g0LLKopNl/ouG
 3DFLTYj2Tr70Eouhwm6E5KldqAuRbT9L2g4bM7ukSEUXJ7/E0hZz6HwaAKANcmcJsWXAEaZjGZM
 GwEc0r1z/3YRP/g==
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

While tacking care of the mptcp-level listener I unintentionally
moved the subflow level unhash after the subflow listener backlog
cleanup.

That could cause some nasty race and makes the code harder to read.

Address the issue restoring the proper order of operations.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e892673deb73..489a3defdde5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2909,10 +2909,10 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 

-- 
2.40.1

