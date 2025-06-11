Return-Path: <linux-kselftest+bounces-34745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6907AD5ABF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938671895CBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AE1DED4C;
	Wed, 11 Jun 2025 15:33:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D71DE8B5;
	Wed, 11 Jun 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656014; cv=none; b=uJoe+yD11v4s5YVoJKab5So49rZLyj3Q/SOQzzkWXg8Au/HQveA7wsWw5RY13WoPvFqmX43baLlNBpS5U/VHnzdYyPvdvpZIy4NhlyaGP2G/RwpyhLhqh+CZd0Nj5AgkhdktraV+kvx3yo0LeeVp/dN26QYsRZJQGoW6DV7H1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656014; c=relaxed/simple;
	bh=LFVvjcEUPcLUUGZ+sQE1sFmTa1aTE1eEZgoHDRCWpjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeRFuM2MHWncaEQX7ZqJNrwrN4ZO3Rz9xPBty5uKHqNZ3nAURygqwz8fL/tV2GVdx0AgDC+4nu2LbyScCg6mHT/DXe+rFYXV69pXnCfhzgvvwVekPtWXQ/Rno6ZsONy0sXJ4m4+xqm42LojDEzOnd0FLesOPWuZfKb5CNMQMm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb4e36904bso1351602866b.1;
        Wed, 11 Jun 2025 08:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656011; x=1750260811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pWEWrKCcgKVTrwcZ+8YcpLvU8fPQDchyP7vci7CIuQ=;
        b=WDpgZU8x3q3vThT18VPGkdJaq75NykE6QKQm0Qc5kwTCbJ3+spLFJllFeuFT2FNo8x
         YwoAVMiuIaV98TgmUIJjm8FbzEnQGhpYUy3j5LV0oddAGweCUOrxW12Y/Q8SzRuWDmUm
         ayrjVkwvuevTcf6ERZyGPEt8oxhKj7kefeWp5WuJkeANkfy7vLHSOPRcMQjPFk8krGEG
         Xd7YxfkyhdINUDjLwLmvevWmBSLGs6Yy5XKNywywrScCOSL0to6M1cScYrnvMNlC/ZLQ
         Glf5vGIfKy+cEQxv+G2BpDUDedkxj1gaj5jO43yh8uOYDUsazBAO3n/oETapRheGyeUK
         M+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNGQjGlmGS8WRgKpcYegb0zdk1pwMlUtKmKw6IZ1Cx2FAx3YPblpF7nIzL4pxMCAvVkQ/NQaIH3Mk=@vger.kernel.org, AJvYcCUp64mRAlrK1YJR+jAHTpy/kPuXFJWO+3gcnrnl7ONFtVnEhH4k6pAReWgRXKnY7A34mQkSCynr@vger.kernel.org, AJvYcCVVgEQFJejv7+5hC2KjIVF2VDPKcxVp+FYccFSuY8Ll2pmxcp5LNLh6Euk4xpWXEWb95d5LJiXFi/EjYmLA@vger.kernel.org, AJvYcCXmOTc/FT9wNY7jGpV/FEvUnAgBeRLh5vR2E19I6K70JuwA9SeUdJZ/5tw9OKyYBxXk3o2ZBhuU9YVE8HOmxLQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHBktNAvpmRdr2taCkRlWVk0z5SpKUOE6gPGF9tGfatqFrlq9
	K/pHDtcGXbFbSgIaVzKUCCIsperqUJtRi+/CsGPDrStfN1kR5jQfPw5w
X-Gm-Gg: ASbGncvoaYG3VxU/sPYMOmz1OwaE20KCrweyHk0EEVRrJwBlXdtwHzznI+5SxZf2bJ4
	07Zc/RskK2iAxl55U125zqmFTJcVp5lJgXqqTtgbmZu23uWa4vOXDiurF+kE4m0KtogTdnYcRlG
	x9suqCRHU97SCEeUpvjEq7MeWDm0cEp1wy9VU1xBNwnf8PwtHRHSGGTjKwIKPttnlWjGCyIBxn/
	VAIzboNEudn2WPHasEoZiBd87h7yDSmbgbDeY/3Ueohihgd7CTW7XrIPLsiAGw1BPE3v2i9b5Le
	gSFRC/mN0krDXX4tavcfnRJTe21bSR5aljqeTHD3e//MG4KK5+gqlA==
X-Google-Smtp-Source: AGHT+IEfZLGhg/nkYXc7GHKnUQ8cgynZfh8zxgjNYfMoL6iegmHZJ0pGGbPX0ENOTFyvS1/RSxxJJg==
X-Received: by 2002:a17:907:6d23:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-adea2e8a85fmr8568166b.22.1749656010593;
        Wed, 11 Jun 2025 08:33:30 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c87esm919503566b.107.2025.06.11.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:33:29 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:33:27 -0700
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
Subject: Re: [PATCH net-next 5/5] docs: netconsole: document msgid feature
Message-ID: <aEmhx1vutCK3RsOd@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
 <20250611-netconsole-msgid-v1-5-1784a51feb1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netconsole-msgid-v1-5-1784a51feb1e@gmail.com>

On Wed, Jun 11, 2025 at 07:36:07AM -0700, Gustavo Luiz Duarte wrote:
> Add documentation explaining the msgid feature in netconsole.
> 
> This feature appends unique id to the userdata dictionary. The message
> ID is populated from a per-target 32 bit counter which is incremented
> for each message sent to the target. This allows a target to detect if
> messages are dropped before reaching the target.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  Documentation/networking/netconsole.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index a0076b542e9c..42a0acf2eb5e 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -340,6 +340,28 @@ In this example, the message was sent by CPU 42.
>        cpu=42    # kernel-populated value
>  
>  
> +Message ID auto population in userdata
> +--------------------------------------
> +
> +Within the netconsole configfs hierarchy, there is a file named `msgid_enabled`
> +located in the `userdata` directory. This file controls the message ID
> +auto-population feature, which assigns a unique id to each message sent to a

Important to say that the message id will eventually wrap, thus it is
not very unique.

> +given target and appends the ID to userdata dictionary in every message sent.
> +
> +The message ID is built from a per-target 32 bit counter that is incremented
> +for every message sent to the target. This ID can be used by the target to
> +detect if messages were dropped before reaching the target.

Please also add that we cannot rely on console ids, given some messages
never make netconsole, thus, we never now if the message was never sent,
or, never received.

