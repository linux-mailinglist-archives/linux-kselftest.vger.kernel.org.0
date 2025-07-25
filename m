Return-Path: <linux-kselftest+bounces-38010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4EB125C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 22:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FFA5630A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D26245003;
	Fri, 25 Jul 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVkHT7yu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EB8F5B;
	Fri, 25 Jul 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476479; cv=none; b=o01FHorjeY27HbMzfiBYFakU/KoYD2lIzsvlAua93/gpDZCf5YZ2wuAYf21eRnnHuX3WvYb1eUyaAelxUjBWzQNYit4dAZlOCLgPw4q09Y1O8oF//+Hb1hliL87MNyQlEUymiaO1MBbP8n60tyYMqU463yqrdovrCjW6qE/+O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476479; c=relaxed/simple;
	bh=1HnDXNWh+78+5J3ziAOUJF0w03fT02FGni7TCg2mTGk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o4Dv58IicDadXZCW5/UFgvhtx5t/h0CQ70VkaaLSHhzjEG6wOJ4lMck/C2k7BRYy9p465V2YbXOs6PUvNm8WdMkGlGVZ3evHko7yfxTDG4/HGmX3GVbW8Gc9wz2j6gBiWzXjuMGBAhe78hOZfzD44uzlWQxkzle/9fdBnWmmZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVkHT7yu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8dfa44ba70so180622276.0;
        Fri, 25 Jul 2025 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753476476; x=1754081276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HnDXNWh+78+5J3ziAOUJF0w03fT02FGni7TCg2mTGk=;
        b=YVkHT7yuM2ei2KNiQ6DJsp8lhLM8oAnJThU/Pe5Zxl9nDIX6s61w8zPMOCADLiReqB
         5FjdqlVjtSqIOtb5ckn0hqGhLnhRU5IKvtkQnUkF4OB40YKhn9UyLi6CqJwI/L991uTv
         EI7iqwS9U6451gJYf6yEOPDrNHo2ohPpK1wTNg82CDZkkZuKSJ/IQZSaKDXDVmWVV4mp
         76qFZ5zIp5Ld8n1nacyFOJirAKpFpgSOSrxVdcfEK5e2hYpe0KgpIyxKaM0yL67UBZc7
         RcSTnuWZX0UDYmuwKhwxCDDqh//fkx641cLs6NwLJ2+7GPlE8Xz3RFhiDQwvi1cdI+5G
         Se1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476476; x=1754081276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HnDXNWh+78+5J3ziAOUJF0w03fT02FGni7TCg2mTGk=;
        b=sa/+jhxU+IugSjrnsUSSBVh5GWKC0L2otQJ3qxu6gh5voToFwVbbpGABLNEVrYAWQI
         QQ6whbjcGTQvapwYPiH0J4pN3eYb5mTdPR0w/gy9Pt9BfLSjkrkuxEEkvegI554XklyZ
         CrSqR8tWeqrKLFaqrc/wPjLGoEP6BSoTUBSlAJGBx5Mwabd+/GIfBEIimLzSw3mN7xex
         tFKemGhOXr4IQuwErC7T5RXnCafePwDh6ALOBdpzMftOZGEJ/j9ETG+Bd/q8kl/w0mrn
         qPG8HGIDIJV6fLrlQJSwRTpCZ5p5InSoEqK9p+FaaG64ilcXYMS7kRWjWcVWOezbRqFw
         /ZUA==
X-Forwarded-Encrypted: i=1; AJvYcCV/NtMx4FxVH1GL89KvatsjfCrvA9Kbd08S8pxA5kVrvIjJE8R0blowyD0dBx7HsECDsJ+DF6l2@vger.kernel.org, AJvYcCVpNcGkb1ac5pIsjvz+Y6InSve/4fb9zMb/3FeGKh8J++MLyMnmgkS/wt38pnBkDpm51qP/pLbR2gMFN3NN+/rc@vger.kernel.org, AJvYcCW+IqXpGu43tzDQV/K1ivXKXrT7RpqzCcSEM7Wn+4qOHN98GwRJUmkHMjd1BN4dt1V7C6cdzTC/KKzeDyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKS7RT1Ug4M5tBl7PLnyumqBWPAd5PILfzuKlsJcjsaGi3pCoL
	+8fpAg69fme29lKzoznBtou/RiqwZh8xB0NotUd45OLr/lqY3aAJRLw0
