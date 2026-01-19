Return-Path: <linux-kselftest+bounces-49315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564ADD39B8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 01:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DED300CBBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733091BF33;
	Mon, 19 Jan 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EU+0WTge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE012581
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768781159; cv=pass; b=j3YLVKcbjp9Y2dAUQyC4pa/K7hvLZhXSGFjFlMVQ0L0OjtLQVPxcua3yEJiGu9BuCUDNBxcecCuhWq9sFNbN+rCUZgc8BESJE0fOKGUHp0gctTbrcesJoAHDuJ7BicO28Yu+LD79tT64Io4BhhZAkHKn1+oR7UevSF3SshSkmkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768781159; c=relaxed/simple;
	bh=VMV+WimP73eDUWfjl0u6jcYuIsXAyXwTXlyAbjDgKrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrUo0RS4TAkaSqZg/UFjMIRJ+v2i/Pei77JrQAIUBP1nQLQTDrlOhycq/30dINsVvnXAn1t6w+VD0N9pDCifjlZJ3LPV5zI6kjgUTSPaw+SrLGzT4x2NQJ9l4YjcAvYTXcZHHgYFXfGSj5/xpkzZ097/mq9uUwjeoDefLAIgf7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EU+0WTge; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014acad6f2so632501cf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 16:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768781155; cv=none;
        d=google.com; s=arc-20240605;
        b=Xhsx6kPcRGjGLarasd9yVSq9mNs0okqsZ/9juwqDvZ/0uVSRH3jEr7GI2j1ygtjn2z
         6tk/UJSphnBHfyq7e1WzQE72rGLE5j/NuiacwpT81d8+HnX3px3uaYfGKC1AjQZ8sT4N
         kClc7Z1Sz71BDoxyK1n4CLEAhL8NT6eYn8fpTfkvi2ETUuipb9LWPc7hZ0krN0wBM6ft
         25iW8O1nVk1Jn94yqcNcSeAV8BQZ3z7qdyf4TP19I9giTlOr2F/Z5AIgqgNtSqhtrsVi
         sPWIks2V1TxakY/uyY/yMHPaHL7Za3SO+RCcF8ZrKxdIeomcn43KoUuLEQq2RjuZIZvn
         uJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgQF4r6yjLtHRY7UFU+ayksiXBrWDCrSHjT1kt5/rSM=;
        fh=sC6K3sH76NnYofUsxRKJVbEV1uxjUUb8KOUKFUJhJzs=;
        b=JFPH3fUZVCmaydXlqS9v8jt0r81glpW4zvOXFgbIXqOkH4CDenzVGpZVoSSAAei5bm
         B87dJ/CbwGY5p46HymoEWGFK430ZC2rMnUBCe/pxIy9x7g43lpE2qyDtsqXxPXFcYI2y
         OMBEUPSatz54y4P7+gqqcop5zIxB319vbPxo1Or9/pEA/zZiJAQJUrVTud3DOZZ8OuVl
         ANwDgISowIyLwlbH9O6OUDwnprDwj0ajP+YUmPtrVq1QRpZTgsVikw9UneGeMv8W8AOA
         xIzpl16uns/ld/B0GqUAXdBLcPiIxkE8tcaa9PpHWR9PahcUkwxMeydux1ZASJslhR+C
         EDaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768781155; x=1769385955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgQF4r6yjLtHRY7UFU+ayksiXBrWDCrSHjT1kt5/rSM=;
        b=EU+0WTgeCVYhOCcaQFrqIONqCGorjMHb2lXsKNT4KT1GyzKcWtetOepQf6Ib8vpSG/
         EyyQ02jBgpcBPq6uG3wFH6e2KEp6se6aRIHtZk70AXuAdYFV2JMe2fMlLIbIcfQ2PabM
         QAv3rcyTjiHf9gPZ2xmWwTQWYny3dmt0U++2bMg1NsycCbXwx+viEwV2DMaog+WJHnSt
         TphtUEjmz2dVfjnOMqBZ/RvH2KhLbm32y28yonc3t5oEaEhsM3C+lFUND5qxLqdnhA+h
         pLL8zCXiUQmUN98vHHmHCVE8rVG7mKgtVdzsoR++jayBGZHu7bQhbiJ9Xz/GOKyPmlGX
         S9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768781155; x=1769385955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgQF4r6yjLtHRY7UFU+ayksiXBrWDCrSHjT1kt5/rSM=;
        b=kpzJpKIXIysOABdgSUae8o9JZlwpl8ZsG6EZ81lgKx1EQC7sfzzSMTHFiHK/5LChY0
         d26AWRSw5eEdiDSRoHdw9FTNCB6lwH66LgWzAyjf1CYFHvJrofbEDcjohD1ke+sxAvxK
         uXKRKc7aR5IeipiyyvrI9l3keyJFDApXU8EZCGHRv/pz9+AGwW7LmL47dRg0Essr4vmD
         cjEFKArDVLRtd0/A9u5MhgkVYWX7Goj2TXZD3fmobs6Nc8BsqTg8XoOY1PRV0wwSgN4O
         nVaw9AtgZmHclpFTeyTa8bJyyS7+lhHlKq28uX6zhvCbRLE+5JqLRYiP08VDDZIAIf5G
         9BeA==
