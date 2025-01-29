Return-Path: <linux-kselftest+bounces-25376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB17A22210
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B8B1883C3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AB1DF75C;
	Wed, 29 Jan 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F9csjIoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892481DF744
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169353; cv=none; b=PPynbvKXdF2z5IiAZ/UsrYy4XQE7o3qdrBC3dQ4qSU+3aJwAdeJqE3hf9bIdIqLyuAbVrd6G3E2N2uQ8aO25bAbGBDm3QM4H9OZBgQ0hg1RlmuHfnjeSMNIPuZG/aT73ihpo9ErvcDz8VcODXiZe+gKw82V9jdft0QJN3JahnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169353; c=relaxed/simple;
	bh=Hgkh/0Y0TyOZtL3tMmuDhaoz4mDZ9yXLeg6Xlz++XBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxXCyfqQE/lDTn//w+FJdeB9ZlQhKxqlgPWqcWn07C4gCVS73wbclBJckc/8IQBWj/DDSomFMZdfe2Z6JXLJGJqrazDvgFs/wh6uI5wo9w1gXmBAgPExi+rymQ1vE5p/wA8Lrke2fVl4vFoGAv6Pfa50fYfcZwngstfAoqBwkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F9csjIoY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso9818184a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738169350; x=1738774150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24mFNTs5JTFo0m2JMhT7QRNiD2ytZH7rVwvkzzD60y8=;
        b=F9csjIoYvJMbEtg8ptQTyIyirtFb3rD/KcpKhDEqbF3rmNRPtoVHJZV3KCNMA5DfVR
         NDponZn/j7YAfqciWKiP8xYaHdpFWS7U/ssOtGOaBnkKj2fCOSJLGVaFs3UQ+kEy56dc
         +cdthm+L3KfmZjSqneWHAvOM75xdZwnTkCttRO4RB7mU9C4eQm7Oxnl0CynAGneqxjxC
         FhkceFykIsoideGsWfixjXSRlupStiRO8rnknir6PYEpKbs6SxvX/3f/vhIvE/iiGkgJ
         z7f9W0fPjaT1TnefeB7Tu1JazJxXO5pRxTR9KjdKhwbV4G2drPtt2hv4dP3KmF0J3LPj
         hNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169350; x=1738774150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24mFNTs5JTFo0m2JMhT7QRNiD2ytZH7rVwvkzzD60y8=;
        b=E+oMKpXdl+Oc+enEomrWc0DaX0jbagKsy10BqO1HHVUNANzMIXhwqiUpIbi6vhy8o0
         401jnhjhpKeuYAPKPhOYwLdhNOfZZW+oKJ1BekoyqUh6Z2dc5FNA8QPmMNMVKELQyLbd
         bw5smXWv52v3iRDeXFW4k6X2biWLgEJW8x4UXyEz3dzKOOxIrIZp/swwYXNCNqt4W3iS
         CFLT+k70LsbmXFxlIwzFlJwfaxAFfgOGlnDuHCv/ncfJTxZ0hGZR4vxRxutch8075Ac+
         1I6U17vDGJChFvvFVeOZu3q6lKOG87pWZE+AS78BKwrgw2UWVIYgznGk6Ab1aYmIHk57
         rBQA==
X-Forwarded-Encrypted: i=1; AJvYcCXxmiOOAXxZ11eUz60fvDIHI5ikShp3UxxLmujYixLls8m4jX+9WbaBDTUxXhgWbbFsz80wc9+lSy6v8sGoZ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlIAlNvT5q2wtt0XbJrMb98x+61SFdT+fTJcMI9gqShs2992O
	/64iJHnFPe1dy1j5Wb5vj3RjmfHatjMN61kQ+NK6J3c01N5U9zF3zyo5B7jDb9mfvvG0XJXwsMP
	L1qX+CAoJhB3Hy7i2BpdI+rlVX57+zyNwCYqfsg==
X-Gm-Gg: ASbGncv6g/iFdoMcY9pDqJhPiXozeIlDdmJwJZ3JkCD1gAhDYgbPgFqIYtcOBLdHP58
	83tanHZc0TInbdJJdmBi67rflDfThbXKaOYwcy8C+3uotsJwK3ilIStGlyzJrV7oc5RICszoBWQ
	Z33aJ7cb85YG8=
X-Google-Smtp-Source: AGHT+IFNVgiMkVJIbrv6oo/KsxMQ2wthoaQl/ttMBhRczemhVIIoaZYCQxK+nPbUhHuh1xAsfsy9eREZqVlKLUwJtpY=
X-Received: by 2002:a05:6402:90c:b0:5d0:d84c:abb3 with SMTP id
 4fb4d7f45d1cf-5dc5efebf52mr2864461a12.26.1738169349705; Wed, 29 Jan 2025
 08:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5cgWh/6bRQm9vVU@debian.debian> <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
 <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com>
 <6798ed91e94a9_987d9294c2@willemb.c.googlers.com.notmuch> <CAO3-PboS3JB1GhhbmoJc2-h5zvHe-iNsk9Hkg-_-eNATq99D1Q@mail.gmail.com>
 <679a367198f13_132e0829467@willemb.c.googlers.com.notmuch>
