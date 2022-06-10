Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35468546711
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbiFJNGg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 09:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344820AbiFJNGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 09:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA3ED767D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jun 2022 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654866388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/qZ9hPkyfAzHF2C3skFs/nWfk6/WdMDFmw7jidLtN8=;
        b=Tm6TrGX0rrz7QlT2OrkSiRk89SqLFQVsp5CKrAfCSq6xpDBbRarOQVD8kN/28yOTLxRZAU
        mGtns31xf1VgT/d12Xcq3TfauB9ubGivuKIY20GoaYZrQ6FoxugLD2ENHOmY/uMGn3dxZs
        p4oKjUK8Nc/TIgVfHSUtHToBGb7Zeyc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-32Pd2XnZP0mLq6_wg57fdw-1; Fri, 10 Jun 2022 09:06:19 -0400
X-MC-Unique: 32Pd2XnZP0mLq6_wg57fdw-1
Received: by mail-qt1-f199.google.com with SMTP id 15-20020ac8570f000000b00304e9e3b19aso12771167qtw.8
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jun 2022 06:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i/qZ9hPkyfAzHF2C3skFs/nWfk6/WdMDFmw7jidLtN8=;
        b=6YhY9b9ioycRkxPvSWZihZZW/kymNud1adSfC8fDP0X86AlkyNbpPEEeu40VfSL+tG
         kz4O5K3D7rYxgCyHE7pSDOd6PEpkMt0EyQx+uxUvrYidyIRpkUQLkUoiQT+8bi3/ri6s
         eKltYUyY9i7ihLO7z5sbsNVcHQ3F7R5//Epibna5dyUT2VvtKB+utSq2dAnvU+Nf7fR/
         YJB8Tpw6Nad93cjust1+EPZjKYkhTa8Yb0KKH4wnFTSiSXfNvykMY+miOIt9PMF4vC6s
         /go8Svy3t4ozwRmaINCoYGjpXZlBr9rz4F+4lWFa7miEqgGHp+IQks3DbPz09i8Cx7jN
         JBLQ==
X-Gm-Message-State: AOAM531vym55pOOdumwYoxZPE8zfN+hZou9JGJd2rsVBcDRulUFm2b6y
        sZldp6iql194UHSugGKDUI37HRsB/DiIdcvPc2ge8o8l45N0z2uRRgEY5yjT8tObRZhpJBdHEO4
        /maAulUcYpjJhw7jwJ5Wy01/iU1O7
X-Received: by 2002:a05:622a:11c5:b0:304:d8cd:2058 with SMTP id n5-20020a05622a11c500b00304d8cd2058mr33787605qtk.324.1654866379094;
        Fri, 10 Jun 2022 06:06:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhc8Ym2vVTmu35wZVMf8SMDVYuy8RlOZdv2PzzhEZKAhcDLqWbwqQ2AtPXYeBY2TIahvJk7Q==
X-Received: by 2002:a05:622a:11c5:b0:304:d8cd:2058 with SMTP id n5-20020a05622a11c500b00304d8cd2058mr33787535qtk.324.1654866378406;
        Fri, 10 Jun 2022 06:06:18 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a69d7f390csm18477915qko.103.2022.06.10.06.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 06:06:17 -0700 (PDT)
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
References: <20220603143242.870-1-mpdesouza@suse.com>
 <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <5966397b-5577-8075-ffdd-f32e5e4ca75a@redhat.com>
Date:   Fri, 10 Jun 2022 09:06:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/22 4:16 PM, Shuah Khan wrote:
> On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
>> Hi there,
>>
>> The first patch moves the current livepatch tests to selftests,
>> allowing it
>> be better suited to contain more complex tests, like using userspace C
>> code
>> to use the livepatched kernel code. As a bonus it allows to use
>> "gen_tar" to export the livepatch selftests, rebuild the modules by
>> running make in selftests/livepatch directory and simplifies the process
>> of creating and debugging new selftests.
>>
> 
> In general selftests don't include modules. We keep test modules under lib.
> One of the reasons is that modules have dependencies on the kernel and
> should
> be built when kernel is built.
> 
> I don't fully buy the argument that moving modules under selftest would
> simplify
> the process.
> 

Hi Shuah,

I see that there is tools/testing/selftests/bpf/bpf_testmod/ which
claims to be a "conceptually out-of-tree module".  Would similarly
moving livepatch test modules under tools/ give us flexibility to write
them build for multiple kernel versions?  Then one could theoretically
build and run the latest, greatest selftests against older kernels
(assuming the associate script/module/kernel supports the idea)?

Regards,
-- 
Joe

