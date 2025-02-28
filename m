Return-Path: <linux-kselftest+bounces-27876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A495A49814
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7D3AB32B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174E261365;
	Fri, 28 Feb 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="iauPLKkA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75226039D
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741010; cv=none; b=WbABJqcP7TaPw+Tv9R+Re/xfi2YPB5HpLOU+KT7tluBdp9xsVWNn21Sy/sK2NogFVRti4d7aqeunRVUVOn/x9z5HIODUTRpIdbjiHxafvY7g4KgrY9H405ayvTfJ+7us6eycqBmaKKfMxsQyd5gNDORHcFXABn1q6zCzQ+wvFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741010; c=relaxed/simple;
	bh=E037DhVCapPBoakU2dqv8HwLgqUFKwlWF11ok265wus=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NrmKefLZNDob0P1uNRfu0T7nlH6iw+YZnEC3dXnX0bXAYj9hafjMNnHs8TeoHnXcE6/BBgso++o7fO8ny21EWxK/f8X2Z7BnfC/SQqQsjO2OBbjhF73GCZB9rIVUJYjiSEOgVCcYwIRmIYw5a/VIjft4NECq6o8vndIZjBFmw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=iauPLKkA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1083501f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740741006; x=1741345806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DD4bhF0kHfFymrlaMMfSMbLSI6fL031z/qgNsA1KNJY=;
        b=iauPLKkA2wrDFoRP804vwr/qxhnqDO2S4b0az43hrKLEjceRklVojUeBrBdNVKOE5O
         zx1s/YM/Ua8xCNTjW40WyhyXyhIk5jZU4wAB8/3WZBTc+m7z6JzYgMyZajSHV/FF7/Mk
         OIlZRJExgGQHBngyi1TIo4XZvSdn/6bn/okO7/P3pQ0hlvyncHTbF7Ok7WdkqpW9zJqg
         10oeGzGjOp2Mt8HuIAZHeGaIsVz7Nypvzzcs01YW6/FCjz0cw+QzytKLMkSk1Jx10fxq
         qCNeQ1TPgEkawto/Rf/2/Sj7uG/zVM7PlfpbF8njy3lLDZk1PpZ5F03tPUuYVraBKh8W
         AG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740741006; x=1741345806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD4bhF0kHfFymrlaMMfSMbLSI6fL031z/qgNsA1KNJY=;
        b=YhjfwZe2FgEKQayUYQg4Fl9TA6mx78LvB0Wxjj5T38AFmOzggFW9dHUsNe9YUMmWDQ
         RZjjh5okmO63lrFdVft4sTkxlyF/+Aup4yUPifPPx/DbnRpBclqpyMV/AN4FNRPesO8R
         yah48AOfo2BY0W2+nKtqtzllXUzUFznH/aTMf4ehAL08Jfna8AdhhGiHcZab5aLycZwe
         FPPVoRMnh+c4nhh4tVHDH0WDpHJK2THsvKagzsYCaiYxgc7mfi0Z7/WQhqLuG5capm53
         /C1FLBTA17/j/NB9wS5MXKdkwpWb3N9eSO9NoVEIkSg/HtX2wewr1TXwwtgyamfCheXQ
         P2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG3BAvi8aMsIp0cyee7lM26h87UyhaHBd5GK4n6uTCzOPhyblkxp/aveF+iIGTUGEAPChFcwh19U+jhFuhAFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblypEBTikSzYt5xBbmQGPNOzPpXnz/fcac1aZ5b1JZPt5/HG5
	L48/Jdsw7rGY1Fham8xiSIIUMfw/42jmWR4UC9wxOqhnQzcE+rxBZXoz4EzK3iU=
X-Gm-Gg: ASbGncsk4kvgwM6QsmJeKakznDFLu0If7GkH/h5eGambBkwtGrXAcR/r8kmLNkpLgre
	zMVqerpiqhunVvgiwYYPYCRAEFuaDEYxGwc9YL2vOrbFqbPbrrsQX759FDKf013eZmiqN0Xkrp/
	R9Hn/SM9k+g1w4w5xUUzYq+ru6F4SLTZnrhPLs4w6/qZkKUBtRGTHDEVY8r7O6WqfOKsizXCDTL
	R5Ei0cFDr3jdEkoJy34KfWVeqd8wifDpE5usq0k68EzpHpLRBUHn6VBfq2Wr2QbbKEnwyOoM3aM
	RpEejD4vMSyBYuR98yoEfVxCvuJA7U5B/tsRexwpqI2MuFedkqLOH5XBuw==
X-Google-Smtp-Source: AGHT+IHBwKxAFElOpdG+NI+BwrAkR/KxwPojeVWc8zD8i0wW4iQU4cQtM89ILFrbTkzbuYuexnWIFA==
X-Received: by 2002:a05:6000:1865:b0:390:e9e2:828e with SMTP id ffacd0b85a97d-390ec9becd8mr2465154f8f.32.1740741006281;
        Fri, 28 Feb 2025 03:10:06 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a22sm4906513f8f.74.2025.02.28.03.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 03:10:05 -0800 (PST)
