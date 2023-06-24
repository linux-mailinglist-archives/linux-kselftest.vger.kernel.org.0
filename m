Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADB73C5FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 03:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFXBqJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFXBqI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 21:46:08 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFE26B0;
        Fri, 23 Jun 2023 18:46:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57045429f76so11170887b3.0;
        Fri, 23 Jun 2023 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687571166; x=1690163166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ohlWj59dfEBl6C9lQbUMUfwQD797JYV3vAdsQL++H0=;
        b=MeCFnRmIknlhdVic+wRlWdemV0cpT0JGgYzXmrNZFr7yyl9rZlYiOxgTckrsQLaZci
         wfwneuY1oYpHU3jdMhxFIBHLu1VHrte1J/AvRS84UdG2JbGvSKDa5SDcItt1Dvds4hln
         v4Fz1lqgHJi9Q572c/ayqDaK22FB+4usIN0qwcjsKO1NQJ5pr88XSjZbK0WlbfURosIV
         WkKYzkfpgG4WzpyMR1Xf7X6EmBu0R7TmMZg4jyJJnZ+n6QZKCTPOqt3seTAIWeqUIXgk
         EYSmKBVB3/xC95DqhZfTGHalpAT+Uk9xNA6bsDM+mEewuUDg1LkmI+l7BnEBnHaB++S7
         baKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571166; x=1690163166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ohlWj59dfEBl6C9lQbUMUfwQD797JYV3vAdsQL++H0=;
        b=KrhG0r7sY99yT3T5bvHm48qrdB91fYIXm5Laj/3Zohxjg7uKKAeeZvCfYhm1vFYFxE
         lWyDqcGF93YCdt3OOZd0ffb2052QDxBB13IuG7lg9fX5yvEuMO+J+q68bqaPSD9fZ6EL
         BYsyysZBS+cBwC6GBftC01U9loPr4J9/qaoE8tlMrHjwfyhpVytL7vPIznG0C9Yx7YaW
         Bv4wK7vzLS7vMrHSWSUD5JwhXlhNtVdLN8GmmU9XUOTVBIWIWIlZ/fJc45zTen1XCu0B
         gVnBraNU6jJLpEe7kt5QwhVWrzReXRO3yfvNeIyKlRsm8IjSIreU3TDZUZ2kbPmPmm69
         FaGA==
X-Gm-Message-State: AC+VfDxs1bq/vyxve1UZfxqcEqcC++rCEbmSDOapn+u/ilkKqOz9JQjV
        cwI0wgJoliCVCbX8k7N1d4zhK2CPotI=
X-Google-Smtp-Source: ACHHUZ4oJqe52Nfo2u8yQrMY4vv9jVoTt/W2ISth1Cw2R8m1F2BHzq6LMln+BuMiDmbITKS4YHyKbQ==
X-Received: by 2002:a0d:cb89:0:b0:56d:a55:4b25 with SMTP id n131-20020a0dcb89000000b0056d0a554b25mr22051794ywd.40.1687571166054;
        Fri, 23 Jun 2023 18:46:06 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d5fe:ab6b:8508:3503])
        by smtp.gmail.com with ESMTPSA id b126-20020a816784000000b005731f3c8989sm107916ywc.62.2023.06.23.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 18:46:05 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com, netdev@vger.kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 0/2] Fix missing synack in BPF cgroup_skb filters
Date:   Fri, 23 Jun 2023 18:45:58 -0700
Message-Id: <20230624014600.576756-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
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

TCP SYN/ACK packets of connections from processes/sockets outside a
cgroup on the same host are not received by the cgroup's installed
cgroup_skb filters.

There were two BPF cgroup_skb programs attached to a cgroup named
"my_cgroup".

    SEC("cgroup_skb/ingress")
    int ingress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    }

    SEC("cgroup_skb/egress")
    int egress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    
    }

We discovered that when running the command "nc -6 -l 8000" in
"my_group" and connecting to it from outside of "my_cgroup" with the
command "nc -6 localhost 8000", the egress filter did not detect the
SYN/ACK packet. However, we did observe the SYN/ACK packet at the
ingress when connecting from a socket in "my_cgroup" to a socket
outside of it.

We came across BPF_CGROUP_RUN_PROG_INET_EGRESS(). This macro is
responsible for calling BPF programs that are attached to the egress
hook of a cgroup and it skips programs if the sending socket is not the
owner of the skb. Specifically, in our situation, the SYN/ACK
skb is owned by a struct request_sock instance, but the sending
socket is the listener socket we use to receive incoming
connections. The request_sock is created to manage an incoming
connection.

It has been determined that checking the owner of a skb against
the sending socket is not required. Removing this check will allow the
filters to receive SYN/ACK packets.

To ensure that cgroup_skb filters can receive all signaling packets,
including SYN, SYN/ACK, ACK, FIN, and FIN/ACK. A new self-test has
been added as well.

Changes from v3:

 - Check SKB ownership against full socket instead of just remove the
   check.

 - Address the issue raised by Yonghong.

 - Put more details down in the commit message.

Changes from v2:

 - Remove redundant blank lines.

Changes from v1:

 - Check the number of observed packets instead of just sleeping.

 - Use ASSERT_XXX() instead of CHECK()/

[v1] https://lore.kernel.org/all/20230612191641.441774-1-kuifeng@meta.com/
[v2] https://lore.kernel.org/all/20230617052756.640916-2-kuifeng@meta.com/
[v3] https://lore.kernel.org/all/20230620171409.166001-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  net: bpf: Check SKB ownership against full socket.
  selftests/bpf: Verify that the cgroup_skb filters receive expected
    packets.

 include/linux/bpf-cgroup.h                    |   4 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 402 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
 6 files changed, 834 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

-- 
2.34.1