X-Forwarded-Encrypted: i=1; AJvYcCVThdPUMp2EIyGaEh5/UTg2BupOT85v261EgWHfNd2/q6LWKHYpVa7CVOXZ2L1xRyzcl9/ESwSuqciucCuTcYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JslaTSpQQKVTC6TQGFvw7h6BD9TnLQ8iirReuhF3+WNZNpBR
	FUoMsPsv0RF9MB5t3KF63GJ/tYjFq+l5byCVs/EJso32UyABoILvqrlVGYJNHp5Ah0z62UWfv42
	3/1Hpxrnsto+bTLPxiJqNnF24/i5pYifulGK9TFix
X-Gm-Gg: AY/fxX5OzACE+q1rvSTyu63bIJzdgX9yaLSC811zPc65dshbq0AbXY5ouD0rCCg21Ma
	aQfXUqEZVN1JoGpN7ZM/cGeZ+bw+1hSngti8W4t9jR9eJAgagbv/3S5tKyZ2CRT3DMmxlp9RUph
	+5K0R1ZJsUV93fn9Z0QidmxrHkL1NFO+/gpNGUx8IYvqiAZVu3R6+yGTij9VNh7fN0j2v0og7vh
	/QCL3TOFW463+ShtsFX//jLOeYGq1s8QQtHC7ZcajWBM7XjPX1Ia4RxHqQ0+ZifEPhyJh3qwphh
	Ximu+xeyfOjFEL18kadjR/6tJAG2sj7B4nBC1Q5JbNw7MF7aXvOjjNPMB74X
X-Received: by 2002:ac8:5e0f:0:b0:4f3:b0f3:62bb with SMTP id
 d75a77b69052e-502b0700cf3mr13377511cf.13.1768781154906; Sun, 18 Jan 2026
 16:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <CADVnQynBnqkND3nTS==f6MGy_9yUPBFb3RgBPnEuJ446Hkb-7g@mail.gmail.com> <PAXPR07MB79840B8A0D8FDC3778D79539A38BA@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB79840B8A0D8FDC3778D79539A38BA@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 18 Jan 2026 19:05:37 -0500
X-Gm-Features: AZwV_QhpQAR-sDEtcWbPkwX7Cos4uMIpVOtY8K0FuKS0H__o6hznU_pPXh9_GzE
Message-ID: <CADVnQyn7dqO8m4UjjQvujH4z8HFYOm0_mb5xNpNhgTdpG8L_PA@mail.gmail.com>
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

