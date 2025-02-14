Return-Path: <linux-kselftest+bounces-26653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE81A35F5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCE3A3226
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57661264A88;
	Fri, 14 Feb 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbiHc+Al"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DD275419
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540020; cv=none; b=p05km3AQmDSfDe2XquqsId4KRMW6H9EGCUIlStUklKEB3D/GrmkHFUcqWy27dm3aSr0erY+vq94L9JWp2a2hH3fA4YFbGuNeCVNjp9JRlhtPubpMRi5hG8F1iIJoId3qPHXEurdC5ja2IDD1HOBMpphR2itzeG3lipIpbfyfZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540020; c=relaxed/simple;
	bh=ycR+1MwMEU5ObvPaf3WAvNpWw1BEie2SzKcxxyLnJUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjMw17UKuFEGoG/PL3bH+yAhp/P5gH2/7yT9szQTRrsdhzSdTpffEyA9th4nlmRORX5+gfpxBWhZOrSWHLBVYPA8WPGVzGFmX56ZPSfVb2FU1a5ZF2bzGCBoXvEJ5PkjTyG0pXCRcTW6fnut2g+Kj4KyZ2ZhfBZQ79hM05OVHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbiHc+Al; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso1398330a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 05:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739540016; x=1740144816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMU56UYZAvRvQBmTkWTgLsgV69Nth4aeRE+elxO+TF0=;
        b=GbiHc+AlPDqD3e04Vc1bpK7+mzD5qpHAFfRQsivopjbkb8lXYyA0ONhO4IpzAcumsT
         imj7eNSqBekrrJ8BtND6IkhdGmR/LQ5cFspjb3jPxwO4Sx5RS014wSlW4N58ABoLz+cX
         1CTcagUlAS7vsO6uZP8xmI0IgcEPJQ7B0FbWsJKAl+Vemdn+zUX7FabWsyJqsTW7GfgW
         dKGgrDqwNKVmAt1V/SS5dLBJb4qXx15/dycUYcE9eJ2Tcv3WjzffiIeAZ8ogzgVMj2KO
         z9iim8mcJDGDdllmuAiAkIviAz6yHOkq+ZmtPHHFbpiJ0cgp2owSZdWlz/Gnhdkb0dyk
         c0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739540016; x=1740144816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMU56UYZAvRvQBmTkWTgLsgV69Nth4aeRE+elxO+TF0=;
        b=E5g3z5aYmgvW/5JZ55+F4FYl7EneFYU7e/5rMKds/WeltG4q3Ph7V8dc2Z3ptY1n5z
         5MCh7hy6iS3vZfgJZoSm0qSUc9mL/lepZ86GYGI7q8j612i1CFGMhmme/0Kk3Q/hx4rT
         EVj/5a2zBkn1sb0a87cncJXoSMUk1OlsvSz3uAi1qo38ykVhJBfOnyU5RQYQhi4AVgYE
         WzC6yffTVE/ADI857/IF6TidkoKbbjIBrlLD06cGp/EQTaxusTyGRIeLj2bYmvLdPerB
         MFquyQIZkqDLuvNORpOFN0xMRKBFQtZ7RLk5A1JYayWARWKdegwj7ab6SdFVGjQ1N35X
         6F6w==
X-Forwarded-Encrypted: i=1; AJvYcCWfPe25R7R06vP/tdgVsgOVtVKiNPyFtj2pO2Q+wk+7a45VW9qkpPrSw4ZtFDtKUWQZyWS63zFFU0vmmfasFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypM92qu5/c7+ME6QBtHoSkAHhBI+cSQw0g6sOeSWWI9cm82v2v
	Fn4gOSeW2HqFFkgHBvMCD3NzF0fH4DRIIXHCQenpJep8DxCMjLrHclNOi5CB2AaXpsJ2VFYAdTU
	Q
