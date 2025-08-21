Return-Path: <linux-kselftest+bounces-39458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97AB2EEDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479AD3BC914
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B22E62D4;
	Thu, 21 Aug 2025 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luuBcH13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963C2E62B1;
	Thu, 21 Aug 2025 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759237; cv=none; b=M2PQI43ZFKq5vDz4289zsm2R0XI4CVBB6nCYB83o5Eq3T7TdctQ4alfz04cBcm2OYY07sKPwmwjbr40OhpDF2G91LgE6ge27z2kpE69EPLZiQ13Yahc57F7e9j+y52k9G/9iuA6QuoctAmO7CuraUj+g745WD7QvzE36xdWTuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759237; c=relaxed/simple;
	bh=sRlcGgpDKLEmjxKkigQObYiNHiXIeoll0G7BsSW3vjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV0dSmVmCTcFp82pGKv61hqa3XLbcy+dhWvMtZsndHvOzErToQtUDi0TF6TDvSBr+o6luPZf8Gc22P5QX1JK4oFAkkMGp3Sz4tiPO/FIptWY/mCKBsBOqar/PNvlMELTrmB0C21OjQcx3cM8XPclB22ZZLSlDwVTs7jUW/gH720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luuBcH13; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso632274a91.0;
        Wed, 20 Aug 2025 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755759235; x=1756364035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVAowaizbwM8zC3SecUJeU/owuvTRgJIAMeNb1DRRP8=;
        b=luuBcH13BXzyugLwIjJ0MNkae9G4u8lnQ/bIsbA92P1Uu7fnKmhS+rWC3bKbl65Xf5
         S/OpdTH/3iYu5DqPIuW+az/+L6DSxZN0hL2f+2LRK/rKj/IgY8d6yeJjHBAKWjTs8xOC
         OHN5336C4xPA2knV5vBbybOidcmzLcEixh7LpPcPOv0CFL7m9w0CF8jeRgt6LDzahGXD
         nKlSBBeTLeh+WiaYMnHhZU7S7i1F9aHWfEaSzqVgKOyb3NYN5ebd7Yb+4dOPHsMCfwu4
         5heG8yAl4iDDYo1Eif+u/3VI606yemOuPf4xmizM8t+181qMni7G8Og7aun8NktU9uOO
         G0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759235; x=1756364035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVAowaizbwM8zC3SecUJeU/owuvTRgJIAMeNb1DRRP8=;
        b=Q6JjvYWbrta2YpsDZGm5zbk077Y1V6epaRzQaV7R4KF9JPSU2SPK+9lcTCfkhTrF25
         PNl6jCRCvhDbxPAgfkXKBjQWX7lNAnDuT4bmk07X4W7JVs3iTshGGSzLJdbSjcX4n6Ho
         MyuaATruuA7jF6sAmGfBB2wzL8RdtRdw/dw9qMFlmandrQ4j1INt4SWyIlbodHq8c+JT
         WG16khMoWYCIzZupYbY0w6xu/NbWCPP5Lov520Oj7uTwthrh9UadLE+a0Bfpw3nuMIGJ
         rJT+xLAQ8vbyMvpC3KI2Y9ae8xjRZYXyUASnmQgD+LX6VvLpA4PDbFM6jV/FpcbNDWsS
         Lz2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCb558ZophfuXif6lhu8TKlxEphhlrpxBjd0zW+dmyEK3vjRb6UDapbgbkiUDiAS6Q8z7jAU3Hd4JINV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJS3eCLgz4ba+eeWgXl6N6Ew+kuh5DIW1OrmZq09ykhRYmUqe
	xv80yYM+sP9mGZqWhJKe2jfZAl9wXu4k1dNrfPk49yOArPNcgMeuQSKM
X-Gm-Gg: ASbGnctaxpjbev1ANC9i+ApDXLl5jlGJSIuOPgoHrObFuTCUqbwDHrRsHrFBmCiA1Nf
	+XOuK1g4dVfcyDxvU7pC6zrP0RX08+hzFwV+KKzna96623Q/ojBbCvieH0W3XJKYTWiXlrTx3Ax
	6h2soqDbJD6/NAU8kbSrv2X1Rr3akruxUbVQ5mBqs8RsksCfpt5Oj9vWb8jmbiimcklG/4SzwMM
	GYZuT0d70FgBubZymeQIyCLk3mPIu+prWrUX6NGGfp8nzkztWEK42reUnn7MzVESvfUH6Qxy/kc
	I+3WIZRuT/1mCO6QIxlQBQbjTNZveF/U9uBp96OwzM2e7BVoI41QaCJvZIvQRjPBGS+GSitP+lx
	bG7Vi4rrcidcniBx6/FN4vzrXCsyuxlUFNlI9JYr4qsU=
X-Google-Smtp-Source: AGHT+IHR/8FmCjKLMcsBNWUUB+Tq/5DX5h4iJ+kwOP23jt/9z4Om7BAA8poEjkbqHJ7MDauW0r62Ag==
X-Received: by 2002:a17:90b:28d0:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-324ed19563fmr1749382a91.22.1755759235212;
        Wed, 20 Aug 2025 23:53:55 -0700 (PDT)
Received: from [10.25.72.178] ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c48337sm942659a91.25.2025.08.20.23.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 23:53:54 -0700 (PDT)
Message-ID: <4177b434-15fb-4ae3-8c6d-9e3a40328dbf@gmail.com>
Date: Thu, 21 Aug 2025 12:23:52 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftests:grammer correction
To: Pavan Bobba <opensource206@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250820125836.14464-1-opensource206@gmail.com>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <20250820125836.14464-1-opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/08/25 6:28 PM, Pavan Bobba wrote:
> correct a minor grammer mistake

grammer should be grammar, i think not present in spelling.txt and 
missed by checkpatch.

Also fix your subsystem prefix it should be selftests: acct:

send v3

-cvam

>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
> v1 -> v2 : changed the "corrected" word to "correct" word in message
>             description to follow the convention
>   tools/testing/selftests/acct/acct_syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index 87c044fb9293..ee2894e4f7bc 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -22,7 +22,7 @@ int main(void)
>   	ksft_print_header();
>   	ksft_set_plan(1);
>   
> -	// Check if test is run a root
> +	// Check if test is run as root
>   	if (geteuid()) {
>   		ksft_exit_skip("This test needs root to run!\n");
>   		return 1;

