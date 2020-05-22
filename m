Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023F41DF1F2
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 May 2020 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgEVWkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 18:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVWkS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 18:40:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BAD204EA;
        Fri, 22 May 2020 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590187217;
        bh=6VBOAlJoPz7ULVbRUKA5Ubh9oBBqQcvYDNDgMR9WFV0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sLAEowTmi27guJYKxjE/VKhXLyK8DZ6lvfw1B89SHMNT6kak7yzdTRwF8hFe4AxYK
         4b7GNkzsTpyWAmxTxcck5pvku4zKB10WJdFmRyJvE5OYjEF4C+xMboOt+EAbACr2Lt
         j/hS/M8Q1nTfERX9RPmPq1dxmvnyoTlMLVNQGL5M=
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
To:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>, shuah <shuah@kernel.org>
References: <20200414230950.83665-1-vitor@massaru.org>
 <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
Date:   Fri, 22 May 2020 16:40:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/16/20 5:11 PM, Brendan Higgins wrote:
> On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>>
>> To make KUnit easier to use, and to avoid overwriting object and
>> .config files, the default KUnit build directory is set to .kunit
>>
>>   * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
>>
>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Applied the patch to kselftest/kunit on top of

45ba7a893ad89114e773b3dc32f6431354c465d6
kunit: kunit_tool: Separate out config/build/exec/parse

from David's work resolving merge conflicts. Please check if it is
sane.

thanks,
-- Shuah
