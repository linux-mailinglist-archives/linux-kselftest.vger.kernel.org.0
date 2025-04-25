Return-Path: <linux-kselftest+bounces-31623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0AA9BC70
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1A7A690C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5252E13633F;
	Fri, 25 Apr 2025 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OWV7qZ91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B46664C6
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545128; cv=none; b=KgtlHEjSCyBBwQvZW3kGwLsiAt17+4KVXjZCmWwo5LvrXs+/u2ifPSjw9mUCoiklRGkVerRLqvlNBI8nZYv6fz4EMLpksmXIK0lKq5Q0Em9jtPEEHIjPMfcJqJIQGl7F2ezIlqGWa+2R87OoVbiIAEMsnXsLs5rw4HFDsuoutng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545128; c=relaxed/simple;
	bh=yhOlAEzwrF0aCAFf+JgQeNbbx3sk62jQPHuNFSORMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ1O+rwvPFMo+8buFNMXs+6oxfJyuqx0hqEy3qA+ybCwOAw3h+8H1vs7bPRdHGMzNL8o1Ahnx2MsYMZpLFCGJXwnSNX47RpoIO2laO08RdOdaBvVEXKP6t7YxH53R7C6IZ6OnZRroPq5fEHG2YBc8lzLVZjldVjRC9eS+0sz0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OWV7qZ91; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2243803b776so29237455ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745545126; x=1746149926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSqYScKgytFmXzzaTTv95GQdkzPtmJIkcWKivQdfd7E=;
        b=OWV7qZ91iqDuT+nIndMTN3+mLDvFqvm0SPifYoT0vQYv6e23u7mATuF35l0sbtfaSh
         DU4aAksXg8kTxuXwwZUmp+NimBiZo4FM4b8iadkqnYuayNakFFl7Wcpo6xN7e4Y/mRb9
         GpIY4wlgGvsZaRjRmgqZVlA631Kso9qMhnLf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545126; x=1746149926;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSqYScKgytFmXzzaTTv95GQdkzPtmJIkcWKivQdfd7E=;
        b=aWeqGTIA1a7xsGZBdZlWvbabQ5rZkmyjxzOV43pj1hPNoLnI4ARFTU3OeHN6DDaWf2
         ti7KmA20Kn+i+hB7hjQc88B5MeuPQPd/QEXGCHwsOkOp2uhTgMp7DdgXTNZbuu5TdG/w
         QJtthRJQihAX8/K+pl5h8knXlD7i9apIbuzeGppRwvgWMkq2tFEEE46UGfvB+8T5v8EF
         5iN+VpKzUhjYBtbw8eOdsYKEThFInBAPAsQ0CqBV4khhTFyaiqNKvRAN+fM7CAJ6VxVM
         VDiyUODR3DnXb00fAe8x9Za6ERGudfAGevlS4pfp0ODo1wyV1YEI6bPGueKKfCmpz+BI
         q5tg==
X-Forwarded-Encrypted: i=1; AJvYcCX0MmjJOoI15DXJtloVxeTSBjo8qzuwEfmVOUkLbhOEryIXS2rRC0j7zzzOIx/CXg/NvlfgavV4WxrJC8s0TJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tM234St72rxrPHYFsMHVdzUKu/ame/j7DvwWGnIbJLFqxa1o
	rFM1bSNzIiJs22s3sTqDjxLMKEi+qAekUDZh632/QZWbeskEpTZh2n5WFc8YplQ=
X-Gm-Gg: ASbGncuTWDWZrMCU6XitrSfaLlnRtmFVlr6m5wKkLW9ed102Zf+XTPgeTJKYkgX4+Al
	mybbCag8SkZb5TB7Gk0NJ0RYMsQNJYVGyI9U/md7V3kBK4qSFfu4VfZQFYxa0uDvdYkWAYYs181
	clMFyHKCl6JiDEe6rnrXet8cvD0lstDF6/TwI7auJk3nxSCOXd45FyzYA7DgudP8Zjsjf2QB8Ie
	3mIX2PFlMQxfoHNd5GVaPgQrwjeom0W70RuSyKoaYtzK1sUzZ66B1z2UsnoYolgWucR5XED2WQd
	SwVWebTIabRzJJH6326CfKPRnqZyx+cD4TJP4DHhHYk9SCCEq1W8twxE8/jJCPSkwH+zmrRzsmN
	7rlFoGmdeg1+ML1qmeQ==
X-Google-Smtp-Source: AGHT+IHtyY/Uad+Dw4YYDrHqlH0t+QCAu2yareuHTx9iQsFmiei7axjBQ/X+aTouMtAFce8aEB6OZQ==
X-Received: by 2002:a17:902:e84c:b0:216:644f:bc0e with SMTP id d9443c01a7336-22dbf5efce5mr8556365ad.24.1745545126067;
        Thu, 24 Apr 2025 18:38:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm20612495ad.246.2025.04.24.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:38:45 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:38:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, shaw.leon@gmail.com, pabeni@redhat.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] selftests: drv-net: Factor out ksft C
 helpers
Message-ID: <aArnojKzMWKS1ySR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	shaw.leon@gmail.com, pabeni@redhat.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250424002746.16891-1-jdamato@fastly.com>
 <20250424002746.16891-3-jdamato@fastly.com>
 <20250424183218.204e9fd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424183218.204e9fd1@kernel.org>

On Thu, Apr 24, 2025 at 06:32:18PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 00:27:32 +0000 Joe Damato wrote:
> > +++ b/tools/testing/selftests/drivers/net/ksft.h
> > +static void ksft_ready(void)
> 
> > +static void ksft_wait(void)
> 
> These need to be static inlines.
> I'll fix when applying cause I think this series may conflict 
> with Bui Quang Minh's

OK -- if you change your mind and prefer that I respin to save you
some cycles or something, I am happy to do so.

Thanks.

