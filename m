Return-Path: <linux-kselftest+bounces-15500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F48954AA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649FA1C20E85
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBF13AA2B;
	Fri, 16 Aug 2024 13:01:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FF1E4AF;
	Fri, 16 Aug 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813281; cv=none; b=Oxqyh24kHy2YdIdVjYrMeb7JgcRQna0NAGVRJvEQCB2AUQnlU8Qp59Np1/+6eosnVMIu9aJAKLpmlFPFVHIzJbttuSxyrZhUkVsexKMNNzQ34ptYSfaICN7u+P+9cLW7i4oa8JtndbpaRvKJ4v754IIZfYbY57JLRayayfmD/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813281; c=relaxed/simple;
	bh=KzD0Xyve9PLemVNDupoBAN/jquzgMv3HHLv5g4tIK3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOCM/AFqEhE48QMxzCTJ7vwVkTMCO6scm3zfsrLs0czWqbmusoK45CTPe6jvqa9eLn4W0Enxl8N6HBa7qrBpNcwlT3ivf+5n0XSf19xQkfdHUSb1kskqPfSRqyTFCSobI5gO94F1S/3JUR/hEEVbwyHbSeKiHUnd4M3pJAMbTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so312476a12.3;
        Fri, 16 Aug 2024 06:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723813278; x=1724418078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOFUzcGmD8YZyWPgeFeyXF3QqukovaEuw7rQe+seNtE=;
        b=PhYbB1SzH8k4ItJpD3ldh0w0gXm3HQSfMHV70S/aBbD58dtjXcDI0DvGy3GPTrcecu
         spt2UztxlLAdRldmpCd6ZnQCFw6/5OU+B0JFGbN9IZN4b3FIDBkuo9c+6cLkhC+VvHWZ
         /ia6HsFag09uXr4NzuQKL7r6YHn6VFcgJxp0I8tIQ/Uj3PjyHPmUAfz70ggXlKZpQEKT
         AwxWM2SbCozg3ZWhqCZL2L7Y1YpmCdYmEYDgbS04I4kwxVvHYmg0YM+EpGZ/7bh62zAp
         srkdphLAIQFktcc38Wrcram3j7JwpalHpswOmQ4l4j6DFVgXB8hF+9c378iO9RZsIV7F
         51EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3oQ1l0CZmA3sTQPDvSgbCC5XZzQ5jkGBYcoggxnWF4qJUjnkjral8AQTrxvsM1JyZsu4sNPXtFJYI/Mg9IqCue+1aU2V3xa9hDDzEP185BJN+r9RHensTWv0wfUrwDKvcjSbYpFe+p7OnhOAdUryA3M0TkWquC607Rqb4HLZFl8CRWFAJ
X-Gm-Message-State: AOJu0Yw53l1abgbb+53eqkMMU0kxy3uiNwm3gLfXSESRCqejeG4Y9YQs
	O8ic6tXmCHssNWCtL+bCOEDUwEBLJQsec2ZxqTfoA+5kRwuu+7q/OYA4yw==
X-Google-Smtp-Source: AGHT+IHuoeH0ZWe/Z6RbRI9LL8Uli60fHi1dpmDJOw0kZsaqeysUAbcLLEwXh238QnGUoxHNkfaOSQ==
X-Received: by 2002:a05:6402:35d3:b0:5be:ae21:33a7 with SMTP id 4fb4d7f45d1cf-5beca4d9f19mr1914013a12.8.1723813277512;
        Fri, 16 Aug 2024 06:01:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde3849sm2189934a12.21.2024.08.16.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:01:16 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:01:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liuhangbin@gmail.com, petrm@nvidia.com,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <Zr9Nmgggn3nlUVnV@gmail.com>
References: <20240815095157.3064722-1-leitao@debian.org>
 <127af9ef-2d69-4765-a8f0-0dece3b6dd1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127af9ef-2d69-4765-a8f0-0dece3b6dd1d@kernel.org>

Hello Matthieu,

On Thu, Aug 15, 2024 at 12:47:22PM +0200, Matthieu Baerts wrote:
> On 15/08/2024 11:51, Breno Leitao wrote:
> > Adds a selftest that creates two virtual interfaces, assigns one to a
> > new namespace, and assigns IP addresses to both.
> > 
> > It listens on the destination interface using socat and configures a
> > dynamic target on netconsole, pointing to the destination IP address.
> > 
> > The test then checks if the message was received properly on the
> > destination interface.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> > 
> > v3:
> >  * Defined CONFIGs in config file (Jakub)
> >  * Identention fixes (Petr Machata)
> >  * Use setup_ns in a better way (Matthieu Baerts)
> >  * Add dependencies in TEST_INCLUDES (Hangbin Liu)
> 
> Thank you for the v3!
> 
> I only looked here at how 'setup_ns' was used, (and a few other
> Bash-related stuff), but not at the test itself.
> 
> I have a few comments, but I don't consider them as blocking if you
> prefer to continue with the current version.

Thanks. I've adjusted all the suggestions you gave me, let me send a v4
and we can continue from there.

Thanks for the in-depth review.
--breno

