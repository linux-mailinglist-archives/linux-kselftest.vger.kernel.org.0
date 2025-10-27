Return-Path: <linux-kselftest+bounces-44135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2991C0FD3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C761350953
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228131B137;
	Mon, 27 Oct 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Cx6GGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7A2C029F
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588102; cv=none; b=uNA9VRMJdXwRAwY6Td2hRO97a0O8mSmhotwhzDT+DihzIAvufTrlotD5cD5xe56OWQkibCxTtOwPOxBfpKhVBtSzLkIE1KgpqnuV60VdrSZRU/PyMV3rmSk8K3hNBRlLnXkioIbJSJnT3UvRBVbf/SHzSaZKbwSw/n5uI0NSmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588102; c=relaxed/simple;
	bh=F+dHEiFLnh8A5KzJ58bksVScGa0jeuzf/tPIICsdU6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdEzz+ztEohnqnpyH2R/XKrs99JY5FWPKuBCyxNgbHScHJOTA0ADHGystZEHhi2JI992fgIUTsa02Lwwom53pQ0OmOACVyGmQpaYhgnFXfTC08+UcueaUeJPQkKhQNwlvUI2hLfZw9fQYNWxU6AuA47wAvtcEH0IxBfowiT914k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Cx6GGS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-781421f5be6so55453957b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588098; x=1762192898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=O6Cx6GGSJIbiI2nx+yk+XY+6BIUZ60igmRyRnixex/8rG+NRQXEQ7mt9+dHbkKPida
         BMChyTjviwcfxMxqNp+wP4i7iO2D7FWRgC6MaZR7/GqQ6KYGC37nvhB/MRCmY58teC8w
         sztrkM+/oQORh7mDIDZ1gFI823xwKucQ4cdAyazgCqwWGNXR1nI9HJ5PqYY3tZ9p1yNz
         5cZEOeQLJ8Rz2CZ+7avlKRQFpW2Wax5/oJElUYrPpxAeVuEg6YqGBi5nanESCKYoYqGw
         b9ZITqXUzv0m+7aQ269qHr7ppIWhhRoNPZHlMjBDPwfnqyI5mQLDUBiXVcLb/hg4Nn9D
         mDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588098; x=1762192898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=EMsJkKE78PlHFQGWdBmpze+FSjJKNEwGjO92eW05dUY1L5VWe49EI44eZwreDzBbxI
         v47gBgcsoGRxCuFXUoUByIh95rkBE/NSbQY72T5IPq5eSvaK7Qs9LIcGmZZ4QmM8drn6
         yHh8RI43g04Lmc+SWz+ZwZO4zTA26tH0/hwGJlU2SSPNMWI+aTeTFPYItJr7s/9AzGA4
         c+khxmaR6NotMD+9g5wPfjtw/f0A31MlTkUzh1wgipqI9SESJvdFKXk8CdXnfUUZ/n2P
         A+5FSVZvONokGelbxOsGOldvAIe3G2lbg2RV71m81lvmxkt/0eOruY//ORrXygA2XfxO
         rLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnUEIHCtBOmaLGv7Y8eVE6jS7QQFnfCdFbU3lvaUzyo/9yFXuZqxUtkzB2H2P1TO/GIfZKH85dERXu5gbuMH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3m8rhIOp5ljVIDtMagT18s0dRDtJ0B0OFjml4I9LCmAgh+k5
	zlQRe92XRtwXj4UlDx1lPhQIQtPWKnPzLWntf028Xv0kQ8ysMbDq4i/q
X-Gm-Gg: ASbGncuCRKy9HCY0ZhPGPpgRCNNeMlkgmOA/XjqOEBiA0rE0g69no80KkrGcxdkJLS/
	9KpLxA9aIyKhHBZBE0u+krk6clO1Pb4lEAHPz+1bxiTlDcxBTBnXsVyoxFPxsvApKhYPjlEDnh0
	cD5NBVWTu2jeuej5htv8tEI5gZK504f4T1KO0s+/seI9GEDlYl57oCLgqT/snKZvP52/vI60sVO
	aP76/cHgVutUF5P/cMZKjA7nf/uGOJeH4VhMXbiEQgk21s9B/k/TfD9zySgXxqS+w5gUyqa/B0R
	ts2sILP25YerNijfzPVqgr1/1GWVSH77DASqc1w62IoN9OWZ8Pmavh2YVcwMpEWA1XDJtc0lydU
	fpALXTwWUBQMOC0iPZlrxc1xEy9UAS9s04QQH0Ljvbr48gK0AhR5qaNxFyc1Gv7Uc70yspuBwHD
	rUHQwon5gTO3tCYkju3Cpl4Vzg9E4diZ9aMcZk
X-Google-Smtp-Source: AGHT+IGY7m5xCBIjhFzMJJMeIr2LMm+2g2vwUGpyuiJ3FoHQ+eVB5BYIwqC2NkP1JlPdGSmbLHfPDg==
X-Received: by 2002:a05:690c:ec9:b0:785:bfd8:c4c0 with SMTP id 00721157ae682-78617e03ba5mr7395497b3.4.1761588098317;
        Mon, 27 Oct 2025 11:01:38 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1c875bsm20767397b3.46.2025.10.27.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:37 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:36 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-kmqhvo4AFv1qm@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > the vsock_test binary. This encapsulates several items of repeat logic,
> > such as waiting for the server to reach listening state and
> > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > from hiding failures.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> shellcheck has some (new) things to say about this patch too.
> Could you take a look over them?
> 
> ...

No problem, will do.

Thanks for the reviews!

Best,
Bobby

