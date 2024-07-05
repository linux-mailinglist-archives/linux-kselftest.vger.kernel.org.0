Return-Path: <linux-kselftest+bounces-13242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB914928A56
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FCA1F21EB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AB168490;
	Fri,  5 Jul 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nacf79q4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D34166318
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188089; cv=none; b=D/di50EcjoaZ6B8iKU+jXJk9e9FLNBqGBwKq4kelgF84B6gzQlA6NgFqE9ZJQWO0Qq3FOR71o2bBP6HrMmINSXGweNoiwstlIV01AlisiNdv+6VrCtmawglvFfuZb42FQbZ7VFtv1YfACNDe2fS0hhRsUs285/6rZWQL1ap9n3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188089; c=relaxed/simple;
	bh=7tGSHKV8sdgdC7RNbGaWsfZ+SPiR4Zzlma2qqZNVdWA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2ppgkpC3+nY8o+iNfAMHszkXiKDKaSI4j6ceAS2A6sE53gqfeFe5DryBtwMUXWVB6fFFyJioRhKLUzqVyfv8cwU+KMbckgcMkGUroO5Ltzr1Hs70+NlvZKvUulW6ePeJv27r8xIbzJGptFD6USjeDOII0gdeUGJFk8MVR5XCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nacf79q4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720188086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4BN2DKVnIi0/FYqV0P1Y2iVXb87vc8jKGdpfjXw8IM=;
	b=Nacf79q4AS7r0f8pE/EI03trZ7wUTGznNQusErAzfPxsa4bJN//1iM/FJuhH67LwJ4DRe4
	4g6LhaYplEbOfHOrkcx5w29/M/7BRUuu8iuCyGjyciL7TejOcZpTio9WHC1BD5qNKcCA1N
	AkXlMjaYIaZFSFW3USfimEZBBjrjyXM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-2B3upiXoOpKR3rQYgo_KKg-1; Fri, 05 Jul 2024 10:01:25 -0400
X-MC-Unique: 2B3upiXoOpKR3rQYgo_KKg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5e96477ebso23292076d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 07:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188085; x=1720792885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4BN2DKVnIi0/FYqV0P1Y2iVXb87vc8jKGdpfjXw8IM=;
        b=OuzQ+tMR/vX/Pq5GK3CLiDoXJ+R9StCxwzrUv4tAtdB8zls275lt1qL7LelbMBs8P8
         IFiDqmINGWjvIa8KVUXOptP+UoFFnCdqLI9kSmweL81rgOhjhjsBSWsd7XuWIFOs1/+q
         4HSymPnEWIWgX0/5B48R7InkxTDrmOea+B/+d6sWnmDQw9Urb96cElXOw02ScHl7DsiS
         tmLX8Mjw/AMeQtrVCoLhu3R6rk9ogzoZzNEFVokBHsHdP3h8wxeNShk0xXwwC6imi6hz
         YsKizL80WHU7h2FvTegwy32UcftvYh28TZBiVaCU629nKSYnGHUhgiPw8J3LIPrdIEGD
         Wt+A==
X-Forwarded-Encrypted: i=1; AJvYcCXcs5WXdX1zzYYGlcQWnAuNtmTDAxW95BJ5f70LUO5HTbzL1uveO5xnLXVJaaMJYRUZAvoU7j5lv6XMQBCyFK37Kb8GjQ39aKgtPbKtRWsU
X-Gm-Message-State: AOJu0Yy2NNSnQIzweHUkG+6KM6M65lJNzapOe41i+MDnVu9ljsmfL1+R
	Q+mPVfHBDNqHKvKlEIl9vY0mnewjKWWN9kND505Q7Jqg050b9mUfw52xKB7U+Iyl/2mN9Q7futp
	GHSaTkJctyPyRfvNYwyTwsYEvSKDvJqbeY4Uk6ERzvlC/v497BqQCpRqS/v5hfk//e6o1wxrpyS
	T9c/xfFW6WNKLOSy9BsbUjOcHn/OqyLERG0OocvHny
X-Received: by 2002:a05:6214:e8b:b0:6b5:e5f7:7ffa with SMTP id 6a1803df08f44-6b5ed093efamr57690806d6.63.1720188084929;
        Fri, 05 Jul 2024 07:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41KdTtAEfnQLNxhWthl4at6lVGAdChdZNVWU5AfJWlf4kei01pwe3OHUEL6/Kntn5X3dSc4CPSTCUguMa1pc=
X-Received: by 2002:a05:6214:e8b:b0:6b5:e5f7:7ffa with SMTP id
 6a1803df08f44-6b5ed093efamr57690366d6.63.1720188084394; Fri, 05 Jul 2024
 07:01:24 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 14:01:23 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com> <20240705062851.36694176@kernel.org>
 <f7th6d4ne3r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7th6d4ne3r.fsf@redhat.com>
Date: Fri, 5 Jul 2024 14:01:23 +0000
Message-ID: <CAG=2xmMDm-AuTZVAC3WwXsax1z_NSx9kYXG37q8EAnZMdk3BNA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some flakes
 in the CI environment
To: Aaron Conole <aconole@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 09:49:12AM GMT, Aaron Conole wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Tue,  2 Jul 2024 09:28:27 -0400 Aaron Conole wrote:
> >> These patches aim to make using the openvswitch testsuite more reliabl=
e.
> >> These should address the major sources of flakiness in the openvswitch
> >> test suite allowing the CI infrastructure to exercise the openvswitch
> >> module for patch series.  There should be no change for users who simp=
ly
> >> run the tests (except that patch 3/3 does make some of the debugging a=
 bit
> >> easier by making some output more verbose).
> >
> > Hi Aaron!
> >
> > The results look solid on normal builds now, but with a debug kernel
> > the test is failing consistently:
> >
> > https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-net-dbg&te=
st=3Dopenvswitch-sh
>
> Yes - it shows a test case issue with the upcall and psample tests.
>
> Adrian and I discussed the correct approach would be using a wait_for
> instead of just sleeping, because it seems the dbg environment might be
> too racy.  I think he is working on a follow up to submit after the
> psample work gets merged - we were hoping not to hold that patch series
> up with more potential conflicts or merge issues if that's okay.
>

Yes. I am working on a patch to solve the failures in slow systems.

Thanks.
Adri=C3=A1n


