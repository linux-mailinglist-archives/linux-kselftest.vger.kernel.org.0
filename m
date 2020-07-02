Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3740A212EE3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGBVcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jul 2020 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBVcv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jul 2020 17:32:51 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D1C08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jul 2020 14:32:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 95so14593429otw.10
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jul 2020 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nX3WtTCapftQZKi1J19LFFYw/FZoTJx9oV4zdav/HAM=;
        b=W2mEdExBm5gJieoP7Q/8ZwG9gCKaZ9p9eCzN2Y50mZ6jLZXzjMnev/SY9+Be2QR2Xw
         qHVXs3dixLkGGDEWHJh315caCWuWYCcAFzoTR5R4LdocDACPNuoIX5PMCLDg3jdEkhKg
         z073WidPDOU3/u3m9yl0jBb+t0OrTzGyiQBog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nX3WtTCapftQZKi1J19LFFYw/FZoTJx9oV4zdav/HAM=;
        b=NYrIMJWg2jXfQx79EdTD7Lsi1rGY8+EiaiAAh0rf+Yn4j8qVVuBte0bhRPLOr2dtnO
         rm0xoHbHf/CBNBiKfKM4idBU7fWi9dPyyBFAQPjr6MJ1c9kNmOIT1Xsg+8hOL4nK0fFi
         EOMxWofQF4Pfv0q0h3OXCdQQLCEjchIr+RwIE0FGC4CI5igZpJk6hAHUqia89rlW3e+S
         JCy7B0FDmvPxBncfzfTuD/ySWchPzwKuIeEpLG8NUUrU9XPKcBnqMeH1rxIkgiAxoJZM
         r+O/vLD4R5KGjFQACiHT7PBbqUpy6JFrB+hRgRmZ53TWUAg2TwLHtXpmXVSINDHUMwMU
         Xccw==
X-Gm-Message-State: AOAM532VsXUuLkIGA9JhLskhWuSjIfOdIhW1lytj6M/0YVSyHQ/Ax9pH
        9UGDDMou35Mmo7/uyc6rhFNjOg==
X-Google-Smtp-Source: ABdhPJzANdCeEB3WWTPYNmcant+VS0uiYdncD7z7qX7msKxD+29krliYFkcOZaYQbQgqgJYUp2Tpng==
X-Received: by 2002:a9d:32f7:: with SMTP id u110mr28817895otb.217.1593725571151;
        Thu, 02 Jul 2020 14:32:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a204sm3019240oii.34.2020.07.02.14.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 14:32:50 -0700 (PDT)
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
Date:   Thu, 2 Jul 2020 15:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702194435.GA28988@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
> On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
>> Python 2 is no longer supported by the Python upstream project, so
>> upgrade TPM2 tests to Python 3.
>>
>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> 
> I think that it's perfect now. Thank you.
> 
> Also
> 
> 1. I checked that scripts/checkpatch.pl did not report any errors.
> 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
> 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Shuah, I could pick this up after your PR (with my earlier fixes) lands
> to mainline, and sort out possible merge conflicts if they uprise. Is
> this fine by you?
> 

Yes. I will apply them as soon as PR clears and hopefully they can go
into rc5.

thanks,
-- Shuah

