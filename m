Return-Path: <linux-kselftest+bounces-29055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3EA6156A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7503816C245
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0981202C2E;
	Fri, 14 Mar 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQzwU2kO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E6202C2D
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967768; cv=none; b=ondRBJF8EGYJrvBNqzGWvYhWTHu9vVK1j58IzlRaBcpD4Gx+67TC1aKErrh9rdb6G7Jvw8IQ/7nzv29rOyBXGjDlntRL/5mo0ccItHWoMMkWyjocro+OIdKWYrew+6rbSjBm9ZDU+KqW7e3mYfj48mxYKSeDbkasEFrRlb5fA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967768; c=relaxed/simple;
	bh=JnZ1YHJjukNmc9qetPt7sSkSNc2R6dj7qnTEJ4+cikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY+vbYgt7hzKCE4nTV04/zt4E1kNS9uNoNdLqxjBlNpriaezwTkLvI3xJyNZHhKC00Sf3z9K53Rbiq9aE0zoZpzKm7v9oHelYwuFsvdyQF7cubFsBjHgMQeV38j/EKUxly+EOUJYvIpJhwKncD9v251hoifN+E2Qn+NEMbFrSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQzwU2kO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe808908so50865e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741967765; x=1742572565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKoGoA18ujKk5HU/x65AGFBw6cvIwE6a5BEmMBdMtSA=;
        b=pQzwU2kOPr1+N4eVQJsmTzGbapTIT2cFIb4HT1CsarW/JRKNpUYX+cfLuxeRfMYFe2
         OcrUvzIO4x9EXvqpntVP3S81uGWCj1VDXpGS2G+bWVIIVLh29FopYGOjzg1dsc6MAJT2
         7aAYcUW6UC2enATYpgwTD+zds/yij2TybB01lfKhU0jjqeVFu7dni5CyP3GGYHheRv0a
         3MarfZ4T7iGKS+19UYx4nbtoDm+/vJR0WNEFrDRjnwE0GMFjF93imGBUnH5u77bGCWgt
         8hBmflZOtUJ3yliSmGNpfF6wdLeC6FrGUzE3h1mnc+VOKLxTX202dMjY/Av1M9Ykfsjw
         fwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967765; x=1742572565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKoGoA18ujKk5HU/x65AGFBw6cvIwE6a5BEmMBdMtSA=;
        b=vzmvhkjZajqKo7xiqLhtbtHnHRlYqU12M6kAdc9HVwOxC9rp8keEPjGhpDLbMe3PNB
         TLLzvipvI6Sn4xj7P7mRhvPc1ieSMI4E4REEwxUpgwfNxCXcfLV+jNh1P4ph+WNr7xLe
         UbzKNIgosNsdtgmt2S2AL5VYQGFBs3o7xgD4WiPH4D3815QWCKL4NbRKYB37MpAiUYPD
         tku9OF5AiHAQODQGT3pHBRIAnIkcC2IlRz8pM2CE9TkQm8QxjeVb6FgvXhUn3pwXJxGb
         XnQfRupqHFm+fy+TW9hdMW/aset4qWyEKEtoASbhogVRYFSv2aD5UbRnnYMV1qVGrUrD
         fE8g==
X-Forwarded-Encrypted: i=1; AJvYcCXQLdsFtR7RH4/Haimq3H1cHGYmaeOACitGaqLsiqe2RMk7cUbful1zTV88t+l856Ma8h8HUpGIeBZeZ2Om624=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNukbyoc8pycWhW0r3H752FcPNQwkWX9fJJIfDZV9JqtA17JOl
	FdMOytqfin07qwaNeL2qhh0BvrO4hp62gteLpmaMeromGl0olMw0u46NcU8SaQ==
X-Gm-Gg: ASbGnctfVSFZcTJ9i2kmoGBM3mQ2c2OaPdKNLsO/6EkK/WJ8Y3z0A3SKDxUw+tAZOAF
	EItPpj1Pme5ecjno9w/Pcfe26dNX+7Epur86gazDAvpj97cPr2bmvvnJY08psX/ySKQXGZ2bcbG
	AB7y+HWPeqtnVd+4nOvXNk8k6LIFESqpDn/HxxBtsBm25y5qwi8w5O7uG+6A3YzzPNC0M3qDRCl
	VAI4Oho4cabmada9LCQGgsV2Xh9r+aBoI59MkyMNtrvR0KCk7MWagkUx9leI5S0V/IfVaJI6X2Y
	1KSd8zOIuq7ovFagEN6xA2lK91BWBEOvqH3RaVjg6/3DsUD+kTlOHqCea6H/C0vFpf7t4hn5dHU
	FMPLk0Bs=
X-Google-Smtp-Source: AGHT+IEwYCKoSx0cSs3htw+SGMCjLhU2RU9hodxnkl419jpY8lUbMFXoXkJQoMHy2icUExOKjxJZxA==
X-Received: by 2002:a05:600c:4748:b0:43b:df25:8c4 with SMTP id 5b1f17b1804b1-43d1ded2193mr1458335e9.4.1741967764799;
        Fri, 14 Mar 2025 08:56:04 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm6097615f8f.70.2025.03.14.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:56:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 15:56:00 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
Message-ID: <Z9RRkL1hom48z3Tt@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
 <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>

> > Even if it's a bug in QEMU, I think it is worth working around this
> > one way or another. QEMU by far the most practical way to run these
> > tests, and virtme-ng is probably the most popular/practical way to do
> > that.
> 
> I'm afraid yes. Although allocating temp files form 9pfs is rather ...
> weird. :) One would assume that /tmp is usually backed by tmpfs. But well, a
> disto can do what it wants.

Ah yeah but these tests also use mkstemp() in the CWD i.e. the
location of run_vmtests.sh, it isn't /tmp that is causing this at the
moment. (At some point I thought I was hitting the issue there too,
but I think I was mistaken, like just not reading the test logs
properly or something).

> > I think even if we are confident it's just a bunch of broken
> > code that isn't even in Linux, it's pragmatic to spend a certain
> > amount of energy on having green tests there.
> > 
> 
> Yeah, we're trying ...
> 
> > (Also, this f_type thing might be totally intentional specified
> > filesystem behaviour, I don't know).
> 
> I assume it's broken in various ways to mimic that you are a file system
> which you are not.
> 
> Your approach is likely the easiest approach to deal with this 9pfs crap.
> 
> Can you document in the code+description better what we learned, and why we
> cannot even trust f_type with crappy 9pfs?

Sure, I will be more verbose about it.

I've already sent v4 here:

https://lore.kernel.org/all/20250311-mm-selftests-v4-7-dec210a658f5@google.com/

So I will wait and see if there are any comments on the v4, if there
are I'll spin the extra commentary into v5 otherwise send it as a
followup, does that sound OK?

