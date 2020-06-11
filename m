Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE81F6768
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFKMDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgFKMDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 08:03:54 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E2C08C5C2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 05:03:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t9so5945529ioj.13
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HQgdpKM4dEN15pdyKHWiwAPArlDUxZ7X6xmIoMk4KoI=;
        b=RLdsocZGxNbIqrwbRaCW9nAGeQdfkcRfB5yY9O+DueBvepvOjkQV8IqxnoEtk2MJXv
         xAse8W7GzRGAtvWUkdhPyzXkKFWPqU1IklWYBJ9daHebL0Jt9EzhNHv98oxbWb3R3Ue1
         aJ0Bj4REGLnCZ5Lc02q3FkpxKZkYAwG5WZuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQgdpKM4dEN15pdyKHWiwAPArlDUxZ7X6xmIoMk4KoI=;
        b=YSjQcaeyQbyA3eUhvNdYefccH+hTKJ9jCQYG1rIG0tJq8PNbarMcSjcWEVLCixhckB
         EzvFs9UO2Y2pF5XVqi5ZnNfonEwDxn2xwGbDoDySV8xXTVrppzkZ8S2W75Rzw99ZYMf4
         iiWTA5ApSfxxZTyHeCcErEdSkfsBJ1tXF1Xt4SvMt2zYMBheQERUqoFyxW0t/dXA11RX
         u6wQ9wdhwA0UIshtjJs/0hUNFqDPFbCYLMka4ZBi0f4feawzZveUpKTRCsWxgQqwWScE
         dT9g6xABtRXZ/eCJN++8ePUXtJoFUJDkdag2gsLqjKew1+ds8aS+b/MSfzsdvyDVolzA
         74Sg==
X-Gm-Message-State: AOAM531Ji8VuWRfTFA7hn7iIOeW5SQca2aeCFNpG2LVUFQb/kW9SI6UQ
        iKyW0YQfKJDAeJszXpr63yw95FcHSDQ=
X-Google-Smtp-Source: ABdhPJyWfGJ1+9lxeSa3Th0z/gkQYgnCXCMBoWdd2c0vXWG7F6qlix9bM8Er5mV/swuR/vh9eQiy5Q==
X-Received: by 2002:a02:298b:: with SMTP id p133mr2918838jap.73.1591877032369;
        Thu, 11 Jun 2020 05:03:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm1367881iog.49.2020.06.11.05.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:03:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
 <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
 <20200610093206.5b9fb1b7@oasis.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 06:03:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610093206.5b9fb1b7@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/20 7:32 AM, Steven Rostedt wrote:
> On Wed, 10 Jun 2020 06:04:33 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Steve, what would you think?
>>>    
>>
>> No worries. As far as kselftest tree is concrned, I can apply these
>> after rc1 comes out with Tom's patch.
>>
>> Or I can give Ack and Steve can take these through tracing tree.
> 
> All my patches have already made it to Linus's tree. Perhaps
> cherry-pick the commit needed from Linus's tree (it shouldn't break
> anything when Linus pulls it). Just let Linus know what you did, and
> everything should be fine.
> 

Good to know. I will get these in.

thanks,
-- Shuah

