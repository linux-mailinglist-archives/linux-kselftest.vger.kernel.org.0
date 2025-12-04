Return-Path: <linux-kselftest+bounces-47045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E9CA4B85
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA3AA3005A7C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750482F49EB;
	Thu,  4 Dec 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiA+oq9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410282FFDE3
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868582; cv=none; b=YUlAD04LxenU9NXKlr+Dzzcc2c9UFMgYReqlXsdvfB2+M2csZxNrGEy1XFk1wwbvmwAlImZTyuBNFPERdlkJlIFM3sX4SGwY7k03vCXJmADC2cSkiKmyJmXCbrr6r6QgmF0a6ah1ffoD5sBJAUiASvVKLQxE9PVd0dRo+MI19BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868582; c=relaxed/simple;
	bh=km4Dh9hQxInKzZx/6CVtSmfiE01GeOx+hzC3RItzZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW79vruybC0rfjeVneBeUr1utDXQnsxu4ayFPPKW8LuG1knCJ5C0aG+Yd5235dNw3zAnrJjw/NQ+65YoeESLJhotNz0FQsA4pj4o60Kkpm0zI4bK1Ed/SpmxUw2wSYq6/D4kvQd8HrVCEbbmMDI/ielhsNZu2HurYRQM5yfVEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiA+oq9p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7e2762ad850so1069648b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 09:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868579; x=1765473379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=BiA+oq9pF4b6fLwzzpFCXc3BWr2q7jmMqSh7Y1G3BALUyBhaEmta8HkkX3qUHa4H9Y
         oI1s5FC66uKaW3k42HXLHdqG46JyjGZunzg2oLW/K+bPSuzy8xapjecNrnPBs36TocvU
         Dda+FuY7i5Ti6TinHUN95K2A27UkuBy6HBtwflNYQDyeAzzvh3PyqakZRmjx7jsUWKv/
         OhCy7DGnm92V1HCzfcRyas5gImTgQkXm8t1iFW4TcZTHcJLWRzwn2u+GerHMs5QaCHsW
         PNr3lCrasUwnrxNv43Fr3223E3yh55PFoxRmR+hkl/1T6QS8yMqm2ham5i+fXwetIaIy
         CUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868579; x=1765473379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=EpzPdgLoAyf4nuB9WM115+HZuJ1xuf1BuQabvmaxQBPLQaUp4xBCiaQ8YYGXBBVyQz
         pXQ+esW7SLtJACAmGC2RwRz5pd6kePR0TtkGzExBu/SpJAfn99mQ8KwWSuyNSfDGAfuk
         FeqFT0SLpH63R88p+yR4xAki0mNDuDgf/ou0IkLy9jJAuIV+mGKV2TlC80RP/TyVg/iG
         POvWQ/petx3KDw5zjUwSK4auN7gWVgi0t6qLG+3jYOWoS5uHBsPifrf7AGkFpzhCENG2
         qoxY2KvcR2C+LbXRiC4bCBYDde6vSjYAWxrv2x7yxPrJ95u/AWn8x1Sv0H9/qceKTHwu
         5gNA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJtkD0r/u61S/yVynjrgfO9UwI2Oc6mbvFLevqkVlw7cuzwf6vN+K7KDBDX/PR4c82PreBIyG6026yY4mJlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEir6HqUlK60zdJkgdaAwLEaRPdEPgBpqugrU+VcPlfbAjv04
	JcBpDNVAUqCQxMuvYnTKaOc9pjQCxGMik6AeSz4rw+DFCu9NHAtCWdfF
X-Gm-Gg: ASbGncsU0c1HZgK8PQD134tCnkf28ZNXsEMswbp6b0kgiiwRQr+7ZPZqZDF9RvEr6MQ
	tLsHe2jzQe/R72/IHZ1YjWG+DYSrMF6qIYIE5JJYWH0dbLkkV0naiyilV2uvuLkqoPPtCHHRtnV
	t48ErqxI5dI0IgtmpOwlZG1oAVTJ4dThfLCV7rw3g4j8ZF8npyKGCsXAokNp1qIuIk8wceWuLnv
	vto7cnM/0rQQ1Rg3i9H+EynZcZgdQGWUYcGpVyDOfdC2eFxJXa/Mtl/H2R5uD2r9Z7nyIf3DbFw
	nA8KzTDv3gguPPpb+kIEl3ajHOecZWDBsWXaV9QXqJSxti19I6NVOP3hm2cnFC1neJ/sF8xO1Jp
	ykaI5+0vHhMV+arUDY0+JLD14IRDGd0TvSqBV/eRVbVbiI/is5r9FKeUuarKpneE/g1Bxc0U92y
	6429bXedgZP6DIMttX2Qk93ik=
X-Google-Smtp-Source: AGHT+IHAXVYFQ4q367vSeW5sz0uxGvn2ZjIkZaA1NzUcPpPtZ5Mf5JbmRDgnfViVXo5wuRHDOwdH8g==
X-Received: by 2002:a05:6a20:958e:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-363f5ed53c9mr8451647637.60.1764868578709;
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3bad4sm2375297a12.10.2025.12.04.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:16:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204082754.66daa1c3@kernel.org>

On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > This series fixes build errors observed when trying to build selftests
> > with -Werror.
> 
> If your intention is to make -Werror the default please stop.
> Defaulting WERROR to enabled is one of the silliest things we have done
> in recent past.
> 

No, that is not the idea, and not the intention.

The Google infrastructure builds the kernel, including selftests, with
-Werror enabled. This triggers a number of build errors when trying to
build selftests with the 6.18 kernel. That means I have three options:
1) Disable -Werror in selftest builds and accept that some real problems
   will slip through. Not really a good option, and not acceptable.
2) Fix the problems in the upstream kernel and backport.
3) Fix the problems downstream only. Not really a good option but I guess
   we'll have to do it if this series (and/or follow-up patches needed to
   support glibc older than 2.36) is rejected.

We'll have to carry the patches downstream if 2) is rejected, but at
the very least I wanted to give it a try.

Guenter

