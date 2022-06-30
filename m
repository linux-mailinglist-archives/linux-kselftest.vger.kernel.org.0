Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEE561E34
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiF3OiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiF3OiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 10:38:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6ADA197
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jun 2022 07:36:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p14so12533632ile.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jun 2022 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f9z5EbxXbqosYQFsoXX2aboDLVMH48aS/feIG93zb/A=;
        b=ECjm+xtTfGhQo5LE4Ry7UFz2eivhvnsCOwyE1HrrNEYV8olpPLrJdXB1tm2VU1sLqf
         ZP21WSgaFdZs82Bkc9Uub+LIfYFvnm4xhTUvi7+kGsge4Q3Xiv0c6ZIgoqXoztEw1MZl
         gwv4WOXyFrS2ZBmlVN3ACzytjB66PPvSUUvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9z5EbxXbqosYQFsoXX2aboDLVMH48aS/feIG93zb/A=;
        b=3eZRbb9DUbKnXEnCi3jJGeQy4/QcUFdeFq0fT6DigYOshGkRZdLqlcDVOotlC3FaQW
         l4yiV0Ro6lWK+OrUkdLfBmVQEyVjjXHyN9981dMLuUfobwTAjkLu4bShlKPXm72gwx8b
         2Vi71fPOh/KtGU12PsyDQXOEteJCExcugVO4EbAwvo6KATiZz7DcnKv4Sz69yd94aWBC
         Whl5m97Lhubkb13GBpiGtodRCr2rLsghpxx+QcKM7Q5xdOccDBbSgKWXnB3Y/B5yKPnR
         c9mNWOo7T5Jtb9y4Icx7EJrRqeNk8dRW+UxTrdFWHuKe9dPF3sL1som8gVh9vED7Cec8
         O9+A==
X-Gm-Message-State: AJIora8CTUfxgj1gjwfN1JIlGcr/RxpW4gp7S4L/DdUaHLoaHlTeex0+
        6VC667T0aDHf0aMrG5WDTFFytw==
X-Google-Smtp-Source: AGRyM1vqAwYNV03atR01g7cM184M3LG8DWL49aqimRNjYF3JNrRusxSxshCA1spfPqv/NIerj/qs6w==
X-Received: by 2002:a92:b00f:0:b0:2d6:5628:6865 with SMTP id x15-20020a92b00f000000b002d656286865mr5378626ilh.230.1656599764064;
        Thu, 30 Jun 2022 07:36:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p18-20020a056638217200b00339cae5cb8fsm8684193jak.103.2022.06.30.07.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 07:36:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220630141226.2802-1-mpdesouza@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 08:36:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220630141226.2802-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/30/22 8:12 AM, Marcos Paulo de Souza wrote:
> Hi there,
> 
> this is the v2 of the patchset. The v1 can be found at [1]. There is only one
> change in patch 1, which changed the target directory to build the test modules.
> All other changes happen in patch 2.
> 
> Thanks for reviewing!
> 
> Changes from v1:
> # test_modules/Makefile
>    * Build the test modules targeting /lib/modules, instead of ksrc when building
>      from the kernel source.
> 
> # test_modules/test_klp_syscall.c
>    * Added a parameter array to receive the pids that should transition to the
>      new system call. (suggedted by Joe)
>    * Create a new sysfs file /sys/kernel/test_klp_syscall/npids to show how many
>      pids from the argument need to transition to the new state. (suggested by
>      Joe)
>    * Fix the PPC32 support by adding the syscall wrapper for archs that select it
>      by default, without erroring out. PPC does not set SYSCALL_WRAPPER, so
>      having it set in v1 was a mistake. (suggested by Joe)
>    * The aarch64 syscall prefix was added too, since the livepatch support will come soon.
> 
> # test_binaries/test_klp-call_getpid.c
>    * Change %d/%u in printf (suggested byu Joe)
>    * Change run -> stop variable name, and inverted the assignments (suggested by
>    * Joe).
> 
> # File test-syscall.sh
>    * Fixed test-syscall.sh to call test_klp-call-getpid in test_binaries dir
>    * Load test_klp_syscall passed the pids of the test_klp-call_getpid instances.
>      Check the sysfs file from test_klp_syscall module to check that all pids
>      transitioned correctly. (suggested by Joe)
>    * Simplified the loop that calls test_klp-call_getpid. (suggested by Joe)
>    * Removed the "success" comment from the script, as it's implicit that it
>      succeed. Otherwise load_lp would error out. (suggested by Joe)
> 
> * Changed the commit message of patch 2 to further detail what means "tricky"
>    when livepatching syscalls. (suggested by Joe)
> 
> [1]: 20220603143242.870-1-mpdesouza@suse.com
> 

Sorry Nack on this. Let's not add modules under selftests. Any usage of module_init()
doesn't belong under selftests.

Leave these under lib and use KSTM_MODULE_LOADERS to load these modules that
live under lib.

thanks,
-- Shuah
