Return-Path: <linux-kselftest+bounces-41122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07580B51909
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1AD3A3F47
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2292322763;
	Wed, 10 Sep 2025 14:12:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BB1A76D4;
	Wed, 10 Sep 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513529; cv=none; b=DKlp6BrCpe7z08YDXL5B113ueRj/Wdqz19qYY2oEzbFITWpW18B4Sp1d9tVRhewOaXxggTStG1hEl9IKpzfoSbA7dFElgjVTDVqRmox+tZAfpYxTwwj+xg4/E7cW7XrPy1y81vMDAF2cujSlxjUZyeyUsT9gzRJ62zz1Tf7uPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513529; c=relaxed/simple;
	bh=BuH07/Cum8ilWq7fktbOKN73y+hgVGVExicH3rzWbsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKJ6rLd9qJEBLYCQn3iOP8BXQkLnAVrclQKd3TyTZMQr03I08GVk/nQEe0YtMAS0cgYcYRbpL7zv3baPOd6o/1JDpvUMu2qN6OldVhbuDztmNWQ1Kkesh3e/8uYI0y4lBdSK+jgPcMepidTT0km10CyoBswCDRXdtArwff3SjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0418f6fc27so1137565066b.3;
        Wed, 10 Sep 2025 07:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513526; x=1758118326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeRS2yB/lYI/APOxiGv1ZbIrveAk9ANoUQjTZkTU2z0=;
        b=YbfXI7/rv1/ynIW/7Ab1LCiOQSmmaqXmDb3YpjJILODJN6r7uoTjRONFW8vjwiJ661
         cEbcmdeT7tnu3bQmjs076QHm5HU4g0+5yP3lw4j1Vpn7aCLO4t/0kN8DSsMHfO1V2fq1
         PZFu+YOQ9OYfd6kkr/aZEZ5xhUhduT589ZXZCRDM3ZUS3J4c78lRiiVNR5dmZTDUyQDf
         cUVh6KNecGoN+rcw23WJSuLTQJtwCxjau45wWv8uUNyMdF01rhouaNL78Hbq+v0rumIU
         8nS6+2iWojLzKKF+TA5vXPsLIqnsB5pSR1oxmVZI32BgQZGyTpiYVnPcgGUh7nHhvjDv
         seNw==
X-Forwarded-Encrypted: i=1; AJvYcCUaOM5ZtLl4m9z6gj0R+hHar4QG/r3Jvf74wvYGsj1ow+UgFs3GbSoGyBxCBepny5sL3wKo4u7n@vger.kernel.org, AJvYcCVP4t3GM8GPgampVqOfSwp6rH/czsozFUpgphgnhqh1wNRLPej4mVHNZ4bA7f82ULY1CUnsaDWN/75FDZ4=@vger.kernel.org, AJvYcCVYYhniQwhvQOo5Vgm8uD+qDGX/fygN40onQJhvNvDQXzsJd2RlzI/Zgtqy7Apxzu3RAlwfaBdb5WGBM37vTItJ@vger.kernel.org, AJvYcCXukpDQQp6M5fceZg8RiGaQaWHudmSANk2FsnZVbyUXYafD6qPIMt0xUhbA8w/pTuQTfz9mJyeI@vger.kernel.org
X-Gm-Message-State: AOJu0YwETpuPK2zOqz2w1MiWxiCzmpCWCO+IunMLA+sp86NO/zsykoK1
	eRKiQ1TcewJOyyYtK6QU7L+yOLdE9vLV4E9Vjk4A7GUdmukpENvkEXaX
X-Gm-Gg: ASbGncuKXGE6PQcAU+YXCxXpXopWZROX5Hp9wl5xZMf4f0D+zjRzBzoge8fU6/I1b+3
	1cV68DZJlPNAezeCrcmFdP/j7RQBJSzVlTCkfDHPZzYWNf0Z0LKpnEfpEITEl3hxLQVhruESJXY
	wV+PAUsgiwp3UK1PMBZW9HODNT8GG7P9kVpCsXp7h533XsgFkviXHLVOfO9VQWyF/ZWtSwpyXzo
	4LF8FAr3E0NGoGH7U6IToSYYacOKG4QPnokqsXYoVyEriFZGhs9ZUk+VL+0ZPtM4eWQ0vdf+Znf
	7ElXzt0fTfkxtnTK2tIpfNYr81O0pRIH+N8yzi+XS/k6k8l3QYEXFU2Yyjb3cxevNdX4xR6e1Tm
	A3+CVycGg030Keg==
X-Google-Smtp-Source: AGHT+IFmFSyfrWgMwdgHc71VO7KWawXXU+herwPNHRT2RcvmhjfTOzg1KJW7L0A2P6w4UTRGZBMcfg==
X-Received: by 2002:a17:907:3c91:b0:af9:76cd:d836 with SMTP id a640c23a62f3a-b04b1458c7fmr1486696466b.13.1757513526255;
        Wed, 10 Sep 2025 07:12:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334c317sm171503566b.63.2025.09.10.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:12:05 -0700 (PDT)
Date: Wed, 10 Sep 2025 07:12:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com, 
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <jibftqm5ihdgazmk3p5gsjhlc536itqaq7r5uag5fuiqtth6cp@abihzyykh4gy>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <20250908182958.23dc4ba0@kernel.org>
 <kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
 <20250909161625.470d2835@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909161625.470d2835@kernel.org>

On Tue, Sep 09, 2025 at 04:16:25PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Sep 2025 13:17:27 -0700 Breno Leitao wrote:
> > On Mon, Sep 08, 2025 at 06:29:58PM -0700, Jakub Kicinski wrote:
> > > On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:  
> > > > I wonder if there might be a demon lurking in bonding+netpoll that this
> > > > was papering over? Not a reason not to fix the leaks IMO, I'm just
> > > > curious, I don't want to spend time on it if you already did :)  
> > > 
> > > +1, I also feel like it'd be good to have some bonding tests in place
> > > when we're removing a hack added specifically for bonding.  
> > 
> > Do you prefer to have a separated bonding selftest, or, is it better to
> > add some bond operations in the torture selftest?
> 
> Normal test is preferable, given the flakiness rate and patch volume
> I'm a bit scared of randomized testing as part of CI.

Ok, I will create a selftest to cover the netpoll part of bonding, as
soon as my understanding is good enough. I don't think it will be quick,
but, it is on my hi-pri todo list.

Do you want to have the selftest done before merging this patch, or, can
they go in parallel?

