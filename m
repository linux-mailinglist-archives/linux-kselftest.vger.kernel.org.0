Return-Path: <linux-kselftest+bounces-49392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D359D3B5F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C896F303D15D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4E38B7BD;
	Mon, 19 Jan 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX9zKjJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB838BDB3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847977; cv=pass; b=DI6ZXHEV9pfC1VBbVbShBBxq1aC2cYJrHE6oXly3ozvO3rRMTe4FC0EYbEWcXK81M5gXj/l+9Jr+MDcKeERM3Jp9315lcGPLM2Ts1uIWDGMnzaCf6lHNNvSC4p4ggKC6ixAzNfPIxIWZtHFTbZfBmkQ0GORrlMi1O0LaDB4mps0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847977; c=relaxed/simple;
	bh=V+N8d1kIeA9rWRrLTQneE3+OWDqZdZI0AdGdoISqd7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAGWC0/OWPv0QaINw7NYNIP1o62iNt5IsOtzfs+a32q/jOUkDQHMTShdagCIB9MilEhg1wIA1Icclo3IrYacSdXXhIyZPjDh/48+8BNSoE/IBSAVbbuqB6Ke1+gfN5u1sbxl4G43YrWUAghCpvdwg5iraeURIS8lQF2j3aqOFso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX9zKjJC; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014acad6f2so87841cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 10:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768847972; cv=none;
        d=google.com; s=arc-20240605;
        b=Iopq+GLoucA5WewDs/3Vm4ZMwt/dc9jWbcGbCpT5ews3e6Er+osbanWyGcqGNe+LM0
         MFZUCH6G2jZRVClEZzSiWwpvHtkH3QOUhWxtNcCUVRRBC6OUxsFIby7hgE1RcVtd0wlq
         r4qhBCzY8sJPz22rPZay+Xn6vNrIUBUQA66WlYuEPxaVUwR0oeInNUwPhzq7gI/cRzmr
         vfNDuiyDmB/Akx866JdhFGkKJT3LQijgPUIeAL2E4R3fClx2xQKaMo5NS/9Qvddw7p8m
         OsMEE4dG56nhIoYHXwZ9JRqiWRuMSJx2eO+RHaZv/AC4GFtKxopj42GpFRhHwITw/WMJ
         2J1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yliqXEmgwAyejYWqMYzVHnGIOpCtscuO1lvo+BwJm3A=;
        fh=zpJ06XdmpIr3YWH99Q6f7SYhXH/5OfGuVEaIPWRyV2k=;
        b=WobdePAd0Ak7JfGbWfgK+n9lnSn6g+63+ETzzgoEe94V2V4uBJHK+ErpJ1UpOWiB7H
         u86WlK0cdPMqrM79bN1uUwVSZICLoV2hGIdF33mXD5tRgHpFWIcwfifykKdb4ZpSTrF9
         RVTgesMUCbcSeN4Rz58FLhuJi9EQIaGTf0GHWjUNW9OyunRLVJQgWEcqMa46ZZdhUFvB
         GllOY+WnN9vKWkCwGWcgWcnpdVg04xWRWYh0sydsdKbKFlMgOC1yn4R6/F5qQzU+duSv
         B2h4Kwkt3qL1X6DqaKn9bXDh+LsC4Wn9tl+IIj1CmsVw/vnnuCrpssKjk5ZvD2wIyX/K
         U3iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768847972; x=1769452772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yliqXEmgwAyejYWqMYzVHnGIOpCtscuO1lvo+BwJm3A=;
        b=SX9zKjJC5r8Z42VimGGzQHhlYo2tgN8whQBP9w9OSymEdHq3+5SCa7UyWi88Kvl3pm
         MvyZT+TJpHk56Vu9tI7reXam4fFuGW6rHZnsHPtuI3F1GbyIOYJTBGdZ/Y8I9PgL0sbg
         1aGRm+VEJVX1NYxgrklCPnhVqpaFwNBY/HhR1joMO9PkTUL+8uP+6wy6FN490Rzgzawh
         GuFYUJSm5gLfrkbFV+YV41wGVq6aczWIm3QfEa/R+E1hjXzN6b9xEH4ztUXegZdg3WzR
         ZOFdgYyKq17Tl9ZEV2IfLrqxdTOqd7KoHJbJQfIHIy92d1PxZ8JnfCRjNAanQsPiE25E
         j02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768847972; x=1769452772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yliqXEmgwAyejYWqMYzVHnGIOpCtscuO1lvo+BwJm3A=;
        b=V6OaKHuEPcJEtShU47YyNbud805UJ+6xWzHB6gzmg6S+kypP0F6Bynlqr6HGGh1ieL
         G1J113euD4OkwD6/QcX8upB2vzmRqTgDxznKM5oZ3qhhrr2cbzMtYitCmQR1r4sK43gD
         mn17dbTnFZ5phBEIj4exdm/0UA9u6FqsBX+POc8Eoy4fncb/Mbrkz6fPDrcrbIrHPHpG
         +Wq6bJp6wLpvPFV6LChBrbo8zzClxs1IFhFrC9NzodlY6xexXYezX9FCRDAuSLOced8X
         WDdtR+mNOgmgpfj6FSuEv9uNAxTAm1mSP5Bodn5dg374MdGCW27Hqr3kUWq6vRRsgswn
         w0fw==
