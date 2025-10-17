Return-Path: <linux-kselftest+bounces-43400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF0BEB118
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E451AA7A3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC629D28A;
	Fri, 17 Oct 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoH7KYbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5BA22A7E4
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722234; cv=none; b=HauO2Ukg9X7tYfaxVcbVEP4FYcrNB0p2iRHtTNYLRSheIckUROCpIKs2LkWENOUYb0wbz5WKiKDXALSF9GLpw4vBhgekyz++nkm/UVZv+Pw8eEjJfxCR8dZTkY+bE9vXSFXPBAjV/JHAp9YchzdiwTKR9R+l8fLyVRt+JEAD/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722234; c=relaxed/simple;
	bh=3UmOV/vZIGr3iWs6bHx6WZPio9wVxmolvVMuMjZBgO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwlzugFxigii8NQGE9hpfAqdAlOPGMd0NT1kRFpGvyKvCzyAsruvfHO6gIiD6pBpp1fWgds9ODxr/snvCa3UMsQz7Pmh6zkbfRKoTqvGEehdIIN2jSE0wYtRoQ39GTnJYhYzaGAe4m5v+IOmph9DD4KrnbIAU1ZS8NlRBHKFniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CoH7KYbr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so13095ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760722232; x=1761327032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIL1nDuSoId7w0AXQ//S+0eYpVMeQ8tIjQGoxQsFgN0=;
        b=CoH7KYbrTxfyclP5ucQOIi1ywseK4uG7i6FMuKcmh5B91tIgCwcicq9eVwMqWs81Gv
         7aR4l/SUOZ0JQSdT9MYfEja25Dt3IOt/uBbAiiCdrUZWoRy9ig/tbJHwt5AVuj+PB/mj
         mk9/Pi+igCof7vxnFp09JaO0OsOVz62NM7aojJ3hnXfpHbQ382M5ivqPljnIMlqIQl9y
         oR/JjDkeZtQjb+5K5x22tNUAf7a8D9iv545/6X9KXojGOBVW+6mklNZqqMFxBwTGFYMr
         6MXgM7rawEKZEsDcqgys2zVzzGB9UB5RUFansrHTNoEBgzazy+LQzIGtaCr9Ct/mWqeQ
         1PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760722232; x=1761327032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIL1nDuSoId7w0AXQ//S+0eYpVMeQ8tIjQGoxQsFgN0=;
        b=SepUEdk3QTXu90+AqLCoFlgS+njsmc62GBSt8BobhqUF/RREJ6qeTO+NXN6LjlEVzw
         UNdrx0SfHoVBjqHUcTNHmrLwLPRWAKHifY9c18LLLN4l6oGhILyYOhB5XbOGD+t18K0T
         +w0lcm8CAQDtBJZX8DiZcrjM4wG1BLylu3jbKvtYdcWcAbdRMCMDF05y/iSEVI/LGJYN
         lcslAwLlopKX6QcvTKWNoQaXDLAuV0xderA12w+odFUS10AiSep/zOP0RqLEsf6JGHIu
         jCrCpmxYFQvELCIH9EyQLxpfFYtYpPXhJfPAO3ACbd4zxCwA1yxAUhD8cCV+NHg2ZUid
         qkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoKc4agU+2zyBZRhoCBQLsBkpxW0YUPtbI3pB9xx75D4gPgY1V8epRKoBQqWE8VkG0hZB2Fjb26JhE8bCoDiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNxws9ijKsluU9iRX9X8JK7DqNtFiVlf3L12v4jXL26WPCDyD
	o25t6+d/d+K48ewSCvJNapavJVqXFJKC+gJB8VAY5gcZYs8NkcNE+ufzgvmPpIkeGA==
