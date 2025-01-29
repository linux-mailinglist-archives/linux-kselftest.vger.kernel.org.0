Return-Path: <linux-kselftest+bounces-25366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE5A21ECE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EAB188BD3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51B1DE3DD;
	Wed, 29 Jan 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPtWWEHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F831BD9E6;
	Wed, 29 Jan 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159735; cv=none; b=W6ktTXtcdgQ/BGxcyZnht5ZSWiiScjF6Vxyjj33aT3f3HdqaMnLigUI4nhDJd6ZU4jB+0KdUQNrlQzn75qCwN97cqBydPweoeuMKpTBgNF4/Bs69f7amFusazl+Qh1TnB8yhp6Fwktpjre7Yr2xiDYxvKmcNp0xiHfj7TmL03Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159735; c=relaxed/simple;
	bh=rqhhwXKGByeE8r89cbnCBNvF1PnM7jIfUTqAYfzJo1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EusBjjS236Ehqg6KMiJo151DQpPvTOj54G1h7oxp47BPrySTdacwaYNG/3aSbvHcKwRwT3P+dSnnFkeen7NIc/6c2gNXK3PSkNncIQNfrOaG1V5cI4se8uhvT6b/hZad44uOvuITLgQHHdMGvgFupWY8YCrc33q+wPqmYdtwNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPtWWEHs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd01781b56so77998046d6.0;
        Wed, 29 Jan 2025 06:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738159732; x=1738764532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MjXPcEMKbR6gUdgk/5lZvgG3KEYIRNOpZTNc0pegh8=;
        b=fPtWWEHsNNLDrMwy9BzZ72euZRTTzJhiBov4GonICml0wWAcFOtMORn7cdrJVYfpcO
         9d2oQ6n7wW4ZnjoWEvTjeNoKN2tt1FUKB2a4XPBy1LgtgP/fibBDH5Eu6gMKIjtWLG0L
         2bhbCbcdNAjJMyEOE7TzDf7op/JZ6zcFp4ZgdrJAXXDLqnlQ931ZnNydDc7RMWP6Y8xt
         XR5pS+/978FzWHjsJJ4pB9rJlpcpaa2HL7cA+YGTrlyqIWkKws65Klu+4jAnQ0UiHGd+
         +TGFa/v14RAhpFXB+5EZ/zQ2jsnwgzZgjal3JMoeNZl28/bML/c0tKYeazfhXFLDHIvf
         4yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738159732; x=1738764532;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6MjXPcEMKbR6gUdgk/5lZvgG3KEYIRNOpZTNc0pegh8=;
        b=p2B+mXcCN75toAT0vCM69wMGr7kMreLILFhYUnLi8sHxMZuN/8+TmFWX72iLB5ONP9
         FMlm1PW+vNYA3KdOc7H1GcELlHR/JFhKH2YWbCJDF/nyqUIAaHYEW6xJ2pcQ3LTjl3D3
         cUOPg65B5DAx4ZLQ6ksw2pnmi8dmT3ToWrkxywRALankWaKW/Xa7MQWTE7IL6hOaRs3p
         2dooJc97iWMJ7GIa1rHB/kXh9jrsBQmxENNWBYk3ylyPzc2cNZyB8Eo/iuJPoztg0TC0
         8KvseFetdoJ8U2auSJcxjHrM+fN6pMqfEhSPAG/8Vo2QWlJLRdIJuXjJmvWpJ+HJcF7k
         hLdA==
X-Forwarded-Encrypted: i=1; AJvYcCVIIFr75+GA2YZGhvgdA8zhxEGHm+dpBbewhUL1vAi3+oRay9EEzVJ2evd2JoPTePY29fj1k/C7MEjzumGhtgHc@vger.kernel.org, AJvYcCVghSDIy1z9+cM3qABx0jKlhhOt5YQ/XvzQHi4OIAX6ump0Kc8lqZdW6azb4rDQCfsHGymegIfPqm3fWlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza83ohCoB/1WG5a7hlOzUxhnNgTIG36NxW5a3o7su35LJ56W8g
	mkpAwueCnkP8yyMNth+Ib8hI8Kp+tn4d/sDdum9/s7us8k5nWtkN
X-Gm-Gg: ASbGnct4YhOav1z70f1296r9p2CZYpUV+ZOKT/ZtPXMBDoMpknoNVFBQbS0V4FYDIDP
	7tLnkqjd6NvD6XSEPxZ9c22w8ROZjDmZCvtZpaCHjUYt6gJ4mAuyiR9LzUXQXU17TRImthUAWl8
	TMP6v+bScD4VId/DPxSyTBSHE+eKKUoBBiiAlrubobOYa50044jGC20kGxYY/tcxoeyLvDbvcIS
	DpP/dBJPTCuYY1OSHFBV26FNkwESR+UiI0hAJ0C2bwq3vydzduV2yX8dndJnXUfCLBvQWsz9pn8
	yfX0d7Cri2F8FHSTpTYUV5eU+LKaf8ptMujzYto3fy5febRaE8H6TY3XdJ1yDQg=
X-Google-Smtp-Source: AGHT+IGin2FqQStz1/iddWMQu+LTtXlc7FkeAXWkw9fwUCSfzEmhcK7kaFTSmr4rIauWIX5YWXi4vA==
X-Received: by 2002:a05:6214:408:b0:6d8:aba8:837b with SMTP id 6a1803df08f44-6e243c78da1mr41902336d6.41.1738159732065;
        Wed, 29 Jan 2025 06:08:52 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2057a88e1sm55475816d6.89.2025.01.29.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:08:51 -0800 (PST)
