Return-Path: <linux-kselftest+bounces-36153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560CAEF19D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E53A4905
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479AD1E7C12;
	Tue,  1 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fB7IZGpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8C15CD74
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359531; cv=none; b=mq1OQgDXl1cKzCS8rMlR5b7UISSj8DVLySNgG73MNIFqmDv2oGGGwbjUF+SvcdpvDfARY7J9e/Z3W+SHlpEdWjwLQwGzMFLln5dnFHhKLpWQQVVKZAzOaTZs3T7z6x0nHEqCDfqtUtMK1QR6Bh0u5n17pfdHnA7RrjJnfX0rQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359531; c=relaxed/simple;
	bh=cSXDRJLgBwVPWyJ4COYRZ6ZnwJofpOg3fpGm3dk9b4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvIIbnlefLkpYoIgbIlFXQIjcJL+sm34uT1j2MdhjhvHYXT+OwkYc4RyvZiDoKM5U7gbPobeAAY5N3obFihdAGFtE8Uj6nx5YzMYkf2oewCql4S4s0KYc9a9gqD7cR0g+gIw0ucZ6D83YmsRqyQPrbwbXgEss+J4D0EIr8lke/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fB7IZGpB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Jul 2025 10:45:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751359526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqjZl7gOuECoDPRPbAcfIhLHBzetX6fo+UmdquAXnu8=;
	b=fB7IZGpBJowF1Eov/iy5XNSSFnVMyEMXIRtkEr2FyURw0GqzPknRl/z89pzAjL9cwY10fb
	H0e2c4Up5P8Q8zkmylO5vBBDZ9VWvnQMH1LWffWEGVgHohf8agPJIKG7d4bc2mvuuqoYpx
	szltdqXoGW4m9ei9JoW0SNM/X6xgelM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH v7] riscv: sbi: Add SBI Debug Triggers
 Extension tests
Message-ID: <20250701-f714a38e3d17247534378927@orel>
References: <20250630223224.1235132-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630223224.1235132-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 30, 2025 at 03:32:23PM -0700, Jesse Taube wrote:
...
> +static unsigned long gen_tdata1(enum McontrolType type, enum Tdata1Value value, enum Tdata1Mode mode)
> +{
> +	switch (type) {
> +	case SBI_DBTR_TDATA1_TYPE_MCONTROL:
> +		return gen_tdata1_mcontrol(mode, value);
> +	case SBI_DBTR_TDATA1_TYPE_MCONTROL6:
> +		return gen_tdata1_mcontrol6(mode, value);
> +	default:
> +		assert_msg(false, "Invalid mcontrol type: %lu", type);
> +	}
> +}

Please don't forget to also test with rv32. Enums have ambiguous sizes. It
appears rv64 uses a long and rv32 uses an int so this assert doesn't
compile on rv32 due to the use of the %lu format. There's not much we can
do here other than specify the enum type with the

'enum <name> : <type> {...}'

syntax, but that's a C23 feature, so I think it's better to just cast.
I've done

  assert_msg(false, "Invalid mcontrol type: %u", (int)type);

to resolve that.

But, the tests also hang when running with rv32. I haven't tried to debug
yet.

Thanks,
drew

