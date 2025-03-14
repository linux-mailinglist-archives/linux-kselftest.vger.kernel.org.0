Return-Path: <linux-kselftest+bounces-29045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42908A61274
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 14:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014AA1B62E12
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5A1FF5F6;
	Fri, 14 Mar 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XGLvP/7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1C1FF1BA
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958489; cv=none; b=KF/aXSeYWMpboGdNTZHW925CEYylMM/FxKQBS79Im2f0LstjN0Gn66PDXekyx28SkBLP+27So1T027g3yCa/nl3YCtro65Yve7lNn6sCStf4NirAGwTTfDQBu2CPJ/lwOI60ZkPQhsM5gBN4qE21deteh5VzFu8ES7FYn5cM+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958489; c=relaxed/simple;
	bh=et1KWl+GmikDH+nAZK+eZMciYBDno4m0DwZOZx7tjEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy/xK4Vf5L1APM08W/oa4UV2qdUgoaqKdd+D/h+0cUaVD+f/ZufCDd74r3+UtAGLBicnq3Y6OqK2Kc5QNn4NQBcVNq+sY/VZAedYEnYdUzEptyT3hiG601li5f3+zTxLQL85EQRRu41oPeR2JPIgmENfmHVsdR/8gQ/pxcQx8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XGLvP/7D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so20060485e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741958485; x=1742563285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfZBJkbB0rxqkRnLOvSzKKZry2EipJmvWVg+07Btrmw=;
        b=XGLvP/7DmP//ovtuyTwK5u41Ba2ETtcEoVxDw4EEBuLMgV7yjqLLHC5MCtcgRxH7TW
         UxHOjszysQLsUSva16y4wdLQcSpFEgtxp6WAaiqtkI1WqL2F5Srxtwld/7OFiXrbiiUq
         x14swLhB0HgI558gGdgk+YnEe4XiGl28l0yEb1fu3h9k4tnbU6zAb+zGQY71Dwcyis1t
         0AMisBFNg64Vb7X9VokHr+mT3T1WM9Xn27W2LP4LsOynmjIjweHy9Cf/BXScp3t7I+Du
         +ZAxKlLhNn5wcrXPX7QOOxoaucACBPgi5DPNAGBykExr8pLeAHOJXwueOPhZUU1EaOe6
         krtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958485; x=1742563285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfZBJkbB0rxqkRnLOvSzKKZry2EipJmvWVg+07Btrmw=;
        b=jG1VkJjQbVV53ov29M/NZPo+YwA94Bvv6J76SBm29UwwdJOoOski9KguyJN6PpGe4V
         LAjBeSZWFubZ5RbxxoltYm+d2ZmvDad0A+w2dcOmDTp4gEpOSwWqiFNdCXGygWyeIUpu
         BUrbvTXLiaAB/whLjFCJMsbHCk66phhuNJTE1ldDzWjrAedmxzB9pvmymV9bpOqHC9R2
         x9VbLE7pH1ZuVm0yWjkgWxTVx3CIrSU2BCLUkJ8NkOXGeK72n4odXEaAuNsxwz909JW/
         QxlIPuQfbgehRVzieiBPllziD9vK7ILzBTDhCZourk4Ce4J+usuOWqWYZFxNG0XVxAnd
         EjYw==
X-Forwarded-Encrypted: i=1; AJvYcCXH87HlBJ4+swA98FwUaXJPViBNmPs48aV9iDuXattsNcrO6VpJvCOYTh2gNREvlDUU25kyGWmXL/PhZvEX9jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8+tRy3AZugB1GGuaWkup0LNHsH8FT0FldaJCUJWwZuf7dXK4
	xEs1TOh7qCwSGgR1G2kHHU+dtPw0Rs4q0OQMjcUzKaP61YzRWDvapcnJdoSrHIU=
X-Gm-Gg: ASbGnctKpGCoN1OjolN1fJ4rUL/7+vIJHiotqPtB3YYtI07gUgqQ+zE8bLta/H5/t4q
	TYQXSD8dnmM+BfP6JBf0TMqzNy2pVzbwcjJfrTchEA6dQzcj7INSnxrtCAv1zX40iGAducelI4M
	Tqw+QVs5C51o6bdb8vvaVY7KJSsj5WT2BU1VGT2W+mY0lL3hU72uX1bYdFBoEGH57kGmrmDYdgt
	FKwc1JlC/u/ogHdPfWEKpb1s4xjTYl/e2qC+DCjWEWTDWHwFvAL83gUWaOnqGkF/1oqGtGTagBm
	38j6lEFUbXjFyAi5STvrO6dmzytbz+2R2cXGB6nMFbUdQMc=
X-Google-Smtp-Source: AGHT+IHz4rLkTjIbottnvR1bTWD1He70uzCstqzoITMLF0sKAgHxlQ/29uxxKSBaLDiz0yI5D5qYSQ==
X-Received: by 2002:a05:600c:3ca0:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43d1ec72a12mr33996705e9.3.1741958484966;
        Fri, 14 Mar 2025 06:21:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe74f4asm10674595e9.1.2025.03.14.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:21:24 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:21:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 6/6] scanf: further break kunit into test cases