X-Forwarded-Encrypted: i=1; AJvYcCXu5f9KCXHab3VuFFAW3UhjDNlYlzZZEJPS6kwBnXy+w2eLXTLJuFvRq4rl+obbbK+pYuTiLVczktuulkBWjaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfGDDL7fNqxGa4nZfA/PJeownWtMUOUdOiORQZm/w7NYxq+sC
	FfFEjJSZlYCle60hsxk/s4zYo28ylrqAU0kUOXyv852VE0MZ+lmb6SbMQI6lOqmJ+4yPT7pTnYE
	zJo61lJrXAHPL9v/NOCz/hP0xIoRgcYIHKsfDUETZ
X-Gm-Gg: AY/fxX7swBXCHuERLEEhYbBz5lwLS1YLpTBIV2fydaZ67HMxBmVaoyvKjeFSfSHiBfs
	ES3uAzTfGa+iL78F5DhrvZtmm1vGOcWA6uX8/ZyPITC6jf+5wZB/OLoZx5To5wGiWWxcw6WMcg7
	ZIecG+zo/bag7X5WtlbOk9aQBmZO9B8tRgnxJXnfc4sKeaYeBbGHq39JoMDkyy0tBbDFl27eRd8
	0VFsZxQ+qzwfm12RcTxICEodaSHP9e/U/wQk+9DzVxYNsUfLHhazsEtE7lbIduIAwnW7cvB6CF/
	scUy5Ln56CGyhjF4u0YWFJPpLirOsndvA5QMTawWdqGGeuT0OWVj32Z+Ua9B
X-Received: by 2002:a05:622a:50e:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-502b073da00mr21734401cf.19.1768847971730; Mon, 19 Jan 2026
 10:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <CADVnQynBnqkND3nTS==f6MGy_9yUPBFb3RgBPnEuJ446Hkb-7g@mail.gmail.com>
 <PAXPR07MB79840B8A0D8FDC3778D79539A38BA@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CADVnQyn7dqO8m4UjjQvujH4z8HFYOm0_mb5xNpNhgTdpG8L_PA@mail.gmail.com> <PAXPR07MB7984F8BDD933827A117EF6E2A388A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984F8BDD933827A117EF6E2A388A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Jan 2026 13:39:13 -0500
X-Gm-Features: AZwV_QiSDFT3ZWaGQrFi11G5xz6c5fIfoidxzqFLWjR18imAARDYmBRTg0drjq4
Message-ID: <CADVnQynkpx4jkcTu2nbvcxL-FrZtSo3wKwhEhaEV27rZ5VC07Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"parav@nvidia.com" <parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 1:34=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com>
> > Sent: Monday, January 19, 2026 1:06 AM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc=
@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kun=
iyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmai=
l.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou=
.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@l=
unn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shu=
ah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; Koen De Sche=
pper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com;=
 ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire =
<cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Go=
el <vidhi_goel@apple.com>; Willem de Bruijn <willemb@google.com>
> > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packet=
drill cases
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Sun, Jan 18, 2026 at 5:56=E2=80=AFPM Chia-Yu Chang (Nokia) <chia-yu.=
chang@nokia-bell-labs.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Neal Cardwell <ncardwell@google.com>
> > > > Sent: Sunday, January 18, 2026 5:11 PM
> > > > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > > > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com;
> > > > linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org;
> > > > dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org;
> > > > netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com;
> > > > kuba@kernel.org; stephen@networkplumber.org;
> > > > xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net;
> > > > andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net;
> > > > liuhangbin@gmail.com; shuah@kernel.org;
> > > > linux-kselftest@vger.kernel.org; ij@kernel.org; Koen De Schepper
> > > > (Nokia) <koen.de_schepper@nokia-bell-labs.com>;
> > > > g.white@cablelabs.com; ingemar.s.johansson@ericsson.com;
> > > > mirja.kuehlewind@ericsson.com; cheshire <cheshire@apple.com>;
> > > > rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel
> > > > <vidhi_goel@apple.com>; Willem de Bruijn <willemb@google.com>
> > > > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill
> > > > packetdrill cases
> > > >
> > > >
> > > > CAUTION: This is an external email. Please be very careful when cli=
cking links or opening attachments. See the URL nok.it/ext for additional i=
nformation.
> > > >
> > > >
> > > >
> > > > On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > > >
> > > > > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell=
-labs.com> wrote:
> > > > > >
> > > > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > > > >
> > > > > > Linux Accurate ECN test sets using ACE counters and AccECN
> > > > > > options to cover several scenarios: Connection teardown,
> > > > > > different ACK conditions, counter wrapping, SACK space grabbing=
,
> > > > > > fallback schemes, negotiation retransmission/reorder/loss,
> > > > > > AccECN option drop/loss, different handshake reflectors, data w=
ith marking, and different sysctl values.
> > > > > >
> > > > > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > > > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > > > > ---
> > > > >
> > > > > Chia-Yu, thank you for posting the packetdrill tests.
> > > > >
> > > > > A couple thoughts:
> > > > >
> > > > > (1) These tests are using the experimental AccECN packetdrill
> > > > > support that is not in mainline packetdrill yet. Can you please
> > > > > share the github URL for the version of packetdrill you used? I
> > > > > will work on merging the appropriate experimental AccECN
> > > > > packetdrill support into the Google packetdrill mainline branch.
> > > >
> > > > An update on the 3 patches at:
> > > >
> > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgi
> > > > thub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96&data=3D05%7C02%7Cchia-y=
u.c
> > > > hang%40nokia-bell-labs.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4=
7
> > > > 17519675428d917b70f44f9630b0%7C0%7C0%7C639043779630263465%7CUnknown=
%
> > > > 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa=
W
> > > > 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dl6PAGPT=
ELL
> > > > T3KwEWsuLQnLaxQ0BUixhbrFp3n6dA950%3D&reserved=3D0
> > > >
> > > > (1) I have merged the following patch into the google packetdrill r=
epo to facilitate testing of the AccECN patch series:
> > > >
> > > > "net-test: packetdrill: add Accurate ECN (AccECN) option support"
> > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgi
> > > > thub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96%2Fchanges%2Ff6861f888bc=
7
> > > > f1e08026de4825519a95504d1047&data=3D05%7C02%7Cchia-yu.chang%40nokia=
-be
> > > > ll-labs.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519675428d91=
7
> > > > b70f44f9630b0%7C0%7C0%7C639043779630288017%7CUnknown%7CTWFpbGZsb3d8=
e
> > > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi=
T
> > > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dwct5GueZNjBZHCaxpbokNB=
LXh
> > > > pGpDFjKKUiIbCMiKco%3D&reserved=3D0
> > > >
> > > > (2) The following patch I did not yet merge, because it proposes to=
 add an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte pad=
ding hole at the end of tcp_info:
> > > >
> > > >   net-test: packetdrill: Support AccECN counters through tcpi
> > > >
> > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgi
> > > > thub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96%2Fchanges%2Ff43649c87a2=
a
> > > > a79a33a78111d3d7e5f027d13a7f&data=3D05%7C02%7Cchia-yu.chang%40nokia=
-be
> > > > ll-labs.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519675428d91=
7
> > > > b70f44f9630b0%7C0%7C0%7C639043779630306235%7CUnknown%7CTWFpbGZsb3d8=
e
> > > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi=
T
> > > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DHpI3cgq0qf1%2FrTCJACRA=
QZY
> > > > ZRs473MS3p%2BUB0VWATKE%3D&reserved=3D0
> > > >
> > > > I think we'll need to tweak the AccECN kernel patch series so that =
it does not leave a 4-byte padding hole at the end of tcp_info, then update=
 this packetdrill patch to match the kernel patch.
> > > >
> > > > Let's come up with another useful u32 field we can add to the tcp_i=
nfo struct, so that the kernel patch doesn't add a padding hole at the end =
of tcp_info.
> > > >
> > > > One idea would be to add another field to represent newer options a=
nd connection features that are enabled. AFAICT all 8 bits of the tcpi_opti=
ons field have been used, so we can't use more bits in that field. I'd sugg=
est we add a u32 tcpi_more_options field before the tcpi_received_ce field,=
 so we can encode other useful info, like:
