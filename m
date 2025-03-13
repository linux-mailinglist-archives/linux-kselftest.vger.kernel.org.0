Return-Path: <linux-kselftest+bounces-28941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF2A5F439
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D193317076C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C79266F1D;
	Thu, 13 Mar 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EbCTWpuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A057262D16
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868688; cv=none; b=s7Cb64L87cypSoZqqOGipO+qJYWRXm38HE3Dfop/UZjXJrHbBMAC8RPTXWVgnYh78aUqW2o5MVWnIwcdRqB4UhhjW8CF0LQDnApS30eTLEQfBBEi5bMfzlJ1E9e7TwzAEjPPXZADeY6F/APzpoGCvOTQIZcHbwSxGqXJv/Iyxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868688; c=relaxed/simple;
	bh=qUINEFrGdyqtUCxJgPIIWVSKNSceW/vG2w99VTb0EFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZw0U3W2QOh3HarP3xL/bBKMYQ5DxZDoZa+zMelUe2Hgps23vGZrH2hB/6W/KzuPxbMB7zclpuCoZnlNnQg1p3u2li45o2NDIepJKrZfWH0HLMyQVE8/ZHXUkYhjYg5MMgQfYOKriD9v75wFs6+BM3FpDRO+3HbtmOKeKoVz1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EbCTWpuC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so501414f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741868684; x=1742473484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jdwK1Zh8ZZo6rwDf542VaxRAlTlQ9sZFdzOTXwzDIRU=;
        b=EbCTWpuCIEVmrusg4jm7PmZ3G9kQr3/k9FBQmvZQ8D7L9OQ+iISsTbF2CI9I7Bi7gG
         bkXR4Csa9wQus0Wn3s8RDbygCrSwQoxc0zR4YNMOspJKsGE+qogTlrrQv4/JIgdiLaQC
         srHIzpaxhUnaPIR/rbJblHFnLgfoenOWhKitdtVdX6uHq24OQ/Jk8asZPuloMdH88Gcb
         PwABAp+AOU8lCJ61EKwfQlNMR9F8nIEIwMFNi4vwTZIMkosSsHDu5x3I0O/zvJuFQpZQ
         CTaTAXGf8EJm2gSbBuYUb4oq4aKf0bSHvrfQou7r10dsjUH3wz5o/1X0jX53FbeEL0Ws
         caHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868684; x=1742473484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdwK1Zh8ZZo6rwDf542VaxRAlTlQ9sZFdzOTXwzDIRU=;
        b=NYl/HBeGEaj5PMA0mXGInspK2I24WMOpH/Gs93+3qu1G3/d5VpSAFlIgVC3Lld+356
         MxsgEyT9VnPQLANmZQIn/Kxz+mQxDSf651e2SOjhrUY0WPaMFEn7x3forSCnNsMAduc4
         qqxrO8Y1/ENr2nNt+zS6LR7pBJ2PSuy30AbmUf5yqcRuNcmaKN+d4y61ByjCrW+jgQzb
         Psi4jIIm0G3/LR1mIFV/xJzMUUfEfXPn6xLpb8kLRAFrcY0+6s69D1CB960FUL2yVimJ
         X1dQUAhJ3yj4hABSN45yFrNvX2+gUlpTTD2I+xtx94WVLWFtZoyHKy3JeSp+mCcR50lY
         mDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpvl0jescCjNPEKD67Ldb6cNPF1iPm8QLR/K7Ow2Dbo2rkpQdZDX6ZFivDM0jnbz8na1Du/YDmY1333IZ+M+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGTsZX43RfEMYXYzM3PExVLHIVxN3f2HED0YbVfOqQf3RyPeI
	2RsXfkhcouEBQ09f7zaFZG5EbRE/B6/C9dqIh3n6si0OSAxbJ/IDn17jex6AgeU=
X-Gm-Gg: ASbGncsZVn55NvRwNL/X3EEbeRoH4cvDfI+nJdbdBTk/XwK0QGv20Zh2TRwMJEdVU6F
	rSb3CAVFgvBL0rQnjlZM1sMFTlb41V1Byr+j8HD0Ey0OcM4JsWmU2wy9sL3a1aEbCmI3uStBnL/
	6lhZ4Gyz1rIcXRSS4yKT8CAZzofb3n6w7w/cqx+gJdEb3ioRP+QYqdlI4Z/P3WR0XomESXK/qaW
	a5DWgquUJ51D59QjzZN4OJhbQ84DBl4ywfLsD8uE+BkFdvkdT5PzPUbHtiujVDDdlwl9rjpWHNY
	U2ECKMMYcF4cHdx123uJQm/6Q9qwuIk0
X-Google-Smtp-Source: AGHT+IHTTFdUMyPE8J6/FJ/Tz2TmgEnvUPiqAP3Vg4LJA9U623EyzHKoPA3QMg0KCVbZ9Z4v0fkfMA==
X-Received: by 2002:a05:6000:402a:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-39132d22aa7mr18761264f8f.3.1741868684583;
        Thu, 13 Mar 2025 05:24:44 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm2006325f8f.53.2025.03.13.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:24:44 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:24:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v3 01/17] riscv: add Firmware Feature (FWFT) SBI
 extensions definitions
Message-ID: <20250313-924c6711597160f50c4cf90e@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-2-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:08PM +0100, Clément Léger wrote:
> The Firmware Features extension (FWFT) was added as part of the SBI 3.0
> specification. Add SBI definitions to use this extension.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

