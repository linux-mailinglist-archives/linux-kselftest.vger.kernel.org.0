Return-Path: <linux-kselftest+bounces-49307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A988D397BA
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8180030022C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43C22F75E;
	Sun, 18 Jan 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6XaMVfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4871D515
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752663; cv=pass; b=jBB7hkPeNVdmDqSW1b6RmYE2xRmCiB0d2LCumpcUZwcgBc932oqo9OSlrODKowFCPiiM9G/uir74k7fFY63tYYmAUbxGxxpD8BHWfY7S997+Nzp//tIC2nvnhZxNL+58cScrE5Lx+gru/x5PFF6ef3TN89Vq4W+886MWizBsBMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752663; c=relaxed/simple;
	bh=0JEpv1u8AAklgZXOaUjF/uve3gSlITzDcBypad/O0O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS3l2pQjhM1eG2oXMnBji6gs4KzvadjVGwrDYysdAXHaHh50VoyVJTQ+Ei6dQjf81p4vBp3wmIylW/HD8+VIsjOle1N02Hz7PkabT58tEFnVpp3wfI9+DuKtRUEwS57MWtUfjonLzHmdpTXbM+HzCel1tQPMJD4TY4Wzx/+fZiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6XaMVfe; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50299648ae9so539311cf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 08:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768752660; cv=none;
        d=google.com; s=arc-20240605;
        b=e9yi1smjgXeAvZLP0EwopOmPRgTBQ+K4aGBuNj/fKleeZwKO+qWMk5ZflxMeKPF4BM
         9O91VQsrHaVjCwaTmNhxPSnQZIzettBVxg7nVjvuMYceEyLV3xRrCQCeKC5hlHyJ+1MV
         6SoXbNxFLBicu8NT0fH0za9IbrlUHk+7E8TjvY6GYevs7psUav3GOd497eUAbVsJut2P
         WujZPW1jYd6VlVu7yXjPtnwGEbndcgf6IVrJxA0uz22pAFArXWGN8PY9G4R5Fg9JTFCk
         TZLK9ds12QA3jc/XKcds6lg6y0qySmyt8AiazUuyzVTTibhUsG54JTItNbRdsxPhRv7k
         OzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        fh=9JKGZNOS9bSQDZnNVgJHa3No78DbEjJhxmRCmgLNCU8=;
        b=Z6uomosrs22vEPZ4sNTqlxuSXRzxwqqG9A1MaOhO8fV6NAul1FSqL0gR1uV1AWBQAd
         e3JBpBEI93luuBVSQ4bbwPzTLAa0trDkMvgPMDjPPb6ZFg6mPfiSYoUwiROgOLmeDk4z
         hxYgaV/lI4K/1eBZ9URIBH1GJjFH8qs8CVg0TH+hj/zS/RCSBobRYUXVw4baejG54ekt
         IXeCjVTXoZW4WHfQImRoUVeq/VLXVHpjVv6wDrj9+1QBJGi31tTYPOIRbgRDzhdenSxs
         idJJAZYGzjq5tXamziki2VUQrGSMHwi+XPGmhl/soJa5vcrWTbKEvc7kqomqpPp8kJ/9
         91Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768752660; x=1769357460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=o6XaMVfeClkjpRcSgzZz6ylPmhY4DzRtt9TKBZgcXgb9UBFd4eGSJy3wouiKYeoxFZ
         +dS00Qq+oyGb1YwCrkvooeHOr0y5bV/hGVGwIrhbmVGkcVH7PJJE01wr4anVeqSzQobf
         66NZEO7pbzaQftNGzUWh5O3JtHyWCC902akFDKCQpxLgyZ6/jUTmUbQZh7C3HUevO5TP
         3337NTE9Mu43ev+xQsctB1vLMjQUe4Lp4pAsQvhCUNp2qJNn5Sh9fDkSfXpcKoCJMUhP
         vTjHYNT/7aXvP+tzo0d6oAVG6NGcAwRdBd4I9+waz5sVmzsYBPC+suwxJvrX4W3lIf6Z
         LO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768752660; x=1769357460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=LA3ck7s3jmq8y5iMLgcr0u68404xi85XbVbohkYZMnWj00cos+hagRRf2IkaML8qpi
         IyKLhddL7eBP4GD2hmN0okaVG2znlC1YmGTm48nEoLN0ZP2YF2I5G/9U/uWf2draNmOC
         jedwv5sso1VWDfNkdMJaAzENGOr71f6T0CHxvNYVTB8jdTVI9e/Ys8HDjhmBTM97OKUX
         eS2bcSTf4qPH45dsIJZ3z0wtUBkBzA8osdjhJN92f6tgaBpAdvPyI55JHxM09ir6TgWJ
         tyelcM29G8VBmDpZQyzWI6qIhgkjKo4yXQLTcZfjaitusrY50nZTIRrl9LJ/QC6axVvQ
         Bg4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYocseOALahjS0X6LZemwMBLD8W83dqfyn67M7c4urcIocoWj1OKiGpII58L8wsTAThRKhzfKrbZX+MarKiPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtUO3c+lu9s6a7fft9OAD89KV8qogz/tFGR1Cy6yDssPGaYSm
	ea4NzMN4Du3sykLvJAVSLbw5FJLuoOuTV9PRAN7JwdDVP+IeeyaCBSLHGtMWbmJKgYhEgzhl6Yl
	wd2fIgkeYAH1aqB0jbdNNkJ0tZwPW/tJ6CMZXk4Z3
