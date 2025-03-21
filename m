Return-Path: <linux-kselftest+bounces-29582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4EA6C26C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F6E17CB34
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8F22F389;
	Fri, 21 Mar 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGv/cfXz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808122F15E;
	Fri, 21 Mar 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581981; cv=none; b=GsKSLDqR1LdJeKJ92ryanVUXpWbN5LJAn2Jm3hhdWUv4NPGAJFJIqxpXyvM76SKMP/2SXUvVX8FtVmJDhs8lUh5JiBHiXFh7lddNfQmXZrk5HWL2iAEsnAw1egzlpX9R7Fc8tFaJV+5V7PjKSI9wySVEGE0q8t64hj895M8PNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581981; c=relaxed/simple;
	bh=xK61NJ5AcpPTkZxqeIXw3ikD2Gq+iucUtG013FT56sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQsLgfUgUtkGbWpUtYhAPS1m0KbJaFlols2rOfSyfxt9HH1ArQrqWAxxvgU4RtonsGGjoK/cxINyiCb8rnRmD3fzxUfby9j8ijJ1onyTpGo6RbVX0zdVXmBL0ZLY4SLVGJ5EtFLfK95dqI2goRg6Gpt5tr16lWYVxCwYpR20mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGv/cfXz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so55985715ad.2;
        Fri, 21 Mar 2025 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742581979; x=1743186779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYYSOKUxEGqctY3EfhN9A2yhuGU3c7aUKlXkZitVseM=;
        b=CGv/cfXz6h16+MYAEWgGHaE6luKawPtlwm/UyZrmG9n5SxPdWQHMT34son5uRzKqKU
         pQH5juq///ouih+AT4duyeFz0Q1766OeEQc+hBMFxIjZBPIyTuvU+369ITzGCkWbBUI4
         c/SwIbLtKAr1wRa17cxIsLvjMHYyUgG9ahk9FhcLiJgxBKM99DpiC9RMNXf+0d2PpeFu
         +dhSOaWyAbczYDIMFMpqe9jD1fel0n7jPlkGCNeasQtI9OUGITbDL0x9m6OBms2MKBqo
         KjScHQ4i1R2yNrOfqTLysiNJuPAIaSEZNCaGt9/r8LJ/9JXwWdGTMgDYTkGCxcaF7fur
         rcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581979; x=1743186779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYYSOKUxEGqctY3EfhN9A2yhuGU3c7aUKlXkZitVseM=;
        b=NnBIDpWHrW8quC/4IuU0i5J37cAfjU7VdBCFhZ8FnAgcKrN4U2KziQDB8+QpRMVQNJ
         9orYBVi1hHnz6Rb2D/o1CO5xiJ4RRRh5ijD1ngCht3JQZGat26e593+e/N42hKhoxrlh
         sjgUOI6eIZIxmWZsM3PDKOr7Keiqfz5KZqaGE16Lixm/ogQARQS86vov8e9lVRysU1rM
         QE0Zan0DH5w1RSCSyiKn34dWdzZjBIpSx3fYEe8LK2WeTU0nbvmPsr0v6gEYERHAmJzC
         oNWGmKZea5qomNbnp3QNPufh2gh1FaFTIViTkfDQaJ5je6LceVCLV6H8KZbdbPLO+m1z
         4Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGS4txXeToTt13ar+OqW4hCcLSfAdPgEQooBIkRIIhgW2W7NqIucaKOEOBS/xfzYtbipT5+Jjsira/KY8=@vger.kernel.org, AJvYcCVfZQ7gYMkgeDhgZkQ0YezJQmTIx45pr4t6/ddl/Nf+Veql2THJ5BLSYGe6BZdFkE0SfXrBxzuCQnfoLP8DMX/e@vger.kernel.org
X-Gm-Message-State: AOJu0YxMn6ZzrVjYzzJkPcTgr+T8BLtnl7EN8ENL41fwAaD/1dAbvlPB
	Ipi2sTZLiHWBgGTbBcFWdZOM7Bmht+xGtov9ka9s/pZvOIhBewZXWMNnQw==
