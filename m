Return-Path: <linux-kselftest+bounces-32521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C2AACC5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2784E7A0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AD2853F1;
	Tue,  6 May 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBdbT4Cn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47972820CE;
	Tue,  6 May 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553237; cv=none; b=qtmf43Bis0GhwhhlUGeSacrsY25Dwlm0CQ+5bkMX90ZVg8lN83wflNSCSbAMWOLFu2zET9n2NDC10lVcjKyBSon0Mk1WO+ksTcAyXQYKVZ/xeus7eEJm/NZIua0uR/UKZQBF6JK5QZVJaKpujRr+awmqkC/xax0LXVBlGpzrC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553237; c=relaxed/simple;
	bh=wDGoJrItvz9Guz2NwKT+3LqsqxJYbeX52NMfs5S5dkU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VHR8c++Bf6BxJDcxXTHEmSXNnSoot7L+W4tJO+sZOYjGxHVOFguK5IWQS1sLfyUCOnaYyXcpzJVavaUabutUMH+ilKS+sgjSpr9YoShtwpFkGGCY+o+9Tn3Eyps3HUwVA+/1/QkAo4o3CKZblPmum7MCCpCbgFcWjiOu4431zcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBdbT4Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF1C4CEE4;
	Tue,  6 May 2025 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746553236;
	bh=wDGoJrItvz9Guz2NwKT+3LqsqxJYbeX52NMfs5S5dkU=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=tBdbT4Cn7poyAwiHItVxi+zCprTY0iLukWKRpbIh13P967MIdSX286LCXQVNTyeXs
	 1zZJcQjp+pZe1fvbQy6Vyudphzldau6eWNcbyHIU9rc315w0/gePNzlqXSqD1rJZIX
	 zBHyrhcx9Wb4xMMXHoRF7fxamj+NcniGtJg3ZC1kLwD7k6Bx9SJ3woMUu0zDKkB3w/
	 I9zquv3lUdD170b0xFWlXZsWYOD3fb+cXyGx0oxmfzV9Z8TfwKQuQyNLFjjdxV3v/S
	 FUnWa6NpVW3y8j6cL2F7qaah+T9mFfq488T0CDnOS9Sv6PkBo7cBsbmiIvxb1B9iTC
	 cibUDj//P3xkg==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 6 May 2025 20:40:30 +0300 (EEST)
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
cc: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
    "dsahern@kernel.org" <dsahern@kernel.org>, 
    "kuniyu@amazon.com" <kuniyu@amazon.com>, 
    "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "dave.taht@gmail.com" <dave.taht@gmail.com>, 
    "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
    "stephen@networkplumber.org" <stephen@networkplumber.org>, 
    "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
    "jiri@resnulli.us" <jiri@resnulli.us>, 
    "davem@davemloft.net" <davem@davemloft.net>, 
    "edumazet@google.com" <edumazet@google.com>, 
    "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
    "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
    "ast@fiberby.net" <ast@fiberby.net>, 
    "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
    "shuah@kernel.org" <shuah@kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
    "ncardwell@google.com" <ncardwell@google.com>, 
    "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
    "g.white" <g.white@cablelabs.com>, 
    "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
    "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
    "cheshire@apple.com" <cheshire@apple.com>, 
    "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
    "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
    vidhi_goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
In-Reply-To:  <PAXPR07MB79841A27EC04E89136330942A3892@PAXPR07MB7984.eurprd07.prod.outlook.com>
Message-ID: <1564983d-5bbc-c28c-351e-fc6ab8d4d4eb@kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com> <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com> <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org> 
 <PAXPR07MB79841A27EC04E89136330942A3892@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-994551896-1746553230=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-994551896-1746553230=:1002
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 May 2025, Chia-Yu Chang (Nokia) wrote:

