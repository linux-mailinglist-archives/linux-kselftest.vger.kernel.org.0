Return-Path: <linux-kselftest+bounces-26467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB2A3271C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 14:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DB71625B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157420E6EC;
	Wed, 12 Feb 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bI9eezHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116A1F94D
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367031; cv=none; b=Fr+Wq1ABNRqE57bleBObVAlG2SDh8t63sp+v5rod40AevTu4kLKv0A20MmBIJhhbHfWrKSaYPLy3cnGAMGUp5oxwYnfSMZqzcRh0NhQK6WKttqxxXCWwvAZ63SU41+O4i+0a6MhayRrV0ByUQfEhiaDjBzqXu61DLYGcFSIS2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367031; c=relaxed/simple;
	bh=cppRDKTH5X7+PhdoGd1D1mSrJYsVfO2+TtgwU+r5HiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtsgRoP8V0v9pLIb2uJMBN9gUgLjRwkoVSR6pzGBTieBY3HXtKfhx+vOaPRUQ6ovPR0t++ajr4gHK6srxS0lHxT5I51xgs3GxOkYSkcE8RHT02bKzbv/psFpggjm/x0O1IUbPHpxXhaet7KrqLc1FDPkTMfYJ09t5Cr0riw9r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bI9eezHu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c4159f87so6767835ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367029; x=1739971829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq7SdSXo+JhFwWwHQa7/twUcE0+PVputBf+G7gcfT+Q=;
        b=bI9eezHuZ1YRlXLL26JDblxdtNGRFf09dr3q1mu7Lynz47ayzTiLJjJhKXhTy/9k+B
         0D4ITt6y8zAWEjZ/FVrGl4QY3nS95UcnG7ba0x7HqugSdeMpRZFhqv9YE4C5N+qjDbQe
         LoFfdGwBDdNyt6mq/GpTEhAdKGpI+BpwLuogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367029; x=1739971829;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq7SdSXo+JhFwWwHQa7/twUcE0+PVputBf+G7gcfT+Q=;
        b=e3eggrqWE9b0gKdtvQYtYgY37oShSNe4556153QU8kX4WmWpxXaXB0wjIJW2mvCvqu
         Cubsv84Io2AJgEVm5DD9dDi8Bs5FXG47CY9x+DNQvsHLTK7v+cfUqtuMiLT1wPhAa84n
         5SyzcF2FnN2uJDvBpT709o5BphjvCnGRYhqZEKVSzivteh/e9b2JRfn8j8Xzd/wCig9C
         giMqE6DcrntscI5WV8moVslrT7GXWCN9b6W97hihBeYdemoZpS17AyaPa66+i3nICzgp
         klSHlrLVROCKtte0/S3MjJnb+mGwQy+wAGkkdLTWzpck1Q58K5Wd5bT5gbNX8yfZlCpV
         Qt9w==
X-Forwarded-Encrypted: i=1; AJvYcCVMO9f6PvSg/ukVUZSZv3e3gdn/SDY8x1Kk8nCTJbGJSby8pT6mMkfdcKwIa8eITtSPjAP6XFk+HJZA5E5jlL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaNneVRE5WLS3tLiNUx6A4LQXWGE6hnDcBNPKkAVIx4iHypOu
	mCiTPsUkirMNvNvo+wqeBEBOgumCRdYuVJjx+jGrNfr9lB1TrKR8neExq48kLnY=
X-Gm-Gg: ASbGncu+rEHtloU5Lr7iBmK1RqEcMqE3oTMv8UiBCHN5OTtcq3+0Wq8UUrDemBE7NLI
	uN4xef2KNUuPbfw7zahjJFnW7gQDxJ54cvUTDcFwc9xYAzIMPOmT4dWjs1lNseilNjyttlAUJb4
	R0A+xGGMJMlHLwNF8EKkdaoMuN3D6lLoMqKB7Bc+jF3OZ0ZroDAz98UMWL2EbXNEiUpoxc8eWlp
	+DA7ix0zPtCJ5VIeZfLWNGqdD5NSh1FWaxmZcT+XgbLoFVXfZjcMKLeo30Diz4oyCPMbwyiMfEZ
	XaE6HwYmM6Sintyjh2UZ+8TGg2zy9TSrlTrRmaIFnFf0pFOSYdTMc+aCvA==
X-Google-Smtp-Source: AGHT+IE/UeUsPjMO1gpNMj4yctOpDIpP/4atL2aTr+WokGGBV4mZ/QiJjiwEjLs7hX6m+RhsVtK1Fg==
X-Received: by 2002:a17:90a:fc46:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2fbf5c10491mr4674200a91.21.1739367029580;
        Wed, 12 Feb 2025 05:30:29 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b4c52sm1448513a91.4.2025.02.12.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:30:29 -0800 (PST)
Date: Wed, 12 Feb 2025 05:30:26 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	horms@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6yiciovTsNpIAJA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	horms@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
 <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
 <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
 <Z6urp3d41nvBoSbG@LQ3V64L9R2>
 <Z6usZlrFJShn67su@mini-arch>
 <Z6vRD0agypHWDGkG@LQ3V64L9R2>
 <Z6vY_LXp3LTp7qWV@mini-arch>
 <20250211183706.5b53ee5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211183706.5b53ee5e@kernel.org>

On Tue, Feb 11, 2025 at 06:37:06PM -0800, Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 15:10:52 -0800 Stanislav Fomichev wrote:
> > > I can't comment on NIPA because I have no idea how it works. Maybe
> > > there is a kernel with some options enabled and other kernels with
> > > various options disabled?  
> > 
> > Sorry, should've been more clear. My suggestion is to add 
> > CONFIG_XDP_SOCKETS to tools/testing/selftests/drivers/net/config
> > to make your new testcase run in a proper environment with XSKs enabled.
> 
> +1 this we need for sure

OK will do.
 
> > > I wonder if that's a separate issue though?
> > >
> > > In other words: maybe writing the test as I've mentioned above so it
> > > works regardless of whether CONFIG_XDP_SOCKETS is set or not is a
> > > good idea just on its own?
> > > 
> > > I'm just not sure if there's some other pattern I should be
> > > following other than what I proposed above. I'm hesitant to re-spin
> > > until I get feedback on the proposed approach.  
> > 
> > I'd keep your test as is (fail hard if XSK is not there), but 
> > let's see if Paolo/Jakub have any other suggestions.
> 
> No strong preference. Stan is right that validating the environment 
> is definitely a non-goal for the upstream tests. But if you already
> added and tested the checks Joe you can keep them, up to you.

OK. I guess I'll just leave them? They are as described earlier in
the thread.

