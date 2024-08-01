Return-Path: <linux-kselftest+bounces-14670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C8945191
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93584284D35
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0F21B4C59;
	Thu,  1 Aug 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivh8FIMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2313D62B;
	Thu,  1 Aug 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533803; cv=none; b=c5Z9YGTvw/QjGkXWehdxCrICMjrFEMQ13iMF9usnu9sK4LQHNrt/qWNwyiqRp90kc2HMGwfPyKTqufTBzOwc3Ak5w4w47/f5l5097mycyDRiCbaUeIZVcWD6KxDVUW89BkBI0N6R6UKe9Ioah9zTLZ0ceU+ZQqlxf9gBI7IoXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533803; c=relaxed/simple;
	bh=6ZVlREg5BXL/EoXOJ2rnaDZF/rFMF02YBydQTjZeh64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaAwpo5XnwHTZGGyhd5uJ2DA/jRbBf8LcheWiION3r8xZEL8S42w7lxcfVVKqEanCKvnZGkmor/15tE1vCNdsTPLcxuMFWhzZPEOjAWJeXq0CQKJkMEzNgBenlEmU1yyqvUElVFRzBBIyWbv/Ryj1oAojqDkkHiMHkl8rR6rbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivh8FIMZ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso6031371276.0;
        Thu, 01 Aug 2024 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722533801; x=1723138601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkeda4WMxjg+epSrNx4KCKRBP/x9ruE4N5/saWbuL1s=;
        b=ivh8FIMZYnnw1nU9q5do51Nsep5egusCjfWEtcirXNsmzEgLoRlOKfCWttBDT75+aS
         6Hi+QUmqErWgd9PJWFQbey/821bpu+/7vrzlp3hYUqW/thzlhtZIRWi581/kP3olUUE+
         KdBnEJp6bHQzO37S1wOtXiBTDgipnt69Bbd10K/hZAVdB06EGybLa/mhrxBr/wXkLOAw
         yWApjOM47p/5I9DDyQWx4Qli8JkzZqgRlT+F+3DtCs3pTFkKsUMBXIUT9JdV6/E+7M1N
         01hyz1ETQ61DKVYfP1q4p6XwS0gzIQuHQRNbEJGIIqZ6GCRW3rfieMhzkssHy2raRR+L
         kRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533801; x=1723138601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkeda4WMxjg+epSrNx4KCKRBP/x9ruE4N5/saWbuL1s=;
        b=do7sdBl4Tmyv02srwkIyWL6pkUmvJd6s/j24w5zGfAE05fCYNq9RNA2VQHi7wiNgUs
         SmwBfvhjfzRNGgjtv3kn0MhOqxQoHIosqWlWpL+s8D1z9PZ5z5afRnYPHmkjQUaT5pVR
         9byHaCIN2yj7K/64cZykmSjyNq7iVyOICvxNAlLUsHxyz1x/OmuWvPlFH5FenhsXrTQa
         QVyCtdjMuVFkK6dUIlm1yQDyRMH7qqcOmaD2E85lcgY1GaVlyu+qwvbEZy6RgIzyHAX1
         lRup1mpFHnxtewGHGdQIPudw4/gJR1sTn4wtzIyT2OsL5pKvK0fzPQshAlch3ymjt4m9
         wiEA==
X-Forwarded-Encrypted: i=1; AJvYcCXaOYiShESc5PvAAG1bbHq01Zt6AeslkUzaP4Xgmynwl0eBaM9YwfvSqNO/o3Jdk/YGpplYbvVhVgbS4cilkwr4eVM3L2R8Bz8CD+9wFo26KGP5aMUvOwmhxIGMlyKoMJWKsp33YWutdfXH
X-Gm-Message-State: AOJu0YxuhKolqjqSa0KqLOy1H2cqqfAr+tlbWqH6M2BOUvOG8qKGMPn6
	GEISH+FFIJ+J6hK/RyeVRIMnNnXAACyod5pTpfzKF/0L3f/dl07KvmTlNfshMv4+misZvWeFrm7
	mRJrD2Sv7m2uikZ6o5nlC/l4n4UdFPA==
