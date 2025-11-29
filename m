Return-Path: <linux-kselftest+bounces-46728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B393C94157
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A2494E1718
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A271F3BA2;
	Sat, 29 Nov 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAKydBKh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A71A9FAC
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430861; cv=none; b=Q9xwdnN9SnbColJw8ivjf7CUakHnOq5vqeeDz7KENp1HCrAWm4hQW209f2ZauTLt1N8egNNzPqVmLiIJqApk+wvAXctccNibGGSowP7k2J0+R5kSNBVqgyWtwEArcwnWvjmvL0UDus2wpukbedttBOHjv7teLGl0V6GpBu7akJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430861; c=relaxed/simple;
	bh=98ShLA3Gc+8iz5Ta26raelUKEqRHNI5RcMvSUa3Fzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqrdqhtnPP2zsiyKqxSFLTk96mPCsmytJk3Df3S3AUOkCu8DNrjdZ3ir6JMgeWO4oGKudGBn+HNuCoMHJ4k9lRY1hifvIV5LYg0Ox/lmwvskMW8qvUGzUSAMZAx5PMGRNcESOCVrUeua2UXTBCJyA6f9YPswgIgTU3XbxyUdMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAKydBKh; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29555b384acso31775255ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764430859; x=1765035659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bbXgvlnENKnsdEGuYPN5PUkGwl/lkMRHa8r0W5LEG8=;
        b=JAKydBKhXsU0ISH+XEd016ZmB7u5XXayZU64X4rslL8+aJJE4J+QEmV0IXMgotpmfr
         pDtCeB68jznjPpy+L6bGWtsoivnKtKLKXeBliYKm8opsDjqVOaWG3/xTnxO6fLa7tzkm
         rh3OiJFh4zyxH0HMiWkWKOTqD4WVBCfZL3lZFF/oK6zPXtalQFCHBNj7dcfRHpcixUZ+
         8o+G8QX3o504DUHhEcs+uAFBem2qSPpWbYyngzWAL88tqmZe7wBUtNtM8HrD9CJTvMva
         pmKMY9MtNeShVYB40N591/YW4/sQsd4B/Ka+8Y++pxBqwa+JiqTgryEtfliFK2ktnNRS
         aGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764430859; x=1765035659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bbXgvlnENKnsdEGuYPN5PUkGwl/lkMRHa8r0W5LEG8=;
        b=HCPELz7RMRwnxUxL+ohHH8KqmZ9EwQhWyan1rvOB79+NlLSWBJ08W6sCV5lNgX2qAy
         vJLa5ihvei2LJuFqU9G+2vxNR6RKbEPq/fSNuvH4EdyuH+iSItwe+Vzvxjp6f02SY/lr
         /vJ1ZyvpFdSwb1zTt3sv/G1FX7dB0xHZJGtxAgc84OPyoEgpzSzzUBCKQ+wF6MiZgYqN
         LG3WgaNSUUGjLnERYlWV83BN1Z/8UG74EvuFf61oAWdrOCd630ZTaxh/PL/aqzxuaTFC
         M2WPITOcDREMEqv+HphE+PRczho5qljG4zodLlhioK94jKURuZTI52vC+auC2/eVQmis
         w76w==
X-Forwarded-Encrypted: i=1; AJvYcCXCuC1Qb1DS8mUjvg7pYAgZFRsghigrWAe9tqEigPkId1rdploqkFdhzWSroQ8x98ew9UosJJbUywXucvzxU7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTivePryaDCiJThLeQ0t4K6qxNUm1y0LXkwG7cMJpnXejJ2BX
	legIe5z3/UgT5fvMg3+LCk0tbIEmMFDwIZV/6i8XbjMkFwu1NckWQT8L
X-Gm-Gg: ASbGncuBuGLOyFbtJmSJAZZju7KoX58MOjEW3eCIydMIld9/hdd6GRVNjUcUIY//D4m
	X6KjdGQ87KP/rEA6WAVaYC4MBtLVUDJq3W+LWnbqVlwIuc+Z721SCVJRozeyr/GzHczV4gqmDkf
	Y71xGIf4Ch+wMpZpvg+mvzMUGqjeaIx4QAqw6F99Bmv7qzTUr7/kD6yfqtgFbCFCM3vb1nf9xYK
	yiZkB6XslG0wT3Qx4BPoLbB8J0yBCTb6i5Akm6XtRghkcs10jM5YQ4NAVMFEAnAH+eucxWeUQ7o
	oDy8V0PWtFGQcNmK2opjNtSwEAMzn1HSfBmINAG4ZRAoHYxxNuJPYwVqPhkeS1Fw31/6MigT59T
	ZQvKUkLRBuPz4WUJYpf+IGoEgRJr4A7DcUFLFnxYPh358HeNCD5owTq3+a2vKs+O2GW99KUmqkn
	IC2wiPJPOQaxRctEqyitIIunMpC3dHvX1kmGPgDMi7
X-Google-Smtp-Source: AGHT+IGR6+gSpgs55IR0ytGEOhQiXrSj5OpdthG/7BED4fO3xJA8Xtb2N1uITeOdeAVbOohzMgttKg==
X-Received: by 2002:a17:903:1b4d:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-29b6c3c30d4mr328707135ad.7.1764430859202;
        Sat, 29 Nov 2025 07:40:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7cf89sm76573825ad.99.2025.11.29.07.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 07:40:58 -0800 (PST)
Date: Sat, 29 Nov 2025 21:10:50 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tls: fix read/write of garbage value
Message-ID: <aSsUAvnn9dnwk91E@fedora>
References: <20251129063726.31210-1-ankitkhushwaha.linux@gmail.com>
 <aSrJTmtJqOX0rNDh@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSrJTmtJqOX0rNDh@krikkit>

On Sat, Nov 29, 2025 at 11:22:06AM +0100, Sabrina Dubroca wrote:
> I'm not opposed to making the compiler happy, but in this case
> "garbage" is completely fine, we don't care about the value.
> 
> So I think the subject and the commit message should talk about
> "silencing a compiler warning" rather than "fixing use of garbage
> value".
 
> And your patch should indicate the target tree in the subject (here,
> with [PATCH net-next]), see
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Hi Sabrina,
thanks for the review, i will send a v2 patch with suggested changes.

--
Ankit