X-Gm-Gg: AY/fxX5j6nJZFlhU0aT8XUWGLcW4bd4quGKnGl/VIBuozVFie6498GLhvkv8T76Ozz/
	FjRbViDx2xm9FqdOXZKMdZss6w82NkegLwnie96kJ8JTueNKEZa98WXS6uxgA2Hjx8RJ/PEN4Og
	ACFkfoUvcFuub6K44RZ7fKo2VMbkGwGd/LD4l1p6JCXy2uLbMpIn1TtViQEY6T7DEMjMAGFc9wR
	0ITdnJPIfOHenWiMmOZAY5g94lBItVpxW48zX19/YOb1tIYY3LikxtNvqlhqOZyclj5u9Wb7Cme
	joNYDifNbWMGm3l8e6OxTofdyz9Ib5c3P74Gcg0Iw9WSGEFSjF2TrUrXfFdb
X-Received: by 2002:a05:622a:1342:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-502b0673b32mr11255181cf.3.1768752659324; Sun, 18 Jan 2026
 08:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 18 Jan 2026 11:10:42 -0500
X-Gm-Features: AZwV_QiOr26zAWiUyzYVGxtB4uUNxYcdhHaXiVDyCTcYKsivAZl7luiVeGFtNPs
Message-ID: <CADVnQynBnqkND3nTS==f6MGy_9yUPBFb3RgBPnEuJ446Hkb-7g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

An update on the 3 patches at:

https://github.com/google/packetdrill/pull/96

(1) I have merged the following patch into the google packetdrill repo
to facilitate testing of the AccECN patch series:

"net-test: packetdrill: add Accurate ECN (AccECN) option support"
https://github.com/google/packetdrill/pull/96/changes/f6861f888bc7f1e08026d=
e4825519a95504d1047

(2) The following patch I did not yet merge, because it proposes to
add an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte
padding hole at the end of tcp_info:

  net-test: packetdrill: Support AccECN counters through tcpi
  https://github.com/google/packetdrill/pull/96/changes/f43649c87a2aa79a33a=
78111d3d7e5f027d13a7f

I think we'll need to tweak the AccECN kernel patch series so that it
does not leave a 4-byte padding hole at the end of tcp_info, then
update this packetdrill patch to match the kernel patch.

Let's come up with another useful u32 field we can add to the tcp_info
struct, so that the kernel patch doesn't add a padding hole at the end
of tcp_info.

One idea would be to add another field to represent newer options and
connection features that are enabled. AFAICT all 8 bits of the
tcpi_options field have been used, so we can't use more bits in that
field. I'd suggest we add a u32 tcpi_more_options field before the
tcpi_received_ce field, so we can encode other useful info, like:

+ 1 bit to indicate whether AccECN was negotiated (this can go in a
separate patch)

+ 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
use TCP_NODELAY is a classic cause of performance problems; again this
can go in a separate patch)

(And there will be future bits of info we want to add...)

Also, regarding the comment in this line:
  __u32   tcpi_received_ce;    /* # of CE marks received */

That comment is ambiguous, since it doesn't indicate whether it's
counting (potentially LRO/GRO) skbs or TCP segments. I would suggest
clarifying that this is counting segments:

__u32   tcpi_received_ce;    /* # of CE marked segments received */

(3) The following patch I did not merge, because I'd like to migrate
to having all packetdrill tests for the Linux kernel reside in one
place, in the Linux kernel source tree (not the Google packetdrill
repo):

  net-test: add TCP Accurate ECN cases
  https://github.com/google/packetdrill/pull/96/changes/fe4c7293ea640a4c811=
78b6c88744d7a5d209fd6

Thanks!
neal

