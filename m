Return-Path: <linux-kselftest+bounces-23942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E092A0235C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 11:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B888418852EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EB1DA60C;
	Mon,  6 Jan 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYnNzr76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA21D619E;
	Mon,  6 Jan 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160440; cv=none; b=PZkYaF2Nvf8n6x90tvgJx0bD4cmoH/B7y7KKvV7qo0qlIjlZLSsmSIuLOJ15wYthi7V474paNSjOLdcchQLlvuT1QKlChIJdzbztp9qTdTFInmqVzML9Di/iOPhD0c0tEqdEM/AGeYG5SWK/xLgLrR0tTjKOhl1Q6uhHhRENSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160440; c=relaxed/simple;
	bh=JaFJjbaQwnzq/hVa9JgcxnIRcEwz1iAcP3V7/AU2w1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWd0BxGvUerh4xXc0poJMtRvZjh+Y4wLyw2c6e4jr7QAOT28BmRNCAFPnBCBIJoPLAhGLAwUAULNuAqZZnROi2s0Iy042FSIN+wjd5ml309bvqHOQkT6dRrQkEGpFuaXlWyDNou1Bf+YKVlCiwwvGZhIsaaSiNSIbUP1Tkk/70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYnNzr76; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so20523041a91.2;
        Mon, 06 Jan 2025 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736160436; x=1736765236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmdWuMp+W8klnnc2Fqr8EjfprgS301JhSXk2qIwpbX0=;
        b=IYnNzr76rOuCV7pLAAlj0z0xs9KsCgae/vhJYVnuKiB8FsX0co4Weakxa7eT3Sr2St
         UJw9AEXOh/P/bVP7+BG8hCV0im4OxSsO79df0bizF0yLQ3OtYsfLNsxoxZ+bWf8dYt/f
         t+ooIxm8PmvKeQs+kDRqAx5aSNS/32FsUVT4purEdx6VefJe/+SSkqBHHY0Pe7wRkEFB
         1bGVWMZRdvJBvJbUX89oYF9BIWsFwvecd0qfI2ry/LI7pRwxtCXxQ2zdxqybHDBPDgkw
         1Duu/IxQV8/9IeEzFpiSGTeJw3dp2OF2I2VkbvxT1PG8W7/ExAqIDFikLKf41wviT4f8
         CdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736160436; x=1736765236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmdWuMp+W8klnnc2Fqr8EjfprgS301JhSXk2qIwpbX0=;
        b=CSQr2hymgR9PwHx9H9+NKEPF4AUe/l+AU1Zjqqs+FHhF9NHNPr720SEOXhtJtPHwTg
         x3bnaxT9JHempv/oQzoCj39ErxvwFkwKYaLfO/QCOzKGi7NHmygeZ/r6+ul/DFC76Rh9
         p6CYRkxS/Y1ShLT1GpufoULy6eJhfVdL+aV6mYBGM21qu2QrSedI2z6ntxfgngw3YbZU
         fgGQyups/jhOuPppHwihFKeHUulkBLmznEHggVSeSaU2L76QEmXpIl17SFsONytkDIiH
         UisjxDrUINnOeY9tU6f7Zc87FLWB3oNnplz2f93+874RSjIyhbAe+7v6BAzpQhvWLQIj
         pZWg==
X-Forwarded-Encrypted: i=1; AJvYcCUOuJhKk6wuu/6+0KI5m4MjOYKiSuW3Q46yb7jzun3VuZbkL93Zviw9nFxiss23E6ks3H5aAOtx@vger.kernel.org, AJvYcCUTrB581fyMMyaG0Hjxp44mkj8rO3bzy1qs+DGRP4EFgZgEqLpv1Gc4tr31yFad+HpG6FLE5GbuI1R7hXc=@vger.kernel.org, AJvYcCXIJAU0pcYP3idQ4UfR0Duq+Rew/QshC6s8qHOUkzQOwkJUBMiShQDgWgSFH8r1cp9Hoj7In/JmIpiC7ieBWmmN@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAkUwUy7zYU6lOZAbyVp+UB92lrKJfydjR5c0GM/CedRlh2zQ
	UXcWBFgC9YAe5zwO2HElQ+5I8WzqIhLB7LXwGkRsz8+9ubm9tZyN
X-Gm-Gg: ASbGncvthYmqwjiy8u91gVRqwKjK7nzojInpD0/eaRGr2cZpz4H8D3wlrG4KzUUtr5Z
	DKpQwCfYJLFPQVQnqZTPC4h+H2pqELfAJoGxQTg/o2bY2l9RvfkO/Em00YrLuSP/ry0nOh1qaL7
	xvjFiz4YexHb9xgTh4Pe43W7+y1Wq6/MVbghEwgEAIU8elB2qqzMWQ4OGELi/04BNnd0hxAD1S7
	/Q9RyWECBHmRzj/TUo1oK/AzIxo6nE4teLHcm7Y989EbHEWP5yp89wgK52Kqg==
X-Google-Smtp-Source: AGHT+IFZyYQExz0NjdtjD9p5XPUzsyPQhWZpx15jq97xYcydba8Q19CoQ2uuYY6Bvca1WKGgxkF68g==
X-Received: by 2002:a17:90b:2cc5:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2f452e16379mr86841636a91.14.1736160435849;
        Mon, 06 Jan 2025 02:47:15 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06de88sm38972178a91.39.2025.01.06.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:47:15 -0800 (PST)
Date: Mon, 6 Jan 2025 10:47:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z3u0q5HSOshLn2V0@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>

On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
> > > Re-locking doesn't look great, glancing at the code I don't see any
> > > obvious better workarounds. Easiest fix would be to don't let the
> > > drivers sleep in the callbacks and then we can go back to a spin lock.
> > > Maybe nvidia people have better ideas, I'm not familiar with this
> > > offload.
> > 
> > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > Hi Jianbo, do you have any idea?
> > 
> 
> I think we should allow drivers to sleep in the callbacks. So, maybe it's
> better to move driver's xdo_dev_state_delete out of state's spin lock.

I just check the code, xfrm_dev_state_delete() and later
dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
checks. Can we really move it out of spin lock from xfrm_state_delete()

Thanks
Hangbin

