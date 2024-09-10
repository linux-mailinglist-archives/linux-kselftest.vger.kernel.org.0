Return-Path: <linux-kselftest+bounces-17640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5E9740E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B1B1F210A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8811A4B6E;
	Tue, 10 Sep 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpKlzFRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832981A4AC6;
	Tue, 10 Sep 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990147; cv=none; b=fqEITgoy9JJGXkV/EkxGpRrTMLf63EH4QYSpJncYzxunde2rwlKXRYxgDu1cXiszG4oVahkulFJ6fUd3vnhcZ8knZhIgz3guYLv50qx6gSkb1BKJ5nN7K28JxJdL32jBvJvryfcdCO+ceE/4NfANLTbiNg986hCnSm8uTl494Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990147; c=relaxed/simple;
	bh=bV/cCPgQmMGPZOQ6cElFw5TE2AzczFXZAlM9b/E8Fug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UPztstZDmRpLDNytyCa62UypwHTXXudhK+RHq7UxkS7ElPX6uktRQUDUDWslV5meFsu/sWjsvxVosTayaljNj2H7aQF2a0ThHpGQ42KWw3ttQ+UQb+bfzVJhdnLCbLcvrcJWBf3YU+zhDhYYHGBpuIWi41yE7PuTWATd9ShYLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpKlzFRo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ae8fc076so254417285a.2;
        Tue, 10 Sep 2024 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990144; x=1726594944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osrSmdlRRbXgWjiWwZC0FQoUmfxKFrAIzTPo9tEegGU=;
        b=MpKlzFRoClVoF96LXi8EunQL6Ypuq2Fu/80cfMmrdzbC5CR0ntB5zOVDGoyq7/cj16
         lCOOfTbbxsCyNG+BCZ+Mk4mvkFNzDYZezFnuejZ2JVMyduyDscMoCXcKkR50+j7tlKaz
         9glK9oJNshKOmHK4Qcxf5TtMDDBVRAzm0T1YmnB7/T3D+en3H9UtCHwVZEVbuTiRoVoj
         7MxpWyKoKVhQnwnu5Dq1Ev9TflWyfR60etJC22bVXC4L/CUy8JspPWNRISwvBRu2S+Oq
         ZUD8L2t0lN9fiaQhYzwhQGGhdK16sQmPv+RNH/93szvUo5NkKcIKKNF7VU1eHWNzbyK3
         CjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990144; x=1726594944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osrSmdlRRbXgWjiWwZC0FQoUmfxKFrAIzTPo9tEegGU=;
        b=Uz5u/CjAWntKF8Hnj2iMOiiIuZYLWfKoultmh5KneyA0t56rIzLqBIcckxPNg6jCNt
         0wxWyWAqV/oH6qV46osmX4dZALQgV16EJy1UwcMUOJ5CqtS2dpwTOAi30T1GQ5hodfUw
         O8G8eyMFwmSNoBlPuuMjP7salMmwvflTs6i9t9rVhJkGHARwLGQwn9ChPMm4OEClWNRL
         kG0cP/TA5PetQQbMvlPyvKYjUoKhYJ26jMD7RIH1TiWiPkIZWzxEGU/C3429WM+E1X/y
         glEnGeJ5kjwSC1y3nQ0a39SNJtUBC7GuUfLdlnNNGXPIdWTEr0/pI7j5lsS2HjO52y3R
         DqIw==
X-Forwarded-Encrypted: i=1; AJvYcCUmk/EqoytxzjjxiLHbbGFhs6AnwtIZFinqcFnmt4cs9sfh0wI/59gNYtlCzmuyfYufDfC+DPmK0q6nfxvvULVS@vger.kernel.org, AJvYcCV/+x9MxqVwI3pxoZ7ltFjwwW+S6oFDrFdHmD0qNUJG5SD5QxRNYnByG4288WaJbIr6JYT3ZjlNtWUz0kg=@vger.kernel.org, AJvYcCWhx1JaeI+lWXxLZSAmKu6HnNevqI0WhTGkdxsc73RbmqZhIHsRYvNvlME0I1CNbikpWI364ZaV@vger.kernel.org
X-Gm-Message-State: AOJu0YykUyzO0AZ21rBKHSfSgoSWyCk9GwrjuxmXCPCsgNcl0D3iKfZG
	AKzLT9YALPgdBV1k8cPZ9pOZW0q2lLjVaW3Tc1PjxVYqzYENmeDa
X-Google-Smtp-Source: AGHT+IHvwbLEki8g7DoGbzuEAVprt0WWYMJSyX1CbpAViPsW6cMv0Yc1UKcT8kk8wS5Y/sF9i5dOig==
X-Received: by 2002:a05:620a:4629:b0:7a9:b3a1:94ca with SMTP id af79cd13be357-7a9b3a197c4mr1254397985a.35.1725990144340;
        Tue, 10 Sep 2024 10:42:24 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ad15sm328004285a.30.2024.09.10.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:42:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:42:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <66e084ff8f8aa_c435329483@willemb.c.googlers.com.notmuch>
In-Reply-To: <6d5ca057-87a3-4ec2-a733-8f0c1fb11158@linux.dev>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
 <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
 <20240909165116.1bdb4757@kernel.org>
 <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
 <6d5ca057-87a3-4ec2-a733-8f0c1fb11158@linux.dev>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> On 9/9/24 21:01, Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> >> On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
> >> > > This seems to be a bug in the driver.
> >> > > 
> >> > > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
> >> > 
> >> > In which case this test detecting it may be nice to have, for lack of
> >> > a more targeted test.
> >> 
> >> IIUC we're basically saying that we don't need to trim because pad
> >> should be 0? In that case maybe let's keep the patch but add a check 
> >> on top which scans the pad for non-zero bytes, and print an informative
> >> warning?
> > 
> > Data arriving with padding probably deserves a separate test.
> > 
> > We can use this csum test as stand-in, I suppose.
> > 
> > Is it safe to assume that all padding is wrong on ingress, not just
> > non-zero padding. The ip stack itself treats it as benign and trims
> > the trailing bytes silently.
> > 
> > I do know of legitimate cases of trailer data lifting along.
> 
> Ideally we would test that
> 
> - Ingress padding is ignored.

I think the goal of a hardware padding test is to detect when padding
leaks onto the wire.

If not adding a new test, detect in csum and fail anytime padding is
detected (i.e., not only non-zero)?

> - Egress padding does not leak past the buffer. The easiest way to
>   handle this would be to check that it is constant (e.g. all the
>   padding uses the same value), but this could have false-positives for
>   e.g. timestamps.
> 
> --Sean



