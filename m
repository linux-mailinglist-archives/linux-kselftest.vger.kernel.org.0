Return-Path: <linux-kselftest+bounces-43559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFEBF2234
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14384F91AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E3326A0BD;
	Mon, 20 Oct 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqNoHb+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F320013A
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974324; cv=none; b=iTEsBIBMB9N3KtKS/dCOvuq5XPCo+0gh6sRfhbO43zim+cawLunXmRi3iNnomFHbjjlxMf30w1AqASczQPZjtw6nN+W8oU9rLakwG/Tcvp0wnkXGMTN1KVB0S3pakoLaXKdQmHmuQw4qiBJ9/Isihw35MjwEbe+nifs7F+4ViM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974324; c=relaxed/simple;
	bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSL3uOw+xsEk/kUR3csMqKgJm4VHa+I+MtCoRFP5MU4hRcQnyMa75RKEyJbd1O3fyt/2QjkF/0ZLwJhxEIwp4MuWRoJKN40LD8hZvUtiNVMcIbCm7AFdD1ESz9d29YqqIzQBCH0eiOao5gHnXt3E/Km0bRy4FzMqMtzmm8sALDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqNoHb+t; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f8f346c2cso669473485a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760974322; x=1761579122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
        b=kqNoHb+t9kqF7MM2fykkOUJMAMvWEYQSEXWxHxwHN6cZuWN44kHXULJP6rcpsle7+7
         SPuOlX+UiYQTDnJpuXWWzWzHIdh993F6cdqYx1MBkHujca2jL8MtdjIeW3cg0vZpQp/0
         m1jsXImHyF1HsTi9VPjz4E4JdGKgIWPuy8cL50mYH/rPsclRmyV1Rq3sV37eHiemgje3
         8pvC3B/qldeE2WYKsp+3Bzah5Wzd8kXQ13Suk9wJAaf5NXBf2IH5dPVJybFdD1xIsmxK
         s74jE8sh2oto0wnIULOJ4qw+oTpcwjytD07lMmmWEgy9jXrb6vReS+cDAiZnDF8nBCY/
         q0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974322; x=1761579122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
        b=bKiqvjeJNZSqEUgYZT1KqmFk+3uLgR9EUbEdunRQt24SMQCp9cGE0gNKEov8/mAlB6
         eFlR1B8eaO1QczPN1n/ribHKC4l6CoZozv66xfJNEctgOI6eKgX6XXuZiilqRSLIz+Vf
         uUX7AmvH9uggcaeeoybxUjdbMxmL6Si7/PG8pS16mN9pDV1EJ4Rk4+RXHz/88VUsKZg+
         LPLF+5E/7ETREn5epAHw6olZhX8kNRBEgxkamAfaBc9CcKT1Hpewvj5p/U3R+ufdnP8Z
         KoE3aMXOAj/x2enpU/DlQWTvRoxEAWggCCtxPwEAO76vUy2qsdY8Kkn+2hJqgqAfEMsq
         JKxA==
X-Forwarded-Encrypted: i=1; AJvYcCWgpHKZvPUfxxyh0+ZPFjqiXTl2+TmFxDkDB1yEM3ICK5XQByqzMbps1C25cFLiK8sQJjJVRS8jlp1vd0oikwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsuO1pgIdaayOFAukhWlS8vOunydUmB50vMZzHWjF+gZqY0ki
	o7Bz44zuX3Ssg58BC8sxjUG93HsTq+uT7MbEl+lhx9OBui6MECd27+3LjMyDvco56icZThWgSCh
	S3n+dvEJolZZrlIeFoAPEPYZnR9Nu/SJfBlKm6H6q
X-Gm-Gg: ASbGncsk3uzzDLOnDllrcct0QKWsv5hvjU1aX8el9+LbgcPXSg1ziW3GyDo+p/aEoKV
	3esJt/BXEbaE6H7KHAOvrCmXFYSbnUKoH/3KEUCxZHsfVaRVa2TtazNKywWu8PsVUvBTNaNw0+W
	EFuwErp74WlB1f9EZMk7KHdr9lw5GKIVDJUqb396bIAwHkix1e5uM6HuHgJMjOaLGKfu4YnEkpE
	tw/j9GROfaLPQ01PKl1q02VJ7pVneJ+GUpKpfByNrK0BkHWAAh32P42tnot9mwSHbVE/us=
X-Google-Smtp-Source: AGHT+IEdHdWyI7mOrpfFqKEne60YjRdxkTiiGct+YFp5FQLwi3H3NnPrv3GzMWIKb1yewXybnZNz6NoRsBAOxXmE8qs=
X-Received: by 2002:a05:622a:613:b0:4e8:b82e:7092 with SMTP id
 d75a77b69052e-4e8b82e7306mr79282891cf.62.1760974321166; Mon, 20 Oct 2025
 08:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
 <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com> <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
 <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Oct 2025 08:31:50 -0700