X-Gm-Gg: ASbGnctRfhssKnWUN7cXmpPO8Aei7N5ItR6McqrKg5jnQXseHkZVUqeBZTaObtNj9if
	pfFY2nv5STjzY8cyTRW493zs9hbfaheSzj92JLFTmJy49rB+fSUVSwW0v//zO28U4q/AxFSyQT4
	3+edFHuxep37CSm6GdSvBw9USMDfcEG74UJ1+JaLlxtGfk7BEGILvyQoXw8cjYd7Wtq2Yyb7kSw
	e7aeRstTRj0Y69okJIZvrUaH+Alv75FVsdMisw7ip383XltLop7do1ZwGgy6OSx08DHFEJOm1Aw
	vsOX9RHub0+hb3BYzg==
X-Google-Smtp-Source: AGHT+IGPJJhE6wRDk9L9f4no7Cog7YbL9aFvuIy+X6Xo0n3M9vxodRrVaRG3tb7zWwYGNh5DO5nxsA==
X-Received: by 2002:a17:907:94c5:b0:ab7:ea59:2120 with SMTP id a640c23a62f3a-ab7f37149d0mr1353996666b.10.1739540014663;
        Fri, 14 Feb 2025 05:33:34 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533981f2sm341066166b.125.2025.02.14.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:33:34 -0800 (PST)
Date: Fri, 14 Feb 2025 14:33:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
Message-ID: <Z69GLMVPCuKKz1gk@pathway.suse.cz>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
 <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
 <Z6tytjvT1A-5TOrq@smile.fi.intel.com>
 <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
 <Z6uGPZZ7LioJmekz@smile.fi.intel.com>
 <CAJ-ks9mGwXmiJ3_Kk4j0MnEqn24A9UJJXVhqtUjcG8W5ifodsA@mail.gmail.com>
 <CAJ-ks9k9d4aX+P9F10h3TqHPOCHEQ5m=QyMAv7bU+Xyb3LRsOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9k9d4aX+P9F10h3TqHPOCHEQ5m=QyMAv7bU+Xyb3LRsOQ@mail.gmail.com>

On Wed 2025-02-12 11:54:52, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 12:26 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > > Is it me who cut something or the above missing this information (total tests)?
> > > If the latter, how are we supposed to answer to the question if the failed test
> > > is from new bunch of cases I hypothetically added or regression of the existing
> > > ones? Without this it seems like I need to go through all failures. OTOH it may
> > > be needed anyway as failing test case needs an investigation.
> >
> > I assume you mean missing from the new output. Yeah, KUnit doesn't do
> > this counting. Instead you get the test name in the failure message:
> >
> > > > > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > > > > >             not ok 1 " "
> > > > > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> >
> > I think maybe you're saying: what if I add a new assertion (rather
> > than a new test case), and I start getting failure reports - how do I
> > know if the reporter is running old or new test code?
> >
> > In an ideal world the message above would give you all the information
> > you need by including the line number from the test. This doesn't
> > quite work out in this case because of the various test helper
> > functions; you end up with a line number in the test helper rather
> > than in the test itself. We could fix that by passing around __FILE__
> > and __LINE__ (probably by wrapping the test helpers in a macro). What
> > do you think?

I am not sure how many changes are needed to wrap the test helpers in
a macro.

> I gave this a try locally, and it produced this output:
> 
> >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
> > lib/scanf_kunit.c:555: vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> >         not ok 1 " "
> >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
> > lib/scanf_kunit.c:555: vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> >         not ok 2 ":"
> >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
> > lib/scanf_kunit.c:555: vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> >         not ok 3 ","
> >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
> > lib/scanf_kunit.c:555: vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> >         not ok 4 "-"
> >     # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:94
> > lib/scanf_kunit.c:555: vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> >         not ok 5 "/"

But I really like that the error message shows the exact line of the
caller. IMHO, it is very helpful in this module. I like it.

IMHO, it also justifies removing the pr_debug() messages (currently 1st patch).

> Andy, Petr: what do you think? I've added this (and the original
> output, as you requested) to the cover letter for when I reroll v8
> (not before next week).

I suggest, to do the switch into macros in the 1st patch.
Remove the obsolete pr_debug() lines in 2nd patch.
Plus two more patches switching the module to kunit test.

I am personally fine with this change.

Best Regards,
Petr

