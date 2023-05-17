Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9E706E11
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEQQ0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQQ0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 12:26:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC5130
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 09:26:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c63acb667so6285139f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684340805; x=1686932805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1UIr2O96eqQRKPgP1AV0SLkUICGyPPJvig8S9zbnRc=;
        b=CdYixgdA73pqJh8OsVlHYLcRw1haMr3GeszWTuBgvrp0NVlCVUljOqwtL7hbmwMtVB
         iZDiN+sKSL3gVveQgYyMFr+H6+ni96CS/+VaON8/ZgEYQz97l2gemWZMrXiPqwN0ac+s
         k5zyhslT9oQdAg39XGFQ7KS9vdPy+LGYfwoF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340805; x=1686932805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1UIr2O96eqQRKPgP1AV0SLkUICGyPPJvig8S9zbnRc=;
        b=DY1epzYT1IcKkdsLBhroSep4fjaL2eKtig8eRZp2YwzhCAwhYrNC28Ptc8nlcy5Z0R
         VBcs2JhzS6YBaClJVWBr95NRfhWL/xgE7863GTbsG+BhShbqxWyWketvwanfi9dSc5iG
         eyQcTkPoc32IeC9XKVdO9rHWS+E3zf+rpWc+7eD8rpnag1YSkUaqHdP5xW05IwkyK4Zw
         nSJsuH46CoFcsdSuaq7zs78NoNHL4KJnPww+nTlYhkffQLThpomL5Ty01IT1tHpEmjzu
         fsgN0yGc88STMfma5U0+UDGEW6EWsWvW6xu2lmEvDmyRlDypXBuY+NMzaeLGiTuJq47Z
         eL8g==
X-Gm-Message-State: AC+VfDyw+YMQx0aplML6tt3H1lMGNdMmbQyYYnwHR/GbhjE3nQvvvaq2
        SIMzHU2e54/7unett6zZuNoqHI4fO+o12iu0tDQ=
X-Google-Smtp-Source: ACHHUZ70fhXGKVnGJqC9bAhF6L5Zabpzl1hP3Kv6138nXbxN14WKXZhHZp9X2xMtWP3mT9LtVqoM0g==
X-Received: by 2002:a05:6e02:12cf:b0:32b:51df:26a0 with SMTP id i15-20020a056e0212cf00b0032b51df26a0mr1987315ilm.2.1684340805478;
        Wed, 17 May 2023 09:26:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h4-20020a92c084000000b003317ebbc426sm6240049ile.47.2023.05.17.09.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:26:45 -0700 (PDT)
Message-ID: <08abb08f-68d9-54d0-cb7a-ba56a73a9856@linuxfoundation.org>
Date:   Wed, 17 May 2023 10:26:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, naveen.n.rao@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
 <20230428163842.95118-3-akanksha@linux.ibm.com>
 <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
 <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
 <20230512181517.607ff03d@rorschach.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230512181517.607ff03d@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/12/23 16:15, Steven Rostedt wrote:
> On Mon, 8 May 2023 11:36:28 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>    
>>
>> Would you like this patch to go through kselftest tree?
> 
> Shuah, you can take it through your kselftest tree.
> 
> Thanks!
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

Applied to linux-kselftest next for 6.5-rc1

thanks,
-- Shuah