> > > >
> > > > + 1 bit to indicate whether AccECN was negotiated (this can go in a
> > > > separate patch)
> > > >
> > > > + 1 bit to indicate whether TCP_NODELAY was set (since forgetting t=
o
> > > > use TCP_NODELAY is a classic cause of performance problems; again
> > > > this can go in a separate patch)
> > > >
> > > > (And there will be future bits of info we want to add...)
> > > >
> > > > Also, regarding the comment in this line:
> > > >   __u32   tcpi_received_ce;    /* # of CE marks received */
> > > >
> > > > That comment is ambiguous, since it doesn't indicate whether it's c=
ounting (potentially LRO/GRO) skbs or TCP segments. I would suggest clarify=
ing that this is counting segments:
> > > >
> > > > __u32   tcpi_received_ce;    /* # of CE marked segments received */
> > > >
> > >
> > > Hi Neal,
> > >
> > > Related to these 32-bit hole, two extra entries are added into b40671=
b5ee588c8a61b2d0eacbad32ffc57e9a8f of net-next, and one straightforward way=
 is to apply these changes also in tcp.h of packetdrill (This is my miss).
> > >
> > > +       __u16   tcpi_accecn_fail_mode;
> > > +       __u16   tcpi_accecn_opt_seen;
> > >
> > > But I would prefer to update this, because tcpi_accecn_fail_mode and =
tcpi_accecn_opt_seen overall just needs 8 bits (i.e., 4 bits for tcpi_accec=
n_fail_mode and 2 bits for tcpi_accecn_opt_seen).
> > >
> > > So, maybe we could add u16 tcpi_more_options before tcpi_received_ce =
and change tcpi_accecn_fail_mode and tcpi_accecn_opt_seen both into u8.
> > > Within tcpi_more_options, add one bit related to TCP_NODELAY as you s=
aid.
> > > And within tcpi_accecn_opt_seen, add one bit related to whether AccEC=
N was negotiated as you said, then we can leave more unused bits in tcpi_mo=
re_options.
> > >
> > > Another thought is to use a single u32 before tcpi_received_ce, in wh=
ich 4 bits for tcpi_accecn_fail_mode, 2 bits for tcpi_accecn_opt_seen, 26 b=
its for tcpi_more_options.
> > >
> > > What do you think?
> >
> > I would suggest something like your last suggestion, where there is a
> > u32 before tcpi_received_ce, with bit fields for tcpi_accecn_fail_mode
> > (4 bits) and tcpi_accecn_opt_seen (2 bits), and a tcpi_options2 for the=
 remaining unused bits in the u32.
> >
> > I am leaning toward tcpi_options2 rather than tcpi_more_options, becaus=
e I guess in the future we might want yet another options bit field, in whi=
ch case it would be better to have {tcpi_options, tcpi_options2, and tcpi_o=
ptions3}, rather than having {tcpi_options, tcpi_more_options, and tcpi_yet=
_more_options}. :-)
> >
> > And rather than a single bit indicating whether AccECN was negotiated, =
it occurs to me that it would probably be better to have a 2-bit enum with =
4 values, corresponding to the modes in tcp_ecn.h:
> > tcp_ecn_disabled(), tcp_ecn_mode_rfc3168(), tcp_ecn_mode_accecn(), and =
tcp_ecn_mode_pending().
> >
> > We also need to keep in mind that since the tcpi_accecn_fail_mode (4
> > bits) and tcpi_accecn_opt_seen (2 bits) enums are exported to user-spac=
e, they will become part of the kernel API to userspace, so should be moved=
 out of tcp_ecn.h and instead be declared in include/uapi/linux/tcp.h. We d=
