Return-Path: <linux-kselftest+bounces-43989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5EC06FED
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCCD7544F53
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1A32A3C2;
	Fri, 24 Oct 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CcCitAe7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD5324B0F
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320049; cv=none; b=DXg2UUzHWC377beR/nNSmWlEDEj0RFL0qI4RZXxmw59g8NoXcqeSROL74UYVQgWDaxlkIXm5RRz5MwvMOPqwgt+3Hy4yvFiHiY+l5+lFQYX41I+wg4zGzxPD5FxaFRnGL6wh5babqpUNn8Vuqrv55P0f0vOIQ3f7+8YZdixPfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320049; c=relaxed/simple;
	bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opsKN4Rk9cjOWmuqM0ENm5qm3bwcC1D/f7qhOZ3bckNOwxbjy9ecAVI+QZIxfTAbkHdndYOgEt/a/qxxcM6zBSiBfN1katYrFOY+tLVmXJrXgmaVvaaL9bZmLIXnZiE3FEdFVY4WCrjbpKyJgeVTYp4IR87KWVlmamRcyIXyxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CcCitAe7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so3578149a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761320043; x=1761924843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
        b=CcCitAe7h2YJ6QBV/Cay2BUOhxWYlSZRo9mEq4Zy5ZUSpbiiophcZUOiaPtMsYCUfP
         Mht5GOxKq+FZhG/vnmH33NgDSKVM7YZa+rjMhmZfbUGU2OX8HFHJ/MgnLdrn1Qk3zbnd
         ae+oVwsivjOJiIkjMh7/olmsnkkIioG2IHwfEgDfbAh09ygNWHv4rHjD2xyj38jUH1gX
         o7QBbYoGbOQEj66AuiFj4q31edE9fTwQHT3BSK4A/LwhCN9OX1RENjb/BYOPe/YtKU9t
         0OrAKtzD7EyXisFJr91ksDs3drdGdGAoxqnOR5Uvw+Py3U9Ity/c3Xur299S5WdTmSGw
         0yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320043; x=1761924843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
        b=Mor6U3EL3yInXsS4saPnEfnfZ6cx6ezQWnjusEQ2813f9iYM6c1NldM/v/Ib1tcd4j
         zNXBljLhJIqA3kTvi/xElg75tHNdHtFs4+rRpEUpiP/x6tGsDqpIbLrkt1q27UM4AV7p
         FpvK2bZrCjy32YAEEyMewdhNiM1N7OuNb8pEgqrXz79zipcNb9D92o6l6UTcFqmONgzt
         3FfA+JTBRu7KDLyDOHX+p48l28W3a38+wj7kiGfc+aYKMmCHUo2vXBuo3nUrN+up+Ncp
         i+sUvEPvPUEo+ygOqjm+c32O2tXwaeDYqIAVZdLlgAmdmHnB2PjAZFqLxhApGvXdsEXb
         rgEA==
X-Forwarded-Encrypted: i=1; AJvYcCV4vtNYv4ftI9hxw8EYnT18LhYeypg3fIZfJWk8R6c7T1tpxMKP2WjGyb2B32JvriGK1NVQmXnvwfMCafVJTZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzurXy0C0NPBdNMldMhF9jZglcvy62fFN7IAn3T8N30/OE8TbeX
	eDuxXEz0hrX5/8gHwB9oIoRq+s1cJrr5Gp9tnbcfKHIaLcOaFLor7LwptmKzcgw0boLEZgKDT+S
	8YkKcstxDHgDmMUQPMlyhHcOADQN02CWAJ304VSaCLw==
X-Gm-Gg: ASbGncvHbuV1a25vchsWQOt9AOckzabDrHIjb8CDUameoO0WYvTOEgwgG7nn0oYkDbZ
	GhNzykO2/3MXIElPWzjV4E6ospADVd6v4cS1n6/SRtoc96Fzad99J4oHD19vjhFy/FLpGUVxtJ2
	+MJpdrpcjLrlnSIMHTtlnUx2OB7fCz0hDPFbNnahNaI5AslxU9xBi6oMNFcVFQaczx+6ezYas6L
	tMRLqmOyX1SECXqhajLJeo78c/u9lWAD1+97Vej4LIMeFar34dx4/iB+KsAedHh5hXu
X-Google-Smtp-Source: AGHT+IFfTkje+cUGlXkTFymJUSte5krNn/bEG5EhN31gNJr/7cVMgJy9Ry/5kSN5HjqZ3SuvQkYNIfXAVoLsVbdbd8M=
X-Received: by 2002:a05:6402:40c5:b0:637:e4d1:af00 with SMTP id
 4fb4d7f45d1cf-63c1f677665mr27513307a12.10.1761320043188; Fri, 24 Oct 2025
 08:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-6-pasha.tatashin@soleen.com> <mafs0a51jfar1.fsf@kernel.org>
 <aPnXVmD3cNmYNRF_@kernel.org> <CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
 <mafs0wm4ke2wq.fsf@kernel.org>
In-Reply-To: <mafs0wm4ke2wq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 11:33:26 -0400
X-Gm-Features: AWmQ_bnJ5szaFV-enEeq3wfvmO3Zq6ympB-Z6lOOZF2BoJ-F4vXI0M6cDC_xrXY
Message-ID: <CA+CK2bARUpZaymPTusZWM-kzXcUp_d1UK9nUudu3tHitpeAH5Q@mail.gmail.com>
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

> If any of the kho_preserve_pages() fails, the notifier block will fail,
> cause an abort, and eventually all memory will be unpreserved.

This is a wrong behavior. Why should the memory that I preserved be
unpreserved if there is finailziation failure or abort? reserve_mem
should still keep memory as preserved in case KHO later will be
finalized right? I have tested that this patch works with kho
self-test: preserve, finalize, abort, finalize again, and the pages
are properly preserved.

KHO Test and memblock do not need to ever unpreserve pages, as they
preserve them once during boot.

> Now that there is no notifier, and thus no abort, the pages must be
> unpreserved explicitly before returning.
>
> Similarly, for test_kho, kho_test_notifier() calls kho_preserve_folio()
> and expects the abort to clean things up.
>
> Side note: test_kho also preserves folios from kho_test_save_data() and
> doesn't clean them up on error, but that is a separate problem that this
> series doesn't have to solve.
>
> I think patch 3/7 is the one that actually causes this problem since it

I updated that patch with your suggested fix.

Pasha

