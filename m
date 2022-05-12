Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147F52540B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357124AbiELRs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357205AbiELRs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:48:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD37307C
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:48:26 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l16so7310237oil.6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cf74R0Wz1/uilLfLOdYpCYhNdODuzdJOYPzmmj2JrkQ=;
        b=BomaR2ZB3It89qJzF/He6WjK6nzpMOXZbPnnKGIPFtclbTuI5Geun6Ys29DJd8oC7A
         zFwMvbCb7UapaQRDnTNyYJx0Bht3w9fFxXs9CNDU4w+Z5Yaw8iRhHYxkKo6Of2gmaNUn
         SfFKXx+q+g2q6wlMpqgLG2j3rDPCFkU0xdugk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cf74R0Wz1/uilLfLOdYpCYhNdODuzdJOYPzmmj2JrkQ=;
        b=A89OfrcFRc9WXem+GtcmLKvDmfIIQi9KBqjSxMQm041vvY4qZxvFL/OM2AHVe3xRUm
         lsOlnVWIEMPYZBU2fTfqlaHErG+KAqnqcOY+ITQRbEzBs3wbMCDltbc5uLQBLd55bFRD
         DI+aSYS/SAQ6JlQSKjOS28SNbliJETfty7/EhwBUOc71uIu8UIXY5y1VQl74QoQ5Uj4g
         YfHUPQYMtkSEMnV+/PKnO9h7KS/qwCIv/N7/TqVl2S65uYhwdCYbyoNCNf3+tz4pMEtB
         svWgrX8Co236h80BY56dH4IsLCyvg3RJG0O7bmiLIVTn5R2ZQv00bzPxog7F2qMLXD4V
         7yIQ==
X-Gm-Message-State: AOAM5319q2eHeN3I1TdYJK5QaFRuvmoIsl244O0S5QMFTrcxezwI4Zhv
        WHfJoRBjZLzdZCUSH/fGHIgYqg==
X-Google-Smtp-Source: ABdhPJzihOYlXGwyw98+yvXr9su5BZdWeXWub3QGrmwoxYV3oIEofuRBckm809RDKkXYO9zEgp7kOg==
X-Received: by 2002:a05:6808:16a1:b0:2f9:bfea:e5f3 with SMTP id bb33-20020a05680816a100b002f9bfeae5f3mr564892oib.28.1652377705871;
        Thu, 12 May 2022 10:48:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s124-20020aca5e82000000b00325cda1ffb8sm148096oib.55.2022.05.12.10.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:48:25 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 5/8] selftests: kvm: Add implicit memory conversion
 tests
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-6-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a68283e4-f3a5-077c-95a9-c3a8f0ea3b60@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:48:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-6-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> Add tests to exercise implicit memory conversion path.
> 

Too cryptic. Add more information on what kind of tests it runs
and inlcude test example test output with how to run examples.
   
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---

Please see comments about coding style related comments on other
patches in this series.

thanks,
-- Shuah

