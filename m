Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98A07A31CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIPSFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIPSFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 14:05:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD340180;
        Sat, 16 Sep 2023 11:05:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40471c054f9so8712985e9.0;
        Sat, 16 Sep 2023 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694887532; x=1695492332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVbOZtDmbMexD/9gCiyvbGFst0WQ8c5NS6OBdsiTSoQ=;
        b=gUA+buxc3rFn4d4y5lN7MnQGr2pyRdGRjlh4Yilr7wbmfe8LTeeht7fQTKtQG3jXcC
         XUzON4a4FbJqiAW/CubmFD+LKQZEUZu4NcSo7nD4uudAwpWTjondfrSo1LBUIcRT51Tc
         BRFE8JzG9Y2Oq6xncCvJa1uXzWaMZLTYxBb+nykA6mM3kvpXoOWQK+Kfn5G9YY5djugT
         EbE3/uGDYAudFUp8dVObtjXJLdldjKwGZbK4sn8hGjFItraRVDfr6SUPpmrayJdXJpOs
         czkg9zeejhhX2OQBzRlSbdRPIYxI7qysBJ25kfW3keOJ86ySQHhTKiUCev4BIrVpf10t
         q+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694887532; x=1695492332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVbOZtDmbMexD/9gCiyvbGFst0WQ8c5NS6OBdsiTSoQ=;
        b=Csuu3oD9wzt1sG/hrwxyXPJIDR9JkzTCWFYhcgqanLgSeNLWlaXC8s3Fw17nUQofR6
         3xZmfLyDDUnfurVRxRoMjP8QySho2whMz4NbNmecKiCleXzr5OHJ0v9zVslB8liulJjA
         T/K45oohMj6BtFD18ihPM5x9GyGyV98g6CeFwgT2oXYn659y1F3qQL91FyV1tsCcCN/z
         MdqQyXLqWDjWQDBdZq0/O9c37mRnDQAbEIwrhENoYwpz1uBqcVfuHKLRgwlu61zecUrY
         FwWQDvPbKiMYNIpdzcVcxPt285cYZzxKARzOUCymkJu0Ex/sEN93Nl3THfmBkjCVb+vo
         wGtg==
X-Gm-Message-State: AOJu0YzA8FBdNASokITNdu0lop+9xbs+V+dxG8YGHu8I9JrBVQGTxOoo
        nuGWvUNMGE3KuWRzKrhih78Pc2nvO40=
X-Google-Smtp-Source: AGHT+IGyzH2yu/6hUHOmL8w1dZVsxgoKTJgQ/SNo/4Bvb7BjabOw8CQtwW8w8VFC81JIqrYXFuDoiQ==
X-Received: by 2002:a05:600c:500c:b0:401:b53e:6c3e with SMTP id n12-20020a05600c500c00b00401b53e6c3emr4671065wmr.1.1694887531817;
        Sat, 16 Sep 2023 11:05:31 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b00402be2666bcsm10732150wmc.6.2023.09.16.11.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 11:05:31 -0700 (PDT)
Message-ID: <96ed6e41-65ca-7410-e2d9-78bd18bdf844@gmail.com>
Date:   Sat, 16 Sep 2023 22:05:29 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: ALSA: fix warnings in 'test-pcmtest-driver'
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230916-topic-pcmtest_warnings-v1-1-2422091212f5@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230916-topic-pcmtest_warnings-v1-1-2422091212f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/23 19:22, Javier Carrasco wrote:
> Defining the 'len' variable inside the 'patten_buf' as unsigned
> makes it more consistent with its actual meaning and the rest of the
> size variables in the test. Moreover, this removes an implicit
> conversion in the fscanf function call.
>

Considering the fact that the pattern buffer length can't be negative or 
larger that 4096, I really don't think that it is a necessary change.

> Additionally, remove the unused variable 'it' from the reset_ioctl test.
> 

Your patches should always contain only one logical change. If you, for 
instance, remove redundant blank lines, combining it with something else 
is fine, but otherwise you should split the changes up.

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Defining the 'len' variable inside the 'patten_buf' as unsigned
> makes it more consistent with its actual meaning and the rest of the
> size variables in the test. Moreover, this removes an implicit
> conversion in the fscanf function call.
> 
> Additionally, remove the unused variable 'it' from the reset_ioctl test.

You don't need this text here. Usually it is the place for changelog 
between patch versions if we have more than one version of the patch. 
For instance, if you send a patch V2, it could look like this:

Signed-off-by: ...
---
V1 -> V2:
- Improve something
- Add something

So, don't repeat the commit message here :)

Anyway, great job! I believe this test could be enhanced in lots of 
ways, so I look forward to seeing new patches related to it from you :)

--
Kind regards,
Ivan Orlov
