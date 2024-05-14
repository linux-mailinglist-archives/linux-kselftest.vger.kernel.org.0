Return-Path: <linux-kselftest+bounces-10193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057F8C5BD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C0E1C217E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401C18132E;
	Tue, 14 May 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZfnpfGN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70B2AF09
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716337; cv=none; b=XRzH5hcR1MSeIk2Z8GadlI44PFrTO4nx6deWpwF2wJ9sN1Tii6dyNUOUQ0NzXL7zkpZMVZGQblS0sc/xGACsIru5h1Sd4CZ/GFXlY1bpifwe+8Fia1GduQkzf/XFK/8g6MTZPlVW/arP3dFRVDmRisiucydWQbZ5FKBZG7i5gDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716337; c=relaxed/simple;
	bh=sZP6tHo+9CZUoeCNklvRvOlqbMBw89gzuROoS4J3Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bfb83ZVGJMubvgbq2HNtsXzRuXF4tWw18sThcH+a5JvhyIacB5oOiFcBlr7HY9VjtiF1YJEbLvF8Ub2btQ4Dt69cJSRn4JDuDxMZu5/m7Mkd+JBauBKsNu2lM+vpwJjmNVe/047BPicC5//+q8jzppbfJFROzCn7ht7kmws1Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZfnpfGN8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f05b669b6cso32798675ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715716334; x=1716321134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=ZfnpfGN87jzG0rt/lfhe7vQg/eTCzaodROzOlcQIx6Vet6mWXxV+LrOwJQblYLeni/
         dJGrz1RnoNb1mWjELi77HQlSyyf24fbpmVjwXGl052q2NvRXmG4e1GlPytFtJhtpAEx1
         B0izW07S5S2J58Qg+Fj2123oqlSEPnqklv1WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716334; x=1716321134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=ltmzU3aQKBQ3zBHcYs+K9KIyyEO7Ngsa52hblxwHG2JgjspvUOa+n4tOruwcrN4H/d
         oSHPV4B9gMQ/ZW49XGtLCbc4aBr0VeQ63OwDe8DvkUVF5U056UfsNMETIqbozUwCVYxy
         rsWXQ4/SovucwYXnvvQBYCYaOp7oeJGavChgRVOyWiz56dDtCn+YSGUQt/hp0A7sDoFr
         GxaEZ9F4bZd2m0ecWuU24/iLVovO7vfC7tQrrLHQrz3GV8/1aGXU/Fz06o1FB3j0FI0O
         GVnucxriNkAe8pRE0BXxmORoMHWW1gewRXeq8TsIykS13fW9vHJxZa/yis5daH+kaHFv
         cm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9uZ2IEBok5Nvd0UaAHHsMx8gJ6/LSeCP6AqhdgW10TbvTTVtWKUXXnWWJoxN6RwC5PUa/MOekx2OLDfyiiKnNWqK0UnIWRhe/btJTyh8v
X-Gm-Message-State: AOJu0Yz6P7zBfusAZKtxFCTBh1e6xxiE/utc5lZv1t+hJvqKAOq1FhfM
	yMJFmNRoq2M0XzxrNJHuLlnYha9JwYd9MPfN92pOANoqK9dexJzk2TvOvunqUQ==
X-Google-Smtp-Source: AGHT+IE4USN+kE7T6RZD7G5inzqpecMh0wnrqgy4EQ6oLTRU7SRnjNyHXsSdHHrK+4e8wMQQLJM0Rg==
X-Received: by 2002:a17:903:2290:b0:1e0:b2d5:5f46 with SMTP id d9443c01a7336-1ef440495b7mr159207695ad.46.1715716334549;
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038c4csm104274535ad.226.2024.05.14.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Date: Tue, 14 May 2024 12:52:13 -0700
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
Message-ID: <202405141251.8E9580E@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>

On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> 
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> 
> I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> of the total lack of Reviewed-by:s and Acked-by:s.

Oh, I thought I had already reviewed it. FWIW, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

> The code appears to be stable enough for a merge.

Agreed.

> It's awkward that we're in conference this week, but I ask people to
> give consideration to the desirability of moving mseal() into mainline
> sometime over the next week, please.

Yes please. :)

-- 
Kees Cook

