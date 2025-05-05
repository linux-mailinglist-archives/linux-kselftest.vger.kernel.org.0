Return-Path: <linux-kselftest+bounces-32465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A898AAB22B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770FA7BB992
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD362DC3CE;
	Tue,  6 May 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="blIsO1yF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5B2D6458
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485709; cv=none; b=qP5dc10ZwjRz+uT+wZukwWDLt4d7yf8HEfUWNQ7gesTI7r8IsZJD27XwJsHhMCLDd2zgUKdJkKReUA+MUisdXxsoyzTAFNWvZtvK5iBcnWMYcabRCVhv4p1WrDb9kkxfEojUuk2wnLDg9nvFBzhyj/e6LQhgicsvMiNyO1HEFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485709; c=relaxed/simple;
	bh=Mg2CXirr6UvTh7WdZZfM5Ugt9d72LzrmXthHN3w72ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OORbrXCEDmRuAldr8iydwOgJQ86KoPe7v9/o35O62Xni92OvHIbJadPVZWSHstAXp7E4jlERTBENvgm77byB6bZs7Tc1A1DmQGyfo6Bzmx9zftRagyYqMqY9XfLi2dO9FdkWZgWQAzF90bT7q6WdJHd2gmXo0gvI/Qu9nCbeqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=blIsO1yF; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d818add2a3so17075995ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485706; x=1747090506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0MzPmtdmRQ2wegGs8YL88YA21hMeqRHBV5NTQWj3A=;
        b=blIsO1yFR1IS5CrCYFZYFmR327mV7FkydBSGwie6Tjvt3b98gzF8pnEsl8F5Vguv7K
         i/qgSoFkZU3KHommCYOvrE+AS0gItoRUfQdp8RltmPYg0cUFJOB8f6PDHs+U2u6I8aQC
         RJDWdDyYKasyW2UzoO7dT//Szhq3mzOHcisv/1YvGgYf999lVrJmzd87M5oIbxvpCwDp
         CZnyt2HjMo7V2jhgnICrsQJSgohO31XdfkCVzLL9fjV9tDOm6i/SX2Nueo4mwHR57Rtn
         3AnezZ4eJCR6CnY4pYCFjk3tY7b/1cGQxiGL+uWEy9g0FMMsP4mb/189u7AoS/Uv6j5V
         AEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485706; x=1747090506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0MzPmtdmRQ2wegGs8YL88YA21hMeqRHBV5NTQWj3A=;
        b=jyLmboba4QAwhLsWQlgVB4Q6dz8X3mPUsQ4P0DnPr+kKUEr/XVePUSO06YMdfFwQMv
         d9VLNNmIKPM5sG5ehhfGUCnwYNAOuhqob762y/KnOdPfz+OzwSlcdsN7SmwUPv8DL4JL
         pQ09IoL6Omk7uCpSHiV+PxuK7pc1VLDDtpuMZzv18yI6X+AxS/nRgZKIZjI6RG7aNIC6
         01NrxXl8PgTyl5PBc6tQtpe5z81OOcB97trtdryZ3eJ60HNl0Og88hOdhSgVUQAxhQv/
         7ox7KdUOSDKe3dQXz6A3Gp/yq7LYslf6x3Zq7RgUwjICABOLikP6U8f4tzKoMMYPM4f1
         SRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDm1VqsDwuEoW4O1Ew5h3opXwvt3y5XCXUFXM9rzNFcp7cfoVXjad/fSOi6/ASeduCmKBUj4gevGtU6w+MclY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtx3Wx7EjUs6K8/RNFZETLQTZ2dyshWX0y4hpfTdxwfPuHOdz
	hejBNhpAgUkf1FXcXFlkQcJ8uuV4U+yIqEWBu8g1fr7VVjXa+rl/8Qpw0Yt/18k=
X-Gm-Gg: ASbGnctkya7c9om8SCY571out2ffROaVlSUBKfoCirm1P73UI15nH81N570WeN9FrT1
	r9ZAjjHD1pl9BPt71gC1wv+LXKp69RWjsxxhFejrH3e8gMNE+SNM15pL4YqEKKof5CXkR6TabBc
	JCZHpwe90jIuWJjkgyp07CarSf6luTCMwqooocoHoCeliFDAtNIeVHt58HpU40NasTEK1RasvoJ
	noAyZ1eOtKqKqA9hZmbr0qwpIpqQt4uHugDaCdlUrx7tfUCOWFhuuW2Cec7+At0LYWCvv5sGDj1
	4pC7GRxwev9t3m/W7cndwgu22s9+c7v1Pz2lCw==
X-Google-Smtp-Source: AGHT+IHD8ML20CAJxh1aMxoelraKxk40IzV2DcR6+Tf1u925PW2sSl5JHvnPoT+pcjPADCDtKFI1gg==
X-Received: by 2002:a05:6e02:219c:b0:3d0:26a5:b2c with SMTP id e9e14a558f8ab-3da6cab0417mr15472125ab.8.1746485706305;
        Mon, 05 May 2025 15:55:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f6dd89sm22445675ab.66.2025.05.05.15.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 15:55:05 -0700 (PDT)
Message-ID: <818fd481-3925-43bf-af04-a10244a52d66@kernel.dk>
Date: Mon, 5 May 2025 16:55:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
 <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
 <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>
 <aBlBdBl8uKCIVOPG@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBlBdBl8uKCIVOPG@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 4:53 PM, Uday Shankar wrote:
> On Mon, May 05, 2025 at 04:44:19PM -0600, Jens Axboe wrote:
>> On 5/5/25 2:34 PM, Uday Shankar wrote:
>>> On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
>>>> Hi Jens,
>>>>
>>>> Can you take a look at Ming's comment on the first patch and merge the
>>>> set if things look good? I can rebase/repost it as needed.
>>>
>>> Bleh, sorry, I meant to send this as a reply to v2:
>>>
>>> https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/
>>
>> Let's give Ming a chance to review v2, then I can get it queued up.
> 
> It looks like he has already reviewed all the patches in the set.

You're right, was looking at the other v2 that you posted today.
Now queued up!

-- 
Jens Axboe


