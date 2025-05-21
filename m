Return-Path: <linux-kselftest+bounces-33453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE739ABF30F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4143BF9DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F7263F5B;
	Wed, 21 May 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOVBKSAF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789D22DA1E
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827564; cv=none; b=HBNBcNw2GwAgiyVSt0R/2Sy/tfsWjyLHwTDL2pZaYKgQM/AmGZj+u2B2LpKxgAr02rKuoIzl9PmM3UMmKIqgkmM6Wl41OY/4hV8RaFBy9aZwZu3dDbyW/s+0wwW7sb1YmHWwIWglt+0CcORvN4GE4uWpRebs5Blmm7Yof+N5jc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827564; c=relaxed/simple;
	bh=ZCZ2aJ1b5eMSWudl4vKU4ptaYuhCrY9+6o62fv7wrhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5LTEMNOmQmH6ON+6NaLY+eTRF89h6xo1Fby5zwgmvIEGfjQcAiI9I8uTYYCxRmWqRxtrNbct/ZUCOWmwdp+jApfGtel6udVe1MAR9Kq8Rdhnt03JvGFnU5UPdsG4ewGowmw9bbwi6YCD6sseD2BCSGve1kJI+RMzhryuCaaZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOVBKSAF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747827561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9KOOfsW+8OgloJMhG+itfRoJTQZ8+HhBWqoWSniyY4=;
	b=eOVBKSAFJMEjV64oqPutVzgtmmrCnizztXl40y0549zvDWhNGUu8wXWl6XjOqxj7XRw0+t
	bJ5z17NDQBccuGXwyzaEcYRkKWnOA9gT4GC9B1v+8dlR9W8iucyDh6imsiDiYjiAfAOMeY
	/kYfh8Dvm2nJrWDmgAXfS5DM5rLPfW0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-lsPshMg8NKG0-2argdkA5A-1; Wed, 21 May 2025 07:39:19 -0400
X-MC-Unique: lsPshMg8NKG0-2argdkA5A-1
X-Mimecast-MFC-AGG-ID: lsPshMg8NKG0-2argdkA5A_1747827558
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a362dcc86fso2049299f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 04:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827558; x=1748432358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9KOOfsW+8OgloJMhG+itfRoJTQZ8+HhBWqoWSniyY4=;
        b=fkio64o3BBN+o5upMpdvshMeXNxGu8ivrUrPqjoVbU3IgEGgJWHqihz/e4pP2EiP6Y
         9yeKws0YcEOvGeGO+CUqPnmmSsWKpAe1qsvkiA2ThDIXzK1yXRYd31lYnLTuG5uWPnUw
         2s8UO8iAGOpkhxAqNLHR3QJTomq04xfHOUbas02dyB1AnECZZWeXe80UxqSFTr2ifRZ0
         OyfhSVSXcha1mq9BWH0MDlaSaLAjEup+ius1ExI6WpwwsmJYJzDMXJCn+U++noAuyu49
         4EW5p/pkeM7MnLFEtYnIn4PBy9xcjwA/2fD5+sUxkQ3HFBwbanHLi15OpLPh6BCNDWkC
         C3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1+xNLFShnqhCWghWsmdko1kGZjh/goKJJlYqkBVkBy/iJdENSbHCAB64HBYX3ElvPwBxq3Yl6jyGgfjIcNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvYA/yTC2MnhWfNPQjjDNDIa/CEIV5UXTqFQzMGBwijbcLQgW
	2iOQ+8YV2dVSigx+VPGboJwYeZohd8N7pUIDOh5JAEiP7rJ/dB1WvKNF43HYhr/MrcX4Fm1ZCk2
	XWSGgPR+4S+kxRDq9JOtjrmHuqLFTa6Y4Tuvhkl9ZIiTOo1lIyr4zvc0J6k9vy25+AWjpMw==
