Return-Path: <linux-kselftest+bounces-39131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE128B2898C
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85649AE3699
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B1B2904;
	Sat, 16 Aug 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Q+34tCh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96176211C
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Aug 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306301; cv=none; b=aIrQC2RaX5FI7iBu6tCUYBWIvyY5DLqiJiovuTfcXfZoAeB0BRZYcJfNaCed0l0w6f4kMW6dngh1knncEMdqI56gxTR9i/VKqLAm3ghHO7SfCkSyj2agHLCccM/S4ezL+9JITF7iqEc/8GJcGlLLeLraXd7lyQsyU8Hf3YCQPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306301; c=relaxed/simple;
	bh=AmC7aK+TWojYLMuv2X8zTyKYSCw4V0Yu0YOf7G4RhBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfDF8wPyC4vp8VoQ2z0b2SaimP4eXlyLoQNmKu2i6jcay8syVLT8ZYpfxsK4Q2LJG3e/95C1Y2CDUefJrI0kPHurUHB2jnNbhDqMs0v7Uc2GkcFswOWDO3EqclKf6Gs1KgHNvCjzJrSuvVHE5W/dnzTyRF69QN2+p0mkxRRXd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Q+34tCh7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458298aedso22513045ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755306299; x=1755911099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJUQ38MWzTlYEkjbKnTHPpD6HEhNxZ9Aq1YWaqmqts0=;
        b=Q+34tCh7xgCvWggZuHEkRpp2GVQ6W6c/kQGwxcLDCZgNwXo+bScqtNHIGHPqaUh0kZ
         l8sr63D6JotSo4KAGZtHJwR5rslO4lqdOO8mS/h454/qSmx9AbR0SWlGFtlYpHYSvr3f
         7tlgqBCzuW39yRtpueAfsUdgdcvBtgiMY5/sXQqjo4zHZWQazPS/+qnzL2U+rNS3BFab
         pZK1gXqtnfK5jMhF4UHlQAfqskCOr33i84k8xHgmDKpE+3KED2MtQpNeYN4QhHK1a8jS
         0i+EwDDfei4v5prJmNUW4kMifxcmP11To5vmbHQzU5uqdwNAflDfjBLmzWI+HepLWsjz
         qkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755306299; x=1755911099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJUQ38MWzTlYEkjbKnTHPpD6HEhNxZ9Aq1YWaqmqts0=;
        b=Hjk7nFYSLC2elQ/NzZvoy3PH9AqNUn2B61eQkxrCeYvT8tkg2vwHeaXPJZ2ODt+z7u
         CQePfDnB+lI55AsLTb848qyaVusJOh4qWaseLASHa05CoDCktU/GZKjqpvfMi2GZCaiE
         QrsHVuzvomdPi9wRIVymK51PbCApws6U3je+Rwaf1ZiPKU3MhK9nDshUD5VqN2aEDOu1
         qW7qZahQ4gg7Uoe+1sMs3xhfCzVia4yCaOFFIy8ASUbmzwp3mLY0W7NZKRa/7ONIXs98
         hVkJgdJSs2F6x/nKR5e2jtOh6oku76lbRVHUz9OcToENMyrrtXD4XpSXYOoHLv8a6S8m
         zpMw==
X-Forwarded-Encrypted: i=1; AJvYcCXPY6GHob17Ch7XLd8PkwuCBk0S1kqm8IKwffXkfHT3Mtgbo9Z6o2kupOWJUvfSkDGd/upLcwnVFddIyCj6Pvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCbQ+p+yTRE19HzEAMd+j7BmI1TT3iLKPOJ/Y+iLqV7eF7JXoC
	lwkAUs1ivDAWfcVFOvY0k+c3JETvR7AsQqVBst2TqT7K91lWIC14GL/4PlK/XM1deY4=
X-Gm-Gg: ASbGncvHYrAOoIUU5VGO1/xKZPWysEzdfp7Du1rppCs/6zK94bNzlDrTbv6o8/QbmM3
	s0OxTtRZNzBcKC3yzqwLzty3Aj8C890z1t7V5UwNtQ0pDJigJKz0Z29FUl5l3wOmA5JbMUfGT7N
	FdWgvcGa1QUBA9nPoTBUBExFsIKZa168bKBkD+/Kbvb61THl2LIO81Wt4fgZurnTk6tmyaFqgjj
	1Nyyz3eIjHSEIBaRb5XjoK7/mdWOnXAZsCthV+dK9d0/BtMy2rqjvovkwFpMdUeskNEQLuAWJQ1
	iBqix8tJXUQGP+P/U2m/FKXjqnqCGTsD67xzu8KoA5QQWJURsnrSb3ZxeGaihv4BvoSPZNO7mog
	dnb9u9i8VvvXsGFDrbbREWifuQ5YzesZZwJNYIUIXT9kFS7xmECp3qdfTygOulHbNkN1hpcppNU
	Il0DbKnl8=
X-Google-Smtp-Source: AGHT+IG5UkC0QGFsgQC6zols2w14yKAcFn7CwlpLEfwDMw/WDj2jHgyd9t+DzcFoZnMMrYVZj4rXrQ==
X-Received: by 2002:a17:902:e741:b0:240:7753:3bec with SMTP id d9443c01a7336-24479096669mr14932305ad.51.1755306298880;
        Fri, 15 Aug 2025 18:04:58 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb09ff8sm23934795ad.50.2025.08.15.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:04:58 -0700 (PDT)
Date: Fri, 15 Aug 2025 18:04:56 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: test the napi init state
Message-ID: <aJ_ZOBnknmewrxNE@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250815013314.2237512-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013314.2237512-1-kuba@kernel.org>

On Thu, Aug 14, 2025 at 06:33:14PM -0700, Jakub Kicinski wrote:
> Test that threaded state (in the persistent NAPI config) gets updated
> even when NAPI with given ID is not allocated at the time.
> 
> This test is validating commit ccba9f6baa90 ("net: update NAPI threaded
> config even for disabled NAPIs").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Somehow I missed sending this out with the fix series.
> 
> CC: joe@dama.to
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/napi_threaded.py    | 31 ++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

