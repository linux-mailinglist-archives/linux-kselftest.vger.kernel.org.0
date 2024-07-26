Return-Path: <linux-kselftest+bounces-14283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0D93D9A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB371F2394D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669B5588E;
	Fri, 26 Jul 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhDeKhi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6271CD06;
	Fri, 26 Jul 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025327; cv=none; b=UPNdLJUSD4sJjc63JLmfKCp2dW2OHolwIxhnDuvcJ1A2jbcm7S4z7eN+4nceVpqPTIiknCvpl+Y6EVrUjXWlRDAf/yWtJ/BmlWSyVzembWesHn8cVa3/gSw8wVB/ijchGwsPEEf0uhwxAY4ih7GCv7FSmtfebxtcYK7mfIHMky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025327; c=relaxed/simple;
	bh=M7t73o1/Lb5UZ1Q+Cvsvq1ULxbJOCsc5N+cSMT7TqOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9Iq9q51dnmFrObjZp9DrPlpHdefDy0Ucc+5zFp6gimbIkFnnCNB9Vmy2zd8jmdta3myzjXo/GSKIyFQ6iaIZSu9Oy+hm1/n17stglO3zwEREar82GPaGaUDv05ZZ0QFlvxLgGzIa0548ivtwGaSdEyLoMfTtb3ESQEISEWQyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhDeKhi8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fee6435a34so9055195ad.0;
        Fri, 26 Jul 2024 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722025325; x=1722630125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I04y2vzUB5spbfoQs+w/eH+P8YuqTfLTQOdpnSD5X/M=;
        b=dhDeKhi8wBWM74OXh1JZGht+VRDK/wElP/+BOazGaTK5iaaA3+Cq2l7roaaYpMY8Lp
         EpdpFf3QSPDynT1Wwju5IGoFSF4nbpvgf8cqPOg9+etXDt3Upr3Lvfa3/+ij+pXeHji/
         MiDZSv7k1NYRvgcOB5kXHyCzxMwLHGhSWNOtoJ4vvQUcyinUVR32pYPFqug8ntARxVC3
         Y16vK7/eDm+2LI4ZWTl/hO0mpknGcULOSRtOTPkyPpR+JH/1Vey2f/P6iW+fLFV72bK4
         rwBijS5WLPksGJJppZCr3Ux/QyPmViIx8740BQvDMzlQKcCFkASbhlkIo51iS61mp6DP
         W3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722025325; x=1722630125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I04y2vzUB5spbfoQs+w/eH+P8YuqTfLTQOdpnSD5X/M=;
        b=a9KBVS+6UFsRz53Ec9AN5Lcfxu4Vp6IUZ0zNph+lF/+k3O53zgXNniuhSgp/B+ww7g
         bcs2+NyqbZcHtYDjXklw9ETrtohomlhZ4XQDr9zB2qLPIf8LlhCrTG9IG6bDTa1VDD9F
         IAyqXfOCCxhmTI2GzwQeTQx8P7YjDLNWaaoaK0zP2uBih4xp74vCuoIR9LDg/HViykrA
         sqX1PHJK/k+vc4x/1KmpbNHfxvW0ILPrcfvdSbxKz8zivcgxE7aLAfnpON+vmrrtNTww
         N3YKAvxEyJNvOCqzGQB13bgQAfn4OiEBSqCy9MKP/8IMImpk6v+EOkYmisDShZcvmnhY
         GX1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2c7lCaCTiY7LZlHsx6wD6g2sGXcZqeGTWF7CKMsp3EvYdwl3cNLrJR+vatgGYUW8BSLbQ+Q0TTDdTEwNXE7lRcrn3lbzwesozu1lAlv8jOmmPGP1yXFGRxRPvitLEFZw/mOHa3WR0oNy7zhqX1c/6dsdp02Djj0aXK+F0+wYXMajcEQ==
X-Gm-Message-State: AOJu0YzDVQzFbDxpA9OUY50I8cKyt4WjQcuqHrA3sfykxzY9TshT8T/2
	vVDbHy8oicw0kqo1Ft1YJXgIsRZivnfbpiYospiURCqCLbxg7tQ3
X-Google-Smtp-Source: AGHT+IEmKAq2//jjyyQHgSfVFlu85kePhlWK9rvBRE8BIl7ji0JX/M16W7mdND1KTEuRHR07HFZmOw==
X-Received: by 2002:a17:902:ea01:b0:1fd:d4c2:a2ef with SMTP id d9443c01a7336-1ff04839437mr9349225ad.21.1722025325480;
        Fri, 26 Jul 2024 13:22:05 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee302esm36896745ad.145.2024.07.26.13.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:22:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Jul 2024 10:22:03 -1000
From: Tejun Heo <tj@kernel.org>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZqQFaz07jIg4ZKib@slm.duckdns.org>
References: <20240723233149.3226636-1-davidf@vimeo.com>
 <20240723233149.3226636-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723233149.3226636-2-davidf@vimeo.com>

Hello, David.

On Tue, Jul 23, 2024 at 07:31:48PM -0400, David Finkel wrote:
...
> +	A write of the string "reset" to this file resets it to the
> +	current memory usage for subsequent reads through the same
> +	file descriptor.
> +	Attempts to write any other non-empty string will return EINVAL
> +	(modulo leading and trailing whitespace).

Let's just please do any write. We don't want to add complex write semantics
to these files. Writing anything to reset these files is an established
pattern and I don't think we gain anything by making this more complicated.

Thanks.

-- 
tejun

