Return-Path: <linux-kselftest+bounces-34298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D5ACDF67
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9022E1658AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A028FFE6;
	Wed,  4 Jun 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR6JecI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401C28FFCD;
	Wed,  4 Jun 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044363; cv=none; b=UmXQzOETbEzoaROyjAIg59pqxGcBuRgteyUgR35uJXTqYEWlWx0wyyx3tQMChWEmHJ/FlGKw4LAihs0nYmNBCdrd8GAHuoph7P6eIJOYlYU2+l1MEdBhsUEjcfuGE7r01JraXpzTk2BAuU7SvNsao/AeYsiAPSbmLS5q8/Tb5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044363; c=relaxed/simple;
	bh=Ol1P+2wBIL194NxYgULcBDieqS7zCToAfy1HbdBFgRU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GhTwzQDBobNe2I00yym7jEwn3x5KuF9WEYUgc5cW25ZcbmyT9v81T62H2t0PVijioKGmLqdKXRkV6g6y0xGv0zKZRkr2kP1dXqyFp8nwOn0aRq5BcsFZztXkwKOcZgxB+GGOEtXtMzNZvoz8GLNfM9LQXqhoYNwJyYM3EZRg0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR6JecI2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e6bddc30aso62271117b3.0;
        Wed, 04 Jun 2025 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749044361; x=1749649161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC+rEZEkFyNzF5RGnxbQD57hLniaWRHKQEFbtHBo84w=;
        b=dR6JecI21KRE4oHUHk29DqT/ZcHloasPlobIOk0pSEx7RiqlS3A1st5XWuEG5zvQzD
         X0Zp0WL8uW2X7n7vyhDbzGNr1KdBnru6Gxvq6YDcXdIFp7J/OGAGzAnx3PZchn3aikj7
         CMrzVCAF6PYWwH38hB39mA8pVjND7tRhl6YQzOsdhTX4U0gpRETxNYJqeACazwhWgAg9
         URzUNU0Fmxe7Q3AEVNKwQxaHZ+By1Z3zD+d/kIqogFxewxKPCkruEYxbTff9nbs57wqe
         TuB+eUKmw40lN0Holv/DqZaRkYyzxecwna/8l7Xm+eC4rOTkHCitwk3sT/6fl2Segfi7
         7r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044361; x=1749649161;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PC+rEZEkFyNzF5RGnxbQD57hLniaWRHKQEFbtHBo84w=;
        b=DfQZJHQDNx/SwsxD4w2YxwMBkZO9eqpc6Fm32CieIWk4bBS4dT85GmxpZUhDR+0CFg
         f5O23RezHsNcXEUL8movC3TiOJh8OG7y12x8BPz6HxBqfb6tFP+dAVOKExj7mQ4ZV+ge
         68hBm0OOqJayrQgcspGbWDFrgvlBWv5Zt0DObrNrwrR/xsWiXgCDFfadp0qk93GVl8os
         yIvxGSz4Q+NI5J9pZtjqxPjgOltbwAyEjMwveC71kUuguvAup5KI2/8wBo5Gu9dlhYrP
         5ePIWMKnF/A70vSZFieQSjfPvisR7J34K0iPv4vvV86oe287cipat/VG6eav/o6UoVkT
         bRPg==
X-Forwarded-Encrypted: i=1; AJvYcCVVor0mQ/qPhed818P45yfcjx+7wvaFxTtT2lFB7EEmmjNK/Rc/9yQwW+ui1s1xVd1rY9UK10qPzBRInDgmF5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3+FKJ/Pw2nn3Q5MST2p5YpxBFRY0uqsfDSIwQkz4O4s5BQqR
	9y2A1SdQ5Ut7gF6tQ6x5EXWCl0TjaZUuuC1KbSY3ro3B0ftuv48o7lCt
X-Gm-Gg: ASbGncsNweUAiDaYmN7WiZYQ9uAA95kTCvRn794cmJX/Em70UnMoHO5j6nNEIjj4QRM
	jlYOzGX5tvpnE8MR3QvqMKBBy3vSK/xB7L+Dahef16J+Z5/2/2wyn/9VwCcnTuB2/lTWR1IRFJY
	cyzqw6nqwjQsKcAnIfhixSEmEEByh7n06LBbuLqz2NJDKBG0C3osxsF6xx6AAIeSCOJF+uHJ4Vb
	2oPPcMf68js7DL4K6s/r3agb3KZoyspIw6ekRgTkHwCJzvdR4gzqURrjAHbt7cX8SDI5VpKR1Pw
	cfsh70/Dde2pSYG3Y3KCiEqvvdUONDts03wSRjuPNPxeUFlZoxseyKaRIUinnkwpZL0QWtw85kG
	vgKTJtDBwB3EMBTv4+Mt3edc=
X-Google-Smtp-Source: AGHT+IF05R/RUpXOCcDBbiH9wnIoG1/Rm1gSoi3qFQWXGoOMrwCsUsYNpPUiNKBm8CHlv4Gnmoz1ww==
X-Received: by 2002:a05:690c:8e19:b0:710:e6b0:1688 with SMTP id 00721157ae682-710e6b01c61mr455107b3.14.1749044360719;
        Wed, 04 Jun 2025 06:39:20 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710de73be23sm2041347b3.43.2025.06.04.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:39:20 -0700 (PDT)
Date: Wed, 04 Jun 2025 09:39:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <68404c87d5090_1e99f529455@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250604012031.891242-1-kuba@kernel.org>
References: <20250604012031.891242-1-kuba@kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: tso: fix the GRE device name
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The device type for IPv4 GRE is "gre" not "ipgre",
> unlike for IPv6 which uses "ip6gre".
> 
> Not sure how I missed this when writing the test, perhaps
> because all HW I have access to is on an IPv6-only network.
> 
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

