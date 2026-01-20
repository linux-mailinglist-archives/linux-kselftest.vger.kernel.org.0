Return-Path: <linux-kselftest+bounces-49440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07ED3BEE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 06:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FABD4E8532
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 05:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F129BDA3;
	Tue, 20 Jan 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3IEwoyn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB91500971
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888301; cv=none; b=T/xwoOM5exE/L+2unO0ioM7GOumTsKis9Zh7tTaXh0+iVPfSxtl9rQLjk5yGELC7TbdDklAAt31SViru2gI2mok1jha0RiEYtivlqehmX9G0g2U1/BVperp8uKrt9zbFFXkN3kFZkYyJnl7v/+h0aKFI0IDnR9JnnNdBkfMRn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888301; c=relaxed/simple;
	bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6BK5fvGCHdmcelUwES/eK7gfjbbJIGpp+Qq7DHJJCva5y7xU4hkkJLKpGSlG2NDrXu+OHVdgYueP9F8sDOshI9/Rh40Z1lNr8Jclry0W+ozSPSTT3msy5OGihPrl3YnxDNCU4qAn8TW6NHarh+Jbc9smUmpW/jqssr4lTwx6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3IEwoyn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2072621b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 21:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768888300; x=1769493100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
        b=A3IEwoyn8DD8pFl1pMLibT/Rs4n8WnhD3zl7RxDwku7vj4lO2Vhoa6dnPKvqqvCpCs
         8SGoXusaBlzn4ssprJnA2xS2vbXisoJ/yfeafh6jLq6HlR5hU2kSK576hkP/ZqHaLpm4
         Ba/L7Fx0r0etTDOGHmRgrQ9Nw3nhPPrMpIhBTUoJatwFdG0RgSDAInjbGG79uD8W3Z0e
         gXSgFWJOLUUR9Szi2ReBmEfgNWnJM/r69HiXGyyqnKb/2DpKyqw1lH3uf7Z+PBJ1Q2Ia
         Do/y8IhDRAKfgdfhKtMPl3EHgRuLT8IJmGfIrzAMIq8Q5zVpu4HuBY1T86kdYVuTPTAh
         CSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768888300; x=1769493100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
        b=A+frjegnuDTdzhBwZwSI1tajr2OOL7pg5kjcJcuXPDAo7whLO+f1lRuY9vriZpRYnS
         yog9Cdsq057wKEiFyUBsIqMplc6BmofI4B4fIUTdBKsf634pgbXbAS8K8VOPHSzPnoRt
         yaeq4F6FvnIgWvl8uqziVBlYjL0CV0Pgzpky6p4bR/zOGd2/wwV+vNfKMmvEIGRES4sN
         0AyqSyVNxGgzpXeUDT72DZ+dyABy19RfFiY16dGmEVrQHkb/qDQgjC5Aqp0tQIYB73AT
         L+uIX3mGlfUf9H2yRF54RkFTWf0oKWXyPl5k3qV1ciCjXrxrOq7I3x5xsYqrYjshawDx
         a2EA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+/IklGW95FN/ydJ5vP5uejgZXr+bSklR/7jetQdJ2P4eBezQV7Xdqg/RtbdlMRTagV8GyFGdMV8RIi+XHxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3yjsgJxK6h3rWYuauZiRs5Ojk4G4ZWVYhyhzfeXUpz33hL3T
	tbNyCCB4Rkl/afXEd1ZIa8KzLA9ItzDV5z6jk1AswI6LeEKVvqzg2YzS
X-Gm-Gg: AY/fxX6tcIIXHVQWdE4TxMb2JPLjSYBO/Q6jLd1BxgVGZyLs7668cCG4k0I3XtEbyN9
	gdRcHR8L21PTrPHjD2uMZoUxzp5J+I0kNBVSoivY6YbE35uKCq4NOeGXxZEgBwYAsOAv535nh0z
	BrIUElK8qls6l1LpMxLdIPxIfFQzPVgFxlTaNpKiD98XddvMfv0tckC1xu0MP4+l6u+PtXGC1Ox
	EhJuORybat9dPwuRaVrM2NLMRa1c1uBlGSOKBnVdMYukKex+0CqZ+MkyXWeoti5ooVlJb0hUlaC
	X9dQ/Br7Uihn8jJ2nIAUTDaLPngHdkMMWj1M3pDapdAPAsYwadtHMth2wpp6AqHDEFXmrxsEwIf
	Wz6b+XObB+oEvhRB20iXL4ECa0rA1qLoSEpeEqHwbVZHuVTN6kvb1++bfI8zXYn9xcpgMvt9SB6
	UY0Wj0DuUZzbrWYRA=
X-Received: by 2002:a05:6a00:1311:b0:81f:521c:b645 with SMTP id d2e1a72fcca58-81fa186243fmr12972958b3a.51.1768888299943;
        Mon, 19 Jan 2026 21:51:39 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12784c3sm10829338b3a.36.2026.01.19.21.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 21:51:39 -0800 (PST)
Date: Tue, 20 Jan 2026 05:51:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Message-ID: <aW8X4xm99aWK-W1J@fedora>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <20260114064921.57686-3-liuhangbin@gmail.com>
 <20260119122203.5113b16f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119122203.5113b16f@kernel.org>

On Mon, Jan 19, 2026 at 12:22:03PM -0800, Jakub Kicinski wrote:
> BTW please make sure to CC Nik (based on the Fixes tag I think).
> Always run get_maintainers on the patches.

Thanks, I will keep this in mind.

Hangbin

