Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062D75B903
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGTU6N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 16:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGTU6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 16:58:11 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84719A6;
        Thu, 20 Jul 2023 13:58:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 08E493202AC7;
        Thu, 20 Jul 2023 16:58:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Jul 2023 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1689886688; x=1689973088; bh=yUfxtH9RM9
        dukICZlQ4Vtj2WahFi7TaKXxx1t/LzP8g=; b=jnbUWFqLonaYD0wJnjWR447TLX
        6KZOS1lqBpHOkNRRBvyPNJwk4Du8ZOU7yn3R38vRetybkQyOhVVZHIZFX8cpcRW9
        PLQRKICpzBBEk+V2G29bKvuCWpGQBCSgtsczm8IGf04pUkmyFRzj1supFvWB67/t
        lr95C4+8+lCDc1KmpeJIK/ND9IMACKU2JJuQMIbqNK08QGyazz/utgXNJLYFT0LC
        80iXLhFu4FyT+MqPc9AGVzbGDYEiV4SnLC9lu5Xhnhh1HwWE6ACGDlSdMziwtF0V
        eWxG9q9JUbzbxLvNJJED+dTC951B5oVuj1Zdcpns4BstMUcXKrwNwASWbQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689886688; x=1689973088; bh=yUfxtH9RM9duk
        ICZlQ4Vtj2WahFi7TaKXxx1t/LzP8g=; b=utSeSJADxLz8NqE2H8w6aVSBOYOQc
        7/jy1qmi9qivajSdOjM2XFMtOWg5v9yOluvbtyW32apr2y1Cyauq1wV/s1n1TrE7
        qc4Z/wn3CtMz3NvPnnIixeYVIpVuA7cb5af0St1ncKp+zdobhQ2Aj6xShoQxFArX
        T6MVDWO8DQvZhASuy2SkUd1MqA2PdgtzgKAfWXomOPuToe4XhUYTyGJy08IV+pRU
        y4ied0xgoUvnh28sLl946YSzThM/SSYm4Iw5qGBLJF1qGN+74smha5H+Qz1sLsbe
        y2l5yiLYjos8l7frUh+w2L7cwy0yvpJOmN9rn1Au7eo92128HiAZUpklA==
X-ME-Sender: <xms:35-5ZL7_c3CmZkLaBVOEisa3FEYcfd5tqFSUs_O8OLkmfatBULR9Kw>
    <xme:35-5ZA60RuhMDOA6ksQdA6Knb0i00ggcxpLiMhy7w0A2QT_iPONcVKNaHGjYrRuJe
    jHEnEa2zRfxklPQCQ>
X-ME-Received: <xmr:35-5ZCeWJ4SsJCz-I_Y9f8wId1Xv9Ao3JnD2ntCBomlN5uhltNldO3wOFdCgNc1AzAnqSVzcRRwr1o-PRIjHVuGb9nbVLvj0qCiTkVLT_0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteeghffhiefgjedtvdetfe
    ffgfetkeetudeitdekveeluddvjeeugefgtdefgeefnecuffhomhgrihhnpehivghtfhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:35-5ZMJkmVizijuFXxAfkorLfsVy6RQaO9OZaIr4QbvUCKgfAgDv0w>
    <xmx:35-5ZPL28eShlmMQ578luou5CRnTZheuAmY5rWFRkb7QLFn5WNUdLA>
    <xmx:35-5ZFwt4uLgn_nLaEnO1XKcknE0F7jiNkhs2zKRxlQxnpK2PVdMdA>
    <xmx:4J-5ZG9WlL7jr04aRTSGf14rTCBvyDmyLJsP9-wYiW41pCncJnW5fQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 16:58:06 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        alexei.starovoitov@gmail.com, fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next v5 0/5] Support defragmenting IPv(4|6) packets in BPF
Date:   Thu, 20 Jul 2023 14:57:34 -0600
Message-ID: <cover.1689884827.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes from v4:

* Refactor module handling code to not sleep in rcu_read_lock()
* Also unify the v4 and v6 hook structs so they can share codepaths
* Fixed some checkpatch.pl formatting warnings

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


Daniel Xu (5):
  netfilter: defrag: Add glue hooks for enabling/disabling defrag
  netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
  bpf: selftests: Support not connecting client socket
  bpf: selftests: Support custom type and proto for client sockets
  bpf: selftests: Add defrag selftests

 include/linux/netfilter.h                     |  10 +
 include/uapi/linux/bpf.h                      |   5 +
 net/ipv4/netfilter/nf_defrag_ipv4.c           |  17 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c     |  11 +
 net/netfilter/core.c                          |   6 +
 net/netfilter/nf_bpf_link.c                   | 116 ++++++-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 tools/testing/selftests/bpf/network_helpers.c |  26 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../bpf/prog_tests/ip_check_defrag.c          | 283 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 14 files changed, 715 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

-- 
2.41.0

