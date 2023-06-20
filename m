Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5D737189
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFTQae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFTQad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677991729
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f849a0e371so6453814e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278629; x=1689870629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxp3CVs+ro/rfTb6DauyD+1bhDyUe8sURUkY1mfasF4=;
        b=AYzwMd3MZg1214YypWfZYbwDUE2sSWfX6HyU4vxQP0M0/WVoXoIondiYKjClY9zWTr
         Enr5/bWTCwuCTn+PhrbU9d43EuCsVuceuL8jvGEKDM2VEAhAwLmJqJghORqZ3SuxXzgJ
         zM3QQgOk07UXCxtbk9qgWwPCvjVuLgjnhXqXfJRl755ycaWxK2qEzU7ChXhOrxd0jsCP
         xqI75sPTYm/AtTeF7c2t1Q/U1y1iUdmwRiopGvtkPghe7/tXz0UeOrvTUuyCCP79n8Vv
         SkkZ7EeSL85wS5eiHnpPBPtTipTCMTHO+HSDAWQDWqWW2BZAu3WIepgjtkvjcmJR17mZ
         z2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278629; x=1689870629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxp3CVs+ro/rfTb6DauyD+1bhDyUe8sURUkY1mfasF4=;
        b=kPgFMuy58MEn6v7rX6aARDu5PTPF/tzN3m6plIOGyDnTlCnPVmwlsw4gJuifI9usqo
         AgpD8FfbHR+P3EJimZBSKaWrEzbs1nJAOah8ek8wBCsNChPEVKcSHiJV6gU28IuVvuwF
         2jDwQHXAF2TlAUaI8XeJPmH0ctzp4jDwW2Qsql2S+QiMbwUERq0n9CQw70Bbpu1VSqaV
         GLsgfvhsJ5RTGFdXWMTRetVaNT3AJWXuWW0lTWVVL7ZQa+iQQLSPK4vztz9WUMvtY4jM
         BxwLB04hL+m2wBxYvuQ+B/zySTkbqPnUFdcLBTCtdtod35198bUoHWasbaB+5yf+1XRC
         0RBg==
X-Gm-Message-State: AC+VfDwpSk+Bb6a8ia7VL+OPuckLQCAy1NVlWIH1G1nfhS8GH/XuCzqB
        k5iIveO/1oPtLYJFtYsR4Xv/uQ==
X-Google-Smtp-Source: ACHHUZ6uilwXp07TNZRwvdGuWWYsuHTr4kjSUPpfXoEKYxSCLoDtcmI9g0YgWmjS6atRNA+E6Kaqpg==
X-Received: by 2002:a05:6512:3292:b0:4f8:5bbf:d195 with SMTP id p18-20020a056512329200b004f85bbfd195mr6036063lfe.20.1687278629665;
        Tue, 20 Jun 2023 09:30:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:29 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/9] mptcp: expose more info and small
 improvements
Date:   Tue, 20 Jun 2023 18:30:13 +0200
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXUkWQC/z2OSQ6DMAxFr4K8rlUIw6JXqbpwgilZZJATqkiIu
 zdUogsvvv7wvENisZzg0ewg/LHJBl9Fd2vArOTfjHauGlSr+nZSLW4xZWFy6DnXKxn/lovZROQ
 SQ2J0QWrXLwHJz+hsMjjpgXoaupHNCBWgqea0kDfricj3a/s0o/Biy++zJ1wseB3HF6D2l+KzA
 AAA
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=dY2I+IolmYYXRImtHvmVAlAFRqwyoGdykxww/AGy5GQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQjb7mU+QKVnbbw+czfA2vSKPJG0c7RFsJeo
 4v+4IQpncCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUIwAKCRD2t4JPQmmg
 c+U/D/9jKiSeGEGHapjar2jm7gJ7cydu8HVo6iI3cwgBqfWAtTZUvJu2PmJ5Tgmj8/pNny8z2Bl
 KIZSSv+oRJK6SPWTKQrF21t7kKebK755KlZYVPBc+8A55zFpt7eAzJiLofHDlfHmV+oxMfmVzIE
 tUJgX5r+7F4iiRpdmtKE6lEtrAE5iWv71oWzwYcG5N8Q2OtRjnWSaLHD11LIgsqzqTXFW+KzfU6
 BNrgbieXfod78A+yPSGl9igNN4Ut4LLHHu6U7WmFOS8bl63JUrtckM+4Uo4UjLRBThcNRNpqXJ9
 9lWuf3wNEaES/kZKqchCXSwqtjnxuIY+vzMvEm3qND1Qk4nEWORGrjz9AY71TKq/v/aC0JqKzV1
 EKtfuTMkUS1yKNUshf/UjAToclSKPYp3HqVIMala+Zpde//NL00nL6T3XiTZxZZkXjHUXDNoR+Y
 aEiynFmDb9POR687anxLaJL7qFTgW0kPrY7IhbVDQBVV+VPve+5bT0lFibKoBGLOuNIHZhxGqDb
 aWyg7+GTJec2sfQfDEm1/417T/01FfcG/oAdRTi8cWaxaaEtZ37fQUUB4XvOvYG/EqkaDxV1Cgl
 1TgcHyuoQD50XVkF/xDQiMFKXVjTC5faph3XdblLY6RqA//gaPEvv/7hKvpC0wyZfrQJBCD9hZU
 lZaTBLnTBd+w5tQ==
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

