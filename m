Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC61B1441
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDTSTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 14:19:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41302 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDTSTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 14:19:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so4248735pll.8;
        Mon, 20 Apr 2020 11:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7v8hOkx9WmIy3YT7d2v0dE+Bx4o1hmDGi8iBopJx8s=;
        b=BsySMqaAcPXGGn3krkyUXsewJQoYTRz0tKGMsHlPAXRyPv/5fPKZdgkH+UAFvykbhO
         NznnhAHnSm4GCUKUO3IFUdGpkLi2CJgwjcgOUVkINLB+MWy5xbdWRvAhI4Qxmf0NuPhM
         4ie+r/3mGnUJ3rmM9PJbJIaBsYnm1fuZx9BMokJecGwCxBg2cx2DJX1rF8qjuYJ/PWcC
         anG6IUNazIOCuq/uqGvz8wFC2yd9sYkiJFFdYOCar6htV78ITfMgrFop03Wi+NkxfgCd
         t4aQ1XzTn1RrxgE1gOr4emu8DySnxBh0po9L6gmlc9KWu8Q1XgCr8hYKeezaIzsZ1A34
         Q+4A==
X-Gm-Message-State: AGi0PuZtpZY1CA0GG0e6YLTjwakBJGhfVzWlSf3cE3033BsJXlvRzX13
        xb3gjY19tagqnpuIZ24CCfcMBLhG/W0=
X-Google-Smtp-Source: APiQypIXOYg11jQH19yBATdPxBOUTTvM6LmfAQB6BGlPXyvZz1WWKkiNQzkriWbPYZ8XEQCiV4mz3w==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr750807pjh.133.1587406772794;
        Mon, 20 Apr 2020 11:19:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j14sm35043pjm.27.2020.04.20.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:19:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 12DF74028E; Mon, 20 Apr 2020 18:19:31 +0000 (UTC)
Date:   Mon, 20 Apr 2020 18:19:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200420181931.GJ11244@42.do-not-panic.com>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 20, 2020 at 08:33:54PM +0800, Tiezhu Yang wrote:
> If module name is empty, it is better to return directly at the beginning
> of request_module() without doing the needless call_modprobe() operation.
> 
> Call trace:
> 
> request_module()
>       |
>       |
> __request_module()
>       |
>       |
> call_modprobe()
>       |
>       |
> call_usermodehelper_exec() -- retval = sub_info->retval;
>       |
>       |
> call_usermodehelper_exec_work()
>       |
>       |
> call_usermodehelper_exec_sync() -- sub_info->retval = ret;
>       |
>       | --> call_usermodehelper_exec_async() --> do_execve()
>       |
> kernel_wait4(pid, (int __user *)&ret, 0, NULL);
> 
> sub_info->retval is 256 after call kernel_wait4(), the function
> call_usermodehelper_exec() returns sub_info->retval which is 256,
> then call_modprobe() and __request_module() returns 256.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for looking into this. I still cannot find where
userspace it returns 256. Can you? If I run modprobe without
an argument I see 1 returned.

At least kmod [0] has a series of cmd helper structs, the one for modprobe
seems to be kmod_cmd_compat_modprobe, and I can see -1 returned which
can be converted to 255. It can also return EXIT_FAILURE or EXIT_SUCCESS
and /usr/include/stdlib.h defines these as 1 and 0 respectively.

https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/

  Luis
