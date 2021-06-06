Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7639D02C
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFFRUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Jun 2021 13:20:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFFRUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Jun 2021 13:20:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B92351F42052
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     David Gow <davidgow@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com
References: <20210605215215.171165-1-andrealmeid@collabora.com>
 <CABVgOS=QMTjFEPqgBab27sTRdnW6PLG_bcD20ui_nC2wK_GAPA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <afc18aea-cdca-5768-bbb1-32b6ee637c97@collabora.com>
Date:   Sun, 6 Jun 2021 14:18:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABVgOS=QMTjFEPqgBab27sTRdnW6PLG_bcD20ui_nC2wK_GAPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Às 21:54 de 05/06/21, David Gow escreveu:
> On Sun, Jun 6, 2021 at 5:52 AM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Remove custom functions for testing and use KUnit framework. Test cases
>> and test data remains the same.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
> 
> Thanks! It's always exciting to see more tests using KUnit.
> 
> Note that the names here (filename, suite name, and Kconfig entry
> name) don't match what we usually recommend for KUnit tests:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html
> 
> Given that this is an existing test, it is definitely okay to keep the
> old names if you think it'd break something, but if there's no issue
> it may be worth renaming them. The test suite name (which is new
> anyway) ideally shouldn't end in "-test": just "uuid" is best.
> 
> I know there are quite a few existing tests which don't adhere to
> these perfectly yet, but ideally new ones will if it's convenient.
> 
> Otherwise, this looks great. I've run it here, and it worked well and
> picked up on any deliberate errors I introduced.
> 
> So this is
> Tested-by: David Gow <davidgow@google.com>

Thank you for the feedback :) I'll submit a v2 applying your suggestions.

> 
> Cheers,
> -- David
> 