X-Google-Smtp-Source: AGHT+IHAh1FTSSaRqGtcyuTtpXm8BVpnndG1OumyMGSiG1akAcrZ3HkFTv+BKGqDW1xJodRgK1UyO6DjTHZ4lfmTmk8=
X-Received: by 2002:a05:6902:2605:b0:e0b:c94f:3040 with SMTP id
 3f1490d57ef6-e0bde2f1ac9mr1104573276.27.1722533800595; Thu, 01 Aug 2024
 10:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-4-zijianzhang@bytedance.com> <66aabb616714_21c08c29432@willemb.c.googlers.com.notmuch>
 <570fe8a0-4b93-4f3d-a4d7-34a3a61167e4@bytedance.com>
In-Reply-To: <570fe8a0-4b93-4f3d-a4d7-34a3a61167e4@bytedance.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 1 Aug 2024 13:36:04 -0400
Message-ID: <CAF=yD-Jt6XWSCLfZE1C+9=vcXyG-XcC2q-7Ai-HHSUt=1OrWsg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, almasrymina@google.com, 
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, axboe@kernel.dk, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:30=E2=80=AFPM Zijian Zhang <zijianzhang@bytedance.=
com> wrote:
>
> On 7/31/24 3:32 PM, Willem de Bruijn wrote:
> > zijianzhang@ wrote:
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> We update selftests/net/msg_zerocopy.c to accommodate the new mechanis=
m,
>
> First of all, thanks for the detailed suggestions!
>
> >
> > Please make commit messages stand on their own. If someone does a git
> > blame, make the message self explanatory. Replace "the new mechanism"
> > with sendmsg SCM_ZC_NOTIFICATION.
> >
> > In patch 2 or as a separate patch 4, also add a new short section on
> > this API in Documentation/networking/msg_zerocopy.rst. Probably with
> > the same contents as a good explanation of the feature in the commit
> > message of patch 2.
> >
>
> Agreed.
>
> >> cfg_notification_limit has the same semantics for both methods. Test
> >> results are as follows, we update skb_orphan_frags_rx to the same as
> >> skb_orphan_frags to support zerocopy in the localhost test.
> >>
> >> cfg_notification_limit =3D 1, both method get notifications after 1 ca=
lling
> >> of sendmsg. In this case, the new method has around 17% cpu savings in=
 TCP
> >> and 23% cpu savings in UDP.
> >> +---------------------+---------+---------+---------+---------+
> >> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> >> +---------------------+---------+---------+---------+---------+
> >> | ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
> >> +---------------------+---------+---------+---------+---------+
> >> | New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
> >> +---------------------+---------+---------+---------+---------+
> >> | New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
> >> +---------------------+---------+---------+---------+---------+
> >>
> >> cfg_notification_limit =3D 32, both get notifications after 32 calling=
 of
