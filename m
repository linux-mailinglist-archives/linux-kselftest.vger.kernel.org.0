Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2917CB33C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjJPTQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJPTQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 15:16:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED81B4
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:16:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fab2caf70so31704939f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697483815; x=1698088615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8eYRGRtH2Fn/z90b+vACllQCdROhKOQRPM4SZCUCIQ=;
        b=hv4JM9dYs+xbTHSY3CyswnYhLarwRPLfBSNPZGxmR7viGtvVtpduYr8oFG1tNSS/6Z
         ktWDFzlwr0pQNz1SEhleGlbKoFpVteuzMCG8kPWcjvtomBn7EaqpoQAaDjzYs1C3hbew
         4afOqRa4fYGqnyu0e/CiGqhTVFJFmKifi03Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483815; x=1698088615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8eYRGRtH2Fn/z90b+vACllQCdROhKOQRPM4SZCUCIQ=;
        b=MR8cHU+KbMjbkA+T0E7/SFKfR8M0zV3krmifm5LDTWfWJwaEtBYPUqbKE5yb4ugfPD
         88wVLmunW1S4ai54/whhEoHPMnBlqZQSn3l2RXfUP8lID8BpjO/vWV7Xt249gnRkvHNT
         P6SoznxHZurfdu23eWRzInd/uytpileOe5u3674pf6I0UTNokuQbKCmYJh0KYuySoHay
         auNM1Kdzo9w8QZRXNQ+U/ABzX1KCe1kXHwSOCcxzk+hYXombYsvyske6ToDv1EAA6twB
         7Lfiid8tYlr+s5VziOO9QjJS0hojip9GWqQOhIIPmj3UNsdfKI+wpYSxR4YM3/caYLwN
         KP0A==
X-Gm-Message-State: AOJu0YztYHOAEs6azBfvWHc+G0xXZ2T3Qo+NgA+tJ62zsTn+aQsdYfPN
        1yRhhoEl2e7S3zBeoqbVpDOoJA==
X-Google-Smtp-Source: AGHT+IFn1ecQPDmAmDXWidaDLU/nr0Tzhtrs0dUVOUBVzpssFg4fsI+vtOqUvgh1sUS+F79tV8d5lg==
X-Received: by 2002:a05:6602:35a:b0:792:7c78:55be with SMTP id w26-20020a056602035a00b007927c7855bemr190345iou.0.1697483814866;
        Mon, 16 Oct 2023 12:16:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g21-20020a02cd15000000b00458e239fa31sm1109479jaq.55.2023.10.16.12.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:16:54 -0700 (PDT)
Message-ID: <148d2485-798a-4258-bfa2-870b7b6b95a3@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 13:16:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:modify the incorrect print format
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20231016025038.1677-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016025038.1677-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15/23 20:50, zhujun2 wrote:
> printf %d in format string requires 'int' but the argument type is 'unsigned int'

This line to long. Character limit is < 75/line.

How did you find this problem? Please add the details to
the commit log.


> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---

thanks,
-- Shuah

