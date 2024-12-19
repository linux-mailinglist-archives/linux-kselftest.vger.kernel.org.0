Return-Path: <linux-kselftest+bounces-23575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4F59F7464
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 06:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C21640DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 05:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAC21660A;
	Thu, 19 Dec 2024 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlvsVA+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6D1FAC26;
	Thu, 19 Dec 2024 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587685; cv=none; b=ruu0/ap8rVbmHHO1qx5nIYZjryt9iwShIpFhSdpTUMDzl36/TGaJgO09i7EUIG+P6GCy07Fk+ijvUT3L5ARxqeO1jCvi8AHXMUtQ5QMzAflEF0eY8ArQugAM7Xb/CVwNKkzA+3blUo4gBru/Y/ifB1HnKBSuDTnLEpaZF8fKgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587685; c=relaxed/simple;
	bh=VsNY71lG5lYULBvFXVp0KhrDlqgduRP+ORPVKzySpuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4TG8q2+fM+C1GGV8wDPlnogH8WkLThbfP4//vTctqqkUP/XcGXbDjb0KMptYl3zCV1EeKuncOboS1JwqfNFcVKrngKDNHO3voZ6AP0e0ji4qUR2bfuSIQR4CL4n8oeJyMNTmaR/7gvyKamgkA+jDvPgWsKVY23t1gGot2D32Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlvsVA+w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f664af5so4374875e9.1;
        Wed, 18 Dec 2024 21:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734587681; x=1735192481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=DlvsVA+wXI6i1KZT9lm7VOFI7czigiGhZADLOrnKSV9b0EIZkwsKPjMCneGSwuWDNt
         tqSzzXqZLPu/ECOYzRmlJMx5TxWB50zZtgcQYQwd00cCAAqit7VeMa0yS9/3VjGpDH7I
         aXHKaysIBOGFkpqv0A/T9dOWYLdk1i1eyf5oypzdcnQK5xxmnibQdENbKYeDBYrtv6zg
         bFXv9iGDXju6rmkqMIIhNGHPPfYld1g1CnkPcw2RNERa6hqxFIMHoo3nlwPQBOAKXOlm
         JwwRtlm7CHhEXquivsuy+qSh/XNDxr4FJU/feblYVePstfyNOuwfH+sZaj9J2SWprcVX
         8QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587681; x=1735192481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=QEtqVhzAQ/htuy3UdwVCI9wz3xFSH/YZXUrq2ssfztulmKLlACSaMMcYwM1EksIK9W
         rYTwqSsxc5STOXr/GMXKoD2xlw5fjFC2w//CSxPt2UsLML//475E6H2C187VXx80Thbo
         DY1oYvPhcixJaMigAabuLYtFCWhtbMMcaG4MCJvv8F8q8gdT4nOY0dhoKTvk9Fiypg3c
         YQlrHRD1CPUyfS23ywQDl++xhhjIR+fdrpr05UNwHipUh/NsdDa0FCaxNJudmECJ+IT/
         XTygTtRpvjGyEo7rDLwiIIaIoWo1AfjJtzKH21C1sG9XKu7BrRgYRo4nqwrdQKrubQ0z
         77cw==
X-Forwarded-Encrypted: i=1; AJvYcCVE5bHAOCx/Ir+omCK/lQzi9/AKeI0MfusOWgeR8jU+pdzKacdpBqgrlyFxpUJHrkK+9VCPvpSeWvAzbA==@vger.kernel.org, AJvYcCVfBhM8rQsUyVYa1/0G4Q6wp5MY/j2NipK6zBW3dmMuj9Fcmju2sH6onzKzvNS72pAkR1z9qwDRzfJDbsn+jEc=@vger.kernel.org, AJvYcCW1U7pZvhGGMm/7WhY7P0Uja0Gqr3SGChRplnFcA5Mnc0co6IRs2eaDfxQziT0P+NgsCglEV7sWGljH@vger.kernel.org, AJvYcCWIy/bZ8E3sgs4RrDQ8cBVzi2jTtq0DxvDbnX7FO0St5MnqI5hOD45D0T5FMgSsAcPaPt9CTKUoqL1rZCOWyPTi@vger.kernel.org, AJvYcCWxKszMr7PTK+BCVN9NRxXreNBPFmpMU/QlfJ8eCyCxBtRTcS8hjeC+3tUB6CLOCd6AhQ7szXXmsIV/uOBw@vger.kernel.org, AJvYcCWxP9c4je4LN3uGv9+iTmdoCKXhZeduAAE1sqFi/3AB7nJoIgQ0bWahIo7hEOohoqw8JKc=@vger.kernel.org, AJvYcCX1P+Q3cTk3NwKYPdVvgMl++Wq3l10sZDSv/rGv7Cd/HTqSulNgLTAuN19s3+vxOqsdnmI3BBCsrZpo@vger.kernel.org, AJvYcCXwrBTBjEvqf6JEMth4HSrxTjXzxMoE49szMpq2a5xxZ7BgpIw+xe4CgB/7BjOvpEICioeyAzbGKH7UMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLyNPLdbpZd06rIRvErliYm7TJ5cL/U+sTDGKIVSqQMEtWluS
	mniKrys5qq8zNEK5vI6G2dzGh15CwMP1wQ1ychhjB3Q1xPIEjdQ8HBtahJ1nmQON4xs/q7yxMFY
	kxeS0V+KHWYS+n7HUtE/jMhTqUIU=
X-Gm-Gg: ASbGncuEH4Xw7pYcaU7E0g48nMEwu7wJLKkQNK6vE4KRklbTj3MkfvV2crG3Qz+XCJX
	SiJ6VFiibV4z6q0c0KXLQrKNndFVw3dcRLZoj
X-Google-Smtp-Source: AGHT+IFXswhNY3wf74HiVRQ6mWtI+LQ0dYPzH2WDbrTkg0k3vCjw9PHsmFSj9uux2yKPzKWzDIYRJF3gX8R2i5iXHRM=
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id
 5b1f17b1804b1-4365535c6a3mr52447275e9.14.1734587681279; Wed, 18 Dec 2024
 21:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218130909.2173-1-shaw.leon@gmail.com> <20241218130909.2173-12-shaw.leon@gmail.com>
 <20241218153759.672b7014@kernel.org>
In-Reply-To: <20241218153759.672b7014@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 19 Dec 2024 13:54:03 +0800
Message-ID: <CABAhCORszq9ao3OCVW-1EBsxsnLxbQ096eV+cbs12Es2HvCgUA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/11] selftests: net: Add test cases for link
 and peer netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Dec 2024 21:09:09 +0800 Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test to verify that link is created in target netns directly -
> >    no link new/del events should be generated in link netns or current
> >    netns.
> >  - Add test cases to verify that link-netns is set as expected for
> >    various drivers and combination of namespace-related parameters.
>
> Nice work!
>
> You need to make sure all the drivers the test is using are enabled by
> the selftest kernel config: tools/testing/selftests/net/config
>
> This may be helpful:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style#how-to-build

Thanks for pointing it out. And vng is really cool. I will add
the missing config in the next version.

> --
> pw-bot: cr

