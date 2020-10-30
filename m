Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797BD29FDBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 07:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3GP3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 02:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3GP3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 02:15:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D817C0613CF;
        Thu, 29 Oct 2020 23:15:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMsVk01pFz9sRk;
        Fri, 30 Oct 2020 17:15:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604038526;
        bh=DqLHWG5e2hCxBXi/w8h/yBrEq/gA139siSJr53GSAnQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RtST3msMsElHFgx9tVx8HvZ8wSTJbEFHxB/h+8+UnRV4f6GP67oX7t/MnfJZP11FQ
         LN876kHBqp7X+AvnE/4FSChHXHB2QANX1cFAbTx+XJHNKsCFrx6vEKhGjTTy0cEZR/
         LIBWDiGfJvLKxAv2FJgkRtOaTRzLPCv18HJ1vwxLwG7/ad9NXtWJLBDH7rD8icwhe7
         Nl0Z/zpj9sfme4jCCzTuSxjZXFtsr3udxbUNlksFiGZWbnL/ouSscMLW37DCPmyKcL
         C3ATC6vW6d0c0KXwGHK4OVmnpzRKrks9XZ+4pxD2pg06X4hzfEqGC+TF8/+w+NwaC8
         gTTFs8FajnOIw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/13] selftests fixes
In-Reply-To: <18daa545-b1d6-1867-fadc-cada628e2406@linuxfoundation.org>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com> <87tuufw2on.fsf@mpe.ellerman.id.au> <18daa545-b1d6-1867-fadc-cada628e2406@linuxfoundation.org>
Date:   Fri, 30 Oct 2020 17:15:25 +1100
Message-ID: <87o8kkutmq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 10/27/20 7:37 PM, Michael Ellerman wrote:
>> Tommi Rantala <tommi.t.rantala@nokia.com> writes:
>>> Hi, small fixes to issues I hit with selftests.
>>>
>>> Tommi Rantala (13):
>>>    selftests: filter kselftest headers from command in lib.mk
>>>    selftests: pidfd: fix compilation errors due to wait.h
>>>    selftests: add vmaccess to .gitignore
>>>    selftests/harness: prettify SKIP message whitespace again
>>>    selftests: pidfd: use ksft_test_result_skip() when skipping test
>>>    selftests: pidfd: skip test on kcmp() ENOSYS
>>>    selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
>>>    selftests: pidfd: drop needless linux/kcmp.h inclusion in
>>>      pidfd_setns_test.c
>>>    selftests: android: fix multiple definition of sock_name
>>>    selftests: proc: fix warning: _GNU_SOURCE redefined
>>>    selftests: core: use SKIP instead of XFAIL in close_range_test.c
>>>    selftests: clone3: use SKIP instead of XFAIL
>>>    selftests: binderfs: use SKIP instead of XFAIL
>> 
>> This series doesn't seem to have been picked up?
>> 
>
> I applied them to linux-kselftest fixes yesterday.

Thanks.

cheers
