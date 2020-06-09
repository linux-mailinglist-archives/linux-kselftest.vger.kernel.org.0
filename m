Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16181F476B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 21:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgFITrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbgFITrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 15:47:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA20C03E97C
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 12:47:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j189so19885355oih.10
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJHHkDUbokY+54DQEArYhqlw2m9nYTGAzxOkgAkUWeY=;
        b=WXtsedVfP3o1vfsUqp9SFhXoVaZT2RWMlQqJ1vHWpk3WyTLEZUd3NiMq6zfRqO5UbF
         BfIpm5z/znMwSry3ZVHTa6S4xXg78v+/9tgPGruWE0yDGTEZc2pbDGqgE6Osf3gwkU3N
         Vq7g07ijZN4PQD4Vr+wOiewFQEz1wW2dZAYhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJHHkDUbokY+54DQEArYhqlw2m9nYTGAzxOkgAkUWeY=;
        b=QsT+JVW1O/Aeu9FCxke+w7GPk935neIZ1UvYxx/C0U37ML4FuNpL+13hc/AAtu1ICN
         zVbXOiUjqDx/bJP0XpAuoJxtL5pjc9wRpbAlS+GTY41HfIUyaiFo2MPZ74j5irvzDQ3t
         zjZ2ExWYGP8UNoYZPxd3Z67nrUfl6KMVLT4Kssw46ZsX0OVnpjSieHVC95h7ph1+ayrl
         1BgxsdSGryh8/MGMKTqW3p4NiWatuuqcRhwXLfZg0jecZ4EnENfOaQTDK4Dvx9+O61zm
         f8KkhuyJHKKdNStbv/JR1b1onbfDwVPlBN5kjj1dsI2AICr1FuCV9Nz9ycKOEosqoIXQ
         fZQg==
X-Gm-Message-State: AOAM530UQbZ5BrGdg3NsxdUdt4wCZlFAyXtXevyqUi9apKrluKXOvDWH
        3F0mX2BilIySaO4Ymzyf0cOBYg==
X-Google-Smtp-Source: ABdhPJyrjWmHTMRP25i31oeVNd2eDv9bTCijGBLQDfU/kgKT+C11897+WkO+8gV7JrS+tHAmTk4Yrg==
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr4937372oif.42.1591732030191;
        Tue, 09 Jun 2020 12:47:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j46sm2369331ota.69.2020.06.09.12.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:47:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] tools: testing: ftrace: trigger: fix spelling mistake
To:     Steven Rostedt <rostedt@goodmis.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200609163853.1602-1-f.suligoi@asem.it>
 <20200609135235.608cdbf6@oasis.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6334f193-675d-80a1-ccb3-d007c8179bcb@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 13:47:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609135235.608cdbf6@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/20 11:52 AM, Steven Rostedt wrote:
> On Tue, 9 Jun 2020 18:38:53 +0200
> Flavio Suligoi <f.suligoi@asem.it> wrote:
> 
>> Fix typo: "tigger" --> "trigger"
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah, want to take this patch?
> 

Yes. I will get this one in.

thanks,
-- Shuah
