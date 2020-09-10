Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664FE2652A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIJVVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgIJOYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:06 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E849C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 07:10:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t13so5761378ile.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJnJs8vNdF1wP9aLBCzGabaxQxUsTtglU7hU8j+gZEY=;
        b=hvo+fr9Yln8JetuGtTjqIFv+2TLIvn6Rn/7c9U7e2qYqdviGUYuoisvGVPcaNZyZsg
         wWW+P3xsgfnkVC3hoPch9gKhLnpSiXPNmEU+rbRMtTHLYvl7z2Fs7wBIxmmOb0CAXFib
         sMFaRLjx/pNkR190V8TCooR6vii9nHQw19DWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJnJs8vNdF1wP9aLBCzGabaxQxUsTtglU7hU8j+gZEY=;
        b=HcxQ03M7Wr+9M2VKYkcfhSnqT7qPlFRzxVuBCJOLEfSXMKKtwyKZyCkxL3Njd3KaS4
         FLMmaIfyt9zv5SRtQ/pNpEUpBREOeFK/cdpULCVibJm/F1PDc9mFIMdg5QabLmWNzwyO
         iEh9np71hz01gbHPGXT0Xe3meeDGXMnZl2BcNwElex1LD9rzYqR2eNYiQP9x6OIIgs+O
         Cuv9UBzHX++EX+hqrByHRPu/HmRep9A1uO9uORDy+yfru5nMZCrAv/UMTYc3Ep/F/PRk
         UFN05bxTclq0wH6awTMs7Zmjpb1KELCjn+EsR0kX4uKxGxwzWdI25w1WWUd9KtGa1OXb
         mtpw==
X-Gm-Message-State: AOAM533Ubw10GGam6m5wGtZXIlmzn2pQwXHOBRJNUtPoklhKxcu4vOAD
        ek1Vostbd0rivA4f9AI1F1z/QQklW7Hu5w==
X-Google-Smtp-Source: ABdhPJyvQbZVznJNNJizOCvgulAwN47Npavr3DbFPT7h3sHAcICA5Cp6cueyl9J0d1M9fE2qVc3r2g==
X-Received: by 2002:a92:7a0a:: with SMTP id v10mr7012115ilc.99.1599747056972;
        Thu, 10 Sep 2020 07:10:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w8sm3276471ilc.85.2020.09.10.07.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:10:56 -0700 (PDT)
Subject: Re: [RFC PATCHv2] selftests/run_kselftest.sh: make each test
 individually selectable
To:     Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200309101256.868-1-liuhangbin@gmail.com>
 <20200316072626.24037-1-liuhangbin@gmail.com>
 <CAPwn2JR=WzpuMjA=x+39GFAbXpTFLt16bcD37LyfH5NtU=Mqvw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <accf2bd8-086a-1047-e751-cf79df008fc7@linuxfoundation.org>
Date:   Thu, 10 Sep 2020 08:10:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPwn2JR=WzpuMjA=x+39GFAbXpTFLt16bcD37LyfH5NtU=Mqvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/20 7:20 PM, Hangbin Liu wrote:
> Hi Shuah,
> 
> What do you think of this change? Any comments?
> If you are OK, I can rebase the patch and repost it.
> 
> Thanks

Looks like a good addition to me. Please rebase and send
the patch to everybody get_maintainers.pl recommends.

thanks,
-- Shuah
