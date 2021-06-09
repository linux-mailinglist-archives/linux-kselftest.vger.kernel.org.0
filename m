Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA13A1316
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFILqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFILqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 07:46:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE70BC061574;
        Wed,  9 Jun 2021 04:44:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DD1D51F43416
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
 <CAHp75VcM_ikg26cs724rsTBz1Vc6HVcycQShWRtq_viFrX0AYw@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <340555e8-2222-2aa7-6e91-36a78fc7431c@collabora.com>
Date:   Wed, 9 Jun 2021 08:44:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcM_ikg26cs724rsTBz1Vc6HVcycQShWRtq_viFrX0AYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andy,

Às 14:32 de 06/06/21, Andy Shevchenko escreveu:
> On Sun, Jun 6, 2021 at 12:53 AM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Remove custom functions for testing and use KUnit framework. Test cases
>> and test data remains the same.
> 
> Can you provide the output in OK and non-OK runs before and after your patch?
> 

I'll add the output in my v2 cover letter.
