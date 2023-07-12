Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EBD75149C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjGLXo3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGLXo2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:28 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE11EA;
        Wed, 12 Jul 2023 16:44:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7191F3200951;
        Wed, 12 Jul 2023 19:44:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Jul 2023 19:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1689205462; x=1689291862; bh=32DhVpjlB5
        qv2RGsaSG2S3DxCzE7pSAz5Ol3v4ZOloA=; b=Q+6YFmiE/uWOUcwnG5JjGTGP9a
        DfZaL1JEplHBINYyebNSzg4lgY7AW9vHXwo1ZdL+NnfcO2S6wWoqMw0pMXG0brRV
        nd0UIYW3nFTcLOqR3QFD/T8gfsZ4BjnWCEEyR0TDDKTTM1OZNs4qCIM0OIdtfPBN
        oMVgJ8L4ZJoqa8lZ8L6tfmOXxXXJI6GASPJ6xwLHInTRE8GSLmwU1n4BjbmXU58x
        oxpXoU5RYsXXOU3BeNudpYtAI4jAnAiBoN6cxcNeTqPkn8ZFJjy+NMNeJ6hDlYZr
        N5BfwsKKOWQFPzE7GJOpsbLo5Pu9CPkwg+L0WjcvF8Day37kpx83w9Iqbkug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689205462; x=1689291862; bh=32DhVpjlB5qv2
        RGsaSG2S3DxCzE7pSAz5Ol3v4ZOloA=; b=Lx/iwIed1H8kiK2S5PTiWd7pYxiKo
        6yzN4bomecJ8insQJaL/uCXVH3aehCCXmDnMxA+xs0RCtQsGZ8yxBtTr3kex8Uj8
        7AUtDOhJ2Pe3UTF5wc/12Hk9AF3pnjjKhRpHd1I6rFM95gx0O0S/lvM/mP/n8GNS
        0eLJeOxlRXQ2T5boTwFXnkOuXd7Ho5qTGg2SxXVAPgxY9iu2Eb6hzg6WK0lBISzo
        2E47KIHo8uZnUMdvLFYfAtZBb5CB+1bAJAm0rlUOWztaiupBxE1TelQFJ5qpuy0s
        zF1uDIMsKZCsN0nv4m7eoYQ/mUdYckC9BdPTm+9Gb9kVVIrxyNiTwhKaA==
X-ME-Sender: <xms:1jqvZOozHou81WdtgXLUfY9lJ52l4zIe2vRTza4mA9Pme5H9xm4_gQ>
    <xme:1jqvZMpyLm4IghaNnFnqSeul6Zv9TfaLbGx7IbOPEo__u5yPjr_h3sI7JkKBLpaxa
    hBKMkomF394Ca86vQ>
X-ME-Received: <xmr:1jqvZDO0gJrilWd9YDPAb0LGjjqBq4hhQYXgzsNGj6PsBw36uLif5gdPxNIzPhGKbjtl_9woyJQ8_HzXIFepUt2iYdJHfgmTdPFGKYVlbmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetgefhhfeigfejtddvteefff
    fgteekteduiedtkeevleduvdejueeggfdtfeegfeenucffohhmrghinhepihgvthhfrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    iguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:1jqvZN73mQjvozEWfF4-BHrk0AA8nQxhoy8vkl_-6aFiHQdMGH86Og>
    <xmx:1jqvZN7BKz_LGhpqVcWj8hZFuiwJeXlyzP80eAwsTLw_ZXuOwE79tg>
    <xmx:1jqvZNibXfOKLiBPs7yKP35wI3A9TvqJayLiNsF2jaZELMj06tUojw>
    <xmx:1jqvZHsP4Trw8WbzxrHouJNbZHsc4panCNpegQJhMOofCIy3OsXMug>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:21 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        alexei.starovoitov@gmail.com, fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next v4 0/6] Support defragmenting IPv(4|6) packets in BPF
Date:   Wed, 12 Jul 2023 17:43:55 -0600
Message-ID: <cover.1689203090.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

=== Context ===

In the context of a middlebox, fragmented packets are tricky to handle.
The full 5-tuple of a packet is often only available in the first
fragment which makes enforcing consistent policy difficult. There are
really only two stateless options, neither of which are very nice:

1. Enforce policy on first fragment and accept all subsequent fragments.
   This works but may let in certain attacks or allow data exfiltration.

2. Enforce policy on first fragment and drop all subsequent fragments.
   This does not really work b/c some protocols may rely on
   fragmentation. For example, DNS may rely on oversized UDP packets for
   large responses.

So stateful tracking is the only sane option. RFC 8900 [0] calls this
out as well in section 6.3:

    Middleboxes [...] should process IP fragments in a manner that is
    consistent with [RFC0791] and [RFC8200]. In many cases, middleboxes
    must maintain state in order to achieve this goal.

=== BPF related bits ===

Policy has traditionally been enforced from XDP/TC hooks. Both hooks
run before kernel reassembly facilities. However, with the new
BPF_PROG_TYPE_NETFILTER, we can rather easily hook into existing
netfilter reassembly infra.

The basic idea is we bump a refcnt on the netfilter defrag module and
then run the bpf prog after the defrag module runs. This allows bpf
progs to transparently see full, reassembled packets. The nice thing
about this is that progs don't have to carry around logic to detect
fragments.

=== Changelog ===

Changes from v3:
* Correctly initialize `addrlen` stack var for recvmsg()

Changes from v2:

* module_put() if ->enable() fails
* Fix CI build errors

Changes from v1:

* Drop bpf_program__attach_netfilter() patches
* static -> static const where appropriate
* Fix callback assignment order during registration
* Only request_module() if callbacks are missing
* Fix retval when modprobe fails in userspace
* Fix v6 defrag module name (nf_defrag_ipv6_hooks -> nf_defrag_ipv6)
* Simplify priority checking code
* Add warning if module doesn't assign callbacks in the future
* Take refcnt on module while defrag link is active


[0]: https://datatracker.ietf.org/doc/html/rfc8900


Daniel Xu (6):
  netfilter: defrag: Add glue hooks for enabling/disabling defrag
  netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
  netfilter: bpf: Prevent defrag module unload while link active
  bpf: selftests: Support not connecting client socket
  bpf: selftests: Support custom type and proto for client sockets
  bpf: selftests: Add defrag selftests

 include/linux/netfilter.h                     |  15 +
 include/uapi/linux/bpf.h                      |   5 +
 net/ipv4/netfilter/nf_defrag_ipv4.c           |  17 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c     |  11 +
 net/netfilter/core.c                          |   6 +
 net/netfilter/nf_bpf_link.c                   | 150 +++++++++-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 tools/testing/selftests/bpf/network_helpers.c |  26 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../bpf/prog_tests/ip_check_defrag.c          | 283 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 14 files changed, 754 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

-- 
2.41.0

