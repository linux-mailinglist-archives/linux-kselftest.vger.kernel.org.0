Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAD1C7544
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEFPqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFPqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 11:46:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3502C061A0F
        for <linux-kselftest@vger.kernel.org>; Wed,  6 May 2020 08:46:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id m5so845523ilj.10
        for <linux-kselftest@vger.kernel.org>; Wed, 06 May 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QT2YN6oqKqg6700ugZaaaxIxPh7KJTUan3y27PnGKts=;
        b=J/GhKerOoarXIYXI3Rx+JWkjRs7CCOiRPgY+0225MXwMQMVB0it64dmgW6lpUI5o0Q
         yH6/E22JHPpFY7NS7CnEvTyK9tFqq1yV9g6N4rAbwlqaUOry02ETNNre4XdxElRL19F2
         pNHdP5k4fWMSt7askz6QOiDDWXSO/VoIe0Fh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QT2YN6oqKqg6700ugZaaaxIxPh7KJTUan3y27PnGKts=;
        b=Vnw36VG36fJmsg5/+oG87qfBtQAXRkvg3BbCCrbvJ15+DKneYTLTDqW3tIbnsSoXVr
         GBi5RftEtHP5dWjrPgmWn5m9tibIPTz7jqvSjdikkrCuPvzHT7KlyB31vUyceDRfFVqb
         2YWVsMUN7ChxYewUwK9wk8bMbZ3VtKm8A9PGTnzTaEVD2xSHMAVOq5E8xBNrDP+3wyVu
         HiqRU5Cc4QQ6h6VTMi+YzgWVL2/fsvBbA1XTyiURxrSLLLMF5FBLLDHYWFgP2Kjqy/cs
         WqdPGsYNQEuorQFCN6PNa+lWcVBmV8Y5gDFo1LnhxOt4/1j8Ha6nHLNbbqqYvhjMdy6I
         wdpg==
X-Gm-Message-State: AGi0PubM3vykMvuY12W2dIrJycx7GSb6rp1MVPbVMY2ILKWfRSAWoWHw
        k3sPT+ql/q485+8G/QresPfnjA==
X-Google-Smtp-Source: APiQypIkBH8t6x3OXeefHkp9yWiD5BTjf+mpTuKXbtUT2nXa+csoEMlMwpIi8Fir10PaPz6LZpH1Cg==
X-Received: by 2002:a92:1949:: with SMTP id e9mr9877680ilm.106.1588779973174;
        Wed, 06 May 2020 08:46:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t1sm1208096iln.4.2020.05.06.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:46:11 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
To:     Steven Rostedt <rostedt@goodmis.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
 <20200505090912.7114f420@gandalf.local.home>
 <CAMy_GT8r8H21Ly3N5VFkiPi0qUCkPCvy8SU3Ns2vesaS8xvffQ@mail.gmail.com>
 <20200506114351.1b45e82f@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac9c5f4a-3288-0f6a-dbb7-1b7dcd0c7a87@linuxfoundation.org>
Date:   Wed, 6 May 2020 09:46:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506114351.1b45e82f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/6/20 9:43 AM, Steven Rostedt wrote:
> On Wed, 6 May 2020 09:46:21 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
> 
>> On Tue, May 5, 2020 at 9:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>
>>> You keep forgetting to Cc Shuah's other email.
>> Thanks!
>> I got the recipients list from the get_mainter.pl.
> 
> Hmm.
> 
> Seems like that is what get_maintainer.pl does:
> 
> Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
> Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> linux-kernel@vger.kernel.org (open list)
> 
> And looking at the code, it appears it will only take the first email
> address found in the file.
> 
> Shuah, if you prefer the linuxfoundation.org email, you need to update
> MAINTAINERS file to have that one first.
> 

When I updated the MAINTAINERS file, I was hoping both addresses will be
in the output. It doesn't appear to be working the way I assumed it
would. I will send in patch to update to switch them.

thanks,
-- Shuah
