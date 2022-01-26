Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05A249D307
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 21:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiAZUDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 15:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAZUDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 15:03:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12832C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:03:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n17so988528iod.4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMe8O0ITicLrwj3c7mkhip/6OJuBkx0HlJG/uCBDyG0=;
        b=GhbYXCdsWaR3jqth7tUcp6GURNRcQA9iWuWLPFpC4acl8+N0xmi8+YgjFbT+hjwtxV
         n9aH/ZAlQ8EG7r9RgIms4WlycA2RMMCtn17Y5Ci065Wa4bLpaTOhvEABpXWmv3dWWNVR
         BURZtEgbYWrUy6b8ON1vY06AvY1l8w0QMPw7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMe8O0ITicLrwj3c7mkhip/6OJuBkx0HlJG/uCBDyG0=;
        b=qVQ5niftHjdOsGy2jml8J1aG2AVgT/NdAnq0a5XIxl1ZZ1QD23mbXpmj45O7chLN8l
         ydujNg3ieF9KZlSQMwrVFuLJP6ymhL8FVu7e9nSLpi49vnY6n88HshVkG/ihTufRmp+I
         Tyg84GJ4CPMiZ9c6YKD6fkO3jftVxmIggJiFltsVz2iaXDIbcJJSVqviKpyzOZUsWvI2
         lMxeWd6Sce3viBG5rSfDdC0e5Cx53jIeDkuhbI9ikCLNcZ9F5Tc7fkK+dqrkbdK35l5O
         eJB8PXHjhMneb0uilWHmd6TUAHMY+8Etw8B86dqMLCkd7/KwP+wW4Hrssdt8Prlke1SI
         j/1w==
X-Gm-Message-State: AOAM5312wowDctqmKhEHvkaBclRpSf6ndbMaX3Yi94ZTPjq3nS8hTifg
        g2n4HXlMyRYVb61FVyNQ0Tv/XQ==
X-Google-Smtp-Source: ABdhPJwNTLVDSEQaWj4ahmayvU+7w5oefhIemb+BKQSc24utvCF3MytvBjt5ASR37I+v9VEo/79llw==
X-Received: by 2002:a02:9709:: with SMTP id x9mr123411jai.53.1643227426312;
        Wed, 26 Jan 2022 12:03:46 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:f2e:a7f7:d853:1e3? ([2601:282:8200:4c:f2e:a7f7:d853:1e3])
        by smtp.gmail.com with ESMTPSA id k5sm845601ilr.7.2022.01.26.12.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 12:03:45 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126145242.3473836-1-broonie@kernel.org>
 <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
 <YfGmk1I8l+ROoE/k@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <48c44d74-6668-7823-ada6-0285a8b32a35@linuxfoundation.org>
Date:   Wed, 26 Jan 2022 13:03:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YfGmk1I8l+ROoE/k@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 12:52 PM, Mark Brown wrote:
> On Wed, Jan 26, 2022 at 12:22:41PM -0700, Shuah Khan wrote:
>> On 1/26/22 7:52 AM, Mark Brown wrote:
> 
>>> +	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
>>> +	if (ret < 0) {
>>> +		print_skip("Failed to create vgic-v3");
> 
>> Printing the negative error code returned by vgic_v3_setup will be useful.
> 
> If the function fails for any reason other than the system not
> supporting vgic-v3 it will abort rather than return.
> 

Hmm. vgic_v3_setup() return gic_fd looks like and the interface says
Return: GIC file-descriptor or negative error code upon failure

I don't follow the abort part.

thanks,
-- Shuah
