Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B177E691
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbjHPQh4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbjHPQhx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 12:37:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B624273C
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:37:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748ca56133so87935639f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692203827; x=1692808627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4xPqQ4cB/nix/cN2wGNqZZb13mJi3CPHo+Hwyx7CVA=;
        b=fiSMl01S0UOqTZysWCfVoTPP/nM3YQmzbHtZdEXTI+aTM3vaDGA6e5pJJoOswd6jGD
         E9zF0XBR18+FJqo5N3/o7jkkUKCTgvnIYEmFBhFatfmrwY4kTHz00KAnddikvTrFnTsQ
         2W5bbudBsymd1BUpKKTy5ClOooK6olcdZCgyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203827; x=1692808627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4xPqQ4cB/nix/cN2wGNqZZb13mJi3CPHo+Hwyx7CVA=;
        b=YNrYZsod5OHUOypH3PkE6KFt9Npfst89CwpsgE6CCQGyQJMxVbZQT7hZ34jyaurV+L
         Dd3Ba5cmvk3cxY2Un/xxJlomT8c1z4TmLWvab71ZAaaBQAh7iAVGen+okULu5DL2vhWN
         ybh/5/DajAs+Gk+M3i6pgmbiZtunUt3KTCsCrKU0teoglwpDiG2hsk+IjUZc47bBS00x
         geAfbSyLPTkreE15lJl2wYMr1aWHUc8EbDPaBKB7+sKU1ZjacS5mUCMv4Q8zdRnLLmeO
         HEuya05G2i9EmjI1Ie1BqlbC8jy4XnNJjNWpO8qr5Unll1/WkiLM+m1JV2JWkI3rqlVf
         lkHA==
X-Gm-Message-State: AOJu0YyiIxLmiaVlB2qX7M5sDThQs3vAkkKDJ8D6JXgV54Qe5JeuQ0eE
        aNaDUwJ/3UTUW4NaUZjmkiQ4WA==
X-Google-Smtp-Source: AGHT+IHp/TbXPplVnNYznnj1iqoVtmSrLU9Wek2gKzZHKOR17WkTWXKjEVjKBOYNtszoNEMyLmqDGA==
X-Received: by 2002:a05:6602:29c5:b0:787:16ec:2699 with SMTP id z5-20020a05660229c500b0078716ec2699mr4660666ioq.2.1692203827439;
        Wed, 16 Aug 2023 09:37:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f7-20020a02cac7000000b00418a5e0e93esm4370750jap.162.2023.08.16.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:37:07 -0700 (PDT)
Message-ID: <4cf3cb55-9fe3-9fd9-3238-0e4153e3d77d@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 10:37:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/user_events: Reenable build
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230806-kselftest-user-events-v1-1-9c5b368bd062@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230806-kselftest-user-events-v1-1-9c5b368bd062@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/6/23 05:29, Mark Brown wrote:
> The user_events selftests were removed from the standard set of
> selftests due to the uapi header it relies on having been temporarily
> removed.  That header is now reinstated so we can reenable the tests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.6-rc1

thanks,
-- Shuah
