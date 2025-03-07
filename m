Return-Path: <linux-kselftest+bounces-28495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF766A56D8C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CA91899747
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090F23BD12;
	Fri,  7 Mar 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3h62ObV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79623BCF0
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364643; cv=none; b=cx6ldui5JxENu4zFhoC73z+GxRiuRxP4hngnMRXkF0DXapbakYwM21lRdb7Mx2ZeZQd2v679ZyyXo9yLX9IssA6mTDRa7uZ6g6pcgNh+7vRWvrLgGMHhdKr+2Z7egVSJiKSUJKV8YRxAGYxPT6TiXH91GVqfctEbIIEctdC5zlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364643; c=relaxed/simple;
	bh=mXtKy6AqPJTsyZQnFb8LDOzMrVCF8Jxpd5iGHDtoCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkfNAho4bxYS1hC6wXOd+xKbEyKulARANPaxhOKROu5RHH0PASyurkYOtuyLurl2egfJJ5HzUF7GtDjOd4sfPrrK2o118MX5pDMYXR2ztKk5tQo5g2kOne+7XS9sZOOFBHiCjc+HAQaQwETGIFgTYVQLtJn778B2eInSc6uoiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3h62ObV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39130ee05b0so1056929f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741364638; x=1741969438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFC22TuZGe+bG1f5l5pg/Qemq+Rum0/SnOpCdO9V/4E=;
        b=Z3h62ObVMeGJPieKQt3rx0AECyQt8nD55EakDE6+10CK8l/oDR6j8n17mRlyav5VaK
         +J5PZcp1zeIuKoJi/IF0pcT6axroQOsFpJu3B6XlNAbTbZ44VL2UPmiGXI4atPvMUPvw
         k7W39V/KdvELNNYVOnwBIAVHaeL0k+w48aPMkpYJq1q9bPMc24PISlA3jE/JUN3izZNJ
         g4tarfag2/SWykLqOeCt/qhJ4AoA5qGz0FmMexxqszHLiaqxEZ/SqFA46AtnRRorecmV
         dGgc7stlZ4eSivUucXSGKHRoXwLWB3ruT/HrZld3uOGjySHpHx2k36IqToUcdZW4SXFw
         qinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364638; x=1741969438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFC22TuZGe+bG1f5l5pg/Qemq+Rum0/SnOpCdO9V/4E=;
        b=DkMh9m/dU6pWrRQ9R7sqZb2YygfO6KQCsquRcEWPjr22IOLHABfvrffspIDDasE0JO
         tU8Mw3EM+S5K5M8Udq0eYE1fZBu+ohO0fgS5qMOFys7w69E4yPmKmKbmRx7bPxntXKsp
         Laxp00lZlN/hypQFW5L/tupL5WkoRxS3tEYkUjl4M8y2AoPW0+H194RvX39JMOQl5hcW
         0vTA58qTm58UMifQv/C4N/zgCwvbgLNPhRrs47grAvuTZQKpM4adcZ9KeC8Hi4w8loQ1
         6pyriX6U58HqjAgP1jgZ2ix8fs2EjI1MoS8YDd+Zkg3X/9j2cSH+1DHZSJKtYpaihmFD
         9muw==
X-Forwarded-Encrypted: i=1; AJvYcCWXT+zF1zu+zXubWH294K5zOxJB07o3Zmmw06de+lhvo0lMtDAjTHEmS/YqNgiWexNCmkO3Q5+spBterTpoMZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvhPzFFc6/GcfawJbwCo326T2urvB2NsBVh207Bh+OASpMXRyh
	z2qiK7ZGlEXu/r3TYZRyc7pgB45Dlp5DyiN9+EsqFdlImzeK789mz+2XQtkAUII=
X-Gm-Gg: ASbGncsU7C2k5vLyreYiK5ZK/h+cyWCm8KEAirGVZO1lUTvGE0CyjKmfc2vxVN3ue+b
	wCAPAb4jwXeZrmd4kCg5M14KsQ826CFDc2nzMy+A5imfg3urnc3Lw2nYRck6FNMNipuW2rtrs1X
	c6SL9bYijJ00fwzoraNVlqfbj9cg8S9u7wW0yBP5P8YA4AvmRIeI20AfMngfDUYXUHfqGzXtHX7
	gG9+Z97PejeafygDX3yuCiRrptK0KtWbbdF5I92xe6CCz/LleVtRox3P/LFDrMr/IQhhXHTkbD/
	8Q7f+ArrKXbbaxcisx2DGuAm1l+hJBpARkBzMGAcRNsI9xU=
X-Google-Smtp-Source: AGHT+IHn0r2Cn/E3lALMkI80pL0QtaTbm6Rd+OGBd1NolTMQ0z7qv14g2CG0Lk8XXwV55vp2Eib2dA==
X-Received: by 2002:a5d:64ed:0:b0:390:f55b:ba91 with SMTP id ffacd0b85a97d-39132d4e369mr2759140f8f.14.1741364638354;
        Fri, 07 Mar 2025 08:23:58 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm5731100f8f.88.2025.03.07.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:23:57 -0800 (PST)
Date: Fri, 7 Mar 2025 17:23:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] printf: implicate test line in failure messages
Message-ID: <Z8sdm7Nhk4h3hoUq@pathway.suse.cz>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com>

On Fri 2025-02-21 15:34:32, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test, e.g.:
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
>   lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1234abcd  ', expected '0x1234abce  '
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
>   lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x1234abcd  ', expected '0x1234abce  '
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Just for record. I like this improvement. But  I am going to wait for the
next version of the patchset which is going to add back the trailing '\n'.

Best Regards,
Petr

