Return-Path: <linux-kselftest+bounces-23142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAD9EC3B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 04:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460B51882F27
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 03:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE462397B6;
	Wed, 11 Dec 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMG/NSPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEF22914B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888668; cv=none; b=ZNiSe28a4/e3qdHvUhjbfH/re4P3TxC8Pw+0R6IBvVUw5zuIHvkenL1W9/fBbYgPYkjsYnsAZ6OZYzUwlhvQu7gvBXQSAAVkgLxPWgQgVjrUGOPchr4Ev/01XQbRGJCLwOjIqXiI9CWHOSV/R6FisEqKdLeDrpMUCV7UR0pWQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888668; c=relaxed/simple;
	bh=h+iQpxuUF2z9uLrEvofKfRG+v5z2Zb87jckGIs2e9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8zDtNrI4NgCESCpotNJ06Rf4zSn2/YyiWJ4f4SCYjtIzuDi/V3rmRL593a44IKqXBp0o4ZpgNvNjRSK0CY46sjLAXlq2f7GR860WAxNRv8gFlUR94J7AiHt4nyE+/BDm/dHd9CNV4j1qExg2XQkiv6VdHvdOv9ppU97rS8G9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMG/NSPW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef824f40dbso46359247b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733888666; x=1734493466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNapOyEQ91ZoVlFNBY2PuFB63oHmXcixJJFgp+wWmMs=;
        b=FMG/NSPWujMcHQ84WM7vZOtTgQNSEhKjeQxqgg6jRe4Q49rHCJi6PoYsnMwfibC4VJ
         uZpjf8CU2Z+P0QZwrFPDQ01GUgOAkrM4aB8oeYUASOK6REikQri9bR8ugUQcyw5/ypzc
         rg42dI8QRvlIelVypYfGoVcZmDrix87iCA5fLCtLHzeO/IS8wQF76my1eROMMDTcPNci
         A574DGXRDcpZclVsRakeQ+fJVuG+QmNtmdbt0we5+OE8oETS3JgjKPa/mk9GJyku2QRq
         jkws+Jwen8WrD81cSAHZHl3tRdxTBmL7nHJSrft1q16S2L7u/J8XlGRPJ5MTlLvszpCw
         g94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733888666; x=1734493466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNapOyEQ91ZoVlFNBY2PuFB63oHmXcixJJFgp+wWmMs=;
        b=jnBZG6ENXTz07YonVAxeVA/HcsB5iMzPC3J1bc/K8R4EdLSSS6kk10l7OFYsOptHLO
         TNw6135ah2UCjiLm/RVFg8ABtLuaZ7sqt7eKAhaSAw3YnfS4CjKkmbheA8uwqpJYdeyJ
         Wjf/QED8gUQJwZZX1jo/ptIRv98PAyv3RlLe0Q7D57sMWjQA2DxJGeuyDZ6MKDGcetvr
         oMQ+XyRbazXxFY9MDcs1pPVJ78L+04jN0Wine62c0xke1J39BRz7y3yPuvTPPaxYADya
         MDeYcFZdOxNU5xiSbq4EkaDYr5sGWFTBDreOmcGt+vF2ykBjk/iuaQpYgZ8IQMCnI++1
         iM7A==
X-Forwarded-Encrypted: i=1; AJvYcCWeH7wQaUP7l4wMNcbb6wMshVoM6yBAxz63fyQqvKWcwDKhL8YBRjmvu5hjZu5xvWlBk5wUaKG1zYmHOEowkYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Gx3ZakH4+TiVeUQUg5OkDdTpJ+qTaNWy7WVB8OblaKeSlW5m
	NW0GlYq345ycMFT2PWSMz3DYPXzObeRtAp9ADcZ/0lDoqCWRTxzM
X-Gm-Gg: ASbGncsL9IQqn1O0KbFDIi0ICMonKfqwK6D89zpImxeUmhEu4NjPVU7Rkgw0yIe8AA0
	GTpMpjEa6husP1hsKQtQTOuxTjz9oflzOV8gh2KdPkSY9wRkav2YLGERRaxSg8ywodbVFk6xNgY
	LPz0tSmYS5eyXgoPwo6A5cLkeTYF4hYwGd08m/tMOdSRclwCggUagc1JG2w5CxuIuNozhiWGMbX
	U4RUYAQ81PkRrvKY3G1FDApr0DPnsB4zUs9p4ArJWea2VK+ptt+quOQaIxMut4/T3m9KDXYcHIi
	9evF6ZLD0BHdSgryXw==
X-Google-Smtp-Source: AGHT+IG95h9z/msfDeQOwzBtB9buNs0kGCtNIwCEwXSqjPZZJyjcqhT5K+EMuMxat1vH8HdrDpA5yw==
X-Received: by 2002:a05:690c:350a:b0:6ef:6d37:1844 with SMTP id 00721157ae682-6f147fad943mr18703677b3.7.1733888665679;
        Tue, 10 Dec 2024 19:44:25 -0800 (PST)
Received: from x13 (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cea48basm496557b3.121.2024.12.10.19.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:44:24 -0800 (PST)
Date: Tue, 10 Dec 2024 22:44:22 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: davidgow@google.com, Andrew Morton <akpm@linux-foundation.org>,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	skhan@linuxfoundation.org, rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v4] lib/math: Add int_sqrt test suite
Message-ID: <Z1kKlhUceHxZrMeS@x13>
References: <20241210172822.97683-1-luis.hernandez093@gmail.com>
 <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg>

On Tue, Dec 10, 2024 at 02:59:12PM -0500, Nicolas Pitre wrote:
> This will fail on a 32-bit system where sizeof(long) == 32 and 
> ULONG_MAX == 4294967295. (meaning the result would be 65535).

Thank you for taking the time to review my patch and for pointing out the issue with the ULONG_MAX test case. I failed to think about how a 32-bit system would treat ULONG_MAX == 4294967295.

To address this, I was thinking of updating the test case to use a large enough value that remains within the bounds of unsigned long for both 32-bit and 64-bit architectures instead. Specifically, 2147483648 (2^31), which has an integer square root of 46340. I believe this would ensure the test remains valid and portable across all supported architectures.

The updated test case would be as follows:
{ 2147483648, 46340, "large input"}

I'd appreciate any feedback on this proposed change and thanks again for your time Nicolas.

- Felipe

