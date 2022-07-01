Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE5563C37
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGAWN5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 18:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAWNz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 18:13:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE033EB6
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Jul 2022 15:13:53 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so2832281otr.11
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Jul 2022 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vIW1nHmpusRVF5xA8y8f60fs96mXWAcFdbwaab9mjTQ=;
        b=AAiP3UDUcO0WW1eVydHEQqa/0yv6PGRxMGMWMq4CA6z1TjTc3RSmdqI+IxsZBR9Rxx
         IkwgLoWFdwWT3VY/gZd6znbNEbl59FmAPzla9CILyjGcvqZAaHJhdgtZxcYRSpdxk1nx
         moKiZb4Gu1/JExBVtUHDKtcc+yL+6POUFeNy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIW1nHmpusRVF5xA8y8f60fs96mXWAcFdbwaab9mjTQ=;
        b=BmwcnWDMw+V41RThcwltoYmsiAQ/tBNpbsPtLap9Fl8ZzjzG2aRZE0FZZMY0bgibdy
         dxfdVufWIivZ5LbgazS4yaK7rp5z06dOqfxbLw3/osB1O+D65ZeZ4c8Tl+nMn/QijRIy
         19QgjRz+aQu3SvXi83TmoGXYAs1KTZewWu2KlvHfYqnQyCFBpZhOSkcRjuaCkcC0x7cr
         /4Q+5HoNSJQ/NxO/BAugwc5H4l2I8IlbyE+oWgnO33lc+P7UFkEW0/b6MGPpy/ln8tKE
         mmaoHlWFXy8otkD6sPIVCJRSJlEwNFAK8mSvW9GXT8uKMfCJdZBtUF3UoydyxHVPnwAk
         8z6A==
X-Gm-Message-State: AJIora+vKZ5eYN0OIbi0dBiLmVjisqAz63+18pqeqddfZdr7+ZGezfrz
        1J4avJVRQ8DgljBE0FNBuZLk4sUYO676AA==
X-Google-Smtp-Source: AGRyM1vwcKyX1NeGZPO3z+npoB1EW9K/fAsey9TXHIR98gOlceBgC9O5wUKh91o6R/hQY0yXFpq7tw==
X-Received: by 2002:a05:6830:4186:b0:614:d750:825f with SMTP id r6-20020a056830418600b00614d750825fmr7670514otu.8.1656713633270;
        Fri, 01 Jul 2022 15:13:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a056830268700b00616a2919312sm5660316otu.8.2022.07.01.15.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 15:13:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, pmladek@suse.com,
        joe.lawrence@redhat.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
Date:   Fri, 1 Jul 2022 16:13:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
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

On 7/1/22 1:48 AM, Miroslav Benes wrote:
> Hi Shuah,
> 
> On Thu, 30 Jun 2022, Shuah Khan wrote:
> 

>>
>> Sorry Nack on this. Let's not add modules under selftests. Any usage of
>> module_init()
>> doesn't belong under selftests.
> 
> as mentioned before, that ship has already sailed with
> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c. Anyway...
> 

Just because of one module under bpf doesn't mean that now we can add more.
bpf test is some ways is not a good example or model to use. bpf test requires
specific environment and its needs are different from other tests.

> You wrote before that you did not have a problem with it. And you would
> not have a problem with Marcos' approach if modules can be compiled and if
> not, the tests would fail gracefully. What has changed? If you see a
> problem in the patch set regarding this, can we fix it?
>   

Yes I did and after reviewing and thinking about it some more, I decided this
is the right direction go down on.

>> Leave these under lib and use KSTM_MODULE_LOADERS to load these modules that
>> live under lib.
> 
> I may misunderstand but KSTM_MODULE_LOADERS does not seem to provide the
> flexibility we need (yes, it could be hacked around, but I do not think
> that the result would be nice). See what we have in
> tools/testing/selftests/livepatch/functions.sh to make sure that a live
> patch module is properly loaded and unloaded.
> 
> My main question is different though. As Marcos mentioned before, we would
> like to have our tests really flexible and a possibility to prepare and
> load different live patch modules based on a template is a part of it.
> What is your proposal regarding this? I can imagine having a template in
> lib/livepatch/ which would not be compilable and a script in
> tools/testing/selftests/livepatch/ would copy it many times, amend the
> copies (meaning parameters would be filled in with sed or the code would
> be changed), compile them and load them. But this sounds horrible to me,
> especially when compared to Marcos' approach in this patch set which is
> quite straightforward.
> 

I have to think about this some more to get a better feel for the use-case.

> Then there is an opportunity which Joe described. To run the latest
> livepatch kselftests on an older kernel. Having test modules in lib/ is
> kind of an obstacle there.
> 

You can revision match if you think you have to have kernel and livepatch
test be the same version.

thanks,
-- Shuah
