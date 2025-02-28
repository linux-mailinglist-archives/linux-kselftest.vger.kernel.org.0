Return-Path: <linux-kselftest+bounces-27875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A552A4980F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904081896304
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34630260A55;
	Fri, 28 Feb 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TyBmdm8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3C260A4E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740845; cv=none; b=G2ZKrxFsfTxCH0xhTeWC+x+z2yfUALsNZheYbsWqBAHHStpjWRwgWNZl7trnvFVUPUIqL8bXEU03eLFYHWGUpQmRHgcCBmXcrVeifkFxI176XsWheqLq0647w6RsbtuhQoZGxbBG9E3ZId1hAhik9lJNkPmhKAPJnldjq48tego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740845; c=relaxed/simple;
	bh=oxS3D1+bWCdWf/O3kma8r+tOX5j3w/Z2DbftKYa1FUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjuPQtTl+e9jErxFO++v3iMfARkikljDVoc1hPxTwMgWUijDa+Eha2SyogpQQcY90bxAq0iayGlLu4CUvbMkyeyTB5rmgb00x6NWdgWis9OEW4syUWBn6TYQu2zkurGIP5Tdq2IwPkvUvaSb8DzWvzD3OTj7Z7lBFsHXd05eQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=TyBmdm8+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso20502485e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 03:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740740842; x=1741345642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zd6cBLv8z68rtL/L7WHD5EmDRb0PMF8fi6e4fzSvi44=;
        b=TyBmdm8+HTXWcvSodydGM5F7ILoG5Xe5eKAiqBJQIJ559ARyiA5vnc4JCqSxSPhabJ
         V3bDtqCuOp2semRLf37BqC1Au8+bZ8PoIbNr2/WyRs1RmpIwsr/t9tMERrKjHC55l3pv
         zzkCeZdMqFPjHJgRBl8n2AgZ7rFHJbp1vnosU9wbnh8sAQHm26GWEa71e8SQvNScHbsO
         dHoJt+anrMRVlaVyhQQe7skM5Zu9UbSwGd6Ok1H7SYf7+C4Q8/nlYD8B8aXhW0iCl5/l
         a/nPhT6Gga7PXv7Og0ZDYn6y7rkdpY/XfW9v5sNaALOgvKiJgyKU/u4dAyrNDqOq73zJ
         2H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740842; x=1741345642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd6cBLv8z68rtL/L7WHD5EmDRb0PMF8fi6e4fzSvi44=;
        b=N1IRlnJ04Wx7wseqIZyzvvyX6BYlLnCIq83s4sR2qdpaH4USPpamm2+7XaxjSIxLha
         RcLLDNAnREUaGgHEp1zz34UTGmPHGOFDhSk6tY/vF3368F60YkkdOrGNmKBPTS1yIAO4
         dAqLfJnr7HLJHuCbeF4QbEFyqoLDF1d7QBwe1q9P077ho9Ek4InVFcVBB5Ut3wc+e3TO
         FTrE5HROsZ7ZwuThaaAlUNjpV1q3BqixYuf7TuhQS/akXdwXwbSlXTDco6raIrAKlVRg
         +WpCufwbqAfx7j8RiYZFV7Wp+3Bo6/nX0PBRP1Dl+1jvDRIkTomv1GslVaCmgiEcwQA9
         srMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnX+sjtb2ATb7AodVjq0/DHlxinTaMgKjHfrsAj35Wjo6tiEyxLhKKnvDswumB9QgI/Cyx2N7uzjdt2cSoWkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcfh4soILrLDylASYy1c9oqikr8BkyhfuIQBIiaeHKKDRfX9kF
	p9eOBc0bk3PlD4cqEsmlI4mtZjuNIxifDDN4eUPwGiRnt9o+Zx5OQWiL/eTRTmU=
X-Gm-Gg: ASbGnct0TLm5t6CNaeEfaBqmuujXaW64JZK2tc0MgpauSS24oiIHrWsC8w7QOdWTHAj
	zgSLUKW6mD5yOCnKarvsuhM4YiSC7Wx6rGx2yQEJnpbwx7t6ncF9j0khjRjUk7g1P/UP8sJqZqL
	Gpmw9J/kLc+j3rVO/j1yyK/aE7S+guQjkJ5h0TEOE1Vnmtc7pzgkcJfJh1gHo68H8fufPJaeyuc
	mJ7eU3c/jtmQv9X37YSXbIQ0v73r4d7mKAJapab94/DkBKxFLBpV/b4X416B0qsgQ4eDzjhv3Ta
	96ldImvgRK40vXH03cqQD/eYlwJLBgqHy/RW3Zl3y9GbiKzO85gNWiEaOA==
