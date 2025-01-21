Return-Path: <linux-kselftest+bounces-24889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C2A1811F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 16:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466533AB164
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC51F470A;
	Tue, 21 Jan 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OdwapAez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2811F37D9
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473374; cv=none; b=bvJ0pKd2RhIRfFzHy7asFoObmfcwyGod+jap5mKTOHRY5YxulXwkU6TrdlHhMBoOW0rgYUaiOczY1HweJbbppQlfr5Oj84M4zoxqiP1tQFONjoO/3SkeCQEfbWKOmZk8sfLu3kpztxlIQYk7hiL2glipkEPolwtMEyX1cGK+QCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473374; c=relaxed/simple;
	bh=0tvcxw/M0+bumfP5SQ8bUYR24B3JRc1s/ClOo9jLdZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9xGjWOn/TEIIBD3L4wkZyDU+8qxiRH2RF0PEWbfCajM/KhfuZzotQiPWYNKxk6slk4WDX4f0EL55N18dv6QI7VLXBtJfNPKD1o8N96Shkvzl0rTJRByLenKNNuB5270jPyO23aanTlCQu3aRqaCsiwdnIU0fdpfRX1Q9sAwR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OdwapAez; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438a39e659cso21025465e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1737473371; x=1738078171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+SyMEFDuiz5jdFoFAlcZaoDQi4XryVJWeWGSbZvojI=;
        b=OdwapAezYSEYlIyhGpAygosVU00OR+3P3F1srEREqb/EsDYdku835UJEmsFEtH/cHp
         jertvLA57xEUyZjbOeefC7cm4rNC2oTnp55TtjG22FzE5DabXSUiIIffHudOe1fiG7Y4
         rZibiKxTxmx55GlY2dCX/de9vLcfnAGA3ck9w92qKz4sDyrKSA2HYFF0xHpoY22U/l/4
         7cy7LNq0RpWRlnRsdj9bDY9m3wNwetkVIyRJ+4t7jADGoJaenpiLHlyJzEk+FBm8gf8V
         TGqM/Crm/vNTdLbm7b4gx/awYOZh92TYaTQq/heLy+O9bxwxyC3OTONcfXBvhVefnvAn
         MkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473371; x=1738078171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+SyMEFDuiz5jdFoFAlcZaoDQi4XryVJWeWGSbZvojI=;
        b=k6mf2SAkGK3rntbeh0wOnzfc6V4fpNMwvkvx3YbmYuzrbW3k74DQR04gjdKrYxEnZO
         wPif1P/MDOOYFvA6S9IKQGjwr6na9/6pY65bN/n51K4aaOj4Nqj2tMBcIMzch2fKdUhl
         pVMbKBa2KD8UKJM7qiFVg8O2BetCnl/O74/64UexZPuCx5Q2W4OtTmwiwpVEH77JRiN8
         HxmOBfBwzLWfRoy2BxMq+peX8VdhY0qdzlq4PraV1vzQS8709G/sK8mdFVHTrPoiX7xk
         MNvQE9ixBLDSu5amHK4dmZnL5ovMM9EhEZaMvRTKNz9oLoEWKaGahC3mYsCMrxiUbQ4Q
         pf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXvdGn2fWrNuTjZ5COmO4yrvjFMN6VaBUYFVoAA6zDnELGFcif8CPWnD/JJr2cqVCYKQpa/wyEgibxIEki0fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyyfPSsmlLo/D4VHgMkoZzKrGVKxGdgAtnXFXGTYfgKwgMtZG
	3sXaO8QhkRWLGv5g76+s6mgJrY6+CEFujqRttjYMtAMP/+1JxXY9PHy67974nEI=
X-Gm-Gg: ASbGncuoxR85A4jmQT9m8y7MQmPbOdY43tDse+N0zM+ofeXgjEQSaBv9qoRwKUPuA5b
	gVxOItpEF9LMgDZKzlksvXZEbcKwvxLOvCHZsruj4Qi0ayrNvmtV5epHz0vh8yBsGtMWniN3ITz
	aSBcR33BSQ7ztQpR/5i8MD5a+iwHr6n39mfS8KSUerkQklmM6u0dtvAe+SJPE2uRSchgz8+1rz5
	QKVmsSAXtuJvsl4iyxJrjnRtZf39j7Ton9RgG0ko7bbs5JMC4wpymSDoSxfeHEaf8lzGB5Xe631
	y9IdVa7kvZLihhqZ1/nvmMnP2/CD6fpA21MBwhTvoA124HKugSFJz+g=
X-Google-Smtp-Source: AGHT+IGl2rjI0Z/X1fO7b4lQu7Bz/+RhZRQdSmN7QWCPax7hXw3N4uwdbUK9AcP8ky1wqh1l9HCJJA==
X-Received: by 2002:a05:600c:4e08:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-438912d4a3bmr183994855e9.0.1737473371456;
        Tue, 21 Jan 2025 07:29:31 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm242856925e9.2.2025.01.21.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:29:31 -0800 (PST)
Date: Tue, 21 Jan 2025 16:29:30 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom extension and its
 block size
Message-ID: <20250121-4990d96a861a4ddd304abc33@orel>
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <20250115024024.84365-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115024024.84365-3-cuiyunhui@bytedance.com>

On Wed, Jan 15, 2025 at 10:40:23AM +0800, Yunhui Cui wrote:
> Expose Zicbom through hwprobe and also provide a key to extract its
> respective block size.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
>

As the bot points out, we need to add the following to this patch.

Thanks,
drew

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cb93adfffc48..6b5b24b399c3 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -160,7 +160,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
        pair->value &= ~missing;
 }

-static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
+static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 {
        struct riscv_hwprobe pair;


