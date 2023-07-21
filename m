Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEA75D5A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGUUYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjGUUYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 16:24:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CF3C3A;
        Fri, 21 Jul 2023 13:24:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 16E5D320095B;
        Fri, 21 Jul 2023 16:23:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 16:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1689970982; x=1690057382; bh=qK4jETCPwl
        HuZUy6Z7D6ph2KKy80jTJkS86PaPy+M2k=; b=Mwd7FNw1jZulDdy4QAGnqC0ea6
        m/G8sexiL+8han3C77hisHdCHDNdYWJSUwQVDqjCDEzw3hKxVNXwVZdp9/QXTeV0
        erDTFmCLKIyuEwioA7IE10wr4l1/mpjmyCZO31g93S3XNmRqE4aWhu5NAnUwUSnG
        rpnDyrAP6ZQNUb84CoWA9O6Nj65znaWHR17JO6p/cmQf2LUaMpqrZrzOil+Eo6aM
        cfR7bI3unWf+EfPHnBw9wQWjYeNhXRZIg/vl1ko4TWwi3+eL0vyyzrhHS3ulsd6X
        qwohVpU6K6HLCIr7vFd9eXaxjxBZ9rrSdGu0UqIWuh85USVHWrQ/4Mz2VnBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689970982; x=1690057382; bh=qK4jETCPwlHuZ
        Uy6Z7D6ph2KKy80jTJkS86PaPy+M2k=; b=nTHbZwehYvAsOEG0+arS2do0FDV4e
        06UZU64VQesI3cbI7yoCd14Bf8Zo3SoAY/QkXJvPyJT9nVAFiWotio6EgrTzVQj3
        X2tHHN7Sn9o9S4bAHuDSAyqIlgYefD417e+JyUgR62KRP1OO29nJE1zCb1ujUOjB
        P49I97AtvVWKxtkNfhdBJUdToA3VSpoJ4y/E78T3WNVucPISaEJLDosc0AZBzPl2
        FHpiH9dLfGFhdP6kQeM6XmnpUf5VOhyeOzyHdxdhIuBL/7NIt/Wj6myCsI3OrqTx
        Y2kY9BLVWv3+mL9tw9ZeDAcFU9SGURx34elnNiCKCjKCqebZt99sAComQ==
X-ME-Sender: <xms:Jum6ZDCclyWe9CdazcyRsD2k512N2SJqeAA0NeAHfnOfG6w3-BQ8pQ>
    <xme:Jum6ZJi8FhyqbiKhcRG-EkMyHLWDlUBFJIVQqgI0ZsQnKtAvZhXnHB6oCIGglubV6
    VACsq8qEv1iJkAd9Q>
X-ME-Received: <xmr:Jum6ZOk0nwbagzNn8iXRP9nnm_zJA-0X6fjlOMWdvtx702VJTcGOuZP31t3yHR01MX_Ka-IXil1ONhpIVpgFxAQEGNlP4D_D08OMK2NCBSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteeghffhiefgjedtvdetfe
    ffgfetkeetudeitdekveeluddvjeeugefgtdefgeefnecuffhomhgrihhnpehivghtfhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Jum6ZFxJAvWJKwewgmgjMqILCWqeDBAGaH1oNj6mpwmG9cOdPe7uqg>
    <xmx:Jum6ZISo9QRpiE8NNizh0csXfPvIGg2cckgOGAfHdgIRXXYL_Lbdrw>
    <xmx:Jum6ZIb0lSTcs_7W02ifOCpyn5FPCTYVTOznXaZkamrZCzVFexjf2g>
    <xmx:Jum6ZLEpGX4b-ImWApIBhlfkjFpG3JxQ1D2l7vThZbH8co_Q3kEdAw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:23:01 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-kernel@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        alexei.starovoitov@gmail.com, fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next v6 0/5] Support defragmenting IPv(4|6) packets in BPF
Date:   Fri, 21 Jul 2023 14:22:44 -0600
Message-ID: <cover.1689970773.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes from v5:

* Fix defrag disable codepaths

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
 net/netfilter/nf_bpf_link.c                   | 123 +++++++-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 tools/testing/selftests/bpf/network_helpers.c |  26 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../bpf/prog_tests/ip_check_defrag.c          | 283 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 14 files changed, 718 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

-- 
2.41.0