Date: Wed, 29 Jan 2025 09:08:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team <kernel-team@cloudflare.com>
Message-ID: <679a367198f13_132e0829467@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAO3-PboS3JB1GhhbmoJc2-h5zvHe-iNsk9Hkg-_-eNATq99D1Q@mail.gmail.com>
References: <Z5cgWh/6bRQm9vVU@debian.debian>
 <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
 <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com>
 <6798ed91e94a9_987d9294c2@willemb.c.googlers.com.notmuch>
 <CAO3-PboS3JB1GhhbmoJc2-h5zvHe-iNsk9Hkg-_-eNATq99D1Q@mail.gmail.com>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yan Zhai wrote:
> On Tue, Jan 28, 2025 at 8:45=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Yan Zhai wrote:
> > > Hi Willem,
> > >
> > > Thanks for getting back to me.
> > >
> > > On Mon, Jan 27, 2025 at 8:33=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Yan Zhai wrote:
> > > > > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoid=
ed GSO
> > > > > for small packets. But the kernel currently dismisses GSO reque=
sts only
> > > > > after checking MTU on gso_size. This means any packets, regardl=
ess of
> > > > > their payload sizes, would be dropped when MTU is smaller than =
requested
> > > > > gso_size.
> > > >
> > > > Is this a realistic concern? How did you encounter this in practi=
ce.
> > > >
> > > > It *is* a misconfiguration to configure a gso_size larger than MT=
U.
> > > >
> > > > > Meanwhile, EINVAL would be returned in this case, making it
> > > > > very misleading to debug.
> > > >
> > > > Misleading is subjective. I'm not sure what is misleading here. F=
rom
> > > > my above comment, I believe this is correctly EINVAL.
> > > >
> > > > That said, if this impacts a real workload we could reconsider
> > > > relaxing the check. I.e., allowing through packets even when an
> > > > application has clearly misconfigured UDP_SEGMENT.
> > > >
> > > We did encounter a painful reliability issue in production last mon=
th.
> > >
> > > To simplify the scenario, we had these symptoms when the issue occu=
rred:
> > > 1. QUIC connections to host A started to fail, and cannot establish=
 new ones
> > > 2. User space Wireguard to the exact same host worked 100% fine
> > >
> > > This happened rarely, like one or twice a day, lasting for a few
> > > minutes usually, but it was quite visible since it is an office
> > > network.
> > >
> > > Initially this prompted something wrong at the protocol layer. But
> > > after multiple rounds of digging, we finally figured the root cause=

> > > was:
> > > 3. Something sometimes pings host B, which shares the same IP with
> > > host A but different ports (thanks to limited IPv4 space), and its
> > > PMTU was reduced to 1280 occasionally. This unexpectedly affected a=
ll
> > > traffic to that IP including traffic toward host A. Our QUIC client=

> > > set gso_size to 1350, and that's why it got hit.
> > >
> > > I agree that configurations do matter a lot here. Given how broken =
the
> > > PMTU was for the Internet, we might just turn off pmtudisc option o=
n
> > > our end to avoid this failure path. But for those who hasn't yet, t=
his
> > > could still be confusing if it ever happens, because nothing seems =
to
> > > point to PMTU in the first place:
> > > * small packets also get dropped
> > > * error code was EINVAL from sendmsg
> > >
> > > That said, I probably should have used PMTU in my commit message to=
 be
> > > more clear for our problem. But meanwhile I am also concerned about=

> > > newly added tunnels to trigger the same issue, even if it has a sta=
tic
> > > device MTU. My proposal should make the error reason more clear:
> > > EMSGSIZE itself is a direct signal pointing to MTU/PMTU. Larger
> > > packets getting dropped would have a similar effect.
> >
> > Thanks for that context. Makes sense that this is a real issue.
> >
> > One issue is that with segmentation, the initial mtu checks are
> > skipped, so they have to be enforced later. In __ip_append_data:
> >
> >     mtu =3D cork->gso_size ? IP_MAX_MTU : cork->fragsize;
> >
> You are right, if packet sizes are between (PMTU, gso_size), then they
> should still be dropped. But instead of checking explicitly in
> udp_send_skb, maybe we can leave them to be dropped in
> ip_finish_output?

Not sure how to do this, or whether it will be simpler than having all
the UDP GSO checks in udp_send_skb.

For a "don't add cost to the hot path" point of view, it's actually
best to keep all these checks in one place only when UDP_SEGMENT is
negotiated (where the hot path is the common case without GSO).

> This way there is no need to add an extra branch for
> non GSO code paths. PMTU shrinking should be rare, so the overhead
> should be minimal.
> =

> > Also, might this make the debugging actually harder, as the
> > error condition is now triggered intermittently.
> Yes sendmsg may only return errors for a portion of packets now under
> the same situation. But IMHO it's not trading debugging for
> reliability. Consistent error is good news for engineers to reproduce
> locally, but in production I find people (SREs, solution and
> escalation engineers) rely on pcaps and errno a lot. The pattern in
> pcaps (lack of large packets of certain sizes, since they are dropped
> before dev_queue_xmit), and exact error reasons like EMSGSIZE are both
> good indicators for root causes. EINVAL is more generic on the other
> hand. For example, I remembered we had another issue on UDP sendmsg,
> which also returned a bunch of EINVAL. But that was due to some
> attacker tricking us to reply with source port 0.

Relying on error code is fraught anyway. For online analysis (which
I think can be assumed when pcap is mentioned), function tracing and
bpf trace are much more powerful.

That said, no objections to returning EMSGSIZE instead of EINVAL. That
is the same UDP returns when sending a single datagram that exceeds
MTU, after all.


