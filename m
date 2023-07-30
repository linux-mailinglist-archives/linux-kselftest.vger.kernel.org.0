Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB7D768457
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjG3IFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG3IFd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 04:05:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466B1BF3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jul 2023 01:05:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so32832705e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jul 2023 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=ZjH2k4XIfgl6uS73UzgK4wovQ15iQxQGiwFX7IOQscCb+shwV37MQ8aItVNiPlSuQ6
         IlnMNRW1qAhizdzjLqAUW6E7f6R4zPGiFbPvkxnuoBHMSjGI5JXPWnR8CjcdU6n2f1EK
         env7uzYZcAl1Gkf/V0xTRWfBZ/MpUKACyHI1DEKI3JVnd/0cMi3KiuGXhNGp9i/Ty/c9
         /uxhBzDOKBmcAvLa7+J+i2+/MtZvlW83uieHmxKMiSBiYd04/iWy4WSjgWFzPtuitsVf
         QgFUlBLgrG8LMpNlT49e1l+0w/rbahlCtd6LxGn5xCJA61sczDrKx3l5VMTg1FJrXsdj
         ++Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=KxZLlmvPjxsFs3+4FfOO8lcQH3LRNa9IUb/SROjwu88NhBTvmKHR+l1T4xFSr7pyln
         gs5Fl51TsbsRvSyI423ZVtzaquttIoXVu9znuQ78bw7J8KlYVZIPmx+ameUJT9ANu8Z3
         VKUQlY/CP92ymSsDzbekVdKIxlHzQ/Rk4GcgFrTWXfPRlnyKam622cGGXvTT+Ps//vk3
         kgBCJFV/IUMZBCkWkw90c++f3drI/p/f83Yhrl37LZj7Gr3DcmjxJkQuU8EDmjnjngVv
         QYmO5TgmMCkzjFeq/76i7apReiQzvi7Siz1HGCJ+BNghp6qWu5+c19WAOWzYIlSSCq0C
         zGAw==
X-Gm-Message-State: ABy/qLZDJOD9Wodel20oJ3Wf0Yu7VAJRaoIsozjcsLM9rgWYl3z0z5gn
        62T9H9mbrERZ4YicsY98W1bKgL4TEWjx1+PKKtfwqw0v
X-Google-Smtp-Source: APBJJlGd5gAPj/i7sI/3N9J/Nir1AuCmhJl8wHThq6nlSOmEiXmZovxjHRXi6Otdbw5V65hUCZsQPw==
X-Received: by 2002:a5d:5101:0:b0:317:64ca:eaf1 with SMTP id s1-20020a5d5101000000b0031764caeaf1mr4424857wrt.17.1690704330306;
        Sun, 30 Jul 2023 01:05:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:29 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/4] mptcp: cleanup and improvements in the
 selftests
Date:   Sun, 30 Jul 2023 10:05:14 +0200
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoZxmQC/z2NQQrCMBBFr1Jm7UAaQY1XERcl/dEBE0NmlELp3
 Q2CLv7i8eG9lRRNoHQeVmp4i8qzdBh3A8X7VG5gmTuTd37vjv7Er6rWMGUusL7F+H/larGy4pE
 MaspZNLIbg4tpPgSkQN1aG5Is3+KFfg66btsHKLzSt4sAAAA=
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=R+PsDSeOsK6DRQCgnPaQ0p8AQt2Q2fy33uMXa6qwvZo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnIeqEaf/93z9Oq2kkK8awgQo6LIJLZJuk70
 JbrNVHBe/GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyAAKCRD2t4JPQmmg
 cxNZD/9y/26FJR4a4x5mXCtzWRpRNEs6apsl4qRVW5GrS8INFeu8tmHSmSi1UPe3w4HOqkzNIOF
 sh5+Nh5JQvqUVl6stWCEYt+KhLmN3UnFbHhG18EJ6V82LAzuCBnImFTPsYDEwfBWkvXzYI0pV7W
 M8t11X4K+AJQqnj15rYzy/gFG+T35RetnT/dsrXhBa3OGID1L9A90sWG5v7JUpx+6/5L7h8zliM
 plGTFAOri3/5S5F2rwMrQ4QTKm1ZSwo5O6S0pt5ZeY0FVdoPuvvwNanyH6/H2WpLixxK5Be7sNg
 m7Xery9sz3mLwW21DcXsxmtC6rQuGtJrc9m1keKOIxdefgBve/wb9U5GNYylMlwcXBp4xHRUesD
 8NTciPV7VU/vmVYBRYQ28qLLTQXJK7v45C/wsukEPuWQIGlnQQeGEBFVHMYwP1I+JeQ5+v+tGE0
 AjvLfpYrkRfeygXmt2xMRUQ039qjJNi+Ey4/YnLN4/j+0h/BB4enFxhDxApJ3vvH7osV7Zqjsfn
 tAcObFdSf42A8/VYoEwh0MTdTZx1h3bcDgENlPEB5leE8ujG2OFzQSv3AP0VZs62GmiBigM2LjP
 8r8oScgrtZnFPGm+9cxnU2LZPu/s0HRD6jYZ23pOHScfQLu3h182RkLXOQrm1ujOtuNs0gCo/GC
 o/M4iQ+IGPmbz2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This small series of 4 patches adds some improvements in MPTCP
selftests:

- Patch 1 reworks the detailed report of mptcp_join.sh selftest to
  better display what went well or wrong per test.

- Patch 2 adds colours (if supported, forced and/or not disabled) in
  mptcp_join.sh selftest output to help spotting issues.

- Patch 3 modifies an MPTCP selftest tool to interact with the
  path-manager via Netlink to always look for errors if any. This makes
  sure odd behaviours can be seen in the logs and errors can be caught
  later if needed.

- Patch 4 removes stdout and stderr redirections to /dev/null when using
  pm_nl_ctl if no errors are expected in order to log odd behaviours.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (4):
      selftests: mptcp: join: rework detailed report
      selftests: mptcp: join: colored results
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 452 ++++++++++------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  39 ++
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |   6 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 ++---
 5 files changed, 329 insertions(+), 301 deletions(-)
---
base-commit: 64a37272fa5fb2d951ebd1a96fd42b045d64924c
change-id: 20230728-upstream-net-next-20230728-mptcp-selftests-misc-0190cfd69ef9

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

