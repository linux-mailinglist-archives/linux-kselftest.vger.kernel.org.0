Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47FE4A8BDA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 19:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiBCSqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 13:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBCSqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 13:46:54 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE439C061714
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Feb 2022 10:46:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c9so2910205plg.11
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Feb 2022 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=6cmuVf7iCIkZMywvQSN2+djuwKhrInrnUCD1m9svnSw=;
        b=Ge/5BUJ6OdBZmtQWxfOnNrE/OJ21bNmEylbeLKozrhVlapVZWfthTHLNTCeTf0VwRv
         9hH7pZLyEY8hejvqLyXs3y3aai8mRTQHk7feYmMlKIdIJULA9+XRfkoCXlmJNpdmMNiL
         Zb35QE5KCdt6AJ7SQWQz2Z7n9XoCQx+G8+wEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=6cmuVf7iCIkZMywvQSN2+djuwKhrInrnUCD1m9svnSw=;
        b=SsISj3BB9oPj6/imBxv8gJwjgbu+K8IWSldm/LyIWEZerZQ5LcVxKhzMbKk0ysVJ/9
         7YWoyfPpMsCDS09ZRk88HmA5MQ+D+dFvkytc4bm5hM5av7D0UDKslX1mOZ2Hx4zuWhMk
         mRRhWFWW2eJIw7lC+WoVXawUjimZC6Kj3EyH8xbPp1eQME4nwpn9sC8Tt320aYaSoUX+
         QJddib8Rtw/iLxkb8m6dxdBVMMocqptZk37Q544BgjArSB7nazbKHN61XVqS8l1GLg+X
         S27CeIPKrk76nrmgCUD3gLdGKAJOvGJGg3LFkzYxMieoPTsjplIIiVVnlxxq+JqrRAhE
         MOeg==
X-Gm-Message-State: AOAM532eN9pDfKHzomieu4pK5ZHTEU0p7f/TVfuNweku/ItbEjGroC0y
        DKT02YUI12lTZDBzKdHxDhttKA==
X-Google-Smtp-Source: ABdhPJxxsUQcjkIr3SdPvm+yAkCaphoBg60yLvYU1TeyZEE0HGQcXRw1ClooajCEh4BpHO4Io+iLcw==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr35966883pls.126.1643914013442;
        Thu, 03 Feb 2022 10:46:53 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb90:3395:d30d:5452:c102:c721:b78d])
        by smtp.gmail.com with ESMTPSA id a125sm21608940pfa.205.2022.02.03.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:46:53 -0800 (PST)
Date:   Thu, 03 Feb 2022 10:46:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Sherry Yang <sherry.yang@oracle.com>
CC:     linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_selftests/seccomp=3A_Fix_sec?= =?US-ASCII?Q?comp_failure_by_adding_missing_headers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
References: <20220202201118.13933-1-sherry.yang@oracle.com> <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
Message-ID: <6BFED8FC-8368-4F00-9C71-B4E30DC7A5D6@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On February 2, 2022 1:17:25 PM PST, Shuah Khan <skhan@linuxfoundation=2Eor=
g> wrote:
>On 2/2/22 1:11 PM, Sherry Yang wrote:
>> seccomp_bpf failed on tests 47 global=2Euser_notification_filter_empty
>> and 48 global=2Euser_notification_filter_empty_threaded when it's
>> tested on updated kernel but with old kernel headers=2E Because old
>> kernel headers don't have definition of macro __NR_clone3 which is
>> required for these two tests=2E Since under selftests/, we can install
>> headers once for all tests (the default INSTALL_HDR_PATH is
>> usr/include), fix it by adding usr/include to the list of directories
>> to be searched=2E Use "-isystem" to indicate it's a system directory as
>> the real kernel headers directories are=2E
>>=20
>> Signed-off-by: Sherry Yang <sherry=2Eyang@oracle=2Ecom>
>> Tested-by: Sherry Yang <sherry=2Eyang@oracle=2Ecom>
>> ---
>>   tools/testing/selftests/seccomp/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/s=
elftests/seccomp/Makefile
>> index 0ebfe8b0e147=2E=2E585f7a0c10cb 100644
>> --- a/tools/testing/selftests/seccomp/Makefile
>> +++ b/tools/testing/selftests/seccomp/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2=2E0
>> -CFLAGS +=3D -Wl,-no-as-needed -Wall
>> +CFLAGS +=3D -Wl,-no-as-needed -Wall -isystem =2E=2E/=2E=2E/=2E=2E/=2E=
=2E/usr/include/

This didn't look right to me=2E That's outside the build tree, yes?

I thought missing headers had been globally solved already for the selftes=
ts? Going looking, though, I think I'm thinking of the KBUILD_OUTPIT work=
=2E Hm=2E

I thought there was a proper "updated kernel headers" dependency that shou=
ld be used for this?

-Kees

>>   LDFLAGS +=3D -lpthread
>>  =20
>>   TEST_GEN_PROGS :=3D seccomp_bpf seccomp_benchmark
>>=20
>
>Looks good to me=2E Adding Kees Cook for his review of this change=2E
>
>thanks,
>-- Shuah

--=20
Kees Cook
