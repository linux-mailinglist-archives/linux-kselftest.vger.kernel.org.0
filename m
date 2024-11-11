Return-Path: <linux-kselftest+bounces-21754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A29C3718
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 04:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2C2B20BD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F813665B;
	Mon, 11 Nov 2024 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwchesi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBB3224
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296406; cv=none; b=Z1DfbY6lR1qFsTiI/IJaIvKAewRJ0WygyAWq21peh2/PG3JlKrldoh+EGXjQP73gqNyDM7+eGuwQj7KtIDuK5s9ohJm3yW9a5NKIIgkT3777Ad4sEBe2QU4JAaHebv6q3CnKwUc73l8BoaPD19Fqp/geaI0+Y1ojLxVMS4w7uFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296406; c=relaxed/simple;
	bh=fSRFxOIHYXaSA7eOwGE5mLfQuEaze4Ccuwl/tYlUH3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9ZoMUg2e5MCYuWPeARA5xi2y+MOakdfFNfvD8ieanh7fi83FwzwhhzdzOcXPejib6lgUOkFCJpoy61Mp04j+L5mU/8c+kuxJqNKTmxBe6U/uuuVLwWqIAjT3bAV2LnasHIHfQUPqnGcoadQOfvush7YaozSnsHhXNYX8rNAko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwchesi8; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5139cd3ea31so1638079e0c.0
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Nov 2024 19:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731296403; x=1731901203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g70jWIyUug07mNUn0baReqb5XDvEch87p3FhpcHNA+U=;
        b=Bwchesi8wodNShkOCEw6203RPvGlzcPov5Giau0ZcFLN1IdqgdcrW0qS/gDCXg2Ife
         xdEOA3irZOllC4yOCnkFKdQZEn23Bs6uccOsGLAKv9LbzTh8oeRBwlyxjboaAdCVnOin
         bgL3/iwP3JA8K3NZDMMFMVqmxFF5Y5awoYwy4xptThqoFGss98U0JDhVZY9kttfartLe
         NWA2Icep4Bjs7YARrpaWjTCaNLLXkw9R2FDRULHDf6QuRpYd8Fxpp9v6pc/JsGn6SPvp
         wgCIIW6S5HBVHDT0pAFothZr2Z/4yi296yQcAqZAskDvCsEr/8/iYkxU2E/6RX1gTteL
         7Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731296403; x=1731901203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g70jWIyUug07mNUn0baReqb5XDvEch87p3FhpcHNA+U=;
        b=nXaVNCFOx63W7PQ5+z3VpvMQ92GQQ2I8bdqEpgT8Bkq/OoJ1iUGuStLVg9AYexP4jS
         uzpL2S+u+nGPokyNkzsrDWD1SWMwT3FAdPKa4xJV9y1pHUjja/z6Y4s5/y3ajM6q70Ns
         QRbd7euseaevq5vxi++KuCROhuAvk7lxyDm+9ft9UXxls5yq4wFYdcjBXydS5J0itihd
         ZjkdGGRwLIzAPaJu4LOXrQUxN4H0nWpDXKgVERyIZVQ+sPHwwumZubRuJFKWA6BksJmM
         VM/akJUYOnQHkj63PVFM7x7efyx0w4OJuBqp3l2Gok0vIvXad/SYmCgVl7mtAix2Znub
         fWqg==
X-Gm-Message-State: AOJu0YwqwkXmo8ZrBIZo+4VyQgCxZGXGeSu5vN6ZUWAmtckRIRxfAJk7
	EJvcDle0huFbDYzyONhdc+wJhDlXYN76E+pPTXKomp4c2UPGPOZI
X-Google-Smtp-Source: AGHT+IFftJfOjT0wVZJxQ21rwXIxbHKtSdb7dxj4cM+94QK1IpVGvOAf4xk7j57nsIKzXOtN8JZTzg==
X-Received: by 2002:a05:6122:168e:b0:50a:caec:70a2 with SMTP id 71dfb90a1353d-51401bc7d7cmr9989178e0c.4.1731296402828;
        Sun, 10 Nov 2024 19:40:02 -0800 (PST)
Received: from granite.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-513f3190b6fsm1601168e0c.23.2024.11.10.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 19:40:01 -0800 (PST)
Date: Sun, 10 Nov 2024 22:39:59 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: davidgow@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
Message-ID: <ZzF8j6KT87aj5G0Z@granite.localdomain>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030134355.14294-1-luis.hernandez093@gmail.com>

Hi David,

I wanted to follow up on this patch to check if any additional fixes 
are needed. Additionally, I would like to address Andy Shevchenko's
<andriy.shevchenko@linux.intel.com> feedback in v2 regarding moving the
lib/math/test/* Kunit test Kconfig entries from lib/Kconfig.debug
to lib/tests/Kconfig?

> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
>
> > > Shouldn't the thing to be in lib/tests/Kconfig?
> 
> > The Kconfig entries for lib/math are located in lib/Kconfig.debug as per
> > David Gow in https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/
>
> He put it as "Somehow confusingly, ..." meaning to me as a signal that he will
> agree with me that moving that to lib/tests/Kconfig seems like a right move.

I am happy to make this change if it would be beneficial.

Best,

Felipe

