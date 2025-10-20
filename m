Return-Path: <linux-kselftest+bounces-43620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DFBF3C05
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE52118C4531
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BCC334C00;
	Mon, 20 Oct 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdqaA1UZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEA334376
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995794; cv=none; b=tH0W3MxFr7+9JvUn+1My9dG8awL621NBNugWwaty2rLTFmcuTI44zM5jLXVD62oL8WuGPqATzYlRJzAh2/baVlq32em6YnrQ09KvqBzkTTSdTZosXOJfuzpLM64VnF72mysrjwAjJuTHq+6s2PO08uNJDFndqmCtF6b5PfcoWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995794; c=relaxed/simple;
	bh=PqlFilZVmSbZKJLHpAkGDW0igOyGGkLNA6FRjPXGD80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFTv9cw4hT3FbDgIM2rBuR7NVlUKEjf4UBJQ/G8TvoD9cciUpeeA4xJ79qdKHqnrAPnJmsfVigLSpBlCtMdC/1t4CVbnUTunIlzONQwy2hvpbOqoTGj8vBpnZnXRUV13cwIuh9Kcn2gq+smoYewepBOgLt6UMrZuSPVntItRA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdqaA1UZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2909448641eso47032755ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760995793; x=1761600593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=jdqaA1UZWsigzRkXK2O8p9ZQRSa+FDJucZvY9vIZ2BoFf1KNt3MbiDs/62NGsrCOg2
         +ji/hFkyfbsmnE0rwdNEtIylVUnKfefBtHhh/6EOYh+9tVd+THKYWhq+fI1ZEbdhro11
         vn2+42low1nO93m0mJkAor0w5myk7GaQ4IXqojE5v1HQQtdFTHB+I8m36E1XFnL4sQyx
         V7/KxdJlCH1CjhJAjvOoNcX7Znw8KNJMeP6CcSL/u8a8C02oO2QqgyH7tjwTNES8KFyU
         irFosAixaTf4Y0zIUR6td7j210oJ3OayDY4HpFL+Ov9ev7xYEHSHa9xxvnRpcw+HhVE2
         hZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995793; x=1761600593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=g+Ghk1ewIIZfKQRyh1P8Xw2d5w1o1DX9V3TdfWc/f+Xc6xcpT2V3s6hsByVnYRMU9E
         QJ5pie7ffPSQBg0y9sbneCiBwx2Ei3tsT7dBZs8gaQSNn81BfFErH7piJYgG/bAjkq2/
         p7Qk9H8HiRPkeurDPARBkXlYB4+1/yzeFUFSUURMwadgF6YcEMYQwxujVSdiMkqy4l5Z
         j/v9add1FKC/t7F9f6CAEq/20gVCxJwJq2dSbovHaMF0kUNqF/2tDbtMb+z8x2jhqGq/
         h7cA0AAWMUrQJWe90l6onWvMjMErbjWCop29PriPoPCwBWdlI3BxfbKmnFXiOrxfKAvi
         hQXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrnlGEfgEZ3ScJoIdKBG/hPMNX4aBZD7Gj55DeRxxbiUmsQ+peb6bLAmY/QaTe9Zmy2jPFBDfzFHSPuYhBMEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHjU2Lh28fY7tsMRgSvoPCAlh2Kdq/5zkjOIjBhqdFOqIfUOH
	ktH0t5ZyNTN+M+Fl5Udqydwg02ac1b5S3QtQ9ss5k0EoJtGvJYe1YXv4rnZO2ApkdQ==
X-Gm-Gg: ASbGnctYfJqbw3oiAoOPiKVSCBZZee5rqCyOqJAU8tczNVqPr77/5UVVYTbTqhzub0y
	bNbPYv9c/2gu2fwVi4yjH8JHOHghl26X1VuPssJZM+onXNcLFRVNw8lpwCWIM04lF8UMQsA+rfn
	XZnQ3Tez/QqHnURI8upzI3iXONpaZrZG0kM8W9+1iU2j4cy2EUkAazZEOg01mEoqRaGNwcgVs5w
	uzOvSNWu4vBYXeLbnl0tBO8D9LLSoKWm9uJ/xKIjrf6Kc8gYEhO6W+4K7jZWA1+th7AoRIaztAC
	zBY67uSS2qwT13G4BKlksougVsyBdmS/epJJAFZxBL6UkiEaud3LEWKQWMA+MDhojIyK/wYZ+Yy
	rNo4lT//LP7mpObjS3XYpRMfbm2hjx74DteYzvRnIQ9Fp/Q7y1scZBVrMdW2KWouR6dKVmxiVDO
	lAxoSNWCP4WaPZr65/QekkQvBTqcmRgAf6aHj8ONRkV9Y6cw==
X-Google-Smtp-Source: AGHT+IGk4YTNxvDRPlGdzR4t9GlLZJuciLlt+LaOjUUn8d6Qy58ILE26bgum5kvXRpVHjALaky9Cew==
X-Received: by 2002:a17:902:ecc6:b0:249:71f5:4e5a with SMTP id d9443c01a7336-290c76f8182mr169199055ad.26.1760995792362;
        Mon, 20 Oct 2025 14:29:52 -0700 (PDT)
Received: from google.com (96.75.168.34.bc.googleusercontent.com. [34.168.75.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193dfsm88852855ad.105.2025.10.20.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:29:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:29:47 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live
 update restored device
Message-ID: <aPapy8nuqO3EETQB@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-13-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-13-vipinsh@google.com>

On 2025-10-17 05:07 PM, Vipin Sharma wrote:

> @@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
>  	 */
>  	filep->f_mapping = device->inode->i_mapping;
>  	*file = filep;
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	guard(mutex)(&device->dev_set->lock);
> +	vdev->liveupdate_restore = ser;

FYI, this causes a build failure for me:

drivers/vfio/pci/vfio_pci_liveupdate.c:381:3: error: cannot jump from this goto statement to its label
  381 |                 goto err_get_registration;
      |                 ^
drivers/vfio/pci/vfio_pci_liveupdate.c:394:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
  394 |         guard(mutex)(&device->dev_set->lock);
      |         ^

It seems you cannot jump past a guard(). Replacing the guard with
lock/unlock fixes it, and so does putting the guard into its own inner
statement.

