Return-Path: <linux-kselftest+bounces-48562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C8D0674B
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F051301FF66
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF269314A80;
	Thu,  8 Jan 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGQejxtf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D596247291
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912429; cv=pass; b=Se4wG2t6URe5tHWsaaHUTjFnxom51nETzFQKNTQWUScVhid1Fp4ZnraWE3TdQ+eEmVsbDrV0deTlcQYLmLuf6S2cQFRjyF1mz3a0NiPWGPTspE9Ua+OujxXNRRmIyBOD+/FlthNnhGWxA6iysuqg1cetr9o8GHLo4d4rtxojWEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912429; c=relaxed/simple;
	bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIZxmHfdLnhEuvAsu3nMEdum0S8vCEa5irU/vcGRsxVsyOEopx3yT69NdMMTAlbYgqpXzPiwdZ/4KO5buzwpFMDZ9fQqph4fzUflz782/uu887ey/J2BsEGb+iychBW+BKMxmpdByjHNJ5Oek8yT13PDwNhoDgN2TkwhjaplA0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGQejxtf; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee243b98caso68091cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912427; cv=none;
        d=google.com; s=arc-20240605;
        b=JboZTZTJkg+jaL1EhPREj539RB5XQKmvEnbJ/piHSoRVCgWSOYe8fRsGuXIPYc8wWs
         MmPIUVbs8jwWGtsZTArVN801swX7p9SGMgw2KhngBbIIzl/CKYyc0EWxbBW4Ub8z/iit
         4/iWnVYzccojEeU0MBHIVfV7fYj2QKoZg0BZD0S+1ZBSHb9pecQkqboV45318IaMSqX8
         PNzJW+Rqk8N6zGNfmz6xlbBLkX78Nkdij6S0zFI0YaaCiF7YGGl3/9uX/uIaZ0W7UwYf
         YGyO+t3iMpEYWLY5MUEAeVPGQAZ8t3bwuY2rS2WKeZCk4t8lDCnYhsWmtszhlJ6OABgF
         L++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        fh=DQzvfA8iUShraEiNHvrw+/izMZQTaS6RFrEeWK0K9BU=;
        b=YtSyTBGQmu9Tje/TUl7ETWtp3VEu5b7jKZccQpXBRpmrhJRKN3pJ3FVkCYV9rvUcc4
         tr1ylwnVz5GrGqRgMvSW3EopxPeAgHOJglWfIVmcoEfMKpinKMzbxxRx8KATn19aknLG
         jDOG6czx/US5d/hcOKJSgOCfNUT+5P02VcwogIqx42hfYghPUcAEfuVpnc/pMzzF/g6p
         3gVUb8bk36gg9s3GT9tbneLDO8SRNWl9B8wEmjJ5pXEZLg3MMA53wBjwIWUxxxUwdEjN
         XZn9btUAiU+woXJBuhrI7Vb/NsNlCpoe5+TbMR9hnqbRoSogTLENbr9mbPsfmpvGhi2a
         zcDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912427; x=1768517227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=NGQejxtf2Jaa+RGslgJRJN+JXurmKYzqnYxfVp8GPq3Zay9NOOR7eoF3Zscb/0kT6J
         BRXM3Koq5aNwJG6Xs9rIRhTbWIS1/1hmL4glbb95HoB6mT9RiMEOHNw6wIc1rTBTILlQ
         HwEosyqJ9ExuavMPnseG6vxblXkOSut6IYTp95WMS6rKmy+V0pF3ZDuR6+RlfSJf+XRg
         hUmJu81DWN5mH9KtOy99zamcPFbKZf+e4BVQIa3fw50k7Kazafz5+mfgGrzwZ+uMJwdU
         rsi1333NfXMsMETzrVe+4gUN7q86gY2CLx3o3Yzo5e/opPEzxJi1AQzEnFwZNeYNTgcs
         yE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912427; x=1768517227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=IQ+YqQ7FrC4A1RzDx1D2rr1FAlwvLLHlJ5WAy2eU7aCX58xXnUM3YxIRY/gZOYro3L
         2iQHR1qCCbAs40hjun4Dv7+t0uD5WcLMSRg+gj5xtvs/gaCbup4KkkT7xZpxdgNeHuHd
         b7DEqkJ2+UokbMe+VncInyby61GcglUa6x5soNov1d3GKByb181XUvQ9Q61edgNo08Im
         1wa+sBGhW5eO7u5RSAZsLMJHExlkiXFBWXAazQROLPBcaazLule/hh/YTA0SgCpw0LnU
         XT41+diFQBoOqSy/85zpNRSSjvy6ZE/f0B5OQgOW7E/Cq417jMZO6z4N4IeZX3BL6Tpk
         /FFg==
X-Forwarded-Encrypted: i=1; AJvYcCW2nrOK2X+/fMlLYpa43kRaLcJC1xKlFcS8bFewZDoiqZVpZJLiZqov4UNSfnAApN/W6r0jI+Ai1DZYCK/CsPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagpV52NwClJ6guubhJkyWK6eBELtDQ9ecLxPtOaqiW+laTwHw
	ce0t+Nq2Rfjx64yeOYUUV23crEYK3otgj/39Bp+7ge5lJt7ZzFOInrd9EAilM+PQF0Gw7ylihSh
	TaqZj2rUebg0kDJgkNuJSi9wvwTycX/U4oz4fJbGd
X-Gm-Gg: AY/fxX43RF5nB7rs+87x/+BaUN5lYjr0LkGa0C/8Qbh5WXWque8p1GZxDJPLUudrpZS
	LseF9YnCZgK5+tXaLsZXuVnwq1Wb4rbrwy3WpHDdmPOxzYEPTqMfq4UKWnKJ0qKVfoNrKP8tkaO
	1Oid2ic4fVAkqOBJDQ8Yg05zBuNcqOtjr263TCXpMbORKXcQ5eHaGU/xi2fMtA5MINiV8z3X1wz
	KZTgQ/l00MkGTEKfn+1uFjaEOVwheAelvvxq19KGCBF4xelIndVkgxZulOWSwGxuiZLz2U4K0QE
	FRfvWhdk7SLrmqpeju70UrW/YFCDxC+zwr+ixT0x5dmdrjehs/9EuttPF1GX3LdnlakusQ==
X-Received: by 2002:ac8:5782:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4ffca3ad29bmr3817721cf.18.1767912426910; Thu, 08 Jan 2026
 14:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com> <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:46:47 -0500
X-Gm-Features: AQt7F2ovG-v9G1YvqpyTasF2O1QIEJ_BUtc_E8UKj2kCrrVV8U2__Yy5KoIU4r0
Message-ID: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
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

On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.
>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> ---

Chia-Yu, thank you for posting the packetdrill tests.

A couple thoughts:

(1) These tests are using the experimental AccECN packetdrill support
that is not in mainline packetdrill yet. Can you please share the
github URL for the version of packetdrill you used? I will work on
merging the appropriate experimental AccECN packetdrill support into
the Google packetdrill mainline branch.

(2) The last I heard, the tools/testing/selftests/net/packetdrill/
infrastructure does not run tests in subdirectories of that
packetdrill/ directory, and that is why all the tests in
tools/testing/selftests/net/packetdrill/ are in a single directory.
When you run these tests, do all the tests actually get run? Just
wanted to check this. :-)

Thanks!
neal

