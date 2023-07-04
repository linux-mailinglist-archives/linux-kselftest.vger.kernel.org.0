Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C874792D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGDUpH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjGDUpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:45:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129710C8
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so437735e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503498; x=1691095498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irQcTZRmsJv9yLw+oo0R2smAEctmL3X55DWeBMb3Xgg=;
        b=AbdcFx/rQ2BupkcS7tHqQ7Ov507+5/oUa82g3ajawYumtqR/ZB5JE/tvxh8BnQuetX
         +2ErlL6WYuMv/FCCpm5LuR86PEh4ZRliv1TzZxU1Bq5rW8rfcmrp1+3/fYSoLxR18GWR
         IgZ8mFwXKhJLqtoWDd40PXCvaUo4kB0IjBy+i88V+nR7p1goMR6w0vTs87KJwSM3go1y
         42Ex7dtxXGgktJXtBH000UPPe0IwvgvFP7PETTDoKR4m3xYeBhg7Yh4H/Hd6YhVYoAnW
         OBOdsGQSExWPviJbxA6Mfv0j8EDep9I9EDckuedjES1/UFrJxSreaI8ELtgA2ctlrTmy
         HhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503498; x=1691095498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irQcTZRmsJv9yLw+oo0R2smAEctmL3X55DWeBMb3Xgg=;
        b=TfSpsPDVMSSLWZRGDUwAMCIP868ZUtlv/RnVzaYYzyaTvIYSOZirMCFVD9pobYU73s
         DMwidbuAknIMfCvxCOMn50WOo8a1qX/q+MDd22aqaACwQBnlHejH0qFTQ+UF/ZC/NU0m
         Yy1P8G5WHFIfe4Y3rTq7aS9lIop2QcLqutV9CWJWtbPmOIUcc1Lby5Wb7I3dHyKxzqcB
         C3mvnhVw7igcjzry1gtNPrkzS5oW7Jn42PzLrF8M6zWAiFt9vsm9FOU3Z34V1KrDhTos
         vtY/ejQyqNXg+1+6U5m2mhoAw22cfRLeskkHblMMl6vGtIPrALjpeNjnWi59HaN73aY0
         Nvog==
X-Gm-Message-State: ABy/qLbwYqMjOIBW7XRn+MQ72DMEuSINTVJyUDwg54GDYk9gaSCXTO8j
        SgKb60dwy352ESVQkvyQNkiPag==
X-Google-Smtp-Source: APBJJlHVCDv2kYSOQsWKbxCTvcUMIPr4hZjuOTdzmgEd2cJycCTGIblQN7NvX5IjUohWlVIc7EfkDg==
X-Received: by 2002:a05:600c:4446:b0:3fa:ef97:1fa5 with SMTP id v6-20020a05600c444600b003faef971fa5mr313961wmn.6.1688503498304;
        Tue, 04 Jul 2023 13:44:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:58 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:38 +0200
Subject: [PATCH net 6/9] selftests: mptcp: userspace_pm: use correct server
 port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-6-d7e67c274ca5@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=W8jKw1hMxiLOeZZvDuf1XZG5l8hWMmDQywIII/N7bcg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDVUs10maSaUizFfzW/5uHbdpafk0qxzjwH
 ltHTHnsCzeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 czn/D/wPsNjzMUnZu6WAL2gtkZCLSrk2FqCTpvoiCaj+toarKac6awqKM0X2OQqAcS5XBgt3nLj
 qrrZxiHCPMZQFpHZX3tQVo/der59hrjtswqjbMrPabPWMZXNSA+RZZatIxjri3198Qk01HEfxsJ
 Iz6DAImHfy3IHQHmSrtVH88cpkFzfGEzLeoZaiDWeiX1Snpz8C+KbWuiHROmLb6YlpXqjHva867
 ubmVDe8dhJleDBoSm+A+iRR03+8EowX7Jxwi6m0Huz+jAwXnJ/DLFa8L04pmY5O3fWUVsk10N+3
 IVO3l1OGvH2NP8AYNUjW0r0wAfU2x3Qh3BDqL3kRa0+TDzSAH+97/9Ep2o/W5QJL9cIz9YoPFeg
 JK9lRycRKMlEYeEODlIHg5Iu5ExxU11jo9n+Eh1OSKwnZx71ciZ3nmJm/yzdkbI7J0D1OewS3+P
 If80l9isMxznoyNNC4CcRszZ3jXl1Vq6P4G+zDOWmPYiuNEXjxAfitUqYX0tgGZZ5H7SgLZ3GT4
 U1kLzOr4hILxJWr4Sx8cQDT4L9gMZc0PkXGbCsPS5NmYakmVTJiSMBhkXq4r3It8Kdae7biYxCt
 UqNtEHOk6jaqgTB1x8bWjx/kH1DzJygKg8//96n6eE2erpDQt6YU49VfqwS9WZgogEb6xYrdQj4
 lDemp4eD5NsFKMQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"server4_port" variable is not set but "app4_port" is the server port in
v4 and the correct variable name to use.

The port is optional so there was no visible impact.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 98d9e4d2d3fc..841a67a7d524 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -848,7 +848,7 @@ test_prio()
 	local count
 
 	# Send MP_PRIO signal from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$app4_port"
 	sleep 0.5
 
 	# Check TX

-- 
2.40.1

