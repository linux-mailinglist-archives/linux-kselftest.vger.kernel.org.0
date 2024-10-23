Return-Path: <linux-kselftest+bounces-20505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5D9AD552
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F9D1C2168E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC21DB344;
	Wed, 23 Oct 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vo2MbbFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F4142623
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714063; cv=none; b=ifCf++EPEGJc4i1KJSXePUDbvdUd5PqJfWGuDQLnmgqFRyCfl7uGE5y6zIY5JuRwCH4pbQHrQ/QdS3HsMgFdHV1DRijc8J8B0glK0H/YAqKN9CCKjS/DbD6AC2SxCIjxlN6MCkFvphYcbqy8Xd+I6Tikd4/xYNQQTufV9EASBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714063; c=relaxed/simple;
	bh=Oc9T20sL9GzDJ9MXtms2CQ0BCWRW+F5FKpOhylFGpDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWTvjUjMvI607Zed1CgKe226qfMDIs1opY7IQsAhPxJ08gSAh56EF8b1B98oTg/xKB6pjt7bVUekDb23UtAFxExX9tpQonQxg7aDPkfszKi6du00HoXkCwhASqrNjFffDZTe5us2JM23W24VaEvFOZmM4K4f3E/88Pk3o9B6CbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vo2MbbFb; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83a9be2c0e6so5846539f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729714061; x=1730318861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQKCB6RcE9DVN+QliMh7NeyWWCz4zTZwRk5ZndcDook=;
        b=Vo2MbbFbPn0ZCnv0gEXyhdVaNups0TZtS4zjZpm0XkI9OQYPrqCVd+UpXaLtSISliH
         XEwOANiArFbRlz7jJq/6/vUcbjajD5GHhzifR/noYAQ/ZqyQ98cqqx1m3r1QtIL1QyYF
         GfO9XYCnchMgh4D8KIxqJ9leAE5o+ejOymr18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714061; x=1730318861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQKCB6RcE9DVN+QliMh7NeyWWCz4zTZwRk5ZndcDook=;
        b=JOk4UFRGhe2WxG4qjABUGCrGNxVqU77F/GZr6NI5Y/3npJx8bFB6CXMqTmO/fMhCdi
         vZlo7QTA9rqxGolnj6dRYQ3e3qyNHRYlHjkS1rJ/sqwbNOcDriIg9gzitZwJUcHkeA91
         mpzBIcTuoFElZYiFOdSXeys3HDm2oBvXb4rvS3KwIAS2CByRrjlo6Kn9xhk7KXbfbnrP
         8x7AD04NFaIioO4qhzNaUJGiLKPaQLm9bOfB6bgpp8uEvq6/+DOxiHpB5HkXs9+ekj3O
         3IknT0SjRsQWki6hGPBYfwm5VlrIpW21yYVcX5A7NuBd8uyEcsQ7TWDNcnTGvQ8Y1Y6T
         u9ow==
X-Forwarded-Encrypted: i=1; AJvYcCVww4gjAaPOrlA4I24E1CKyhu9VlFxRLJwp/chKUU4H0CeUhyZZWO04k16kcmcP2eNpbLgc2gPZnXhFbkVH7mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFn9Hgjm0G6UVs+8YLR+aXOE+rrCQimcjmBB30JD0RUzTTh6c
	VpJoJ9tuhBJUUTg0XGotHIxkMD3d+b7xzNpclb/GWjK+nyCQMBQfndXzkMr9AFE=
X-Google-Smtp-Source: AGHT+IGJAXZLXw8YfyNAKL+7k84dokIL7fMfI0LUJtlRPUYDDDSyMVeTAwledsk56TvI+yeEVlnQuw==
X-Received: by 2002:a05:6602:641e:b0:83a:a82b:f856 with SMTP id ca18e2360f4ac-83af614d256mr368001339f.3.1729714060543;
        Wed, 23 Oct 2024 13:07:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a5570fesm2242840173.51.2024.10.23.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:07:39 -0700 (PDT)
Message-ID: <477cac2e-606d-4c78-ba5e-ce7e594bb6f5@linuxfoundation.org>
Date: Wed, 23 Oct 2024 14:07:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] selftests: net: lib: Move logging from
 forwarding/lib.sh here
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>,
 Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729607879.git.petrm@nvidia.com>
 <4421094dd36be3714eeea70d577ff761454de3b3.1729607879.git.petrm@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4421094dd36be3714eeea70d577ff761454de3b3.1729607879.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 08:50, Petr Machata wrote:
> Many net selftests invent their own logging helpers. These really should be
> in a library sourced by these tests. Currently forwarding/lib.sh has a
> suite of perfectly fine logging helpers, but sourcing a forwarding/ library
> from a higher-level directory smells of layering violation. In this patch,
> move the logging helpers to net/lib.sh so that every net test can use them.
> 
> Together with the logging helpers, it's also necessary to move
> pause_on_fail(), and EXIT_STATUS and RET.
> 
> Existing lib.sh users might be using these same names for their functions
> or variables. However lib.sh is always sourced near the top of the
> file (checked), and whatever new definitions will simply override the ones
> provided by lib.sh.

I like the direction to leverage and make logging functions
common. It make sense to use prefix to clearly indicate
that they are common and to namespace conflicts in the future.

> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

for all patches 4/8 through 8/8 I have been cc'ed on.

thanks,
-- Shuah

