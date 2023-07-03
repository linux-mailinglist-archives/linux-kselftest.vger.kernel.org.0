Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE3746195
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGCRxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCRxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 13:53:11 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 10:53:06 PDT
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE3E6C;
        Mon,  3 Jul 2023 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=1488; s=dkim-tub; t=1688406787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tYxoSf5LmrE4cpA7IxtAMm4INNC8n+qNcVDWmGD7Rqc=;
  b=hV8X6A3VmKfhh29uX9FhisOyLGXIJyt0tESEQOQ001b3/w8rjM/CDrcR
   qbfMyL7uBAaxd3uCUVm3/nHj34dzAp1mZR9ovcHI9br4g+60aXV8MPYdB
   jtrTY3iLmgsppcMG+ZZ3+P9avdcxSDrPKBKXWjfHybDGY302hdcla2CRN
   8=;
X-IronPort-AV: E=Sophos;i="6.01,178,1684792800"; 
   d="scan'208";a="1387328"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 03 Jul 2023 19:52:02 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/2] bpf, net: Allow setting SO_TIMESTAMPING* from BPF
Date:   Mon, 3 Jul 2023 19:50:44 +0200
Message-ID: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

BPF applications, e.g., a TCP congestion control, might benefit from
precise packet timestamps. These timestamps are already available in
__sk_buff and bpf_sock_ops, but could not be requested: A BPF program
was not allowed to set SO_TIMESTAMPING* on a socket. This change enables
BPF programs to actively request the generation of timestamps from a
stream socket.

To reuse the setget_sockopt BPF prog test for
bpf_{get,set}sockopt(SO_TIMESTAMPING_NEW), also implement the missing
getsockopt(SO_TIMESTAMPING_NEW) in the network stack.

I reckon the way I added getsockopt(SO_TIMESTAMPING_NEW) causes an API
change: For existing users that set SO_TIMESTAMPING_NEW but queried
SO_TIMESTAMPING_OLD afterwards, it would now look as if no timestamping
flags have been set. Is this an acceptable change? If not, I’m happy to
change getsockopt() to only be strict about the newly-implemented
getsockopt(SO_TIMESTAMPING_NEW), or not distinguish between
SO_TIMESTAMPING_NEW and SO_TIMESTAMPING_OLD at all.

Jörn-Thorben Hinz (2):
  net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
  bpf: Allow setting SO_TIMESTAMPING* with bpf_setsockopt()

 include/uapi/linux/bpf.h                            | 3 ++-
 net/core/filter.c                                   | 2 ++
 net/core/sock.c                                     | 9 +++++++--
 tools/include/uapi/linux/bpf.h                      | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 4 ++++
 6 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.39.2

