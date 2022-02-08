Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197C44AE176
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385498AbiBHSuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385493AbiBHSuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:50:04 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DFC0612B9
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 10:50:03 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h7so244122iof.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Up9s3VVyRq3gUPhujQummCRkFjt5TIPVI87trpcElzg=;
        b=BGKJpotKRvg9wbEaGyU52UDLSBHBOdnH0ozTUDjnP5Llw3UWs+GztkRlCP3t0AqK2W
         00Tb2TU8KE6B5rASBMivmtLcxUCDUVv1S8Ct6p97DJlUNdW8L+aMDP8ycjq8tFuoiqZE
         bquMmHDbTIS4UEk9DDqMDwR+EEzOTfHX59l7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Up9s3VVyRq3gUPhujQummCRkFjt5TIPVI87trpcElzg=;
        b=uV+tQLqTDwL5eoxax+Za+Yl5R9Y+JMfM4szD0ETKK1Y27XPnHefqL2JlhrxNoN2l5V
         /IJWgjjLfymMmL/nXrTTPBPckECOas84OmqVwVZfF/7ZxOg0gO5tEU6Co71wkETuMeCz
         5Pwit1vI4AqvMR08ijLIaT9xm8ktQEc3VMcrvo8YA93Huyq7ppeVFJ/oe+Sa/0JRWjj0
         Mo4CmKbqSeTTeM00iA7vCWO93XDkeCpdYLDBx970EdFisBQSTTx1oPvLFID0bHaXbO0D
         05vGv3c6D0pKJ+wpg/lFEvQ12kEVlnXes71U5gRBosctOsk70YBdXD2vrO/fb2EWQwiU
         4xmw==
X-Gm-Message-State: AOAM531d9VN8/Bc9pPraX89mOxXsGldICiQCyoGAXom/4/kFXP5V4YeV
        6wOCaC7ATeAqICVFBpNxsCUl0Q==
X-Google-Smtp-Source: ABdhPJwftdpUC+GK+1Mlp6jRp8pl74aOJ+aLuxMv4f6itmu9L1GMVyRPhLCD9Etj1CtWGgoqIV22sA==
X-Received: by 2002:a05:6638:329a:: with SMTP id f26mr2675913jav.28.1644346202072;
        Tue, 08 Feb 2022 10:50:02 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e17sm7625070ilm.67.2022.02.08.10.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 10:50:01 -0800 (PST)
Subject: Re: [PATCH v11 40/40] kselftest/arm64: Add SME support to syscall ABI
 test
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
 <20220207152109.197566-41-broonie@kernel.org>
 <676aa270-7801-9689-7c88-27368f32a532@linuxfoundation.org>
 <YgKzXs2Eti+Z2A1+@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5ab8ec1b-c978-3eed-9e32-3d99d7cba4e3@linuxfoundation.org>
Date:   Tue, 8 Feb 2022 11:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YgKzXs2Eti+Z2A1+@sirena.org.uk>
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

On 2/8/22 11:15 AM, Mark Brown wrote:
> On Mon, Feb 07, 2022 at 06:52:06PM -0700, Shuah Khan wrote:
>> On 2/7/22 8:21 AM, Mark Brown wrote:
> 
>>> +static int check_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
>>> +		    uint64_t svcr)
>>> +{
>>> +	size_t reg_size = sme_vl * sme_vl;
> 
>> Is there possibilty of size_t overfolow here?
> 
> No, if the size of a vector were anywhere near to being able to being
> able to do that I think we'd have serious design issues with the ABI -
> the size being calculated here is the size of a single register.  The
> current architectural maximum vector length is 2048 bits, which would
> give a size of 64K for ZA if implemented.
> 
>>> +	if (memcmp(za_in, za_out, reg_size) != 0) {
>>> +		ksft_print_msg("SME VL %d ZA does not match\n", sme_vl);
> 
>> Print the expected value in addition to the sme_val.
> 
> This is not comparing the vector length, this is comparing the contents
> of the ZA register which may be up to 64K in size.  There are serious
> presentational issues with displaying any errors in a useful fashion for
> such a large register which IME needs custom display code adding by
> whoever is debugging the issue that takes account of what the pattern
> being observed is.
> 
>>> @@ -265,8 +357,36 @@ static void test_one_syscall(struct syscall_cfg *cfg)
>>>    		if (sve_vq != sve_vq_from_vl(sve_vl))
>>>    			sve_vq = sve_vq_from_vl(sve_vl);
>>> -		ksft_test_result(do_test(cfg, sve_vl),
>>> +		ksft_test_result(do_test(cfg, sve_vl, default_sme_vl, 0),
>>>    				 "%s SVE VL %d\n", cfg->name, sve_vl);
> 
>> Print default_sme_vl as well.
> 
> default_sme_vl is just being passed in as a dummy value here since the
> function takes a fixed number of arguments, this is testing the case
> where SME is not used or enabled and will be run on systems which do not
> have SME at all so there won't be any defined vector length for SME.  I
> fear that it would cause confusion to display a SME VL here, and
> do_test() won't actually pay any attention to that argument in this
> case.  We will individually step through all possible combinations of
> SVE and SME vector lengths in separate tests.
> 

Sounds good.

thanks,
-- Shuah
