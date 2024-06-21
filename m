Return-Path: <linux-kselftest+bounces-12429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B44A91206F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46133288198
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596BA16E868;
	Fri, 21 Jun 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0k3NfcBl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDD16DED6
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961917; cv=none; b=ZV/30EXB2NYDhWaV2kUD9IHC4TwJMKgv+9NFvVsCyJYCCy4LJQrAdOwzapm3oT3NbmmIjQeF8t9rutyxJXq6EfSR4tDQ3lsgE2fPez0t/bd4PizfVy6bqeQGhGEqwQSj+WjMFUYblrMrfPizTRDXB1YBz9RkwUpHByxBa2CS8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961917; c=relaxed/simple;
	bh=IVf06wXtoQ06bGlwMj4u28LbqL8Tx549GhE4KTb7LS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/fSZ/zqiOdc07W3AkCJlaHX5flGpNlgygTOb3wTR4xmj5G5jaQLiRD4Dset2OFsEJtbS0HVgzjsQM1BWuUrVH6p+jUg7vgoPRsPWHfyUjkYo9LRsDT30jglIKHPSnjBpdB3qa5NANby1QtBG04Xe6mZLslzCH/ascDNGHP41b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0k3NfcBl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso1979991a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718961914; x=1719566714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ7kPulOx451lKRJFwdomb+qJgH0vBNRBUJ9vVH3v6U=;
        b=0k3NfcBlQ7nqkYtYow1Tg9e+/CF5M9pR04+jU0wT/dpM9YtPoXVMyX+Eq/3GgJGcR8
         xAge2WTquRxBXtNe7uvMt5NlU2YbC7YQxcqMDXD3XVVYmHWp3q6HH1QTkv4hSRC7essk
         D7RRcI4L+4yEsYjpocdUGv3G8cwTHSLvTaQ/Ly/5sb7XmnVzoq2icwVK0DCElALyyHdZ
         lYQ955GhUR6W6ZQ1s4n/a/Wt0GU3mGyoOLgTI/2mepaI4g0JI9Eckgr2GaHByE0Jfwtk
         VYNNkNNeXTeJ6qoxwgqRtfNK3T2K7pF6jC0t3ctetV9LkETfFUL+ngRf66opetRQiGhZ
         uueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718961914; x=1719566714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ7kPulOx451lKRJFwdomb+qJgH0vBNRBUJ9vVH3v6U=;
        b=tWeaQCXO46J0gUdxRanfDrtKk4XoLtbR+HnB/Y9G3DStEkod0NTSPkHu7LaBLHx0ZZ
         sLwBnpPd21io8lFeFdfh+TfJYY5aK57GPlrslOSZ6BJfnr33drKTXEPBWdZnMWh6jrRn
         YaKM1OGgZBECisJP2Ta+0ApuVruG2sQ3ABPMvt7cqCfalikW0pO3pLe910syekVvDmD5
         aTZtdfUbZ0cC0MEb5YNwDjtvH+s8XzdD+MUn0O7NqlOu+Q6Wrz81ERaX/X77me31/zig
         NdLGNG6QJv//eE24j8576Kn0USbCZwrbINQqznWvLfPtabN8XQXjGiH1pRds5QU6T9HW
         bZvA==
X-Forwarded-Encrypted: i=1; AJvYcCXEZHvJxmP6w3iBK+JQYZp8ZGOuy+9GpuHbucGvOTRDM8/zKzCFgpCNVW8EH8m11HwrWR2TR5ghweztOxDqOvM3vxaUm4iBqXgmdMtPigqr
X-Gm-Message-State: AOJu0YwMPQmRoPBomCccVVcw2oIhRdWytH3f9WAno1YYWGiQgno1+BwF
	UhohgYJLrSpkRWsp97UBowWuDKkVIXuZIZjMvGTQURldhvoBYaPgJfe8sucwFA==
X-Google-Smtp-Source: AGHT+IEpz/9QgX9U5wyhR6jzpLAUkz7DFkr/DyE9ciM0TRNOVp0gEwP5yeSZ1FfEyhdCaNpMGEoyBw==
X-Received: by 2002:a50:d71c:0:b0:57c:d237:4fd with SMTP id 4fb4d7f45d1cf-57d20d49ee9mr2816823a12.4.1718961913575;
        Fri, 21 Jun 2024 02:25:13 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d8b1sm683245a12.45.2024.06.21.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:25:13 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:25:10 +0000
From: Quentin Perret <qperret@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <ZnVG9oZL4GT0uFy_@google.com>
References: <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620231814.GO2494510@nvidia.com>
 <ZnUsmFFslBWZxGIq@google.com>
 <c05f2a97-5863-4da7-bfae-2d6873a62ebe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05f2a97-5863-4da7-bfae-2d6873a62ebe@redhat.com>

On Friday 21 Jun 2024 at 10:02:08 (+0200), David Hildenbrand wrote:
> Thanks for the information. IMHO we really should try to find a common
> ground here, and FOLL_EXCLUSIVE is likely not it :)

That's OK, IMO at least :-).

> Thanks for reviving this discussion with your patch set!
> 
> pKVM is interested in in-place conversion, I believe there are valid use
> cases for in-place conversion for TDX and friends as well (as discussed, I
> think that might be a clean way to get huge/gigantic page support in).
> 
> This implies the option to:
> 
> 1) Have shared+private memory in guest_memfd
> 2) Be able to mmap shared parts
> 3) Be able to convert shared<->private in place
> 
> and later in my interest
> 
> 4) Have huge/gigantic page support in guest_memfd with the option of
>    converting individual subpages
> 
> We might not want to make use of that model for all of CC -- as you state,
> sometimes the destructive approach might be better performance wise -- but
> having that option doesn't sound crazy to me (and maybe would solve real
> issues as well).

Cool.

> After all, the common requirement here is that "private" pages are not
> mapped/pinned/accessible.
> 
> Sure, there might be cases like "pKVM can handle access to private pages in
> user page mappings", "AMD-SNP will not crash the host if writing to private
> pages" but there are not factors that really make a difference for a common
> solution.

Sure, there isn't much value in differentiating on these things. One
might argue that we could save one mmap() on the private->shared
conversion path by keeping all of guest_memfd mapped in userspace
including private memory, but that's most probably not worth the
effort of re-designing the whole thing just for that, so let's forget
that.

The ability to handle stage-2 faults in the kernel has implications in
other places however. It means we don't need to punch holes in the
kernel linear map when donating memory to a guest for example, even with
'crazy' access patterns like load_unaligned_zeropad(). So that's good.

> private memory: not mapped, not pinned
> shared memory: maybe mapped, maybe pinned
> granularity of conversion: single pages
> 
> Anything I am missing?

That looks good to me. And as discussed in previous threads, we have the
ambition of getting page-migration to work, including for private memory,
mostly to get kcompactd to work better when pVMs are running. Android
makes extensive use of compaction, and pVMs currently stick out like a
sore thumb.

We can trivially implement a hypercall to have pKVM swap a private
page with another without the guest having to know. The difficulty is
obviously to hook that in Linux, and I've personally not looked into it
properly, so that is clearly longer term. We don't want to take anybody
by surprise if there is a need for some added complexity in guest_memfd
to support this use-case though. I don't expect folks on the receiving
end of that to agree to it blindly without knowing _what_ this
complexity is FWIW. But at least our intentions are clear :-)

Thanks,
Quentin

