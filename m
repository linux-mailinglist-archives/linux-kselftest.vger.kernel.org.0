Return-Path: <linux-kselftest+bounces-46695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91926C9279D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5021B3A85ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3292459D9;
	Fri, 28 Nov 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REIDaUaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EF79CD
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345062; cv=none; b=ahkOmTpqGkhgquYbfaowHKtYisNDA/GpV5gvEcBT/dnIkl0R7TcYTzjNVKaj6YSfyHarE45AuqAxAbFAbHVWBy/7f1uoemTKkrPksAApyZ285ETnZE0xJ6WWLXcJy5ngbw04htk7wFF97grjukJNhPvcD+uzx1TcnMO5fkSFpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345062; c=relaxed/simple;
	bh=MGtL6DfpEfB/mkAXzLzzie/i+p22c/hsHzJYktd8RzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7Zs1Ba7R0EGcqqsusGu3+tYUskQpEw7lu3JL7T/BF9bdRl3e5kQr3pq9Pbjqe2VN8owjIJI/8Iut1kKo+e6E+SccDRXKqtD6ShGsHitBRnlQ6/nWC5HIX+5mHKctXp9NE1yrWz7GNMkP0EuuI31xgkZL0OeIGKsGTX85377kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REIDaUaU; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so1671473a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345060; x=1764949860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P61WKJnqyh8/Q+jWB9OZ6DHYmVs1u+jLgIH+gZ1ifWY=;
        b=REIDaUaUqcK9gN6uRpXDMYDFlBZZbLmjufKjW66gKJ+MMbzZXG5CLtLhxHdNRa2skM
         GSXkVjt0N0jjNw/1KXhSdQrr5IzFF1/Hkn2Vjg8xYLCKGGg/48uixSAQM5Lq+1o/o8Ez
         c/DWKqFYACOVxHrI6Hq89HKclWHmLMAzvzFpMBGWACG67LchHc28TGf92tN/2PxhMVu3
         KUWKrE03pd9n2MgH7yOmOoOjr2VPMRvQTSj5NBj3tOcrbezAj4BuX7/P4mgpSthsg+ii
         xNNKnMu5r3kzFGjqKfGGWA3utyAeQtSUrxVKJ22hG2drr9Ky0AC2HaN101sydM/PQ/Dw
         6m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345060; x=1764949860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P61WKJnqyh8/Q+jWB9OZ6DHYmVs1u+jLgIH+gZ1ifWY=;
        b=Slo4f6CCWKW1OLLFuJp9iQ+Q/h9V0XXeVtf/TlZQtCbxMKhm6X66fW7+6VDPnd3vYY
         dDbnTlHSmW3quncH9g9n0LiU1F+fMoO/u8TkYi3cb1HyJy9s0ZanNmwXbvOW5zIbPWiv
         2X21Dmo7h9k6SGoOBfMiemzDC04U/oFkVgab4VhDmjqToSsfe/RkSdt3tnFSCgO6V84x
         TXH9W5B+t0vtTq4CUSbWbAmS50AEUcVf58susDiyaFyPWnqP2XNXsHUzTds9jLsF0C4p
         AP2ZQvviO8XbQxjaH8rMNZPf5MqbUPXrSUndXfQXkhikH7DdNt5ASSJcfoPRM5VfJsjH
         RxEA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0qqjE1L/Q9vUnk5RYYhoSwP9J/EF5LCrdLiUTCC8BkZuOVMHe7qIQipvr5AzSgnPjdkO1LYyiwZ+xJD6iDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTNi1bSI4w+ViBOh7IuFT61ki3DtY1WGoixDNZKl+h37nT2qL
	soQwFeiERBw4Bp6FBO8dXktKKWuDU09uZUVwb8CuSJpf+f63oV+kGxkU
X-Gm-Gg: ASbGnctR+pIHZm1uLgxmpUNOJ4ADDlluiGQhIIoIt9u2obMUgFqBxmiM/fQnpoT1Lkx
	AC+Yw3bIwk6QK6iz8I+OoJQ8h8IdDPXoCtadgoUxKSvrsCdac1AJ6od3hSuie0trZzxMsELsgFV
	rCQfr3HWn3RVZ5Rn3XcOPWsx/odmKeKqbFA/X3JK+d1pnnyi8ejjJQ0iknLSBXnmIQ9aW73MRQy
	MQEFhU3CdNmsqH6ixf6GAJhgzlUhxuPTCVQHoUgyN2PYJTutKDPb7Xjxg3kB1TL4MIq7pVPYM4X
	cMpc6+62X0PVxVtkCsuHTcZlHS9AXzAcnK2UdRMHh8U0OCLHtxQCdGHrjoVjoMKL1Jp80/apNyZ
	g33JtPpnNwL0sEzhIrhPlRQ2e/xLCs8UAVTmHRSSDUHoKSB1qRHfGf8yVSQXa0VoSEKNnhw6LsS
	tJCw5GkE7YMTzWflB3HTT5rEKxltMxwQ==
X-Google-Smtp-Source: AGHT+IHDXjnEWiD4Ij3Aoqmu0wuirePC/DePO6Ksg/pXsaBSBRnUOru5vuneh2uWo3PUFH/miirhXQ==
X-Received: by 2002:a17:90b:4b8c:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-34733e4cb74mr28454632a91.6.1764345060177;
        Fri, 28 Nov 2025 07:51:00 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be6ec21e044sm2533746a12.12.2025.11.28.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:50:59 -0800 (PST)
Date: Fri, 28 Nov 2025 21:20:53 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Include missing uapi header for *_VECTOR
 definitions
Message-ID: <aSnE3Q4kDAjIrC9Y@fedora>
References: <20251115110830.26792-1-ankitkhushwaha.linux@gmail.com>
 <aRs6EbV2gnkertzA@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRs6EbV2gnkertzA@google.com>

On Mon, Nov 17, 2025 at 07:06:57AM -0800, Sean Christopherson wrote:
> That means your build is picking up stale kernel headers (likely the ones installed
> system-wide).  The "#include <asm/kvm.h>" in kvm_util.h is what pulls in the kernel
> uAPI headers.
> 
> Selftests uapi headers are a bit of a mess.  In the past, selftests would
> automatically do "make headers_install" as part of the build, but commit
> 3bb267a36185 ("selftests: drop khdr make target") yanked that out because there
> are scenarios where it broke the build.
> 
> So the "right" way to build selftest is to first do "make headers_install", and
> then build selftests.
> 
> Note, if you build KVM selftests directly, tools/testing/selftests/lib.mk will
> define the includes to be relative to the source directory, i.e. expects the
> headers to be installed in the source.
> 
>   ifeq ($(KHDR_INCLUDES),)
>   KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>   endif
> 
> You can explicitly set KHDR_INCLUDES when building if you install headers somewhere
> else.  E.g. my build invocation looks something like this, where "$output" is an
> out-of-tree directory.
> 
>   KHDR_INCLUDES="-isystem $output/usr/include" EXTRA_CFLAGS="-static -Werror -gdwarf-4" make \
>   INSTALL_HDR_PATH="$output/usr" OUTPUT=$output

Hi Sean,
Thanks for pointing it out, i am not aware of these details.
Will take care of this now onwards

Thank you
-- Ankit

