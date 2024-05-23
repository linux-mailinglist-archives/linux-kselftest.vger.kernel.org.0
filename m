Return-Path: <linux-kselftest+bounces-10636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C28CDDBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 01:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7C281B7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CA1292D1;
	Thu, 23 May 2024 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYAIR9C8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0B83CC1
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507151; cv=none; b=cy0BJ7tDzgOJGxZAW2lvfMlfd5x535DKxji5PxtUNtZ1sUy+MJjCORu9Y3584ZnUTni2Nj/PAPHxjRd+G4yYoVq5jd7A97MZLFv646W3ii4+VTT3it7Y0aKF+6tD3JP6G5KPM4qGNOWS7WqRlBUbiir5MMtz1BCyig5q1HpYlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507151; c=relaxed/simple;
	bh=Rl78iHC2xR4eTLgM9pFhtSrNG+eYrSYtgxu8L4wWsfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDenfUeCdGVeeBxFm6NK1QeUka8gBykZfGn2aJ8IogNsvEdJn33LdAY9c8zn1IzRpZcQOuxCdw417eIyQpc3QPOGYkeZUtw5971WsKf8wwQ44BtpKYnV+W8CGqg+xupqbukdeHwzgIiEI8PNXFe9clM/cbp8XFOCmuaWE3o1KLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DYAIR9C8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bf62b121ccso60453a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716507148; x=1717111948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=DYAIR9C8W8spsie8Pc8vutCp2t+Jd2cRx0RdrITfImvTQVPr6GxPEYOGVED3WFHFNi
         ZMOROiAYQuReyR0EoAisvfbR2PESQXw/F5sye1MV6wcwJ793FpbG389fU8wEL6oBE9xP
         DmUvIGd3QQtMbsPTbBRe0VhVt2GFPRAlkstrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716507148; x=1717111948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=pG3NgwzovZSmXQdqSfHj4HXXO9z1nazsOHPGPWes+nhjoGBrGYjy4yjjBiZi1QyvIC
         sZrN3gWW86VZ9jLWqH0gGvXF+rYtY6au85xpJcZvFv8bKC04G3QPqTpo6GXYYI6g3iB0
         o4mAQoUC8e8fcsPj408CEEVVPsMWVTMHSWI57VFWGuZL8OHeHqF5Zp8upUMbgjGFGEih
         PDGhT2SvaWOYPxzZPALZG5HxaxkHU916ZZgi6S9GVT/XafAAmR07wNhzXP8mNGCn9RYx
         nOLF9wiVzBWBdNLNC8vahaIJe7VsmGmaCoCRH8MrzxCyOVDPly3z5sW7W4bS0pBhN39s
         UHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSDixRlgvFTpRoU3gX/Gh2xUPHKT6ZPkRRaoU+FbqafV7J6cZhPD7oO9g7rN5Am3qyxa6X4MLjE/woofLx9I8JxkO04lzqUD7uAuorBEie
X-Gm-Message-State: AOJu0YwEHi8SU/waetrEOdFIAD4XhRwdFzK/6khd8Y77yQGon+JSHw91
	FwqS7395O+flFsV7SoR7701ZGPkcgdHXnDh2NiJNPM589jylyqxpL9lQHXD6Lw==
X-Google-Smtp-Source: AGHT+IFOfvlBfPaN91h6KUnDd+S4/iEFS4mMZGfINsKu6kdcMCF6+DYoaaEjtaJjxvPHQzQQjzLQfw==
X-Received: by 2002:a17:90b:ec1:b0:2bd:d898:8732 with SMTP id 98e67ed59e1d1-2bddce8fa91mr5008761a91.13.1716507147992;
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f615b9fsm247043a91.34.2024.05.23.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Date: Thu, 23 May 2024 16:32:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <202405231628.BBBB9787F@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405141251.8E9580E@keescook>

On Tue, May 14, 2024 at 12:52:13PM -0700, Kees Cook wrote:
> On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> > 
> > > This patchset proposes a new mseal() syscall for the Linux kernel.
> > 
> > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > of the total lack of Reviewed-by:s and Acked-by:s.
> 
> Oh, I thought I had already reviewed it. FWIW, please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > The code appears to be stable enough for a merge.
> 
> Agreed.
> 
> > It's awkward that we're in conference this week, but I ask people to
> > give consideration to the desirability of moving mseal() into mainline
> > sometime over the next week, please.
> 
> Yes please. :)

Is the plan still to land this for 6.10? With the testing it's had in
-next and Liam's review, I think we're good to go?

Thanks!

-Kees

-- 
Kees Cook

