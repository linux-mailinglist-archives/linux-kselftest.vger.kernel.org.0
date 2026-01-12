Return-Path: <linux-kselftest+bounces-48702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0FCD107F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29EE7302EF71
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 03:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B967306D36;
	Mon, 12 Jan 2026 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1csbDOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8B2DB7B7
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189403; cv=none; b=Lu7Qi8OHH311uu5p/G9LYiS5fz44QtNDWaS9ijiFLxs3lvKNKSKE+Q+/1RqTz6ZSj/R+p3w+Pok2lNa+A2VLE0Dv8+49cGZt84zIJUDdaw+uQ2O0Jv+UsBBlS/8MKnM+tAJxz01z4vDWOVs06yHRxbbUn8aG88gEff2eEtDAqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189403; c=relaxed/simple;
	bh=aRoenwJ0gao7dPtlCSV/80B5lUMua0AbN7AvuLnw44o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kn/9PDkmzBbbBvNECjwLhfhTx6Hn6hdHZwfF+EFdxe6tAbiwOCOk2C5RaCuUZxqKN4cf3C9zfSei5/d5h9wP0+QVGr4DUGVanQP38r0M6Tud2QaIZMZiQk8RB8PMVg7G61nMJunS4KGztMkwvCtqdmhGIyEPwGNbsI3HsXVK9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1csbDOn; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-646e2b3600fso5409107d50.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768189401; x=1768794201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekfb/wJ+g8F9vSzHIhdC36YPR9Gw9VBJHquzEP71TvY=;
        b=b1csbDOnmtaUx7nSumUH/QT6I75xTT0AaJbYTKEEVWy8trVh42JZTNK/AGSFaSA1I8
         i5hacx7f9qGBbK2BYkNjs+LyE1sCJe0/lCckYwdywSycLvreMFLTABjKwwHLl8Z3GLk5
         xiC42gs/1Z2C5A5WZzTEoDzCRgPi+qExoQeibXFtL+0lr1Q5ilS2Jqouxxmf6N12pVm5
         fvJ0JdIidlMBbCwgTtAQ0qxJnJWtMAgfPFyhebkw5Uz+ezqvq50rVulq54ys76tijpbw
         m1H6WuwISB6UkJ+yM2b/VdCfj4UZED4BGD2GUjx5sbD04T2E3yLGYxvmWV67hOYnqS2z
         n+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768189401; x=1768794201;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekfb/wJ+g8F9vSzHIhdC36YPR9Gw9VBJHquzEP71TvY=;
        b=IAdmT1SHLuIM92Jkp6xTGQBtVMVDS8KBycDmmuN/mgtWtw+aNzU4recJoUCmiRPTda
         5A/wxKzwWLc78gnZpkCK8D6cgdVU7uFM4DicB2nYZds+luBYd5KT0CIzypzuh88x/wfe
         N6sc4HLzk938onxFMpviz68xnoy4A0yrhJjppdwtnw3+5I3G1Ag9m98BKAM3cgLoZBYj
         J2rpUQi6v2IrwX5sMdocHD/nHmx2AFsZq1obpjl97xT2wqa8WKVTmwxBxXhP3jv/hOaE
         o6/tNO/fZw/ks6t28eQHjptoWQk8YxxQilPzIA8L38qUq/IDzmzBUmN+hkv8i5YXvgFY
         Ofig==
X-Forwarded-Encrypted: i=1; AJvYcCXbHXuKkfSevnMHXecsK1ErXe07ZXKU27RvCbxZ6NRrNyZ7k4pkAFK06i+aLKztMwGgm5AuhNXn7e1MDhoGgys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CeWhpmxbg4uHM3V0mth4yOmtMniIO/b623GPh+RG9Jbz6XRz
	gT7+OgTu1gq9eCpOkzADWoUGGaE3A9r8AQcngnLLuHWkXWK5oYMr1Phj
X-Gm-Gg: AY/fxX5daVdvixCGJzumvMP6fMhvD1Oc+mzvzKBYPH3LrKpTbOiTetV/LBR4Cv+IizZ
	Qc0tnNPPUD1FCLO3HxoPtNEj/aNrlz3wBkAXR3NPWMl9W2ZzGpqRuBtZtG5bblIbB7ytxVZj4dC
	4YhV5iLRiMN2n7n1ApKmyidcqtfOcJPCT98/7H9jvb5wuxaWaVnHq0B7+xFV4m1nunCbS3aq2y2
	JATGRNyXFgG4twuLm0OZ3EahxNgLkqkkGDmnVszNcHqTnGJ+N3TSIZKt6fl1xLSDeXLFw97/njA
	u1T8d1fcngvOmmYgzOHBT9RQoCCVfJhcd1mU4nCJ5R1SdDXHBIe7Vd4UPKyh93qw0pPHPGfspMo
	e7tQsVhFXQiHUJK2bWgu9IECqFyWYNja1x5BhI899u/6SdIu1JIXDcb/0+bMe12+BRG+yNxtUV4
	0pcWnmUoTXDONYjRSDP3Qdij4EbOqpreZYCeL/UAkQFDCSM6I2hWC69C+pmIs=
X-Google-Smtp-Source: AGHT+IEnEFu2j0k5cVNlPes4yIjGEiiDdRgjqnACw2xu0oJYD6eB9G55SWS+S0XVTzNsdlVDOJe2sQ==
X-Received: by 2002:a05:690e:4008:b0:63f:ad90:ad6e with SMTP id 956f58d0204a3-64716c04d5dmr13382554d50.64.1768189401054;
        Sun, 11 Jan 2026 19:43:21 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6f09besm65668507b3.56.2026.01.11.19.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:43:20 -0800 (PST)
Date: Sun, 11 Jan 2026 22:43:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.f136c851c9ee@gmail.com>
In-Reply-To: <20260111171658.179286-2-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-2-gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: fix RPS mask handling in
 toeplitz test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> The toeplitz.py test passed the hex mask without "0x" prefix (e.g.,
> "300" for CPUs 8,9). The toeplitz.c strtoul() call wrongly parsed this
> as decimal 300 (0x12c) instead of hex 0x300.
> 
> Use separate format strings for sysfs (plain hex via format()) and
> command line (prefixed hex via hex()).
> 
> Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/drivers/net/hw/toeplitz.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> index d2db5ee9e358..7a9af4af1838 100755
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> @@ -94,14 +94,17 @@ def _configure_rps(cfg, rps_cpus):
>      mask = 0
>      for cpu in rps_cpus:
>          mask |= (1 << cpu)
> -    mask = hex(mask)[2:]
> +
> +    # sysfs expect hex without '0x' prefix, toeplitz.c needs the prefix
> +    mask_sysfs = format(mask, 'x')

A particular reason not to use the existing slicing?

> +    mask_cmdline = hex(mask)
>  
>      # Set RPS bitmap for all rx queues
>      for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
>          with open(rps_file, "w", encoding="utf-8") as fp:
> -            fp.write(mask)
> +            fp.write(mask_sysfs)

Alternatively 

-    mask = hex(mask)[2:]
+    mask = hex(mask)

- fp.write(mask)
+ fp.write(mask[2:])

The comment that sysfs and toeplitz.c expect different input is
definitely helpful.

>  
> -    return mask
> +    return mask_cmdline
>  
>  
>  def _send_traffic(cfg, proto_flag, ipver, port):
> -- 
> 2.40.1
> 



