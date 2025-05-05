Return-Path: <linux-kselftest+bounces-32439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5FAA9D42
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017DA17D4B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD91FFC50;
	Mon,  5 May 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RXfuiU2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F81D63E6
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477268; cv=none; b=fM6G1NsX76MydpReNYivbWdHtC6yyp9xE1hUAI6ulr6cB+9avZ/VMhteCl7SD83H9+Dgiwl0YtOQuRd7nbHRExWJPqlBBDswGEdzJH99jXWp/AnvBvqJThLdNjiGMeek5RhajZd40aCttuatIHDJKL/MVwUNdT/DFkJYfBY/PeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477268; c=relaxed/simple;
	bh=AQiFzZ+hioF3/4ec4StyGYUiDu4auMssToRPssmrwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7BW2B7SfmAge43X4oOMw48o4wEQv3RrENqAh6hj/GF42yUj4db6xXW4CgzXJkMT1HiueQ+UGc+oAbT7bu+mgfC0T91TRZ9ldR0CRfKTSBFsnk03hUGHYf/nJUbeMCi8RdU8boRSpJIIjPA2mM3adeD6KgJ57OxC6K6DeBtdKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RXfuiU2B; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6f0ad744811so40090326d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746477265; x=1747082065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjt5SetEQVeK+FSr50cmz95zo5QuMyYcarl0Ii5W2m4=;
        b=RXfuiU2BCnC37wgciCr7iHmhUKd6bP4+1IFDfwyTw66vCVCCqbZEao0yy1xaZwthmI
         27v6GVqW7vj1EJ8hFCc7gai1I5tWu881PtmUD7UkE7R8gHFLRXnaMWLkQMYvL/t+RmZE
         J+ikBAmPthXN87sVI5JouelGD9TrrZO3r1l88CcNMFJ3mXS8hK3lF4ZarGaXys1n5tgQ
         0a+JTX6Uqq3oAdaJk5yHY4hUJImQ9d2JNGc2fi0YqGNshlnNHu2KvkSnPkyX2bMPCDEN
         +ie59/N60uz9kSKpCY9wrJxV2ZTUaXlL78P6pTIszkGfXil7KRw8wSiuj0Ivb4B9ZXpa
         1bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477265; x=1747082065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjt5SetEQVeK+FSr50cmz95zo5QuMyYcarl0Ii5W2m4=;
        b=GXcPmE/2i5df+tTZWq113AONPW0+RwLCAZzcERz/FAmvMPFQCmlm2q62LyxQKAqDxC
         NbTOP4UfgQtSz37iF24M68T2U5MuaVK/hzCHaH41KQLRj9oFEiZE5VQaLe5Zg6ZWlgh5
         ZzFCk0yEmJuKnieZ0RPgZpqU66XHMXQj/K0wzfelCH1tDg+2Wqs73JQdSoPH5TRSImGI
         480jQQb/SPfjILT4PcJQPTAhtlvrMJHEOIFqBb6aFYM3enBFLgA3XOrHxkdOuDsIZHjy
         HBs7zw8X5bYJueeRLdn0BHYxeYjFIMIGvEFjh8NDoFgdSA5ZvbR7pgbqPehkHMPX3Gcx
         qc0w==
X-Forwarded-Encrypted: i=1; AJvYcCXqSGzg9UkbHr0ePpDKgNweOv5pIODzIf4TX5yaQMNm+EMUeix8Qg8tXnarwVuCKcM/PwmcqeSM7T/8JkV7KKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwe+FnKTc5kBWQ70KimdDc1ugvasBQJsF3e0royafQkr8KEbC
	LmRhAJtVmXFr1jg9YZlsg53kCBu1Nt+Ldj6OR5RpmAwxtvYMu9c0qHhr+2YpqUvtGUH7BY4DyFo
	EvQtvwxiwnoEGbjw5GVIsWcWUOrztCUws
X-Gm-Gg: ASbGncudnGr/3d5j/UKPgMxA0/Vahf+T9DSBN817LT3sl992ma3fDU6mXZ+jtAZzi5Z
	DwuUELON5k7v1Nj1QER3y6d8iryYBbcrcsynIJR1dfZahIjqd1e6dsQ+TTOVMyOftA/xinVMo8H
	Y26fKhbwL42Wsmi8EOP+p9CdhxgAojcyhe6Cq6ASnnAU2OO2AI/wjAnUwz3uI9apk8960Y4hwt2
	3RyjpNchMJkEkToJx2UA0TaApnaXYJFbipCQGfZ0jx9r6dbeKdR3Eq9Ep7w03tb6+KqpKdRYRzv
	Qufd4NZd9bYCvyYJT0a8UJI9YMUWKIqBcQzGtMt6q5ub4g==
X-Google-Smtp-Source: AGHT+IHDhruxKjn2niV28wBPJpKZJOMbtoa+Ime0L962AGQ61i+87oKEyyTGXvRQxnnGlsuLIRHOP/l8m+Wf
X-Received: by 2002:ad4:5c8a:0:b0:6f2:c81f:9ef9 with SMTP id 6a1803df08f44-6f528cf8e94mr138201146d6.33.1746477265123;
        Mon, 05 May 2025 13:34:25 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f50f3c3363sm22898456d6.27.2025.05.05.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:34:25 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5D95A3401B7;
	Mon,  5 May 2025 14:34:24 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 52ACCE401BF; Mon,  5 May 2025 14:34:24 -0600 (MDT)
Date: Mon, 5 May 2025 14:34:24 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
Message-ID: <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>

On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
> Hi Jens,
> 
> Can you take a look at Ming's comment on the first patch and merge the
> set if things look good? I can rebase/repost it as needed.

Bleh, sorry, I meant to send this as a reply to v2:

https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/


