Return-Path: <linux-kselftest+bounces-35233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C3EADDC5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC91940CE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164D28981A;
	Tue, 17 Jun 2025 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Wa04klLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6223B60B
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188760; cv=none; b=AKUFIz9pJKnSwpOYoyp5wYvNa9hxN+wCdnO7RtB4ODdG3Ct1/n98fhq5phFI5x3jiFRKDzdkCayGSxY8FXYF9istE7MKxhkuXGthsaN/GhnmQjmdfHhVhBPg5ke4VR1kocbo2kPS9p0vNgYbvLSAAGEVGKyHofpKZbDMLUQ83z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188760; c=relaxed/simple;
	bh=maosBMqcEUMS4h2mAKWow8LWfPYq+6TS1PNZ4TsGvMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8NDssD/BhHmBz38/wW/A5UxFVuArrbPKIkJsY5YuS411dGiatqP1C/jjm2CXjFEZd/G5ZJ4qNaq5n7IiCGB4Bw3c429Sm3aN+KnoR4KA95XQniJE8sYlPs75TPWkIlw6AyWe4KtCbNI9+xfik0TKw6t2zmAOiu1eY95MZZnnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Wa04klLd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so5042211f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188756; x=1750793556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2mnqssJBMGEGZ4yel65uTxyhzurhDZlVcPz9/ChFNk=;
        b=Wa04klLdkmQ/xKvpWT52JECt8nLb8Z2fpNzWpRZQ82JEo/gQS+yLjDcQaZh3JHCkRm
         NjpzUUNP060TMA3a6eXE5nG0ImgrtpJfwEH1RjgETk2pPwwW2TGEf2FPHjecabjxq/Ga
         e1rZwxZP0J+qcsfGN3w8j24ygU9PL9V87Mm5MbQREU7u9BeFGhAWHpKY21HgFNTUMK+o
         CTQ38tubaUTNE7ZxWVGcamDhxu5n5Yb2bfUJ6cwsg3cqlerL3MUTUCTqsBSbR2/I/cXi
         n5FoWoH7SbiP6AOp6zOz84ceDKICzTZDF9DmfHrJp160Or6wgIp3jTJ73tSTku8cnUpj
         f7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188756; x=1750793556;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2mnqssJBMGEGZ4yel65uTxyhzurhDZlVcPz9/ChFNk=;
        b=xP9EuqZAhwj1Nnm9xRWgm/y3xCMVkj7aYlDbiae5gFBg7xcx9UTLYJqwKDnGAL6PWq
         F7XgvX3/O3Y0+dX9IfGBbFM90EMRBQoFNdzSM6uA5iOZYyxV4Z1ZGAuyJVsaP/qQx2Li
         mo1WXJSjYp7xhIT/sJI1I5u6ZUNcObqEtWp0jWG9U8a4qrK62PxhDnxRnkPOYpaT++49
         spyLszOPc/2HkoDh3Pz6IWv+6+5yVUBQpZYCxVNYN2QEtqnBe6tj5IJEy9iRjuqbyOZG
         Xxl6AS7l96RIkhjEkqpI0KHHxVu4t9BdYT8g1xQWfU7jTOEd60hLbGvT/keDE/C8bqvu
         tyeA==
X-Forwarded-Encrypted: i=1; AJvYcCUZrLkndpcZ4acWiDDk5zSR0jEBu+vpUd/THDacRjjtQZIiEVeVUujbuUbBi1nsRdhKdpieVo5x13xu1QxtYF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdxhkV8jYok/8ZzsfHXSum27lGeVQMmBgbZ1NqASEGQFqf0d3
	mfeMhdUEsi5xGLyW0BkQX5JmkoW14Enxj4LuCX5EK00+TB+qLBVsOXn1Ay3O6xSFr+Y=
X-Gm-Gg: ASbGncvfKoOuvIhhCT8JPsfqcmYeI+A8JL8RW079utTXorTm59xcmzj6tYyg0np2I0B
	SfyPv9TR47tJbwWK4Gg/q7XyviOf6lu/3YzDsMCpShhnnpOqgid0/BXk1upJcyvmdhgfgb3wLYb
	FAvFhpjTWYqAFv2lYDvEwPYNxuw4qv2ZHGs9uESewmUyoEAb+owRjL2HOgRAFOfiWIJoMp5TcFW
	LUiUI2+3kMvIX4PNYkTMB4+7ViU7BoMUJICfbVGAnD44hkTtLAaiT5Dn/PrKRdACJCBmwtc54Mm
	8oIJBG7cCJBjQ1geUVZrEcAF5JZF8Gzi7FUQFMbNtHVriYVuJhd3hQN+zFD3BFH9iZQ=
X-Google-Smtp-Source: AGHT+IFvX8UDNBBi5DC3/Ybdm1840HegO6/7yt18rWlEL7Zc3/qU8HDPT3MpH4li36+sH1FH3nFgGQ==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr12226086f8f.4.1750188755945;
        Tue, 17 Jun 2025 12:32:35 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6389esm14585247f8f.27.2025.06.17.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:32:35 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:32:32 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v3 2/4] netdevsim: collect statistics at RX side
Message-ID: <aFHC0AFQoJ98Xo2A@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
 <20250617-netdevsim_stat-v3-2-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-netdevsim_stat-v3-2-afe4bdcbf237@debian.org>

On Tue, Jun 17, 2025 at 01:18:58AM -0700, Breno Leitao wrote:
> When the RX side of netdevsim was added, the RX statistics were missing,
> making the driver unusable for GenerateTraffic() test framework.
> 
> This patch adds proper statistics tracking on RX side, complementing the
> TX path.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Thanks for moving the RX accounting around.

Reviewed-by: Joe Damato <joe@dama.to>

