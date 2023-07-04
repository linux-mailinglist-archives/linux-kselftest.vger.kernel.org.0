Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FE747623
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGDQL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGDQL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 12:11:58 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CD8DA;
        Tue,  4 Jul 2023 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=3292; s=dkim-tub; t=1688487116;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9pD4Ch4S5j+ANwqD1CPw58d4xO0OpJUusf60fgZFUbo=;
  b=hfWY4UV33/eHHwR+FaYBf3Z/czA2f7hz/aaixxy6d1lKPsyUXAvm1jRu
   OUCQhP8/injsL0R5m8qSZUYYV2hQ2Ex8/h/b9y+b83qi80YkOkyo1Q3bL
   TvAqMnSmPf6dQpz/LjyrbIs029Wd1FE0PbPhQTkcxj2b93fieH7iJEU6d
   k=;
X-IronPort-AV: E=Sophos;i="6.01,181,1684792800"; 
   d="scan'208";a="1396566"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 04 Jul 2023 18:11:53 +0200
Message-ID: <bdffeca8e222b0126100dec5dcd9d9b186ea6905.camel@mailbox.tu-berlin.de>
Subject: Re: [PATCH 0/2] bpf, net: Allow setting SO_TIMESTAMPING* from BPF
From:   =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 4 Jul 2023 18:11:51 +0200
In-Reply-To: <64a33ce7b50d2_6520520875@john.notmuch>
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
         <64a33ce7b50d2_6520520875@john.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thank you for the feedback.

Just noticed I missed the =E2=80=9Cbpf-next=E2=80=9D designation in the sub=
ject. Will
add that in v2.

On Mon, 2023-07-03 at 14:25 -0700, John Fastabend wrote:
> J=C3=B6rn-Thorben Hinz wrote:
> > BPF applications, e.g., a TCP congestion control, might benefit
> > from
> > precise packet timestamps. These timestamps are already available
> > in
> > __sk_buff and bpf_sock_ops, but could not be requested: A BPF
> > program
> > was not allowed to set SO_TIMESTAMPING* on a socket. This change
> > enables
> > BPF programs to actively request the generation of timestamps from
> > a
> > stream socket.
> >=20
> > To reuse the setget_sockopt BPF prog test for
> > bpf_{get,set}sockopt(SO_TIMESTAMPING_NEW), also implement the
> > missing
> > getsockopt(SO_TIMESTAMPING_NEW) in the network stack.
> >=20
> > I reckon the way I added getsockopt(SO_TIMESTAMPING_NEW) causes an
> > API
> > change: For existing users that set SO_TIMESTAMPING_NEW but queried
> > SO_TIMESTAMPING_OLD afterwards, it would now look as if no
> > timestamping
> > flags have been set. Is this an acceptable change? If not, I=E2=80=99m
> > happy to
> > change getsockopt() to only be strict about the newly-implemented
> > getsockopt(SO_TIMESTAMPING_NEW), or not distinguish between
> > SO_TIMESTAMPING_NEW and SO_TIMESTAMPING_OLD at all.
>=20
> Yeah, I think it would be best if we keep the old behavior and let
> SO_TIMESTAMPING_OLD return timestamps for both new/old. It looks
> like it should be relatively easy to implement?
Alright, I guessed that would be preferred.

Yes, if there is no objection to making the added
getsockopt(SO_TIMESTAMPING_NEW) this tiny bit more =E2=80=9Cstrict=E2=80=9D=
, it=E2=80=99s just
a matter of modifying the if inserted in sk_getsockopt(). (And, well,
in the other case I would even remove this if.)

>=20
> Otherwise the series lgtm.
Great, thanks.

>=20
> >=20
> > J=C3=B6rn-Thorben Hinz (2):
> > =C2=A0 net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
> > =C2=A0 bpf: Allow setting SO_TIMESTAMPING* with bpf_setsockopt()
> >=20
> > =C2=A0include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> > =C2=A0net/core/filter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 ++
> > =C2=A0net/core/sock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 9 +++++++--
> > =C2=A0tools/include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3 ++-
> > =C2=A0tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
> > =C2=A0tools/testing/selftests/bpf/progs/setget_sockopt.c=C2=A0 | 4 ++++
> > =C2=A06 files changed, 19 insertions(+), 4 deletions(-)
> >=20
> > --=20
> > 2.39.2
> >=20

