Return-Path: <linux-kselftest+bounces-44871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE5C38F5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 04:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDE63B697C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874F2BE65E;
	Thu,  6 Nov 2025 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CMFffhgH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE42BE634
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399597; cv=none; b=JBZNB3deIVqOoXwQpFuetxzHGF6IKq9seJedPCMKJg3npL7uM9fM/W4CYf7pwDikpSb1Va196IiKBbFfN/Sth/+ucfEpbiVKAl0ZJYxHclDYYPycSo5y0mNEP8ZQ0rafmAywspNmFHpj3Ycr77bjvSMriePkKTBBL22NwGqEL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399597; c=relaxed/simple;
	bh=fTj20aGtZ+6F5GDEijyEoHOupVnVzZxg6fD8bO30o+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9MT1l2FFeCeMHyehY+DlrlYpSPFLZX64n1ZzkCv7fzF7PNwybBgDsYLTi5tg8qtALCsjKg0aXw9UzpRPHXDSZCrrrcureQSXuADrdgLXXaDbRV/ilDaxbG2hUZPV0hY1I1SCOtI5tAOxlJu57vI7qn+MdzViv7jELoIHgbwpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CMFffhgH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594270ec7f9so404201e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 19:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762399594; x=1763004394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xpFecSad0Q8rQWlUdeL6GhfjlE0oFfhv5tERAh3/A0=;
        b=CMFffhgHCBEiaS3ZcYQr+tD+ArxAefxkmIF9QCJnwC27bPtI56nI6Rj1UGLHB5n+IZ
         6kIGSdE7h3pwmU2Xgudp7+VX/b2DiIn9Bulkm5ulqjpPuCSLNoonRzWA+ko/jzabhVqq
         LPkvTrhyMFib+wogpkNSPqfNs3HYdwGnSocw2jdo9AP9A8/jcZpf57JG54LNcyNiovHz
         KEuPGWNo9i0revstAH/CwNDFYwPs5jjZyd+Y+bPdQ68a1ahfDCjQKW/cqnwrwRb0bu0C
         3CP0IUmc/4GgcrwzXDyxUTgpqudyn0/pKA+ctYgIa1x18HH+zgQj64TguEwmtv77MFG6
         oPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399594; x=1763004394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xpFecSad0Q8rQWlUdeL6GhfjlE0oFfhv5tERAh3/A0=;
        b=XLNQ2wtGql+Rmz7h2lifRzJUpzkJUeYtQ6O//ZClJ4tXzNdnGiq+JxDhMAa1RC9OYF
         eNCrWM7ERh+YgWHejG76iRS62WIwtqPk/SaGxQUMe1zyVn7QwzcV4MNSmh3TCKKrKcFV
         GsTx57QpXBX4UwIhT7groQa+FbS1UTiNXiyS9b6qpXjELQPWgJ3KMv3QyD1SMxrmb2ki
         R7sUBqRvhfngbnC96ox95sg0a+bWdgIFaEHhLiOc1GCNN5hLKo45ItQ36m+iNTQI9MLf
         cQMGdgQKYUsnh1oaiAJDgYU/PtHn/0fmTT62fCk5NqPFnWMSP+29i1/uSSdhgq3cI4se
         YW8g==
X-Forwarded-Encrypted: i=1; AJvYcCU1v1h1RChIdUc85CwbsYqxgy1bQ55l8lUMlNXflNtmC3Eo3JoEKq6n/wgdn0P60WAyT5JCq8nhGodHPESbBm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ezQR2jvebeyF1RbQBTbX73jmvQixmJ66zNP3EtiUjoLD5275
	rtWQoMGci1h7YswkuHbRoJaLoiXFw3+r64T78PgZJEK13U2PeJ1YsRTmrB3jHqGzHwPLMZTpNRw
	Z/+eSfaoqKx6muBdRo/fbr3U6XFWoPzTecXJ9SGHR3g==
X-Gm-Gg: ASbGncsObf530OIsS6wvYTehPQyQdY7tRqveNf3HVs3yShiuhrZQHhjGP1guWENKUrc
	J49pJZbvzsT5eclT993zJpX5RAwmTdaH6sG0fYlj7K+gh2DLpi0nKgsjGCRZgJuFKg8ILHBFL5y
	NiSFrrGwrT+R5RX6NsP63xsJVI5FKVAORS5emkjMVUlTDXieOoTqTGZL47USTGlIAFzmz3Lmz+6
	CQHuC33GY3WRkhPBapPEUE6mMIZsPv1s+5PxvEhKD6RSqo65Gyp3P6U0y1o7tvT4I1Wx6R3CzKB
	eJV2tQg9wxuZERYfyfY=
