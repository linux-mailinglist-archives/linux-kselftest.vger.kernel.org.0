Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012E73726C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjFTROR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFTROQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 13:14:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50A1727;
        Tue, 20 Jun 2023 10:14:15 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-570654fadf8so51322437b3.1;
        Tue, 20 Jun 2023 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281254; x=1689873254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRaalUOCoIVfPrkXnrF7LBogOQ5R9CqLsQELkMYwGpQ=;
        b=qYxn95q5Wba6IvRogpLkIvfFDh1m0VLshIb05xqVUgSbimCzlrtEGP20WB5oTWIk3R
         xlLbXSCczIl5Bbi9HTm76tmr+4ZGA+f+VRIv2LjKI3V8UE+1+e2UJN9EG7LV3JmJhQQN
         c/5Qewg2V9ULcubws23hTYrIvI8BvGrP2KrpadeBBjLjfeLPuOIYJAKkj9cYddzOsHZS
         AcEL1SFZLuSoid9Fke6nN5R2AIi1QuejidkmeNov8WyCsrpA6H3BMplqCg74Qg9siBn/
         gxLJ5tqELQBs+n4Uv4ibvW+JuXU/giGNqnb5JRhiFs2ZYDVK4K6vOgpErAcg+F57Bon1
         VIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281254; x=1689873254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRaalUOCoIVfPrkXnrF7LBogOQ5R9CqLsQELkMYwGpQ=;
        b=NTBMX01cIkQYOIK0iFn9zNyZQpa5BU/NMPnAMDR1aRqZmSPUHd9tSefqApeYCGMASO
         TaiF4VHYvUUYEdcf91A90RTlXJPVRebIdanhjXabChqA8GbX7Dg0VR1M4/Aoq5oqZqpZ
         szAYuP7EZ4GK3myoolr2j/XHEueP0XnS9sg/s9+jWM0jO6hUpIHYjFdh7KX3w8Eu21fC
         PjE0v1su1XdJOcbTm9aZnJ3ZL2XLU4L0oaUm5OitcltEsTjjFtfRdOhfVL+4Yj0umbgO
         yoxQ9cTeFW+4uBzPVoKawTSEoG8A6WOK7jetQAc8T6cohLd2/88AA64iEI2EQ7qYAyk9
         qjJg==
X-Gm-Message-State: AC+VfDyrUUE/Gy31S4rwGviOOvR4tmiCjXRusG6BlM2XFCA16zwGHJ6e
        QEwXLrES5Gl81Ozqg+PM4fgGkWhCK4c=
X-Google-Smtp-Source: ACHHUZ74skO8UWt4NetU63H1fOdc3/h278jiG0eDO9Ub6DCuRHxn3cxtMduRh0xAvXGysmc0mIvUig==
X-Received: by 2002:a0d:cb57:0:b0:570:22f:af3 with SMTP id n84-20020a0dcb57000000b00570022f0af3mr14139699ywd.22.1687281254477;
        Tue, 20 Jun 2023 10:14:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5338:88af:5817:a5f])
        by smtp.gmail.com with ESMTPSA id u81-20020a814754000000b00555df877a4csm195139ywa.102.2023.06.20.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:14:14 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 0/2] Fix missing synack in BPF cgroup_skb filters
Date:   Tue, 20 Jun 2023 10:14:07 -0700
Message-Id: <20230620171409.166001-1-kuifeng@meta.com>
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

Changes from v2:

 - Remove redundant blank lines.

Changes from v1:

 - Check the number of observed packets instead of just sleeping.

 - Use ASSERT_XXX() instead of CHECK()/

[v1] https://lore.kernel.org/all/20230612191641.441774-1-kuifeng@meta.com/
[v2] https://lore.kernel.org/all/20230617052756.640916-2-kuifeng@meta.com/

Kui-Feng Lee (2):
  net: bpf: Always call BPF cgroup filters for egress.
  selftests/bpf: Verify that the cgroup_skb filters receive expected
    packets.

 include/linux/bpf-cgroup.h                    |   2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 399 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
 6 files changed, 830 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

-- 
2.34.1

