Return-Path: <linux-kselftest+bounces-40828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26CB45657
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D384A0570C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3B342CB0;
	Fri,  5 Sep 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPVamrkN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070B342CA2;
	Fri,  5 Sep 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071655; cv=none; b=IoxyR2femD//UmYRoUMYQMapX5tsWEUHvS6e52TKzDjVWZc1B9pjTDDBMcO+JOfpbTRa0uIuq1H7eSxA/lzJy02A+q7mrysEByVR+FCuypvMXKQbkHoiRa+IvNZKH3/LFA+Htav+cNiwoFR/aFQI712om6E1K+2+jCwv7ET8IAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071655; c=relaxed/simple;
	bh=k6gca60XknWskVVSXPPicbnRtDYnJHRpylugD57BQY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPdmLToPLMaZH/6YDtkMIi5cZzeqDqw0VnHIT3nquu0yzTQUWpFnE7gOsaP13J+E5sAp80S5n6omQqNJ1XuTAA8yNKXA8QdpZDDZeoqpo3hN9ypqcDTcGDxCc+2x8qT37XB+mTufXG5GeOWUBwxTllUX1pb9LmlUS2mMGW+f0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPVamrkN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so14604875e9.1;
        Fri, 05 Sep 2025 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757071652; x=1757676452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6gca60XknWskVVSXPPicbnRtDYnJHRpylugD57BQY0=;
        b=DPVamrkNEMo/USgU31O5WWHhJ+beEG0bna9raeC4dzs5IwDIfT9K63D+jYrgHhh5j/
         RCxsxaGNfeXrS8+ChsVGHVYoJ10AYYNut9UiK8wmCwFdEssEug1CZxTsW4ga2NdcWU3h
         eButk/IDaHI/+a8B4kr7l85aJXClSYphPw8Jj0PuVLVPLEGL0TntulnQLTEDRNPlc8AB
         uqyaA4UULerwHfN7EmetHm9O+/eCaVwVvTAYxj8NC0S1HEQ0ws6+Cg2e4xgVGwdCQokP
         YvjA3kc4tLpqweQPiJwbhRNwlvijjnV55TWFQM6G+Ww2Idq0VZQ6xmFVHM8bIUVQBS2Z
         Wsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071652; x=1757676452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6gca60XknWskVVSXPPicbnRtDYnJHRpylugD57BQY0=;
        b=wo+s7G6372Ork5QYHN3M82PoBSiRtmr1UdfMfg74oLUht81jR4dg2CEaLlm5y9HN3p
         NPH75kZr0VXBiDUuquI/mFq5JU8pxtLtut3ONJV+BT7Qm3b+gccelR/rn56IZ/9KZJ38
         kNubtgLXdGdRyPNJDuaHy3aYmQFiIjqGHOzmDh1f4o5BVlqzHvRLCDiGY6vE6poTARBT
         gjt58ZUmztqT3K8DWQDDEbCM6sWeJy5gSQWXZpb+r5OJEfJT/E0ORTToJVqz7Z5XpwQe
         /kaeBfM0iaCJ2993UzR2YW6ouymZmM9V4GtJsS4BLwOV0UHiLpt3/X4wlHLBNUsnOUfV
         9lRg==
X-Forwarded-Encrypted: i=1; AJvYcCURHIFVgelGvr+qd8YEHripLjFg2KUB+boNX3B1y9zMEpQmK0KdVrIMhYnjBEG98dSvSXfi73NE@vger.kernel.org, AJvYcCWF+jbsvnR+aiw4+QsKusHnNY36DUwHhqFYXG0QGooYL/Zmr4sqMRkVIDtf/IJz77DZbTt9hYvTioLLuxg=@vger.kernel.org, AJvYcCWgNn3ueIRo5H7g2n1u+jhT3Zj6g04yOHmxQ5GNJ+NqXaKAV5WroH/BUEapjGMZWHBq5OZWHqE35uP0YPNm32xP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TowYkqse1SUax09biZXw0UyErVbqbZGAJPSmmy9ZTLEE4Ig2
	OT1vGSxiOCVK/lf/ojmT1w9UmmcCsPIuKgY3LSyVwd8J5SeMlhMT1Hzr
X-Gm-Gg: ASbGncsp091bGMBv84e+qhXQr2b1WXtnBcrqaFmejPg1XsZ8mqk/1lfEHzTs6P1b+8n
	EWbBP13viHpgqMp6AFOz7biM1AnhTaze5/ii35+9eHArP1fTBEFNhHY3bjdXRZgZokSvr+1459x
	T/F2lEigLpgnV4RXKFYT+T6d2xJmf6LzavrNPsHdWfBA5Dh6eU0/1RtLbRuq9AJEBtBJ5VI6VEz
	mxxozxI0rPWDOkOyyC/m8ouaNWUn3NlODB9e2puQMHQBIalXECvxwrSQJ1YFyUKH/PMDLqwjP6d
	YE7V3hG0EoXB1DK5VdKAkX4bh7VbL0hj5R2cKzm9WrATJTUWix97PgbIl1cXdXsYfCvU/FNul8a
	68iqDIx6n4wvhajWt+i8NpA+tERYslg==
X-Google-Smtp-Source: AGHT+IFCwaEkUL3V2ug9ojCoJ94pDdD0UpCfWMbIE+5ocxwbKeoXrjqxDsrGZsO43avkw19l/hK4Hw==
X-Received: by 2002:a05:600c:8b42:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b8558a801mr168825985e9.34.1757071651714;
        Fri, 05 Sep 2025 04:27:31 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda4f2a0dsm18608655e9.2.2025.09.05.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:27:31 -0700 (PDT)
Date: Fri, 5 Sep 2025 12:27:29 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	efault@gmx.de, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/2] selftest: netcons: create a torture test
Message-ID: <7uzltg7ystb5dzxo2r4kuq2spsg5w52eteh2sg4ldcomlxwj2x@724yzzynyfjx>
References: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
 <20250904-netconsole_torture-v2-2-5775ed5dc366@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-netconsole_torture-v2-2-5775ed5dc366@debian.org>

On Thu, Sep 04, 2025 at 11:00:41AM -0700, Breno Leitao wrote:
> +# This test aims verify the robustness of netconsole under dynamic
> +# configurations and concurrent operations.

Just a small nit: "aims to verify" or simply "verifies".

Reviewed-by: Andre Carvalho <asantostc@gmail.com>

