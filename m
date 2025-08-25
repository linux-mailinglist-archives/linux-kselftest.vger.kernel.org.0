Return-Path: <linux-kselftest+bounces-39885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC0B34B2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828191A8785E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CB28640B;
	Mon, 25 Aug 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoeOEwER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5826B08F;
	Mon, 25 Aug 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151643; cv=none; b=d4f/GTyI7VP/QMko/j9+LU4p1lAuDH0aN/c8zlLW+zGizRjqqLb0kV/JKCot6zgBWasZdJb5TutpvhIEhd6KXzscfZT2C3D95YqqwLRdogq2oMo08JZ5HWnKFbzucbNmopf6C1smK5pR1q6KFZWoUVk1kkPciTUxYfJCWP3PYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151643; c=relaxed/simple;
	bh=pncAPkXt8am82BvZrMraZwDvu8s/RK9Sq6BRR53zrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBDdK1qofmmRHFk5xBOD4olTpAswGwhSKsijh9Q2nSQ5RVPTlFrgRRTr/YUonY800w2SEYgS/Y44XOIoa5LdcggZsqdmoSUmpbbZgbS9iNbHmtU1VWvZFKZ4xsQU9tWnjXPvGWW1CTXraKsgRpgkLEPWRGFhSX/tcv6/sY86E1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoeOEwER; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2460757107bso43719315ad.2;
        Mon, 25 Aug 2025 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756151641; x=1756756441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hblcTV6SRi+i2kQ1j/WNk4ZeI9irz/NCFtS96Usun4A=;
        b=IoeOEwERTcleGECFUBx0/Y+3J6AkhXQ4uckSclPnVwMsFo6K62WLpNNgbMIBycPW9s
         2+ROF/Wel7FYM8CoYTnQEJoL6M8OBB8PUrpCzekGfe2xna3vJUSgkdCvvEaDtRhGffJX
         wCTkqN906DprVb9VdphzrtQwPNYRqLvE9uhfUPYb09b/ZFkbeaPgm6tB4sup0YAabnNk
         Ng7Rw/GoHbffS0MPLD84NuTn7kwB3THWuAT5SICHBfTDYWhRpBKlZGhKF4LIVbKeGiad
         GFnnXCFNF+FelPAVpOlcOR6NHwOKB2eel55ChXwIeWTL3ww+9QtfAn5B9pOh7+N0ndqR
         UCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151641; x=1756756441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hblcTV6SRi+i2kQ1j/WNk4ZeI9irz/NCFtS96Usun4A=;
        b=i/QVdcx3e5b6qM60yMZ+wtLp2y7ijsdQe5ehjlkEFpTWYL3KrbzEWXL9AZBFB9ZmJc
         wiRpTwg9aEK4t/nka4rsoKPPbPlKRCox7xpKAIVtN8ToqH8TsX75TDXUnISHF6/f9Zp3
         t7mU0QJHDthmugnCnku1SdQPdxERaSoMZSZ1la0mz3B+2iqoYvV3jhWrTvDKPYIUQL62
         /IucJ6FIrcnpcjg+Mv3MGkoJgy7eDM04WKVOotKtx8KN2Nfd5T2/zyKMKhlQ/+mfNBgw
         W0xvieLym0LwL+uxcJUtUqmp9ZGXJcdbwbHo2IoSr0w+3biK9lIiVZzqx7PqE9dTleSi
         CRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOUcF3+RV96SYMWBIg/9Ksq16IZNDf1GLqh8Pi09YL9ET8Ihb3Tu1o/x42QTHrPRDQwETdIKxE58PU4lG3MIQ=@vger.kernel.org, AJvYcCXs4jgaXVwe82/wl4CJAAdqipwgkEKYkvJ3dEcmsnteM2wmSmgYUPYz+0RcBMQHP1IAkOFjD3d0@vger.kernel.org
X-Gm-Message-State: AOJu0YzHctd4M/8VqghHu6jJMm/WBZLPQD3aOB5L7YnBrSpUC6kEnC/9
	i3woXadtztBJfn7BhC6HtE1EGY+Mg7NdmsfK5lNimKLJNfkOAl8CoXI=
X-Gm-Gg: ASbGnctRzLiX3jTGs2naP1dXi3StZ0ulYwJIDYzhkbUplwMdTJdmTluCo8Haim7Irz3
	k9qKfqQRStmVz5qtyCPfjMXq67fx8+53T/dSKnvAC77CBrnJ6tMxKo6LOolIL8NYr5XilGks88+
	0qaE3LyWWmzBj1Zy3u3ryyaKDCjz9YlGUrLMImC6iqj0l4R3FSQ5A9I3jqFOE+3ewVkWR93yrSS
	gJpiaXBNt0xjRppopheKpDD5A73YKjwQuwrb21owEy+TPhVm87zgpKaZ+wuXgqpBC6DqF824ie8
	6byXad/SoZCXtAZFY0SKPMteQdRqn07NVvuFpPAgBYbOrIGY1MtZRpBQoW3qUHgIfcipkNvrYve
	j39ZckdwGO54tBFCdjnBgPrUHDk3etmC1x8Buxo6QDW0BV3sbUaiDmF5+a52crWtzb90PAZWRUb
	BzF8TqyZ2qHHIGodblVAnrK7mzYPMS+0FQQT6SyLwdGj8+ag7Oo891VhkblKw7VTjMWgxLpxWav
	MZeUEjb/Ej0aTU=
X-Google-Smtp-Source: AGHT+IHSI9Jv0vkVHj88ZxRs9n3Bdir5DaO8ys4HWy9D8pgM4ip5mTtAJ0fVKE+2dWyrIUgE6o1Suw==
X-Received: by 2002:a17:903:3845:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2462edabc8fmr159339055ad.8.1756151641220;
        Mon, 25 Aug 2025 12:54:01 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889dcd4sm75611285ad.158.2025.08.25.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:54:00 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:54:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, almasrymina@google.com, sdf@fomichev.me,
	joe@dama.to, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] selftests: drv-net: ncdevmem: explicitly
 set HDS threshold to 0
Message-ID: <aKy_WJPrwNwOxOAc@mini-arch>
References: <20250825180447.2252977-1-kuba@kernel.org>
 <20250825180447.2252977-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825180447.2252977-6-kuba@kernel.org>

On 08/25, Jakub Kicinski wrote:
> Make sure we set HDS threshold to 0 if the device supports changing it.
> It's required for ZC.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - split from previous patch
>  - only touch hds if device supports it

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

