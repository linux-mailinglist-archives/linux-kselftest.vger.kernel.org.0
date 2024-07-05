Return-Path: <linux-kselftest+bounces-13244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A2928C85
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 18:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFD6B25E8E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C216D9DA;
	Fri,  5 Jul 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QmbBcDhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06116CD00
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198393; cv=none; b=kinH/ZIVD+Hj+5CiUOPolVyFjNYli34Xvq4xQYXYaSt0k4YhlDFimVUO2j0L09Qs5aHiQg7BLMS94op89PiNV9hUCzgVn9zO3vG0ZNebvUQkgghL8x6iAWxci+Z7PN1i6x+Doj5fAoKwkQihLSYk0sjw+AvSlzqMoWsjIaLGuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198393; c=relaxed/simple;
	bh=RncQKJYbfy5H0b3XrKMgUXVHO/dixUXWg65oa+C6FdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blZziBEpxOWFdG34J7cG+1FzvT+601FpGyFUVW6bZI1pvigSArQzJu+wlqr+aJvm9weVDEaCJetCgKGlOwW8HpR0GXqn2qqYcqalGc3DXVLghjRMWN61RDvvw3/81Q07/Nramca/i1l1ncOzasreRCqia05DSzD88Y/R4ajgcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QmbBcDhK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-380cdc44559so971755ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720198391; x=1720803191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLrD/RGWBG3HDOWPiY9D8ry94UHKUAljIHl+MpL5ZcQ=;
        b=QmbBcDhKkK8AltFpBseMvUMyqT2le+vYC98EHNWS9rv6RXbVgILHHR8RYwnAhnjPJv
         vmpe1YRREbMgISedCeSfFhNAWvCQx2sQiEKv7ICu9vWZfsJQBDZVYN27KtLY5rP6NOkl
         X2rFmt3leO/XFstN8TP4/c6v3QM3xLfGXvtyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198391; x=1720803191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLrD/RGWBG3HDOWPiY9D8ry94UHKUAljIHl+MpL5ZcQ=;
        b=MansOY0qw1VCYvuID+QtisRvW6tmlxQAjS9YsQ4neCySHYuicyIn/TJQflWyFtmBzm
         JNoCtzoU0JpPM+WE1Q4LXk7gToD7qvPuEbmZ8iSP/WgVzRwjJuR+Iz4YQgLAXyAfYuwD
         VdhwFW93Nr7N3JFBQwhT5ASnuCxMlHpbSxpl0zc2x1a0SUDCTnQfQ/jET03elQ3gXwfV
         OLQUKYHbwUUD3qfOmSZVK8hNN3Kgx4j2shft0XTCfwJUln1bUWys0UoptOxGvCgl9EWa
         D49A4CHMhCYzCQJobkR+iI9P/VuwQuzzxJEipI8euXDoHABmxJt8EjBvm9Wt2z421IZF
         YUMw==
X-Forwarded-Encrypted: i=1; AJvYcCWjovwmOsEab12TxqZhgjbwpqMCYhcEjeUglL4TQ7eR750XSTwwoOPXiRx5RYjxLEixnRQRtng8n5ycWzBjRnUbwe5QVTDKUzqwWsAbTNe5
X-Gm-Message-State: AOJu0Yywkj3CGunJN+tqqj1EfgywQnXXZMw9ilPxrb6q+hjJmcfQyFq/
	85KyyaBC4D13c/VPcKIxEUmPU5lko/jrVkp4EIkrTbepQ4SnoCD+dLkaDWg3+1M=
X-Google-Smtp-Source: AGHT+IFnMHVSBiih/3sZgpAFXUvJl8b4JDQIC1sGK7IOw0ZIUebUnheLQu/ZKBtQd2s/VP+yFXOJbA==
X-Received: by 2002:a05:6602:6398:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7f66db3caeemr477668639f.0.1720198391430;
        Fri, 05 Jul 2024 09:53:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73fa17cdsm4449380173.119.2024.07.05.09.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 09:53:11 -0700 (PDT)
Message-ID: <5a3a3c0b-2c72-45bf-91c5-0d5808e3bd14@linuxfoundation.org>
Date: Fri, 5 Jul 2024 10:53:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/timers: remove unused irqcount variable
To: John Stultz <jstultz@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704024202.84726-1-jhubbard@nvidia.com>
 <CANDhNCpEvPL+b1mve-YJp4+yzQU-BAaAQLr1-G6Br7i83zaQaw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCpEvPL+b1mve-YJp4+yzQU-BAaAQLr1-G6Br7i83zaQaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 21:11, John Stultz wrote:
> On Wed, Jul 3, 2024 at 7:42 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftest
>>
>> ...clang warns about an unused irqcount variable. clang is correct: the
>> variable is incremented and then ignored.
>>
>> Fix this by deleting the irqcount variable.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you all.

Applied to linux_kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

