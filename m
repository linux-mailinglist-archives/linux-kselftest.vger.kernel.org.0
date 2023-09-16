Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892057A31E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbjIPS0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjIPSZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 14:25:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659CCE3;
        Sat, 16 Sep 2023 11:25:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31ff7535aa6so1430070f8f.0;
        Sat, 16 Sep 2023 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694888731; x=1695493531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckuQZ1CawEUL97pJvhzualqoX+UXSrLJZVGT08Xyrcg=;
        b=BbCX2VhYG9B8HSer6l1IVjMhGr6y2/egGTnN+V8rgzpVCYxzkIx+WJ1xdNsZZBiUps
         A2lXF2BT1PBq0jyvsT3asBMgIz82KCuOIFQaqiMoU0fN6ZC7lJE7X8DTEyI4m2xQ4Aea
         CX4BiaUEtDpuhWVd3EUmr/D8omfIdxqo4IrnQk0Y/aPgYrfyb4uFqsbkcG8KUHDy4hFY
         rx1PHt6pTQpPGpgnmQfdOBUk8RJURIp8c3PxHyp3SrG15qpA1WxnIhZHURLFZFrY1Z8Z
         WRP5M9+YompcHfNBAdqI+maXPb2LAT9iJr393DNGfPnnIyEuap42JyKYEoJQmbwhA/lx
         6yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694888731; x=1695493531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckuQZ1CawEUL97pJvhzualqoX+UXSrLJZVGT08Xyrcg=;
        b=rZlSAM65Ber6wpKDSi/qMAQMoIxukuJrIPjBnWAIS8oCZsHg9nL3j1kvd9v3xpGoFl
         KDQIGNeclhFl0CopiqxSGgfEqewM7SoYhtP8gUQtOo64iP13pQiVCjtNC+9yD0PFPprd
         a+NQp/dLlKwvD5HHe6OQetuu75JJoPa3vH626Y5dt/Z9dLYeTgjKEdqRLgrup8lkqOE1
         ySsaEGiIuNBHaPcqe8PvSmYRqFVzkXPcKzCFPaz9P6e/OkjsQM8OInLDl5jXAlVwkc4s
         uZ0P60GCIdYR7Y+yjLzZZD/KqhBMWJwqh7QdQjsZpzuZAo1e51ebtwjKQLMEFf7FQmwV
         1sDw==
X-Gm-Message-State: AOJu0Yz++ng2Kq5aaIpOsUF9i8XTG9bFvIDygnEIqfAWgwCcoyhPtjJ5
        hgXDND1lmuh0uneQQ9OCk+Y=
X-Google-Smtp-Source: AGHT+IGVa+XIIFY8QmJ67pNTWSWASvWz2SosTfH23zEiYYZcAQR/VAmKZuHIVUDpULlmkx9mYLv2Ow==
X-Received: by 2002:adf:dccc:0:b0:31a:ea86:cbb8 with SMTP id x12-20020adfdccc000000b0031aea86cbb8mr3704433wrm.2.1694888730582;
        Sat, 16 Sep 2023 11:25:30 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41b4:ce80:33dd:a87e:3888:429c? (2a02-8389-41b4-ce80-33dd-a87e-3888-429c.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:33dd:a87e:3888:429c])
        by smtp.gmail.com with ESMTPSA id v16-20020aa7d9d0000000b0052f3471ccf6sm3791715eds.6.2023.09.16.11.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 11:25:29 -0700 (PDT)
Message-ID: <128d057c-0d60-418d-7129-093ea59b8870@gmail.com>
Date:   Sat, 16 Sep 2023 20:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: ALSA: fix warnings in 'test-pcmtest-driver'
To:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230916-topic-pcmtest_warnings-v1-1-2422091212f5@gmail.com>
 <96ed6e41-65ca-7410-e2d9-78bd18bdf844@gmail.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <96ed6e41-65ca-7410-e2d9-78bd18bdf844@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ivan,

On 16.09.23 20:05, Ivan Orlov wrote:
> On 9/16/23 19:22, Javier Carrasco wrote:
>> Defining the 'len' variable inside the 'patten_buf' as unsigned
>> makes it more consistent with its actual meaning and the rest of the
>> size variables in the test. Moreover, this removes an implicit
>> conversion in the fscanf function call.
>>
> 
> Considering the fact that the pattern buffer length can't be negative or
> larger that 4096, I really don't think that it is a necessary change.
> 

>> Additionally, remove the unused variable 'it' from the reset_ioctl test.
>>
> 
> Your patches should always contain only one logical change. If you, for
> instance, remove redundant blank lines, combining it with something else
> is fine, but otherwise you should split the changes up.
>
Removing an unused variable is actually removing a blank line from a
logical point of view. Is an extra patch not overkill considering that
it cannot affect the code behavior?
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> Defining the 'len' variable inside the 'patten_buf' as unsigned
>> makes it more consistent with its actual meaning and the rest of the
>> size variables in the test. Moreover, this removes an implicit
>> conversion in the fscanf function call.
>>
>> Additionally, remove the unused variable 'it' from the reset_ioctl test.
> 
> You don't need this text here. Usually it is the place for changelog
> between patch versions if we have more than one version of the patch.
> For instance, if you send a patch V2, it could look like this:
> 
Sorry, this got merged from the cover letter by b4. I will be more
careful next time, thanks!
> Signed-off-by: ...
> ---
> V1 -> V2:
> - Improve something
> - Add something
> 
> So, don't repeat the commit message here :)
> 
> Anyway, great job! I believe this test could be enhanced in lots of
> ways, so I look forward to seeing new patches related to it from you :)
> 
> -- 
> Kind regards,
> Ivan Orlov
Thanks for your feedback and best regards,
Javier Carrasco
