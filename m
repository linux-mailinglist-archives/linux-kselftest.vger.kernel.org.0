Return-Path: <linux-kselftest+bounces-23663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037589F9575
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD66188ABA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939C218E9B;
	Fri, 20 Dec 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OV8SS8xc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3211BDAA0
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708591; cv=none; b=dhXJGIroRJhGWjAsE9sozZJv6GDb+QKKi4C928ZD3fIZncZmQ9nTJdNndJhtvNxocIRt4IM5YSqeD6WdkxgLBWh26IHLbQWNEjXsx3DL3fHmOPn3ohbLmYEu50jgK4Hh2J8WB6KaDsUkl9t0gfVgEyS1t6ME+iDrVuXx1aun1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708591; c=relaxed/simple;
	bh=s8eCH8kuxQWRQxDJCILHPIJzUCXDSK4i8VYPs+tqL/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzBv+LB1oEneAqzdVnhWANAUr3y4sVrcVBnWLWJ4C+l9ZnSCixf72MYKt2AwA5pR15wKfe5uR0m35m2XyHOwaJIJTy3GGo+FQl9EIYzeWoElQYe7l+nK9KRgB0VQDRUVGAdtI579rfuWJQEmwn3SUjjuEQbl80B9AjeRQh6DEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OV8SS8xc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so2756831a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734708587; x=1735313387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=05YAc0164tw9JVplzvpWjTBOHLBHQDYsgb3ajbpcIzA=;
        b=OV8SS8xceeZOQ4Vc4W2/+rC3MhQX5TwH4sIlfMiSVx7O3yDOE+G3VkI5r0cT7qRsjJ
         3pVYEep+wcgWdqAkxD9nYGc0K3ZElt3f70sIRHWXBOhSW0HvHtGsZAfiRwdSv6vhl1K3
         /HxgVIodoYRmmvEr5b+GbUgZuSXY7b9EpsvUXaz2AuCTC+NjY8WFoT8O11f1ZyvU66Nn
         N8zUGJqZFdmCc0D+iwc+y1X/agXr53SokyoPBy7Aifj2vpNBewzfo6wDOw5GdOzsAsHe
         SKoNPOQc1VlVk8EaBnfelWCvGC5usKKMzE3qmI2bBW4mmj5ImhPUPh9fpL3kDgAxuT7W
         DwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708587; x=1735313387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05YAc0164tw9JVplzvpWjTBOHLBHQDYsgb3ajbpcIzA=;
        b=s0Wlf0t7XrIQfI/pArzJqFrpPK7KPJ05Zz6JeBtfbQtFbzITZjog09gFEhpstHzVhR
         /mXDhnBdF8sIMu6UnIHmu5fL359+zLbmbEHtWa9Vucgkb7WDv5oTdw+KwvUsnJ4uSVuS
         phfD5RI/KVJGp1G5tQCBAQHQq64GAyDy92A44ku7QpJkMl3DCPkwlnUZPyKErYceBL6Z
         Qmyks6Xm5UrOVHpIRsoU0uJgwkUe8BkLaIqoNv2jsrmV9l/xZmyRqb8hgjPkFxjtmA7a
         BDzJmSF6R2Kkj7Cj1BZ9xMSY8Ml1R+KhdLvE2q6S1p84TJwiSFGANdqMUPLfKt5/xvkI
         QPtg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSFWM7scoEoPR8gstWTGoYZI2pFLQI8yiv9g03nJDGA2VqkNZK6ULlLyT4KaGCKE41+spEuEm/0CLNSOHYcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tV6Kb85HTaDRIcsDspjhIiw31kd/begOQSH4LRNz0CgU+VUl
	4vYusBSx6xSdcSEVeLabBwLv77evxdHESxnn1CFG7NzcjpD8XC0YA+G+sIb9cHU=
X-Gm-Gg: ASbGnctkYbkqGMemupML+aVfFmdfYP7imj1b44fYIk4xd1Lu5AGS9cqzPIUe7mnMNJY
	pr6UhJ9keiL3Xv+UMEpk5luSOnCG0fxCFW3bqxyHaYY3OwbYn2F8x6dOcT1OWQwCtfOFgnIU2dA
	gC/Or/MGqOzI0xpFJ79EK0irbuzSuxYl9Mx10Li1T7hVt4MnEWzHIzrqgzrjMlpF8M520bdlexp
	RI7Y/HZ4SPZLA9w3jHcy1udMgwqO0wC59jmSDhAGIyB5nq3EeVBII1gqk/I1iHaLdZKMvIYfdWA
	Pgq1z8VF3sRMhkL9MiSFpCN0kb4rF2DGRuq0E7ox1A==
X-Google-Smtp-Source: AGHT+IEZMoavpWXkCDitRk4/ItU/bKhH5jQ7fnch6DumD+R+te4XLnU5UkkcQtK0y5cwevkmXN8Sww==
X-Received: by 2002:a17:907:94c9:b0:aa5:225f:47d9 with SMTP id a640c23a62f3a-aac2d0479dcmr344199266b.29.1734708586955;
        Fri, 20 Dec 2024 07:29:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae71desm185507366b.89.2024.12.20.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:29:46 -0800 (PST)
Date: Fri, 20 Dec 2024 16:29:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	andybnac@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 0/2] selftest: fix riscv/vector tests
Message-ID: <20241220-c289fbb5af69417dcc623bf2@orel>
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>

On Fri, Dec 20, 2024 at 05:17:25PM +0800, Yong-Xuan Wang wrote:
> Add test counts and pass message to remove warning of riscv/vector tests.
> 
> Yong-Xuan Wang (2):
>   tools: selftests: riscv: Add pass message for v_initval_nolibc
>   tools: selftests: riscv: Add test count for vstate_prctl
> 
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
>  tools/testing/selftests/riscv/vector/vstate_prctl.c     | 2 ++
>  2 files changed, 6 insertions(+)
> 
> -- 
> 2.17.1
>

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

