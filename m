Return-Path: <linux-kselftest+bounces-2317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EB81BF6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3B92884F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F273185;
	Thu, 21 Dec 2023 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHOhvKkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8C73191
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba97708c38so3882639f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703189212; x=1703794012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGa4HpSCAJBcJua8zvNb9GizD8kC9hwlf6LmyFf2834=;
        b=eHOhvKkMMHruW2oVZHMyoKVz/8EMz03nFmzEgRaqLoBvCRJqd2bOKaO7+2xPf2Sicx
         bB5/CC3bbCRvyTdS6CXk72okbLWF41VNS5cydCkxXzmUoXBru4nqW6Px0L6feIYcjfll
         4OqUrfPtIE+MA0brx1PoDdtfPgCYxMCbCx8d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189212; x=1703794012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGa4HpSCAJBcJua8zvNb9GizD8kC9hwlf6LmyFf2834=;
        b=Zgk17nK4qWkea8an7otMyHq/VA9g3x0IhGUVWyTsuBbqd/6Q5E4xvTYicCBTRd4rPK
         Ca3uLdiHhAp9HKoFKBIte2i9ybibr3873nX1VlqZvi7IrZ1ijF9IigZk7slKcrHG0S5I
         oAhgs20CaN5S1JaE3yFIEMj8O9g3eQoxfr85CHSFIqOhJFlFWZCSyvZU0D5MLGoISBsQ
         JF/OqlZ+tudkOWvtglUu3CSa8Z+R1P8oFel1lLanzJZIQz+jTA1LE0fbgLy82aYniZsB
         rqev6aYDhWg5qzBQxI5KTKmRVWGrwGOFiUbcbrfNEsvbXVFJRONFA23WLsf8+PR2Ycl8
         4Ddg==
X-Gm-Message-State: AOJu0YxdTqTSJiC7SGBQymkNFeyL3c+BMA2gLX5yrRNjk6JFxiOb9JH8
	Y5asDm1TFiPMkmWEH+/ufw8Ks7WFXbJelg==
X-Google-Smtp-Source: AGHT+IHJ24hh8AzP+0pbrhZids11wF22fPSqTMJrtHmVYNgPU4p4flxDy/CRTNsy+T1bIzQ72rOreQ==
X-Received: by 2002:a5e:c642:0:b0:7b7:17c0:e19e with SMTP id s2-20020a5ec642000000b007b717c0e19emr583129ioo.0.1703189211933;
        Thu, 21 Dec 2023 12:06:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g7-20020a056602242700b007b457549001sm643626iob.36.2023.12.21.12.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:06:51 -0800 (PST)
Message-ID: <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
Date: Thu, 21 Dec 2023 13:06:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 12:39, Johannes Berg wrote:
>>
>> This patchset adds a couple of helpers for kunit as well as tests for
>> cfg80211 and mac80211 that use them.
> 
> I can take this through the wireless tree, but then I'd like to have
> ACKs from kunit folks for the kunit patches:
> 

We have run into conflicts in the past with the kunit tree. I take the
kunit patches through linux-kselftest tree. I do want to make sure there
are no conflicts. I don't mind taking these through my tree.


>>    kunit: add parameter generation macro using description from array
>>    kunit: add a convenience allocation wrapper for SKBs
>>
> 

Adding David and Brendan to the thread for their review.

thanks,
-- Shuah



