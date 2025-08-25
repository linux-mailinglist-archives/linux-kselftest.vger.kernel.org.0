Return-Path: <linux-kselftest+bounces-39857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8289B3462A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AA188FB59
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922D2F2916;
	Mon, 25 Aug 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd5F1k10"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0C1C8603;
	Mon, 25 Aug 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136670; cv=none; b=KF0NODkVqh9K/aVOD8tMq+bnd5XmpGtEikpVTCVhBnL3un/6qFW4/rYhu3u+7wxUJPpfvvUZzkzPXxvVu3wm3reaKqaJdRFF9zA+F9WDHyYAVVeEWQBPjRjl6ldoKImtooJlZPAgpqkFKnHNsEKI4k16IBqkcqR4+FTm8coruDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136670; c=relaxed/simple;
	bh=qXXtjVyJbPTnTSvv1jiT8zoxv/mOFKWMVHWirfu4Q9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es0ULExQB7umblV8dXGXdc6lFF/JrvLudbQWVF4KlRxpPh2kqvos48IP0zvqjKxKqWrMTyFnGADWiwsLnIIR4s6UQPL/kt7YcqG7IoyQs8KXgAXCUT5t98wEKa+0TNGNPURjzKDclkHRM3q+2YweBIF0mij5YnADBiSmSA8WApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd5F1k10; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b004954so35958755e9.0;
        Mon, 25 Aug 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756136667; x=1756741467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsoEtYln4+6Ly5LWRix+6Kzr4MOEUJ1YKSS8CRff6kM=;
        b=kd5F1k10lkTlnnNdEgSkRxj7YT+0DFtfg5Tw957f4rrblU5ugk8y5szNioEIexGNKD
         gPh3b1kUOtpnHUU3ci+lvwEHWW2UY3+YFhaFhEDlbPyMDa5rWQsKSdwDxT6X0Y0lroEx
         fQTYoOWcRq0JFtOU8RauPnZ6t2vEVOim/dDEk09C4aOKnOSSiHMHFVWMp/UjF+mZTfUW
         TmPAY+8SU1hqMGxdW95gyjTcS6HJMAlu4I48yKgtIddSiXnpeoSD49dySuOBRSqnP4IW
         3tAtRctfSySYBwLBY9fxDR9cDvkp084ueYOgVGct7qxWNHs1BZbFPqJpACJamzdAvbLL
         wt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136667; x=1756741467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsoEtYln4+6Ly5LWRix+6Kzr4MOEUJ1YKSS8CRff6kM=;
        b=dQlyCzWSawmj5ZoMqwCTwjgfZtNn1/1NF2D27TxtX7Xt7KcXRXQxad+pshAFMcY7he
         dLHAOp9YlTCTYIdNzWa4cM9C5CiNofohOme+P11VLKqdNVbCtz4+impDcYD8PfKAmMCJ
         miyGl4EXfZFvQ8kymTXuwNPjFNQBM55pM9QKft5+ACQsPWlYHwb+YWMyMR8GKPmzFTKA
         gmt++4MEsveooWq8xM/um0STVo9uhod3fajQQtbvfBlLeMKz3kg5ass3T1Q9glcxsXiY
         wjddmMcIJqURMtysTtXip7puRlGFFZ4JQ0+vbW+Ay7BOD4EVMu0w11TQeSIBK/+OR4ox
         X8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU1LKXEl5etDCfqpaqBE6TCxl0dvGIPu+j4ZedGQgVK8K6MDaJ7SuSo13ZLJylExiXVYE7VlyKt51Q5hPw=@vger.kernel.org, AJvYcCUksp79Vfzpvz6N2Iq5fHPKhNa0vAPypR3QbbQcSd54Go7N5FrJFa3ZhefGlwp5rjjqoycRDaQOQYBSHHypxro5@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPza2xD7dxKZZlf8npMut6GOOS+5WqXiHMH/VBhiwGA5au8Wy
	7zhM8X6O4vs6LPNSynWCR8sf0xMwgcfabpNNUz8CpCidfA2ARqQZanCe
X-Gm-Gg: ASbGncu0r42NqOjSoVyergVeL5oV84hchoKf4csqHmWdAntePcSpV1rb8aOcejsJb8t
	w97TyotSrBRnGrbxuRXp2I6eDXSvMronPPXNuGo8m4ho8rWN4tK9/Zw/DzZn3TLkWBo+b2ZmGs+
	/d0w72aVQrSPvfjKGfK26jHnIdwnjOiIa1LgDAGZw58VzSnSzOeaZgixUP9C31yqoq4WSvClJlu
	+Q8028H1ZvTAOI4dxEsnvwcstAL2ELtSR9E1RUnUQj5ZwkkT9UkcziI50nWtQ8YUYiCQ+KNCwB0
	+t1oZrN2du9nlZNxcxS+GUpgN0109nhG5hQlHL5mKwhXJYlCqSaFjkLybsQ7SlIEI3mGvQQdXJ6
	RH9Cf4aIBLqecn6cy0C8/MeojZy8CuRom11keg0oI40gu1UmZ1z98XDf9x7I2l3xhJW64DvFIF7
	g=
X-Google-Smtp-Source: AGHT+IFSi8NXd9p8dDHHrT8TXcVru6c0IjGWMlP8jM1KABVnPN67yWWMt5ZuiIUYpqnay3gjKhFKeA==
X-Received: by 2002:a05:600c:1c87:b0:45b:4282:7b61 with SMTP id 5b1f17b1804b1-45b517dae7emr101078695e9.35.1756136667074;
        Mon, 25 Aug 2025 08:44:27 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cc8sm12028458f8f.36.2025.08.25.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:44:26 -0700 (PDT)
Date: Mon, 25 Aug 2025 18:44:23 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Eric Biggers <ebiggers@google.com>, Mark Brown <broonie@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] selftests/arm64: Fix typos in malloc return value check
Message-ID: <u4bv3ypqrdaz5klrvs57ptp7tu25etf7xzvoytrgnz2xohiysj@vua5mcbpznio>
References: <20250824131647.490439-1-zlatistiv@gmail.com>
 <ed07c6f9-e389-4387-8585-6f1206da1a07@web.de>
 <aKxf1X1u8QHAdvqW@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxf1X1u8QHAdvqW@archie.me>

On Mon, Aug 25, 2025 at 08:06:29PM +0700, Bagas Sanjaya wrote:
> On Sun, Aug 24, 2025 at 03:40:44PM +0200, Markus Elfring wrote:
> > > Fix double "-ed" in malloc return value check
> > 
> > Refine wordings in error message string literals?
> > 
> 
> I think what the patch author (Nikola) intends is "The error messages' wording
> use parallel structure device, where the second verb should've been in
> infinitives form. Correct it."
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Thanks, I did not expect to get schooled like this (in a good way of
course). Should I send v2?

