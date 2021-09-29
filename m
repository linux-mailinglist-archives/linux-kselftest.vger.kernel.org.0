Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC541CBC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbhI2SY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2SYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 14:24:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A6C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 11:23:14 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h129so4359358iof.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Earei2TEE70xb1bWseb57XiUgCpp9bxruVgNh93/6gI=;
        b=U5IIFXjtJWGhAdjNtjprGM8G9DlTfya87vUG4dd+em8cisQPmw56Cd0ok0WE8lMRpm
         Bm2l8PyImS/NY7Fg38LxAOavBNPREojskYVeo7tZ5FE4SFEqjvaJR7i9TwYwuicRepI+
         N+TcRbSiMAhdBkN0Rm9UAB25k8yHwcqIsv1uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Earei2TEE70xb1bWseb57XiUgCpp9bxruVgNh93/6gI=;
        b=Ah4WZh156g5H8lH9RLyDH1fds/1bLqU+WFAAQhW3zqTV1Vw9luAtN3k9XIFmM2QsgO
         QJsvE44FudDjJSsaBoqr4BEm7uqXHb+aSok5l7NdynZUCT1cah1xdan3rSoD1QOF+7hu
         LYgio/Kmg7f/W2SOLX5ReSwHFkK/+ZaEiQYKtjly91rDXFszQQAQOLdYt5WqFvON+ikw
         mxwc9fFxNifD8HIkHZxoAq6QiyRrj1hm/rx2fAPwN9yEgJ5Di6FvtMA+K1db7SggOCJa
         J/QmN67l4Sc6ZQpirMQnQmkFQS1r0T79P7yMhmDzAqvpaV5LnZOJPS6eRpsrLREYVSCG
         81Xg==
X-Gm-Message-State: AOAM5329B1TEo3SbymJZLMmMU3A6dEoUPeHhaJI0j6IXdmIpW7pNtTQi
        n5ig6Dml9BoNMQg2dNk7WER17RZa197SaQ==
X-Google-Smtp-Source: ABdhPJxN/ddcXlF84gGxtiv5Ni4XQilYh9yy2HWB+mjVR8KTVFfb+zK5Wrq2GRzEPsqt5hNiKvaUJQ==
X-Received: by 2002:a5e:8d07:: with SMTP id m7mr859042ioj.31.1632939794130;
        Wed, 29 Sep 2021 11:23:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g28sm286045iox.32.2021.09.29.11.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 11:23:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
 <20210929144323.GQ4199@sirena.org.uk>
 <20210929153511.GB22029@willie-the-truck>
 <1b573881-ef9f-c7ae-c08b-8079f63f66ec@linuxfoundation.org>
 <20210929163721.GT4199@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ee671ef8-2fb6-ae8e-cd15-ee1b98390b3a@linuxfoundation.org>
Date:   Wed, 29 Sep 2021 12:23:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210929163721.GT4199@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/21 10:37 AM, Mark Brown wrote:
> On Wed, Sep 29, 2021 at 10:26:49AM -0600, Shuah Khan wrote:
>> On 9/29/21 9:35 AM, Will Deacon wrote:
>>> On Wed, Sep 29, 2021 at 03:43:23PM +0100, Mark Brown wrote:
> 
>>>> I'm not sure it's a particularly good idea to run kselftest as a
>>>> non-root user TBH, it's going to cause you to skip a lot of tests.
> 
>> We don't want Kselftest default run to be as root. Users can choose to
>> run as root which would be an explicit choice so they expect and plan
>> for the impact. Example panic test.
> 
> OTOH if you're trying to verify that the tests aren't broken it's not
> that great since it'll mean that you'll not be exercising a bunch of the
> code.
> 

Correct. Running Kselftest as root is the best approach for full coverage.

thanks,
-- Shuah
