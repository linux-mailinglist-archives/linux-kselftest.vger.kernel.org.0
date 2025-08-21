Return-Path: <linux-kselftest+bounces-39536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E7B30122
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104C97BA69C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D4337692;
	Thu, 21 Aug 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocYGHGSr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCE2E0404;
	Thu, 21 Aug 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797585; cv=none; b=K1qCOGy10t5kL+1T/WvU2WVVnZt4kLjOTG4yoPBmvvmhy9T1njvS9t2A/o2k3PqLk5+3zYCFXug8mEmYNrfGBPh2DxC0HMnQXL0q1oGoDp1ShXwixbQyWpCSaTpLNAwDdZsxagGIaFr6gJ41WrPHq1l8sYXa0YxkCDFqhob7gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797585; c=relaxed/simple;
	bh=Q9rh8Lkqpu5Ldx6YYZa4TBRMwiKb+sHCQo3ITuYkI8k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pp+g2OVRMugLIo4uLkq0NA5IsGk+XyJ3jbGn7C4MJzV5CGmV7mzSUkylYt8J0ruKeCykMNZ57eS6kG7q1JNgQPm/yutvi/CV474qHaHUCAIezYOMWiwul+S0XHumTv9uX444hwD1C7l2nO1za4FocPqgDJzb0HpuSudxavpEdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocYGHGSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A75C4CEEB;
	Thu, 21 Aug 2025 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797584;
	bh=Q9rh8Lkqpu5Ldx6YYZa4TBRMwiKb+sHCQo3ITuYkI8k=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=ocYGHGSrIjyruo1m6k+xsPQPitnjESHHx1y+Yucjy2Md5b2HyUOw/UzE15RgRm9Ot
	 v6Q7C8CSdq3Kq07xHCZ2qxToiNn3nIlRUiCFGANW0RDiLs2Kdz8JBEG5npbKKe2/L5
	 /U95IpDZplwL4q6OtK0236ji7ilO+uj0K398nxywZbC2i9tMfN9dPTqhRIoQcVQb6z
	 7EY/F7SwJfhXhNWC5FKvVdnuaivpWPLY4s1FW8G7vlgXVBLvIcuGrTojhu+WMN+MTA
	 8gyH2QKsgfK+myahwdgJF8Aq1nnfdRp/mwhZlsS5UgqliUhYKFqrtHa2fja/TzMU9D
	 HIPTJWjcuRQsg==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Thu, 21 Aug 2025 20:32:59 +0300 (EEST)
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
cc: Eric Dumazet <edumazet@google.com>, 
    "pabeni@redhat.com" <pabeni@redhat.com>, 
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
    "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
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
    "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
    "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
    "ast@fiberby.net" <ast@fiberby.net>, 
    "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
    "shuah@kernel.org" <shuah@kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
    "ncardwell@google.com" <ncardwell@google.com>, 
    "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
    "g.white@cablelabs.com" <g.white@cablelabs.com>, 
    "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
    "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
    "cheshire@apple.com" <cheshire@apple.com>, 
    "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
    "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
    "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
In-Reply-To:  <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Message-ID: <f11c16d9-5b29-b0d8-c9bc-d6bdb49f00d1@kernel.org>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com> <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com> 
 <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-579655347-1755797579=:1081"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-579655347-1755797579=:1081
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Chia-Yu Chang (Nokia) wrote:

> > -----Original Message-----
> > From: Eric Dumazet <edumazet@google.com>=20
> > Sent: Thursday, August 21, 2025 2:30 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms=
@kernel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; ne=
tdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.or=
g; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; =
davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fi=
berby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.ker=
nel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koe=
n.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johans=
son@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.iet=
f@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> > Subject: Re: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> [...]
> > >  /* Used for make_synack to form the ACE flags */ diff --git=20
> > > a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h index=20
> > > bdac8c42fa82..53e0e85b52be 100644
> > > --- a/include/uapi/linux/tcp.h
> > > +++ b/include/uapi/linux/tcp.h
> > > @@ -316,6 +316,13 @@ struct tcp_info {
> > >                                          * in milliseconds, including=
 any
> > >                                          * unfinished recovery.
> > >                                          */
> > > +       __u32   tcpi_received_ce;    /* # of CE marks received */
> > > +       __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counte=
rs */
> > > +       __u32   tcpi_delivered_e0_bytes;
> > > +       __u32   tcpi_delivered_ce_bytes;
> > > +       __u32   tcpi_received_e1_bytes;
> > > +       __u32   tcpi_received_e0_bytes;
> > > +       __u32   tcpi_received_ce_bytes;
> > >  };
> > >
> >=20
> > We do not add more fields to tcp_info, unless added fields are a multip=
le of 64 bits.
> >=20
> > Otherwise a hole is added and can not be recovered.
>=20
> Hi Eric,
>=20
> Thanks for the feedback.
>=20
> Then, would it make sense to add __u32 reserved; here or this is not an=
=20
> option?

Wouldn't it also make sense to change the byte counters to __u64?

(It won't help the alignment though if the CE counter is left __u32.)

--=20
 i.

--8323328-579655347-1755797579=:1081--

