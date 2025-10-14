Return-Path: <linux-kselftest+bounces-43119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEABD87A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417B519226DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A532EA49F;
	Tue, 14 Oct 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hg0hQXB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A72DC79B
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434831; cv=none; b=k1nTKj08ujoGsmA2Mi4qJQX5H/0AxbDcLgFe8jjKhlhYmYwaIUZuIr1B14TeKLQwJTExROzBE7fc1XRSeRiEQjt/gT3b2of5YajbXe71A5OuabVXljQaS9kfsBNRhaiJeg4CqJXtEIXG1PuPW5HZynzc/lt2KJ+HzVhYDEE9q84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434831; c=relaxed/simple;
	bh=wRKvHPeq0IjJrOaHI66asnH+YnrNb0PTfpXzCuY2EDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzqxJh4dElzck1Y4TWRcCWqGRA8i8nT1K6TsDARGVlNHNtpD5LlaVL0yweDcViEQfQ+s6wLJ7oOicfjJfzqBS7yDCCZIphWGtrMvrG3bI4sye2M58XF69CUGv8JzYY0Cs9maSuj1GHEVkuEC3ycHNlh2QKchVSmlvT0F6ZGndi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hg0hQXB8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so55058075e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760434827; x=1761039627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=hg0hQXB8XAbu9J1QVE7NT4GBi4c5s0ke0YV806ghrjE//nd2En048xXCQf8hiX+ax8
         RmMZH0820PTQw9LVvYyQ1YtgYRJkcnHs0kJhy2sq+GTJ4DuLwyf0vl01bgGQwfkc+voL
         TM3dciQqsCoqWoT49iQIUQSmPyHBYdIkjzzYD94P17Cwv6EkucSEhceFMzuHmKYzTe5J
         sbK3FfmBj2rYoZoLtaYNePqStwQmIKwljO1E9K96ZjkKfmu+rra2X/9CebvBC3KYOc36
         LphJOHjOSVrpiUBQdO4JWSmNH7gO1W8/Vxq7T8OPHxI7Q2NfWi73tW6uUTkpBOHnPhZT
         tmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434827; x=1761039627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=fR66aTCnhoI/elyIFLllr4wCuS65z6fGcUWV4Loe7y/iHtoCh8ENEpKxI5hG2VoXJZ
         xqF4Fs5sHz+WmmUtkd435j1uB7+7f1e0scOK25uVIQmmv94TjJLjrlSJMv25HkEKh4N7
         OrZXQlcrZxqxz7v2s/bmjpTL2Vt2UcfS9g4H01/im5Dyd6kUku1QKd7GF3VIhQT1oeoH
         O+LcO8XBnDPJkzGYpTBRZ2GUpnXD6grT383Ws/nUXbsM9x+GdgPdhofmyEWlWIA9DFMt
         qua1r5UrjbTRFRR6UE/LIz5ShtNMThmsl9RerjzP268E8KTYf+tuDNDUgVvPD+snZN3T
         vD8w==
X-Forwarded-Encrypted: i=1; AJvYcCXMczy4f616AF5V/9zagxOqulaz+oSKxk+NSgmcAtQhsTAzIE2U0AI3BrSBFUP34cUVjZjLfMGi0wTqvStX6+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR32wiVXWM+pcTrjeo03uo6MpApUEy+/mUoPXnTh9lY+HV6ni
	ZliRSb5jd69TUNcWdlkN+hAMOcHAA3T01GVtWOa1VQB1jgv9d1QEsU0GIFOhmQYQZ60=
X-Gm-Gg: ASbGncty71sX8ZZacBGlrIz1tIaCKvLfHVZ0bjQhjhKiaObloRODIj1l4EtJIDUFNd2
	F2SUlCYAaD6H7hAmQZYkwi1F5SYNT0Fzk2AWaV+kr5FzBnHBlRs6+jz6uOz+wJGF142GM3rVeb9
	epwAw9hOEVojAYPvydO18YBMiX4leufgrqoiLos7sxByYN00I68NS3XIw4JzuDkKTrNaeNiiB+S
	o+KCidHkXCB3AygHW+u/oO0JlxF/cz1BbHurRvrF8xURHxR1lfSfD2chwI7ND1wT/Gra+Z5KTd6
	G0Y1+Oh23vd0bzqvGL7Yi6pF4YUuOYof+5tHyWLeoyeuUmOBnzd/b9/gv4disZq31n16ELtIbhN
	5uxRPCj7Djjnao4POWWbBHvBDoMNSZQ62FMXR23NUNrFFijlJ1dPhwbFtwLAdoJ1pqus=
X-Google-Smtp-Source: AGHT+IHXmiUu6VVSyfoi7gU/XjlYIF2/0bxO4RUXhVMSkCCmaHjzamtRFltrBIEPIqHHZ3nvWstrgQ==
X-Received: by 2002:a05:600c:468e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46fa9b092femr190108795e9.31.1760434827487;
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm23512241f8f.10.2025.10.14.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:40:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080217.47988-2-liuhangbin@gmail.com>

Tue, Oct 14, 2025 at 10:02:14AM +0200, liuhangbin@gmail.com wrote:

[..]


>+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \


I don't like the "virtual" naming. In the past, we always tried to avoid
that for lower-upper devices like bond/team/bridge/others. Soft-device
was the used term. Please let the "virtual" term for vitrualization,
would that be possible?

How about "master_upper"? This is already widely used to refer to
bond/team/bridge/other master soft devices.

MASTER_UPPER_DEV_VLAN_FEATURES?

[..]


>+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)

netdev_compute_master_upper_features?


