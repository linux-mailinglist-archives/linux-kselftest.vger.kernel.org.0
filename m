Return-Path: <linux-kselftest+bounces-39613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1AAB309B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 00:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F3620F28
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBDD2E2EF7;
	Thu, 21 Aug 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmBZ2TUB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D28E0F;
	Thu, 21 Aug 2025 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817033; cv=none; b=cf4WzQgnAvAwr9DM47supwUxqJrfyDfvPj+rTJbyTL9r+Fa+KGVtodHVCFpKf34uvkSOpWQLtPzAcZTiTfwThaTrn0H2f/Vq9qpt1HbgqFfPNtGN+1SAXK2vHmQZgtBDphuASN3vJGGHenNVDCiRWuPfVtknx+1MX8Rh2/Vi50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817033; c=relaxed/simple;
	bh=gjNGlFYrWdAxwJw9cFMTACnKXVbNl/94mhTpU0ua4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMP2RkD5NN5lv2HXgBIF32Iw96BMcak50hhvsL8doWNn8NriIABVuOAaSvXxS3UtWY9tjmzUDt74GcN2Sx3xwQ1EaAxWeJsViKrcMDRWhdmc/nvDeA66LT6iiGHEERJQLZPQ7zfRq9DjUltenxua4GtW1EnCMPcXOYvzeVNCB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmBZ2TUB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so11363255e9.2;
        Thu, 21 Aug 2025 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755817030; x=1756421830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLKs7kTK+4hcjMq7nRN9dNEk8LtEip2NyviTVvyZITg=;
        b=KmBZ2TUBNmnp7GHdf6+JGTc3CMdy/brvG+NQFxH8Lfc8k0T+wo/KURDZnCFjNBeaPv
         l26FeO+w2eJv5ij1pLzMl33YwiBIAhOCACTkIzek5/bbROkY3+Xu+XVXWFF1hkUIFTez
         6O/HHEUsYTFgwWdhG2Ct+O09XDb39T+cxcBd65Z4X8KCn5c4ng3oXu7khulkMD7dilu8
         L7D9aF6GwFh5+Rsl/XXoqi+cVbiV4MLR1QzDKbe1LgF2nzjom2T2JikmxYYTlmXWc2tS
         rqomggLQC7JwqcNsOHmIN0DIxZJM4oys2oZWxH8bqUV0Yk/qo4OwVE4PYmua1ojjDaX6
         EUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817030; x=1756421830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLKs7kTK+4hcjMq7nRN9dNEk8LtEip2NyviTVvyZITg=;
        b=V8i6R0jkWh/aTEwPw7TB4ZPktaiNtASmkPINTHySe1P0Z7Adon9nSQU0RIYd8SHaYD
         q0l1gDqlNYlQlXJV/6xZv09mGt9UBt2xQOow63NEfOt20IbQJs23khw+FTnWIWhuMvwN
         XVM4tSbpkOjaoSoIUG0CYYz5eD/XvctOq4A6HAwI/y/P3BLiQ99omMcNOe5K6JCuVdXz
         W8r5gTCqSegmpSAkfPd5WvnP6gXu4b8yFEYmP8hlhLta5bcG6LEgwPfmiNZivDwwsZnx
         U4XUW9rUofwJQ+V/XvkY8wovqNrXzes/4WRKO14a2UUIh5S0EAfnyc/DyvAjCEnHF9rz
         DFug==
X-Forwarded-Encrypted: i=1; AJvYcCVSdsLQlUh/InG+qwIMbjclWOX/ORjs2c87T23ULIPlYFlkXCk+kRtb7tlrQWNFOBPkaZV1nnrnOB2xDhM=@vger.kernel.org, AJvYcCWIl0Bg2lvfNsQvza40YJOKrI9yWYrwgJFIONbjkvTQckg6BsDG9AfrF8NZrcb9TqQRh9UMNSJhEKh8L4Y=@vger.kernel.org, AJvYcCXiRHqiwEZifh5/f73P2is727thzvsoo2geLgePsJ7uIPHYMW5M8PYkCNJIlfmJc27oapaqznVIkPdME9S+03tR@vger.kernel.org
X-Gm-Message-State: AOJu0YzogvRc7REfcwc8F5+YOd7LVQA8bEdlpSABSNZ12wAZh/9G0mhJ
	aUVkFKmjTEiyoExSBMmEe3ueKyw6oZac2pGUcklB/r6SqQat8U2W6dSW