X-Google-Smtp-Source: AGHT+IGYMoT2xV8jUqZNsDpRBewBTbv4+kgQPDV4kSS9LjY++Ln8kzXqYWY2rpk78RI7qVA9AFP5RMpBDQ0EOStji+4=
X-Received: by 2002:a05:6512:39d3:b0:594:29c8:9ae5 with SMTP id
 2adb3069b0e04-5943d8043damr2098109e87.53.1762399593422; Wed, 05 Nov 2025
 19:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
 <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com> <CAADnVQL91xsujXt4GWjgCYC+PdBC-2ZH6GqefXws_YHiL7B7Sg@mail.gmail.com>
In-Reply-To: <CAADnVQL91xsujXt4GWjgCYC+PdBC-2ZH6GqefXws_YHiL7B7Sg@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Thu, 6 Nov 2025 12:26:08 +0900
X-Gm-Features: AWmQ_bmR0XThGmCNnGWDRtAQwF2L1nWrxoFXbdmlSZGFMImtnXeNaIqn1ePhIVQ
Message-ID: <CAK7-dKa=2RkU2uyPBjagkdMtMbZJ1aN+=b9U1tFzmdcJAbBWmw@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:43=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 3:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@su=
se.com> wrote:
> > > > > >
> > > > > > The netif_receive_skb BPF program used in snprintf_btf test sti=
ll uses
> > > > > > a custom __strncmp. This is unnecessary as the bpf_strncmp help=
er is
> > > > > > available and provides the same functionality.
> > > > > >
> > > > > > This commit refactors the test to use the bpf_strncmp helper, r=
emoving
> > > > > > the redundant custom implementation.
> > > > > >
> > > > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > > > ---
> > > > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +------=
--------
> > > > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_sk=
b.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > > @@ -31,19 +31,6 @@ struct {
> > > > > >         __type(value, char[STRSIZE]);
> > > > > >  } strdata SEC(".maps");
> > > > > >
> > > > > > -static int __strncmp(const void *m1, const void *m2, size_t le=
n)
> > > > > > -{
> > > > > > -       const unsigned char *s1 =3D m1;
> > > > > > -       const unsigned char *s2 =3D m2;
> > > > > > -       int i, delta =3D 0;
> > > > > > -
> > > > > > -       for (i =3D 0; i < len; i++) {
> > > > > > -               delta =3D s1[i] - s2[i];
> > > > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > > > -                       break;
> > > > > > -       }
> > > > > > -       return delta;
> > > > > > -}
> > > > > >
> > > > > >  #if __has_builtin(__builtin_btf_type_id)
> > > > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)  =
                 \
> > > > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const vo=
id *m2, size_t len)
> > > > > >                                        &_ptr, sizeof(_ptr), _hf=
lags);   \
> > > > > >                 if (ret)                                       =
         \
> > > > > >                         break;                                 =
         \
> > > > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED=
_STRSIZE); \
> > > > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _e=
xpectedval); \
> > > > >
> > > > > Though it's equivalent, the point of the test is to be heavy
> > > > > for the verifier with open coded __strncmp().
> > > > >
> > > > > pw-bot: cr
> > > >
> > > > I double checked that before acking, the test was added as a part o=
f [1].
> > > > So it seems to be focused on bpf_snprintf_btf(), not on scalability=
.
> > > > And it's not that heavy in terms of instructions budget:
> > > >
> > > > File                     Program                  Verdict  Insns  S=
tates
> > > > -----------------------  -----------------------  -------  -----  -=
-----
> > > > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152   =
  629
> > >
> > > Is this before or after?
> > > What is the % decrease in insn_processed?
> > > I'd like to better understand the impact of the change.
> >
> > That's before, after the change it is as follows:
> >
> > File                     Program                  Verdict  Insns  State=
s
> > -----------------------  -----------------------  -------  -----  -----=
-
> > netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     23=
5
> > -----------------------  -----------------------  -------  -----  -----=
-
> >
> > So, the overall impact is 18K -> 4K instructions processed.
>
> It's large enough impact for the verifier.
> I agree that the test was mainly focusing on testing
> bpf_snprintf_btf(), but it has a nice side effect by testing
> bounded loops too.
> I prefer to keep it as-is.

Thanks for the clarification.

Removing the open-coded __strncmp would drop the bounded-loop
coverage that this test currently provides (as a side effect),
and that stress on the verifier is still valuable.

I'll drop this patch.
Thank you all for the discussion and review.

