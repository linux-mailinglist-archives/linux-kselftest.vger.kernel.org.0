Return-Path: <linux-kselftest+bounces-28800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E949AA5D848
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF97A7CBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB95235354;
	Wed, 12 Mar 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ny1olTw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A523278D
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768474; cv=none; b=IC4jx6aaR0r+9SafN1mojDTjgGfwhnJEtgsGlMEot7GONFNZpS47CnG3FoD6Gnw6aH+VE6Eqbcqwu334maKUMAvKj08qQAQIRo5Dzh8Lmdp+bMYIO8RJtVq7CThmTBVR3nxpv+SOby088Ge01bnXPJmKWGGKwMbZY/gDONp9QkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768474; c=relaxed/simple;
	bh=0kjv16UAwseS8JksZlMETf11NjAxs9jRYijgK9qxmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH21oXbgEoqksFiN1kqRM4KLf5w7EoW5ueU6rOxKnRZzjgqKRi7IheB9/CHtyBPfTnZ7aun8Gt37c6bTjAeShG+pj9l7lKVSNl79u4sLs2mub9LoMyAKLU4DYoblRgHVfjDWH5BQng5GcrPDRcoWuAvINfFJ2yg+4OPxdogh7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ny1olTw8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe808908so32355e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741768471; x=1742373271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQWaJZrZr0xUSSNup1mdrv5CIAgkfPyhoViquwJddIM=;
        b=ny1olTw8aGAtuXE+ZTbt7QSxWsZ0zNfhfi7Gp4xZtLYHPIFfZRicm4hS145Zo6JeLl
         DSqvuRbHuzF1+3ADSRNH/uLLmR2BpNi/A/HwuyX5zTkYqFX/OmUtV+3/STC4sC/6nzxI
         JX3m/ISJa1tVuBywyu4UDMuX2Ycx6BQl/Bjn3mAuZq/Ur+LZk+5dYqIb0llh4ClX8y4P
         eIgWwYs+hTFcVctnYLUCkolJ76gD8adFcKLm6d2crEe59ri1u+f/K0oxgjeCAhUr98dC
         cK6xzMrdtmui2XTpdLAaGpp2aujB9hnO56pQHeNFVmsRi7DIJp4y0IkvEUYZHBwSrO3y
         Eqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768471; x=1742373271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQWaJZrZr0xUSSNup1mdrv5CIAgkfPyhoViquwJddIM=;
        b=T3ybBlqvvDZXP3wvvG5w1+6ofEPLy9Ar6Q/9XDFkupJ/Cmu7LisanBl9fHIPPxMcX0
         5085DDWV5GDPUFAUdW2r5LVa3LsC91LmwZlpmwrA9d8LcmQezW6WnX1jHI3f9xNEk3FP
         WoRfZ2wRmJS3zPoC8Vtq83A0VFZbLtYXE6QMf8k2ihpjDJJa5slQuUQtIRvRt+JTAgfP
         68nDvKioXVDUkYdjMGpOKvPTkeazOLzkWHrVjdfnxpqmFC06QrhMMUMzN+Pwqu8bTZ3w
         zrA3pbSpX01fzFrIe85X/FHitEeeomMncUUwqVElu8LuXW52YJkvy32hqvh0diO9eTCQ
         GvvA==
X-Forwarded-Encrypted: i=1; AJvYcCVyG4Uv85Dg9af0gVDudAXM77A2giJp5VCMNlJSfOgCLBJOWNQI8NsvGeEriF/YJ54zSGDZ51w+oNZkLT00yc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlMDdFZai6y9MJF+gdPBPcIJyMd4UOP5qGZBPyjze2YRtrUsq
	2LdTJNxFsd00n0j+48r/Zj/0iQa39HPXJrpuIEP4FLIxzkttJN6b/DgLzib4oQ==
X-Gm-Gg: ASbGncv7fIGOj89w/Zzez5U12IXdJWxxorjbYrVG/dz/svYm2gDAE6a/DJd2qBy12fQ
	NmcGJ+qeZyV/AucjEGEhUr14tnmH8dI3i0T8rpEmkvzdzm57j0RBawqZZv2AYEvaHv9xRFw78Rr
	/OZc/Vc+RoQ4xg2iBc48f+j6wo0CiIfX65ikw27iTL9RyW9yMNHd7m5OpRG1w7TQzOL8KyeB33X
	EzLFObcLEDLiIPA8dWKjsavLscwwayhZx472OF1PTy6pk9oA/yUHKqGjPrbhSis7bwCtRJ3PRiQ
	pfrrFp7RQwc0U8C6sR435pRWOP5DI51uWlMsaWidGN/MSdKl1aRdkwyRMOk0WibLbmYNDFBSJhs
	JuOiK744=
X-Google-Smtp-Source: AGHT+IGTGdtQIMwZvqc+1o7EqwASuYBuINZW5/L5S6tMO6f4OuLHSRcUxmyp21aGik2Fx5ziZSuHfQ==
X-Received: by 2002:a05:600c:12d6:b0:43b:df25:8c4 with SMTP id 5b1f17b1804b1-43d09e9c951mr907895e9.4.1741768470612;
        Wed, 12 Mar 2025 01:34:30 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f4fsm20260383f8f.77.2025.03.12.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:34:30 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:34:25 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
Message-ID: <Z9FHEdZoYbCMoj64@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>

On Tue, Mar 11, 2025 at 08:53:02PM +0100, David Hildenbrand wrote:
> > 2. 9pfs seems to pass the f_type through from the host. So you can't
> > detect it this way anyway.
> > 
> > [3. I guess overlayfs & friends would also be an issue here although
> > that doesn't affect my usecase.]
> > 
> > Anyway, I think we would have to scrape /proc/mounts to do this :(
> > 
> 
> The question I am asking myself: is this a 9pfs design bug or is it a 9pfs
> hypervisor bug. Because we shouldn't try too hard to work around hypervisor
> bugs.
> 
> Which 9pfs implementation are you using in the hypervisor?

I'm using QEMU via virtme-ng. IIUC virtme-ng knows how to use viortfs
for the rootfs, but for individually-mounted directories with
--rwdir/--rodir it uses 9pfs unconditionally.

Even if it's a bug in QEMU, I think it is worth working around this
one way or another. QEMU by far the most practical way to run these
tests, and virtme-ng is probably the most popular/practical way to do
that. I think even if we are confident it's just a bunch of broken
code that isn't even in Linux, it's pragmatic to spend a certain
amount of energy on having green tests there.

(Also, this f_type thing might be totally intentional specified
filesystem behaviour, I don't know).

