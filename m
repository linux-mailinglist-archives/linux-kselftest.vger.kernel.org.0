Return-Path: <linux-kselftest+bounces-49178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2132D33917
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42A10300FBFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5024399A6C;
	Fri, 16 Jan 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="WPtDGPHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735E34321C
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582039; cv=none; b=IczOCkpOhk1Rq/rr/99GmjzBZ1w1ZHt9xf8qQ4HR+xFhu9ta6roHa8gpjsfh42aD4rofLHNlRN9fzfVX86oz/Jt9hMLB4xTs6uOHUWz518ORo/HzbMTcEcm75GWrZM6tAsb+17xTn4xBmXC6jBh66UINaw7JdiYU78TTkukugwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582039; c=relaxed/simple;
	bh=+Q5MJCj4TVd4LpveiwsjRWBEpJtCsPIHTEKopKSlucI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPIrdpYxJYfer+WX9cuq7H/3QAjAcHykU26UEwaY2a/bzV57TldfmMaUpR3+LB0WTyhuaShhnv9kcebgjJoN8Z2n+ECuDRnsK+k/s+Z0Zq8yJ4Vvwqenz2kC9RhoEZRIC55nTgevhAckvA7+7g17XhnvEBSShwdBaEUtp3qCHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=WPtDGPHr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so27147035e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1768582037; x=1769186837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJzgUKOJB6oCUo0JSuCqlChu8wca/s3XgI3abK0Mh6I=;
        b=WPtDGPHr3jwkYBgL7DEwh5KiVuzmiqU1JR/yHeVw6iJDr5bJcFt2WBz/IvsDv6t9gV
         wQRgWVAdpndKN5GwVOC4SD6LJvSrrCO3i20TGkUr8e18OlcmSspBgLWYJkjgisoT9qZb
         oDVESTUyfa6fZj7DIdwFsmLM0Qky9wFebsIXcbJ2TIXbJmixEIuOJu62PK8bBHIHO3t/
         6o6iRct81O58wfUtDnsJcOcitRMrxbEkUwe3Fs3te8cDjPJdwCMQE+Nts0mbfeaP/6H+
         r0jY7YbCQYGqzwLPlEZT8GaU8mrkAFYoN+D3B6iJLPa63SG/2NaenLq731/UJVkRAeLX
         tLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582037; x=1769186837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJzgUKOJB6oCUo0JSuCqlChu8wca/s3XgI3abK0Mh6I=;
        b=G74lSXcWUOvPFUG5ENXC3RZf6C26VuDdTeoXw1E33Ghq/aipktwtm+iyj17fxQ/hAq
         pKlNSqacbdR9u6JVnoGoRu7a3LyUYr+j5iEEAemfkWur2E+I+ArtGRlsqLfGeeqAxUlR
         dzblrR0cMWxJ10ZLLiZsFeHhUm6wZ7tfs3lNqV+IqAMQHr5CNqtdLKpPNizqTMQGUnuF
         OtctY0DzNAy8udOf0mfE5r1HzNZeCd4Zk/cNIbQtzw2ZKjWCN3qA4BbGdOBSVtVsPYt3
         NVKqJNlRqZVqFgoypk/gVXmZFy/GuMiskRQJYWPI17VubOvhOeRblGvtixHIiSBv8ir0
         47AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo27laGCY5yf7OKuqvln7pWV73xW83B7Afz8iHbwWmkvm4RgVMXW544TM6oMSK0JlYXyNCKwWgC2ixZfsJJyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZShfMLzb5QtaiXqAfeDE7uPi0juTWGrDBQxHpGzEnpjmqQ/6F
	ghdloJO9LOzlCTHIcITIS/tdt2+l1paEZJb2qmfJN68MQb31GITpO1uUJNUOervdO9vvUEh9PMr
	kuogv
X-Gm-Gg: AY/fxX5G7yozwEbp5+q/qw8NsYJYXJuIBtNDNSTRGC3mvFqhoR6qrtQsyMfiO3w2gl0
	50cw1mfuwbe7/h90Cqw8VHVncltoixEfs8u9iPa4jF7MQDqXqIGgafiojZxIjHlbKdPEo347D5b
	Qr8iXL+SFFTQFmaFATW61nOAXb8QIhSiVjdnGPGjBs/eEsGFD1Q+q8+QoJ61D+iF8QRUkPRRq2P
	DNAxMcIvwjFU08TT2siQPHXaEdnW4CVWGSfN1Cd2EHD3DapMHhBUUtNYREU8WQ0h9WQ7hJwlqz/
	o+q1wm/AgpcF5yLY51LesZmUtgWcmyOZWUnnthfAEF4zfJlXzrFuN2+ThPr5EMZrlvjQuu9m8O1
	cdOKNDt7XhwBm41dslsv9YAVwmAE6rKdh7XTEtsXl3StfvbXpl89WPNZapIIXogBTyEv9e1WYgG
	2mmYN3XsKOXE2k/bPPXRcskxcgkmaoKlz1XwX4PAtnMIWP1Sja1bgzy5UFy5eE6p1T/IMr52YRf
	7zpGaz0QQ4=
X-Received: by 2002:a05:600c:8718:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4801e2fb9e5mr46263395e9.2.1768582036182;
        Fri, 16 Jan 2026 08:47:16 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (nat-184-7.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe2c04bsm19443975e9.8.2026.01.16.08.47.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Jan 2026 08:47:15 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
	id ABF0710FE3389; Fri, 16 Jan 2026 16:47:14 +0000 (GMT)
Date: Fri, 16 Jan 2026 16:47:14 +0000
From: Jessica Clarke <jrtc27@jrtc27.com>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: davem@davemloft.net, andreas@gaisler.com, brauner@kernel.org,
	shuah@kernel.org, sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, glaubitz@physik.fu-berlin.de, geert@linux-m68k.org,
	schuster.simon@siemens-energy.com
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
Message-ID: <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116153051.21678-3-ludwig.rydberg@gaisler.com>

On Fri, Jan 16, 2026 at 04:30:50PM +0100, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
> 
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
> 
> The return call conventions for clone on SPARC are kept for clone3:
>   Parent -->  %o0 == child's  pid, %o1 == 0
>   Child  -->  %o0 == parent's pid, %o1 == 1

One of the benefits of having a new clone3 is that the interface can be
made the same across all architectures*, unlike clone, which both passes
the arguments in different orders for different architectures and, in
the case of SPARC, has this weird return convention inherited from the
SunOS syscall interface. Is there a good reason to deviate for clone3
too and keep this annoying oddity going, that requires special-casing
SPARC when other architectures can just syscall(__NR_clone3, ...)?

Jessica

* Even Itanium's clone2 could have been subsumed by it, as clone3 passes
  the stack base and size rather than the desired stack pointer

