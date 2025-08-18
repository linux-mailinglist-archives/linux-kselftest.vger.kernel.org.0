Return-Path: <linux-kselftest+bounces-39217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E78B29D75
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F48E1888772
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0512750F6;
	Mon, 18 Aug 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBOcaBQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7523C4E0
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508688; cv=none; b=e0XzNx4SYraU+9K8bAqBKDnB5+ELQH/dYrz2dYDt+Vky4tAIXZ+By3/BL+0pcaK2hgsFSAJ7zzoa/086DUw1CYxZVrspxMfquC9VZ6BD9W5FdrZiLP2qnGvlXgPojfWfsperAHEwiyC8FkGCQ0TKUk1WuHFmIHM+EPRoi/Yiacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508688; c=relaxed/simple;
	bh=VRbt8m6yjwhJBf5/VpfWNr4OTU3FocAWSdb4TOxjyvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFwOfDnWtTPgh0Xs0AS0oBpo4Mi2zZKEv/f7FzmcGV9BwoTDmxDoZjFhff5vAIEvhn6uYJ3h/UywaMv7hXKIi3ME6HG25AehPbGiZNQ9ENtoNy8kh2rpX0fl8Q8+4seYHgGBRIMSac6tuY7mocHKUas3iQmHIXlfXVFYedjA5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBOcaBQZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7949f6so7492916a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755508685; x=1756113485; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBB+lwM+pvu4wSVI63N+6OIHc2C2sLC4MvB3ZcoPbLI=;
        b=MBOcaBQZMeX0vEddnxjS41cMsUGiEZrSXKT+uQKGjN2ZsGoOMW1kqmKvmeosmslWbb
         eYRe0MjcIf082+t4lh88vWp3W+hOhbUv0erzRhq4zBzZOXAYF0fBx5ry/qy0daF8kELv
         AljcQWVW7vvlqjKwv//kQx/fztyIZEE4vJhafqFiN7rfVdp+TCJ8ir33JgFdXvohKCiw
         eca9/c27g7xRNPtiHlKIg8LuVBgxsUKOCaRa2qylj+TwAI+rd7Bbz29C5c0rhclopfj1
         1EJMO0Y0X4TaSOnsMT4Kzvz5rsj+mpFyAKaKDieXr06D2AYak9eSh/Wr1xXjg6Vk/L0t
         0XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508685; x=1756113485;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBB+lwM+pvu4wSVI63N+6OIHc2C2sLC4MvB3ZcoPbLI=;
        b=b8v46yUp/+DVTf5/j17oqdoVx6OXCZ08Tl8afSGdTtoKrJsZD0T16m1O6SOPLJlGWR
         coAYOMIxISfen8yQEeQGaS/6dGmp/pE2ds74EaZCNMqbRcg4S+Y2OlzA/nTnih9B0+Ox
         ihLxOyFyG1BlMBx0VdOi7+IGIL4MUGCFr7Uvb+w/hk6sjbD6bEatEzHpGRAjM2NKtD5T
         FjCAUNI2IeB5VVNnNaG2FfJDeiU86OvpjQ4xDROG61lG4vlIP6M1XW1OuLvrJ5eXewSi
         aa9lv4qpsqykAkeVwDZRgGoLHAuhOpBtL6d2nyG17MKyWx5Fxvc8SxUfUXndXH/zCy2m
         t6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQR9qeIwKAlbUdv+oapHRnJhdtjY7Li6/A/qa3zb2u4ZEoUXVc7A/5n+ujqe39LTBmqHsErPBIW6Jwk3bBPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtV1gdbs0Xx3LvqCl7deTBa5h3nUQSgu3geBKiDDQgApbqPqJ
	9n5lXZKmzZ3KM7N42C/AfnczwmOnlzRPqeejKXUipHhSBf+CBCNhXtQP
X-Gm-Gg: ASbGncsC10YDXxNnt4r78Wy8pfmU1EPHeIJtI85NZvSWbTjAmETbRG1SWXNAJNDj4H9
	INEuglPU/O25/KXcZx4m9dxQ8efLxmL9K0v29s6E0sphYZOKKpaZesRSyeccOpJzzAqeTkgyh90
	4tB92hg7eVfiWIJE7l+O7hIC4d8GMo1S6vG6bL2O/WxtaePlcdM8WrDKxC3sOOQf8peZ6bXm8dg
	y54MvfPAiTO6UI5Aynxxf1IV/ZUaA+4tleLWosbmo4CeZMfM2X6+WI9LN7p07h0hLdZrhfQgWIc
	j/6E+hXInWuOU5cNR0m/PhUxvZrfZ/sNb62KAewMgnO/S89XlEGNAEmG1ch3RC4uGUKKdXwzFrR
	seYAAxomTGJVqkdUSXkL8bQ==
X-Google-Smtp-Source: AGHT+IEnbuslmAYoX/r/WUhAK3IQsUhLJAXaHPPA81WGpSjMtXS6gTvCCY7bzrCTPjrHQRCoTrse/g==
X-Received: by 2002:a17:907:9446:b0:af9:3611:924e with SMTP id a640c23a62f3a-afcdc3e77b9mr944453766b.53.1755508684864;
        Mon, 18 Aug 2025 02:18:04 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01f445sm762836666b.106.2025.08.18.02.18.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Aug 2025 02:18:04 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:18:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	usama.anjum@collabora.com, thomas.weissschuh@linutronix.de
Subject: Re: [Patch v2 0/2] Add kselftest harness selftest with variant
Message-ID: <20250818091803.jfsmmag27n2vivaa@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620032815.14543-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 20, 2025 at 03:28:13AM +0000, Wei Yang wrote:
>We already have a selftest for harness, while there is not usage 
>of FIXTURE_VARIANT.                                                                                                                                                                                                   
>                                                                                                                                                                                                                   
>Patch 2 add FIXTURE_VARIANT usage in the selftest.
>
>Patch 1 is a typo fix.

Ping...

Would someone pick it up?

>
>v2:
>  * drop patch 2 in v1
>  * adjust patch 2 based on Thomas comment
>
>Wei Yang (2):
>  selftests: harness: correct typo of __constructor_order_forward in
>    comment
>  selftests: harness: Add kselftest harness selftest with variant
>
> tools/testing/selftests/kselftest_harness.h   |  2 +-
> .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
> .../harness-selftest.expected                 | 20 ++++++++++---
> 3 files changed, 47 insertions(+), 5 deletions(-)
>
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

