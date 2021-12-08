Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1466946DE00
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 23:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhLHWKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 17:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhLHWKD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 17:10:03 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1485C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 14:06:31 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j21so3563329ila.5
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qgjw9+9lL3xAImaF5HZygUwNAxWz9liV5VfwAbG8uCY=;
        b=MWbxU3nAgs6ZlUx4tYXOELJZcOwF2SnWET+yXIKrCX65kEZtmOSyQCnLEYUeilNT7m
         ZEXecdERmWP6pyDmPOb3hgpWXSz5afwXSa9MVG4Om1rw5BDjcDQfq4RVxK3PGrIV3mXb
         IaZfTdk2CgX3Ollv/iXsuxUH4lcOsI9bYKuqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qgjw9+9lL3xAImaF5HZygUwNAxWz9liV5VfwAbG8uCY=;
        b=Tp/8arLuvvzNCFF8CzS1tyZntKPB0Ppl1qUnDbybzBep+lWpC9QmjcaSRsd3ozBxKr
         wg96wDQ0RlMxn17p4Akk4KvXdYoCYlgg3DJtDOpsj5/n1s1am925vTKvaipBhg4/RT+8
         DoJ5QeWj3CDCyWM9Ie8wJXPoiP6NVOHNiUn7/HV6f00Y5iE5S3Wq7TAeSmo837W/Abhp
         hraGINpeJqZ2mMwdQMRWK8oshFBO/EHDXSXx0f0ewRthhn242K0ntNaMBNEn7DGRxviI
         7SNERA7euLm/wUIrLOVz6pXzsyA3MaBPCvtTGTGYrDCm/E6CNidlO1EQsQivCGEyXsZW
         KSfA==
X-Gm-Message-State: AOAM532DJtIVD/bzc3O2Oy6KB9rexLxveNKFlc+F17MbplMytRbZ1wO1
        X7KOFSPmJJ2DQzXINh37OrzzdA==
X-Google-Smtp-Source: ABdhPJy54p0dG794taCZs5Slo3XmDWJqbp6em0OEz64G9t5tSEJdZS44LKPnAN2BvXgvhGjK9JtqNw==
X-Received: by 2002:a05:6e02:1090:: with SMTP id r16mr10336398ilj.208.1639001191140;
        Wed, 08 Dec 2021 14:06:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm2417986ilh.59.2021.12.08.14.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 14:06:30 -0800 (PST)
Subject: Re: [PATCH v3 3/3] kselftest: alsa: Use private alsa-lib
 configuration in mixer test
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211208211745.533603-1-broonie@kernel.org>
 <20211208211745.533603-4-broonie@kernel.org>
 <b76dd5e0-56ba-79f4-21c2-ac5455d7fd65@linuxfoundation.org>
 <YbEnPzSO0HKHd8uX@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <806397d0-894a-0f86-bf73-30deb3d3c0d5@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 15:06:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YbEnPzSO0HKHd8uX@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/8/21 2:44 PM, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 02:27:34PM -0700, Shuah Khan wrote:
> 
>>>    		}
>>>    	}
>>> +
>>> +	snd_config_delete(config);
>>>    }
>>>    /*
> 
>> This open comment at the end of the patch looks odd. Does this compile?
> 
> Yes, it's the start of the comment describing the next function, more
> complete context is:
> 
> 		}
> 
> 		snd_config_delete(config);
> 	}
> 
> 	/*
> 	 * Check that we can read the default value and it is valid. Write
> 	 * tests use the read value to restore the default.
> 	 */
> 	void test_ctl_get_value(struct ctl_data *ctl)
> 	{
> 

Yes my bad :)

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
