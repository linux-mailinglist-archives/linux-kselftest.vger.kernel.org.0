Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72D73B4A7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jun 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYWOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 18:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYWOx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 18:14:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D9C061574;
        Fri, 25 Jun 2021 15:12:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E37541E5;
        Fri, 25 Jun 2021 22:12:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E37541E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1624659149; bh=aBOMm1kYBis17TYO37jwrNK1eY+68g/OKwBbu5ZPgD0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j+XZpeTAQ0KjC132HOY2IEgPospjpduBGW4AO6zLReYz6H5eLuDbhQV++MSwzkhJp
         LxYmNACv4ZDstPObhEWu+mD17cj/IDM6IHMhaecKdQsfWJAJhtkqCMGaLBTK16bo+b
         R9xq0zGggV5s6CbUPSnNy4mw0d7I5bGK2mtv5asg2O0776N6j8bg5pNPHPkVSNRr4W
         yAafJWAHLwYpDO6AcITdvMbhT091i97p85hhOumo9o7Zgjh2k1XBRdhPnP79cpRkzl
         T179d0jI9A/M/ditPIsxsTSLLGx8y2WbyUYOiN/hocIIdciP23vjcX6IWxSgMPjuAj
         LhaeXx3AqYL5g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>
Subject: Re: [PATCH v2 10/29] docs: dev-tools: kunit: avoid using ReST
 :doc:`foo` markup
In-Reply-To: <CAFd5g443AK+vxaupGiBQC5wB-5PG+5vV11y1NjevUh8don+VJQ@mail.gmail.com>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
 <6fde409079959a95b62b9b2692503608d7ff0dbd.1623824363.git.mchehab+huawei@kernel.org>
 <CAFd5g443AK+vxaupGiBQC5wB-5PG+5vV11y1NjevUh8don+VJQ@mail.gmail.com>
Date:   Fri, 25 Jun 2021 16:12:28 -0600
Message-ID: <871r8p1tmb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Brendan Higgins <brendanhiggins@google.com> writes:

> On Tue, Jun 15, 2021 at 11:27 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
>>
>> The :doc:`foo` tag is auto-generated via automarkup.py.
>> So, use the filename at the sources, instead of :doc:`foo`.
>>
>> Reviewed-by: David Gow <davidgow@google.com>
>> Acked-by: Brendan Higgins <brendanhiggins@google.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Hi, can you please rebase and resend your patch on top of
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit-fixes

I applied the whole set a couple of weeks ago, actually, so there
shouldn't be any need for this...

Thanks,

jon
