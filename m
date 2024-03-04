Return-Path: <linux-kselftest+bounces-5855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27360870B5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0EB20B3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100B7A711;
	Mon,  4 Mar 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fx6SWR4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED02E636
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583475; cv=none; b=GVONw4kiky6RwHjVAl8qvH/XXePi9Ssj8ouh6tqB9A4VWYPrSNl3eydfYYlSMvkW1F8PWB+2JsVy9WJwhQtrDdi58l2+m9YJCK1ku4PiRGwouj5cx7Ev9lkQcq5yN9OhaE6gMoj2E5XYDhb+8/eceE1HJT+c8OYNyp2mMCAnBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583475; c=relaxed/simple;
	bh=InLePziy+w7EsIrWLjImxPDq+19gpyA1+VGaRFRzyDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1RiamIrDfSLAnmqP31zuhbAYENSn44RMbG+MeSsXsFeT1Z3gj4cbtYRvnMSHXTBHihtRhHItU3GrNe1Krw5TNRU9Vv0K3juygSXKfgQDXW1USEObDeHFkLd0ItRbYd8rEpcUiKeH3QFeBAcqi6UlvncUVlQTDePrEX0UEL1loE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fx6SWR4z; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c495be1924so39747439f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709583473; x=1710188273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OGnlqSS1kDH9oWockEB3mGHxHlxI0+QQdTZLw4GbL0=;
        b=fx6SWR4zh9OkLbqFFysAja9qFCZQyEm/khCDXNW/WOscVfxsIaQCeV9ODLNi2xpSB5
         dBVpxrKF8j+RBPNP7tgsp2qc0k0fdYddCEu+96y5Xt2biusZ+tVOCy+XGdtuxCVCl+IH
         /UFjwSxcim1cp+QoSWEU7zcRRbO8m3mMTNzQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583473; x=1710188273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OGnlqSS1kDH9oWockEB3mGHxHlxI0+QQdTZLw4GbL0=;
        b=gSchHLzCfEOeughbQSwnJVZO8q/SEX1CkkrAItcyOvy11yqHIczRK0z9kh4E/Ke6b5
         tM+7faKgkgIDBJgHYefLEmTwoWzBdJVWPHDcEh6L5SId5nVlaSr1bbyypknpo2lPYghk
         421ZpEMoThUndnR5OANEtPrcQb7wxSd/hquWB98Qlp0LzkxCvKYdHJ9jY1l3FQDo7hwE
         ONGLGBp1qG3b9SpAzxfZifiIq+tlcIE06pYgrkCtbfy9+f0vFdivLgQxyHqSI5oq8P/t
         6m+7uw6SapMgCQfCMvzAeU8m9hZrpEvG5i4cuyHWoJTYRrWQ/zIn1dIeQQOg8glT69KZ
         UGNg==
X-Forwarded-Encrypted: i=1; AJvYcCWWNpKuNB79szXwaeeioZs43KIXckwR2XFGt1Jhwb2cGOesWxUTfkwpaV/HbsEG4V4BNEh4NnFVf/1Wx5BqDOLmcIsGTU6MREcSwsJI+HcN
X-Gm-Message-State: AOJu0YwlbJxoGwPWQj0Bgdbw02CY7zFdH8waEuiespPu9i5Yt7kS4YrE
	91piSM+7+Wvg/wYDKlNFe42g7RyVS7Zm/FP+AZ8AAIxcW6K0NN9ludex7l5p1ug=
X-Google-Smtp-Source: AGHT+IFCOzr4devM1c9VYw7YymWcLmFzcFEeqrjLWZV1a0vIUexdAt/0/HkFEs+J5NsbnASpH/KsfA==
X-Received: by 2002:a5e:8806:0:b0:7c8:4963:5bb4 with SMTP id l6-20020a5e8806000000b007c849635bb4mr4324564ioj.2.1709583472793;
        Mon, 04 Mar 2024 12:17:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q9-20020a02a309000000b00474f8b4ac47sm389631jai.143.2024.03.04.12.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:17:52 -0800 (PST)
Message-ID: <b8f6ba98-5683-4985-a8c4-53b36bc1090e@linuxfoundation.org>
Date: Mon, 4 Mar 2024 13:17:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample
 modules
Content-Language: en-US
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Laura Nao <laura.nao@collabora.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, kernel@collabora.com, kernel@valentinobst.de,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, sergio.collado@gmail.com,
 shuah@kernel.org, usama.anjum@collabora.com, wedsonaf@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240229155235.263157-1-laura.nao@collabora.com>
 <20240301152232.122399-1-laura.nao@collabora.com>
 <CANiq72nMo72ObJaQ=Eki4E6t5dMOnF+xmHE1Z2Tn3=33ooSYGA@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72nMo72ObJaQ=Eki4E6t5dMOnF+xmHE1Z2Tn3=33ooSYGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/1/24 09:28, Miguel Ojeda wrote:
> On Fri, Mar 1, 2024 at 4:22 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> Adding --first-time (you meant --first-time, right?) definitely makes
>> sense, thanks for the pointer. I think having the modules being built-in
>> should be treated as a skip, same as when they are not there at all.
> 
> Yeah, I meant `--first-time`, sorry.
> 
> I didn't see other tests using it, so I am not sure if there is a
> reason not to do that (ditto for adding `MODULES` etc. to `config` and
> whether we should fail/skip in certain cases) -- I guess Shuah will
> let us know.
> 
>> So something like this:
>>
>>   for sample in "${rust_sample_modules[@]}"; do
>> -    if ! /sbin/modprobe -n -q "$sample"; then
>> +    if ! /sbin/modprobe -n -q --first-time "$sample"; then
>>           ktap_skip_all "module $sample is not found in /lib/modules/$(uname -r)"
>>           exit "$KSFT_SKIP"
>>       fi
>>
>> will cover both cases.
> 
> What about the other calls to `modprobe`?
> 
>> I think it's safe to assume no other module will depend on the sample
>> rust modules, so is there any other reason unloading the modules
>> might fail apart from MODULE_UNLOAD not being enabled? If not, then I
> 
> I was thinking more in general terms: that we would like to catch if
> unloading does not work as expected.
> 
> Especially since these "simple samples" are, in part, testing that the
> basic infrastructure for Rust modules works. So I would say it is
> important to check whether module unloading failed.
> 
> For instance, if something is very broken, a Rust module could in
> principle fail unloading even if `MODULE_UNLOAD=y` and even if C
> modules unload without issue.
> 
>> I can't just simply skip all tests like this though:
>>
>>   for sample in "${rust_sample_modules[@]}"; do
>>       if /sbin/modprobe -q "$sample"; then
>> -        /sbin/modprobe -q -r "$sample"
>> +        if ! /sbin/modprobe -q -r "$sample"; then
>> +            ktap_skip_all "Failed to unload module $sample, please enable CONFIG_MODULE_UNLOAD"
>> +            exit "$KSFT_SKIP"
>> +        fi
>>           ktap_test_pass "$sample"
>>       else
>>           ktap_test_fail "$sample"
>>
>> as the test plan has already been printed by then.
>> I'll need to rework the script a bit to skip the test upon errors on
>> module removal.
> 
> Perhaps Shuah prefers to merge this before and then improve it instead
> -- I don't know. I didn't mean to trigger a rework :)
> 
> Especially since it is unclear what is the "pattern" to follow here --
> perhaps this is another case of a wider cleanup for more tests, like
> the ktap helpers I suggested (thanks for implementing those by the
> way!).
> 
>> If we need more granularity on the feedback provided to the user (i.e.
>> indication on what particular options are missing), then I guess we
>> could check the current kernel config (/proc/config.gz) and skip the
>> entire test if any required config is missing. However, this adds an
>> extra dependency on CONFIG_IKCONFIG=y and CONFIG_IKCONFIG_PROC=y.
>>
>> Any advice on the best approach here?
> 
> I guess this also depends on what tests are supposed to do etc., so
> let's see what Shuah says.

Kselftest should all the tests it can run and skip only the ones it can't
run if configuration and other dependencies aren't met. The reason is to
avoid false failures.

> 
>> Kselftest exit codes are predefined
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v6.8-rc6#n74),
>> so if we use `set -e` and source a missing file we end up returning "1"
>> as if the test was run and failed. With this check we're sure to return
>> a value that makes sense in the event the helpers file ever gets moved.
> 
> Yeah, definitely. I was thinking here about just failing if something
> does not work as expected, i.e. speaking more generally (that is why I
> also mentioned even other languages).
> 
> By "failing" here I didn't mean reporting the test as failing; I see
> it as something in the layer above. That is, if the helpers file is
> ever moved or is not installed for whatever reason, then it is the
> test infrastructure that failed. So I would have expected that "skip"
> is due to a reason related to the test itself rather than something
> unexpected related to the infrastructure, but I guess it may be part
> of the "skip" meaning in kselftests. So it depends on what is supposed
> to mean in kselftests, which I don't know.
> 

I applied this to linux-kselftest next for Linux 6.9-rc1.

We can make improvements if any on top of this.

thanks,
-- Shuah