Message-ID: <7c70ca13-143c-4011-bd28-4ff9944dd0a0@blackwall.org>
Date: Fri, 28 Feb 2025 13:10:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
From: Nikolay Aleksandrov <razor@blackwall.org>
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
 <ab9e32b2-2574-48d4-bc13-8e752a194c43@blackwall.org>
Content-Language: en-US
In-Reply-To: <ab9e32b2-2574-48d4-bc13-8e752a194c43@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/25 13:07, Nikolay Aleksandrov wrote:
> On 2/28/25 12:31, Cosmin Ratiu wrote:
>> On Fri, 2025-02-28 at 02:20 +0000, Hangbin Liu wrote:
>>> On Thu, Feb 27, 2025 at 03:31:01PM +0200, Nikolay Aleksandrov wrote:
>>>>>> One more thing - note I'm not an xfrm expert by far but it
>>>>>> seems to me here you have
>>>>>> to also call  xdo_dev_state_free() with the old active slave
>>>>>> dev otherwise that will
>>>>>> never get called with the original real_dev after the switch to
>>>>>> a new
>>>>>> active slave (or more accurately it might if the GC runs
>>>>>> between the switching
>>>>>> but it is a race), care must be taken wrt sequence of events
>>>>>> because the XFRM
>>>>>
>>>>> Can we just call xs->xso.real_dev->xfrmdev_ops-
>>>>>> xdo_dev_state_free(xs)
>>>>> no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
>>>>> xdo_dev_state_free() every where may make us lot more easily.
>>>>>
>>>>
>>>> You'd have to check all drivers that implement the callback to
>>>> answer that and even then
>>>> I'd stick to the canonical way of how it's done in xfrm and make
>>>> the bond just passthrough.
>>>> Any other games become dangerous and new code will have to be
>>>> carefully reviewed every
>>>> time, calling another device's free_sa when it wasn't added before
>>>> doesn't sound good.
>>>>
>>>>>> GC may be running in parallel which probably means that in
>>>>>> bond_ipsec_free_sa()
>>>>>> you'll have to take the mutex before calling
>>>>>> xdo_dev_state_free() and check
>>>>>> if the entry is still linked in the bond's ipsec list before
>>>>>> calling the free_sa
>>>>>> callback, if it isn't then del_sa_all got to it before the GC
>>>>>> and there's nothing
>>>>>> to do if it also called the dev's free_sa callback. The check
>>>>>> for real_dev doesn't
>>>>>> seem enough to protect against this race.
>>>>>
>>>>> I agree that we need to take the mutex before calling
>>>>> xdo_dev_state_free()
>>>>> in bond_ipsec_free_sa(). Do you think if this is enough? I'm a
>>>>> bit lot here.
>>>>>
>>>>> Thanks
>>>>> Hangbin
>>>>
>>>> Well, the race is between the xfrm GC and del_sa_all, in bond's
>>>> free_sa if you
>>>> walk the list under the mutex before calling real_dev's free
>>>> callback and
>>>> don't find the current element that's being freed in free_sa then
>>>> it was
>>>> cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk
>>>> that
>>>> list and clean the entries. I think it should be fine as long as
>>>> free_sa
>>>> was called once with the proper device.
>>>
>>> OK, so the free will be called either in del_sa_all() or free_sa().
>>> Something like this?
>>>
>> [...]
>>
>> Unfortunately, after applying these changes and reasoning about them
>> for a bit, I don't think this will work. There are still races left.
>> For example:
>> 1. An xs is marked DEAD (in __xfrm_state_delete, with x->lock held) and
>> before .xdo_dev_state_delete() is called on it, bond_ipsec_del_sa_all
>> is called in parallel, doesn't call delete on xs (because it's dead),
>> then calls free (incorrect without delete first), then removes the list
>> entry. Later, xdo_dev_state_delete( == bond_ipsec_del_sa) is called,
>> and calls delete (incorrect, out of order with free). Finally,
>> bond_ipsec_free_sa is called, which fortunately doesn't do anything
>> silly in the new proposed form because xs is no longer in the list.
>>
>> 2. A more sinister form of the above race can happen when 
>> bond_ipsec_del_sa_all() calls delete on real_dev, then in parallel and
>> immediately after __xfrm_state_delete marks xs as DEAD and calls
>> bond_ipsec_del_sa() which happily calls delete on real_dev again.
>>
>> In order to fix these races (and others like it), I think
>> bond_ipsec_del_sa_all and bond_ipsec_add_sa_all *need* to acquire x-
>>> lock for each xs being processed. This would prevent xfrm from
>> concurrently initiating add/delete operations on the managed states.
>>
>> Cosmin.
> 
> Duh, right you are. The state is protected by x->lock and cannot be trusted
> outside of it. If you take x->lock inside the list walk with the mutex held
> you can deadlock.
> 
> Cheers,
>  Nik
> 

Correction - actually took a closer look at the xfrm code and it should be fine.
The x->lock is taken only in the delete path and if the mutex is not acquired by
bond's del_sa callback it should be ok. Though this must be very well documented.



