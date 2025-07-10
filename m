Return-Path: <linux-kselftest+bounces-36975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086DBB004DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF14C16D4D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0527056B;
	Thu, 10 Jul 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1ddgn8lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16FA26B2A9
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156616; cv=none; b=UqoxRYbsegor+dNJ3bVZa0BZbvNuT/3xv8FWK4jFgcT9J/e9goAPw8oQsZAKRPdrYQnT5yNKtzGLTZTVlLE+tqvVEz4WqNXYGDXPVS9zdJhqivy2knVaf1xteT2WXn+ubId0LKyJO526GKeHW18s8ABhB7yw3syRq+bn8TLAblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156616; c=relaxed/simple;
	bh=juAkrnXSzoy+efW/p26vYeCuBN4Z/qAUA6KBfvyQ8yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3hULuAjPr2z2mTT8KbA1XhAHFsm9HkLX2DS5YabheAFOycXLB9A8f/QdTEjeDwc9/O+egNdYPZU5O5I+QtfwhmaplawHWqT7WuxRp7JB1dQK2bpbwAe1laEMsJ1REzPKB9xuUyLJ8ORe3Hg+z5+kXRdpId3OVhXZgSwwswVAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1ddgn8lu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1343377a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752156614; x=1752761414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21fWOwK2yuSSXtTJ/i70WbuqBdOJcLRjYfY+8UJRw7c=;
        b=1ddgn8lurECb+/FBfXJwrImIbyK1myGwir/ex24X/MH2IDJYS0MaVcWQfOssXMl8VZ
         pQNJW56sJSBZqsMMpiYNrr5Tem1/ABfVMfX83iu6SuTkVDb2UFAWEdzlWQzPqDsV6LRD
         gU/LDTTo715fAexygLLLLfFchrv0UYDBlzE8m5N7H1Pc8h7MzW98H8BLWqzPS2Uussv1
         Mp14N8p3w8tDx4S6sLqabP2ZKcgByQ+LUWji0EG7c9v3yEOpfzdwPDaR4hanQqDUzD6Q
         uychDbpXj1S0Efzm2injPbxDyFl3poKrk6Hu2DNVZMTOSpKrinV97AWvO8mdLzPxNQLz
         nemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156614; x=1752761414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21fWOwK2yuSSXtTJ/i70WbuqBdOJcLRjYfY+8UJRw7c=;
        b=HXqPkJf0g2xtdCdpKiFVSb4woqbn5xpnxCpKOUTmmVRvVb7rfrBs/pvpkqzqRebQi0
         lnhRgma1tkmFYK7MPRc02x7YUMbpE6l+n/bdakrOScoKI+5MqMZVxBuEWVnrCWRNS0lR
         EdkmoqwT1OUGyuwTgJAab7QAdVRfziBf5g3xEOaIlSAHtDAmO8sO9ZFZ89ToViAfzfyX
         8SKUR/lt7R0/iEHOsp5V89LldIM4S6GHuR9bPhU5vt9xzCajJoa92HDJ9CcpeNWh4gwX
         1mFUPXGQd2prt9I/sq435RumQd3KJeYwMuWLMYRlv1UG2qJtTppC/vVKgKcg7Fe+TX19
         alew==
X-Forwarded-Encrypted: i=1; AJvYcCXwSM6N8AiZuAKLhwQ4yVXSmnlFvHeU98dZ4USsNeHmQC96dd6ti2HfQp0ovQrEwfUXxAFC3sfK4YXfXxMWUKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx571HA8vW7ykQBDTQSpsqUk+d9yUseqc7qKdp++ybNQRmGeO8J
	keFHYf4jVgugwwnywEJx8BpGHaNZgySNPkwRPBhYTrwSeTg30gdfr4jKj2uE6O+w+cE=
X-Gm-Gg: ASbGncs5b8jXijZklMyoqCWDPBILjVU6j4FADQBWq7O0gQgJhsKZtjIeZyHMkmA4RTO
	fhOsSFDo5wYx5TfRNCUytuotlP+Z2LstuH4Hu5KZ2B5bDlj8kWhEz9Bm5/bf6elNy8q8Ux2O6HW
	Oa/SfQ85VfPHNdi529O25q1vxh8WTer53Bbn9DZ1PtgY4Sy3LewUnIuJrlmOJqKmBGmb16EFbO/
	O3Mh6lIwJltJ4iI20AgaMCPiesa/WNRrNCR2cFqEpiGaZ7znBhHUmniTI60p7gb6QOjkBLZPr/T
	HA2BKaz3QfrzP9RSVqYkclHd3sDSN8x/XvfsMsheLykYz9Qn6BIDyYAYrsG7eqOHR6WVYXzy/wq
	Hj0ugLk4AObEw16YRnzvajCW+ghougDI=
X-Google-Smtp-Source: AGHT+IEMWPpfmJ6IKhaXf/A35j7A+4FLkS38lFffV7k0+kEpETGtEytg1GAw3/ZI2K24PUzBRx4VBA==
X-Received: by 2002:a17:90b:2808:b0:312:959:dc3c with SMTP id 98e67ed59e1d1-31c2fce136cmr9449563a91.10.1752156613976;
        Thu, 10 Jul 2025 07:10:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e958166sm2318999a91.5.2025.07.10.07.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:10:13 -0700 (PDT)
Message-ID: <5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
Date: Thu, 10 Jul 2025 16:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250710133506.994476-1-cleger@rivosinc.com>
 <mvmecuognj7.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mvmecuognj7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/07/2025 15:53, Andreas Schwab wrote:
> On Jul 10 2025, Clément Léger wrote:
> 
>> This selftest tests all the currently emulated instructions (except for
>> the RV32 compressed ones which are left as a future exercise for a RV32
>> user). For the FPU instructions, all the FPU registers are tested.
> 
> If that didn't catch the missing sign extension that I just fixed in
> <https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
> should consider extending the tests.
> 

Hi Andreas, you link doesn't work and I didn't find anything about sign
extension except a patch you wrote for arch_cmpxg().

Thanks,

Clément


