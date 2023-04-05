Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5126D87A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDEUER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDEUEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 16:04:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935561992;
        Wed,  5 Apr 2023 13:04:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-947a47eb908so60199566b.0;
        Wed, 05 Apr 2023 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680725053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qeq6stMWdZs3jAUdnCyOnUHBvyNDWCT5pxImRBQv33k=;
        b=KET6742x9iuXrTvQHP+9XK877ik/eAXlu0GgrNDUy5OJP5KaeaPCw5EHWZxDyJ0oYw
         ob3oNdeKlGSQUa7yt319+ZRqViaRmXMKPm83JrwOi/I1ZIBRIPSJ4FiO8HBjXgP56M+s
         lssJBYiRCxI2h7RHMbkoVWsqGj1MMfn1zv5IDzQIqNFq2I0Gsu9C4fMdbbXIOYPvemDY
         ng7u9apnNlD2rpdIHz8CrIJJlsObZ7kdMIbAgLSuPpQPVY7Kwjru3ctvWsnRuk7LQF0f
         cxwzSRXTs1Yt3/ISEGo6OZFkMvgw9xSA9AjH5CjFnd3K55xhaqoJFwDnIuDBCU/VZc6I
         eOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qeq6stMWdZs3jAUdnCyOnUHBvyNDWCT5pxImRBQv33k=;
        b=nC5v7qsGvn8bmWpaHUq+pcDd1IzYqno18Co4XDSvInkTaeQTUXFCEGt8inEcGZUfnf
         8Tes/qJoeDShuvH/KIwcSMCX4my0y4zHSpPcAeQYcc8wbiGURhgF+3/iiFmzuKhA0hEf
         tFWwLul2t7FC6zJs47DYMCvIPXm/J3qrhjSXP6QWZ+Iji4n0dGVY7p/n36Lht89A4nNw
         t2FizVAHRYLT7MPNPZTPVsoi+RVP6vrckrYFwoF9i/h8qXTx+55iZCfm2oxv8noLE4TE
         lb7HL9/jY06TDqt2kia8ZrNjrKboikz4w9K8FuboDJfrvcILgqekv6A+0Pug/3ozW+VR
         ZaMg==
X-Gm-Message-State: AAQBX9dmnfczaNSU9LyrYJ08RpBVZgDnw8xE8OI1GjjAkxQzTEWe2cDs
        RGjN6x1jY6NY8T0n2PIfaFQ=
X-Google-Smtp-Source: AKy350ZPXeb5mCV8txycSZmCPdPT9yLoGy/tXpowsiDeHt81VCxgync7lPxUrUkGb634mIJ/k+UEqA==
X-Received: by 2002:a17:906:5195:b0:92c:fc0:b229 with SMTP id y21-20020a170906519500b0092c0fc0b229mr3275187ejk.0.1680725052955;
        Wed, 05 Apr 2023 13:04:12 -0700 (PDT)
Received: from [192.168.10.16] ([37.252.92.225])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004ad601533a3sm7750604edf.55.2023.04.05.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 13:04:12 -0700 (PDT)
Message-ID: <63569398-5487-92e4-3c80-48b11f3fb097@gmail.com>
Date:   Thu, 6 Apr 2023 00:04:11 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] selftests: media_tests: Add new subtest to
 video_device_test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230401092207.16667-1-ivan.orlov0322@gmail.com>
 <8038b636-7275-4f44-0b1f-df4190b94a40@linuxfoundation.org>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <8038b636-7275-4f44-0b1f-df4190b94a40@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/5/23 23:03, Shuah Khan wrote:
> Leave this text here so it is easy to spot. There is no need to move this
> down.
> 

> Otherwise looks good to me.
> 
> thanks,
> -- Shuah

Thank you for the review! I'll send the v2 with the mentioned changes.