On Sun, Jan 18, 2026 at 5:56=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
>
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com>
> > Sent: Sunday, January 18, 2026 5:11 PM
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
> > On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> > >
> > > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > > >
> > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > >
> > > > Linux Accurate ECN test sets using ACE counters and AccECN options
> > > > to cover several scenarios: Connection teardown, different ACK
> > > > conditions, counter wrapping, SACK space grabbing, fallback schemes=
,
> > > > negotiation retransmission/reorder/loss, AccECN option drop/loss,
> > > > different handshake reflectors, data with marking, and different sy=
sctl values.
> > > >
> > > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > > ---
> > >
> > > Chia-Yu, thank you for posting the packetdrill tests.
> > >
> > > A couple thoughts:
> > >
> > > (1) These tests are using the experimental AccECN packetdrill support
> > > that is not in mainline packetdrill yet. Can you please share the
> > > github URL for the version of packetdrill you used? I will work on
> > > merging the appropriate experimental AccECN packetdrill support into
> > > the Google packetdrill mainline branch.
> >
> > An update on the 3 patches at:
> >
> > https://github.com/google/packetdrill/pull/96
> >
> > (1) I have merged the following patch into the google packetdrill repo =
to facilitate testing of the AccECN patch series:
> >
> > "net-test: packetdrill: add Accurate ECN (AccECN) option support"
> > https://github.com/google/packetdrill/pull/96/changes/f6861f888bc7f1e08=
026de4825519a95504d1047
> >
> > (2) The following patch I did not yet merge, because it proposes to add=
 an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte padding=
 hole at the end of tcp_info:
> >
> >   net-test: packetdrill: Support AccECN counters through tcpi
> >   https://github.com/google/packetdrill/pull/96/changes/f43649c87a2aa79=
a33a78111d3d7e5f027d13a7f
> >
> > I think we'll need to tweak the AccECN kernel patch series so that it d=
oes not leave a 4-byte padding hole at the end of tcp_info, then update thi=
s packetdrill patch to match the kernel patch.
> >
> > Let's come up with another useful u32 field we can add to the tcp_info =
struct, so that the kernel patch doesn't add a padding hole at the end of t=
cp_info.
> >
> > One idea would be to add another field to represent newer options and c=
onnection features that are enabled. AFAICT all 8 bits of the tcpi_options =
field have been used, so we can't use more bits in that field. I'd suggest =
we add a u32 tcpi_more_options field before the tcpi_received_ce field, so =
we can encode other useful info, like:
> >
> > + 1 bit to indicate whether AccECN was negotiated (this can go in a
> > separate patch)
> >
> > + 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
> > use TCP_NODELAY is a classic cause of performance problems; again this =
can go in a separate patch)
> >
> > (And there will be future bits of info we want to add...)
> >
> > Also, regarding the comment in this line:
> >   __u32   tcpi_received_ce;    /* # of CE marks received */
> >
> > That comment is ambiguous, since it doesn't indicate whether it's count=
ing (potentially LRO/GRO) skbs or TCP segments. I would suggest clarifying =
that this is counting segments:
> >
> > __u32   tcpi_received_ce;    /* # of CE marked segments received */
> >
>
> Hi Neal,
>
> Related to these 32-bit hole, two extra entries are added into b40671b5ee=
588c8a61b2d0eacbad32ffc57e9a8f of net-next, and one straightforward way is =
to apply these changes also in tcp.h of packetdrill (This is my miss).
>
> +       __u16   tcpi_accecn_fail_mode;
> +       __u16   tcpi_accecn_opt_seen;
>
> But I would prefer to update this, because tcpi_accecn_fail_mode and tcpi=
_accecn_opt_seen overall just needs 8 bits (i.e., 4 bits for tcpi_accecn_fa=
il_mode and 2 bits for tcpi_accecn_opt_seen).
>
> So, maybe we could add u16 tcpi_more_options before tcpi_received_ce and =
change tcpi_accecn_fail_mode and tcpi_accecn_opt_seen both into u8.
> Within tcpi_more_options, add one bit related to TCP_NODELAY as you said.
> And within tcpi_accecn_opt_seen, add one bit related to whether AccECN wa=
s negotiated as you said, then we can leave more unused bits in tcpi_more_o=
ptions.
>
> Another thought is to use a single u32 before tcpi_received_ce, in which =
4 bits for tcpi_accecn_fail_mode, 2 bits for tcpi_accecn_opt_seen, 26 bits =
for tcpi_more_options.
>
> What do you think?

