Return-Path: <linux-kselftest+bounces-35381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1DAE0BA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5A37A7E9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA5217679;
	Thu, 19 Jun 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8HtbL4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16E1A3179
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352526; cv=none; b=P6BMn31nGhl9Gzt2VW1slP8wQowTAbcLx29jQJWfcQ1H0igb5lECjEvTvRtCQYOz92l7xSw7l5jDVD27VsuZ5PRAICpf3RDMDCabbxlIDwxmc80ibbFx25BBhtpgcX7HNfIZ6w5ekmwzt1mykY8uzmhffPVw3CO/pwUc8FDUh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352526; c=relaxed/simple;
	bh=lRvnDFm5hhqbK/nTs3rCjRlhuB9VhLA+5W44GAQFf1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbFvrHSWZu73j01UI+9ZPG0HW4tstWBQn9tyoG8JJtZPRMKpZ+TVwWI4GGsTSS6fM5yjjIXGXrYwcl4xKLbT1VD1nfGqEYxmz3YrbU04SWrmNuBSvekLk12tSAHBEE6MARofluWoybrCz9Uizflmt70tUJpX+rSUbAyrwOUa++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8HtbL4y; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-875b52a09d1so26149939f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750352524; x=1750957324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iOkzX76U6MJmCoJ7ODUrEq9zUgZxIapXr2NXSPRn4k=;
        b=U8HtbL4y0lHZhLZN6ADPn7JjUeTOkxagjBKdG9f9OtkxJd90llj5fnbLbp7qfOaXzn
         WN67I5yxvPJnV4w+lbMmCqBNOQXSJpCwSK0bmckBFbkpoHJdSbOXKfm4ZOZj5lZBWi98
         fEBmjnEorZwtDQXBchGdj26O1oH6krFvWOh50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352524; x=1750957324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iOkzX76U6MJmCoJ7ODUrEq9zUgZxIapXr2NXSPRn4k=;
        b=lvQCwe3L+yLL81eBF6s1kA3BwuFC0PR/grVBcF+pZ2zVyFOlLcvvkUyzOpbAHKh7HU
         G/u1hZVYF6jp6zpwnVXUZBR2T0OYCxgNLhujFaux3Ac4/Z9l8sPdRnJqxtCOveSf3q4y
         NgaliGyaerEfPn5j2Aa+uOX73U9/Aw0QDInbAemsz0+/vucmSXKWYCxV0PZETyu1YElL
         T1rL0LPHsjTxeK0vet/fDb37ER2Wk32XOgR5BjR3rBPHM8vjaBtifHarrHdolcMXCfl+
         TfNGShBeQ/QKmKnemwDr8kCCGWIDBbUNh9T6e47d3euiAAGu4sKHspiSXQMS+k//mz/M
         Fiyg==
X-Forwarded-Encrypted: i=1; AJvYcCV4TDqM6LH7Xt3OBg9d8RvPLaHKwvGEx17N5trByGbUIGe/GxhyG/psXgtzWPRL2BRZt0jRCGsJmG7aJw6/KpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBjEBK1pLW23gOGfNPbWVJPDbpZPYtOkiu0lHV2THR/g6L1U7
	Gd/vFuhKK7Fs+4rI5m9Dg4gvsxWwFYJtd3PeSFvzz11espNysD01Zq4zWb1hIRIXwEw=
X-Gm-Gg: ASbGncuRCZdCCc7JbiOFH2zatEoChfszUFbOydxGuURzoU9ltCd/hPAhxYtx3veO04q
	NA00R7v9d/iUFCgERu84CtS0nr0y8E2cNqtEDPO3URDihcUNTEwIxW0Xqz7G2UtpclXZW7fg/ea
	m1qOHNjeI3HmwexdNqJN9HrAdRE1eXZBBwV+jkPzWsMtdw+SlayLAXqfqkbn+N/LCI7jP1kJtle
	gya3v1Q5FCAbf8huT+3GLNFwInTm08JK+8EZdBKQpcXV+NSutyrMRwytvmXKJyDZMfrbZh8PrbE
	porFzl6uuu8ONIAd2S+gT+HKRNox7qEvOYpVeO/ljqSTwU/vvvFYEUgTnx6IlLIuDdK3RlDz3g=
	=
X-Google-Smtp-Source: AGHT+IHw07yRURB4f8spZKZh12POSjAOvV/GpBlqVlkGBvvAjwlaPpAD88x6eYQ+RytrNoIzcN3SPg==
X-Received: by 2002:a05:6602:6d12:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-875ded0e6b5mr3165124839f.4.1750352523818;
        Thu, 19 Jun 2025 10:02:03 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8762b60fd86sm521739f.21.2025.06.19.10.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 10:02:03 -0700 (PDT)
Message-ID: <72998015-c571-437b-a77a-1c49a2787fc7@linuxfoundation.org>
Date: Thu, 19 Jun 2025 11:02:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/memfd: clean Makefile
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com,
 niecheng1@uniontech.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020559.2797938-2-chenlinxuan@uniontech.com>
 <96c46d3d-0e0a-464a-b64c-15c2a544a974@linuxfoundation.org>
 <CAC1kPDM76fLgE-cbKvMO3=B1hKhjTNMYmJw5XpOPV5UAxXx=Yg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAC1kPDM76fLgE-cbKvMO3=B1hKhjTNMYmJw5XpOPV5UAxXx=Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/25 01:43, Chen Linxuan wrote:
> On Thu, Jun 19, 2025 at 5:21 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/9/25 20:05, Chen Linxuan wrote:
>>> When writing a test for fusectl, I referred to this Makefile as a
>>> reference for creating a FUSE daemon in the selftests.
>>> While doing so, I noticed that there is a minor issue in the Makefile.
>>
>> What happens if this change isn't made?
> 
> Nothing will happen.
> When I was writing tests for the fusectl filesystem in the kernel repository,
> I came across this file as a reference.
> Then I found that the process of passing CFLAGS was not correct.
> So, for the reason of not wanting others to be misled again,
> I want to update the compilation process here.
> 

If there is no obvious reason then let's not make this change.

thanks,
-- Shuah

