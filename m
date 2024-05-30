Return-Path: <linux-kselftest+bounces-10962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A58D5468
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FEB28521D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B6182D36;
	Thu, 30 May 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="TZMhwOHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24B181D19
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103594; cv=none; b=WAgpqQuB2MMHJi9vVleD7+O+Y6Cs5ByTUdqZxgn5pa5s0TtuZ3zclOATVhSma5IeE56EJJJA9K1K0h3VICFBTmGDKtL4nTsnMhdwQi8bdkUVzPTwWhXQF8pZdDMgK9Qsqp3ld4QzHPcAQvfgFaGU1B59safpyRN628L6CO+yolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103594; c=relaxed/simple;
	bh=ce8FpwxqQD62UnVP0DyeeRdfMHWhf0s5UptEAbc9/II=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=MGs1jFJQzzCvRy5x8cPm+Ppuet2x3ePrJp2UQXWLyL31m8rdNA//U/ttxaIFVm8NhngxpH2TDxhBHeAM5vjMtklgkSDWpVi2lMoqW8Q5JTd9XPTFNMuG2NfwcnZG413pkoAZB3muF0Vm48Id6mqvgkEjXAo9LwqNBHbSh3hgD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=TZMhwOHw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so975266a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1717103591; x=1717708391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUpctKvfevQrHdaGpIcM44yzfFl2nDayUUMZ29nidi4=;
        b=TZMhwOHwL9xF06fxbDZGgA/VlawJJeQ29ON4WsqrPqKbjILG+KlemVZNwLaglA4MWL
         u/f/Xj/pvrhVr2Jj9u6o+1NzRlAM1HVk7SgJhZiYkCwBi8CN3DRRKx8CvoYv/Bc2aeXf
         /DnUwhbdVQm97auyxTzMFzLo5ATLu9IPGzFEaqbWE8f6Fto72tUurZCzKmt7WOIiKH8y
         FxqiKhK7FXF2jfNFXpGT7jH4qcU1/zQLH+cET2/+6hw/R4Yg9RxlAJAmkQDFR1Qy6hkV
         wi2S2TfVtayi/LOi0uoUkz7+nD2hGF7xNVz6Oq6s7bCFncTQ0MfBJuYfkKRTrOHLlql7
         pBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103591; x=1717708391;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUpctKvfevQrHdaGpIcM44yzfFl2nDayUUMZ29nidi4=;
        b=rybgzkW7OQOEy0VCGC8hmJpzk5ntjZrej69q8giXCw9uMYkrZcrUhLkOUQ+1oSzyUM
         92CMgivrOdQGHHCGBjbcDhHnrfQ6ZCXk9yYQAD3t2odDRevli+geDPkRVd6ASeHGZkkX
         gXJF6dfN7fkRcbe/oPDJIeLe1mCKxMRBkbr3ZZAZgaRHE+lXN+yYolFCXadBYmhlSI4I
         g6muy/06flwS0HCS4eIykYPqC5q+9SmoyxVMH+m0MZJxQv5SOgrpuyGTFJjTqRnmZaB5
         wphOEML9qEnEF1vR1O7XSAnUuodXevDnxcc+wp4FKeB1pJzf1Nh8E5LJ+aErFiN8r5Gn
         wP7g==
X-Forwarded-Encrypted: i=1; AJvYcCVLdWv7yvkBG4PJL27ookkULI9xps98kLKIiwUlDlmqFP3iGTT+Cd0hfdhi+IjguG86dF/aoKYJxTXzI6dFLueVqG86krtJ1iHQ6AE71GM3
X-Gm-Message-State: AOJu0Yw4mYY8phpW1GPTg+YhSqjwFvOEofXtzgzo/ZM9wxSchANEQR+Z
	ZP4saSljr4ZimW8I/mJQM0w82kPvpkpUt13LQkGKYRCESP3rgRJWvMygl3B3nB8=
X-Google-Smtp-Source: AGHT+IG5bEF7vqEE2pvUr7TZyQpWPRiOExDqlbLZlE02H6bgGUcM0bCR65XCXs/V68DITptuE8d6Mg==
X-Received: by 2002:a17:90a:c914:b0:2c1:b66c:d414 with SMTP id 98e67ed59e1d1-2c1b66cd54dmr2280707a91.36.1717103591073;
        Thu, 30 May 2024 14:13:11 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e3a5asm210516a91.30.2024.05.30.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:13:10 -0700 (PDT)
Date: Thu, 30 May 2024 14:13:10 -0700 (PDT)
X-Google-Original-Date: Thu, 30 May 2024 14:13:08 PDT (-0700)
Subject:     Re: [PATCH v5 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
In-Reply-To: <de2c9064-bb01-42b2-9c0f-884dcabf7c40@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, corbet@lwn.net,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
  anup@brainfault.org, shuah@kernel.org, atishp@atishpatra.org, linux-doc@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org,
  kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cleger@rivosinc.com
Message-ID: <mhng-d5016935-99b6-4dc6-bbd2-ed84eb834f98@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 00:20:09 PDT (-0700), cleger@rivosinc.com wrote:
>
>
> On 21/05/2024 21:49, Conor Dooley wrote:
>> On Fri, May 17, 2024 at 04:52:48PM +0200, Clément Léger wrote:
>>
>>> +static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
>>> +				 const unsigned long *isa_bitmap)
>>> +{
>>> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) ? 0 : -EPROBE_DEFER;
>>> +}
>>> +static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
>>> +				  const unsigned long *isa_bitmap)
>>> +{
>>> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
>>> +	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d) ? 0 : -EPROBE_DEFER;
>>> +}
>>
>> Could you write the logic in these out normally please? I think they'd
>> be more understandable (particular this second one) broken down and with
>> early return.
>
> Yes sure. I'll probably make the same thing for zcf_validate as well as
> removing the #ifdef and using IS_ENABLED():
>
> static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
> 				  const unsigned long *isa_bitmap)
> {
> 	if (IS_ENABLED(CONFIG_64BIT))
> 		return -EINVAL;
>
> 	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> 	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
> 	       return 0;
>
> 	return -EPROBE_DEFER;
> }

Are you going to send a v6 (sorry if I missed it, I'm trying to untangle 
all these ISA parsing patch sets).

>
>>
>> Otherwise,
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Cheers,
>> Conor.

