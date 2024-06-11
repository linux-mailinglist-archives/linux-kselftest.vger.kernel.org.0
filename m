Return-Path: <linux-kselftest+bounces-11697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F32E9043B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988BE1F23CA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33AD84A4D;
	Tue, 11 Jun 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkjeBnER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E3823C8
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130607; cv=none; b=V+SSQpP3Pdvh/dB2dGIM1uSlZ33nOAXpQl2eNnf5Wd99xBm9DBpzQfEf99uZcOjRnxl0WLHARCExUEJZgLAAKOFMk42DXBFq7cNZba6XIc90FpMq2huMX4IHbKG7e3erbvvuwCPS3l9nS3xovmOVJtougRbKFKgvZR8YkRHOXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130607; c=relaxed/simple;
	bh=vmJlB5Vx85oOAvr/aM38OCLvx/FPwgawAx4TV4XmcSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APMBmpuZbRYlMq8VarjtU4CglcHhncQbmkMLHhgzmJQ9XqxtQZdcg7nimsuzkBZkjefD5vc/FrO1tsFKu7hEzYemQyLLYkvmtiDo1RB8AQs0ikfI60fUcfz4wbZRc16RGYiHHE9JIoePJJDVQ4VAdZCWFGOoXl+6Y6HVS/tPXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkjeBnER; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6559668e1so10856265ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718130606; x=1718735406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE4BOZRZpuQSDr/bb7Z6GCdUYJnxu9albyuBquTmaIo=;
        b=hkjeBnERHHqamfY8VO6wgZRrPlkbNCuMfpVHGoVs2jIRDMpGPTWKwEP9fn15ViaurN
         vEE8Jx0d11lUxsmq4+HG42RX8yhrL7yAw88LwcKo3z0F3eTwC/hyHL194B8jGp69F4Do
         gwzpMcRJpbbkI0x6+o0aV6dzz71qkZvWEIy9PY3Y6IKTZnOR2rdL3ZnQDw/Qt2QS9QPy
         FaIs77vCOodeeqKPRoBq7u0iSKVxYM2kHT6+e+KDbiHYfAdVv6+L5xZQ4kvB2OdzuSP+
         aKbpGl5ulcXMQlfcDdUBrs6e6l0yu02y66nqHM/W/K6NoARta9ET4/L34Tst8rB7l3Yn
         FO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130606; x=1718735406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE4BOZRZpuQSDr/bb7Z6GCdUYJnxu9albyuBquTmaIo=;
        b=xKWhZMMtrgw1zJR6LSsGhWQo+K+voguO6HuQ+7UHSULyL4QqXLapyq2Nb2kCqoCUEd
         z85MogjDyeaQgQTT5zSWKnrxP01ClZnclLJiw9YYgV2MNkweepujKBtUom9td4sdk4VS
         yxd/W6JCcif68Q2gfy0AHizr7v/MSk+k53xQO6pcP6pzAYtrgl5bK7mf5Gwtj5uwzV83
         EC2GJhmSSPUeVR9iHNpKzugApJWaT43iuZPpac75sxaP7GekrLbtsvzsku/yg0qUNFpN
         R04KixjMY7qKn8TOMXcxi6CeuJcFAihGqJHeElrD5LndYPu2PqylYHZwO02jsnrNItlW
         5GGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrWYfp2d9MSON5wyLAR6UuZeogMP0qB36MbC+y4kfSNsKBs16pQ9IA7MKEkf20YXinjFL3qUL7DLpYXSVTn+8z7CQlDHNwVRSxg4fsfHIZ
X-Gm-Message-State: AOJu0Yyu8CCgbEjCMLjHm5SkdH3BA9TFWyctEafe4HgwianRdScG5b/n
	fE1e9pyZxIcoe6Zn5UvSYtkva6vNZCMIJDZznKZ9B3ctKZqQ6CZu0NA0ckyuw0YMfuZskZOtS94
	Snw==
X-Google-Smtp-Source: AGHT+IEUxjBQ03FSwMcOa7Q1C9oBhVDpqO23pvs6QZZKLHfe2UWqfYR6fTAzVkLY2GOOR2DFyw1XZA==
X-Received: by 2002:a17:902:f54d:b0:1f7:340e:71ac with SMTP id d9443c01a7336-1f7340e7491mr23223975ad.50.1718130604876;
        Tue, 11 Jun 2024 11:30:04 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72110e4b5sm30490685ad.125.2024.06.11.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:30:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:30:00 +0000
From: Carlos Llamas <cmllamas@google.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
Message-ID: <ZmiXqOHYaLLX557z@google.com>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527211622.290635-1-jhubbard@nvidia.com>

On Mon, May 27, 2024 at 02:16:22PM -0700, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...there are several warnings, and an error. This fixes all of those and
> allows these tests to run and pass.

It might be best to split the 4 _different_ fixes into separate patches.

> 
> 1. Fix linker error (undefined reference to memcpy) by providing a local
>    version of memcpy.
> 
> 2. clang complains about using this form:
> 
>     if (g = h & 0xf0000000)
> 
> ...so factor out the assignment into a separate step.

There has been multiple attempts to fix this. I can see these two:
https://lore.kernel.org/all/20211206102931.1433871-1-anders.roxell@linaro.org/
https://lore.kernel.org/all/20240501002150.1370861-1-edliaw@google.com/

... I guess we somehow missed those?

> 
> 3. The code is passing a signed const char* to elf_hash(), which expects
>    a const unsigned char *. There are several callers, so fix this at
>    the source by allowing the function to accept a signed argument, and
>    then converting to unsigned operations, once inside the function.
> 

There is also a v4 fix for this item that was sent out here:
https://lore.kernel.org/all/20240506181951.1804451-1-edliaw@google.com/

> 4. clang doesn't have __attribute__((externally_visible)) and generates
>    a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>    to require that attribute in order to build, run and pass tests here,
>    so remove it.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

What is this about? Left over from v1 maybe?

> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

I would prefer to pick up the fixes from folks who sent out the patches
first but I'm fine either way.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