In-Reply-To: <679a367198f13_132e0829467@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 29 Jan 2025 10:48:58 -0600
X-Gm-Features: AWEUYZkoD9-G2Gb2BMJKOXr7zCSy1PEo0iP8iXxgX__McdlsVTcTjQqXioGb9gs
Message-ID: <CAO3-Pbpxt9K=mT3ozFqMHAQcy0B30snxq9Kg9xvP7pmzmXP5=w@mail.gmail.com>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Josh Hunt <johunt@akamai.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > On Tue, Jan 28, 2025 at 8:45=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Yan Zhai wrote:
> > > > Hi Willem,
> > > >
> > > > Thanks for getting back to me.
> > > >
> > > > On Mon, Jan 27, 2025 at 8:33=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Yan Zhai wrote:
> > > > > > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoid=
ed GSO
> > > > > > for small packets. But the kernel currently dismisses GSO reque=
sts only
> > > > > > after checking MTU on gso_size. This means any packets, regardl=
ess of
> > > > > > their payload sizes, would be dropped when MTU is smaller than =
requested
> > > > > > gso_size.
> > > > >
> > > > > Is this a realistic concern? How did you encounter this in practi=
ce.
> > > > >
> > > > > It *is* a misconfiguration to configure a gso_size larger than MT=
U.
> > > > >
> > > > > > Meanwhile, EINVAL would be returned in this case, making it
> > > > > > very misleading to debug.
> > > > >
> > > > > Misleading is subjective. I'm not sure what is misleading here. F=
rom
> > > > > my above comment, I believe this is correctly EINVAL.
> > > > >
> > > > > That said, if this impacts a real workload we could reconsider
> > > > > relaxing the check. I.e., allowing through packets even when an
> > > > > application has clearly misconfigured UDP_SEGMENT.
> > > > >
> > > > We did encounter a painful reliability issue in production last mon=
th.
> > > >
> > > > To simplify the scenario, we had these symptoms when the issue occu=
rred:
> > > > 1. QUIC connections to host A started to fail, and cannot establish=
 new ones
> > > > 2. User space Wireguard to the exact same host worked 100% fine
> > > >
> > > > This happened rarely, like one or twice a day, lasting for a few
> > > > minutes usually, but it was quite visible since it is an office
> > > > network.
> > > >
> > > > Initially this prompted something wrong at the protocol layer. But
> > > > after multiple rounds of digging, we finally figured the root cause
> > > > was:
> > > > 3. Something sometimes pings host B, which shares the same IP with
> > > > host A but different ports (thanks to limited IPv4 space), and its
> > > > PMTU was reduced to 1280 occasionally. This unexpectedly affected a=
ll
> > > > traffic to that IP including traffic toward host A. Our QUIC client
> > > > set gso_size to 1350, and that's why it got hit.
> > > >
> > > > I agree that configurations do matter a lot here. Given how broken =
the
> > > > PMTU was for the Internet, we might just turn off pmtudisc option o=
n
> > > > our end to avoid this failure path. But for those who hasn't yet, t=
his
> > > > could still be confusing if it ever happens, because nothing seems =
to
> > > > point to PMTU in the first place:
> > > > * small packets also get dropped
> > > > * error code was EINVAL from sendmsg
> > > >
> > > > That said, I probably should have used PMTU in my commit message to=
 be
> > > > more clear for our problem. But meanwhile I am also concerned about
> > > > newly added tunnels to trigger the same issue, even if it has a sta=
tic
> > > > device MTU. My proposal should make the error reason more clear:
> > > > EMSGSIZE itself is a direct signal pointing to MTU/PMTU. Larger
> > > > packets getting dropped would have a similar effect.
> > >
> > > Thanks for that context. Makes sense that this is a real issue.
> > >
> > > One issue is that with segmentation, the initial mtu checks are
> > > skipped, so they have to be enforced later. In __ip_append_data:
> > >
> > >     mtu =3D cork->gso_size ? IP_MAX_MTU : cork->fragsize;
> > >
> > You are right, if packet sizes are between (PMTU, gso_size), then they
> > should still be dropped. But instead of checking explicitly in
> > udp_send_skb, maybe we can leave them to be dropped in
> > ip_finish_output?
>
> Not sure how to do this, or whether it will be simpler than having all
> the UDP GSO checks in udp_send_skb.
>
> For a "don't add cost to the hot path" point of view, it's actually
> best to keep all these checks in one place only when UDP_SEGMENT is
> negotiated (where the hot path is the common case without GSO).
>
I mean ip_finish_output is already dropping packets with length larger
than dst MTU. But I guess it doesn't hurt to check it also in GSO
branch. Let me send a V2 later to address it.

> > This way there is no need to add an extra branch for
> > non GSO code paths. PMTU shrinking should be rare, so the overhead
> > should be minimal.
> >
> > > Also, might this make the debugging actually harder, as the
> > > error condition is now triggered intermittently.
> > Yes sendmsg may only return errors for a portion of packets now under
> > the same situation. But IMHO it's not trading debugging for
> > reliability. Consistent error is good news for engineers to reproduce
> > locally, but in production I find people (SREs, solution and
> > escalation engineers) rely on pcaps and errno a lot. The pattern in
> > pcaps (lack of large packets of certain sizes, since they are dropped
> > before dev_queue_xmit), and exact error reasons like EMSGSIZE are both
> > good indicators for root causes. EINVAL is more generic on the other
> > hand. For example, I remembered we had another issue on UDP sendmsg,
> > which also returned a bunch of EINVAL. But that was due to some
> > attacker tricking us to reply with source port 0.
>
> Relying on error code is fraught anyway. For online analysis (which
> I think can be assumed when pcap is mentioned), function tracing and
> bpf trace are much more powerful.
>
Totally agree tracing is more powerful. Time by time we see issues
lingering for a few months get addressed in a few days or even hours
when tracing is plugged in. Unfortunately at least for us, the number
of people who can trace properly is far behind the volume of problems.
I can only hope in the future more people will recognize this as a
golden skill, in addition to current standard skills like pcap
analysis.

Yan

> That said, no objections to returning EMSGSIZE instead of EINVAL. That
> is the same UDP returns when sending a single datagram that exceeds
> MTU, after all.
>

