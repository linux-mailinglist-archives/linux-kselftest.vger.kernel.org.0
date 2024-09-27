Return-Path: <linux-kselftest+bounces-18501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813B9889C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 19:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA01283145
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B61C1755;
	Fri, 27 Sep 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y67HVPvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7923B0;
	Fri, 27 Sep 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459402; cv=none; b=q8z1aa3T2c73yd6HD4NtHH+chmyGml9H9aWO9lOwWNuV+s6Fw1S+y1ef0gwsGD4DvkVc8G5Yb8nHONItxYZEjDrWxOeWhxX88O72XM7BERJ4Jbx0sXcNrPmdwXyOe26blDv88NpSK2P0SlW7dkIZrHrXUueN/0u+khxof2n7u2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459402; c=relaxed/simple;
	bh=OQ8UJ21YYnXWk8uGEtOeg4cUNizdeSHYo13CO6Dp/7c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=silTTQXtJjq59jAZSgMWPyJWwweEXsgjVF1CRH6wvOJfVkc91RPHHTjOI4t46UbdyeqgZ9OTsF0Avyg8jTkYeimSacqzs+TpqXIvsBIZ4VAtiRHH1pz3f7U2uMHTbv4q4o7XNsFCJOm9GDoXH1YdCweRaXfuhc5VM+zfAwfrS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y67HVPvl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48RHmuBk1788498
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 27 Sep 2024 10:48:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48RHmuBk1788498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1727459337;
	bh=SF0FL9WmYDEbaKMO13C88v3yLZ0MrWkzlusCVl5FVsI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Y67HVPvl61EVkWatxnhOVeXKW63UykF8TU4cDEDQiKbePtlNSYbVPcCS7S1o7qRmW
	 ki644wA0aln7/r+v87u68bpGmD+gJ/XFRJKJrP2lvuXu2IkbCYXV8wReZwNVkJATHP
	 fv8LId0DEgqsrTbBisdaSSSwg/iEGOY7mz+Zw5EA5ttwpHkdZfOpefApYvzPdlNxU0
	 Kcerz93cj51dM7YRIk4YWSUMNUJ9bx2cTpxJKXy8J3kiE8gNmPf/uB48ITrEvtSZJX
	 bgR0btyYoKr9XBOBoeWKFWPg8KpyBiiMmKXHJSWil8jM0W79ajOOIfFEkfQt9keelb
	 vIPxGdpQNNGNg==
Message-ID: <208429ae-d9c5-4b73-86ff-a9b31e68f7eb@zytor.com>
Date: Fri, 27 Sep 2024 10:48:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
From: Xin Li <xin@zytor.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, Xin Li <xin3.li@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, shuah@kernel.org, vkuznets@redhat.com,
        peterz@infradead.org, ravi.v.shankar@intel.com
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-8-xin3.li@intel.com> <ZiJzFsoHR41Sd8lE@chao-email>
 <ZmoT0jaX_3Ww3Uzu@google.com>
 <feefa9d1-f266-414f-bb7b-b770ef0d8ec6@zytor.com>
 <ZuNJlzXntREQVb3n@google.com>
 <d65e62d2-ca64-4b29-8656-bb8411fe837d@zytor.com>
 <ZvQaNRhrsSJTYji3@google.com>
 <496a337d-a20d-4122-93a9-1520779c6d2d@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <496a337d-a20d-4122-93a9-1520779c6d2d@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> When FRED is advertised to a guest, KVM should allow FRED SSP MSRs
>>> accesses through disabling FRED SSP MSRs interception no matter whether
>>> supervisor shadow stacks are enabled or not.
>>
>> KVM doesn't necessarily need to disabling MSR interception, e.g. if 
>> the expectation
>> is that the guest will rarely/never access the MSRs when CET is 
>> unsupported, then
>> we're likely better off going with a trap-and-emulate model.  KVM 
>> needs to emulate
>> RDMSR and WRMSR no matter what, e.g. in case the guest triggers a 
>> WRMSR when KVM
>> is emulating, and so that userspace can get/set MSR values.
>>
>> And this means that yes, FRED virtualization needs to land after CET 
>> virtualization,
>> otherwise managing the conflicts/dependencies will be a nightmare.
>>

I still plan to send another iteration of the FRED patch set for review,
however I haven't seen your x86 KVM changes land into Linus' tree, it
will happen soon, right?

> 
> No argument.

