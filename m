Return-Path: <linux-kselftest+bounces-25672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BAA271AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 13:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30DD1608F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AB207669;
	Tue,  4 Feb 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xe3Qk0Kr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251020B80D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671426; cv=none; b=DgrmhhWXwvU5r69ZO61V9Gx3Vwhvg4ukr6eP8Te/AWJu/1dVO53iMK/y8ZWSJbsDR1gLFN/5aKx8iF865jAJkvcbioCzwkFBOYcMlNTe0ekekhHeF9LyxX+v1SWEoZJxxtpWHfx3RLybDfl4M7zoQs+F05pQlZyVRkf2n7Ofy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671426; c=relaxed/simple;
	bh=1DsnRCD9MC1WNlpE3vjA8aL51Bl2gKT8bWu2APVPL18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba04AdcJxbzAIURCGtBDhTCtzbNG2mxzRJ2hnddY41QZZ7OWW0CUB+UWCmaqRLNfJAjUXxr98o7Epdl2pkik8OTtWdPq43B5n6dWT78lMu1HcB6WjnEFNKiMOyP69TDemB6H2ZJ11epmw5aASjAC3kQE4vdKjDEx5LZkGm97q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xe3Qk0Kr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa68b513abcso980524066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738671422; x=1739276222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZvhNBQWKlCvAqcbBDr5tv0EzdkUSClpqTtdtVXuZUac=;
        b=Xe3Qk0Kr0HP36Qm1W5eKVq8IHDeCaSQYliBW8DvNQZSzRiXW3g28mxcIwdtCUmEQfb
         h/F9hYQQjqOLVHR0HaM4Z7Zx5O6xnWBDOikKmkkMImXfWzq83whRS6+YFb7DcCcK2vAa
         oZgwIDCDY+GEkObFWXwlVt5C+GqcNwsvuTMnnd0rWGNFBEa0/PbODsY8PbYcHrS1ah1o
         CVaUHOkL0f7h/Nb6me4IDHjbNIyZkW6LWam+hVGD35XhCqM+2GJxNILNl+whltEzUW+N
         IyyndLxh8A0LdEjCJLwOFmUq0ct1Onbkjy1s1HQb3fKCYSucNWG5dXLGfjYMWZRYWv4S
         kwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738671422; x=1739276222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvhNBQWKlCvAqcbBDr5tv0EzdkUSClpqTtdtVXuZUac=;
        b=jqTaJtnTF5BRKU+S5GYsGS8BJjW2TTLsm1FIzpA/m4GC77a3SpiUn1p7XzY5jHiIFR
         zz4RT/e0M0x7bLStJsT1HcsJVmbx9FDykCCVOAvKjc6KMbURrh6b/+pHpXFRA9COFIS1
         hYl0oU2t82qYBIRx2X1fY+E1APrfIlX7Rt2voUPDaScVvUDGd43N9k+FlaLYzXD8d0vi
         CnGN+a6E+8DHgnaAHDtUy5FcHnf15QPnAGjimc3RkxCUP11nK9+e1EtbT4VsJqoXIPlE
         V2v3ZjuY8oDX42Rji7kxgMWIfRro9OZrnGyDArXnQkUlDx4akfW1Dd2LwcEHGenrtyaM
         0UBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX5aeHL9/JF/XGduU4ALwzDPyg3+OCsrU8LxSu57zRAPPBiLv7YWDrfDg5bvTjpmWyGd7p0YLsUC1Eki0oKCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0Tydo9gnSdHGj9awdFE9YBRAI/3pEqEL8R6Ohm5zdCwqK9+L
	1Dea2nPaIRcmTot4Jou4IHRgGINcqhFr6lMZ8ULtNJ4K1SkkaRd/siUqSsBRftc=
X-Gm-Gg: ASbGncv4JzuaFl4P+6HELQtEYvM1pHCNZNa03KbulNIe8KG3kA6VcIx+LRrNBXAdEyH
	lL5oofhvmw4lym7uobTmLBfYFodpcpSgYuf5C6kwnfvId6UimgvIfOl0K6TsPeY4JI7pcH5PM+z
	HXYhM7Z54OnLC6Tzh1vPsW9rJ86iYlmBg8v5T56HHnOmt9nLyDdBtVxiGLp3pSzMxuAadgWAJ8m
	/IbAX2yjGIHAa7ckJxZ4LHcZ4/Yhqjl/9MXi96rBMZZ/YeUhq6ymayWSaPhB4ri6zbTSD64QfV+
	8iO6TZj/NRb52gUOaw==
X-Google-Smtp-Source: AGHT+IH2G8hYYAkJwoDrdGcDA8/rdA98WX6XXA5JkrXP0w9WRYZajDa9VQmXcTXz1ys2KVFC33ecFA==
X-Received: by 2002:a17:906:d54c:b0:ab6:edd6:a812 with SMTP id a640c23a62f3a-ab6edd6a8camr2102928166b.24.1738671422169;
        Tue, 04 Feb 2025 04:17:02 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f1e23sm906290566b.82.2025.02.04.04.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:17:01 -0800 (PST)
Date: Tue, 4 Feb 2025 13:17:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] scanf: convert self-test to KUnit
Message-ID: <Z6IFPAuCz0_vDdB4@pathway.suse.cz>
References: <20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com>
 <Z6HSFvvgxFVGDQeI@pathway.suse.cz>
 <CAJ-ks9mfmM-SzkEiJsKL56jSuyXzLrKd4XHgRnp63C9AYcDoAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mfmM-SzkEiJsKL56jSuyXzLrKd4XHgRnp63C9AYcDoAA@mail.gmail.com>

On Tue 2025-02-04 05:27:23, Tamir Duberstein wrote:
> Oops, meant to address this in the last reply.
> 
> On Tue, Feb 4, 2025 at 3:39 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Should this go via the printk tree, please?
> > Or is David going to take it via the kunit tree?
> 
> Going via printk would be my preference.

I am fine with it. I assume that you are going to send v3 with
the updated Makefile. Well, let's wait a bit for more potential
feedback.

Best Regards,
Petr

