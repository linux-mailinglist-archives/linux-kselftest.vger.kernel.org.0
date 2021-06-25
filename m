Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936273B3C9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYGY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 02:24:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52022 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhFYGY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 02:24:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 538731F442C0
Subject: Re: [PATCH 0/9] LKDTM: Improvements for kernelci.org
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
References: <20210623203936.3151093-1-keescook@chromium.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <030c022b-985a-16eb-b9d7-73b6fed2d5a9@collabora.com>
Date:   Fri, 25 Jun 2021 07:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/06/2021 21:39, Kees Cook wrote:
> This is a bunch of LKDTM clean-ups to improve and expand testing,
> given feedback from testing at kernelci.org. Adds a few new tests as
> well.
> 
> (If a pull-request is preferred, please let me know.)
> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (9):
>   selftests/lkdtm: Avoid needing explicit sub-shell
>   selftests/lkdtm: Fix expected text for CR4 pinning
>   selftests/lkdtm: Fix expected text for free poison
>   lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
>   lkdtm/heap: Add vmalloc linear overflow test
>   lkdtm: Enable DOUBLE_FAULT on all architectures
>   lkdtm: Add CONFIG hints in errors where possible
>   selftests/lkdtm: Enable various testable CONFIGs
>   lkdtm/heap: Add init_on_alloc tests

Tested-by: "kernelci.org bot" <bot@kernelci.org>


This whole series was tested on top of next-20210623, here are a
couple of sample results from KernelCI staging:

Clang 13 on AMD x86_64:
https://staging.kernelci.org/test/plan/id/60d4a5ce3d2bc535d924bf25/

GCC 8 on Intel x86_64:
https://staging.kernelci.org/test/plan/id/60d570711a3d6beefe24bf26/

And this is where the series was applied:
https://github.com/kernelci/linux/commits/a9f4387015268e426c77fd51ed846c9756938828


Thanks,
Guillaume
