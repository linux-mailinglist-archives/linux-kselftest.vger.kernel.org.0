Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883367A321D
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjIPTRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjIPTQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 15:16:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95E186;
        Sat, 16 Sep 2023 12:16:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31ffc8ead75so97706f8f.0;
        Sat, 16 Sep 2023 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694891788; x=1695496588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwUo4LhXW6t1Gnv3Q0htjfrVL7zsllgauCJSS4C+aNg=;
        b=RzIY5wwqUA51SkVB0Z8HRNXXBmk+VBI78AVY8GSbre2vHGiFul9H21UgbL77gOg46F
         nGbgd9IpGteNTbcwLZMvLaLD9Zbiqt1ihTLQLxV4AhJ/kTiOcQX60INzUisy/ONfInB1
         5J+d+BaXxUWgdPUoGhfSLg+rg5vgf4xHxPyaz6ZiTPo9UN+etdoQFy9qMaSrRXRk9tvR
         /6tXWy5Kx6NNiaA47okOvl52wSUsGwVs2lLet+WJdtZTZ5YxizPo6skEHxhBLIqWM4jF
         D/9QFTlMhKZIOl2/zsdi5MMbZIZISGhKh2mx79L0nSAigx62sU/J1w9F1LnoKxGuzOnp
         DhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694891788; x=1695496588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwUo4LhXW6t1Gnv3Q0htjfrVL7zsllgauCJSS4C+aNg=;
        b=gzNTkUCUhurqDRHE5xrKhVbC8xXWI+NMrHdMoxVlwiFYhjHfOdnU0GCMiVpg7B+OTV
         p8vKaZtTIdvXEP1L0JCiaruuD4WXx6+YAWlJWsE0NWrMiMZx4Vh1WP7dYqUGcq6qavdk
         gmTTUUDlZBOQReRmxDmAOVRMJrMjN2RGgu2NLkyS+LhjdmWn8H7YlQwfaV5heHLV2Dfb
         WuuLCws0/lX/py1jb/qk+9yrtIJ9CN9j1uTMcHNTC9WtOh549XieoYfNi/SqANlm4XQt
         gdbc8Sck36CQhKUjaCqQQSkGLbQd0XtCHbJ2m93I3WJElm2Z4axQnw6CMSXgEykuz5pX
         rxEQ==
X-Gm-Message-State: AOJu0YxunZFsjxl6ZsSopHCMGAGE1BOW14T2d5li9TZZWiPc7+cMVxVE
        YlwUqsGIm+nv0RqwEWszR/U=
X-Google-Smtp-Source: AGHT+IFQvgWlTqJ+ytOsAKXGLEU/ChOtRbJNqGOsj29RBk91cgJULaEEW3Hth1jXthX00cPN+Zp19Q==
X-Received: by 2002:a05:6000:1f9c:b0:320:b1e:7e6c with SMTP id bw28-20020a0560001f9c00b003200b1e7e6cmr163143wrb.3.1694891788289;
        Sat, 16 Sep 2023 12:16:28 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b0031f82743e25sm7883184wro.67.2023.09.16.12.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 12:16:27 -0700 (PDT)
Message-ID: <f1c8d747-dcf6-a913-f6d5-37fdfe3e2be6@gmail.com>
Date:   Sat, 16 Sep 2023 23:16:26 +0400
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
 <96ed6e41-65ca-7410-e2d9-78bd18bdf844@gmail.com>
 <128d057c-0d60-418d-7129-093ea59b8870@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <128d057c-0d60-418d-7129-093ea59b8870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/23 22:25, Javier Carrasco wrote:
> Removing an unused variable is actually removing a blank line from a
> logical point of view. Is an extra patch not overkill considering that
> it cannot affect the code behavior?

Well, no, it is not, as the line is not blank (nothing except removing a 
blank line could be considered as blank line removal) :) And an extra 
patch is not an overkill in case if you are separating logical changes.

However, rules may vary from one subsystem to another, so it is up to 
Shuah to decide take this patch or not. My opinion is that such changes 
should be separated into different patches.

