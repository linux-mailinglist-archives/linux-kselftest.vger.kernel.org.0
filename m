Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359873111E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhBESXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 13:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhBESVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 13:21:46 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB37C06178A
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 12:03:23 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e5so1231278otb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbEhNHNmugKLJCiX2KXjV/LxdZ+gCz+sfTdhU2+sb8o=;
        b=hbBndiN61VScugSn8g5PdH5dOEpNc1vTlDgcO3sD8O0Q6YfsnCaurJGZNYTTpb+NeL
         2C00ky9tWgh3CuOv2jxbTmdNpPk9XqWrjq7gXRCFpc/iaSrlsuWJa6bt03UGWa5Rq276
         hTV4GgzREQQ4e8s4GIvRWcWvDOh9qfgu3LyAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbEhNHNmugKLJCiX2KXjV/LxdZ+gCz+sfTdhU2+sb8o=;
        b=YhsKrvQUYW6v1cDTV6vng5bguiLAlGzAE8kRx65yEu29VcNGdiW2x7QnODmkmYzCsF
         vskpjtSlTAUAEaACMoHaj9yyvHviclmvseaZUMkgBh7W83oaEG4avwHU6oxmvsUbCn6A
         J+0nrw9LSZUB3R1l8VgSX8nOllGzRixog7BLUaD5krvds2HDn3rTszoMszJ/hY1u0Gj6
         PKPmFpARnDBcYMvCYeveegndBlgjnLwfxiXeR/f6cCtMRcrtCWvORVwHn74gh72hy1AP
         5FERlIYd7a8x4hQTLeFQwR36awa0ieAt+lPg5fB0DfnJxpqCAikLPPkS4sf3jAr/Q3z4
         sr2Q==
X-Gm-Message-State: AOAM532N3j7EoDTQACWAkuAnmJQ/5bj6KtQNoyTNIwEv+g2/XGp/Z+FZ
        kyTFCosmT2X5XCCwS5bvDUUFSz+Cdlapyw==
X-Google-Smtp-Source: ABdhPJyzu0tvcLo4s7d2FrIQ4o1zmYD8+me/HyP+MRVvqQ5v4ul3YMRLWMniCJpUPs1SigUqE0QdTg==
X-Received: by 2002:a05:6830:1dad:: with SMTP id z13mr4489856oti.223.1612555401135;
        Fri, 05 Feb 2021 12:03:21 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m7sm2002833otq.33.2021.02.05.12.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 12:03:20 -0800 (PST)
Subject: Re: [PATCH v3 1/7] seqnum_ops: Introduce Sequence Number Ops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, peterz@infradead.org, keescook@chromium.org,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, devel@driverdev.osuosl.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1612314468.git.skhan@linuxfoundation.org>
 <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
 <YB0WzBnLd+OcpxEE@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2fe15f90-2e33-d018-0d5d-cabe3846ed98@linuxfoundation.org>
Date:   Fri, 5 Feb 2021 13:03:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YB0WzBnLd+OcpxEE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/5/21 2:58 AM, Greg KH wrote:
> On Wed, Feb 03, 2021 at 11:11:57AM -0700, Shuah Khan wrote:
>> +static inline u32 seqnum32_inc(struct seqnum32 *seq)
>> +{
>> +	atomic_t val = ATOMIC_INIT(seq->seqnum);
>> +
>> +	seq->seqnum = (u32) atomic_inc_return(&val);
>> +	if (seq->seqnum >= UINT_MAX)
>> +		pr_info("Sequence Number overflow %u detected\n",
>> +			seq->seqnum);
>> +	return seq->seqnum;
> 
> As Peter points out, this is doing doing what you think it is doing :(
> 
> Why do you not just have seq->seqnum be a real atomic variable?  Trying
> to switch to/from one like this does not work as there is no
> "atomic-ness" happening here at all.
> 

Yes. This is sloppy on my part. As Peter and Rafael also pointed. I have
to start paying more attention to my inner voice.

thanks,
-- Shuah



