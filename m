Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D697545573
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiFIUQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiFIUQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:16:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31927113A0D
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:16:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a10so23288738ioe.9
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTc1YUmssgp4ofN/lfipMzdCHUKfbjkAhnTCWg85ZGI=;
        b=N5eKbiFP5F9WsboOZ/lStxv2GJ7oCHff8sXaoUF7u9xdvgcDstN2GZ67IicomyrK71
         gs7bcS8kheg0i0QdMhRsekqId+b4RjbE8aVByFdE8X0Ay0CtukKftMwAJOfdsnccHK6g
         r4s3uMUNpnifXxTLf3i96gh+g8C0fCTL3SJRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTc1YUmssgp4ofN/lfipMzdCHUKfbjkAhnTCWg85ZGI=;
        b=dSwloracX4WjN+Vnahf9Czo9/7wEny68dLzDC9Y+iIEIOPXR08Th3CRT4iL0BeTb3P
         kZ2yVu6INLcEeWL9OpDlJCBNu09BjN6jtNoju36OOFvBXRtVsyDOl5N0Z2dldFW+Cnpo
         fMNK6FF748P0x9YIxvCPG3TEQtYiYrMpwGCzI/r4AWhfXRpf2LUMXNOA8UpzwEtLUM0N
         3B13nahRqlYUTMAaZR/mjjuBRfDAXMrGh66Ik/cjL8dMXop5GHodTXXGbCIxLFdkGY/8
         JERxQMhzWWWfdIKKMDxvWFaERJZQlaztmL4eDUPlZf+nRnmDaazF6+jMeIoM4fYjhEi2
         pUGA==
X-Gm-Message-State: AOAM531Y2qJ9ZJjKTl19YidIBKRhkJf7wvCmhyKdm8TSI+wQJDRkn9+t
        hCX0KLCkPqTzHAPcOH9FifziAA==
X-Google-Smtp-Source: ABdhPJxuLRw5LPS0kibUBzfb+Hcg7tkGWhRN4VbnW59caUEi9g/ngcq4UQVKLIuYnP/MWwhFB/Y6gg==
X-Received: by 2002:a02:164a:0:b0:331:5661:75b2 with SMTP id a71-20020a02164a000000b00331566175b2mr21929791jaa.122.1654805795555;
        Thu, 09 Jun 2022 13:16:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l13-20020a92700d000000b002d1d3b1abbesm10720904ilc.80.2022.06.09.13.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:16:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220603143242.870-1-mpdesouza@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:16:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220603143242.870-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
> Hi there,
> 
> The first patch moves the current livepatch tests to selftests, allowing it
> be better suited to contain more complex tests, like using userspace C code
> to use the livepatched kernel code. As a bonus it allows to use
> "gen_tar" to export the livepatch selftests, rebuild the modules by
> running make in selftests/livepatch directory and simplifies the process
> of creating and debugging new selftests.
> 

In general selftests don't include modules. We keep test modules under lib.
One of the reasons is that modules have dependencies on the kernel and should
be built when kernel is built.

I don't fully buy the argument that moving modules under selftest would simplify
the process.

> It keeps the ability to execute the tests by running the shell scripts,
> like "test-livepatch.sh", but beware that the kernel modules
> might not be up-to-date.
> 

I am not what you mean by this.

> The second patch includes a new test to exercise the functionality to livepatch
> a heavy hammered function. The test uses getpid in this case.
> 
> I tested the changes by running the tests within the kernel source tree and running
> from the gen_tar extracted directory.
> 

I would like to understand the negatives of continuing to keep modules under lib?

thanks,
-- Shuah
