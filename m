Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5B72008A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjFBLlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 07:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFBLlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 07:41:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C624194;
        Fri,  2 Jun 2023 04:41:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30aebe2602fso1742481f8f.3;
        Fri, 02 Jun 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685706075; x=1688298075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5hQQFCwShPSSScGGAdLrTYkT/tD/8Ppruf6EVNZak0=;
        b=lpbCdDPo8oqAMBTDL1Pyq7/5WqGuqEiJgj6UDO6zCALtYKOEEhbYxfHnIp1i1ZLcyE
         C40XPj7gAbyUo6iTXQPbCO6OT5vlmnUb2ogK8faQhMMWcojPmoYlRhaYpYS5bN/Xtcoy
         ABi6uOJuhwhxw+CPNvQkzbEu/vr76XgYSF6x3HTzVqes7CH+8A456Z2EDsMr8HWOutey
         NNohMcpJt414mu62Ey0YzRoKMBshp+dJQ3WF4LzT+KHtbnQCEip8pp1HbW9tok62g9UY
         7F1f1GloeQzzaDywlH8EREfajW55km7Zv21qkDjyHQNMXd6Le5y5/K7C3uPVmj09Tgzs
         +YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706075; x=1688298075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5hQQFCwShPSSScGGAdLrTYkT/tD/8Ppruf6EVNZak0=;
        b=KEvhg64piE2PBr2lLAXaYzP2iTxVQ11v/aWuKkTL0IIGTIJM1Xchr1M44ucoPGE8Y0
         GtjcbH+O5QN6OZSEZuoLNAzPbk/fI9FN+Rq3acq8u/w0+DB1uuAybKmrfjFG+kln6C9W
         Vm1LrWvBjuX+6JyIZzY1yFd2LWzRIWbk/nmt04eAbu+ZSHz4/aaK7DcG59S58Zm7/IIV
         ySHxFirGH02gh2tRvjshB24CaAsoK5q3S9Nb9P0cW0T8pSeFAkNWbR9XYSTNFSsNqnJ6
         3/wAGrIScMextxOSukhR0A4CKTm77gtuWeBvQXSUN4YUAXnOhDvXdTSnroMBNGaA1tRc
         QXLA==
X-Gm-Message-State: AC+VfDyHIIIUHYD10NB71iJDmMbVKcFHWdQLj6JhGVeQ8t0P4i6vzFFI
        +T85riF6323NaodnP+a+Iyg=
X-Google-Smtp-Source: ACHHUZ6hh2gZb9y18fFjrWO/Hxn65WfbcwBixv/26O788m4ZGG3U1oJHAl9uReT5uWDiXo28Y4Augw==
X-Received: by 2002:adf:edc2:0:b0:30a:ceb3:26bd with SMTP id v2-20020adfedc2000000b0030aceb326bdmr4045669wro.56.1685706074839;
        Fri, 02 Jun 2023 04:41:14 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id d6-20020a5d5386000000b00307c46f4f08sm1443538wrv.79.2023.06.02.04.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:41:14 -0700 (PDT)
Message-ID: <b7b32af9-993c-2f88-30b6-3af9ed87c7af@gmail.com>
Date:   Fri, 2 Jun 2023 12:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] KVM: s390: selftests: Fix spelling mistake
 "initally" -> "initially"
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602102330.1230734-1-colin.i.king@gmail.com>
 <f0f0587b-5f19-82bd-3d58-bdb89ff59f8c@linux.ibm.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <f0f0587b-5f19-82bd-3d58-bdb89ff59f8c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/06/2023 12:07, Janosch Frank wrote:
> On 6/2/23 12:23, Colin Ian King wrote:
>> There is a spelling mistake in literal string. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Hey Colin,
> 
> I'm not a big fan of such fixes since they are most of the time more 
> work for the maintainers than they are worth and accepting one can 
> result in a flood of similar new patches. If this would have been your 
> first ever patch I might have considered picking this but that's not the 
> case.

I understand. However, customer facing typos make the kernel look 
shabby, hence the fix.

Colin

> 
> That being said, if one of the other maintainers choose to pick it I 
> won't stand in their way.
> 
> Cheers,
> Janosch

