Return-Path: <linux-kselftest+bounces-38635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B4B1F7FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 03:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C907F17AF56
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C317333F;
	Sun, 10 Aug 2025 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="BjTMkCr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF01547F2
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791172; cv=none; b=V9xfUmZXPlHMzYpRWfELG7L5xANl4RKee2SsNdyGbrJfIchdIxmmN3JRJ9as/9xSVh0h0AeeGnSrhwc1ksOf+zdinXE04vwYD9oCqobHaixTt3LmQt4wuYW9IDFOExgFJpG4VZdtCdsaf2Rq4swQva81yS/R5bssOkEYMbkM9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791172; c=relaxed/simple;
	bh=qlrKx2M8TZtGZwjSkB8IuXtRhhT1GxtXi9jWa6jR08E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DliQ9lfP0ekTrcXSxOMmKNUThHonn6z2fArgzSCPNcMiPbFdZSaM+FTWWj9TYMF40Qu/6kJdFz04o1jSSmK+U5ayk2wj9GnvwfAKvjpd3KYEYYOUHw4cRCLvKlTsnHLBXTcYSuWsVN2dDwHSaQR7zTeMQwtV04nQ/1izuNa3iWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=BjTMkCr8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76858e9e48aso3055416b3a.2
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791171; x=1755395971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF8pKdQjv4NqMNkyPa2+QQHFgfWeKJGjpAH9U0wK9Zw=;
        b=BjTMkCr8FB3QbJ4ZRRC1qb8vblTmcRi9Lvta9wvXmuqsZmZ6xhtgy+CVUyAcXmKxAy
         5bcJbcdarfNMhMUN2kHpuzzkiY0OR0j6w80ogF/PocTJCWrOaYGRmTNxHG4MdYMSaQZF
         SFrjvxg2nLEsJmJTXeNnEMIrz7u5ZAoOUPtire7M99i8/l1qxPlLwSbsDtjMS+869BGd
         wd8bL8y3JSIsTOtshT2xoAmuBqbt62l+dDG/O2Lh+7uk+fqm9cQwVTePh3KaGZQVKVK5
         JVqGTHUajbq8llh48XMOQtdALMfQVXasPSnTISaxIYe/iC5S/j5UrF3SYNYQyuRg4rdU
         SArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791171; x=1755395971;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eF8pKdQjv4NqMNkyPa2+QQHFgfWeKJGjpAH9U0wK9Zw=;
        b=hV3nbbRObPxlm7HlGFF6f5n6wK219iFVLzaCwGPeYpVUJxUwmFaRkcJlSy4iLw6sRy
         xUhF/a6Pz5GnnCq8sQIXTBklVd2CZzF7Ka20M++OYTMw2IZevIkrK3TeyNoGwcjFLzzu
         BeYN0/eeenxap62ktxB1Ez73rDOzTMXjzvjINhjkJ5YZssAzcfKbZqAYhBewPgx2we0K
         Dw0zLu7tqMCC3+UGnXkRRxxe1zEw9ALOXsCBjm994Pwunp0JmEgxUzF4eky/qvIXyRGv
         jmOJpIpt40S/Qk7vClgvmjTPDmD/V0eIGsPyW4scy6qdlIXJrx/NvQw3YXQlcxzAryPs
         nmHA==
X-Forwarded-Encrypted: i=1; AJvYcCXHPjGlHKyEoHTgvfIRUpA6SjOn5OIByJdfTmdsaEQKljLK9N69p7zNL2uHy7i1z93H71YSHVnf6W9Ue9SxgwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyr6J1Gw0RiVDFBcZTsRIAxZm8wGRdTmq/brGkpa5E4t9o3r2
	zRZloOLUZQBsgWs/yOPPTC9TxmEiRugApRxe61EXm2GgixQkN/78m81odzcdNjoH1/GcY6N6z1t
	8ovvQeJI=
X-Gm-Gg: ASbGncuvhzfAFuw0HPSfyvCnUEjn4oz+aXrqpXktYXTAYnThkQkQob93BwoWLwCboxH
	S2++4dF6IWMeTGpdU2vULTm14oF3xvPU0j0+DP9tEes/ebtS8asQsEj6zk9XhEJi9tBHANDKcPJ
	pQdJ6cEhe0D0OVoOnJwThe8VzJ7KBpVHR6fDaaXsXdlrA+CtHkgXYM3w4TmCiikO4waDS5r8V38
	fJ4RvcqSbYw+yFwZo9pwUk6pVlg0VmeMh8Ez+wKxs15mrKdI6xpPicozb89QL4OsxRgXoD1txNU
	oIwnc1NcZnGB+/15p7jZWt+Wc5F8nQt7HsEtsIz2z6iKOJFCdTurTZnOBSrkXJglLFsuxqH+RUf
	ik7bFyzXJnXCytYv+uvtKUg4bWxQN4PjMFITop//rBrhvKja7JDZncgJLpQBUIoizy48gZJt8
X-Google-Smtp-Source: AGHT+IH/pB2pixkyF2YL9XgfIkRFvD7SRAfHbBOLp/SPkXfC/H0pz69TSJ/YVnczmdr9I/SN4PereA==
X-Received: by 2002:a05:6a21:6da9:b0:23d:3513:935c with SMTP id adf61e73a8af0-2405500059dmr10796388637.6.1754791170739;
        Sat, 09 Aug 2025 18:59:30 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be629a1b6sm19735996b3a.11.2025.08.09.18.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 18:59:30 -0700 (PDT)
Date: Sat, 9 Aug 2025 18:59:27 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] net: prevent deadlocks and mis-configuration
 with per-NAPI threaded config
Message-ID: <aJf8_ypOuSrsQnIM@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-1-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:02PM -0700, Jakub Kicinski wrote:
> Running the test added with a recent fix on a driver with persistent
> NAPI config leads to a deadlock. The deadlock is fixed by patch 3,
> patch 2 is I think a more fundamental problem with the way we
> implemented the config.
> 
> I hope the fix makes sense, my own thinking is definitely colored
> by my preference (IOW how the per-queue config RFC was implemented).

Maybe it's too late now, but I am open to revisiting how the whole per-queue
NAPI config works after a conversation we had a couple months ago (IIRC ?).

I think you had proposed something that made sense to me at the time (although
I can't recall what that was or what thread that was in).

