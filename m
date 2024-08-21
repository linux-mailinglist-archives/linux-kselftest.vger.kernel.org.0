Return-Path: <linux-kselftest+bounces-15809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19969592F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 04:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20611F239C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AEC14BF90;
	Wed, 21 Aug 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQxiZroj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858117F7;
	Wed, 21 Aug 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207940; cv=none; b=YR89zUcMuKtWZImzxsoYisBFpdtC6qrILc1NewLvKr0aVnelZz4PwXdMREr+iErQTfPNWKy+CyCW60laGsw9WFfTdRhhBgYQ1XOg4sGM9iSkbpg9SKzh8MeW/q1CJMtYqiFmgM1McwDdP0YpiEMGcf5cJdOkLpLOq1LfyBWqxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207940; c=relaxed/simple;
	bh=pWLdDITN5G/Fs0+wkZkyaTeViR0s73pz19wdKfX4m2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz5k16OSCfqaXoB5JS/FGMxKLHDxKvD6FI1stzu4hrWxjAOatyX6QEk7Wjy0FJz51C9tWi3UY7zNVqV3wFAn81LgQ69NLxsVk7opqK4we18twEtfS7FvCspalKjtcKVSyDbtQXrnD+H2qegIp0tYAh5DeOV+2u2zNWLKA0NQCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQxiZroj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70cb1b959a6so2378455a34.3;
        Tue, 20 Aug 2024 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724207938; x=1724812738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0aq5x+Ez6jYfq4GqzMr1ftLQ4aAL853CTIVt4Od+B4=;
        b=eQxiZrojmuFN9/8ELs57p5ajW9gPG5o6tjIZmU/hyPqSyt51Wk5cxmUmyrwOkMsCwl
         8spVygh+ke24CKHDC+AtTdiYUudMbIuuzGBSB/99gbjAQ2LmqOn3/oecT8x7ZANQeXmE
         YzuCLX0KNRCz9BuvBeeu2XX1C4pPKOq88pGniTfuwFu/QjM2GYtUJQrup4YOv3iC29KH
         7RU4wXXCz48LcCf4ZFoMc4VHNPJpNz42Tc/2InF/DwXFIxiN7MHBA5TVCYy/X+Nuoqdm
         2LCmHXXc2kjmdQHJXCiLfw3lytMoLLAIlbXJCaf4VxctIS+j5MZv3YKEIdYYL0WVRVyT
         a2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724207938; x=1724812738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0aq5x+Ez6jYfq4GqzMr1ftLQ4aAL853CTIVt4Od+B4=;
        b=RcGQscrpuVQTUR7gTp///tclB3Kqcog58E7mQJ1GHeBNXdQHStMg11L9OwrBUeSiQF
         6otBjtY+nzX8wclgNZ1fMc1Q98xBqs20knQMMXDId4v0jJp3nO0g8CPCh5zJFt0Q0aw8
         HDFqVrdibUkYbRKaZ2lfxFs9br5mdN48H1Zq8ZgplFKdZIxhtBDm1hKwnMTD5V62Tg+c
         ltbdMmEKv5PtXxBXvaDSn5AnwjNYG7TPtXn3QvKkv8W+wMirI9Lotjr1FqMwjz/9HE55
         kYo006UBAbe4siczRo/uxGM0hbbUbsuhOTgTD2bL6Y01UrJ8LNVwGMvyYIdRaPAqPWWS
         Awvg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnxxKKftDnH7oc7aFe82dJEF04hd05Y8Gpvud74gIGWw7rXzQkhraPm4nc/LumHllkpWry/z8@vger.kernel.org, AJvYcCXqY4wZhj3nXMwRnvCThK7I2rdD4b3UdjLsaYGW3ep7eNiTR/MpHNcXsbDrT7PFWYFVvS+7BwEP0TcgRYZT88g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhx/wtPqTXVtw8DUmZHPDRHHzVEuu7HZn1zN8bzxwYkp6CvBi+
	tGB2nk0ugx4ASNwpYnxWAoNujXcN3v5R4XbugwvPGXX8m/th5Cx2
X-Google-Smtp-Source: AGHT+IGRypwpI/oJbphMhwLpfIL9IXGc2ZmuTeRdySk6ObmPlf5MLhxOaix74bJ7PGqWKyIoA7U87w==
X-Received: by 2002:a05:6830:3490:b0:70d:f448:575a with SMTP id 46e09a7af769-70df85ef534mr1127675a34.1.1724207938017;
        Tue, 20 Aug 2024 19:38:58 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae06a88sm8884478b3a.45.2024.08.20.19.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 19:38:57 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:38:51 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next v2] selftests: net: add helper for checking if
 nettest is available
Message-ID: <ZsVTO7vjPRsbb4is@Laptop-X1>
References: <20240820004217.1087392-1-kuba@kernel.org>
 <ZsQLFwkNa-JnymGg@Laptop-X1>
 <20240820084412.4aa6abfb@kernel.org>
 <20240820182147.462226f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820182147.462226f2@kernel.org>

On Tue, Aug 20, 2024 at 06:21:47PM -0700, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 08:44:12 -0700 Jakub Kicinski wrote:
> > On Tue, 20 Aug 2024 11:18:47 +0800 Hangbin Liu wrote:
> > > Excuse me, what's profile used here? I can't find the definition in
> > > Documentation/dev-tools/kselftest.rst.  
> > 
> > Ah, sorry, I added timestamping output as a local patch for NIPA.
> 
> To be clear the profile=1 enables the timestamps from my local patch

I think it's a good feature, maybe you can put it in mainline :)

Thanks
Hangbin

