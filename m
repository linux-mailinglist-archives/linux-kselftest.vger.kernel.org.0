Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139E03F9004
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 23:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbhHZVLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbhHZVLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 17:11:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC20FC0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:10:16 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c79so6475544oib.11
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7GKHdf2p8fphtERfUISgtXjHHz3WcX1QShcGLuwJ+g=;
        b=T//z0xjg0lM2E4tZW6DmVx/GnCNpgj2rZfNqunM1VKCbQi2+uvmxSXiSvQfbbyRexN
         /2uT3QDIbw0boQJlRukGRHita9nbOH8Yd2+FdgrHPl+8+43Cas6V4mLlTpEN8J+RqKer
         FDWR27tv8CeTDfZgcbvWFsBTRm7CJ4Pju6/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7GKHdf2p8fphtERfUISgtXjHHz3WcX1QShcGLuwJ+g=;
        b=ZZ5ZCqZjXfXQWuA5XIZ7xmsYmVPfJYwbdbBJ1xq1Pi71ZEgDiy1hNn/6Zuo1RIdXiZ
         cPf3tLXKK1CpJ9mEPGOhTh1HLbhTOLp7TZMtRhyT8nie29DAor1hO+XnvLL3ibCDs33K
         RCapS+18YJvbXYKPy3Mj+zTfmhBBgw2ldzaAGztYz8O7JtRpI0Q2subffil1nJk8zL77
         ylQFqLkO4jxFthRnUlHvayyzLnQqdJxlZThWKOTiBijYKW7wPgnZSwLTRFick3O2Mkcj
         SVkm6HfUyXPVEjskbKsQEIkbrUgcqBIRkiWcFl/XJuyP4N6Fwsg2yAl/haIfwpPuzAm0
         97jA==
X-Gm-Message-State: AOAM532TJuJkISNbIott9SEnSGsAzVhbX+8luPQwviFgpT/cpgXebaRa
        7CPtvAPk0oIEiJ0tF9bi78sjbtiQif3cvww6
X-Google-Smtp-Source: ABdhPJz8ERQxP1kP6H/EV924iv9JWOdlBbk/fN20trsAUG7NDTQZsbPNCnq5wtsKIOcKsvS9ApCX3g==
X-Received: by 2002:a54:4104:: with SMTP id l4mr12653710oic.126.1630012216289;
        Thu, 26 Aug 2021 14:10:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i19sm846473ooe.44.2021.08.26.14.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:10:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <239339d5-5626-ea04-97db-7dc070a48636@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:10:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/25/21 7:58 PM, Li Zhijian wrote:
> SYNC was removed since aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
> LKP/0Day will check if all configs listing under selftests are able to be enabled properly.
> 

Can you please state what you arr fxing and also keep the sentences
75 chars or less.

Where is LKP warning? Include the warning and explain why this
change is necessary.

> For the missing configs, it will report something like:
> LKP WARN miss config CONFIG_SYNC= of sync/config
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

thanks,
-- Shuah
