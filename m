Return-Path: <linux-kselftest+bounces-26156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81864A2EA93
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9271880293
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B21C68B6;
	Mon, 10 Feb 2025 11:07:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E651EF1D;
	Mon, 10 Feb 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185650; cv=none; b=e08TZeXPJE+QAjpvOT1KVZ4t+6GaJ80hZDz11wN6cUFMStzIlco3QM6a/5XNsmAQkgHYKJGgUyNDKSmnGCONuDmYvScXC0hXnv44foNXVHSqRLKORjEJNL0SU/s5UpUzR+VUgstLxRD+t8B83EnpE+fRYls6sdP++WtvgVkqirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185650; c=relaxed/simple;
	bh=p3RrExhhMbcybY++HDmJSat1lWJaRselOq7u0dkhjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfh5ay27sDWp79+f9SXU4YYUmIcgRjYFo8mDMD9bUzhZKeheD8HKKC/D6jbdeK7dBbpG4y7ZV2iAcMrAZbGAcXkjSydF77JXFt8Bk0CgYW4XycKnbnazVD1mg84tAS0bE3hRQGzZ8pR38aD1yo2YPZk4vcQhvvZr1CD1W9W2Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab77e266c71so598620066b.2;
        Mon, 10 Feb 2025 03:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185647; x=1739790447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAgZVVzs1qooCCE2t7DyLuVDHyt8kAQrNZT9NH7Ms9w=;
        b=tFyvCPBV24llzcr8V9F/cFo6cp3N4ofXmEbfll+bezUsLq8crel4bw7eNEg6jT9aDb
         4Bw3CeWvoRfUIoQ12KOQjcHRl6AZ8QOTp5duz5ey1ejDqTCUGocC9XFKkDGF8/vakDy2
         Rmk+KlKVSETQN8TXjqFD9yO7E0kZ49z0M742QzGv+BwhhzJk4TGmpChfQvJ8lVwhkapq
         vebxCM+t2Bw6S6OtpTe3dNxxvWEfuMAS5BptdQ9uGZuiPZuvbZyfpHWqdQRvUjziSLks
         q/9G2hVu8kMHu6WirN2NlKoTHS7aeCx02Se5mYCYaMvz/n4/6lvgAH98kyIVqG33JY08
         4o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFXAQERs+xq/kJ4MLzbt73BPhTLz0rm7yUz0/f8EHRNNpOr8Gcf6CproA9r+/dKSGRbBNmogk5OYEWgg2izba1@vger.kernel.org, AJvYcCW6ZS6pHevWG3WArxgVUf2eVvp71m5H+s3R2jb2LUpC3wed4D/t2K9nh0BmlEwwa76daBsD9WlCl+Ae3/YU@vger.kernel.org, AJvYcCWzeqRXRgfShEtxGQ+i5xNjqsi7NlvYW4s7LFzoMG0Dbz/JeNRvooVDTg038o1HdA749cmwLXt5jyQ=@vger.kernel.org, AJvYcCX/cKYmADmNwNw8+ivUzrhJHb/45B/yZMfqKnJpP83H6lBdX0uddWFrqjyBZeo8OvQ8kaCdUZXz@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPqtOekLb3LOv32jNdL2ThoXwMbLNIFBWTc394SjWvttoimja
	imyembexSzgYCxn/3BCrzaDpt2S2OFj2qVbknAb2C4I7MveXmzcB
X-Gm-Gg: ASbGncteTKyF+7t0JC1onnBFM0vK8sOUVgMrykFxyTOtCDypC8D1SPJCCP+vOmBO35e
	RE/BTjPnT5ZvZ5YL3xVg7DyitmL/Zr6B+XqqvvGK8n780pypaffr2nv+0la6tVakn3UJpYkc10p
	D0a4wN9SNeFn4kvmQ/9HG1MvBZ4n0KTvuL3YONAuW4QjUdZYbfaLJ2qS2CPE/uX68EPxZXa/H9G
	cVeNu4LIsfW4Lgxy83ysSSDjBZGDkENfZVrbZ+JphHX7DU5xvEZar/z3UxN6235Rmr5rmPZ2fcm
	dM4=
X-Google-Smtp-Source: AGHT+IENAJlo7TsBJws4Qf1vo99U2cLsdl6/G/Z/CVxbymzOGRwCo/AL0b6oPbO9KfI+15t76NEuNQ==
X-Received: by 2002:a17:906:e4a:b0:ab7:cc43:c51e with SMTP id a640c23a62f3a-ab7cc43cffamr144056666b.13.1739185647150;
        Mon, 10 Feb 2025 03:07:27 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ced6fe0dsm68989466b.179.2025.02.10.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:07:26 -0800 (PST)
Date: Mon, 10 Feb 2025 03:07:24 -0800
From: Breno Leitao <leitao@debian.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rdunlap@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v5 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Message-ID: <20250210-crafty-snobbish-pogona-83e904@leitao>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
 <20250206-netcon_cpu-v5-8-859b23cc3826@debian.org>
 <Z6Vm3ny5VN6mcKJN@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Vm3ny5VN6mcKJN@archie.me>

Hello Bagas,

On Fri, Feb 07, 2025 at 08:50:22AM +0700, Bagas Sanjaya wrote:
> On Thu, Feb 06, 2025 at 03:05:59AM -0800, Breno Leitao wrote:
> > +.. note::
> > +
> > +   If the user has set a conflicting `cpu` key in the userdata dictionary,
> > +   both keys will be reported, with the kernel-populated entry appearing after
> > +   the user one. For example::
> 
> In that case, shouldn't the kernel autopopulates numbers of the rest of
> CPUs?

Do you mean listing all the CPUs that are *not* sending the current
message?

Let me come up with an example to try to understand this better. Let's
suppopse I have a machine with 64 cores, and cpu=42 is sending that
current message, then I would see the following on the dictionary:

 cpu=42

You are suggesting we send all the other cpus, except 42 in a "key"?

Thanks
--breno

