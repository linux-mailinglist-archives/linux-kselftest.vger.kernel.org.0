Return-Path: <linux-kselftest+bounces-27364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BDA428F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A7A17D0D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247F2661A2;
	Mon, 24 Feb 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bsh9uTGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5D26460A;
	Mon, 24 Feb 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416372; cv=none; b=THSOvo+Z6T2VKnAQl2K2Kx3MF0tB8TMY6754eSQ4UVVFmVyC59EuMxZjyAX5QpONoQIk2EF6rjuBztdMV9WuVcreIoiU8tbdb88k8kumHJG/6jHFYcjR30DG+Odyyurt77D/wmrl9d0SySSVCOduarQYGlZQUiarPV8RFyiknt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416372; c=relaxed/simple;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0VbBGGsZvgtUfAYxG6nby70HQSvXaBi4BHQjP1mlMXUQIQkxzwFkVBac4iOgtJ8bMQXCNippMDuQuLH0DXjP+oW49l12KhijoUPKUOyC6e37R/oHYIgB34WpuGry7T84wodL8aeZ2r9rLOR6KFSMAopsj4pb3JQ3+700t6NAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Bsh9uTGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE5C4CED6;
	Mon, 24 Feb 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Bsh9uTGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1740416368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	b=Bsh9uTGiYhe1o8ZXOSqrPFWBmXQ1xZ6i4iCW91bSkJCVhH35s3W7gsgmJA0/fB2w4dJJ0f
	jP2EMvnZ+zb0edTKNfba/gtbAuc+7d5nvexXWfUqBuaUwH9qGihPM6xFppbLWSyCSmV5x5
	r05bEMj01G1Thw2Trn9nB15iq/P4CrI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 022d9860 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 16:59:28 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f422d6e3b0so922832b6e.1;
        Mon, 24 Feb 2025 08:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxl78VYZ7bKpQ3dq+RHskNJ9GE6cuUmfLjhr8IrPXlP3V8DKtsHJqyY+RkIfff6UvbF1TjGUp5H3tjQS5IcaLP@vger.kernel.org, AJvYcCVB6jifDnSHbqvHu12VmpCA2rQhbP6IXGNux/CpeAtW53L8G2ISw9DrMbpg0eemClJrRj1iPdxS@vger.kernel.org, AJvYcCVVzMzFKdgSNT4/b6oxv6Y2MxN4nq8cM+yGXPXNBA9uZ3uosGW+Px6y9yyuGn6mA5iMJaExopCKs8SQKbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyv+i+Ac6duGTKPI5R8XNDKlBuAkfTbWJOURAHEig8fweJ0oGj
	JCr6BBeXPlV7ScLTe09IpvWAk+h/45XAY1MakjSf2DqV/KWrXPeiHkJjqLAU1JQscQIZiLS6AvB
	rRrVOhgm3+dx1F6BkwRt2Khq3zVk=
X-Google-Smtp-Source: AGHT+IFtmDu5uSUGW95GD4oZE/+yQz6eG0LBmjYl0CcxM+BcvKE8kMWJ+nIwSVZEE0+psbkqclZn5gJikjdKQrHlg3k=
X-Received: by 2002:a05:6808:2e89:b0:3f4:7a9:7bb9 with SMTP id
 5614622812f47-3f425a7e72emr10406901b6e.11.1740416367403; Mon, 24 Feb 2025
 08:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6945896DD80A71BD+20250224041238.45039-1-wangyuli@uniontech.com>
In-Reply-To: <6945896DD80A71BD+20250224041238.45039-1-wangyuli@uniontech.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 24 Feb 2025 17:59:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9rGjwFKMhpAuWxNerRc9_0068d3k13n3wxZ8BwV_EeMHg@mail.gmail.com>
X-Gm-Features: AWEUYZknNUYzGad3f0Uq5YaAmoyWIrddgaIGfC_iv0ceh4M9u47CYY8wOZTJJ-c
Message-ID: <CAHmME9rGjwFKMhpAuWxNerRc9_0068d3k13n3wxZ8BwV_EeMHg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] wireguard: selftests: Cleanup CONFIG_UBSAN_SANITIZE_ALL
To: WangYuli <wangyuli@uniontech.com>
Cc: shuah@kernel.org, horms@kernel.org, tglx@linutronix.de, jstultz@google.com, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com, 
	chenlinxuan@uniontech.com
Content-Type: text/plain; charset="UTF-8"

Applied, thanks.