> >> sendmsg, which means more chances to coalesce notifications, and less
> >> overhead of poll + recvmsg for the original method. In this case, the =
new
> >> method has around 7% cpu savings in TCP and slightly better cpu usage =
in
> >> UDP. In the env of selftest, notifications of TCP are more likely to b=
e
> >> out of order than UDP, it's easier to coalesce more notifications in U=
DP.
> >> The original method can get one notification with range of 32 in a rec=
vmsg
> >> most of the time. In TCP, most notifications' range is around 2, so th=
e
> >> original method needs around 16 recvmsgs to get notified in one round.
> >> That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here=
.
> >> +---------------------+---------+---------+---------+---------+
> >> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> >> +---------------------+---------+---------+---------+---------+
> >> | ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
> >> +---------------------+---------+---------+---------+---------+
> >> | New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
> >> +---------------------+---------+---------+---------+---------+
> >> | New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
> >> +---------------------+---------+---------+---------+---------+
> >>
> >> In conclusion, when notification interval is small or notifications ar=
e
> >> hard to be coalesced, the new mechanism is highly recommended. Otherwi=
se,
> >> the performance gain from the new mechanism is very limited.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> >
> >> -static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, =
int domain)
> >> +static void add_zcopy_info(struct msghdr *msg)
> >> +{
> >> +    struct zc_info *zc_info;
> >> +    struct cmsghdr *cm;
> >> +
> >> +    if (!msg->msg_control)
> >> +            error(1, errno, "NULL user arg");
> >
> > Don't add precondition checks for code entirely under your control.
> > This is not a user API.
> >
>
> Ack.
>
> >> +    cm =3D (struct cmsghdr *)msg->msg_control;
> >> +    cm->cmsg_len =3D CMSG_LEN(ZC_INFO_SIZE);
> >> +    cm->cmsg_level =3D SOL_SOCKET;
> >> +    cm->cmsg_type =3D SCM_ZC_NOTIFICATION;
> >> +
> >> +    zc_info =3D (struct zc_info *)CMSG_DATA(cm);
> >> +    zc_info->size =3D ZC_NOTIFICATION_MAX;
> >> +
> >> +    added_zcopy_info =3D true;
> >
> > Just initialize every time? Is this here to reuse the same msg_control
> > as long as metadata is returned?
> >
>
> Yes, the same msg_control will be reused.
>
> The overall paradiagm is,
> start:
>    sendmsg(..)
>    sendmsg(..)
>    ...          sends_since_notify sendmsgs in total
>
>    add_zcopy_info(..)
>    sendmsg(.., msg_control)
>    do_recv_completions_sendmsg(..)
>    goto start;
>
> if (sends_since_notify + 1 >=3D cfg_notification_limit), add_zcopy_info
> will be invoked, and the right next sendmsg will have the msg_control
> passed in.
>
> If (added_zcopy_info), do_recv_completions_sendmsg will be invoked,
> and added_zcopy_info will be set to false in it.

This does not seem like it would need a global variable?

> >> +}
> >> +
> >> +static bool do_sendmsg(int fd, struct msghdr *msg,
> >> +                   enum notification_type do_zerocopy, int domain)
> >>   {
> >>      int ret, len, i, flags;
> >>      static uint32_t cookie;
> >> @@ -200,6 +233,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg=
, bool do_zerocopy, int domain)
> >>                      msg->msg_controllen =3D CMSG_SPACE(sizeof(cookie)=
);
> >>                      msg->msg_control =3D (struct cmsghdr *)ckbuf;
> >>                      add_zcopy_cookie(msg, ++cookie);
> >> +            } else if (do_zerocopy =3D=3D MSG_ZEROCOPY_NOTIFY_SENDMSG=
 &&
> >> +                       sends_since_notify + 1 >=3D cfg_notification_l=
imit) {
> >> +                    memset(&msg->msg_control, 0, sizeof(msg->msg_cont=
rol));
> >> +                    msg->msg_controllen =3D CMSG_SPACE(ZC_INFO_SIZE);
> >> +                    msg->msg_control =3D (struct cmsghdr *)zc_ckbuf;
> >> +                    add_zcopy_info(msg);
> >>              }
> >>      }
> >>
> >> @@ -218,7 +257,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg,=
 bool do_zerocopy, int domain)