X-Gm-Gg: ASbGncsDEneln+317cVuwqVSKI0QxgPRdk5NY4izN1ltgVrtD6UQscyXzQXuBlUI+gA
	RceZl8GwKinaDncqCwFErYLG8TqS2lvkbli+37QNsi40eaYcIYD9NA2g6W7Bzc0EPaA7P64EfBD
	rHZcGlkGQpWQjEV3l/etZsvtWecZD7Y/ke846K5giIH4JFa0uWBrztLszn5E0aLMpfNgimNzuMp
	Tp+LXyos9lK9wCdbZUGulxyU38BSGr0tb9JcOu1zo7l/bZABULzIeuKDMDZZoSGS8cJp5Ybg0KH
	Kb9BrEtiAqYsc4j8ksrkNUtikaNoPBCd5sCk87SwRlR3
X-Google-Smtp-Source: AGHT+IG4Y4KdKGYoy70io/r8gYLZiFwsgOksUI+QUCeOo40CKssKjfePE5RVgUBb4ckPKQzflnN8DQ==
X-Received: by 2002:a05:6a21:394b:b0:1f5:769a:a4be with SMTP id adf61e73a8af0-1fe4347101emr8883211637.36.1742581978798;
        Fri, 21 Mar 2025 11:32:58 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906123ea2sm2382632b3a.108.2025.03.21.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:32:58 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:32:55 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Brad Figg <bfigg@nvidia.com>, David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
Message-ID: <Z92w13L8v1MvPC8_@thinkpad>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad>
 <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>
 <Z6pfomw-3LuWoQQo@thinkpad>
 <CABVgOS=KZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQADrW+sJg@mail.gmail.com>
 <CAJ-ks9mevv68v1Mh0GdGd9Y2EEp3_kdV6FygOiAenYG0=e4=Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9mevv68v1Mh0GdGd9Y2EEp3_kdV6FygOiAenYG0=e4=Tw@mail.gmail.com>

On Fri, Mar 21, 2025 at 12:53:36PM -0400, Tamir Duberstein wrote:
> Hi all, now that the printf and scanf series have been taken via kees'
> tree[0] and sent in for v6.15-rc1[1], I wonder if we'd like to revisit
> this discussion.
> 
> As I understand it, the primary objections to moving bitmap to KUnit were:
> - Unclear benefits.
> - Source churn.
> - Extra dependencies for benchmarks.
> 
> Hopefully David's enumeration of the benefits of KUnit was compelling.
> Regarding source churn: it is inevitable, but I did pay attention to
> this and minimized the diff where possible.
> 
> The last point is trickiest, because KUnit doesn't have first-class
> benchmark support, but nor is there a blessed benchmark facility in
> the kernel generally. I'd prefer not to tie this series to distros
> enabling KUNIT_CONFIG by default, which will take $time.
> 
> I think the most sensible thing we can do - if we accept that KUnit
> has benefits to offer - is to split test_bitmap.c into
> benchmark_bitmap.c and bitmap_kunit.c.
> 
> Please let me know your thoughts.

Sure, no problem.

I asked you to answer to 4 very simple and specific questions. You
didn't answer any of them. David sent a lengthy email that doesn't
address them, either.

None of you guys submitted anything to bitmaps - neither in library,
nor in tests. Your opinion about what is good for bitmap development
and what's not is purely theoretical.

Real contributors never concerned about current testing model.

I think that you don't care about bitmaps. If bitmaps testing will get
broken one day, or more complicated, you will not come to help. If I'm
wrong and you are willing to contribute, you're warmly welcome! I always
encourage people to increase testing coverage.

If you'd like to add new cases to existing tests - I'll be happy. If
you'd like to add completely new tests based on KUNITs or whatever
else - I'll be happy just as well.

Thanks,
Yury