I would suggest something like your last suggestion, where there is a
u32 before tcpi_received_ce, with bit fields for tcpi_accecn_fail_mode
(4 bits) and tcpi_accecn_opt_seen (2 bits), and a tcpi_options2 for
the remaining unused bits in the u32.

I am leaning toward tcpi_options2 rather than tcpi_more_options,
because I guess in the future we might want yet another options bit
field, in which case it would be better to have {tcpi_options,
tcpi_options2, and tcpi_options3}, rather than having {tcpi_options,
tcpi_more_options, and tcpi_yet_more_options}. :-)

And rather than a single bit indicating whether AccECN was negotiated,
it occurs to me that it would probably be better to have a 2-bit enum
with 4 values, corresponding to the modes in tcp_ecn.h:
tcp_ecn_disabled(), tcp_ecn_mode_rfc3168(), tcp_ecn_mode_accecn(), and
tcp_ecn_mode_pending().

We also need to keep in mind that since the tcpi_accecn_fail_mode (4
bits) and tcpi_accecn_opt_seen (2 bits) enums are exported to
user-space, they will become part of the kernel API to userspace, so
should be moved out of tcp_ecn.h and instead be declared in
include/uapi/linux/tcp.h. We declare constant values exported to user
space in that file: (a) to make it easier for maintainers to remember
not to change the values for these, so kernel changes don't break
user-space apps; (b) to make it easier for application developers to
find the #define values they need to decode the values exported in
struct  tcp_info. :-)

So how about something like:

--- in include/uapi/linux/tcp.h:

/* Values for tcpi_ecn_mode */
#define TCPI_ECN_DISABLED 0x0
#define TCPI_ECN_RFC3168 0x1
#define  TCPI_ECN_ACCECN 0x2
#define TCPI_ECN_PENDING 0x3

/* Values for tcpi_accecn_opt_seen */
#define TCP_ACCECN_OPT_NOT_SEEN         0x0
#define TCP_ACCECN_OPT_EMPTY_SEEN       0x1
#define TCP_ACCECN_OPT_COUNTER_SEEN     0x2
#define TCP_ACCECN_OPT_FAIL_SEEN        0x3

/* Values for tcpi_accecn_fail_mode */
#define TCP_ACCECN_ACE_FAIL_SEND        BIT(0)
#define TCP_ACCECN_ACE_FAIL_RECV        BIT(1)
#define TCP_ACCECN_OPT_FAIL_SEND        BIT(2)
#define TCP_ACCECN_OPT_FAIL_RECV        BIT(3)

...
__u32 tcpi_ecn_mode:2,
    tcpi_accecn_opt_seen: 2,
    tcpi_accecn_fail_mode: 4,
    tcpi_options2:24;
__u32   tcpi_received_ce;    /* # of CE marked segments received */
...

--- in tcp_get_info() in net/ipv4/tcp.c:

if (tcp_ecn_disabled(tp))
  info-> tcpi_ecn_mode =3D TCPI_ECN_DISABLED;
else if (tcp_ecn_mode_rfc3168(tp))
  info-> tcpi_ecn_mode =3D TCPI_ECN_RFC3168;
else if (tcp_ecn_mode_accecn(tp))
  info-> tcpi_ecn_mode =3D TCPI_ECN_ACCECN;
else if (tcp_ecn_mode_pending(tp))
  info-> tcpi_ecn_mode =3D TCPI_ECN_PENDING;

WDYT?

> And I will update the comment of tcpi_received_ce, thanks for the comment=
s.

Great. Thanks!

neal

> Chia-Yu
>
> > (3) The following patch I did not merge, because I'd like to migrate to=
 having all packetdrill tests for the Linux kernel reside in one place, in =
