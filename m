Return-Path: <linux-kselftest+bounces-38961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1FB26428
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5073B7027
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79C2EB5DA;
	Thu, 14 Aug 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1CUhn+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A22EA742;
	Thu, 14 Aug 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170650; cv=none; b=Lc6tJNFylVVnXTrGgtxvIZi00wyjRBThd9KVE3uolTXMd1YC/Y5BlbDSa55bOBIfM6tScOpqkna/R+5oceCh4baLwFZ4jvRnHx/N7kb5nEYLfxSfIHdLuT0nQmVK2i6EmU3p5NqzJvvxB+dJaWa4eEiXMAr9wcRjhMcHfcaCLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170650; c=relaxed/simple;
	bh=OSgBRSjGQ236uYu98tlTjJY4/7HYkdj4MUaECGXODz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnTfQh3ZY7+DJ6lbbzVFFuA1QUQyiVSMO07sg9cFL6EkvUw33LRbjLep1Y16DA73X0XfIew2fJWNuP36P6tyRpX1bYqfuDnHo4OcJsVhS32MZUWnlh+ul9mdKu34CzF036Ux9Mn5qDLcr//Czu0HWbYbGMR79gULtB2HY/xgwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1CUhn+Q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55ce526a25eso822256e87.3;
        Thu, 14 Aug 2025 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755170647; x=1755775447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8YVDPfS039bLvzm0DeSH6D9y/NnMaiZTYgV49JknR8=;
        b=a1CUhn+Q7NabHSxfxeZVc/XcpFK5sQ1oUo/3AAEXkY/cy3TlswOiaemDkccvDvBqRu
         1VyvKIPowM/e1Wf51kJmx81QRTWi7TzdstqbOSoh7sRZaI041S4ArkBSZlgAjuQQ/LhF
         bJFhItY5fTDD6oHV962RATkywg7cwrzdXxUR1+oE726EkyXubcyTx+JJrgMzP1+IpvkG
         xinJN+me0iRNsSA2W5RZMFeo3H155FVMnVgXT7hMNT2A5ryIrryMhK0lGTleVCB1PTG8
         y+OGi6IVoUguNqBBgZpKnxQu5QDEj5JWs6WLAbDJARZs2O+Ja5klxilCUQpEpIQGL2wM
         bPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170647; x=1755775447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8YVDPfS039bLvzm0DeSH6D9y/NnMaiZTYgV49JknR8=;
        b=fRUFGjG3dWhvhbNLXZsfz5PevRtCvpM3hhwI/OlicxBN2hydBAYJKdGpnsmS/Q14vy
         y/GAHG+CsHsB7nHnCEp5O87QASC18QdKKuvlI/ifMb4n6N8IUA8sBZ3OrgbkuSwMVnfP
         vqNyWakoI8jsGOklSIw4K2kXkHX2lO764LIdyl/I4tIoD02OgLJAMYdry7uEPne5xWDV
         GjqsgJXlzCeHFAIxHc7dENRmalzPzs1lR7+5aa/VIFXouOzpAc0ZTM1G9JFL4C5tyIXv
         B/c2Kt01s4Y5C//eyqXNtY+Qysj6S/vBMMF658d54JOZD3Xe7gZUiSoNbDFBA1Hs6Ru6
         qDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQf5xW5kZWYcxgDDGoaWhY5G8vdjtikz7XfwBqESjRH0rX2R8E1NkG3G8g/HB246KJKqpPoQ55Yn+kDeH3@vger.kernel.org, AJvYcCWBcuPZ62eyHlowN6FmQ5Of4/Y+134svGw3y/Urjes6oVBsjEVYyGPx6UP6lyJYZ85twVk=@vger.kernel.org, AJvYcCWGUUABjtJ4K818qVHvbM/IeRmfofx0qiZSDzAVJvSexcnaoHReTBi7fxci6ZfHvWWesnNgalTLTiN9bG2HTKH/@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSI2958dWmmo2bnecJWr8kvrzoPAAMHxW4VLqHWlOGzbjYj3b
	+eoNSgybQknslYjIVWklP+4y7PW5HGjHPLvyrwUcTQi1bXvv0zh7TiBAW2kI8o23o5WSBmEUq4C
	8XZ6Nyr0p+9Dhx0CAhMqaNGuVgZkckHU=
X-Gm-Gg: ASbGncuq0i20N4FXBOhEismlebcxc8VlCvNxN4eyjqDmVRDg/ggzvr9nUAtj5Qzeyrz
	65B5cpQ2onZryipzqc0Bk8so9x9DTZeor2Erate5qU21ouDpZSnba8lkDu4mymf/w9VvncKZFPy
	ajUTr7K7oJZS2adS486j9Qk9DHsbS+ypC6k7+gulFWK9jrYzaZKFmAZsw0XmtoFp0JttHSf1hhV
	d25XOxW4pVL9G5o24dmmkk7DkL+raCIBCguWZ4=
X-Google-Smtp-Source: AGHT+IFI2kqWLzZtRfGxmJTfQ6cNWdna9hNxp19wpWoh6Z4+RelmSZ3rW47xzxqumwdgnMr18PDAqSFpOeMQnYta35M=
X-Received: by 2002:a05:6512:1109:b0:55b:5863:6297 with SMTP id
 2adb3069b0e04-55ce5029ca4mr858873e87.28.1755170646693; Thu, 14 Aug 2025
 04:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152958.3107403-1-kafai.wan@linux.dev> <20250813152958.3107403-3-kafai.wan@linux.dev>
 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
In-Reply-To: <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 14 Aug 2025 13:23:55 +0200
X-Gm-Features: Ac12FXyFNjFhK511o2F4JY2E85oYqMlyMJBpIFl9oCy6TDbcAhF5fcRJbIbWwQY
Message-ID: <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, puranjay@kernel.org, xukuohai@huaweicloud.com, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	mrpre@163.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:35=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-08-13 at 23:29 +0800, KaFai Wan wrote:
> > This test verifies socket filter attachment functionality on architectu=
res
> > supporting either BPF JIT compilation or the interpreter.
> >
> > It specifically validates the fallback to interpreter behavior when JIT=
 fails,
> > particularly targeting ARMv6 devices with the following configuration:
> >   # CONFIG_BPF_JIT_ALWAYS_ON is not set
> >   CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> >
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
>
> This test should not be landed as-is, first let's do an analysis for
> why the program fails to jit compile on arm.
>
> I modified kernel to dump BPF program before jit attempt, but don't
> see anything obviously wrong with it.  The patch to get disassembly
> and disassembly itself with resolved kallsyms are attached.
>
> Can someone with access to ARM vm/machine take a looks at this?
> Puranjay, Xu, would you have some time?

Hi Eduard,
Thanks for the email, I will look into it.

Let me try to boot a kernel on ARMv6 qemu and reproduce this.

Thanks,
Puranjay

