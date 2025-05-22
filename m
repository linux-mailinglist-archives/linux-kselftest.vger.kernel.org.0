Return-Path: <linux-kselftest+bounces-33501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1629AC08EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429F41BA4B51
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799A284691;
	Thu, 22 May 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDdrXqbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1A1F1511
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907125; cv=none; b=U6We0yA8PjeINCdX9a/ZiRLrkVD0cXMXs83UodPfSoE9zfF4LxnS6EF+fSgGGbR5Z1Yw4Y4v/S90zu67OEuPKUgId1MvFN7QSf2h1Rv9LQL5nvd8uNiWUjdYq1mNqOdKXwz5IaHTVKeflMk74idd58plQDEKdhwhMWC3jRJRjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907125; c=relaxed/simple;
	bh=lUW88JlK7BVXXMOmbI0/ku/1QkPm4H4Jjhu0abvy1yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufs6UJAuSANtzgWMUmckiUkob6y7JizKacZTovTFhmVtsaiWVoMyowE70UxvgiC2JImNwf72qW5nCdRepKoasQJbyau2ajvCUzmomKpXpl2lFj7YpvwCXraxaQ3GiiZAM048GO8eawTLsz9TxJDWgnql+MsM6Kge2qaOv8olxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDdrXqbt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e57a37294so7369044a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747907123; x=1748511923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCeSJpIOFS0exbK/YOA4ghvpJUKGQ608Mgiqg3CcUrw=;
        b=bDdrXqbtUtljd7QhdbP+nySI75EgWkm2QMy7DDspJHCUJI0WWdk86bCyw7QBj07bYc
         Jykh5Lgp0Fo3yVnHif5BEUc9xpTHbQVb4ybBegIKtZTCdLLqTmhWk6/1qkOo3ceWdxlW
         TMVUPg58b98ewNjo6w+dyqWzq9id4lAZaXFxJ6Vx5m8lV1okziSV4bVc3fmWZ49vTiIE
         eGaE0fWnS40ArCCeoCGREIgAeo6nuRnQw7dqf4QJgnMOczWKdv6TmieLXCHDdvW+3AM7
         369j7G9u+tAYbzyW86kfQNtIZJ9bmqv/NBcu/IkWwYTkAjlpYSA48HKsCadsus/rJPsF
         Cm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747907123; x=1748511923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCeSJpIOFS0exbK/YOA4ghvpJUKGQ608Mgiqg3CcUrw=;
        b=gXOa88HXBZrMhs1cufJwL+ijUytOAabYeb0TkyxcrCwxDS4QL81UsML+os5FzKLcLH
         d7sBm4ek85VlOnmCEE3Hmb3oAn4r7YswGOa97L3LqJ/assHNX/HBGHWVGssh7zhgOmYL
         nAtNGzoXf9ZqBevG2vNwTT3lbqUMT2mmwqD2WRPdkM0ou2rJVj6kIGLK/Uy2+g4WYOB5
         ZQTk0fEaK68TjONWeky26660NTKXwu8iuItk0XzENeEiHCw5H7I+MkFTB+v4BfsEt1K6
         dnHaBwHL3XSRIMLERFdFHqRfRYmxu29Gzkdj7j961go44Jx/usjdFP73ZZSnCzFC9oVT
         ek2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHhTkU68g9S+dyGCJAqSZ1Tvn6urTcjtza7klmLFvobXdVriCxyfssfCj5VDJVN7tVC9S+IFJg/xC+M2qJkmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkK9v4mjrmJvhW2A3O9jye+tivZ8B/kzpzec7pSbtKS5X7GAbE
	mhVEfAgBiQXbjiNj7hAZ538K3rS8EdR+2+MGGDl6QEIW9HKsYoixI+392gue5yAVbtU=
X-Gm-Gg: ASbGnctRUC96+6Jg/B6nGc532wx/8z0im5PeW8O3/GA0k/Jc4Teh1ptQpe5Q3onKf5Z
	BQ5gpaaGpnlpMdH5SZWkxNOwzBuUdqwxgZWutgT2n8nSSxcZtUs/qrJzb9daZlV4RcH9ak3Fori
	9cBCv0lZ0me48zRIqMFpZf+XcJCa/iMnb3ZNu17U3H4yX7kRHzjRBmVYLJmgRlqWW6T0lQFr0xx
	BUq0eRbXVvn/I/GrxtulWiJqkBPWfJ/4vyOkUTRhg8/Ujai95ET8Q0Mol0iJwecdtxtbwcbmMRN
	T1gF/g9VbNIc1lu/0vWW/MqibCgtCX6VglnwtiEc2h7rVCXTvGND
X-Google-Smtp-Source: AGHT+IGlWnWcKpf5U7vBQYK7+MoavUPpMAOQY1NhDDr46MQ50TxSToGTpsPqf+nd9cPRi8+h1wIeWg==
X-Received: by 2002:a17:90a:dfc7:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-30e830c6247mr32532488a91.3.1747907122844;
        Thu, 22 May 2025 02:45:22 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2720b62e06sm4500463a12.31.2025.05.22.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 02:45:22 -0700 (PDT)
Date: Thu, 22 May 2025 15:15:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
	narasimhan.v@amd.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
Message-ID: <20250522094520.22zwevl6vgrjf3aw@vireshk-i7>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
 <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>

On 22-05-25, 14:07, Sapkal, Swapnil wrote:
> Initially I tried the same, but it does not work properly with the root user.

Hmm,

Tried chatgpt now and it says this should work:

if ! cat "$1/$file" 2>/dev/null; then
    printf "$file is not readable\n"
fi

- This attempts to read the file.
- If it fails, the cat command returns non-zero, and you print a message.
- 2>/dev/null suppresses error messages (Permission denied, etc.)
- This works reliably for both root and non-root users, because it actually tests the read action, not just permission bits.

-- 
viresh