> >>              if (do_zerocopy && ret)
> >>                      expected_completions++;
> >>      }
> >> -    if (do_zerocopy && domain =3D=3D PF_RDS) {
> >> +    if (msg->msg_control) {
> >>              msg->msg_control =3D NULL;
> >>              msg->msg_controllen =3D 0;
> >>      }
> >> @@ -466,6 +505,44 @@ static void do_recv_completions(int fd, int domai=
n)
> >>      sends_since_notify =3D 0;
> >>   }
> >>
> >> +static void do_recv_completions2(void)
> >
> > functionname2 is very uninformative.
> >
> > do_recv_completions_sendmsg or so.
> >
>
> Ack.
>
> >> +{
> >> +    struct cmsghdr *cm =3D (struct cmsghdr *)zc_ckbuf;
> >> +    struct zc_info *zc_info;
> >> +    __u32 hi, lo, range;
> >> +    __u8 zerocopy;
> >> +    int i;
> >> +
> >> +    zc_info =3D (struct zc_info *)CMSG_DATA(cm);
> >> +    for (i =3D 0; i < zc_info->size; i++) {
> >> +            hi =3D zc_info->arr[i].hi;
> >> +            lo =3D zc_info->arr[i].lo;
> >> +            zerocopy =3D zc_info->arr[i].zerocopy;
> >> +            range =3D hi - lo + 1;
> >> +
> >> +            if (cfg_verbose && lo !=3D next_completion)
> >> +                    fprintf(stderr, "gap: %u..%u does not append to %=
u\n",
> >> +                            lo, hi, next_completion);
> >> +            next_completion =3D hi + 1;
> >> +
> >> +            if (zerocopied =3D=3D -1) {
> >> +                    zerocopied =3D zerocopy;
> >> +            } else if (zerocopied !=3D zerocopy) {
> >> +                    fprintf(stderr, "serr: inconsistent\n");
> >> +                    zerocopied =3D zerocopy;
> >> +            }
> >> +
> >> +            completions +=3D range;
> >> +            sends_since_notify -=3D range;
> >> +
> >> +            if (cfg_verbose >=3D 2)
> >> +                    fprintf(stderr, "completed: %u (h=3D%u l=3D%u)\n"=
,
> >> +                            range, hi, lo);
> >> +    }
> >> +
> >> +    added_zcopy_info =3D false;
> >> +}
> >> +
> >>   /* Wait for all remaining completions on the errqueue */
> >>   static void do_recv_remaining_completions(int fd, int domain)
> >>   {
> >> @@ -553,11 +630,16 @@ static void do_tx(int domain, int type, int prot=
ocol)
> >>              else
> >>                      do_sendmsg(fd, &msg, cfg_zerocopy, domain);
> >>
> >> -            if (cfg_zerocopy && sends_since_notify >=3D cfg_notificat=
ion_limit)
> >> +            if (cfg_zerocopy =3D=3D MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
> >> +                sends_since_notify >=3D cfg_notification_limit)
> >>                      do_recv_completions(fd, domain);
> >>
> >> +            if (cfg_zerocopy =3D=3D MSG_ZEROCOPY_NOTIFY_SENDMSG &&
> >> +                added_zcopy_info)
> >> +                    do_recv_completions2();
> >> +
> >>              while (!do_poll(fd, POLLOUT)) {
> >> -                    if (cfg_zerocopy)
> >> +                    if (cfg_zerocopy =3D=3D MSG_ZEROCOPY_NOTIFY_ERRQU=
EUE)
> >>                              do_recv_completions(fd, domain);
> >>              }
> >>
> >> @@ -715,7 +797,7 @@ static void parse_opts(int argc, char **argv)
> >>
> >>      cfg_payload_len =3D max_payload_len;
> >>
> >> -    while ((c =3D getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) !=
=3D -1) {
> >> +    while ((c =3D getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) !=
=3D -1) {
> >>              switch (c) {
> >>              case '4':
> >>                      if (cfg_family !=3D PF_UNSPEC)
> >> @@ -749,6 +831,9 @@ static void parse_opts(int argc, char **argv)
> >>              case 'm':
> >>                      cfg_cork_mixed =3D true;
> >>                      break;
> >> +            case 'n':
> >> +                    cfg_zerocopy =3D MSG_ZEROCOPY_NOTIFY_SENDMSG;
> >> +                    break;
> >
> > How about -Z to make clear that this is still MSG_ZEROCOPY, just with
> > a different notification mechanism.
> >
> > And perhaps add a testcase that exercises both this mechanism and
> > existing recvmsg MSG_ERRQUEUE. As they should work in parallel and
> > concurrently in a multithreaded environment.
> >
>
> -Z is more clear, and the hybrid testcase will be helpful.
>
> Btw, before I put some efforts to solve the current issues, I think
> I should wait for comments about api change from linux-api@vger.kernel.or=
g?

I'm not sure whether anyone on that list will give feedback.

I would continue with revisions at a normal schedule, as long as that
stays in the Cc.

