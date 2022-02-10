Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4084B1167
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiBJPMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 10:12:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiBJPMq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 10:12:46 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC992D4
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 07:12:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 9so7706706iou.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jB6tKPsvO7dDy/FbilJmE/VrDp+SW+nFJ3vX1gmDEsw=;
        b=KtdJrrZkCdKBA5XuwdDc3fk96WvpYRwpGKkK94fBt9YWkZiYH4GDTawXdVgW+XRo/n
         ELuT2uOUZujEUXnVDvCJRA4xjIJIt0M0Tp7T6+TVTsayp3fMvJJ6c/3xOB7rJlKQ9JQS
         g8/rLvMFAyfcc0MhsUY7LPxDjkUjhCd09obyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jB6tKPsvO7dDy/FbilJmE/VrDp+SW+nFJ3vX1gmDEsw=;
        b=LNpwWdvKyV2VhIRRyREZXZh/cd3tHKmyQP283MirkCmu4pt4q+Hq5eecK3uu7z58AU
         UlSoxWHeddRuftSOzEvPo12ioZiUK6nryfLxS7P17UOkawiNpzCd3Afi9FOZROBy1w+R
         f2e0yr6CPFNpibJ3hCE3Dwyz2Ss8Fghrt+FtwFLrg+w5dJhe94iXOOFmkk+K3SANdE/8
         AOGXwNDYVsftJdj2RaCWs+4t0XBvGFicTVi0KSVPZaEFpEXml3gjtfeLs4gL4f43kVVH
         JPN4h/Ur7Mqw+5chiL/GYG5oNBhELGbRLHaw0pWUwQJcZJnr4rpdi72tsnRtpKgqiK5W
         wBlw==
X-Gm-Message-State: AOAM530l/1RHZa+/E+/DPRSe5MLmO/FhxU/pxvAFI+M06vfRjJYwI4qs
        tx7kAUoLbbc5H+uL712LeF/8aQ==
X-Google-Smtp-Source: ABdhPJysYmraJInuOqIz2To0k9po9IoeNYbbpwP+FM3bjPzUYIvF57Guu0t8ad2M1t0sIFfZs3r97g==
X-Received: by 2002:a05:6638:1493:: with SMTP id j19mr4251238jak.242.1644505965252;
        Thu, 10 Feb 2022 07:12:45 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q16sm11144556ion.27.2022.02.10.07.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:12:45 -0800 (PST)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d41ec776-5bd0-438f-0ab3-6eb1891e7fdc@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 08:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YgK9v7u+FcBTB1ur@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/22 12:00 PM, Mark Brown wrote:
> On Tue, Feb 08, 2022 at 11:48:39AM -0700, Shuah Khan wrote:
>> On 2/8/22 11:38 AM, Mark Brown wrote:
> 
>>> I can't find any free format plain text files with SPDX in them, even
>>> really prominent stuff like README.  The process documentation is silent
> 
>> There are about 570+ files under Documentation directory that have SPDX
>> including Documentation/index.rst
> 
>> Based on a recent doc patch I did, I have seen warns during doc build
>> about the missing SPDX.
> 
>> Let's add it now so it doesn't need fixing later.
> 
> Sure, there are lots of structured files in there like .rst ones which
> have SPDX headers but this is just a free format text file so it's not
> clear what if any format to use.
> 

I think SPDX is applicable to all files free format or not. Are you seeing
any build warns during doc build on this?

thanks,
-- Shuah
