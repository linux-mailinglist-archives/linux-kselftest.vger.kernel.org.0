Return-Path: <linux-kselftest+bounces-23270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25A9EFAAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBB328C43C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7244223330;
	Thu, 12 Dec 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOuLn/Ri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FF1547F5;
	Thu, 12 Dec 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027497; cv=none; b=eFL21q5NwULMWuI/foH66Ne7ujg2KZfTc3ZCyvkcf3p+BSxxwdWnm8vw3CVEaX0Bs+4KlP2daRUY2Aye7MIcwPlp15u//stkN2Q2Dr6lZyHN06uC5h2y4h4EPigxi+9DAzESd2+z0lpEMm7S555Moo/CVM4G5SGd8xpxRM32a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027497; c=relaxed/simple;
	bh=IIpcnOmv8gXyAskv5AC++X5FTUcu1O349J09UOMhC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaE2gfi7ZxvgeoXG03FuhOopYHEaBLsA9Rmenu7VAM3UJ/fDvEDoClBnaSox+GCQKyR/rMTJaU25eNICQ2rfzzawkw0wPdQNtpl1qvTeiJOxmrjqheOuXuC0k+YWzYCB8anyeeSlZ+CBFUQJMg9HWfqhAajuFrgb7905RAsbec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOuLn/Ri; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so663848276.3;
        Thu, 12 Dec 2024 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734027495; x=1734632295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zo9PMMRdvR4TWcHlbTqdY4+03Oq9+8RRn1FRR6QdKck=;
        b=aOuLn/RimM4Q88Rx/xkA3LczOyTF62HeTrZwZU5PwX8NGsfXhF8uzeMwZ7KWr1nIDd
         dwSt3gpScukiVQUz8kgdJ7JbyNpFe8+HX7UiRm3MrELLaey1QnQJZoUs6+gS0pym3cMm
         NJuerC2045kNn+Lj+uGesoHoTN2VUMHXXE8I6hUH0Wf3VEn8C+2619bfBz3o4eQHlXCf
         8CL0SgCsdqlaXGmQTX7v6wE2wUMCxjKs8gh2+TTChzizX5/Y29f9V6ARdopK3nz+V6AZ
         HpC7nnxIak7RbYfPtkkoUzE61kOBxoDOs+2zS4lCBWLTZVAwvWZspPfWpiS92IdkmQhT
         jkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027495; x=1734632295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo9PMMRdvR4TWcHlbTqdY4+03Oq9+8RRn1FRR6QdKck=;
        b=VE8BuQd/qYDbE0todVH0HE5YfVXwY4djVKT2mQ+oJZsQbtoL/dgKLyiHiGjrjBch2W
         ae/w+z/QjyTkW1ssJd2VsdCFVYoLxtrq8J9JJymxwfOhTyV74oxx25yMCqeXzFIKNwzx
         CencU3OggYayiXYy5geggD7v5EjncDXITECWbxmmUNH7pJdU+VYokpAinu8h5pjfEM36
         uP4fWTRn5Dffqw2Flz6514zxeBSOeNIpoTO5VboESC+EJ4b7hA7hbZft1AUbfHswSruC
         OIlLiGmqlZ9Nmz8V3TC0inPAV2pX7TY2cjatNIhzmzhoGKeYkJC/A8pjXAb4dgHMpQzE
         YcnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7+yQPxNQx+w8MK/jNBNEYCrXVh91blTSbFsmLZ/81m4v0B/fopNFuxnpKS6Y+9BNQ+gj8H7wcTVbaB0=@vger.kernel.org, AJvYcCVHWXCff3PWo38qQBVBM6fQ5lv27x62FTX2BEbN5aS4N3e03Fj+xiXRPDBUIJnPQ78XHOQ0+ysHii22v7Iv06Ml@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIXHpqII7YkXu7zeEXsc7TmvuKINPgStaTKHCDxC451zJzqbE
	oISlVBB1mGcvVFvp7ocWqu0I3OLjG70xo8yHzuR5G9D8nE/WRxHN
X-Gm-Gg: ASbGncttKlUn6dZKZUx7S4AF2RcOBzS1D1j1OetXAk3PgKO65+bA5FkU3vYgh/CHJ6s
	WauMg0g+Z/841LFA/ioqiBf9ErdXM1Lvau4UJ46kO4lmLnSNln5flCNGhgATrkn2ZUwJk6Af/j5
	876M8nr/QJRQcmd3Ferz6JP6UVz8Qmfa8Jv1eZWsmW5qSFfS2c8SKsRKD8K7pfNdLTsDNeCPgEi
	RiC0wgZFUo0zdpfCXFEbCpP/3fKQQwUMo2iY8dX2/N6ZvRb6S8lJEc=
X-Google-Smtp-Source: AGHT+IF43XnGa+0BJH8Q9ln131urn1VtN6bAa4xSBCHe/VTCeJaVJATTOpDT1RGSea2nTOBEF6F7Ww==
X-Received: by 2002:a05:6902:1105:b0:e3a:47ba:84c4 with SMTP id 3f1490d57ef6-e41c1289ca8mr1546792276.4.1734027494884;
        Thu, 12 Dec 2024 10:18:14 -0800 (PST)
Received: from x13 ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3fbc7f9e1csm385702276.21.2024.12.12.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:18:14 -0800 (PST)
Date: Thu, 12 Dec 2024 13:18:12 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: davidgow@google.com, npitre@baylibre.com, stern@rowland.harvard.edu,
	u.kleine-koenig@baylibre.com, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] lib/math: Add int_sqrt test suite
Message-ID: <Z1so5J9BaXYUF2fo@x13>
References: <20241212021259.20591-1-luis.hernandez093@gmail.com>
 <20241211231816.9857d14e07251165e247eb51@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211231816.9857d14e07251165e247eb51@linux-foundation.org>

On Wed, Dec 11, 2024 at 11:18:16PM -0800, Andrew Morton wrote: 
> my x86_64 allmodconfig build says
> 
>   AR      built-in.a
>   AR      vmlinux.a
> error: the following would cause module name conflict:
>   lib/math/tests/int_pow_kunit.ko
>   lib/math/tests/int_pow_kunit.ko
> make[1]: *** [/usr/src/25/Makefile:1925: modules_check] Error 1
> 
Hi Andrew,

Thank you for your time and pointing out the issue. The duplicate entry
for int_pow_kunit in lib/math/Makefile and lib/math/tests/Makefile stems
from my attempt to align this patch with another[1] I had authored in a
series by David Gow that moves all lib/math/ KUnit tests to lib/math/tests/.

Since that series hasn’t landed yet, I’ll update this patch by reverting to the
current mainline approach, keeping the object file assignment in lib/math/Makefile.
This avoids assuming the approach in the David's patch series and prevents conflicts.
Once both patches are merged, I'll create a follow-up patch to align everything properly.

I apologize for the confusion and back-and-forth on this patch.
In reviewing your earlier feedback from v3 of this patch[2], I now realize
what you were referring to regarding the conflict. At the time, I failed to
fully understand the issue.

I appreciate your patience, and I’ll do my best to resolve this in a way that
minimizes further disruption.

[1] https://lore.kernel.org/all/20241202075545.3648096-2-davidgow@google.com/
[2] https://lore.kernel.org/all/20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org/

Best,

Felipe