X-Google-Smtp-Source: AGHT+IH91pMAPLSadsf+RNRWI0zz9P3MfkuBchVOwSQOEqwxoqoJ6x/WNs/GRbayY2jKTHKyAR6gRA==
X-Received: by 2002:a05:600c:1c1f:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ba67049b8mr28277205e9.18.1740740841365;
        Fri, 28 Feb 2025 03:07:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28c6fesm51527215e9.37.2025.02.28.03.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 03:07:20 -0800 (PST)
Message-ID: <ab9e32b2-2574-48d4-bc13-8e752a194c43@blackwall.org>
Date: Fri, 28 Feb 2025 13:07:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
To: Cosmin Ratiu <cratiu@nvidia.com>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "jarod@redhat.com" <jarod@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org" <kuba@kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
 <Z8Bm9i9St0zzDhRZ@fedora>
 <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
 <Z8EdatcTr9weRfHr@fedora>
 <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/25 12:31, Cosmin Ratiu wrote:
> On Fri, 2025-02-28 at 02:20 +0000, Hangbin Liu wrote:
>> On Thu, Feb 27, 2025 at 03:31:01PM +0200, Nikolay Aleksandrov wrote:
>>>>> One more thing - note I'm not an xfrm expert by far but it
>>>>> seems to me here you have
>>>>> to also call  xdo_dev_state_free() with the old active slave
>>>>> dev otherwise that will
>>>>> never get called with the original real_dev after the switch to
>>>>> a new
>>>>> active slave (or more accurately it might if the GC runs
>>>>> between the switching
>>>>> but it is a race), care must be taken wrt sequence of events
>>>>> because the XFRM
>>>>
>>>> Can we just call xs->xso.real_dev->xfrmdev_ops-
>>>>> xdo_dev_state_free(xs)
>>>> no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
>>>> xdo_dev_state_free() every where may make us lot more easily.
>>>>
>>>
>>> You'd have to check all drivers that implement the callback to
>>> answer that and even then
>>> I'd stick to the canonical way of how it's done in xfrm and make
>>> the bond just passthrough.
>>> Any other games become dangerous and new code will have to be
>>> carefully reviewed every
>>> time, calling another device's free_sa when it wasn't added before
>>> doesn't sound good.
>>>
>>>>> GC may be running in parallel which probably means that in
>>>>> bond_ipsec_free_sa()
>>>>> you'll have to take the mutex before calling
>>>>> xdo_dev_state_free() and check
>>>>> if the entry is still linked in the bond's ipsec list before
>>>>> calling the free_sa
>>>>> callback, if it isn't then del_sa_all got to it before the GC
>>>>> and there's nothing
>>>>> to do if it also called the dev's free_sa callback. The check
>>>>> for real_dev doesn't
>>>>> seem enough to protect against this race.
>>>>
>>>> I agree that we need to take the mutex before calling
>>>> xdo_dev_state_free()
>>>> in bond_ipsec_free_sa(). Do you think if this is enough? I'm a
>>>> bit lot here.
>>>>
>>>> Thanks
>>>> Hangbin
>>>
>>> Well, the race is between the xfrm GC and del_sa_all, in bond's
>>> free_sa if you
>>> walk the list under the mutex before calling real_dev's free
>>> callback and
>>> don't find the current element that's being freed in free_sa then
>>> it was
>>> cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk
>>> that
>>> list and clean the entries. I think it should be fine as long as
>>> free_sa
>>> was called once with the proper device.
>>
>> OK, so the free will be called either in del_sa_all() or free_sa().
>> Something like this?
>>
> [...]
> 
> Unfortunately, after applying these changes and reasoning about them
> for a bit, I don't think this will work. There are still races left.
> For example:
> 1. An xs is marked DEAD (in __xfrm_state_delete, with x->lock held) and
> before .xdo_dev_state_delete() is called on it, bond_ipsec_del_sa_all
> is called in parallel, doesn't call delete on xs (because it's dead),
> then calls free (incorrect without delete first), then removes the list
> entry. Later, xdo_dev_state_delete( == bond_ipsec_del_sa) is called,
> and calls delete (incorrect, out of order with free). Finally,
> bond_ipsec_free_sa is called, which fortunately doesn't do anything
> silly in the new proposed form because xs is no longer in the list.
> 
> 2. A more sinister form of the above race can happen when 
> bond_ipsec_del_sa_all() calls delete on real_dev, then in parallel and
> immediately after __xfrm_state_delete marks xs as DEAD and calls
> bond_ipsec_del_sa() which happily calls delete on real_dev again.
> 
> In order to fix these races (and others like it), I think
> bond_ipsec_del_sa_all and bond_ipsec_add_sa_all *need* to acquire x-
>> lock for each xs being processed. This would prevent xfrm from
> concurrently initiating add/delete operations on the managed states.
> 
> Cosmin.

Duh, right you are. The state is protected by x->lock and cannot be trusted
outside of it. If you take x->lock inside the list walk with the mutex held
you can deadlock.

Cheers,
 Nik



