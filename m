Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719D352542B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiELRwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245161AbiELRwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:52:45 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B349B1AC
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:52:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z26so6179971iot.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ReqcyXDbUr+EEqNrN0X1PjL7n8Wdm/Pxb5GHqgBmxkU=;
        b=fZyFgh4Ut0aBeUNxcqJ11tuJaT5xpLR8z3OFh2Jgvu2sdaGumX6j2kf+9g0Z93Tfcx
         COjP4SdLzdLDFcerGjU/vjhpyLz4QqpdKaRmRearUGnJHdokDapmD/qSmw+z6N17DwpM
         e7diR7rZ2SlqAZyWp6Kr3hPVb2brq+gFZAIw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ReqcyXDbUr+EEqNrN0X1PjL7n8Wdm/Pxb5GHqgBmxkU=;
        b=vUGN3nyZi3kkwZG0yZpRzp++8KJyJ0rvnjI6v03zr4FJfjJuJMwjUB0z70/5aKhCcs
         bvZm6fuXuxaRwL9N/DjcX7e8eM2jHL2b2hArnQ3U/Fi5ZXJiaKeUC4sqa4mK0LRuFnEo
         mHr+pwt8ZjfmYbrNgMGJgcFuIIgQMhTdFgh/JTg1xvkvOZJ7uDUEsnklLbX/XJpO/0kd
         T+kJbAwL+xxidaMHRLbH9z2F4xNB6ZD61Iu++DUiYJWMUu218QfCsv4X3UVOVUeOtwmd
         VsE10s29Q8eI5KoUob7DNKEVEBTDyzxz7DYGo0r8N1yoVt/WFmdFFVfwP/GMrVd6ZUJP
         2sCg==
X-Gm-Message-State: AOAM530kfsMzvxhhXdikon5f59yybXpiQSWcZovQ7IXZSBhEVXnipX1k
        j0ya3rviHiungeZpj6XDTgYJfg==
X-Google-Smtp-Source: ABdhPJzFw/qfdiaf5oPHeu330lnXRI8cH1am+4TMPXaqU5pgToJ3l3uT8x9mX3/hNiEb0e4b2Z/ixQ==
X-Received: by 2002:a6b:f411:0:b0:657:b73f:8e97 with SMTP id i17-20020a6bf411000000b00657b73f8e97mr589301iog.68.1652377963714;
        Thu, 12 May 2022 10:52:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c8-20020a92dc88000000b002cde6e352eesm21289iln.56.2022.05.12.10.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:52:43 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 8/8] selftests: kvm: priv_memfd: Add test avoiding
 double allocation
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
 <20220511000811.384766-9-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7edd8342-08b9-cb1e-ee2d-9585546cf0c7@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:52:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-9-vannapurve@google.com>
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
> Add a memory conversion test without leading to double allocation
> of memory backing gpa ranges.
> 

Rather cryptic. Please add more details on why this test is needed
and what it does.

> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---

Please see comments about coding style related comments on other
patches in this series.

thanks,
-- Shuah
