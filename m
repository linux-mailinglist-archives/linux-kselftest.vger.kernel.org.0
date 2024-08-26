Return-Path: <linux-kselftest+bounces-16348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A295FCB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0EA283369
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071B19D88B;
	Mon, 26 Aug 2024 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4Hf1Yp3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677F19D075
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711157; cv=none; b=nx5hoSsJq8zl8TCji3i3Y1/1pzPwpikiPZv/Lr8F1b/Biuf5sYj2iyLVf8bl/sZT1tGafbtP9dMV8BzAtKpwY1lXFV1dBKeVl9huiuJKeV2xFy5JCPR2sYWnhMbTDOOknwJ0Kvsgl+kXwYv2aGIIRo0kWDmpzDNnCfzOq1sT9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711157; c=relaxed/simple;
	bh=+YzYiUddl7WzqiuD3XFxFcsM07ACtx70EA9yzXEAw9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBLZiMFjiSiSRamBS0A1ZZhccX6LhIHy9mGt1rGBMvzSw1PnNyU7n1ai50b1aAntdymeHL+3NBHnkZ9Pt4Z6JMKntFtQWnAVKiUOvUB5b60OKWEtVfLYT0WC8iBHdnbSk3v30CzOpRVLQ0gZ3JCjrw//whnaQGu2PoXc+WsMla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4Hf1Yp3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724711155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp/iLwSeDYxo+zs4Eu6WkmBXMKfgOlub9d3k+RLst98=;
	b=i4Hf1Yp3e72x15Yk8EOTVgDclhQSuA7XcehGHkJRg+j7+TowIw/blGqGKcjrLPK+IBfYYB
	hmDXva1zZBGvhbfR4pQ9U4Un4HCphLyBqv68yXJoA/q0oe0JyHN1cnXV6ZOsYj1uOhm+Fz
	uKvtJpnnZltyCltYs757OZlAziI/Pz8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-QXg-eUgeOG6E43mEW0998w-1; Mon, 26 Aug 2024 18:25:52 -0400
X-MC-Unique: QXg-eUgeOG6E43mEW0998w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf789d42bcso61239556d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 15:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711151; x=1725315951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp/iLwSeDYxo+zs4Eu6WkmBXMKfgOlub9d3k+RLst98=;
        b=dD6MJb3NwHsRF6sa0SPEJrhEftt2M3hZf0MBR2IS4jbS0tcvOKeUrmTGQeGPLw8yUX
         UJZtikjWT7aUi1IsfSoYahii8ed1OLPPp80lK30LFGBK5igRiI6w96T3gyoyYLgNzNWQ
         3v6XDk1np1Mf5t73oT9nSsNrvzLA3Znj3PmNXrF9bePzUsbY++3mdIPdLjIO12XGz3xU
         BXNlH+ITHn5bUIDFc43ogqGMszYM+Xj6UNg6v6o3GJsS2ZVyiA3n99cQvqJCGgtgoeEE
         Vpir39+IrQ0hEGNlcegYfhjojBk6hj0wSOWEhf7O1W1juYMLnjIrG3uvMPOIE4nh+mDW
         /i+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtFDulH0VNdIjX2LXRZugT8PXh+xhX1cIYn6PUVsl5Np+T6OBLIBRwviddmVciDJieJGFiN2jecuyuG6Me014=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRunPOlgfTQ3Y863r/96g3VYlu3V11mP6KOTEZ6voV91Lh8jx6
	+o6QYFuXb9kDoGhgndyAo5Yt+oQzzz11TYWsNOW6iwK9UIq1bZAXLevMESvtZepdFGFO4gSVWe7
	AB6+3jzeIqaVzedv9OBCd30bqEGRBB9rYTqZ9isby6alZfmJyB+xI7E5sM9HJEKSVnQ==
X-Received: by 2002:a0c:f209:0:b0:6bf:7c43:c390 with SMTP id 6a1803df08f44-6c16df28accmr165362926d6.48.1724711151586;
        Mon, 26 Aug 2024 15:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6E8/uu5HzgtnUmuh1ISv3bLFbUm6t6E8SWIRIVwEfIumByBeTj9AeGtbyeQ3BXh72tLa8tw==
X-Received: by 2002:a0c:f209:0:b0:6bf:7c43:c390 with SMTP id 6a1803df08f44-6c16df28accmr165362626d6.48.1724711151090;
        Mon, 26 Aug 2024 15:25:51 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcc904sm50182266d6.104.2024.08.26.15.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:25:50 -0700 (PDT)
Message-ID: <c9567ddd-cc84-4fbc-bb6d-b719b2cb723c@redhat.com>
Date: Mon, 26 Aug 2024 18:25:49 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
References: <20240823211902.143210-1-jmaloy@redhat.com>
 <20240823211902.143210-2-jmaloy@redhat.com>
 <CAL+tcoDgq+MmNz6Eo_61eBJ2fduyxL1j+kbo_9AYtB4o3tJO5w@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CAL+tcoDgq+MmNz6Eo_61eBJ2fduyxL1j+kbo_9AYtB4o3tJO5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-08-23 19:51, Jason Xing wrote:
> On Sat, Aug 24, 2024 at 5:19 AM <jmaloy@redhat.com> wrote:
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> When we added the SO_PEEK_OFF socket option to TCP we forgot
>> to add it even for TCP on IPv6.
> Even though you said "we forgot", I'm not sure if this patch series
> belongs to net-next material...
I agree regarding the fix.
The selftest is new however, and belongs in net-next because of that.
Since I made it one series I decided for net-next, but I leave it to the 
discretion of Jakub and the maintainer of the linux-kselftest system to 
decide where they go.

///jon

>
>> We do that here.
>>
>> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> Tested-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> You seem to forget to carry Eric's Reviewed-by tag, please see the link :)
> https://lore.kernel.org/all/CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com/
>
> Thanks,
> Jason
>


