Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097E74A78D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 01:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGFX0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 19:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjGFX0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 19:26:21 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F351BC9;
        Thu,  6 Jul 2023 16:26:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FB8A5C00C2;
        Thu,  6 Jul 2023 19:26:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jul 2023 19:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1688685977; x=1688772377; bh=ILwmPPxacB
        L9zHkUCRnVdWlL4Glqz4GoyWt1wwCPYNE=; b=oX2Lbacu5ZaiB4hPXiUf3PTxaa
        Z+2UiyVyluT96v6omjhkLL5pzeKuECXV2JAUrCOkn6gD+UTlznPXzrUrr8KlQIRa
        M0u0DGIKKW67iE/Qs5EyiEY15DqI5raRd6z3BsBI5R5Ftywgycm4o0Hh8ft06UY9
        jA7m48wenNlkcSHxSJTYYmGxGEJF6auz75ExNEGa/Oncn6JEV0BDR7IPrQkip3cZ
        ptioHTXIxx4PRCartqeV81ekU0uPa8ZkS5s6Fr4FRqX/hJe+lboN+oi/4MWsGNHt
        9oc4CZ8WDA8Cu8LMTp/49Mn8L4Ay0WtF3Jfrf9I+IKwUwBVG8zWfU5v3/hXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688685977; x=1688772377; bh=ILwmPPxacBL9z
        HkUCRnVdWlL4Glqz4GoyWt1wwCPYNE=; b=a7U9Y5pXlK/McK3TuGOYrQCbp1qlZ
        Gc2bY5/kUSE7PhsCRqJoetcE8jaO2QKkwztLsr/QQHNcQpJ/QufTI47DX6XurzzA
        V/arE28UuMHIkYVXhkePMzDgd0obl4/Vn8fciCOFw+XqPzd8BlWRGr+D0iWFqWWR
        iaGz85OUKhDYIqHraDxuqm9gRrlu0mRR5hL+1bl5fhcHC7h5wb4CRm+Gc+iZjRuV
        nrg+s0x93s+0OOJm+F+HfhoHGJnkOWLSqGSHn1J+eblu9iIpiUXncXp81rknJfzF
        9kD1DJ8hT77oAVstRVYFhUJj8MfApkySOslL2SbUX3FcuteuctjabBpXQ==
X-ME-Sender: <xms:mE2nZFPpRtm2CfCwEr9q2ivFyFM0yQJDe4m8wsP0OVRd_WatoXwMnA>
    <xme:mE2nZH8GTJNJBqzCdxlbEbHhtfEm9QA-fKUjf7mey3I68siJvKFB4f-UZ2OfcMmx1
    Iuy7BlvzKlmrXAtTg>
X-ME-Received: <xmr:mE2nZEQ2qRtXvsFI0S0hQRZx133cGIWSyK7HdpFu3aRbLgXiV0FNRfraHKe0RyT3XZQkRjuQCZsCpfyHVZoBTL1eUpumBdGKMVdbXxrv4UI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetgefhhfeigfejtddvteefff
    fgteekteduiedtkeevleduvdejueeggfdtfeegfeenucffohhmrghinhepihgvthhfrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    iguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:mE2nZBufYBER5ZlEgGn6xzP7cuO7fFX8KbT-l07JLeYk7vMu3bT_Kg>
    <xmx:mE2nZNfEPYiNN-E3BtGw3noSA2F4jNgb9o7zjum8nwPheIvKqyACqg>
    <xmx:mE2nZN2VQOoRQFZkF1arEtp3-mPJMf3JC-swxlu98P9Qn_UkQddZ1g>
    <xmx:mU2nZHsuUIIq88dUqvxaPLQN80XYNnh3kaqmvIRzfL7536n0J0fVhg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:15 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        bpf@vger.kernel.org, coreteam@netfilter.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next v2 0/6] Support defragmenting IPv(4|6) packets in BPF
Date:   Thu,  6 Jul 2023 17:25:47 -0600
Message-ID: <cover.1688685338.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 net/netfilter/nf_bpf_link.c                   | 149 ++++++++-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 tools/testing/selftests/bpf/network_helpers.c |  26 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../bpf/prog_tests/ip_check_defrag.c          | 282 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 14 files changed, 752 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

-- 
2.41.0