Patch 1-3/9 track and expose some aggregated data counters at the MPTCP
level: the number of retransmissions and the bytes that have been
transferred. The first patch prepares the work by moving where snd_una
is updated for fallback sockets while the last patch adds some tests to
cover the new code.

Patch 4-6/9 introduce a new getsockopt for SOL_MPTCP: MPTCP_FULL_INFO.
This new socket option allows to combine info from MPTCP_INFO,
MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS socket options into one. It can be
needed to have all info in one because the path-manager can close and
re-create subflows between getsockopt() and fooling the accounting. The
first patch introduces a unique subflow ID to easily detect when
subflows are being re-created with the same 5-tuple while the last patch
adds some tests to cover the new code.

Please note that patch 5/9 ("mptcp: introduce MPTCP_FULL_INFO getsockopt")
can reveal a bug that were there for a bit of time, see [1]. A fix has
recently been fixed to netdev for the -net tree: "mptcp: ensure listener
is unhashed before updating the sk status", see [2]. There is no
conflicts between the two patches but it might be better to apply this
series after the one for -net and after having merged "net" into
"net-next".

Patch 7/9 is similar to commit 47867f0a7e83 ("selftests: mptcp: join:
skip check if MIB counter not supported") recently applied in the -net
tree but here it adapts the new code that is only in net-next (and it
fixes a merge conflict resolution which didn't have any impact).

Patch 8 and 9/9 are two simple refactoring. One to consolidate the
transition to TCP_CLOSE in mptcp_do_fastclose() and avoid duplicated
code. The other one reduces the scope of an argument passed to
mptcp_pm_alloc_anno_list() function.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/407 [1]
Link: https://lore.kernel.org/netdev/20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net/ [2]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Geliang Tang (1):
      mptcp: pass addr to mptcp_pm_alloc_anno_list

Matthieu Baerts (1):
      selftests: mptcp: join: skip check if MIB counter not supported (part 2)

Paolo Abeni (7):
      mptcp: move snd_una update earlier for fallback socket
      mptcp: track some aggregate data counters
      selftests: mptcp: explicitly tests aggregate counters
      mptcp: add subflow unique id
      mptcp: introduce MPTCP_FULL_INFO getsockopt
      selftests: mptcp: add MPTCP_FULL_INFO testcase
      mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()

 include/uapi/linux/mptcp.h                        |  29 +++++
 net/mptcp/options.c                               |  14 +-
 net/mptcp/pm_netlink.c                            |   8 +-
 net/mptcp/pm_userspace.c                          |   2 +-
 net/mptcp/protocol.c                              |  31 +++--
 net/mptcp/protocol.h                              |  11 +-
 net/mptcp/sockopt.c                               | 152 +++++++++++++++++++++-
 net/mptcp/subflow.c                               |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  33 ++---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 120 ++++++++++++++++-
 10 files changed, 356 insertions(+), 46 deletions(-)
---
base-commit: 712557f210723101717570844c95ac0913af74d7
change-id: 20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-6b4a3a415ec5

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