> > -----Original Message-----
> > From: Ilpo J=E4rvinen <ij@kernel.org>=20
> > Sent: Tuesday, May 6, 2025 12:54 AM
> > To: Paolo Abeni <pabeni@redhat.com>
> > Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@ke=
rnel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netde=
v@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; =
stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; dav=
em@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; donald.hunter=
@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-=
kselftest@vger.kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <=
koen.de_schepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ing=
emar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@appl=
e.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@=
apple.com>
> > Subject: Re: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On Tue, 29 Apr 2025, Paolo Abeni wrote:
> >=20
> > > On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > > > @@ -302,10 +303,13 @@ struct tcp_sock {
> > > >     u32     snd_up;         /* Urgent pointer               */
> > > >     u32     delivered;      /* Total data packets delivered incl. r=
exmits */
> > > >     u32     delivered_ce;   /* Like the above but only ECE marked p=
ackets */
> > > > +   u32     delivered_ecn_bytes[3];
> > >
> > > This new fields do not belong to this cacheline group. I'm unsure the=
y=20
> > > belong to fast-path at all. Also u32 will wrap-around very soon.
> > >
> > > [...]
> > > > diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h=20
> > > > index dc8fdc80e16b..74ac8a5d2e00 100644
> > > > --- a/include/uapi/linux/tcp.h
> > > > +++ b/include/uapi/linux/tcp.h
> > > > @@ -298,6 +298,13 @@ struct tcp_info {
> > > >     __u32   tcpi_snd_wnd;        /* peer's advertised receive windo=
w after
> > > >                                   * scaling (bytes)
> > > >                                   */
> > > > +   __u32   tcpi_received_ce;    /* # of CE marks received */
> > > > +   __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters=
 */
> > > > +   __u32   tcpi_delivered_e0_bytes;
> > > > +   __u32   tcpi_delivered_ce_bytes;
> > > > +   __u32   tcpi_received_e1_bytes;
> > > > +   __u32   tcpi_received_e0_bytes;
> > > > +   __u32   tcpi_received_ce_bytes;
> > >
> > > This will break uAPI: new fields must be addded at the end, or must=
=20
> > > fill existing holes. Also u32 set in stone in uAPI for a byte counter=
=20
> > > looks way too small.
> > >
> > > > @@ -5100,7 +5113,7 @@ static void __init tcp_struct_check(void)
> > > >     /* 32bit arches with 8byte alignment on u64 fields might need p=
adding
> > > >      * before tcp_clock_cache.
> > > >      */
> > > > -   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txr=
x, 109 + 7);
> > > > +   CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock,=20
> > > > + tcp_sock_write_txrx, 122 + 6);
> > >
> > > The above means an additional cacheline in fast-path WRT the current=
=20
> > > status. IMHO should be avoided.
> > >
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c index=20
> > > > 5bd7fc9bcf66..41e45b9aff3f 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -70,6 +70,7 @@
> > > >  #include <linux/sysctl.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/prefetch.h>
> > > > +#include <linux/bitops.h>
> > > >  #include <net/dst.h>
> > > >  #include <net/tcp.h>
> > > >  #include <net/proto_memory.h>
> > > > @@ -499,6 +500,144 @@ static bool tcp_ecn_rcv_ecn_echo(const struct=
 tcp_sock *tp, const struct tcphdr
> > > >     return false;
> > > >  }
> > > >
> > > > +/* Maps IP ECN field ECT/CE code point to AccECN option field=20
> > > > +number, given
> > > > + * we are sending fields with Accurate ECN Order 1: ECT(1), CE, EC=
T(0).
> > > > + */
> > > > +static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield) {
> > > > +   switch (ecnfield) {
> > > > +   case INET_ECN_NOT_ECT:
> > > > +           return 0;       /* AccECN does not send counts of NOT_E=
CT */
> > > > +   case INET_ECN_ECT_1:
> > > > +           return 1;
> > > > +   case INET_ECN_CE:
> > > > +           return 2;
> > > > +   case INET_ECN_ECT_0:
> > > > +           return 3;
> > > > +   default:
> > > > +           WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> > >
> > > No WARN_ONCE() above please: either the 'ecnfield' data is masked vs=
=20
> > > INET_ECN_MASK and the WARN_ONCE should not be possible or a remote=20
> > > sender can deterministically trigger a WARN() which nowadays will in=
=20
> > > turn raise a CVE...
> > >
> > > [...]
> > > > +static u32 tcp_accecn_field_init_offset(u8 ecnfield) {
> > > > +   switch (ecnfield) {
> > > > +   case INET_ECN_NOT_ECT:
> > > > +           return 0;       /* AccECN does not send counts of NOT_E=
CT */
> > > > +   case INET_ECN_ECT_1:
> > > > +           return TCP_ACCECN_E1B_INIT_OFFSET;
> > > > +   case INET_ECN_CE:
> > > > +           return TCP_ACCECN_CEB_INIT_OFFSET;
> > > > +   case INET_ECN_ECT_0:
> > > > +           return TCP_ACCECN_E0B_INIT_OFFSET;
> > > > +   default:
> > > > +           WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
> > >
> > > Same as above.
> > >
> > > > +   }
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */=20
> > > > +static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int o=
ptfield,
> > > > +                                               bool order) {
> > > > +   u8 tmp;
> > > > +
> > > > +   optfield =3D order ? 2 - optfield : optfield;
> > > > +   tmp =3D optfield + 2;
> > > > +
> > > > +   return (tmp + (tmp >> 2)) & INET_ECN_MASK; }
> > > > +
> > > > +/* Handles AccECN option ECT and CE 24-bit byte counters update=20
> > > > +into
> > > > + * the u32 value in tcp_sock. As we're processing TCP options, it=
=20
> > > > +is
> > > > + * safe to access from - 1.
> > > > + */
> > > > +static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32=20
> > > > +init_offset) {
> > > > +   u32 truncated =3D (get_unaligned_be32(from - 1) - init_offset) =
&
> > > > +                   0xFFFFFFU;
> > > > +   u32 delta =3D (truncated - *cnt) & 0xFFFFFFU;
> > > > +
> > > > +   /* If delta has the highest bit set (24th bit) indicating
> > > > +    * negative, sign extend to correct an estimation using
> > > > +    * sign_extend32(delta, 24 - 1)
> > > > +    */
> > > > +   delta =3D sign_extend32(delta, 23);
> > > > +   *cnt +=3D delta;
> > > > +   return (s32)delta;
> > > > +}
> > > > +
> > > > +/* Returns true if the byte counters can be used */ static bool=20
> > > > +tcp_accecn_process_option(struct tcp_sock *tp,
> > > > +                                 const struct sk_buff *skb,
> > > > +                                 u32 delivered_bytes, int flag) {
> > > > +   u8 estimate_ecnfield =3D tp->est_ecnfield;
> > > > +   bool ambiguous_ecn_bytes_incr =3D false;
> > > > +   bool first_changed =3D false;
> > > > +   unsigned int optlen;
> > > > +   unsigned char *ptr;
> >=20
> > u8 would we more appropriate type for binary data.
>=20
> Hi Ilpo,
>=20
> Not sure I understand your point, could you elaborate which binary data=
=20
> you think shall use u8?

The header/option is binary data so u8 seems the right type for it. So:

u8 *ptr;

--
 i.
--8323328-994551896-1746553230=:1002--

