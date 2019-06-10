Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8F3BF2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbfFJWIO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jun 2019 18:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390036AbfFJWIO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jun 2019 18:08:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317032082E;
        Mon, 10 Jun 2019 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560204493;
        bh=e8XjUFtZMStDPYS3FRKtj43AwF2CGKnQQ24s2uVvYvo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BIlELQVmQiXsINDdVkW14pOS9K8s3Gx2mingJ1IaepHxagdpMTpD4ZzyEKsLXADQu
         LDDLzvbv2yQR2aXp8ujaMwhG5b7sVH+1JVNw3f8Wr643gACxp2ikFsJnG7lIjoeKQt
         enV0L8Nd0qyRS4RKerZLlzNTADXiWwd0A8vbWeho=
Subject: Re: [PATCH v16 16/16] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>, shuah <shuah@kernel.org>
References: <cover.1559580831.git.andreyknvl@google.com>
 <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
 <201906072055.7DFED7B@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <2bc277f8-e67e-30e0-5824-8184c2b03237@kernel.org>
Date:   Mon, 10 Jun 2019 16:08:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906072055.7DFED7B@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/7/19 9:56 PM, Kees Cook wrote:
> On Mon, Jun 03, 2019 at 06:55:18PM +0200, Andrey Konovalov wrote:
>> This patch is a part of a series that extends arm64 kernel ABI to allow to
>> pass tagged user pointers (with the top byte set to something else other
>> than 0x00) as syscall arguments.
>>
>> This patch adds a simple test, that calls the uname syscall with a
>> tagged user pointer as an argument. Without the kernel accepting tagged
>> user pointers the test fails with EFAULT.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> I'm adding Shuah to CC in case she has some suggestions about the new
> selftest.

Thanks Kees.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
