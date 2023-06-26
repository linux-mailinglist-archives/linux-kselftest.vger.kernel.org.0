Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378F473EEE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFZXC1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFZXCZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 19:02:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21010E2;
        Mon, 26 Jun 2023 16:02:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CCD135C0120;
        Mon, 26 Jun 2023 19:02:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Jun 2023 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1687820539; x=1687906939; bh=i+8OuBfbOb
        CWELCv1iVIGo3uNjpR3WlawSQL1LNzwes=; b=VYB854Kusx3ppHI4Z4B3ZcDzis
        LRnU0J6seQeLryAj39+NkNO7UK2sVheAurLHbXp/HlMbM5TjwJmgnPIrRX4UQZ6N
        bMEJZKSQAMphpWHYYCXuDtaCZF8n1CzyCafqbuzcFAksQfzOZRJtlEfB1NvuKgx7
        zjWikoxx/DkV+poPwUYYF0p6XojcbTiTnCOwSSG9osczaNH1w2oTs0erP4kYlmGG
        /Z/x8viT6R/uWYGK65m9RRsc2+fY9K0f/Hr0pADrrnklQc5lGZhnNIDTGZys9Z4h
        l2nTbmcCUppXDotFevaI2qLKI2ZpoVCGAqKNwrSei+uKbn48Jik6fdTNZWeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687820539; x=1687906939; bh=i+8OuBfbObCWE
        LCv1iVIGo3uNjpR3WlawSQL1LNzwes=; b=o8GnYwts5WqsJGN8GMjOQMXmYalqu
        +3EOIGdNJ1haFTpwvAu9HAu2gip+u8LrYCq4/SmUw2vMncaOIPE3AeyTk5NR3Ei7
        dQMJIt0wDaFEuirrIJSm+el3uJ8YfSBITTvLgrvhl57bbOh+z97JHLtIfHLVNLdk
        s3t1YbQ8GiIypFBL7RS0YvaTZDI573j1Tdx696IKKY6yLUCDnFAqQlVEMp2W4uW1
        xP/wfxoz6ftKPOC3hZxDsm3oYfbD2NEEgkFzzZr8ujRd5cemc+7pccVw5nH8BRaq
        kayukgEeZT7/xAoPfi8ff8LwRH6PKYqF1EnpAsdEQ8GwOKfyA3ZzVWYaw==
X-ME-Sender: <xms:-xiaZEhOAvBFyJ7gletXvWP7WgarqYHMxSjB403qMpvhtRaSf4lvFA>
    <xme:-xiaZNAgpiUl3rtwwO5HRL12SZAtUWgSb0arrTXX6cTkpOxKR63IAKQAsiug4eMjY
    ICDQq_bVeJZrhNBZA>
X-ME-Received: <xmr:-xiaZMEwV-BAg-rxRVh5tPwwGoWVs-16fG9JX6Fe7E_2l8kAHrF9AEEoPH1wrxeghPaMlbm0s1Jp3MnYh6Pt1y9tSRFYdZ-kqDnJeAvt4lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepueekjeeviefghfethedtgf
    duheevheelfffgueekffetheelieetgfdvfffghfffnecuffhomhgrihhnpehivghtfhdr
    ohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:-xiaZFSUvG_G0tfySAKsXAV1NqaufI3PaWz2CJmOzTJ7DzxPOg_8Nw>
    <xmx:-xiaZBxkQtJUsE-Zju4j-GQUZMT-toXCOBXm3Osoty6dxou1YTct7Q>
    <xmx:-xiaZD5k7D4shybHrbzCZHig8DAABy2bF2jA6G0w3dK1xVhoGQzdlg>
    <xmx:-xiaZAx_Gax5MBN_hgx9JgewsUVrc04bPEYv-_RL-bNYKBaVd3j3ig>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:18 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
Date:   Mon, 26 Jun 2023 17:02:07 -0600
Message-Id: <cover.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

=== Patchset details ===

There was an earlier attempt at providing defrag via kfuncs [1]. The
feedback was that we could end up doing too much stuff in prog execution
context (like sending ICMP error replies). However, I think there are
still some outstanding discussion w.r.t. performance when it comes to
netfilter vs the previous approach. I'll schedule some time during
office hours for this.

Patches 1 & 2 are stolenfrom Florian. Hopefully he doesn't mind. There
were some outstanding comments on the v2 [2] but it doesn't look like a
v3 was ever submitted.  I've addressed the comments and put them in this
patchset cuz I needed them.

Finally, the new selftest seems to be a little flaky. I'm not quite
sure why the server will fail to `recvfrom()` occassionaly. I'm fairly
sure it's a timing related issue with creating veths. I'll keep
debugging but I didn't want that to hold up discussion on this patchset.


[0]: https://datatracker.ietf.org/doc/html/rfc8900
[1]: https://lore.kernel.org/bpf/cover.1677526810.git.dxu@dxuuu.xyz/
[2]: https://lore.kernel.org/bpf/20230525110100.8212-1-fw@strlen.de/

Daniel Xu (7):
  tools: libbpf: add netfilter link attach helper
  selftests/bpf: Add bpf_program__attach_netfilter helper test
  netfilter: defrag: Add glue hooks for enabling/disabling defrag
  netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
  bpf: selftests: Support not connecting client socket
  bpf: selftests: Support custom type and proto for client sockets
  bpf: selftests: Add defrag selftests

 include/linux/netfilter.h                     |  12 +
 include/uapi/linux/bpf.h                      |   5 +
 net/ipv4/netfilter/nf_defrag_ipv4.c           |   8 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c     |  10 +
 net/netfilter/core.c                          |   6 +
 net/netfilter/nf_bpf_link.c                   | 108 ++++++-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf.c                           |   8 +
 tools/lib/bpf/bpf.h                           |   6 +
 tools/lib/bpf/libbpf.c                        |  47 +++
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 tools/testing/selftests/bpf/network_helpers.c |  26 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../bpf/prog_tests/ip_check_defrag.c          | 282 ++++++++++++++++++
 .../bpf/prog_tests/netfilter_basic.c          |  78 +++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 .../bpf/progs/test_netfilter_link_attach.c    |  14 +
 21 files changed, 868 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

-- 
2.40.1

