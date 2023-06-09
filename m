Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF272A56D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFIVie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFIVid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:38:33 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4840BCF
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:38:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 380CC5C2878
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 21:38:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C54375C2A52
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 21:38:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346706; a=rsa-sha256;
        cv=none;
        b=C4vIdrbNmIhHqMvv1zq5f8Uq7h6PtMZH1akw3DdvVxE3mwy7bobjCIJ4aSMRmLJQvXQ/dh
        NLCsgV5vbjJGZx0B2A/jnbdB8lvwqwRmVNajy+6Rh95GAwuh+a7IvX0GZgZ8pyYdth202M
        JCyNsquM/WFeFPe2wzxMCP9TQ/9kcSllsVLe89b90rRuuxZN/ncxu+2WQ4CJyDkVWDMQc0
        ZLthBXUc4khsyiPgnF/zSK3nCoJ8GCH7DVWTbDXcCqCgSmXp+8tne3M5zCBEcvRIEmnJEs
        omk+WrBVjV/OeU3hsaRfbw05mXSU00TxRJt2OfEi87pX93S9mWD1jAe5jiaKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686346706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=hfp8+qdPxPXYNum6peL8A5iWGjltwxBPJ7qhqGCpSWI=;
        b=d1qtEoYxWQ0W59LRDmX9jhlSX67U0CqQ66RYFHrzbL+786DhKZLH+XhNKdXNkLCpDeNR+R
        FtkDKrX0J/SCXfx1EUOnA5kTH+szgO6hhd8yZJCkJvLb2KC2VEMpyjDmv/e2hwHZEjkb+W
        2dFJn5MuUt6vmo5Wsigysak6VDg9VUjqxzw/7SU5n35P7QPzBy4LgRAaO8QX1/ZpFaVlHl
        bwZOXUbNifrZU+EhLsWbhB1zgowf2iDrY97px+jLx9u8i8yUeIlekW+5bskjVZcu3Q6a/E
        2NTFXp40SIU9rKyludCxEXuU3QqHWR29/sRW2dsFjKrlp6TFiJrVALaej7dA/w==
ARC-Authentication-Results: i=1;
        rspamd-7c78575475-9x9vv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Drop: 301f5baa05f3b2d5_1686346707039_1468119768
X-MC-Loop-Signature: 1686346707039:3998688610
X-MC-Ingress-Time: 1686346707039
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.169 (trex/6.8.1);
        Fri, 09 Jun 2023 21:38:27 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDwL3BC3zK5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686346706;
        bh=hfp8+qdPxPXYNum6peL8A5iWGjltwxBPJ7qhqGCpSWI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RHKXM+CvKcDBPT3gPCAWB5AfadQASGmY/AtfQhSpAPGoiE3VPfAz1lQnarU4Geo3F
         L20hXgbbjeWiDrfhOGmnIRH062nY3uafl3cL241qF2lSebn8FbMHMxRQQ9BiPGxOqx
         ydgjoQUwSGPxWsDSUiI8r42gFvY6H3gUbygeLA68=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 14:38:25 -0700
Date:   Fri, 9 Jun 2023 14:38:25 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/2] bpf: fix NULL dereference during extable search
Message-ID: <cover.1686345886.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
Enclosed are a pair of patches for an oops that can occur if an exception is
generated while a bpf subprogram is running.  One of the bpf_prog_aux entries
for the subprograms are missing an extable.  This can lead to an exception that
would otherwise be handled turning into a NULL pointer bug.

These changes were tested via the verifier and progs selftests and no
regressions were observed.

Changes from v3:
- Selftest style fixups (Feedback from Yonghong Song)
- Selftest needs to assert that test bpf program executed (Feedback from
  Yonghong Song)
- Selftest should combine open and load using open_and_load (Feedback from
  Yonghong Song)

Changes from v2:
- Insert only the main program's kallsyms (Feedback from Yonghong Song and
  Alexei Starovoitov)
- Selftest should use ASSERT instead of CHECK (Feedback from Yonghong Song)
- Selftest needs some cleanup (Feedback from Yonghong Song)
- Switch patch order (Feedback from Alexei Starovoitov)

Changes from v1:
- Add a selftest (Feedback From Alexei Starovoitov)
- Move to a 1-line verifier change instead of searching multiple extables

Krister Johansen (2):
  bpf: ensure main program has an extable
  selftests/bpf: add a test for subprogram extables

 kernel/bpf/verifier.c                         |  6 ++-
 .../bpf/prog_tests/subprogs_extable.c         | 29 +++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 51 +++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

-- 
2.25.1