Message-ID: <Z9QtUoFdCoTXnkzE@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-6-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-6-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:39, Tamir Duberstein wrote:
> This gives us more granular test output.
> 
> Output before:
> 
> > KTAP version 1
> > 1..1
> >     KTAP version 1
> >     # Subtest: scanf
> >     # module: scanf_kunit
> >     1..10
> >     ok 1 numbers_simple
> >         KTAP version 1
> >         # Subtest: numbers_list
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list: pass:5 fail:0 skip:0 total:5
> >     ok 2 numbers_list
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_typemax
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_typemax: pass:5 fail:0 skip:0 total:5
> >     ok 3 numbers_list_field_width_typemax
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_width
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_val_width: pass:5 fail:0 skip:0 total:5
> >     ok 4 numbers_list_field_width_val_width
> >     ok 5 numbers_slice
> >     ok 6 numbers_prefix_overflow
> >     ok 7 test_simple_strtoull
> >     ok 8 test_simple_strtoll
> >     ok 9 test_simple_strtoul
> >     ok 10 test_simple_strtol
> > # scanf: pass:10 fail:0 skip:0 total:10
> > # Totals: pass:22 fail:0 skip:0 total:22
> > ok 1 scanf
> 
> Output after:
> 
> > KTAP version 1
> > 1..1
> >     KTAP version 1
> >     # Subtest: scanf
> >     # module: scanf_kunit
> >     1..21
> >     ok 1 numbers_simple
> >         KTAP version 1
> >         # Subtest: numbers_list_ll
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_ll: pass:5 fail:0 skip:0 total:5
> >     ok 2 numbers_list_ll
> >         KTAP version 1
> >         # Subtest: numbers_list_l
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_l: pass:5 fail:0 skip:0 total:5
> >     ok 3 numbers_list_l
> >         KTAP version 1
> >         # Subtest: numbers_list_d
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_d: pass:5 fail:0 skip:0 total:5
> >     ok 4 numbers_list_d
> >         KTAP version 1
> >         # Subtest: numbers_list_h
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_h: pass:5 fail:0 skip:0 total:5
> >     ok 5 numbers_list_h
> >         KTAP version 1
> >         # Subtest: numbers_list_hh
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_hh: pass:5 fail:0 skip:0 total:5
> >     ok 6 numbers_list_hh
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_ll
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_ll: pass:5 fail:0 skip:0 total:5
> >     ok 7 numbers_list_field_width_ll
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_l
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_l: pass:5 fail:0 skip:0 total:5
> >     ok 8 numbers_list_field_width_l
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_d
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_d: pass:5 fail:0 skip:0 total:5
> >     ok 9 numbers_list_field_width_d
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_h
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_h: pass:5 fail:0 skip:0 total:5
> >     ok 10 numbers_list_field_width_h
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_hh
> >         ok 1 " "
> >         ok 2 ":"
> >         ok 3 ","
> >         ok 4 "-"
> >         ok 5 "/"
> >     # numbers_list_field_width_hh: pass:5 fail:0 skip:0 total:5
> >     ok 11 numbers_list_field_width_hh
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_ll
> >         ok 1 ""
> >         ok 2 " "
> >         ok 3 ":"
> >         ok 4 ","
> >         ok 5 "-"
> >         ok 6 "/"
> >     # numbers_list_field_width_val_ll: pass:6 fail:0 skip:0 total:6
> >     ok 12 numbers_list_field_width_val_ll
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_l
> >         ok 1 ""
> >         ok 2 " "
> >         ok 3 ":"
> >         ok 4 ","
> >         ok 5 "-"
> >         ok 6 "/"
> >     # numbers_list_field_width_val_l: pass:6 fail:0 skip:0 total:6
> >     ok 13 numbers_list_field_width_val_l
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_d
> >         ok 1 ""
> >         ok 2 " "
> >         ok 3 ":"
> >         ok 4 ","
> >         ok 5 "-"
> >         ok 6 "/"
> >     # numbers_list_field_width_val_d: pass:6 fail:0 skip:0 total:6
> >     ok 14 numbers_list_field_width_val_d
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_h
> >         ok 1 ""
> >         ok 2 " "
> >         ok 3 ":"
> >         ok 4 ","
> >         ok 5 "-"
> >         ok 6 "/"
> >     # numbers_list_field_width_val_h: pass:6 fail:0 skip:0 total:6
> >     ok 15 numbers_list_field_width_val_h
> >         KTAP version 1
> >         # Subtest: numbers_list_field_width_val_hh
> >         ok 1 ""
> >         ok 2 " "
> >         ok 3 ":"
> >         ok 4 ","
> >         ok 5 "-"
> >         ok 6 "/"
> >     # numbers_list_field_width_val_hh: pass:6 fail:0 skip:0 total:6
> >     ok 16 numbers_list_field_width_val_hh
> >     ok 17 numbers_prefix_overflow
> >     ok 18 test_simple_strtoull
> >     ok 19 test_simple_strtoll
> >     ok 20 test_simple_strtoul
> >     ok 21 test_simple_strtol
> > # scanf: pass:21 fail:0 skip:0 total:21
> > # Totals: pass:86 fail:0 skip:0 total:86
> > ok 1 scanf
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for trying this. But I personally do not find this as a big win.
It causes that the test log is longer than one screen and thus harder
to review.

It might be fine when running only this test and running it only once.
But I think that it is quite common to run more tests and then
it is easy to get lost.

I guess that there are tools for handling the KTAP format which might
make this easier but...

So, I would prefer to avoid this patch.

Best Regards,
Petr

