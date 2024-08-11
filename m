Return-Path: <linux-kselftest+bounces-15131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C786A94E3DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 01:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063141C20962
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417415C129;
	Sun, 11 Aug 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Me3s1RBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F3D393
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419416; cv=none; b=qyL/RYfcY3Mx7roV3fPYUPjoIhhGQ0Ap9sikGXTs1oRgw000x7zz3kIdfiSY7sGFCukm7UhQ0kqVZxZskwwL64aHafQDhPf3IR6WW7AhsEQt2w7/BmabDgp1EkuF2O8T1p0P5nGe4WJpB/Ca0brvuYZjdVyEkxJTdewuyoeqXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419416; c=relaxed/simple;
	bh=jJik5mBjweL3zeBsn9GrnT0qvWZxBXOstNtni+DjEVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWaV0kzWbawVC8wh2bac7dkQZM5zk4LW89YOWNgC911E4BxxcxcEUKguXhcjzwpcUPlKInnuu66QxBVJeYgNFoiU8QX9YlRDGzjrRdLIwn+MFZfaDn2T6cs5oU3CiU50uPDZRQUnuGE4hBdmGTTVLQGiOeRD+dv6Rl0hX9tPrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Me3s1RBb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc53f91ed3so2096145ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723419414; x=1724024214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/o6QQklAMDDZPvFb9yHs8DL9r8gNwt2hVWkEfNGtW8M=;
        b=Me3s1RBbq/W3b+mT8KMprLwXlFHJjfAhTwyWmw6LGfz0Nb6upydLrSaQqz4dgxcjiX
         dxr8b7aAS48nB6dQbrxCjQ7N6H5GT+9FobvEdh/0hMLilPXmOCoA7i2deuEn0j4NRNoK
         90QFT52veFvtG9H2awhoflwNjF34gURaz65+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723419414; x=1724024214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/o6QQklAMDDZPvFb9yHs8DL9r8gNwt2hVWkEfNGtW8M=;
        b=Y99VqM3kyCz4uy2QG9eEcnyYHYMnVd/N21G/aAmSTZSaY8HtjQ7pGBN11UYSDDj24x
         g4+L3AhKOtRN0gw8C4BwzQ8AdOrs1F4HX13DFnpnr7zW3qSXHe6HUcu4Z0A4YkuccleI
         33g+GjiKF+M0t1SrJEYLkm6KxGhr06wBjWhveFFMxGKbOmu7ttqTszlClskrh/FCZAN7
         pcuX+ZCSQS5HAY6+n7iW249OMFwkvzKE/VYNa5EL/LyZZNwByqr3tKZQ3LgO9wn8PoUf
         5leWOTKdGUfq+1JUSLZq2Ig7D2q522Csj8EfzWzv4cj1FN/dePS73KWt7gPHKhDaUuPx
         k4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU1VR56fEgImqsYYu0MbEFtCqgpyV8JPUsIgEp9qC7pBVjOFwVL8VtCqM7mFshNp6XCI00612JU9lXQP4/0euur4yzlkMzHLG4pbqsOGOic
X-Gm-Message-State: AOJu0YyO/qeGM6ZNhp12EgxoAyZEBVZGmQKxB1+DSG10i/HszbZBlr1A
	bPet5ZDsijCThBZDiroeJiFU5t6eidVayFhr6Da/ce3y5Qb9XjBrMAoitAjh5no=
X-Google-Smtp-Source: AGHT+IE8vpXF6yYoRRIs3j0MzPmM2wt2DL1913U6epAdVdcSZnLFNeXmzAhsKHWMRz/AyXkdKABfpA==
X-Received: by 2002:a17:903:2445:b0:1fc:52f4:9486 with SMTP id d9443c01a7336-200ae5daa64mr60718415ad.10.1723419413833;
        Sun, 11 Aug 2024 16:36:53 -0700 (PDT)
Received: from [172.31.140.29] (softbank126051159161.bbtec.net. [126.51.159.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb903b09sm26740135ad.95.2024.08.11.16.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 16:36:53 -0700 (PDT)
Message-ID: <4542b8cb-414c-49e3-8509-6975976ce3a6@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:36:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: rust: config: add trailing newline
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 shuah@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
 <CANiq72kM1RsZCrK-3gFZufgeZQRvOBAbO=DwRHpukX5W=T=UAg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72kM1RsZCrK-3gFZufgeZQRvOBAbO=DwRHpukX5W=T=UAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 04:33, Miguel Ojeda wrote:
> On Fri, Aug 2, 2024 at 2:45 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> If adding multiple config files to the merge_config.sh script and
>> rust/config is the fist one, then the last config fragment in this file
>> and the first config fragment in the second file wont be set, since
>> there isn't a newline in this file, so those two fragements end up at
>> the same row like:
>> CONFIG_SAMPLE_RUST_PRINT=mCONFIG_FRAGMENT=y
>>
>> And non of those will be enabled when running 'olddefconfig' after.
>>
>> Fixing the issue by adding a newline to the file.
> 
> Could `merge_config.sh` be improved too?
> 
> Shuah, if you plan to pick this:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Thanks!
> 
> Cheers,
> Miguel

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