X-Gm-Gg: ASbGnct9sGS+5AN8uqZIlJY70DeMiUPpLLbnbkznXuSl7tWOhpH4DmvPU4Gvq3Q31Vq
	PbeJv7XYpXP8HiKvrqSMxpC9Twn00Jv5lG9CyZJWkaD06tOM/mUBkz0T8qHI+oJrlst6lrayxlz
	bA1cLqnJyajMLtEwLQ0wHwduATqw2QZkYBhGzFDt7WbCpvNSYBeC6sANICSaTjjaHfD9mS05D36
	QAIoYJio6DamSlemsljHatHM0JaCowCwEIBkbftVGaqRqfFk9x6dp7SbOYt8KwEGnFcptDwcPqh
	SiXcDVRchFPjUOvOV1k7M+d5uUKho7cE4Y0bVJYpQI91Sm3u2YXyRq9ak9loZSDa51EU9pZm3RD
	60VJAE3mDqlUXXDvYvXR9LRya/g7tGyL6oNYpnlxmhvCcTWSqTfAoQlmZC8ljZY9p38h5UymVl5
	Rd+P85l4dyAnacb71D4sMxkHlaVA+jKxGw1tbtLTTFT60mo0kTWmY=
X-Google-Smtp-Source: AGHT+IGSSk8fOYVNSVQWtRUBikGimjzWO1KLbKPMeaLMcileoYpa6q2TxT4nfsTijlIdFMktb4xiiQ==
X-Received: by 2002:a17:902:d50e:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2908ecfeb9amr13500235ad.7.1760722231581;
        Fri, 17 Oct 2025 10:30:31 -0700 (PDT)
Received: from google.com (115.112.199.104.bc.googleusercontent.com. [104.199.112.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd7e61sm891605ad.35.2025.10.17.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:30:31 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:30:27 +0000
From: Lisa Wang <wyihan@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
	tabba@google.com, dave.hansen@linux.intel.com
Subject: Re: [RFC PATCH RESEND 1/3] mm: memory_failure: Fix MF_DELAYED
 handling on truncation during failure
Message-ID: <aPJ9M25uaKsVC1U9@google.com>
References: <cover.1760551864.git.wyihan@google.com>
 <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
 <91dbea57-d5b0-49b7-8920-3a2d252c46b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91dbea57-d5b0-49b7-8920-3a2d252c46b0@redhat.com>

On Thu, Oct 16, 2025 at 10:18:17PM +0200, David Hildenbrand wrote:
> On 15.10.25 20:58, Lisa Wang wrote:
> > The .error_remove_folio a_ops is used by different filesystems to handle
> > folio truncation upon discovery of a memory failure in the memory
> > associated with the given folio.
> > [...snip...]
> > +
> > +	/*
> > +	 * The shmem page, or any page with MF_DELAYED error handling, is kept in
> > +	 * page cache instead of truncating, so is expected to have an extra
> > +	 * refcount after error-handling.
> > +	 */
> > +	extra_pins = shmem_mapping(mapping) || ret == MF_DELAYED;

Hello David,

Thank you for reviewing these patches!

> Well, to do it cleanly shouldn't we let shmem_error_remove_folio() also
> return MF_DELAYED and remove this shmem special case?

I agree shmem_error_remove_folio() should probably also return MF_DELAYED.
MF_DELAYED sounds right because shmem does not truncate, and hence it
should not call filemap_release_folio() to release fs-specific metadata on
a folio.

There's no bug now in memory failure handling for shmem calling
filemap_release_folio(), because

shmem does not have folio->private
=> filemap_release_folio() is a no-op anyway
=> filemap_release_folio() returns true
=> truncate_error_folio() returns MF_RECOVERED
=> truncate_error_folio()'s caller cleans MF_RECOVERED up to eventually
return 0.

> Or is there a good reason shmem_mapping() wants to return 0 -- and maybe
> guest_memfd would also wan to do that?

The tradeoff is if I change shmem_error_remove_folio()'s return, mf_stats
will be changed. I'd be happy to update shmem_error_remove_folio() to
return MF_DELAYED as well, but is it okay that the userspace-visible
behavior in the form of statistics will change?

> Just reading the code here the inconsistency is unclear.

Another option is to add kvm_gmem_mapping() like shmem_mapping(). I did not
do it because KVM is a module, so we'd need extra steps to check of KVM is
loaded in memory, and that's a little more complicated. Also,
kvm_gmem_error_folio() already returns MF_DELAYED, which seems to be the
right thing to return.

> 
> -- 
> Cheers
> 
> David / dhildenb

Lisa

