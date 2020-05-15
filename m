Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F61D4383
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 May 2020 04:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEOC16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 May 2020 22:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOC15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 May 2020 22:27:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A4C061A0C;
        Thu, 14 May 2020 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=l1ppkroZfvKOp4u6lj/eUcZNGxMPKtmd0dNs/JoZOcs=; b=GOJTHYCdm8PWaqtRIRy+tTqWfk
        dxtkHibSZBFuZsmpFbeFHDoireSy0SHOec4elKy943mhmou6V2eLmxVvtfufl7vBHC9YnwoluX7MO
        tIFEvqqHRc0DDFahtcHgmGAt10A9PikQO8NcRpcTaStoulfv5qlspULTyTuWinpvdMrIWkMwEUfGr
        PAMZ/Qsqj+oQF4pgYKhd+EtbYUMoq7caH+qPcJkJykiU69/g7n9wxKe8HKrFV+g4oACaBsrPXajU8
        8f2+25D88bzWXC0zljNVsxMsfmSIn15MAIK4Ch0lyph4QG9IUK7XScJAKtcZEDZmlo2iWhghxcLz0
        4YKVXXbA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZQ4r-0005MB-6k; Fri, 15 May 2020 02:27:57 +0000
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from
 cluttering top level objdir
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>, shuah@kernel.org
Cc:     mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
 <7hwo7qijn0.fsf@baylibre.com>
 <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <11765b79-f19c-4aea-5c4a-d9ad24e550de@infradead.org>
Date:   Thu, 14 May 2020 19:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/11/20 4:31 PM, Shuah Khan wrote:
> On 3/11/20 4:58 PM, Kevin Hilman wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>
>>> make kselftest-all O=objdir builds create generated objects in objdir.
>>> This clutters the top level directory with kselftest objects. Fix it
>>> to create sub-directory under objdir for kselftest objects.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Only somewhat related to this patch, another problem that wasn't in your
>> doci is that the current O= support doesn't support relative paths.
>>
> 
> Yes I am aware of it and it is in the document as something that will
> be addressed later.
> 
> "Note: Relative paths don’t work - supporting relative paths breaks work-flows e.g:
> powerpc. Explore fix. Compile work-flows. Not planning to support at the moment."

Hi,
Sorry to be dense but where is this documented (as quoted above)?

Thanks.

>> For example, using O=/tmp/build-arm64 works, but O=build-arm64 doesn't.
>> Try this:
>>
>> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
>> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 kselftest-all
>> make[1]: Entering directory '/work/kernel/linux/build-arm64'
>> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>>     ARCH=arm64 -C ../../.. headers_install
>> make[4]: ../scripts/Makefile.build: No such file or directory
>> make[4]: *** No rule to make target '../scripts/Makefile.build'.  Stop.
>> Makefile:500: recipe for target 'scripts_basic' failed
>> make[3]: *** [scripts_basic] Error 2
>> Makefile:151: recipe for target 'khdr' failed
>> make[2]: *** [khdr] Error 2
>> /work/kernel/linux/Makefile:1220: recipe for target 'kselftest-all' failed
>> make[1]: *** [kselftest-all] Error 2
>> make[1]: Leaving directory '/work/kernel/linux/build-arm64'
>> Makefile:179: recipe for target 'sub-make' failed
>> make: *** [sub-make] Error 2
>>
> 
> I am looking to address build and install issues first.
> 
> thanks,
> -- Shuah


-- 
~Randy

