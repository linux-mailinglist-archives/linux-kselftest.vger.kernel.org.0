Return-Path: <linux-kselftest+bounces-37453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E02B0809B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D7BA42989
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 22:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCE2EE5F9;
	Wed, 16 Jul 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyO0ErHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3538262FC7
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705786; cv=none; b=sb3jx1QtbrTJOTQTDja+AzlmtjMq67vYTGJ0vTU4u3EIP/2dri/CdkDtjjKPKcHcom14WNiTc2PNwNRfQ9qHHNtMt1ilWnqr9sPgTKcqtMDn6k8HHYQTWmh305OQBenR0x1Ru+l8meTmw6RQffuSP5YzjQb73j87BkKEVh9ONNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705786; c=relaxed/simple;
	bh=QGSG1zDzy+FiAfvcFqvFZcTAf3kiAzOmr7sGlxp5cIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvb/gLLGusF2ZxnBqmEtKDtFTb9zrhI+rMrhZ4N5Jw/1EZD5WwZMCOf3CjxIbbEUgvYiZUkK4k+P17KJlWIwH47U1DzxmCDA5l4/+vkFwwfey+o5jNYNKIe4mHa7Jrl4I7Jqv5iOx3/E9U066zMPs+hbssmsFfp6DSOzuAt/N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyO0ErHu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dd9ae5aacso29565ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752705784; x=1753310584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yqqHbMa/s+cK5C5oiRrHKnm+0gCY7ZLYL73js4DqeU=;
        b=MyO0ErHuACRGCxboTAQBemDgvLP9ysrrpF0aDPhMiIOIIW/cv6OiU/z5zmvaLbsMQY
         dtEpBWAN27Ue+W+3ZPjFiwzZuK7bp3db4pXvte9iVIFwzPreeDPvtAX/dVhdl/8ZkTgu
         amc+qqkCHmHsFbXKY72UpMSLPHtm+7v4a3/gfIaqorlf9cNKIrW5xtUxrNOuRUecByHq
         n76ivGDdPHDneQTzROojZEP6Xmtp4JWYBxLzdEe2tn0hkt0MoSO2+qjQWjcifJZfnKMZ
         HdniZ/6kegqM5wdY/s8WoArW/hQupU9ik5kLshGP04DiRNG2SO2TEsccVPlcIne7aqlr
         cnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705784; x=1753310584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yqqHbMa/s+cK5C5oiRrHKnm+0gCY7ZLYL73js4DqeU=;
        b=qebevI4WorBRYpbPFWH3qqGK6EmXB5uaHwN4C/Bz8J1DaM0Qa20XFpzBQQJAX4PI06
         zI0PGlkSaE+mQ1o2ZsY4c/sZvvyLFWLKw80ws1tXCe+a2pXVLMNo/H7V431h9hU8grGB
         r51FKzglbIx5lmaahRmYfc9rrqIcKTLt0yg4vRRmJJDdhmbeGNXd5j9KCLlMDU+SN81W
         KYqisy28+hofSBHK78xL90A8FIU44BKMpXQis1n1v7You6IrTe/Tpx8dat6mH1K/vfIl
         FswEsqNr/JV4aC/yAov67IDZG0u3iidnL/yBiY7zmIfXv8sraQAYzDdOJG9qBwNxNcrN
         m/2g==
X-Forwarded-Encrypted: i=1; AJvYcCUY9q2Cahki9+CDxrtsSxyAX9c1W4HnHB2SMoCAXh8wrtAuYNDIznDfFsV+YmYZT4vaBK6St/ZcE3zajeGfInQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReY/wA0M/9gKKBd9LYW/SN9XLKBnfq0WMWiibQB7Ra9B7E3L0
	wKMDjklEeMoZ8VF3doynap7SJw1Oca5GhA6UfaysRkQWHrs+DDzSPitDn7p1/0ZQgA==
X-Gm-Gg: ASbGnctF4evGdtvS5sndpvZRKzPMlaIyP1HuTEonM7vfobw6hoYqTMDRDEAnEHa75Qj
	lxXIMfzdvI4YnwZxWdqA6eUXf88QlJ7rphXd31ap1GJPMPQmSL9Jjj/eMjqVTSKhY2XhLjMCkDz
	ZM6V2qbatR41JwuduDfYcJopbgqBe4JvS13Bf4hPt2q2MpgPShTcHFi04Nsgmhox/fO/vRSBEpN
	hwBECz0xABiV75Bl0hYOiuNGpxPPm4hBS/itq+/J1m9F4Df9K3jyYNcGJuYC8cKvxrGxS8hMS2O
	rfhbdUNRzS3uzZWcphzDkbYB0JqMuP5ZMvMVX6PlwfqkypLW+sqh4riV1CeSrLBVH3zspDZAOVc
	z+ngjRnZlQEkpsUWdSjsVG/2FZLh8U1CbZoI8IlJaxGfXv3Q9hrDYE9NgJQIja5Q=
X-Google-Smtp-Source: AGHT+IEH4DP66Y0IGgJhHWe9Fg54RKlzSO1QLwEYkYL9dH9+XXQwjB3OPR1iWt0s2yjq7dTSKQZGjQ==
X-Received: by 2002:a17:903:1b0f:b0:223:ff93:322f with SMTP id d9443c01a7336-23e2fdcce70mr1238505ad.2.1752705783607;
        Wed, 16 Jul 2025 15:43:03 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e14e9bsm14353649b3a.49.2025.07.16.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:43:02 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:42:58 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
Message-ID: <aHgq8nub0DaIMPbp@google.com>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-5-ynaffit@google.com>
 <202507160735.C76466BB@keescook>
 <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>

On Wed, Jul 16, 2025 at 03:28:49PM -0700, Tiffany Yang wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > > ...
> 
> > I'm used to the "#ifdef CONFIG_..." idiom, but looking at the tree, I
> > see that "#if IS_ENANLED(CONFIG...)" is relatively common too. I don't
> > think there is a function difference, so I leave the style choice up to
> > you! ;)
> 
> 
> IIRC, I had tried using the #ifdef to inject test-specific code in some
> places, but that created issues when we were loading KUnit as a module
> because it causes the built-in code to be built as though the
> "CONFIG_..." is undefined. Consequently, I started using IS_ENABLED by
> default, but I'm not sure if it's strictly necessary for exposing
> functions with a header file since I'd assume "CONFIG_..." will be
> defined when we're building the module?

Right, IS_ENABLED() is the "short-hand" for ...
	#if defined(CONFIG_x) || defined(CONFIG_x_MODULE)
... which is what we need here.

--
Carlos Llamas

