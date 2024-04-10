Return-Path: <linux-kselftest+bounces-7607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BEC8A02F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E50B23F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF64194C7E;
	Wed, 10 Apr 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="15EqhKpJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE86194C74
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787097; cv=none; b=tKHGve5ylnFc01lpvldV6sQp9fH1ZyW7MqSXUPJMOgjo1GCSiFkqWv5UjbVbcvUzNMlfON727ZIDEOx7WiMUws+w9SR2s8XQob7Fa+hYwDYmM3doMMF4DJTujrbqfGGIzcXxDJLDxjUX5t8Y7dmOXGhTgYyqpDnvdqaW9iT3wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787097; c=relaxed/simple;
	bh=/QiNgJqGWJlDyyUI6HRBW5pQDmQPsVVStIMWqIN9niY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y715NkZPOp9lS/Zzcy/+cNP5a+VUvlX/bvQo5pYDzKFaGuh58ijvpR8Jn63PSouTfFO+X7qlYOf0Df6N2YHDM3NUKc6GuUMBdn1XhsKGGBs+Lp4cTeY7I1wtcb/fawWKh8X0Ixxb/9D5OSgxsoPHkK81r7XLB//VFwK7u5dYI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=15EqhKpJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2dbf3c92so3087571b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712787095; x=1713391895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QiNgJqGWJlDyyUI6HRBW5pQDmQPsVVStIMWqIN9niY=;
        b=15EqhKpJUs2EQqzFDolPxbPFLpOFHCw2IGHMkolxs26hAVjMwfG2yK7fPuOuIxQB7l
         KYpPhr6I2w4X30ClQYh4788bdsnjfWjCWq1poJGbvBsVIAH4vQAJZw58ve6AZ+E4FSHr
         jKQKDJjkr9x53UQHvTrFlVNDB011iqY8MUraseNwxWUtCzY1zyFxlL8zVbZ2/Sj5sjlf
         8oKZPF//xnny2agQvroFS6mPj+rNjIiJLECtB5b7Un5UjutH54vGiOLoCKWyN5AdUPtG
         DIwOSg4DssqmFylj6qKJriwFnQvuSXT2w69ZJRXRIp/nX7iSE5zj7iwi492fhWw5nWtu
         GmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787095; x=1713391895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QiNgJqGWJlDyyUI6HRBW5pQDmQPsVVStIMWqIN9niY=;
        b=JlTl5a7OeksFvXjwVuUFvNA0glXRFqx0JRGD1WZ9MRGQgiyUX0o19Wm5R45kujjdGr
         mW9PSkDTv3hY0aa0MHrkubPZreoQF9ACLLkQ7kV+VqSLvHvx+mV9/7ZYPNpEfce53Sye
         IVXKXlX6qsKyPBqR31TWiYTwwr3T8qFrULQcagDHhto79z3DDDFSd+s2hFhFwVJ6lxxU
         R1hvg/griJN5kJMN/JXNY/f7xn1ZAJHcs0PFptKz+XYB8Q52OBeMgvHTJe2Wea9wzuxy
         /oZXoEzI8HxcEAEn9pesrZv+hWIwPrCGByRUQHrIu1NzRy1uZ7yi6/fgmDdYUGak+pCy
         6tvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqSxll/36a5qQ5ex15Pfv3LzfNXq1/bVu3BLzk/+HuskhTa9ARsK5eFr6y1/+kdBmW+ICPVAYAZb712F97FG8bZ82AQRhKgYKSJc6YjzhD
X-Gm-Message-State: AOJu0YycxG8B7ynG8rrcFumorSZ+il4k8tpJIYT/+/+5+ecdLhXzK7UJ
	Zvox2FMqWDwJq0kj/V49NcQvN3t7vl5RRdFwWYbeVl8cnJYhic5eI/3emcvkxFU=
X-Google-Smtp-Source: AGHT+IG/YHAlTiVOH3S4PqA/DOFjKAze10CUA0qLcKk7UmApgTn+NVguvxWt0ZZPHSceedWB6R2kbw==
X-Received: by 2002:a05:6a21:2786:b0:1a9:7e6a:12a1 with SMTP id rn6-20020a056a21278600b001a97e6a12a1mr245273pzb.57.1712787095176;
        Wed, 10 Apr 2024 15:11:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w18-20020a639352000000b005f3c84e12c9sm35672pgm.48.2024.04.10.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:11:34 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:11:32 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Add parsing for Zimop ISA extension
Message-ID: <ZhcOlNK4u1xAjcs9@debug.ba.rivosinc.com>
References: <20240404103254.1752834-1-cleger@rivosinc.com>
 <20240405-091c6c174f023d74b434059d@orel>
 <CAKC1njQ3qQ8mTMoYkhhoGQfRSVtp2Tfd2LjDhAmut7UcW9-bGw@mail.gmail.com>
 <ddc5555a-3ae8-42e5-a08a-ca5ceaf0bf28@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc5555a-3ae8-42e5-a08a-ca5ceaf0bf28@rivosinc.com>

On Mon, Apr 08, 2024 at 10:01:12AM +0200, Clément Léger wrote:
>
>
>On 05/04/2024 19:33, Deepak Gupta wrote:
>> On Fri, Apr 5, 2024 at 8:26 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>>
>>> On Thu, Apr 04, 2024 at 12:32:46PM +0200, Clément Léger wrote:
>>>> The Zimop ISA extension was ratified recently. This series adds support
>>>> for parsing it from riscv,isa, hwprobe export and kvm support for
>>>> Guest/VM.
>>>
>>> I'm not sure we need this. Zimop by itself isn't useful, so I don't know
>>> if we need to advertise it at all. When an extension comes along that
>>> redefines some MOPs, then we'll advertise that extension, but the fact
>>> Zimop is used for that extension is really just an implementation detail.
>>
>> Only situation I see this can be useful is this:--
>>
>> An implementer, implemented Zimops in CPU solely for the purpose that they can
>> run mainline distro & packages on their hardware and don't want to leverage any
>> feature which are built on top of Zimop.
>
>Yes, the rationale was that some binaries using extensions that overload
>MOPs could still be run. With Zimop exposed, the loader could determine
>if the binary can be executed without potentially crashing. We could
>also let the program run anyway but the execution could potentially
>crash unexpectedly, which IMHO is not really good for the user
>experience nor for debugging. I already think that the segfaults which
>happens when executing binaries that need some missing extension are not
>so easy to debug, so better add more guards.
>
>>
>> As an example zicfilp and zicfiss are dependent on zimops. glibc can
>> do following
>>
>> 1) check elf header if binary was compiled with zicfiss and zicfilp,
>> if yes goto step 2, else goto step 6.
>> 2) check if zicfiss/zicfilp is available in hw via hwprobe, if yes
>> goto step 5. else goto step 3
>> 3) check if zimop is available via hwprobe, if yes goto step 6, else goto step 4
>
>I think you meant step 5 rather than step 6.

No I did mean step 6 which is let the binary run. Step 5 is "issue the prctl" to
light up the feature, this should have been reached via step 2 if feature was
available.

Going to step 6 from step 3 basically means that underlying hardware only supports
zimops and thus this binary is safe to run on this hardware. But no need to issue
any prctl to kernel to enable this feature.

>
>Clément
>
>> 4) This binary won't be able to run successfully on this platform,
>> issue exit syscall. <-- termination
>> 5) issue prctl to enable shadow stack and landing pad for current task
>> <-- enable feature
>> 6) let the binary run <-- let the binary run because no harm can be done

