Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DF295040
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394482AbgJUP4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394475AbgJUP4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 11:56:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C9C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 08:56:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so3985506ejr.4
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0lTiqb5J9sY8vV0icb54lwEDBUajV0UVIORKH6LrNY=;
        b=pw6V1cbzdJ6aAPDs4ytDbsD7675deQrBlDE7Zfjq8ZmOkksqk1Hx+ZLxaKQ9ApsYk2
         ajf9p1fq9yHfime7IrTKw1XLB3KQWxS2WZ1IPfIRysWMvnO4SZPiXJYVjgKjpsJIhcLy
         nqO0C17hJVeFPG2QqUw/R4TlWfwCkRQG+gQH5TDieG98d4rNzIqDJXpwspF0hMWJQ1od
         msS/DrstME+3k0Ay4CZqSH4h6vDXu6POv2WgeFrDmPlU0G1AioBxDMofuqAm2vELfMBp
         Zbv+8AUvs7r+LYacrB3m3zdapjqTB7LpxaCKR1XC/TfCokDx8fzN8FuALYgSbGG+Z0Ju
         QYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0lTiqb5J9sY8vV0icb54lwEDBUajV0UVIORKH6LrNY=;
        b=m55UCsiRh/9FX1SLJJ98dnAEV9poInNamSLVfZBRX488TwFahrad13wJxcOf8vnW4E
         S/+Qf92FclZz7b+fbjBU5hpHkdO8fZrzDg1MUboUcDTaGFwNk8wjJm9Bfnip8FkjLH5c
         x43zcsP/XuF2a+UF8+w/ofs5ao7NogNTjvcPnbDhpIhv/yinqOSKHeSCovWY8g53rSjn
         P4xp7bQUxU46aW4UHf3WNoX4wJOgB9b3Y2rmhq2SdGxLYKghyfUzRgox+Tr61XMqp0es
         bgtD9t7sLh+Ls9KVC5SCy67kPwroUpzRpKqVQtjLXqWvnCGz2i2HJknaPpv2oLRbvrVy
         YQtA==
X-Gm-Message-State: AOAM532Zbh0TbMKKraxwySYaB31jrm8eeD3Q2bjmWbnw0Rtg9W+91YbF
        BlsqMftBfNN1BTwPbiaVVHgQl6I9qoSxqWLC
X-Google-Smtp-Source: ABdhPJySolT9z3HzmY7EyNWZ4ApJyxy/nC5R12XAm8kPOgoop3cN8exiEFcaAdXQ91v6+lomcP7ybA==
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr4414045ejb.155.1603295772516;
        Wed, 21 Oct 2020 08:56:12 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id k1sm2342278edl.0.2020.10.21.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:56:11 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: mptcp: depends on built-in IPv6
Date:   Wed, 21 Oct 2020 17:55:49 +0200
Message-Id: <20201021155549.933731-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recently, CONFIG_MPTCP_IPV6 no longer selects CONFIG_IPV6. As a
consequence, if CONFIG_MPTCP_IPV6=y is added to the kconfig, it will no
longer ensure CONFIG_IPV6=y. If it is not enabled, CONFIG_MPTCP_IPV6
will stay disabled and selftests will fail.

We also need CONFIG_IPV6 to be built-in. For more details, please see
commit 0ed37ac586c0 ("mptcp: depends on IPV6 but not as a module").

Note that 'make kselftest-merge' will take all 'config' files found in
'tools/testsing/selftests'. Because some of them already set
CONFIG_IPV6=y, MPTCP selftests were still passing. But they will fail if
MPTCP selftests are launched manually after having executed this command
to prepare the kernel config:

  ./scripts/kconfig/merge_config.sh -m .config \
      ./tools/testing/selftests/net/mptcp/config

Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 8df5cb8f71ff..741a1c4f4ae8 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,4 +1,5 @@
 CONFIG_MPTCP=y
+CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
-- 
2.27.0

