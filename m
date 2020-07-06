Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66821605A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGFUcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 16:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgGFUcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 16:32:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BBC061755
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 13:32:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so22032390otw.10
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYQOdCfTTkXILORVtgEAOSWFzdmimDz+yZgYtM4yZbE=;
        b=VQIIiHM2Ao/EeMWSJrjPlMGvUtC+rgPUY2bgc58R3cMyriGsceTf+Kx01YXOOZqIXw
         upAgmJV15tUFe0W76Yexn9k/dG/4xYzDYNQY1/AWWB0IKUmhfuOPDqcqX27aBowFgjbF
         1dY9tzGMkt2CdilQlzd3ue5U6A5kt1im4geNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYQOdCfTTkXILORVtgEAOSWFzdmimDz+yZgYtM4yZbE=;
        b=HwfYOCpwaYGThiylkCzS73GPAvT4C01sc/4ZwbVxNgP7LAdNdusaY38Kkfr48FxEzh
         NjQpZqjjA7pbSg0qpKIvTbH9GATUMlXAH6j5jq6boSvrKy9wPm+4k24Xwf56lqe4xUiX
         fFywN75H0MFqpwlWkXual1fbcqwf0LU3lZE6PiTMnD0eCXRQuyhYjlMhb8QYQdWD6aKP
         QbfTBnYdJnaBP2Xkx8mrX3Nl+xMlpNzb1irhCwTvk2QmKtObv3dGBjYmOTadcs+QS7Rh
         PveS5DV3tjPZML7DNLeU1BAalWXuwh0kXsN9VpBHlnB+8HaC7LjnJqeEXxGbu1sToXke
         c0TQ==
X-Gm-Message-State: AOAM531VIngP0txCOfcgVCnHFS8mbIJ3D7+sf62EJTuaNwhA7flUiCij
        y8iC6+34M1Kj4bTm7u8YYJpn0zO7Cbg=
X-Google-Smtp-Source: ABdhPJw6ob5Foy2BcLVulUulHHyB2XDn2hXJ0IJM3C9aaf5FcZHvP152UHhejq0INirO6Q1UySgibg==
X-Received: by 2002:a9d:24e6:: with SMTP id z93mr42571857ota.360.1594067534692;
        Mon, 06 Jul 2020 13:32:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t187sm5273105oib.45.2020.07.06.13.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 13:32:13 -0700 (PDT)
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
 <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
 <20200703012005.GA23276@xpf-desktop.sh.intel.com>
 <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <444c90ba-3ad3-6ce1-d83e-bb918856079f@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 14:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/6/20 2:12 PM, Shuah Khan wrote:
> On 7/2/20 7:20 PM, Pengfei Xu wrote:
>> Thanks a lot Jarkko and Shuah!
>>
>> BR.
>> Thanks!
>>
>> On 2020-07-02 at 15:32:49 -0600, Shuah Khan wrote:
>>> On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
>>>> On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
>>>>> Python 2 is no longer supported by the Python upstream project, so
>>>>> upgrade TPM2 tests to Python 3.
>>>>>
>>>>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
>>>>
>>>> I think that it's perfect now. Thank you.
>>>>
>>>> Also
>>>>
>>>> 1. I checked that scripts/checkpatch.pl did not report any errors.
>>>> 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
>>>> 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
>>>>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>
>>>> Shuah, I could pick this up after your PR (with my earlier fixes) lands
>>>> to mainline, and sort out possible merge conflicts if they uprise. Is
>>>> this fine by you?
>>>>
>>>
> 
> I started applying this and then passed.
> 
> Doesn't this test fail if python3 isn't installed? Do you have to
> support both versions?
> 

Never mind. Tested it on with python2. All is well. Applied to
linux-kselftest fixes for Linux 5.8-rc5

thanks,
-- Shuah