X-Gm-Gg: ASbGncvLpaSERvnLXakRRhHvassfvABXtj0uBq8ExDmwA0hpBC8JqQqnYiXZip7ABu1
	d/9xNnXBOwxsaG/cK2ZC7jQsQPkPwdZIGFAW7O4YT0FHEKu8mAN4yecldE1gpMmnZ6IiFNNMbAb
	eygUmlASmQFP+hjpFbETAkBVe7KBsEQWrxolyRURJ2t5WuFegwYs+Y6cWcoTy9xHxd/OImd1HLS
	6698ngTLsSb/eptxe4gno1jHMZlTiiq+HIlogyoxFjO6H1l+2Zt2LTcHo633On7c+nTO5rUCu8q
	hK1uHYkEuzjbzBubLea4KgG/ET8Hn4kgdybEsCYesM4=
X-Received: by 2002:a05:6000:2dc6:b0:3a3:779d:5f42 with SMTP id ffacd0b85a97d-3a3779d5f61mr6318205f8f.3.1747827557960;
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxQsTXZ+Ts2cIK3EuR4b/M12UVesyDgK3ufrotSRgReR+EMMzUPKugbn4ggPlauNfM02nRYw==
X-Received: by 2002:a05:6000:2dc6:b0:3a3:779d:5f42 with SMTP id ffacd0b85a97d-3a3779d5f61mr6318166f8f.3.1747827557508;
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
Received: from [172.16.17.1] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d224sm20072118f8f.12.2025.05.21.04.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
Message-ID: <96837efb-63ac-4191-8e2a-4785672c8d7a@redhat.com>
Date: Wed, 21 May 2025 13:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: can: Import tst-filter from can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <dac10156eb550871c267bdfe199943e12610730b.1746801747.git.fmaurer@redhat.com>
 <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 14.05.25 11:47, Vincent Mailhol wrote:
> Hi Felix,
> 
> On Sat. 10 May 2025 at 00:07, Felix Maurer <fmaurer@redhat.com> wrote:
>> Tests for the can subsystem have been in the can-tests repository[1] so
>> far. Start moving the tests to kernel selftests by importing the current
>> tst-filter test. The test is now named test_raw_filter and is substantially
>> updated to be more aligned with the kernel selftests, follow the coding
>> style, and simplify the validation of received CAN frames. We also include
>> documentation of the test design. The test verifies that the single filters
>> on raw CAN sockets work as expected.
>>
>> We intend to import more tests from can-tests and add additional test cases
>> in the future. The goal of moving the CAN selftests into the tree is to
>> align the tests more closely with the kernel, improve testing of CAN in
>> general, and to simplify running the tests automatically in the various
>> kernel CI systems.
>>
>> [1]: https://github.com/linux-can/can-tests
>>
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> 
> Thanks again.
> 
> I left a set of nitpicks, I expect to give my reviewed-by tag on the
> next version.

Thank you for your feedback. I'll post a new version with the changes
included soon.

[...]
>> +FIXTURE_SETUP(can_filters)
>> +{
>> +       struct sockaddr_can addr;
>> +       struct ifreq ifr;
>> +       int recv_own_msgs = 1;
>> +       int s, ret;
>> +
>> +       s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>> +       ASSERT_LT(0, s)
> 
> 0 is a valid fd (OK it is used for the stout, so your code will work,
> but the comparison still looks unnatural).
> 
> What about:
> 
>   ASSERT_NE(s, -1)
> 
> or:
> 
>   ASSERT_GE(s, 0)
> 
> ?
> 
> (same comment for the other ASSERT_LE)

I was a bit hesitant to change the order of expected and seen value for
the the assertions because it's documented as ASSERT_*(expected, seen).
But it seems to be common in the selftest to not follow this order where
assertions are used for error checking and failure message doesn't
explicitly say what was expected/seen. I'll take a look at the error
checking in the whole file where the more familiar form is with reversed
arguments.

Thanks,
   Felix


