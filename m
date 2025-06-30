Return-Path: <linux-kselftest+bounces-36119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C51AEE5D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4E1BC09D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173682DFA20;
	Mon, 30 Jun 2025 17:30:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F602D320B;
	Mon, 30 Jun 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304622; cv=none; b=uINJg2J44c0sTGmOCRokGvUjPeSfTFFj40tX8k67gBmH6YRjZKW2Unr72Bg71DemSjjNhHwIOJNtjlSqBR1Oywk8lE9T9xPRa9LmEmz3qv5dP1Uey97sLjWMTrRWtAhaMxNqZ1P143lr3wAUAgM+jpVy1ApFdMUljch6YwA5eIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304622; c=relaxed/simple;
	bh=mRaBmnvlcM9HhFflwQ0sq0WRnSWdPwBoSeN4WoeVGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJAsFR5ZJe3VZ4Z5AM4dOYTKdVl4Mui69m7ZYO231pVRr9mXRR8PqcGt3SSM6sJFevXacGVhZfXSUr5YRv2kVOjUEoP3S67p2RjQyHVsJdKtWO4nAgUj6EksWpYtHQ0NS5577g+2P7VsGZuw1w7JvaGplPjjwTElQqiwc7vmVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so8110032a12.1;
        Mon, 30 Jun 2025 10:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304617; x=1751909417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYtk+tdJ9WigmCX8UmH7nwOlbF/EiYv5z8fJ4XdRj4A=;
        b=ZB8ay0FbowQBSdeLgki/bYkMQHwNQ9Q4FsUqBbMVnfmcuawEldXJLc43la3Bk8tHLW
         kNk8WqyUY5BTn2C90UzwZKBx0HMzVS7vMUlCOh7M0FXTKqXUbZxuAZXKAVmTf+od/7t2
         8saT8/HmlWO9bck1lUXzmExQN0l7ajHSi1wsI/hWgb/0da15l7f9BkoPdq4uH/IIFevR
         EzsSkMTGj5QdmZSN236q/b1Pkknrh4XGO6WjoZskHQ/sP3BFPiD3gIMxER0QHWYnBDIY
         7+sNdiaZvTv7evM4R6wGNy/8A7z6/axGRebhqJy/L++mZj0djt6PNGwp6NhCket2w54b
         Uv1A==
X-Forwarded-Encrypted: i=1; AJvYcCVSW+vnXFw2gduEGL/SFkbLKvmezWI69JyS/Q/b3CSLjddDxNCmww79vRsVegWlP/UonZU12WJUU7G84WCQ@vger.kernel.org, AJvYcCWfDclUzNJQT8D7LXj+j4zBUcdeTdc9JUmbLIPg+wkU9FSf0H8pbVz2BRVC6VMY7YaR8fdNpRDNH8OgDFQkT3Qf@vger.kernel.org, AJvYcCWjE317XdTnGhiRM3eMMQuFYzFxAkJg/9iYrAVKBXHRURzq28l2//YaQ34QGGVZx7SzigknfZKL@vger.kernel.org, AJvYcCXMK87R5H6JfxRCWnqmy6TCYGUM6sVQnlQYytBIn0GWzjHgwHkWNxRWIe2UoTI+hibubfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+YgkPTF0UQGaF0+lH4VI+EIvFeyOel5n7ACuQCvVINFMIDRs
	8mJO/qQ5wGi645uCPUw0en2xJawN1j1GMEOoFMydhiFNMMylGAD9Elc3
X-Gm-Gg: ASbGncv3S4QUQVMzasa4ZE91+9xHmlKJdExhAoMXx1Yv9nWVV1wHA6msPrSmXFXmNo9
	vCvnXU/evEqVqBLKAW5kBz8uRM0AOuFalRfnA4dFov0kRneACJU0UPYDjI4V7+afQ4ZK8OeZ7KL
	WlTwvNaRb00I6I/b6DjQKJBuOZMzsSWvb9PxoATiC4FegdaxwEvPnp+OmXH/vPs+9asdAfHXhH1
	x5MEdYJ6E4TbHgjchj60QKvAdxD0b3HYJ4+4WWAz1LCLUtpZ3hjhu7zijL+MMs08wjyTTJ5DV3N
	fOIS+PV47HxBxg79rbpEWgOEr3OCMNnidvje7jgPB9E7PaRoWZckvA==
X-Google-Smtp-Source: AGHT+IGF+65MB7naW9INIqJ01bu/2rGvf85Aln8gTluXMpbflQC+TqF6pJY7DHbPTg7s06gu5viM2Q==
X-Received: by 2002:a17:907:3f8a:b0:ad8:9c97:c2e5 with SMTP id a640c23a62f3a-ae34fb22a33mr1389506366b.0.1751304616377;
        Mon, 30 Jun 2025 10:30:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01262sm700489966b.87.2025.06.30.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:30:16 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:30:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <aGLJpaNLPYnPwKYV@gmail.com>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
 <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
 <20250627113854.04c13ace@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627113854.04c13ace@kernel.org>

On Fri, Jun 27, 2025 at 11:38:54AM -0700, Jakub Kicinski wrote:
> On Fri, 27 Jun 2025 10:03:11 -0700 Breno Leitao wrote:
> > +    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")
> 
> As discussed offline SKIPing is not an option for SW tests.

Sure, I will move it to failure.

Unfortunately the expected path didn't hit in vmtest. I am still trying
to reproduce the failure on my side, but no luck. It hits from 10 to 16
times per run. 

Do you want me to send it as a failure, or, wait until we get something
better that pass 100% of the time?

Thanks
--breno