the Linux kernel source tree (not the Google packetdrill
> > repo):
> >
> >   net-test: add TCP Accurate ECN cases
> >   https://github.com/google/packetdrill/pull/96/changes/fe4c7293ea640a4=
c81178b6c88744d7a5d209fd6
> >
> > Thanks!
> > neal
> Chia-Yu
>
> -----Original Message-----
> From: Neal Cardwell <ncardwell@google.com>
> Sent: Sunday, January 18, 2026 5:11 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@v=
ger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniy=
u@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.=
com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.w=
angcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lun=
n.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah=
@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; Koen De Schepp=
er (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; i=
ngemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire <c=
heshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel=
 <vidhi_goel@apple.com>; Willem de Bruijn <willemb@google.com>
> Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdr=
ill cases
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options
> > > to cover several scenarios: Connection teardown, different ACK
> > > conditions, counter wrapping, SACK space grabbing, fallback schemes,
> > > negotiation retransmission/reorder/loss, AccECN option drop/loss,
> > > different handshake reflectors, data with marking, and different sysc=
tl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---
> >
> > Chia-Yu, thank you for posting the packetdrill tests.
> >
> > A couple thoughts:
> >
> > (1) These tests are using the experimental AccECN packetdrill support
> > that is not in mainline packetdrill yet. Can you please share the
> > github URL for the version of packetdrill you used? I will work on
> > merging the appropriate experimental AccECN packetdrill support into
> > the Google packetdrill mainline branch.
>
> An update on the 3 patches at:
>
> https://github.com/google/packetdrill/pull/96
>
> (1) I have merged the following patch into the google packetdrill repo to=
 facilitate testing of the AccECN patch series:
>
> "net-test: packetdrill: add Accurate ECN (AccECN) option support"
> https://github.com/google/packetdrill/pull/96/changes/f6861f888bc7f1e0802=
6de4825519a95504d1047
>
> (2) The following patch I did not yet merge, because it proposes to add a=
n odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte padding h=
ole at the end of tcp_info:
>
>   net-test: packetdrill: Support AccECN counters through tcpi
>   https://github.com/google/packetdrill/pull/96/changes/f43649c87a2aa79a3=
3a78111d3d7e5f027d13a7f
>
> I think we'll need to tweak the AccECN kernel patch series so that it doe=
s not leave a 4-byte padding hole at the end of tcp_info, then update this =
packetdrill patch to match the kernel patch.
>
> Let's come up with another useful u32 field we can add to the tcp_info st=
ruct, so that the kernel patch doesn't add a padding hole at the end of tcp=
_info.
>
> One idea would be to add another field to represent newer options and con=
nection features that are enabled. AFAICT all 8 bits of the tcpi_options fi=
eld have been used, so we can't use more bits in that field. I'd suggest we=
 add a u32 tcpi_more_options field before the tcpi_received_ce field, so we=
 can encode other useful info, like:
>
> + 1 bit to indicate whether AccECN was negotiated (this can go in a
> separate patch)
>
> + 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
> use TCP_NODELAY is a classic cause of performance problems; again this ca=
n go in a separate patch)
>
> (And there will be future bits of info we want to add...)
>
> Also, regarding the comment in this line:
>   __u32   tcpi_received_ce;    /* # of CE marks received */
>
> That comment is ambiguous, since it doesn't indicate whether it's countin=
g (potentially LRO/GRO) skbs or TCP segments. I would suggest clarifying th=
at this is counting segments:
>
> __u32   tcpi_received_ce;    /* # of CE marked segments received */
>
> (3) The following patch I did not merge, because I'd like to migrate to h=
aving all packetdrill tests for the Linux kernel reside in one place, in th=
e Linux kernel source tree (not the Google packetdrill
> repo):
>
>   net-test: add TCP Accurate ECN cases
>   https://github.com/google/packetdrill/pull/96/changes/fe4c7293ea640a4c8=
1178b6c88744d7a5d209fd6
>
> Thanks!
> neal

