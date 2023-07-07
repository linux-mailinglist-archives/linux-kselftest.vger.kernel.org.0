Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3F74B549
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGGQvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 12:51:06 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74E170C;
        Fri,  7 Jul 2023 09:51:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C08C032001C6;
        Fri,  7 Jul 2023 12:51:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Jul 2023 12:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1688748660; x=1688835060; bh=KOcsyq3Ero
        SSljv1cPyOfuV4mOZBwhb9/RtM03S9WTM=; b=iAbvDdN7hBHPy6klAdIAnAmJEe
        XrZFvpc+tffcuumDrztrSUJQ+cab01UVX+gkLYeiHjM4m+zFTBNRMvNmBqW9/ox3
        bUFzmAl+tYZt7+zaIgOQAnLhqqTPb9mKEBxvS2UydkzwHO9hxZC3ba7R+WnDCu3c
        QJfueWe2kA4IA4qYihzTcyzL9BVm+zDyQ1fcn+Gh6ENjICsGuOCmUgOJu08Btxr5
        jNri6XTRYW+jWZIjqd5sVzzVvo0mEnheMT4S+e1L86Hol72esvSc8XciKgI3q9uu
        LAX02N4de1VH6qeuEeumhh2Y3tZkL+g3o2OZr2fIgKAZ9BcY1UD855Bm219Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688748660; x=1688835060; bh=KOcsyq3EroSSl
        jv1cPyOfuV4mOZBwhb9/RtM03S9WTM=; b=MZRUAlD2lM1QZkPCTnPjTT55jcsOF
        i4B3jnZM0X9wOZTBgcU29QKkXzpy7CiAhw45E7CoWT1bKQh76svQTDb0n64AaT0b
        gvMXSsLzPg4UkSBLkcw3WDa75EJL0S9gROPguIfM7CcUgKJ4Fp17Q3H+GvBPDSCR
        rCNy8G91UL/jC1Uf944M9AUz6YGsVvmIpgp5mM2BNU6N9SH4d7wsIUZcpp50tkpn
        i9n8XsIljheRwMFeOZuzmxPPt6/BA15lbChHvjcvC9uthxsxq9HkYeqFSbt9CJZ6
        B8Jsw8Gk9hRaI5pU9SbxjT6m9sR+6jFqFWlIYX+VJ+wc+iGEBr6733Tug==
X-ME-Sender: <xms:c0KoZHwPbml_t4ypXadhQTYuLSJIfQH61W6_OZpD7l2YbT71e4EZpQ>
    <xme:c0KoZPQbDNx6aiSeUZMl2Hh8izf80DWFsmtqN_zVBVu63RO2fGgnYCsYQmtA5_IUs
    DqiNy7htcDK7xHaIw>
X-ME-Received: <xmr:c0KoZBV3leYcHPXa3yHrgzg4V0t1uwFFMSoRJv-tQA69Crrx7rvZ8XF38m4xZIs7v5HS7VcwLq55tF3CY5SPQxsdPvurzPtG1o9_PzHKCBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteeghffhiefgjedtvdetfe
    ffgfetkeetudeitdekveeluddvjeeugefgtdefgeefnecuffhomhgrihhnpehivghtfhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:c0KoZBj-37hHaB3ZjawY9B7g4BdfmoZUIF9-LRsL0EBTOBkNkvmhJg>
    <xmx:c0KoZJCEDEB71lADvVE-xXB1dE60RI6LV0TAxwFvzLKa8H-bywAzlw>
    <xmx:c0KoZKJtFBr7n5IS3OnPCv2rl5jbyEz40x5Wy6fUwSP4Dhn4ljjR-A>
    <xmx:dEKoZDCLRBRrDMDof97d1fLaKt9SBsvJvNtaUyH6ZtPmVctXum8ypg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:50:58 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-kselftest@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, coreteam@netfilter.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, fw@strlen.de,
        daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next v3 0/6] Support defragmenting IPv(4|6) packets in BPF
Date:   Fri,  7 Jul 2023 10:50:15 -0600
Message-ID: <cover.1688748455.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 .../bpf/prog_tests/ip_check_defrag.c          | 282 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 14 files changed, 753 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

-- 
2.41.0

