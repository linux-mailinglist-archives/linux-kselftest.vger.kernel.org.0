Return-Path: <linux-kselftest+bounces-35858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE30AE9E22
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35753A86B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE882E426E;
	Thu, 26 Jun 2025 13:05:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5C1D5CD7;
	Thu, 26 Jun 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943101; cv=none; b=eQn6847nOtyplNlHUIsNcyb+4jdOvAii4aQntYXnVr9YwN8GOsvmTsTRj/6HZF/l76uKevP/+D3bzc4Dex4nXIcFvQpP0y31kdk80gZvd55zwf4MGFBJdNvnLJqNyNF7/C9IR33mL6iCRr+nWeAl0QSl0TTTiWDqMOcfeNwZe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943101; c=relaxed/simple;
	bh=+weNGP25j0iT/YTTMWNnT/VBrQmiEdyYjSYQGmhbTgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9cR7Z7Fb6R67An3zJx2E9DclNuRFWWJML6sIv8mqaxXi1b4E5KtIQtWX+at320WhcDnNaUhXB62/hmfWnNTiou8NvPohZkTM9pLjiqXWonOKjSdEI5C6XurqFFoYSMzWlJhvEvNukBLiRBjQhoZD3UKOYgbVyHKJNxf/VhpjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so168124966b.2;
        Thu, 26 Jun 2025 06:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943098; x=1751547898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2fxZkpu+g6S2FCWHi7Fk2Zxk55b+c9y9r1cNytFmTg=;
        b=TUpL0+88RU6rY3kADxb+RbqLq1gFGN1nlqrgz1h5/mLZgDKT6aE8P81H4dF+58Yni6
         HfEnwWKaxhC9/uRwxD/uxSYp0jFvpx8m03/4IGetDyJRLoHUg2+rKYb2fJzNzMbG/E6I
         KjCdP3vYNA5W5E0xETakNflP2KCagCAgE6nHWc1iiiYiABVCn6m+EkHu1lEc1aQqMnP1
         BloDniOWE7tbyvRg7OPhQbNeoUk9X5odGOPMSHhCGAmxwJA7S7ooY64Ix0cSwSvNq3Ls
         efl5xtOaOfSqT3apfC5HsUQ/CWRkDOMWSLfgteKTTg/BP9Co3olxG7DZRIvkIYSoSg2o
         q8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUp3q0DDs0pvItfJ2WNRDdF8MNe9RO0QjFdq0vssut9YYXG6ksWaUd1hMtRLpy0HgGRd+GkJmjg0yCkMoFmU+RA@vger.kernel.org, AJvYcCUwODCvKs5jeoiwPBOqKVA7OEREtDIJt3KFTgYp+QV0z48s1gGAod7Ne20D2bAZgE6kUS4=@vger.kernel.org, AJvYcCVEhKQ+ZDI9ON2Bi+kgmkKlXk1URaQRhtVlTIzrKEIRFPSsj6V5dSTkKjctCAY4c5LR5Mb1M+94@vger.kernel.org, AJvYcCVqDGLZ30b3pViSCJ1L6W5s/mf4WFMGOaY//qqDIDcAV3oltSW5LHyeIoQ7V9wrpdB3W3Oj5dF0R9ZXrOwS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/kuxUPE306AM8XyvT4z2S+pejtkcytKYA22JMbaBn+4L10qg
	UDLcs9MlQNTWusYb2mPPHsq61vnrX+9vXLw3+EtipQE1ejffwCj8QK29
X-Gm-Gg: ASbGncu1pP/tu6tW/qgTTgp3D1RWWQXBaaq7msrJwiqEQVCZlXNsYcnwbJ+19FFg6H9
	0x95p1eFYS2j9/13mflVvqb1RWYrSDRC0aADtUeQ7/YSTucVm3GEtElec0IpHZ0Ef0adSUNyJVM
	raWv+5k0PjqRo8xGhhvfDqswY0j/tlgdbU6qrRuup8aB2Qsj/LOWIe/hoK+qVAFksrUg6CCzNqh
	wEcEYOjLWqxRwzM+7RZMWjvjm6ze+zxQ77C/2zMIXi5hgNlXa29+kY/MZ4xZaRrpLwti7kKo0sw
	ehqYeC3lE+es3ttwm0mowu+2yZf0VnQO826G3xI5Y9VIHvqlRI2jvMsoerPkZdQ=
X-Google-Smtp-Source: AGHT+IH4MGOLayR/rn22OHrjTwBgXqcDJuwyeCilYt5OKjYbX6jO+F5h9G77Q+IMrfXKArPgDWoPHQ==
X-Received: by 2002:a17:907:8997:b0:ade:c108:c5bf with SMTP id a640c23a62f3a-ae0beabb66amr704633866b.43.1750943097533;
        Thu, 26 Jun 2025 06:04:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0bccb4379sm340009966b.8.2025.06.26.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:04:57 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:04:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, ajor@meta.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 3/4] selftests: drv-net: Strip '@' prefix
 from bpftrace map keys
Message-ID: <aF1FdfXnqTT3she7@gmail.com>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-3-47d27775222c@debian.org>
 <20250625150710.4ee0f729@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625150710.4ee0f729@kernel.org>

On Wed, Jun 25, 2025 at 03:07:10PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 04:39:48 -0700 Breno Leitao wrote:
> > The '@' prefix in bpftrace map keys is specific to bpftrace and can be
> > safely removed when processing results. This patch modifies the bpftrace
> > utility to strip the '@' from map keys before storing them in the result
> > dictionary, making the keys more consistent with Python conventions.
> 
> Make sense, tho, could you double check or ask Alastair if all outputs
> are prefixed with @? Maybe there's some map type or other thingamajig
> that doesn't have the prefix? 

I have a quick chat with Alastair earlier today, and I understood that
all map symbols start with @.

CCing him.