X-Gm-Gg: ASbGncuD3ik9adgljUyFxlbF4xS/Rlp74Ezy7/XrQ2ljMCfjIdRFo4+QQ6PuHU3OywG
	UYMyVG1r70Bdd05rWMtBJFbQhDBs8qxbOxAmhlGb4eGp+8MKnQ00wU3xgzRjVPA1aGLH5/lviKX
	oOS7sXklEBg53fKaDfb1QF2BiWb+Ta2dhcmhw71PFP7/VuhrvZ1Y7SCwgRGQyPLDe75lxrln5gY
	9TryuabEHJ9n/eWalqoNWq5tFCM21PBPGnF1K43fqP4kmqyeNrGCuS2oBe+en64Da4lzMurboft
	3w60zdfQJ1uJDMrLTTP+5O1VnBisexzXHUlo6MYnVWpYcrb55VGITyS6ZKKLrIXisxQo5BY3xVM
	iNxCJWnw6uKOQQMW3Y093KEbZRvOhCv0V0SPYFhe9MIMWUp3lrJ8O80es8R0laeFy8/+2FQ==
X-Google-Smtp-Source: AGHT+IFwhTwZxUkQnLBqIPdOYM7CdMskd3wM4tl1Nbr5LGllE8GT5heMcP6liCV2Dp3aBKaOfdPdgw==
X-Received: by 2002:a05:6902:2747:b0:e7d:a332:2e9b with SMTP id 3f1490d57ef6-e8df13bfe99mr3122311276.43.1753476476324;
        Fri, 25 Jul 2025 13:47:56 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8df8710060sm244452276.43.2025.07.25.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:47:55 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:47:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
Message-ID: <6883ed7aed06f_3f184b294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <eutsqoc6f7xcaez2ttuce4uqtfvs3hyit6dradikvfcgxdev75@3senqada4nzn>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
 <20250724182427.5ece92e8@kernel.org>
 <eutsqoc6f7xcaez2ttuce4uqtfvs3hyit6dradikvfcgxdev75@3senqada4nzn>
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Breno Leitao wrote:
> Hello Jakub,
> =

> On Thu, Jul 24, 2025 at 06:24:27PM -0700, Jakub Kicinski wrote:
> > On Wed, 23 Jul 2025 10:35:06 -0700 Breno Leitao wrote:
> > > Extend the `check_for_dependencies()` function in `lib_netcons.sh` =
to check
> > > whether IPv6 is enabled by verifying the existence of
> > > `/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconso=
le
> > > tests. If the file does not exist, the script will skip the test wi=
th an
> > > appropriate message suggesting to verify if `CONFIG_IPV6` is enable=
d.
> > > =

> > > This prevents the test to misbehave if IPv6 is not configured.
> > =

> > IDK. I think this is related to some of the recent patches?
> =

> Yes, commit 3dc6c76391cbe (=E2=80=9Cselftests: net: Add IPv6 support to=

> netconsole basic tests=E2=80=9D) introduced IPv6 support to the netcons=
ole basic
> tests.
> =

> Because the NIPA config enables IPv6, the tests pass in that
> environment. However, if the tests are run somewhere without IPv6
> support such as in a test I was doing regarding another patch, they wil=
l
> fail, when it should be skipped.
> =

> > The context would be helpful in the commit message.
> =

> Apologies for not including more context in the commit message.
> =

> > Otherwise, as networking people, I think we are obligated =

> > to respond with hostility to "IPv6 may not be enabled"..
> =

> As for handling systems without IPv6, if IPv6 isn=E2=80=99t available, =
the
> intention is for the test to be skipped. That=E2=80=99s exactly what th=
is patch
> addresses.

I think there is some consensus that these environments should no
longer exist in 2025. And test failure is the best way to accomplish
that.

Less opinionated: the tests implicitly depends on the config files
in the test directory. Do we have to start making the robust against
situations where CONFIGs in that file are missing?

> I did consider making the test adaptable so it would just run with
> whichever protocol (IPv4 or IPv6) is present, but rejected that
> approach. Allowing the test to =E2=80=9Cpass=E2=80=9D in such cases doe=
sn=E2=80=99t really
> demonstrate meaningful coverage, since the test isn=E2=80=99t actually =
being
> exercised as intended.
> =

> In short, it seems more appropriate to skip the test entirely if all
> conditions aren=E2=80=99t met, so, you know that your .config needs adj=
ustment.
> =

> Thanks for your review,
> --breno



