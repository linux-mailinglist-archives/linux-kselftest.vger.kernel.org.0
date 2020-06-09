Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E961F4838
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgFIUlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFIUla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 16:41:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79CC05BD1E
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 13:41:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x202so20052488oix.11
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vX1/6HJoQCcRM+qq9131VZla5JA4KT3mXRX75cnko3A=;
        b=BrYL37H9Bk7uAEUNaMcwXjG/MNCjhC3iNpF6ZpT63kqQij83xH0gjlVwJVXqCLTVgF
         oA+ilSfSsSO5ACPPj7GmlgxSnRXUArbtbwmKkqZhSYRuNkUcNN8UY0LzNKArLVbavEHR
         C7pTHhl94ZiniANQJg6iOCEPHGn/MDS6unvzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vX1/6HJoQCcRM+qq9131VZla5JA4KT3mXRX75cnko3A=;
        b=Vah1fb6FZCnYrf/A3c8dfaMARmDKO+/TMkeSYKJl6OurgWjpHbLm4HXz4NtiXqu1FY
         Nt8m9DAbS7nH2I5apj6OOX9BFRBhbf4K5gwTGEeLvjw6K7dXEhPEmRTxvdikkpt9w2be
         pF/utFVgc3exxlE9iM5omNf4tFEP3PsxtElYCEIwGZU76ZUTb79A4vl7TJkUidR6uiv+
         66G3BPE73f1yoZjNhKlOP6dbvZ7IbOth8Fh3x/9UMvzH10GR+ITCv8R9SDXdxZXQ7g+c
         DTZV/nAwm72Dyb86TkSj5cTzyY9OBWIl3OkjAKhnzgstPFH97HL4zgo44dgsIBJxRk5l
         nV4A==
X-Gm-Message-State: AOAM530I3ucTLfLSxEXpPvS/q0Q9iQsYb7abwWn5WxMPxyT0ZoZqH6X/
        Khjnt1cLpvDTUpazokDKoZkNvg==
X-Google-Smtp-Source: ABdhPJzFMYW52w9uV8RuAmlTsOq4u2EKyDf2AQRspYRj1FSp4o+2To75XIoFy3P2h0L/XxIRfYT1MQ==
X-Received: by 2002:aca:ed42:: with SMTP id l63mr69310oih.101.1591735289482;
        Tue, 09 Jun 2020 13:41:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h189sm3394193oif.10.2020.06.09.13.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 13:41:28 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 14:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159115203782.70027.2241223276591824366.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/20 8:40 PM, Masami Hiramatsu wrote:
> Convert the required tracefs interface checking code with
> requires: list.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> ---
>    Changes in v2: Fix trigger-onchange-action-hist.tc requires list.

Masami,

This patch doesn't apply to linux-kselftest next

Patches 1-3 applied fine and this one failed. For now I will
hold off on applying this series.

thanks,
-- Shuah

