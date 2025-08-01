Return-Path: <linux-kselftest+bounces-38172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8CB17EBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28BE3B87DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B95213E90;
	Fri,  1 Aug 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvdfuEoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168918C02E;
	Fri,  1 Aug 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038924; cv=none; b=BvIjAhQXaRuJTatsCXer3PaPbakfxKHYKrVpTrQrwZzSHylnvBwMS2bkqYWTHn6ZfE/DtX8JOM6eu2wDO4MkZ9uJ2nAxhSwBM64hRXqP5Yoy4f40V1GTXMYo45oVEF9Cyxht75lx/YeTIwlzErTB3FdyqLLpDRBpHbvA45zmFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038924; c=relaxed/simple;
	bh=LQAn9Z74ApWpKknEzR5YdobzGb9ilQ/9BWm/QkLbzYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9VxyrnHD8pJch1OMaU2J2iCxzUxhXWGdAqDDsZB9OHD/wmwt/S8NoS7ET+eWT7YqCyzqdduI0IZA9TCK2Rlrx0DTJXOOstwxs1fh5akVh2s30qMf2q6gNMqkrIidf3cWJJ6ISTwmmAwuNipwHMI+92C8p/4iDeoTqhA3LJGxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvdfuEoR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-240763b322fso13722325ad.0;
        Fri, 01 Aug 2025 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754038922; x=1754643722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNVpnicvngUWIcQSeSIW5UVxijfvMDVXuIS6fIxxIrQ=;
        b=YvdfuEoRk0rRwVd9iVbxWzBJg71ozVQwCwN02h18PnUAfWPmNyAH8nNDUpM2to9Xot
         gCJSFffLQ8uKqDkqyCuUfWFo4eWncgBuBQHrWCsz1Zw5PYKWm4bd/pRzJSqS9ZtsQDGa
         rGYCPZRAHy+1RCylwp6nagbhDab6KwLKyyeVp4UlrdwUzdvqWHmfQv/kLFNZt6Wq9YmH
         wCyWwSK/V92TJxJeHMpQmyWP7+//mwWuRswNDM+zYRkoalSNPbvLq7pkXMmOBEyfQD9v
         OjEOZ9cTHLEHM4qFCsnW1mhMp+VG1qnxzRPbs4DVY0qmPmWcJw5Blgn3Up+MryrBrT3R
         bAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038922; x=1754643722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNVpnicvngUWIcQSeSIW5UVxijfvMDVXuIS6fIxxIrQ=;
        b=dR5XsFhtHWVK5PWj3BNjEqsepsjTs8hX0zZBzNx93vlsyWFs2zItDYHKh+YMCoY5pZ
         /W35uV/RdqZg/EarNuSz28fQPcsiOdIRWuE22VMgkQ66SjgIeETcWkwduxstoyWCMyNB
         UVU0F8W1zN09kn8MhcDnDFcxSKiIQeP1Ueu7gSk/2wJDePGQxzO3lxNtsxa7l1ELovja
         vWXNpF7Ovv41nB8XKnaqxz2YdpwGvNPtVzyolqwjF0MnlROg99Z7xNwe/Hd3UnYr1wcb
         p+inXxFu+EeZkpaKppZWGoqaRF6Kip3YzPoyPqPHyAKOJXX+R4MHKyo+LRd/4L1gOyVL
         w7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/GjDXB6iAOTr27Clxuai36UURmV9K94rY+8pLauQSBoZZUSlVj8ftMmHhaM8oisQsP7WO7l/Ru+YUbtp@vger.kernel.org, AJvYcCW97/0a0cyezgkxc8KQZHrHZNdq6Kje+CxEDWlyeSRjyBezC8cMPVWWlNYZPUhUoIsZ7sZm5Mwqmfk=@vger.kernel.org, AJvYcCWG/WzwrQ6kRRdb1GLtX/v0eGSprYTjJuEb80T80H65ib7r+BhXX/UfTUEQQtD26xWxA7O879AKSFLXd2proaa8@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIM/G4ZewE4FP38HRlzxSWbAKO6DK6RfaUSmbMV/v8ciH6mZi
	2VPkUdg562h5DExHYftDOAz/c1rWxCc/2dK0T1ZSrtojQm/grWhZg03Y
X-Gm-Gg: ASbGncu485R8IybyuSMGCLBVCU5w0pVGNeI97+52YVF37o9vPYvhULoxnO+VsCA1XwR
	I/TlAbuLE/0TxYaKvDloT+Fj84mi9vFnL65fxHC/rnVlXvFmXhTGy4n8T35tpUMRDK7BLOafpk8
	l9BuFqQNAYXLjfJMh8/tQGZgAo3k/N1AwfX0SJdEPFg8T2oDON3P1hhO4laQxyGbRoxIqV1E+VL
	JdbbbmYHkzw7UxRJR8EeyxFB1uq1HDyePEmiQZFlGVfCfU5hjDenR4ueUN2bBO4d1KsU45btBPQ
	scE3GyvdbE2fvmV5QmbDKSbXpzJmqYssHwpVn0F/6CptBzl12QX9zePIiPoIHaWeQYChtgMUQiX
	O4bWO1R3bJMjKkgXAW0nNt/Z0jWA=
X-Google-Smtp-Source: AGHT+IFYvnKgARqKCy9fJNB6z4QxA4wIrT54OgyyEjOC446jlLt0Q9WKuoFiFZZl35o6xiFvSIKMcQ==
X-Received: by 2002:a17:903:1aee:b0:23f:d861:bd4b with SMTP id d9443c01a7336-24096a63f17mr180276215ad.5.1754038922100;
        Fri, 01 Aug 2025 02:02:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm37997035ad.39.2025.08.01.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:02:00 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:01:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
Message-ID: <aIyCfz3KUcYoE4Ix@fedora>
References: <20250725062848.18889-1-liuhangbin@gmail.com>
 <20250725062848.18889-3-liuhangbin@gmail.com>
 <20250725072112.6b3c4f83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725072112.6b3c4f83@kernel.org>

On Fri, Jul 25, 2025 at 07:21:12AM -0700, Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 06:28:48 +0000 Hangbin Liu wrote:
> > Add a selftest to verify bonding behavior when `lacp_active` is set to `off`.
> > 
> > The test checks the following:
> > - The passive LACP bond should not send LACPDUs before receiving a partner's
> >   LACPDU.
> > - The transmitted LACPDUs must not include the active flag.
> > - After transitioning to EXPIRED and DEFAULTED states, the passive side should
> >   still not initiate LACPDUs.
> 
> Strangely this test fails on a normal kernel build but passes with
> debug options enabled:
> 
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-07-25--09-00&test=bond-passive-lacp-sh

I guess on the normal kernel, the checking starts too soon before negotiation
finished. I will add some sleep time before checking.

Thanks
Hangbin

