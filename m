Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCB76EFEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjHCQtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjHCQtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:49:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FE83C14
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 09:48:52 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e9e14a558f8ab-348d1c94fdaso1359635ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691081331; x=1691686131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQ6EWC8B7oQ3T6NTg6WOQ+ngTyl3erkhNwPSztKemT8=;
        b=I8UEEEpMgMmmgjFBfIabgFSwv0M1EvDjPygZRV8ViVDrF5vl/M7JBUeclYDCubHzRu
         jMz5w73fjDNnSuAwricXbSss1mRYA63soRHyxGrN51QEhvC09UFfDwCVLXfZCT++uDTI
         VXHTIBZwIUAvhnJe6iRFjr7/tp0ez/D8LVChw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081331; x=1691686131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ6EWC8B7oQ3T6NTg6WOQ+ngTyl3erkhNwPSztKemT8=;
        b=NLiioCjswttWmmmq6pCD+AEIcEe7T8sQBB+CNSMoBL7oNkz41A2L2y79Ej4kGwQSJe
         WW+5TqUAd2Rv8GpXiBUuc5vL3Avu2p/b4+ajEIW3f8MNtC5h06pR0mvs8bIwdyxKF1w5
         o5qb6HsyBhs+ypzBWknO8QYqVwBlxG1+c3yp4qH7sq5CpEPimmiIFAvSDell6OZOzGd/
         Fssu9lKRIDItQiUaN8AwOlK+KO0Er+F1WnBG75sYVTeJ5adPNGZf28MNJT86DepV2Q/x
         Ugn6MqzDlXsv1Jk7mJxN0YB8Jj9eGdZ0AcztKEMvhSGq7d6FcgpkI+8fmDJPCqWosQP3
         jajw==
X-Gm-Message-State: ABy/qLYRiRUEWaaDYxBzTBu35ZcoEDNEK+NRzyH457iQUZK0BSgcan3f
        lERPWGEIEQOwirRR17mrHbSOwg==
X-Google-Smtp-Source: APBJJlHwrY9T8MbVPlU2tPcxOi0IPISnlrSiyD+jRXAEif1vVKGWnXXUbeacCmBU0nTNw2Ct4/SvdQ==
X-Received: by 2002:a05:6602:3d5:b0:780:d65c:d78f with SMTP id g21-20020a05660203d500b00780d65cd78fmr24072157iov.2.1691081331660;
        Thu, 03 Aug 2023 09:48:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x10-20020a5eda0a000000b00783634b9eafsm66851ioj.50.2023.08.03.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 09:48:51 -0700 (PDT)
Message-ID: <1c16fbc3-9bcb-3ad5-e875-26d8bdc75422@linuxfoundation.org>
Date:   Thu, 3 Aug 2023 10:48:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/riscv: fix potential build failure during the
 "emit_tests" step
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Evan Green <evan@rivosinc.com>,
        Hugh Dickins <hughd@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230712193514.740033-1-jhubbard@nvidia.com>
 <169107392499.27633.6579477595845776477.b4-ty@rivosinc.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <169107392499.27633.6579477595845776477.b4-ty@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/23 08:45, Palmer Dabbelt wrote:
> 
> On Wed, 12 Jul 2023 12:35:14 -0700, John Hubbard wrote:
>> The riscv selftests (which were modeled after the arm64 selftests) are
>> improperly declaring the "emit_tests" target to depend upon the "all"
>> target. This approach, when combined with commit 9fc96c7c19df
>> ("selftests: error out if kernel header files are not yet built"), has
>> caused build failures [1] on arm64, and is likely to cause similar
>> failures for riscv.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] selftests/riscv: fix potential build failure during the "emit_tests" step
>        https://git.kernel.org/palmer/c/8c82d2bf5944
> 
> Best regards,

This is already in Linus's tree. I sent this in for Linux 6.5-rc3

c77896b143d3c9c3e84c4ed0662b807ccbd8730b
selftests/riscv: fix potential build failure during the "emit_tests" step

thanks,
-- Shuah

