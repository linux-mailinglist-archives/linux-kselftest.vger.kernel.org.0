Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31877DA0EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjJ0SrI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346360AbjJ0Squ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:46:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C681724;
        Fri, 27 Oct 2023 11:46:45 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C1575C01F2;
        Fri, 27 Oct 2023 14:46:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 27 Oct 2023 14:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1698432404; x=1698518804; bh=fE8aPn/CJu
        9lfh+4IEv0xtQPK1N/8Cxiy2mXzOknwuI=; b=mlYiwLF7RHnbWML4Rr8Ls5McjN
        tiGAGjjQnU3A15hmBnuQM/P685zvygXrb/AjZyhkQCEGQ1F7ap/T2CJnu69p6OyR
        n0q8Ji2XXKdU4UVTfO8sDg8w/vqDTKUt7oKFPu3Pt9RFF1TP85xGIuxTRUlywbSH
        lTC9keM4GzeAmnKMR5QO0kOinTSsC0YAebyRPJULbp9iOmzIn7H/1Dhy7PQ+d7dr
        3y6AK9w3Cx/Nh/JO6qgE+wrwmIfbrHom3vCSP0AocrCzXmM0vL4DGYY2p35TOATE
        ji2/RBOUpCqgqqYXfXcVhfbU6koM6yADojlSTOWVfM+jxjJMRqnAIITlDqbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698432404; x=1698518804; bh=fE8aPn/CJu9lf
        h+4IEv0xtQPK1N/8Cxiy2mXzOknwuI=; b=Lsnjiq5vQmSWeIynoGatmxHUaZtZQ
        LqbylnmiHt4owGwBl5afnsLsVJkEpBsrwDIdlqNV5Y7dmwYePUlAbW3XdTCgUv2y
        ixBPSyF6XB7xWxRAJ3Zs3wabqTgQAnVE2nsvgPElgO99PEmI3wuD+reMdPZavUR6
        QOgsG7+J4+2loRx0fI8z4LUVOiU+/CtxyBsTjor7uOF5lmJk6+xacn7JN3TZnU2e
        CeHWv6zHXGG2GiutciF9WqeH0KmBC3MSb4EOxNF7r+I1uyUEk+yH0v99Nwy9eGHU
        iKfdOrcHd6FNtYAGLuQKuG2cD/R3w6vA+aZIp9t9gensxusgQCHHwcKYw==
X-ME-Sender: <xms:lAU8ZZnLeAGckp3QuUja6PutsUUQNqGLDsdIBoeUN2eXhqqC-PkIOQ>
    <xme:lAU8ZU1CXM4lWoW3HEd5jqk4R8lC_Q-jwAQF_R7N3bskAkumPsRQGzEPemZBC08f1
    1a9dmgxtrHoD1aYuQ>
X-ME-Received: <xmr:lAU8ZfrANZ3tVZaxfao2ingFoxImdJ972zqhq-uYFzpRkfYmus71GALFkrOoQh3QA5PAI3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhephffgtefgkeelteevhefftd
    egjeevfeevuddtfedvvedutdeiffevhefghffgjeeknecuffhomhgrihhnpehivghtfhdr
    ohhrghdpnhgvthguvghvtghonhhfrdhinhhfohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lAU8ZZkynzIaUxCiFOyCUDgALdmimuXOeCJLBdjU5Sk1BZe0gWXcyA>
    <xmx:lAU8ZX3FjSQuOUB0T_u-VMGpAP3pp5OGVUL333LS6OVXEMNmzIKG5g>
    <xmx:lAU8ZYsA7uXF6MivgSLP3qesuQRXJ8rmkQfl266xExtqI-Saosjr9w>
    <xmx:lAU8ZX9wpIx7hha20EIq25aNiCXiZFDG0GGiQ1dYhRX8ZuVcNExMWA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:43 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        steffen.klassert@secunet.com, antony.antony@secunet.com
Cc:     devel@linux-ipsec.org
Subject: [RFC bpf-next 0/6] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Fri, 27 Oct 2023 12:46:16 -0600
Message-ID: <cover.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset adds a kfunc helper, bpf_xdp_get_xfrm_state(), that wraps
xfrm_state_lookup(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

More details about that will be presented at netdev next week [1].

Antony did the initial stable bpf helper - I later ported it to unstable
kfuncs. So for the series, please apply a Co-developed-by for Antony,
provided he acks and signs off on this.

[0]: https://datatracker.ietf.org/doc/html/draft-ietf-ipsecme-multi-sa-performance-02
[1]: https://netdevconf.info/0x17/sessions/workshop/security-workshop.html

Daniel Xu (6):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: selftests: test_tunnel: Use ping -6 over ping6
  bpf: selftests: test_tunnel: Mount bpffs if necessary
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: test_tunnel: Disable CO-RE relocations
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 ++
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 105 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    |  95 +++++++++-------
 tools/testing/selftests/bpf/test_tunnel.sh    |  43 ++++---
 7 files changed, 202 insertions(+), 54 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.0

