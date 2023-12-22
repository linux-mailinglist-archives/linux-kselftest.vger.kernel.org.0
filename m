Return-Path: <linux-kselftest+bounces-2375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E681CC5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8F8284EA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC3241E1;
	Fri, 22 Dec 2023 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uo8dPi2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3623773
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ba7d17184eso25463939f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703259896; x=1703864696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXQ5ruPdQGz0FxEc4VQftgyACjxSYs+R3MRtDa3PYdQ=;
        b=Uo8dPi2uh0dCzDQ/wndqoOBFPthgXNft/DBYYKc3oABgrMkDK3P9Na7U4xEl3rphpl
         H74Qor50FVjyKAzovf5QV5BLsv5KyeXgxkpF0LFrqTs1INI9lX1zNZGAwnJ3jHpRW4xl
         RMcX5ryESHT1XjfHsWHUaWoAA7gBI5edzGcRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703259896; x=1703864696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXQ5ruPdQGz0FxEc4VQftgyACjxSYs+R3MRtDa3PYdQ=;
        b=MQp2zL3qgo3f0hxfMCWJ6YDHaFGVwuHbnn3Vc8HlXm6iWTS8Ca8X9UBb7rXbrrYyYi
         Iyc1YkOK1ihkIxDoAmeh4j3hNF4AVlJNHrxME1RKsT16oviNfD2wCBOdFtgpgCt3vsZu
         Oc2KaRl/mf9uYcXx15Eh8sFY3oWwa/p+yDU0u8GKwGuprUURHHrkKs/3kcXinAN0t6Zn
         8NYRZFpoZ+lgCWvaUY1ElHiZsHDkdd9GTk67b71N/PnMDjfO8P12S3qY/fc7Fvwo1l1W
         IycH/OArxb3ajN2fZ/QEwyns/eF5A0EGM/SIReAjM09oAfigXF4Yc5zC4dYceb5GlJj3
         K6Iw==
X-Gm-Message-State: AOJu0YzwI6qb4uB0DRsoThLxc6DOgWh2urLX5ZZ2o5982/oy1cESqWRz
	Gl1af2cf8vxnZb4FPMp9CB4zN8IaNinGRA==
X-Google-Smtp-Source: AGHT+IGLGb0ISJXQz58vNsU5qpta2AqSTq8k5w2LR241NJ0NPjGcD4VGem3eH526/o4NhSF0+mFd5w==
X-Received: by 2002:a05:6e02:1d13:b0:35f:da7a:3797 with SMTP id i19-20020a056e021d1300b0035fda7a3797mr2942095ila.1.1703259895951;
        Fri, 22 Dec 2023 07:44:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056e02331100b0035ab8cc4a4bsm39804ilb.17.2023.12.22.07.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:44:55 -0800 (PST)
Message-ID: <5fbe73a4-f954-4a0b-bc07-2a8de7f0c4b1@linuxfoundation.org>
Date: Fri, 22 Dec 2023 08:44:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
To: Johannes Berg <johannes@sipsolutions.net>, David Gow <davidgow@google.com>
Cc: benjamin@sipsolutions.net, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
 <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
 <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
 <CABVgOSkrhEYXvzjtWfdxmKVGZwGnJTKwbd9+kBSRWxbOfyaRUA@mail.gmail.com>
 <2a508793563c46116ef8ef274a9fa3b5675cd7b3.camel@sipsolutions.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2a508793563c46116ef8ef274a9fa3b5675cd7b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/23 03:09, Johannes Berg wrote:
> Hi,
> 
> Thanks for taking a look!
> 
> On Fri, 2023-12-22 at 18:02 +0800, David Gow wrote:
>> The two initial KUnit patches look fine, modulo a couple of minor docs
>> issues and checkpatch warnings.
> 
> I can run checkpatch (even if I can't always take it seriously), but do
> you want to comment more specifically wrt. the docs?
> 
>> They apply cleanly, and I doubt
>> there's much chance of there being a merge conflict for 6.8 -- there
>> are no other changes to the parameterised test macros, and the skb
>> stuff is in its own file.
> 
> Right.
> 
>> The remaining patches don't apply on top of the kunit branch as-is.
> 
> Oh, OK. That makes some sense though, we've had a number of changes in
> the stack this cycle before. I somehow thought the tests were likely
> standalone, but apparently not.
> 
>> I
>> haven't had a chance to review them properly yet; the initial glance I
>> had didn't show any serious issues (though I think checkpatch
>> suggested some things to 'check').
> 
> I can check.
> 
>> So (once those small issues are finished), I'm okay with the first two
>> patches going in via either tree. The remaining ones are probably best
>> done via the wireless tree, as they seem to depend on some existing
>> patches there, so maybe it makes sense to push everything via
>> wireless.
> 
> If not through wireless I doubt we'll get it synchronized for 6.8,
> though of course it's also not needed for 6.8 to have the extra unit
> tests :)
> 
> I'll let Shuah decide.
> 


Thank you David for the reviews.


johannes, Please take these through wireless - makes it easier for all
of us.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


