Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1849A50E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409005AbiAYAYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2363520AbiAXXop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 18:44:45 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27480C05A1A9
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:39:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id i62so5591711ioa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miK1i3WfUZ/zC0iIHbC+wfEts2sC7sUvfuUTymhU924=;
        b=W29qFN81nHINhsa8HGG/ofvd0j6LLSMvIuN3bSyHTkSLB3i2JG7lJ4gzujzeDT6v9e
         9l+i5B8/GvWDHnBsiwF2YX+V+PVyNRj0cb1iIHwSiTw5g8NAaot30whqBY+6tybjslpN
         IU27hTPdFNgyALLH5OJfWyl+zE6SEAd/tMcSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miK1i3WfUZ/zC0iIHbC+wfEts2sC7sUvfuUTymhU924=;
        b=pN3uT3A5m3vq2pv0k/uSX9zbutIhzhUFgvVSR2RXDiMwRDLWHR6rqQeHH6b/3UAMLJ
         hY/YNl/yr+59pFhTJChuHhZZoAhRa1uA9i4WI1fKcg+E7eF0mbqlsp2jn5SCV0rOewRm
         0llS81uCdz2ET3dTJEgztVhgaIZ1aulvFoBadDjj4bdfSPC0bv6CIsuiKD5Qg7KCjPso
         sZ3GUl4RRIYDnkXg7Exr1sqUX2nxBiPVnvdPCrDD03YUSG6uo4G2UkaF8lpL9psidGbH
         aFdVr3Ih/A/PPuycytTTvffbpnu7jB8A/YSAT8f7NzDVC6p3qgCDrNrdct+DHwZ6Y3ra
         B1ow==
X-Gm-Message-State: AOAM533UXKjGy7fHP1FRHaRJcRfqAYbwaDjBdNB3a3V7Mft3KbdpQUoj
        +M/dVusPcM2WyDbGJ35CkDqsTSNw69kR4g==
X-Google-Smtp-Source: ABdhPJwbnAGL0F40XO6llfuXLPsSa84sORLI4fBDtde/A/Edb/tqzjgHGaQZfPTBunCQoERPrywVMA==
X-Received: by 2002:a02:606a:: with SMTP id d42mr8254497jaf.5.1643060375543;
        Mon, 24 Jan 2022 13:39:35 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id u8sm7753467ilk.65.2022.01.24.13.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:39:35 -0800 (PST)
Subject: Re: [PATCH v1 1/2] kselftest/arm64: Skip VL_INHERIT tests for
 unsupported vector types
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
 <20220124175527.3260234-2-broonie@kernel.org>
 <e9849218-24aa-cccb-21c4-a0467cffd4fb@linuxfoundation.org>
 <Ye8bKVurkVbhhEgz@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6a3032de-1a13-b25f-a33f-fb2d7a5777b7@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 14:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ye8bKVurkVbhhEgz@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 2:33 PM, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 02:27:07PM -0700, Shuah Khan wrote:
>> On 1/24/22 10:55 AM, Mark Brown wrote:
> 
>>> -		ptrace_set_get_inherit(child, &vec_types[i]);
>>> +		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
>>> +			ptrace_set_get_inherit(child, &vec_types[i]);
>>> +		} else {
>>> +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT set\n",
>>> +					      vec_types[i].name);
>>> +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT cleared\n",
>>> +					      vec_types[i].name);
> 
>> These messages are a bit confusing. Are we skipping two tests?
> 
> ptrace_set_get_inherit() logs two test results (one for set, one for get).
> 

Ah okay.

>> These messages can be combined into one like this one on lin 572:
> 
>> ksft_test_result_skip("%s get/set VL %d\n", vec_types[i].name, vl);
> 
> If we do that then the number of planned tests won't line up with the
> number of expected tests.
> 

Sounds good. Assuming this is going through ARM tree?

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
