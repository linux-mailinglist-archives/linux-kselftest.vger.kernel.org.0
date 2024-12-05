Return-Path: <linux-kselftest+bounces-22867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30E9E555A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 13:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD971883B2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252521859F;
	Thu,  5 Dec 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ovzJOKz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA85217F41
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401559; cv=none; b=blGSZNxHqE6Fj2TsEcXQllAuQkBFg6EOeie4beBlX3oN1wWKZno249OoiKwa0fX0vyMZWSZEfPvnQQn5V1W7Awb+sTT3PkhXQgaTyFBDSXzKEWJF+cjVD7nZyD+upC4r2leZ5DepYJV8Pb7leUJJ2+3JtcryMb67Fqgqc7EYcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401559; c=relaxed/simple;
	bh=mQZqp4IFUTYgczPMKBs3aU2VcYTyt6nLnQ+NhQNlXVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjrmYXqHVwEyVMtUfifsLPSslNQbA6b4CixQAQDgXhwqGvsPz1guoAnafPhuuV6AzNwShSGhTllX1I2vO19gezpAHkCLDepNYCzmhW7nCIRf3bhb5LCHyqfhbl3PCdxWoCGJe0UTpy75x0t7oSDcVMj6+ylfgBHDtOoa15yJMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ovzJOKz9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385eed29d17so741066f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733401556; x=1734006356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQZqp4IFUTYgczPMKBs3aU2VcYTyt6nLnQ+NhQNlXVo=;
        b=ovzJOKz9bxxAmoeOWwuCj7BsR6xS0rrTsKg6fQ5hYt/Q1Kn8hxEVg8xVW6i9bxKlWZ
         qsUsIpSIBeAGVjBOnGNN0lWyW5JchqDWbPu+HggtGY0eAlxNMj3JU+Y8v/kUJwO3e948
         B/onjjvFNL14bDQrySlhRigZn2nyfVYkwVmVSCHWoCtxEyAS/jj9GrkX23/kWW42dFUb
         8Qv57FEBHVaecs6kFzvAKyPWRvhm+8AC45tE45jymMMyT9mwqJTkLovFpubruAhNPLc3
         /PsIsoVvUD+6/ff+HsaKSQDmZnDHZ1uPJ/C7oDUWOxOLP5DspjcqQCs0w+4hTVTNO7gl
         ccuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401556; x=1734006356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQZqp4IFUTYgczPMKBs3aU2VcYTyt6nLnQ+NhQNlXVo=;
        b=DnK2hZukxJVZ77dA8RLZi/I75GFmZHL+etIycb221X00gxiYDBe1AKCrpfLS5GgO24
         O5En1VY4h7gbj7f3P2t2q4gGY15VjqtL+QAzd21pPxR1Ob9foFypB0vFgX621/QZPxYX
         aCkZYIlzs4JsxoniCNWTeQSUgdyEjNVQNt5Kfs0O7HUWwNIeFarUWIV13gIXpHPQDfIb
         NpY1YbtBIslOxoMymQKcX6BCvt4o23zJx5RXsgqoa3d2DxZRgVW97a896jpK4GSIiIXH
         YovRv1HE0A3g5xZTlkPMNV8U4bV+zN0IHY4lbhbhQ6hkG+aMxIWRi0rZbcQNJ1UhBSN+
         925A==
X-Forwarded-Encrypted: i=1; AJvYcCVNx1wQA/EKX50yQZpSVcfMfED11Ux9d6O7JJYv03DKUvO9qsBzr5yiX7miXdIe+xKYPpVw2lfwiLAqqvtHXRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPtJoaViMkJNFFnLdQHLwCT/mvYef/PydpsvJ6yTaA6jBdPIZ+
	j94SfC40nEEi5V2nDdR744KilnR3nrO8K6H3Vc1SXUFYuy7d5YbWTl8zsmQuoic=
X-Gm-Gg: ASbGnctMiaoeAPgkM2wcDq0TZaueaVvBOVY9DqxnxMr3X8Yy4cbhmGnILY8JpxWioA8
	Js3pBmcqecwtIbssM/aX3HBqQmj2cgVaeSFHaJgtVzAptvBPF+KzMkFwr3F8TxgicB0uylVEKnM
	OCjeCu1cxeySdWbaxRa8Z75QWe/vEVeQbscFdQSsnw/lYutcNtts+ts6QU4RHbtrEazjHRf5ZgC
	1c8Zc5QbpCC3v7dDUvOwuunOYjKlSk9OwjTX8K1fG9nJPN3o9qNH2RUg65xBeHWzahSAkdvq4rL
	nkI/4DUPc0i4sPC9Dq7CfokU+p/K5CC3AXw=
X-Google-Smtp-Source: AGHT+IFgQ9iwN0Qu0vgSQZlMRT0k8B5zzY1On7I2CUzL6GWVsYOhBeCvU1TBPvS2cUARk11eBLePLQ==
X-Received: by 2002:a05:6000:2805:b0:382:5aae:87ac with SMTP id ffacd0b85a97d-385fd421c84mr5534768f8f.32.1733401556000;
        Thu, 05 Dec 2024 04:25:56 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf403asm1883695f8f.1.2024.12.05.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:25:55 -0800 (PST)
Date: Thu, 5 Dec 2024 13:25:54 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <20241205-09606b57e757527a56425fa7@orel>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <20241205-45c00adab2636bf26ce05f70@orel>
 <14125726-bb00-4de4-87f6-6655b0ffae58@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14125726-bb00-4de4-87f6-6655b0ffae58@ghiti.fr>

On Thu, Dec 05, 2024 at 12:15:16PM +0100, Alexandre Ghiti wrote:
...
> Your mails often end up in my junk folder, am I the only one? Any idea what
> could be wrong?
>

I'm constantly pulling legitimate mails out of Spam, usually ones from
@google.com, which I heard was because spam filters, including gmail's
spam filters, assume those are made up addresses... Frequently I pull out
Samuel's messages, at least when he posts to the opensbi list. Ventana
uses gmail, so I've tried adding anybody who goes to spam, and shouldn't,
to my gmail contacts, but that doesn't help...

Anyway, I don't know why my messages go to your Spam folder either. Do
you see anything weird in their formatting or headers? Maybe try adding
me to some contact list which your spam filters hopefully use when
deciding what's spam.

Thanks,
drew

