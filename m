Return-Path: <linux-kselftest+bounces-5018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3785BB07
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 12:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC761C24775
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864367A13;
	Tue, 20 Feb 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoGSdgLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AA67C4A;
	Tue, 20 Feb 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430038; cv=none; b=rtc6mDVyYkdeWE/jevzN7YUHb68HPV5ATmMTCjGrgUr4ayQMA9kDSAcMJEU1tHZxP/QKrMCduhk98UiWH9rq2xs/s6LS5nUpoXqKY3JrDfC12vmpm5cUz6l1qPUQYe/VB55qPneuHSwmV8LM84dOBKPq14xeA67Pe4wDQebP+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430038; c=relaxed/simple;
	bh=LJPa/9V07e+LPEX5ZQTYTiIo6v8zJZU41X6xs2KJUVs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=T2FyrY7576IySFowldx37jZRTdGWpFktFThNcW9D6P0BpcsKVqOgdYpo/pAUMtMK3NX9kdZKlGsUZf3yPxQoJoNGWIo8memF7cUM8C/f3hmAWV7dy+oNrHJkxBC1fMJSnVSnBHGsTvMkIoGu08rspT/cnFjZSS1DTyVtA7RWTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoGSdgLa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1ff697f9so1551805ad.0;
        Tue, 20 Feb 2024 03:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430037; x=1709034837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJPa/9V07e+LPEX5ZQTYTiIo6v8zJZU41X6xs2KJUVs=;
        b=FoGSdgLaolnWAcA3rHHW7RUIwD/3qAmetbJtQxTrb3XvRJCl7zUC2wFa4rFuNS19UA
         xVGBTov592l33HltM6V8qUKRNmxGrnK2RXa6DLxUlnsJL0OFFP6e08x+HthM9/qDTcso
         0Kz1ObnvcaZeNrXAwgFIIw9COrGJSGlHpP82fxhbgbJvftsrRYGSfT1MOC8hbklRrzxx
         baR/+z8LefxpzBwyffEBNsKliuN6SNzJzLwMzmZy84oUkwGsVc/skAfevfsFBvn6j4DS
         LPD//Ic9tE2z7uEyWLtVgpVFGXN6tk3Slrb/XIDVrRk6cXM/k7qILzaW3hEj4pnpxR/1
         pD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430037; x=1709034837;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJPa/9V07e+LPEX5ZQTYTiIo6v8zJZU41X6xs2KJUVs=;
        b=K1+zQB5ngRx7TISN2bUYMuSBgadgdUVoS2+FVFqeePBhfg6RIwvoE8aQbpVjgD0sBA
         Wwe/Uay4/7TJ1ceNnqK55pTKcX1L14mDEslmurULRRcpAqZwTO+HNPPEpCsO5Z7LjmYh
         +G8TFUWaCLCU/ZnPuCjcu9K1b6y/UOdlpxr9kSm7upo9fSnb5uLuZJ/s+9/qlUhu9kxr
         N1b+lGENlK5PFqKOJSms9SzSiyuwsRQ61uqoslNpOQrO5HQxYy2gTsVz25I2S9i9rOZx
         tyXcCSgWIOCsEhK4AdMrx0r6jAuRsu1f+B+r5frUgGXAxnXoTUdX5+/INAIHF5DJDJgL
         TViw==
X-Forwarded-Encrypted: i=1; AJvYcCXANn4M3uVgnOtmEuES/MN/2HiuTrv0H0tt3Iz2HRLgEA454wUpCXZw2NHKiQIMjLwWALe/SmUIHsCtTFJz5EQjxquLuUNa4fXTpgaXmVqiPTkEK1ZexL85dQ1/FeAFMmqNDyfwbQ7I3NRyh0mGpvFkzkyGDlA7w/f/YNFuy73JN+wBaMeQj3qeCApMpQ==
X-Gm-Message-State: AOJu0YwRHLplAy1nvInHv6ZooEB88709qvwLvJ1I5AR6feAuTjiH4ivh
	VJiOedpSMOYaT/0U3SolixFZryJrwLgOKkB1Zmee1QGywsgxiHFG
X-Google-Smtp-Source: AGHT+IFVczPjZ3sA7Vkn3GIlucnVUfCub8lnJ1ZtP+taqizIDPQ0ngAchr6ezAqG7ZANfUXyDG2yfA==
X-Received: by 2002:a17:902:cf01:b0:1db:aebd:5e2e with SMTP id i1-20020a170902cf0100b001dbaebd5e2emr14377731plg.28.1708430036655;
        Tue, 20 Feb 2024 03:53:56 -0800 (PST)
Received: from [127.0.0.1] ([106.221.232.187])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902b40900b001d94c709738sm6021665plr.217.2024.02.20.03.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:53:56 -0800 (PST)
Date: Tue, 20 Feb 2024 17:23:49 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: zhangwarden@gmail.com
Cc: jikos@kernel.org, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
	pmladek@suse.com, shresthprasad7@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org
Message-ID: <4dc04319-8f4c-4159-a6c8-6b106a15305e@gmail.com>
In-Reply-To: <FD18B42B-6B73-4B55-A9B2-272414531C26@gmail.com>
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <4dc04319-8f4c-4159-a6c8-6b106a15305e@gmail.com>

Looking at the function definition now, I do see that the function returns a struct pointer but for me the compiler still complains about an implicit conversion from int to struct pointer.

Is there any particular reason why this might be happening? I couldn't quite figure it out myself as I am very new to working with the kernel.

Regards,
Shresth

