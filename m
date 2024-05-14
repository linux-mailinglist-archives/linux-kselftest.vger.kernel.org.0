Return-Path: <linux-kselftest+bounces-10195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCC8C5C04
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BA91F238DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5B181B83;
	Tue, 14 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIji9zEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9C18131F;
	Tue, 14 May 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716834; cv=none; b=AXEIfPbh/2rpVw4MJMFKLVRs1mXAyJjkZtU3omkcIgxV2rRBNRnsFqDAoq1JoxTmlUuR7dMW2ES6RX0h3IP4VL0135TGQ2a2OM9Pmk489DdjP90qnuo38ngrfFkphKvvejuZS8/96bFwfL8bOJvb6zZD1ff6BkXl6BQ3J0uBmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716834; c=relaxed/simple;
	bh=Uns3l4vcEBP4ql19jJuv5+6cGbzp2148+pjW3Nuewzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQshIEVRHlAgJX4Q0Qye8AkAezneupO+T70AkKs5nyA4mvpYNm/K1MSiqZeFqBS6WcFZVdOKL5bnKz0+3gnHfnbFQ0wRmb+xNIdqY4XVlP6VbaTvG8IoRc7I3X6mNpPBUPLaRSsXyuqsNkZz2+bIPHpUFqPL1onNG3O1vK0CAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIji9zEw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351cb099fd7so143693f8f.0;
        Tue, 14 May 2024 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715716831; x=1716321631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dp5f50u5OZO/IIkoPCOjftXQZtJVWZku7j3Ppopcads=;
        b=CIji9zEw3uRNgJSWFBY0TOP2BTmjSHgRwgFdIz1OFBUzpgUbmHoHc/fsdiygKimETi
         TXBspH7tLD0BLw1ll0CgZVvFIN7fATKJWeYoS+XYj9h76psj2J0OXwFvl8xs0r0dnCMR
         0CekCsye680OwSIHS+eCeZUmFDp7mF2uZmg2kVR+VZkekQ+LEIlOsDOhhtH/i8T4+BjX
         WEiMQcWMRS2/hme6qZBeOqOtoKSEqLWgAoOvWjvpb9UR9tm7SlPXCK0QBPPVEoyzxehh
         GDsCrQ2EUfY4gI84X6ipTKAh5P2exYWVXPVLtPEHJZp3XaSn3w9ScXmrxIdK5sI5PgGv
         Zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716831; x=1716321631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp5f50u5OZO/IIkoPCOjftXQZtJVWZku7j3Ppopcads=;
        b=SW5iALYesfWq530x5hCeTDLrxCJOilBpL5iLGpbhChXF+u32FUPqz/DTYvb3+0ar1A
         EV5AoGfUIDEzDtWPqfXYH1bZzbyze5SOXQ0B4nDEipiqy85zKxGimey3ERj4HgU5BX7u
         r3VKD3PpW/UTZAByB2f6Zbo5mj6w7/9XqYQy9YEaiUK8JTJs6z/do06SIeOoj1DuLWLB
         8VYI9BdC3vrpGp3p5gCtQCe2um7XFMwEn+Op1dh2bMIgGbh5ZcANx8cfLUBqowr6aiPO
         moxSrLU47V+TpWKeilrvC+wTpQHkGZRq92Gr0V07X+MzHmdSFCjau7c+DIK7GsvcG3mH
         LHfw==
X-Forwarded-Encrypted: i=1; AJvYcCXxKfM8mnGScEm9XeQYOMZubaoBi6FGKZ3QStRWfT7wz9PRtnVlTSQ8XeBn8RD6p7+juu2dcxBTM4W49UulgbkC4FX5C3IRo1d6fh4oG+OBGrpxxzArwVZ4DIkfAV/EcEgPkMZI+pUEAcz73/AT
X-Gm-Message-State: AOJu0Yy3ggtSSjROmUNx4N8fYKSHMdNLNEZAmKnomSwPN53Rvn6EhnUS
	bm5Cp1mXQe2EyuPkyxmSMGZS5zL/E4dZBK9aCoTKyr6WnOWfo7Pe
X-Google-Smtp-Source: AGHT+IFRkXX1zEQ16ZVa9wFZ5RExqrRa9H95KNGlotYW70m3+L/dI8Sb3EhKNK/ynHyAkQs9nBzn2w==
X-Received: by 2002:adf:e602:0:b0:34d:b05b:c784 with SMTP id ffacd0b85a97d-3504aa68aafmr8480583f8f.7.1715716830662;
        Tue, 14 May 2024 13:00:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:3efb:454c:189a:7b2d? ([2a01:4b00:d20e:7300:3efb:454c:189a:7b2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a5bsm14367642f8f.36.2024.05.14.13.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:00:30 -0700 (PDT)
Message-ID: <6c7ef96b-bd29-401f-bb07-9dbeaa4348a3@gmail.com>
Date: Tue, 14 May 2024 21:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com, skhan@linuxfoundation.org
References: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
 <CA+GJov6hq0WsjqX1LrC2m7YS1nD37+zGmO+i1R1OajwYQZXY8w@mail.gmail.com>
 <44b5b31f-ac98-4c5c-8bc4-ebff9579b4d7@gmail.com>
 <CA+GJov7O9Hj1g3mMRjdnkcUCORofkxsqtn06t_JGOkNRBhfGCg@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov7O9Hj1g3mMRjdnkcUCORofkxsqtn06t_JGOkNRBhfGCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 20:55, 'Rae Moar' via KUnit Development wrote:
>> Thank you once again,
>> --
>> Kind regards,
>> Ivan Orlov
> 
> Hello!
> 
> This sounds like a great approach! Happy to review the new patch
> series when it comes in.
> 
> Thanks,
> Rae
> 


Awesome, thank you!

-- 
Kind regards,
Ivan Orlov


