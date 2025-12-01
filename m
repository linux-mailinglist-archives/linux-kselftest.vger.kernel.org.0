Return-Path: <linux-kselftest+bounces-46846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78980C99117
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3FD4344A3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870B26E6FB;
	Mon,  1 Dec 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bADbBy+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8F25EFBB
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621738; cv=none; b=JzuaUCiBcvwCFR0UVPiNWAlF3ijLFGUdYicvpspO3fXqqVVHH0NRRziIZQsVak4tGjNcbwxd7/P3KptTZ6RPV8quUIX9+ivCFdFLLB8hILG4r6IEeWOmqUfIZ2MhT1i53jWPFUCJcZ9XYlMnT2CfYeMzwUOqj0lAGfzM2+GXH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621738; c=relaxed/simple;
	bh=vWhHYWcd8FkuJuynK1LVlrehlybhEZwZ8sV261Ob9ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDRErF0d7Z3vR7KUOtVe7jSr29EGqZ2OfZb/7lB5JfZAWne9YS6nq75Dx2TVVdM3N02bSB+8LBk887XvsmJRAcxC4GmHdMQhtU7FC6K/R++i+aUacCnUPyn1CRzBGo8XApufsIp7SB0R+wSSj9FrOUpRltKRaqnsmUy0Z7YXNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bADbBy+k; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so3087408a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764621736; x=1765226536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4a04C7Gv91IN9J+tTHkfFNqJRITFzlmgP6sbkAcNZg=;
        b=bADbBy+kPosRZap3x0D1liAwG3ltp6OTkNftnDLS44Otcr2uW6D0m7qEO5Z6zp1VSp
         h2p2xW8eKGvUSd2lUrdIYt9//UsQkS9RCKxSiGEBIxT8QI/AnKTBmRWtQ/Ud2TXuHBVU
         6HhRusuPi/5XK9ImAF8X3bG60CzszvS/TU22ZnYrmAcDJUdFWioSFz+bgdcmbjl7kIRq
         y2U74owvaDAO7fSH8zWF6K88bYIxyosIoAmXLuUgWcHoN8PLWwCN2WCtE+nm7hBwU1QF
         RPBghEFWc1jGyLMI7xsyk/27JAQCRwnRxlorpHI2OFCc3F//8Eb8qGQzIlX+tnXcSNzY
         ZEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764621736; x=1765226536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4a04C7Gv91IN9J+tTHkfFNqJRITFzlmgP6sbkAcNZg=;
        b=ej3pxdKhXysHkxEuf1jdPruKsbgF3lT2Y5KeK3XnCg0ZJOySOGphXz2ri8rxMVQA1X
         gf4OUbcr9FrwsY8wXk9zOZMsdVYSFluAvPD0PSyHBCjq2A/iUO0Y+gVYQaHhHJ8/4BU3
         r1uPuSMhsA3Fz36N0Y4oMxHKxgIdpC9+rSYBIVEKAijq/Jdj9QRZ1rtdR88R3lPfmvvC
         fTvyt1/RAIsr0VMAhpIyeFJ1r2lsIp7k/AWJkc7h4wlM4acMnYUTwNGdK8/6K45hNoFl
         FP7RMQgRkg1QX+tXKZcwDJ5oJGfyPm0bI3dg+FdgvBBm/CzTOmw2P/JX2LFbBHibOIso
         ZCsw==
X-Forwarded-Encrypted: i=1; AJvYcCUwsRQW/ZEKvBtD6Zs2/SimQI7QcumBsk3NUMLcyINx3Q3aba2zHLEJu/P9heaPSekyeP1Uw0aGEk5S8/bmevE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6fUTU4vfZZeZxfvaQ7PWqtxopwkWiGtfMrkwVDXDMIdP41ha
	jdTbDYc6rFZMvgcUKwRg6vuAss4yWl66IDWm48rS/lYSK/FrPcnF4iZf
X-Gm-Gg: ASbGncvCcyypzOPaVvF4olDZCuxKqgFql2sBL7j9luTT37xrjTWwMqyaNH3GZ5xo4SR
	GI77aAc5Y9YXEgU1rYn+N/oeox7w4ZyCC1RT5UlvnJ+9ht2Xip6Roxw9xjcvG9ZQltbdlaj1m+w
	QPoqkD41LBILSgzRolt3aeXTyuw8RfdtZv1bhzsABHbe7VXo2XEXn0/ayP297QmDIvGfyJ6XOR1
	HuwEFBtPrLLYi0/IDsrfwqmuGwHIpgwQLXu++n9RYw/OZAkk/siJhd+B2PszfKLcuJsNjpP4pe4
	6kSRc6D8eQCJOu+7KvpfiJUoaW3O/D5cq+bFYqD1dBKLWjNA87V9pTo+pgF9N4zPH1kpwpEJgkI
	FtxJihalfIwasPUWIzJFufCv8R8YhczQCs/M1Qf0aQ79dJb9vETgVUD0+lO1qG3to0UmddqyIyt
	1d8GZgamAtRQ==
X-Google-Smtp-Source: AGHT+IEUCOu8J3fhboGnkGeN6j7MlyXHwAIoUZSiGO7WSwiFSdrln4sag31RrIgUhi5uAsL3T41UWg==
X-Received: by 2002:a05:7301:4887:b0:2a4:3594:72d7 with SMTP id 5a478bee46e88-2a719098177mr23906464eec.6.1764621735855;
        Mon, 01 Dec 2025 12:42:15 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:d24b:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm46285150eec.5.2025.12.01.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 12:42:15 -0800 (PST)
Date: Mon, 1 Dec 2025 20:42:07 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Message-ID: <5gwhtnb6yo56u2gozm566mlhorg4j6cjfrqtqqmw5naj2i7s2b@42a7wsrajnt2>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128161133.3397b20c@kernel.org>
 <htqwtsgxsffbjbccd62kzcdaa2uxezdtywudcrfghydym7axad@4j46eyxzvhte>
 <q4l6chqvikl4zgypqysdd5ri2vt6p4qdq2f4l66nxfbm7q5wo2@qwvwkilyzzoh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q4l6chqvikl4zgypqysdd5ri2vt6p4qdq2f4l66nxfbm7q5wo2@qwvwkilyzzoh>

On Mon, Dec 01, 2025 at 02:46:25AM -0800, Breno Leitao wrote:
> > 
> > Looks like it comes from Breno's patch [1] which was also part of the same testing branch.
> > Not sure how to proceed here, I suppose we would need to pick one of the series to apply
> > first and then respind the other one.
> 
> I would like to have this patchset intergrated first, and I will rebase
> mine on top of yours.
> 
> --breno

Hi Breno,

Sounds good. Since I'm going to respon this to address your comments and will
wait for net-next to re-open I'm also completely fine with rebasing/addressing
the incompatibility in case yours is ready to go. Up to you!

Thanks

-- 
Andre Carvalho

