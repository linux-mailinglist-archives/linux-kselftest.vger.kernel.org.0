Return-Path: <linux-kselftest+bounces-15130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BBA94E3DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9434E281740
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F493160796;
	Sun, 11 Aug 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbR1ij9V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AF3D393
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419356; cv=none; b=ei9P4rWcjfDfiD8DnzZsaeNpY1cilBfO391OfnqVb31QMsI63dmu6aHZNUOxJLAPD0ULXakFvyrYuvKhARPI9wlR3GmX0nS02/X8eDo0R46AMR+axU0+FcVJ3T3/CTUSqEB/+YIsM9GwS3S2pmAingrTBJGZntUcFYMLJn1CTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419356; c=relaxed/simple;
	bh=yb0ny0zY4VuXPLTCQZNYbnK3oc52429hwYQFgNULx1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSjbXWdgElXxWWYwU/f4IM4bRkzX3VASTSfYzeG8ATpNE4Gcnl0uVnavLvHp2ghYBBywBDZSeqcFb0uOJMT4k4byJKl9Vh3nzhyyQ2aL1dnvlkDZ1obXW/Zn6a+sq/hmxzMPvtHwQeUFwTgDbsUrfYhuqNZyFUhsGScZSbYLvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbR1ij9V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2357df99so87730b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723419352; x=1724024152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hO37jwTmuSgE1Z4eVGpKU3tnYdMedGjB31Oft97scek=;
        b=VbR1ij9VvJ5R1Xp+0Tf+tjuWY9r6cJUsaJ3mU+3cOGpyd/gO5p4JaUOZ2NkDEcINUX
         7XlXByUu6nyNtPM29yVEAIf3B3sXR0IakfKZxiwrmvaeg/9dcEo8QXjNGNtvWCJMS+We
         izk2mXgvfdJjgdt7neJkrQLvIllwO7guC3FH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723419352; x=1724024152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hO37jwTmuSgE1Z4eVGpKU3tnYdMedGjB31Oft97scek=;
        b=RPTahL+s1z7GGlotUZLR5uhtYpojo1MuYQaG9qSseP8JAJuTdW8ZE84uj+vUVxbmt3
         6Pfh4mtkWQGPDP1iT73G0IJBNxw3Bx6hT4kqeDuOg5lqRLrLVI39Ld2Vae8q716IM439
         l1Atu0/ojWidqiQeT9eGvi+7RUsxfaWrzvJofG/VJLNmOzEdk//JJs4D2jCNpAZ7KIhN
         JZlJAuPzRusiUIceF/cQVE+69GjbvAIcWYArHackkzUQYbs6pu4u6MVVxRxNOJ9HXoWy
         gUSf+XvV9Y9HcOLtKQ3Hnwiov1fx5fd4rgtNO1GeoH6ruUpNxd727YnFf7S/3H5gcTSy
         LHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUskHIRpfNJjXBwwxygG2kTOuLl4t/Ibgl3HTy/fc8zQy1e9nEnCIWwr4JmU0W9laCE6B+75XLcehZJJkQ8fM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8KTjdU908Fz/y8MeTcWUD+qIWR5KBuqL040xF79ElS1P12Ca
	NqclKKEZP2akzvTIA6kalWWoBt78Vuyejnr2bVJJvQTe5a2UybZUy3cB2c3sCQQ=
X-Google-Smtp-Source: AGHT+IED5VVnpv8Jj/o2aNdwI2tSUckratzTwSCTsE+zxtRcpvo79CBOM3dI2QieB5Cx1UViO5mYtg==
X-Received: by 2002:a05:6a00:9149:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-710dc687057mr5239855b3a.1.1723419352538;
        Sun, 11 Aug 2024 16:35:52 -0700 (PDT)
Received: from [172.31.140.29] (softbank126051159161.bbtec.net. [126.51.159.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43948sm2840815b3a.122.2024.08.11.16.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 16:35:51 -0700 (PDT)
Message-ID: <de8abe69-3735-4ffc-9cc2-21a167aab44f@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:35:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: rust: config: disable GCC_PLUGINS
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 shuah@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240802124536.2905797-1-anders.roxell@linaro.org>
 <20240802124536.2905797-2-anders.roxell@linaro.org>
 <CANiq72kb9mDd0xndGFnMQXP4Hg-GE91eQ07yYiQW1HwWv75Qtw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72kb9mDd0xndGFnMQXP4Hg-GE91eQ07yYiQW1HwWv75Qtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 04:34, Miguel Ojeda wrote:
> On Fri, Aug 2, 2024 at 2:45 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> CONFIG_RUST depends on !CONFIG_GCC_PLUGINS. Disable CONFIG_GCC_PLUGINS
>> in rust/config file to make sure it doesn't get enabled.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> When https://lore.kernel.org/rust-for-linux/20240731125615.3368813-1-neal@gompa.dev/
> goes in, this could also be relaxed.
> 
> Thanks!
> 
> Cheers,
> Miguel

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

