Return-Path: <linux-kselftest+bounces-32640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD64AAF10D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 04:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9DA98540B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 02:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6AF1CF7AF;
	Thu,  8 May 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jup+Qk+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E015B102;
	Thu,  8 May 2025 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670513; cv=none; b=QMaXRRNCvNjyFuXrRbr89JsEAvboYFK64rgGn3VQ8q6FFVuo804M2tTeIyEaVHRUTnHpbyTcKSRMOvCTJYhMb7NDGKCBtLVuHON3y3YjhydHck7R1DFFuwhZ9imcAA5BpdZvb6siwSeTxhLWV/v2BHSwGkr1/bhBwBKUSHyU8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670513; c=relaxed/simple;
	bh=Xe71o3NwB4Jh0TFWAYLmp8xOREtAMxdCI+4weerDoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5oKrtaQsIGXmMbCYF5JeRmkh3HnpTviFjRr7uDNNv4MQL5pWZWX6jCjOA74+t3b49e0IGOCGGY6+TDvQqFpTXZ1YOj9QgsK1inHBJEJNhEcVgDHdWmj/KyliT+GObDe2Z+LlAR6E4h8Z35DzZzEvo+0wIjHZxKXoMwUejeAUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jup+Qk+C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22fa48f7cb2so1147325ad.1;
        Wed, 07 May 2025 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746670511; x=1747275311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkADO5RX5LKak5ParSAdhE3hkIpyJGjVDD86j8FGyjI=;
        b=Jup+Qk+CBjq2Hj3r4xbC0ajBX0Hej0PArYRz4HZ3xB7I1ZIEuAJJvlukARd4OTHTDq
         piBDhZCR+8rNcjh4WrNNO28/Z9tTiKZ/PCokukyuqSRq4aTJwSGmUpjtESaBueEs8H7h
         Y46mNveDw4P76Q2CKmLzoLgo33paPfEu8P6BpkZ0aRgG1ZQ5jCszXt8H1LYqkMeehPsD
         d9eq2MAEa4d4mKUV24Eqk1rjYo1ljmOVZ9FSRtTU6bZ06/RJsQQd6REfJRiy/2jdEYE3
         al9AGm+EGAD6Nhm6qtLcNv+WnIiBZ4F6JIVOQsx2vmRAeZw/RKIq5SlvyouAIEvZYbzy
         PhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746670511; x=1747275311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkADO5RX5LKak5ParSAdhE3hkIpyJGjVDD86j8FGyjI=;
        b=US7Y2v3mB7GmadQY2xCpjcY0w8WrEK0D2vBPHY6OYPy3yv7OX9jXS0j5PivkGpwNKP
         mZlRQB+R0sqOWq5VFeVMBwrfs+8nQXCUknQhaTUdGC5fd37+v4Az8p3GteuRnfjGdQl1
         OA+Ooe3nQFQ2qBoIG57hd+vuuNEal13e5/HPh4cM+6CL+z/E8d6mkUviR5K7hGd6wvnS
         Qe6bOScCahLgVLvni3hVKwl4SvnzNqKYePf8IFRmSVP7IE+xU0B+CZH98O4YkIDvmTq/
         WrS3cJTw8P/mtqvMry5T6ydewZ5IY5mUGQOX2T+94l6bJnXQglzfvHPRk9eurwppKymj
         ziMA==
X-Forwarded-Encrypted: i=1; AJvYcCUfE+pCCQQ1Zx7X3w4nAgV9TWmjrDslWblei/jEbaGygCQfjGIiGKKOAPCHZ36uTrjyDiGV9HihYGfcawnvHew=@vger.kernel.org, AJvYcCWwDc5IUlyZ6LF/sndtQQkkQB5aX+bkO8hdbyBcejUKW+Z5qvB3iL91PVSyloEz5flGve1cgROFMi8ebliCTTfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkcIpDxkc5zmos0BbEWuEonvNA79r+KyF8kAApVgx22P/0sz3
	9hy5OlA0aucYr0J9DJuOv3NdpnbXCHshj6rFSkH8ZKUbJFH+YAd0
X-Gm-Gg: ASbGncu7S/GJ7iIAweyKXDQXAdLcq72xRgPFvduToiSZgBeyFWhE6i0H4tFDH4tPv7w
	sdNySXaGiNqBKdozDr6+vJ4BR1/CXxHCuWY9Niju+1zpK4UNhGlAZO8V7Sxx4qIA70JsUaOfXp3
	GPMpsuTTTBuKu/Vt8D2OOfvmtyJ32HTBCMMLHC4X7TV5SQNc/38ImAj2XHPdxwwks+S3QUjvwc5
	vHjBb6q0062N/UJe5yNb/QZtf1jdBcCoer7ondcWB5sLBvxJ+oSY+4kol8JSkBv0J0A5HBNUXau
	sHDiC0xnQ45AtpY6p+vXpolDDDtChKWvchDv1Xq+YedRloOdWILtB/Th
X-Google-Smtp-Source: AGHT+IF/g58dTcMUT9OqqraHwKir4gOqXcqsH7utlmYFK5Z6ygF7IDHvIjdM+rEucmwSxjt46URo7A==
X-Received: by 2002:a17:903:2ec3:b0:224:910:23f6 with SMTP id d9443c01a7336-22e5ee17734mr76937385ad.45.1746670511089;
        Wed, 07 May 2025 19:15:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fa7bsm102582835ad.141.2025.05.07.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:15:10 -0700 (PDT)
Date: Thu, 8 May 2025 02:15:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 4/6] selftests: net: use setup_ns for SRv6 tests
 and remove rp_filter configuration
Message-ID: <aBwTpWOovuXghcRd@fedora>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
 <20250507131856.78393-5-liuhangbin@gmail.com>
 <20250507163904.0cf86c59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507163904.0cf86c59@kernel.org>

On Wed, May 07, 2025 at 04:39:04PM -0700, Jakub Kicinski wrote:
> On Wed,  7 May 2025 13:18:54 +0000 Hangbin Liu wrote:
> > Some SRv6 tests manually set up network namespaces and disable rp_filter.
> > Since the setup_ns library function already handles rp_filter configuration,
> > convert these SRv6 tests to use setup_ns and remove the redundant rp_filter
> > settings.
> 
> Missed some get_nodename calls, I think?
> 
> # ./srv6_hl2encap_red_l2vpn_test.sh: line 470: get_nodename: command not found
> # SKIP: Setting up the testing environment failed
> ok 1 selftests: net: srv6_hl2encap_red_l2vpn_test.sh # SKIP

Hmm, somehow I missed testing this one before posting the patch...

I will fix it and post a v2 patch. Sorry for taking up your time.

Thanks
Hangbin

