Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89937747930
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGDUpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGDUpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:45:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81310FA
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:45:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so59398135e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503501; x=1691095501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GDNvib6QZmeEngLmbfD0MP/CFixjMyasw17pjt5GlM=;
        b=abBErgxiaAQ7MZQ7fucza85sp/xYBG/N4N4qMdPT99RoNZvF5uU7rEPBMsh2vpyCuw
         PqFgSer9YY/68iY5TRNnXstmo6KfO8O2kXzDYVl9WpffbhTnsQoqMsrM1q9djg1FnFL8
         NpmBDbGh97C0J8m1QiyLnu0AJrSMrJ7WLBF+oheIoStrTf7eaz4uSvTxhBoAG67UzHGN
         ljo+O7fT5WIYd6xYFqV9lONzooAGdjsLtSsqBFVLSUG+5wX+P/9RBx/h5bz8S0+SXEiP
         u2xfBzmwhXZdH/CZ0n2y0u0Sw4FNLDZVIabcDPMe4Ee9lzfLyGvIbya/IhW3hSKayyvH
         fmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503501; x=1691095501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GDNvib6QZmeEngLmbfD0MP/CFixjMyasw17pjt5GlM=;
        b=bkvnTPuN14tP9JRxEi6v57jDdCRSysxDdL68VVLYGrjoFNrJWZN1KGboYbaxc1k+Nm
         gHmUh9y6xbsmIM08bWK/X5rmvA9UYwxQ4cdvMFX6jQcJQEjflsQZhBbu1HJoPtBa3BCO
         kMh/a5R94CSj5gon4MXuNfQKzhdW2i8Ba3BkYhfRaS7UkG29gdFUg79p5cnTq/dlbYy6
         SxqCZ9+Qla045xAaNHVX489heI5YIWRL+nNLO1mwRsGR3PjfOMCpzo4ARp5zyxnC9BA0
         K8Jcr7nzEmcfD7uPwDmwHER6ZZ86I8ntZ+dTxdsV/eeivGwVmXDx6Ha2VW2GUV5rp9nm
         gPiw==
X-Gm-Message-State: AC+VfDzXmRomLcIDyBy8WRG44RhPjL0raS0LcElFtG2aPgLlv7ZbloX5
        T1ZgbwF4UNO/xrbY2I5h0p0ugg==
X-Google-Smtp-Source: ACHHUZ48m5TTryjiHP5lseidA3LmSb86zf/V7P9rskuqKQ9nenuKa4+AWi9l8zb3PsBvodIiXgOp7g==
X-Received: by 2002:a05:600c:2185:b0:3fb:c384:89ef with SMTP id e5-20020a05600c218500b003fbc38489efmr10189045wme.17.1688503501104;
        Tue, 04 Jul 2023 13:45:01 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:45:00 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:41 +0200
Subject: [PATCH net 9/9] selftests: mptcp: pm_nl_ctl: fix 32-bit support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-9-d7e67c274ca5@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=u1k8iIN6l4SZJWpyeVyx7kGYVtesJznCZArOL3Lw7TQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDCL61mEtunnDwk6Rf0ldwTLYb6HJX73Tgx
 7uQFLbFrNOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c5uFD/9jO/kwOJQsQZ5OUb5E0p6aN3+wVxvFP3tEM0GikY0krZwGsHqiVy5A2r4PZSGL3X3RNSQ
 sDuR604XK4njHy1QQS7t2v13YFte66oha+/rOHxPpWwg6GQ7eHjFQP8wA6O2oYCkxI+lXwW9XqY
 /5cXrv08fmiTBPjMEVQ0FQklwYCIWPT4FOVsk7kC+01gs8uhdPoECeXMvtJFAX8FZg2M71xcwSo
 fP3NhyWEj8EM4tAS7vTSC21Tm7DT5+++k2R5tDKQHjoH6rbov7Fnqttb41oDGGcGQyFVtQQL/NH
 TadguNjqtD46bbCCJk1Gt4npIySxQ3cxw6HOI1I0UMbjUujoXMAOCutgD2qnCBi5EqOcd1sKQz7
 8lBkc2fYAKyC4m1n0eUatT6hktbQ/8CmNXg/sd1K3+u9s6QBUJ6e7zWTjqAYVoZqvkr1KVR4k5E
 onIqX5UIzRtSyrFqTzu5MbJ5HP9e/YvACev94zBJoR2Aax3BpaFjTH5FyzaNiqvNvLDjq4gHt/C
 EkmC+5O60hcky2lN96dliv7Wdb6WY4VaV3vUdsoWtaIQvvOZV2j7JrhHciqEGpJqchecXBEMF/f
 lyTu8Mkc2+kaRIBdirF0U49a6B9+mka30qMk4EDze9TpydMoQlT+rkEU5CjCxr6HJXuMVVz+c+h
 9k6/Knvzg1m6EZg==
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

When using pm_nl_ctl to validate userspace path-manager's behaviours, it
was failing on 32-bit architectures ~half of the time.

pm_nl_ctl was not reporting any error but the command was not doing what
it was expected to do. As a result, the expected linked event was not
triggered after and the test failed.

This is due to the fact the token given in argument to the application
was parsed as an integer with atoi(): in a 32-bit arch, if the number
was bigger than INT_MAX, 2147483647 was used instead.

This can simply be fixed by using strtoul() instead of atoi().

The errors have been seen "by chance" when manually looking at the
results from LKFT.

Fixes: 9a0b36509df0 ("selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE")
Cc: stable@vger.kernel.org
Fixes: ecd2a77d672f ("selftests: mptcp: support MPTCP_PM_CMD_REMOVE")
Fixes: cf8d0a6dfd64 ("selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE")
Fixes: 57cc361b8d38 ("selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY")
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index abddf4c63e79..1887bd61bd9a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -425,7 +425,7 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -551,7 +551,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -598,7 +598,7 @@ int remove_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 			rta = (void *)(data + off);
 			rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 			rta->rta_len = RTA_LENGTH(4);
@@ -710,7 +710,7 @@ int announce_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else
 			error(1, 0, "unknown keyword %s", argv[arg]);
 	}
@@ -1347,7 +1347,7 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 				error(1, 0, " missing token value");
 
 			/* token */
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
 

-- 
2.40.1

