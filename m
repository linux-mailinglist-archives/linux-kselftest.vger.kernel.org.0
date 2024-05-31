Return-Path: <linux-kselftest+bounces-11046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFB8D6983
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B651F297FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DA17C223;
	Fri, 31 May 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xdt3BDL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C0178369
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182810; cv=none; b=lrQp2FpqNKXGiHTFCQyuGT5WZ+nQoDF+497Oaa/tv40TJteuKcQF/nJpB04+HuDSmgIscK5FZ97WeUoWXu4ScOBteVCnehqLBU5UMRys4f3SLkA94MXzsJs3JNNvbZNw1ES3or/QZj8CgSFOXQPYseIy4e0bWlGOxDGeBxCBE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182810; c=relaxed/simple;
	bh=E296/Sootdy1zZQGNWdy4Bn1+fEQuepZc3Fj238Krog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajy2RciU1FS4w2C4GtLKrVyW6ua2DR/K4t61qmhgzPUZLtd/BGqDILLAAoZ7/tUbJ2niWNg2q+BJjGjbLjhfNA/Tl++JjLCIH7DqDvpNxdkOZ3+hyVI9qB1rESrQsZAUuKn2l+3yMrR4eiwoqv1PA17eu6MM1zqtdVLG9Anr6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xdt3BDL2; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e3b1981fe5so10724639f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717182808; x=1717787608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41fiE54FY+e6bgGGsIbRgTEJBX7DPyrtesC8AIAh9Ug=;
        b=Xdt3BDL22gzsFqcdg/T4UgxHlLb9JGTaMPdlXWcilOXYfJHV59WqcsF02AAh3C6o9L
         KtLSBJ1hz9SsKYBDG4WNPdkfoAXLmUe1WPDU+dEOKSUdPjbww8gm9eFstKSEECVAmXfG
         qPeEz5bcQwzrUzvkcyxU2iK6TRtsYdGjjt2YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182808; x=1717787608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41fiE54FY+e6bgGGsIbRgTEJBX7DPyrtesC8AIAh9Ug=;
        b=PeaVerbQSgRQ7TOFyQNamR030ZQu3Y100vFGLyPojxRVN2mBwgV6fVHB6Sr+McxmCG
         z+t00xx7srMTJxUa2OwJrhN9+vUDB7kFCp7eufVP4AV9JobjxpR8mitVuNVrzsU9Pt1Z
         FcZyCmR8xmY5mJECEdI4GWh7msDzuyo4iSsJo2xSySb4WQWFQW/UU6wty7gielcnbZae
         Yaw5mtVAdWPjAE0/UMkNsNppSFATTEWuY0Qv5EPtnaIEHeaZz3zkSsAZDBtivzDrGTZ5
         +H6Si45pyGrYHuXiKD9KOG2bxNhMSWSJHvpXtW4trQiubKekc85qSZOZn0GEzHRcf6Cg
         csbg==
X-Forwarded-Encrypted: i=1; AJvYcCU100uw4OaIaOMATRE9X2qkyN5PlTrciOzDejYFoPJHjAhPfBvUyNyAX+8OgG0WIGHvZ4KoGlqt9Wb/vS8NsVydlkRdIYt4G7olDu6wcL+J
X-Gm-Message-State: AOJu0YzqvsdnL/kOq6iNNpMIBjZJdoYLphzOGvD4GLb9uU0etux8lhyC
	ROwETPLYBt870kpag+gOpY9eL7bQsF8CX4NYSBobdjArLjxwpmPzVozf5PaM1Kg=
X-Google-Smtp-Source: AGHT+IHrKoWGzpR+rMVObi2QP9d4WGkPOovhn8D1ERBu3+IYhrknVsI6Qi0EL7KWAFhRyTDonEBaPg==
X-Received: by 2002:a5d:9b13:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7eaffee2c4amr334625439f.1.1717182808038;
        Fri, 31 May 2024 12:13:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48b99b0c8sm626884173.107.2024.05.31.12.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 12:13:27 -0700 (PDT)
Message-ID: <f9091516-37ff-43d1-b515-ae8eb3f80e80@linuxfoundation.org>
Date: Fri, 31 May 2024 13:13:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] list: test: remove unused struct 'klist_test_struct'
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: davidgow@google.com, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531151801.128792-1-linux@treblig.org>
 <89e07c93-a54d-4cc2-8ee1-664389ffcdd7@collabora.com>
 <Zlod5TMzmXinDu2X@gallifrey>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zlod5TMzmXinDu2X@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 12:58, Dr. David Alan Gilbert wrote:
> * Muhammad Usama Anjum (usama.anjum@collabora.com) wrote:
>> On 5/31/24 8:18 PM, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> 'klist_test_struct' has been unused since the original
>>> commit 57b4f760f94d ("list: test: Test the klist structure").
>> Probably a fixes by tag would be needed here.
> 
> I'm generally avoiding fixes tags in this set of changes, since
>    a) They have no behavioural change at all.
>    b) Downstream and stable kernel people use fixes tags to indicate
>       stuff they should pick up if they have the original, and there's
>       no need for them to do that with this cleanup.
> 
> Dave

+1 on using careful use of Fixes tag only on real fixes for the
reasons mentioned above.

thanks,
-- Shuah