eclare constant values exported to user space in that file: (a) to make it =
easier for maintainers to remember not to change the values for these, so k=
ernel changes don't break user-space apps; (b) to make it easier for applic=
ation developers to find the #define values they need to decode the values =
exported in struct  tcp_info. :-)
> >
> > So how about something like:
> >
> > --- in include/uapi/linux/tcp.h:
> >
> > /* Values for tcpi_ecn_mode */
> > #define TCPI_ECN_DISABLED 0x0
> > #define TCPI_ECN_RFC3168 0x1
> > #define  TCPI_ECN_ACCECN 0x2
> > #define TCPI_ECN_PENDING 0x3
> >
> > /* Values for tcpi_accecn_opt_seen */
> > #define TCP_ACCECN_OPT_NOT_SEEN         0x0
> > #define TCP_ACCECN_OPT_EMPTY_SEEN       0x1
> > #define TCP_ACCECN_OPT_COUNTER_SEEN     0x2
> > #define TCP_ACCECN_OPT_FAIL_SEEN        0x3
> >
> > /* Values for tcpi_accecn_fail_mode */
> > #define TCP_ACCECN_ACE_FAIL_SEND        BIT(0)
> > #define TCP_ACCECN_ACE_FAIL_RECV        BIT(1)
> > #define TCP_ACCECN_OPT_FAIL_SEND        BIT(2)
> > #define TCP_ACCECN_OPT_FAIL_RECV        BIT(3)
> >
> > ...
> > __u32 tcpi_ecn_mode:2,
> >     tcpi_accecn_opt_seen: 2,
> >     tcpi_accecn_fail_mode: 4,
> >     tcpi_options2:24;
> > __u32   tcpi_received_ce;    /* # of CE marked segments received */
> > ...
> >
> > --- in tcp_get_info() in net/ipv4/tcp.c:
> >
> > if (tcp_ecn_disabled(tp))
> >   info-> tcpi_ecn_mode =3D TCPI_ECN_DISABLED; else if (tcp_ecn_mode_rfc=
3168(tp))
> >   info-> tcpi_ecn_mode =3D TCPI_ECN_RFC3168; else if (tcp_ecn_mode_acce=
cn(tp))
> >   info-> tcpi_ecn_mode =3D TCPI_ECN_ACCECN; else if (tcp_ecn_mode_pendi=
ng(tp))
> >   info-> tcpi_ecn_mode =3D TCPI_ECN_PENDING;
> >
> > WDYT?
> >
> > > And I will update the comment of tcpi_received_ce, thanks for the com=
ments.
> >
> > Great. Thanks!
> >
> > neal
> >
> > > Chia-Yu
> > >
> > > > (3) The following patch I did not merge, because I'd like to migrat=
e
> > > > to having all packetdrill tests for the Linux kernel reside in one
> > > > place, in the Linux kernel source tree (not the Google packetdrill
> > > > repo):
> > > >
> > > >   net-test: add TCP Accurate ECN cases
> > > >
> > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgi
> > > > thub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96%2Fchanges%2Ffe4c7293ea6=
4
> > > > 0a4c81178b6c88744d7a5d209fd6&data=3D05%7C02%7Cchia-yu.chang%40nokia=
-be
> > > > ll-labs.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519675428d91=
7
> > > > b70f44f9630b0%7C0%7C0%7C639043779630323311%7CUnknown%7CTWFpbGZsb3d8=
e
> > > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi=
T
> > > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DkIDQalqUreGDjFAmUljiao=
dEq
> > > > kcxrypAa5YQBXsOvOE%3D&reserved=3D0
> > > >
> > > > Thanks!
> > > > neal
> > > Chia-Yu
> > >
> > > -----Original Message-----
> > > From: Neal Cardwell <ncardwell@google.com>
> > > Sent: Sunday, January 18, 2026 5:11 PM
> > > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com;
> > > linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org;
> > > dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org;
> > > netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com;
> > > kuba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com=
;
> > > jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch;
> > > donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com;
> > > shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; Koe=
n
> > > De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>;
> > > g.white@cablelabs.com; ingemar.s.johansson@ericsson.com;
> > > mirja.kuehlewind@ericsson.com; cheshire <cheshire@apple.com>;
> > > rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel
> > > <vidhi_goel@apple.com>; Willem de Bruijn <willemb@google.com>
> > > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill
> > > packetdrill cases
> > >
> > >
> > > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional inf=
ormation.
> > >
> > >
> > >
> > > On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > > >
> > > > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-l=
abs.com> wrote:
> > > > >
> > > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > > >
> > > > > Linux Accurate ECN test sets using ACE counters and AccECN option=
s
> > > > > to cover several scenarios: Connection teardown, different ACK
> > > > > conditions, counter wrapping, SACK space grabbing, fallback
> > > > > schemes, negotiation retransmission/reorder/loss, AccECN option
> > > > > drop/loss, different handshake reflectors, data with marking, and=
 different sysctl values.