X-Gm-Gg: ASbGncv82xK7dEdSKfUSDPaFG/bdT3Y7yNWhR1XxK7OmJXVZG9E/nTMuphEKvUS5wFN
	Gh4q+baj6zrEea88UTdRGjkq9finIdfqEvUl+7cnHKoRqPefg7EeNn2GO7GAPG5DvR6WAMh96yi
	4ovIXad083LGWritPUJApjUsMMC8+DJ2yrcColUQQt/7FJtdTeOyk/UjDTnY/3mTWsLd4/4L6mM
	rqAqePvO7ebxJGmYByz4fDvhfEU2erLhN8Ji8YpplU8JqiZuwCEpd/GHjlBHo3n686MjlWtoB5O
	eLpbH3gWrA4liXHm4tEBEsL7g+gxbcNXMrNXOYQWfvHT1PM9Vr3Dd6nugorzBe0FaQRnSddMbXz
	nQg2lRyFfdEdJpF0j+epOsAqb8hmrop4Pubn2J0aGRe7RMnxEj2eBzMgQXYH2lzot8NTTOwUq5I
	U=
X-Google-Smtp-Source: AGHT+IFOkdJXi/riVyjR61X1ulOdIUxV4W3ij/Q4IWrHFGzdHXPBWukoRxT8mrsmftUQOsDLFBCJIA==
X-Received: by 2002:a05:600c:3504:b0:458:caec:a741 with SMTP id 5b1f17b1804b1-45b517c5d8bmr5445465e9.24.1755817029657;
        Thu, 21 Aug 2025 15:57:09 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm12615605e9.25.2025.08.21.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:57:08 -0700 (PDT)
Date: Fri, 22 Aug 2025 01:57:05 +0300
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
Message-ID: <uzfke2ry3rhdirqpdb2bdjkoemj4rgtfwsio7yf5la7p3p2ait@6umacnfdeto2>
References: <20250821200132.1218850-1-zlatistiv@gmail.com>
 <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
 <CAHjv_as7m7UbSLAPU6hX_=tAvLZYR_7Q=1n+Xq-nW-6OJ237PA@mail.gmail.com>
 <f7ff446f-2a9e-49dc-af7a-6e4c76803471@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ff446f-2a9e-49dc-af7a-6e4c76803471@sirena.org.uk>

On Thu, Aug 21, 2025 at 10:30:50PM +0100, Mark Brown wrote:
> On Fri, Aug 22, 2025 at 12:17:14AM +0300, Nikola Ivanov wrote:
> > On Thu, Aug 21, 2025 at 09:49:29PM +0100, Mark Brown wrote:
> 
> > > > -int num_cards = 0;
> > > > -int num_controls = 0;
> > > > -struct card_data *card_list = NULL;
> > > > -struct ctl_data *ctl_list = NULL;
> > > > +int num_cards;
> > > > +int num_controls;
> > > > +struct card_data *card_list;
> > > > +struct ctl_data *ctl_list;
> 
> > > Nothing now sets initial values for these variables so they all have
> > > undefined values which is buggy.  The code is relying on the default
> > > values.
> 
> > Checkpatch reports it as an error, it looks to be part of the C
> > standard that all compilers must initialize globals to 0.
> > Though I suppose it helps with readability to see
> > the num_ counters assigned 0.
> 
> Do you have a reference there, note that these are just plain non-static
> variables?  I wouldn't trust checkpatch for anything that isn't kernel
> code (and even there it's got issues).


This is what it says in the C99/C11/C18/C23 drafts I found:

> If an object that has automatic storage duration is not initialized explicitly, its value is
> indeterminate. If an object that has static or thread storage duration is not initialized
> explicitly, then:
> — if it has pointer type, it is initialized to a null pointer;
> — if it has arithmetic type, it is initialized to (positive or unsigned) zero;

"static or thread storage" referring to variables declared at global scope 
(regardless of static keyword) as well as those inside function scope defined
with static keyword.

Since as you said checkpatch.pl is mostly intended for kernel code
(which I was not aware of) this patch is probably not desired.
In case it still is I can add quote to the draft and link it in the patch.

