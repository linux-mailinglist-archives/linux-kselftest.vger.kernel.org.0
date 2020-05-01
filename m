Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580D31C17B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgEAO2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729050AbgEAO2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 10:28:08 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D89C061A0C
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 07:28:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u11so5028961iow.4
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qFn7gkPMpYmrr60w9n8c1qnQXMXv7MA2WqU4Vb048CQ=;
        b=FSHjDh6mE+SLHTo6uWK4BNB8pkEFPuJ3ZSajl02AKtDC/z4FJ3yaVftHc9hD7WkgRU
         oXoAj94KsBc/Q/sLhnXx/DtzkcJpdwoJ7SEAoIquOgp26bYuxGDlTNcRFgOjIlvn4G+H
         StEyTreXxgB+tJCSwnGCNmzEjAnnz+MJpCWUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qFn7gkPMpYmrr60w9n8c1qnQXMXv7MA2WqU4Vb048CQ=;
        b=UsKIQxYVGgwo/xwrCSu6AcbvvWwkcX675n7HxNzLIR6/N1X7DWR7uScEwEZeqAid0A
         Mt8fqpvWooIdUB2jc1jl2oyIp3yStXbsxoY8g94kJI3mGb/zT+yTlKeHcr15JkAJ04Gc
         wyyt694XiZCSvj/Ky/WdOQyFQ1UioDhymwPdq+xGPNmetlb11HxmD7HQrY7WeANWe/X5
         FaL99zMFBDAW1r9lW6RylvrCoFGqwofD9fX06CZnSiXJXCkAQw+OT0XRE/PpXnkYbmMA
         uJTvpIAPbHLCdT8MU75cQnqulfKuR2ceInKkc7jPbRo4zfBHWylZclfQBxqOCMBvvreY
         W1iQ==
X-Gm-Message-State: AGi0Pua90xqSDZg28bKKi0uE3GlpQFljTiwtF72YNKr8Ri1oj6cgmsFD
        /yrwKjglWTDu+ACll1M6YE961A==
X-Google-Smtp-Source: APiQypIV8SjoKr6rXC8O9phDKiSS9vCYzDsnS8K9NLjxFVbMq93JYaDRdRC3XWg84TcQ0M0SFZvnkA==
X-Received: by 2002:a5d:96ca:: with SMTP id r10mr4033777iol.19.1588343286616;
        Fri, 01 May 2020 07:28:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p7sm1027884iob.7.2020.05.01.07.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:28:06 -0700 (PDT)
Subject: Re: [PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for dash,
 etc.
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <20200501102113.151d38c1@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5334156d-a8f8-9eeb-f6d9-299992582c6f@linuxfoundation.org>
Date:   Fri, 1 May 2020 08:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501102113.151d38c1@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/1/20 8:21 AM, Steven Rostedt wrote:
> 
> [ FYI, Shuah responds better from her linuxfoundation.org email ]
> 
> Shuah,
> 
> Feel free to take the first two patches of this series (I acked one, and
> reviewed the other).
> 
> The last patch I had some issues with, and is still under discussion.
> 
> Thanks!
> 
> -- Steve
> 

Will apply the first two.

thanks,
-- Shuah