> > > > >
> > > > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > > > ---
> > > >
> > > > Chia-Yu, thank you for posting the packetdrill tests.
> > > >
> > > > A couple thoughts:
> > > >
> > > > (1) These tests are using the experimental AccECN packetdrill
> > > > support that is not in mainline packetdrill yet. Can you please
> > > > share the github URL for the version of packetdrill you used? I wil=
l
> > > > work on merging the appropriate experimental AccECN packetdrill
> > > > support into the Google packetdrill mainline branch.
> > >
> > > An update on the 3 patches at:
> > >
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> > > ub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96&data=3D05%7C02%7Cchia-yu.ch=
ang
> > > %40nokia-bell-labs.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519=
6
> > > 75428d917b70f44f9630b0%7C0%7C0%7C639043779630340275%7CUnknown%7CTWFpb=
G
> > > Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF=
O
> > > IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D9cEIWqpEDSW4fyo2Ccl=
Kk1
> > > eNZ5c5C0lOADuSrE7lWFA%3D&reserved=3D0
> > >
> > > (1) I have merged the following patch into the google packetdrill rep=
o to facilitate testing of the AccECN patch series:
> > >
> > > "net-test: packetdrill: add Accurate ECN (AccECN) option support"
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> > > ub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96%2Fchanges%2Ff6861f888bc7f1e=
0
> > > 8026de4825519a95504d1047&data=3D05%7C02%7Cchia-yu.chang%40nokia-bell-=
lab
> > > s.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519675428d917b70f44f=
9
> > > 630b0%7C0%7C0%7C639043779630357016%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU=
1
> > > hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldU=
I
> > > joyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DV9Pt4nNHTV%2BcoQrb%2BMNQKOW%2FJARzk3=
DfY
> > > LvhuVZ3ii4%3D&reserved=3D0
> > >
> > > (2) The following patch I did not yet merge, because it proposes to a=
dd an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte paddi=
ng hole at the end of tcp_info:
> > >
> > >   net-test: packetdrill: Support AccECN counters through tcpi
> > >
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> > > ub.com%2Fgoogle%2Fpacketdrill%2Fpull%2F96%2Fchanges%2Ff43649c87a2aa79=
a
> > > 33a78111d3d7e5f027d13a7f&data=3D05%7C02%7Cchia-yu.chang%40nokia-bell-=
lab
> > > s.com%7C227b6e8cfe084ca9279708de56ee858b%7C5d4717519675428d917b70f44f=
9
> > > 630b0%7C0%7C0%7C639043779630374376%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU=
1
> > > hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldU=
I
> > > joyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dvy8TGIgoQum%2FFSN%2FnuaGT3rcZsTVjKHV=
x5G
> > > dIDWTR7A%3D&reserved=3D0
> > >
> > > I think we'll need to tweak the AccECN kernel patch series so that it=
 does not leave a 4-byte padding hole at the end of tcp_info, then update t=
his packetdrill patch to match the kernel patch.
> > >
> > > Let's come up with another useful u32 field we can add to the tcp_inf=
o struct, so that the kernel patch doesn't add a padding hole at the end of=
 tcp_info.
> > >
> > > One idea would be to add another field to represent newer options and=
 connection features that are enabled. AFAICT all 8 bits of the tcpi_option=
s field have been used, so we can't use more bits in that field. I'd sugges=
t we add a u32 tcpi_more_options field before the tcpi_received_ce field, s=
o we can encode other useful info, like:
> > >
> > > + 1 bit to indicate whether AccECN was negotiated (this can go in a
> > > separate patch)
> > >
> > > + 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
> > > use TCP_NODELAY is a classic cause of performance problems; again thi=
s
> > > can go in a separate patch)
> > >
> > > (And there will be future bits of info we want to add...)
> > >
> > > Also, regarding the comment in this line:
> > >   __u32   tcpi_received_ce;    /* # of CE marks received */
> > >
> > > That comment is ambiguous, since it doesn't indicate whether it's cou=
nting (potentially LRO/GRO) skbs or TCP segments. I would suggest clarifyin=
g that this is counting segments:
> > >
> > > __u32   tcpi_received_ce;    /* # of CE marked segments received */
> Hi Neal,
>
> I've done doing the patch on both net-next and packetdrill, and all AccEC=
N cases can still pass.
>
> Would it be possible for me to send patches via email rather than creatin=
g PR (due to our internal rules)?

Yes, that's fine if you want to email the packetdrill patches to the
packetdrill@googlegroups.com mailing list.

thanks,
neal