X-Gm-Features: AS18NWDUZznJqUfVcx0aI9J1KOrbstIH9YmbS1cOmBVfbpztFwRTg_RHcMvp5sE
Message-ID: <CANn89iKyQFowOpFDXbpewEiEGESdeZ_bgBViOA2NN9n8h6Vkrw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:26=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Sent: Thursday, October 16, 2025 10:27 PM
> > To: Paolo Abeni <pabeni@redhat.com>
> > Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet=
@google.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; d=
sahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kern=
el.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@net=
workplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemlof=
t.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liu=
hangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ncard=
well@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs=
.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehl=
ewind@ericsson.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Li=
vingood@comcast.com; Vidhi Goel <vidhi_goel@apple.com>
> > Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set ne=
gatively affects AccECN
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Thu, 16 Oct 2025, Paolo Abeni wrote:
> > > On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > > > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > >
> > > > As AccECN may keep CWR bit asserted due to different interpretation
> > > > of the bit, flushing with GRO because of CWR may effectively disabl=
e
> > > > GRO until AccECN counter field changes such that CWR-bit becomes 0.
> > > >
> > > > There is no harm done from not immediately forwarding the CWR'ed
> > > > segment with RFC3168 ECN.
> > >
> > > I guess this change could introduce additional latency for RFC3168
> > > notification, which sounds not good.
> > >
> > > @Eric: WDYT?
> >
> > I'm not Eric but I want to add I foresaw somebody making this argument =
and thus wanted to not hide this change into some other patch so it can be =
properly discussed and rejected if so preferred, either way it's not a corr=
ectness issue.
> >
> > I agree it's possible for some delay be added but the question is why w=
ould that matter? "CWR" tells sender did already reduce its sending rate wh=
ich is where congestion control aims to. So the reaction to congestion is a=
lready done when GRO sees CWR (some might have a misconception that deliver=
ing CWR causes sender to reduce sending rate but that's not the case). With=
 RFC 3168 ECN, CWR only tells the receiving end to stop sending ECE. Why do=
es it matter if that information arrives a bit later?
> >
> > If there are other segments, they normally don't have CWR with RFC 3168=
 ECN which normally set CWR once per RTT. A non-CWR'ed segment results in f=
lush after an inter-packet delay due to flags difference. That delay is not=
hing compared to GRO aggregating non-CWR segments en masse which is in n ti=
mes the inter-packet delay (simplification, ignores burstiness, etc.).
> >
> > If there are no other segments, the receiver won't be sending any ECEs =
either, so the extra delay does not seem that impactful.
> >
> > Some might argue that with this "special delivery" for CWR the segment =
could trigger an ACK "sooner", but GRO shouldn't hold the segment forever e=
ither (though I don't recall the details anymore). But if we make that argu=
ment (which is no longer ECN signalling related at all, BTW), why use GRO a=
t all as it add delay for other segments too delaying other ACKs, why is th=
is CWR'ed segment so special that it in particular must elicit ACK ASAP? It=
's hard to justify that distinction/CWR speciality, unless one has that mis=
conception CWR must arrive ASAP to expedite congestion reaction which is ba=
sed on misunderstanding how RFC 3168 ECN works.
> >
> > Thus, what I wrote to the changelog about the delay not being harmful s=
eems well justified.
> >
> > > On the flip side adding too much
> > > AccECN logic to GRO (i.e. to allow aggregation only for AccECN enable=
d
> > > flows) looks overkill.
> >
> > The usual aggregation works on header bits remaining identical which ju=
st happens to also suit AccECN better here. The RFC 3168 CWR trickery is wh=
at is an expection to the rule, and as explained above, it does not seem ev=
en that useful.
> >
> > This CWR special delivery rule, on the other hand, is clearly harmful f=
or aggregating AccECN segments which may have long row of CWR flagged segme=
nts if ACE field remains unchanging. None of them can be aggregated by GRO =
if this particular change is not accepted. Not an end of the world but if w=
e weight the pros and cons, it seems to clearly favor not keeping this spec=
ial delivery rule.
>
> Hi Paolo,
>
> I agree with what was mentioned by Ilpo above.
>
> But if Eric can share extra comments or some particular cases would be he=
lpful.
>
> Shall we submit all patches with changes (and keep this patch unchanged)?=
 Or please suggest other ways to move forward.

Hmm... maybe now is a good time to amend tools/testing/selftests/net/gro.c

In general, the lack of tests in your series is not really appealing to me.

