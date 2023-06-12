Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3972D46C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjFLWcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 18:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFLWcO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 18:32:14 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C91715
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 15:32:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77ae75c75deso34143239f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686609131; x=1689201131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zO8aM9RsIffIjx4jAwj5YcVlYgxgznlqdMEphKaCDWk=;
        b=eGRWpJQyLSZ6IJ+0Ht1B84epSUoTv4pGbA2zVUUlO+1PNHFgxxNITeeSnByn3mXOTx
         Qi4G578qXQJw2cI1mU5N4iGZkTcyjm5XG1NKGzusRMBQWN3pJvILgFsUxYr+9e1OykwC
         RVIzfpZWwskQp9n7U40PWoJmEH7D5W+BV8qKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609131; x=1689201131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zO8aM9RsIffIjx4jAwj5YcVlYgxgznlqdMEphKaCDWk=;
        b=W9PmObN9wJFRKJh+Nvy3+P51L7s0RTv5+4Q4y0if0fqXfPLDTkcozc11h0GBXrgzrq
         JVYlcXkqtcc8rodelKoDZSA90e8XO94XZ/N5O2x2ZQ4TozlKruc3uOkzUISXuj8u8LsU
         fG/blGnmfS3ntkrpGAJ4Tsq8wUeaROBq9txRvclWuhfbioExxemiCSGmfNZu8Y8LFxyc
         vttDoZHpQL7Yvm4QQlRRj76zO3GPSCBWUITdVWhlw+XL6eiqDnsAvWtZ7Khtv4FfgRqr
         eW+V4/2mepD+54a3Klg1LNv+W1U0f6QhOMw0295xue4UgM/ym7FEIGn6upBMhifwajUF
         s7Mw==
X-Gm-Message-State: AC+VfDxO6RSkW72pO8ucG8DfpffPrvtHdzkF3iQPkKq2rjlhTnbjS42A
        u9txumxPkXqJYwykMHxTJ/6AYg==
X-Google-Smtp-Source: ACHHUZ4faLgbaPTuPJztAFxODz/u7zHgz+n9zvWgBtWNe3m/0cIMYBx82V/NN7XO82lNQl6eKLSOag==
X-Received: by 2002:a05:6e02:585:b0:33b:3a14:c14c with SMTP id c5-20020a056e02058500b0033b3a14c14cmr5983221ils.3.1686609131185;
        Mon, 12 Jun 2023 15:32:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 6-20020a920d06000000b0033d136f248esm3474021iln.5.2023.06.12.15.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:32:10 -0700 (PDT)
Message-ID: <b9dd402c-d8d6-e6e9-f17b-304a1dc8a578@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:32:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2] selftests: damon: add config file
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org,
        Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230609191622.80289-1-sj@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230609191622.80289-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/23 13:16, SeongJae Park wrote:
> On Wed, 12 Apr 2023 16:58:06 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
>> Hi Anders,
>>
>> On Wed, 12 Apr 2023 11:28:54 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>>> Building and running the subsuite 'damon' of kselftest, shows the
>>> following issues:
>>>   selftests: damon: debugfs_attrs.sh
>>>    /sys/kernel/debug/damon not found
>>>
>>> By creating a config file enabling DAMON fragments in the
>>> selftests/damon/ directory the tests pass.
>>>
>>> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>
>> checkpatch.pl is warning as below:
>>
>>      WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
>>      #20:
>>      Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>      Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> The reason for the warning can be found from commit d7f1d71e5ef6 ("checkpatch:
>> warn when Reported-by: is not followed by Link:")'s commit message.  Do you
>> have a link to put here?  I guess the report was made inside Linaro, so might
>> have no publicly available link.  Maybe better to add some notes or some funny
>> tag like "Link: N/A # no publicly-available link of the report" for convincing
>> the tool, but I don't think this should be a blocker for this patch.
>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Shuah, may I ask your opinion on this patch?
> 
> I'm also cc-ing Andrew, as he may also interested in picking this patch.
> 

If Andrew wants to pick this up:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

