Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B47D7846
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJYW5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYW5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 18:57:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E9115
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Oct 2023 15:57:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso52403b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Oct 2023 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698274632; x=1698879432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pccqeQ21pxAvw3LOKSe/24oeNWut3s5JXL/rhk1PmBc=;
        b=gBbUj7xOdZBkUbrOjfbA5PR8pKKhAcP/OuVk+z/Np0+0jxvNShbbT91+kjr1di5EGV
         4AVV8dbz7CCQSfljMHG+gPJ+jVSS9kIr0b3ZSnGfDT7JcMduQmrhP1n99jz4FwL6z2nW
         BNUkfCZtRbcP8sme46nDpRGWcS2RWnDB3NVuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698274632; x=1698879432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pccqeQ21pxAvw3LOKSe/24oeNWut3s5JXL/rhk1PmBc=;
        b=omhh1NBVYlHsIDzNsC88TBvh+5JP3DrOSPMqNICxSkHEw9NmPwJXs6RcbnjvDkIKre
         sAdZvBPMTrQhsbFxbPNeM26Ti19ixf3q8pXQOHPcPtCTtv+LPpmsRo/ybre2RzVr+OQ1
         MaF/fNOJqSqJqWwzMaaJKmhRFnewoUD9NKSaVHi914rGJRHq77+ycIgATvlZoI1/bquJ
         9vVhAR0UisOwyYilhCzyQRIkyeOUUofKE+XOwYTCetKR7t75td4LMp6xPAN8PpV0JvFz
         E0WeQIDJF0vJLK3PJ/CvD2byafIJjbr/RH90b8bayo9qhkWAoxC/GIN8pVb7Y9mkOgPe
         JWGw==
X-Gm-Message-State: AOJu0YyM50/hkMMIEU3bj5bD837elpGrOP8agn/siOZSD2QiofrJaygt
        iBd6Y6hbP9bjzUtqnH5w74hkGWAgFvgpJsN2osY=
X-Google-Smtp-Source: AGHT+IH8IG+XRC/anHzpgUhYF4NWLVpoz+gct1UTpj18Yly0NHVlSWY5nQQF8fPiFHu/m5o7l3/sEw==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id fj10-20020a056a003a0a00b00690d0d46fb0mr16908711pfb.3.1698274631799;
        Wed, 25 Oct 2023 15:57:11 -0700 (PDT)
Received: from [172.20.1.11] ([12.222.71.83])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b006b287c0ed63sm9843408pfq.137.2023.10.25.15.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 15:57:11 -0700 (PDT)
Message-ID: <a3055ce6-8ca9-48ad-a299-8a0339374046@linuxfoundation.org>
Date:   Wed, 25 Oct 2023 16:57:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Purpose of gen_tar
Content-Language: en-US
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Marcos Paulo de Souza <mpdesouza@suse.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "mbenes@suse.cz" <mbenes@suse.cz>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <2nv6zlkrhaeosjjtpvsfl5gehrlmujocdbmaxyqgpkxzmjnuuz@cj3bajg37xb7>
 <BYAPR13MB2503D83D75CC553E3D994AABFDDFA@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <BYAPR13MB2503D83D75CC553E3D994AABFDDFA@BYAPR13MB2503.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/24/23 12:34, Bird, Tim wrote:
> 
> 
>> -----Original Message----- From: Marcos Paulo de Souza
>> <mpdesouza@suse.de>
>> 
> ...
>> Per the kselftests documentation[1], the gen_tar target is used to
>> package the tests to run "on different systems". But what if the
>> different system has different libraries/library versions? Wouldn't
>> it be a problem?
>> 
> ...
>> 
>> While the current approach can work when the selftests rely solely
>> on shell scripts(cpufreq, kexec), those who compile userspace
>> binaries (cgroup, alsa, sched, ...) may not work.
>> 
>> Am I missing something? Is gen_tar only meant to copy the tests to
>> be run on systems with the same libraries or with the libraries
>> with the exactly the same version?
> 
> gen_tar was originally intended (I believe) for developers doing
> cross-compilation. The SDK used for cross-compilation of the
> executables should handle issues such as library versions (and of
> course, CPU architecture and endian-ness).
> 
> I've never done cross-compilation for the same architecture, so I
> don't know how that would work, but I presume there is some way to
> compile code for another system with the same architecture but
> different libraries.

Right. gen_tar was intended to be used when a user wants to generate tar
archive of all the complied tests/installed tests. Running kselftest_install
creates a directory with artifacts necessary to execute tests.

This functionality is now part of the selftests Makefile - gen_tar target will
do the same.

thanks,
-- Shuah
