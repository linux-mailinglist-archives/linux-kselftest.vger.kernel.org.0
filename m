Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2D4B1359
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiBJQqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 11:46:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiBJQqH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 11:46:07 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C190
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:46:03 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h11so4799178ilq.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DDtHBrYV020bBGjtIYRFzMtZ1rUWWBBixnBxzXJeFHg=;
        b=b6JQx2r2RiP/MMxSjrD6RoqNR1f8sgY/J8ogD1k5zuepBjN9K4EpBTF4U3DnkeWghn
         OiqY/c+ldn1HMMXxr57ZqhnHntCkvLwMwdaoBNgntrz9ZtxNLhNEmUo3JG7R+L6XMQxb
         0v7lJ4uHDLla/82flidGVeDfm9T2y7xdlc+iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDtHBrYV020bBGjtIYRFzMtZ1rUWWBBixnBxzXJeFHg=;
        b=keEP6xOkACdCitJahUwqhRskIuoNNOdi07HhuDOiEnfcfTb9hwwZdJljzT1ltFS9/Y
         LWnPJuZhGHQc+GCj2X04e2XMG5HaY8LV0ldDt+hKeuAy+nnelBwkpNrUtkiC57ghgNCM
         XfmcJ5ndS/+iwkGbS5cnmc4yAzXbpfWiwwzoVeJLFBH9Mjbx6bqOLT/HFBg173ba6AcW
         8cbRuv54AC429Nh+iU6HnKsIUHUPwoM9eRew1uda7ZCgGVKJ7wSWjmFpv+5M9lgJscrx
         51kyvr/rGB0fzSCjYpL1V0iGrjUbe/iFiQGQd3lx/6iN45G2NOv6yYRqZYERgWEy+Rqx
         jbRg==
X-Gm-Message-State: AOAM531uCtQQVYNEMA+C2CyGo8vKCaepFeaxf5KkSy+B7+ypprHI9kX8
        p/iHPutzrkCY8elqSvdc6306kA==
X-Google-Smtp-Source: ABdhPJwBlZn/97+3CiBD8ZcFr5rKXnOkyTzDg+cp7L6qXTI403VmIgvZfUlQKv423UjT5i7Ow2M58Q==
X-Received: by 2002:a05:6e02:1544:: with SMTP id j4mr4346609ilu.77.1644511563158;
        Thu, 10 Feb 2022 08:46:03 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d2sm4037645iog.42.2022.02.10.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:46:02 -0800 (PST)
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
 <YgKQTLwW+ha5XNx8@sirena.org.uk> <YgK4kKrSs6e9seG8@sirena.org.uk>
 <e6d76104-b7f6-1588-d734-1a09c2990299@linuxfoundation.org>
 <YgK9v7u+FcBTB1ur@sirena.org.uk>
 <d41ec776-5bd0-438f-0ab3-6eb1891e7fdc@linuxfoundation.org>
 <YgU66pT3efqwwn7U@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb795b74-e44e-9b18-fb37-505b18d129fc@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 09:46:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YgU66pT3efqwwn7U@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 9:18 AM, Mark Brown wrote:
> On Thu, Feb 10, 2022 at 08:12:44AM -0700, Shuah Khan wrote:
>> On 2/8/22 12:00 PM, Mark Brown wrote:
> 
>>> Sure, there are lots of structured files in there like .rst ones which
>>> have SPDX headers but this is just a free format text file so it's not
>>> clear what if any format to use.
> 
>> I think SPDX is applicable to all files free format or not. Are you seeing
>> any build warns during doc build on this?
> 
> No, but I'm not exactly going out of my way to do anything with them.
> As far as I know these files don't get touched during builds, they just
> exist in the kernel tree.  If there is some way of generating warnings
> from them there are quite a lot of other such files already there and
> doing so.  Like I say I can't find any evidence that anyone has looked
> at adding SPDX to these files, as far as I know the long term plan such
> as it is is to convert to other formats and I can't immediately think
> how one would do it otherwise in a way that works well.
> 

If build isn't saying anything, we can move on from SPDX comment. :)

thanks,
-- Shuah
