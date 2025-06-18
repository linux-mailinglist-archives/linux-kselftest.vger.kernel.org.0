Return-Path: <linux-kselftest+bounces-35251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E5ADE4DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68663BCE5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35627EFE2;
	Wed, 18 Jun 2025 07:51:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21945274FC1;
	Wed, 18 Jun 2025 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233080; cv=none; b=SU4yr5Xm38xfj/HEOUvr9CrCVhXFZAYWBs1a4niFkLsAcnIpmDxzndwDPI9+5OIWhWQIvJAiqQCE8TAmiaSKKkjcHo7HpQ26cZDwWpYf2NFllAw+/PEw9GU9cq5frBahACQJPkH5nQ4DWPf26xLgMcse/rvPyIs0iSJTIg3U1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233080; c=relaxed/simple;
	bh=rAfrW60BLN+fDfYASvZhfQlbeXXKoxyFtavzHgjUXuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEn55u8q6u/ca/OcI2trQ7pPVzDyO9XFTvhIjugxLntk5b/bxLI27ElcCvs4dNhEcn6xWeG8vZsRWZ/F2bLnD65caUvt9rr90Pq75oiWAXf6wONZ96xZSlG8LgpEdoZmoJMFUwh+QQ3uy29Faz3/QlGrTHdyl4dT/yiS4r6OYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso11484307a12.1;
        Wed, 18 Jun 2025 00:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750233077; x=1750837877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Oawlv3qlJ5B14XZ51kOBRIKyOtdglt4ohJphGiBj4=;
        b=dqaVDwwweU2tHiG9Bv2WqCV3TtKQnbWylwJ3WjhXG8XJdi2Yr6w3IxxXGmGih1flop
         EdXxE+1UtuhOHXyLeMolprIF8xrCEPKpwtPWoxbYtIFJEyQ9Xr5EWk7IOVEz3gTzkwGC
         lh4FHUVvPpkBOcwjfaiE5DbLEzDloHALF1BMojSu1ILX1lVV1XC7z770P1nUsnqfPAaK
         +lN9gYdoK+N0W6H0DoHsXjv6pjyVeR3AGgQ5M8wIcF4K09O9xqIAWJAEgvi2WR399pVD
         CSuP/ETq6ALCU/NGZAwvCh09YprT1QTGVEdxOFj7busBWB5abL8M7mX0xsb/elwyAIwD
         BSiw==
X-Forwarded-Encrypted: i=1; AJvYcCV6nBc54X0BNqamileJV78i/upr/mE918cXc1APG6hqRoNUpc5bO1hn6H+fAk4Oq2hyKFuyf1KDJvo=@vger.kernel.org, AJvYcCVY0s0xdgoqdifsR7C9MtBJIN1weaU/ts2z6zIVSKIxbvdkz1csHeaa1cdX2ptuzgu5bfHqOxVR@vger.kernel.org, AJvYcCW6TSERJJ33aCC3bq6bdbtVkMY2kpp6iQIKRjqO7XVuQK4+gFjJp6WKilbP2JpouCiAGIN53yaIfBEuv/6H@vger.kernel.org, AJvYcCWRxUGseCAHX2p90aXPv+fihsbVs2efZpg3Y+ypsFokZgDBmpyxwl8EmBR7osfN80he8o/K7K7S+khAK3g9Zm6n@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/JLZEoNXSHquKgYXwlRI8CULEkWtsd/TDS/F5zyVsT4UhQap
	5RFHm/xUf5sUgnms3CaLR/xRMIhcNAAH2TvBNdfXRfEHnnCbOvNUK9RG
X-Gm-Gg: ASbGncsVP+1ORgCdlPbrtWJdRdsIQAvJCwD+UvitvFkOKF9ety/gw6+6LBkOCrSwMoe
	ALH80YedVSOAX5wX5ay6F2iMWQgR/iYz1IfCYBXqoEYyyY6BPORjYLJiI3mde9UNWIxRrKIwy4i
	gyxHCFx70gBCEqkxcRPVS2G1a+E21NHLIMNJuv37P1LW8abBz3C4gTw32/d3NYLV9T7Yq+w2riN
	o8cZwznKDmH/6sff5IRzmywkL0KaZo5WmfSI4SE76jeCDvQ/EQethP9+JsbF4KFh8LmhbwlidXH
	G4ZW8xOpdmSxI2QX2r2kh3aCxy2/Fmb+cCOW5Gy7BJvxbdnEf77W
X-Google-Smtp-Source: AGHT+IEROA+4lveuN1ZdmzI6YFzyyJzoc5RM1e8Cc9lT3Mb4GkQQtqkmyGFKaOws5hWV84IJgQt/FQ==
X-Received: by 2002:a05:6402:5188:b0:607:f55d:7c56 with SMTP id 4fb4d7f45d1cf-608d097a0a3mr16221027a12.25.1750233077168;
        Wed, 18 Jun 2025 00:51:17 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a92ea2sm9265967a12.60.2025.06.18.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:51:16 -0700 (PDT)
Date: Wed, 18 Jun 2025 00:51:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] netconsole: append msgid to sysdata
Message-ID: <aFJv8gGqCBZr6gOb@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
 <20250616-netconsole-msgid-v3-3-4d2610577571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-netconsole-msgid-v3-3-4d2610577571@gmail.com>

On Mon, Jun 16, 2025 at 10:08:37AM -0700, Gustavo Luiz Duarte wrote:
> Add msgcounter to the netconsole_target struct to generate message IDs.
> If the msgid_enabled attribute is true, increment msgcounter and append
> msgid=<msgcounter> to sysdata buffer before sending the message.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

