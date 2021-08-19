Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280053F21E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHSUwY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 16:52:24 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46621 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhHSUwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 16:52:24 -0400
Received: by mail-lf1-f41.google.com with SMTP id u22so15597278lfq.13;
        Thu, 19 Aug 2021 13:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3cvCpxfRoQDlHVtpQTz35oWEBjIU7MK3I1RSPqUnTI=;
        b=Ci2M2cmrls84+ZsnE6g8PE1F4sbF+AIJoR/E/rGxXu5lFC+ofNb0jf68fdoJbKr4ls
         ww28XMfq9Laceu0zxAnbfNxaTSR+3ass0YBDRMS8Od8AJA+DgakunNCjaQ8bfjrwPrgb
         OKBF4iP9WAk1KBDbAVhhW5EjCwIo1axge/VCg/XJK/cPRijDMMwcwpRDJwiGYlyIeBlr
         2HXHBbO1quS4y3JTSI3yOFkTaFUBb9BDN0C35kfVkYqEUrcH5D6WZSpdDmmKHcZtjzeR
         Tk4bGOsDtAiyQ4e3MIYZdOW4FJFKnm+T8TRWiRspnwBEU5V2VLMrcSI8iF9DHNi++oRc
         f3Rw==
X-Gm-Message-State: AOAM533VZXzXYx9esgEl0toi94pHhqOJLwO1y+JX6WQX74RIFeb+gSow
        D3n9lD7leq7DVoA8csCOmY8=
X-Google-Smtp-Source: ABdhPJyH+1pHjJRPJ/Gv9OmJagVmP+KiDmOpZseeuc6ergP/QT3L2z4VNpY4WbR51bSnxOspglp28w==
X-Received: by 2002:a05:6512:3890:: with SMTP id n16mr11644678lft.240.1629406306010;
        Thu, 19 Aug 2021 13:51:46 -0700 (PDT)
Received: from [192.168.1.109] ([213.87.152.233])
        by smtp.gmail.com with ESMTPSA id w32sm254878lfu.158.2021.08.19.13.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 13:51:45 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] gen_initramfs.sh: use absolute path for
 gen_init_cpio
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
References: <20210818154646.925351-1-efremov@linux.com>
 <20210818154646.925351-3-efremov@linux.com>
 <CAK7LNASTa+_d17wF6NW6GHC7Y+_RrXYZuo0MzzbsNnaRn8KJuQ@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <e90603ee-61e0-4530-34dc-087e40c94aa1@linux.com>
Date:   Thu, 19 Aug 2021 23:51:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASTa+_d17wF6NW6GHC7Y+_RrXYZuo0MzzbsNnaRn8KJuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/19/21 3:24 AM, Masahiro Yamada wrote:
> On Thu, Aug 19, 2021 at 12:47 AM Denis Efremov <efremov@linux.com> wrote:
>>
>> Use absolute path to call gen_init_cpio. This allows one
>> to use gen_initramfs.sh from any directory.
> 
> I do not mind this, but $(dirname "$0")
> is not necessarily an absolute path, is it?
> 
> 
> I added test code:
> 
>    echo dirname is $(dirname $0)
> 
> in this script, and I saw
> 
>    dirname is usr

Oh, sorry, commit message is wrong. Would that be ok for you if I will change
it in v2 to something like:

Prepend gen_init_cpio call with the same path as gen_initramfs.sh called. This
allows one to use gen_initramfs.sh from any directory, not only from the
kernel's topdir.

> 
> 
> 
> 
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>  usr/gen_initramfs.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
>> index 63476bb70b41..2e4a86181c79 100755
>> --- a/usr/gen_initramfs.sh
>> +++ b/usr/gen_initramfs.sh
>> @@ -244,4 +244,4 @@ if test -n "$KBUILD_BUILD_TIMESTAMP"; then
>>                 timestamp="-t $timestamp"
>>         fi
>>  fi
>> -usr/gen_init_cpio $timestamp $cpio_list > $output
>> +"$(dirname "$0")"/gen_init_cpio $timestamp $cpio_list > $output
>> --
>> 2.31.1
>>
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 
