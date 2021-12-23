Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785447E879
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbhLWTsf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 14:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbhLWTse (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 14:48:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE36C061401;
        Thu, 23 Dec 2021 11:48:34 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 438FE6A2;
        Thu, 23 Dec 2021 19:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 438FE6A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640288914; bh=IGCCfzoruXVuNxjJQ9Jvb4MnqEAOH92v0oH47GM483I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mIB9d8mSJcZEVmgP6booAARhBn9Sy8dNF9ty/YdsEL6LJUIf4+gzbte7iJFZr8KtA
         KW531Ev3yZ37huTH2OwFthpuvccCxjodxyIDddwTOY1IjulHDn82REKsz5RTZaPyRW
         Ihz1NtwHdb/4DsvEBLA1eahk61J5YKDQfc7UvolU76RWSxle156KZHWlwakPXNSaxv
         T3YfO2fASXLb6rE9tt2lE7LWNJOkELqu69/Bc0f8iwJARjlFgBD+8jLQrrOHwlvK6X
         djKijrHFoezFxbTcDw6GiQv+o9W9OfmB97dXMd9cdQHMYA9IrlmmIntVvHE9I0hwDE
         6+n8VzayC9HxQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marco Elver <elver@google.com>,
        Harinder Singh <sharinder@google.com>
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com
Subject: Re: [PATCH v6 3/7] Documentation: KUnit: Added KUnit Architecture
In-Reply-To: <CANpmjNMz7nh7Eo97p-ikdE6cyTu_Vge_RJktj68BpC9QHqE7iw@mail.gmail.com>
References: <20211217044911.798817-1-sharinder@google.com>
 <20211217044911.798817-4-sharinder@google.com>
 <CANpmjNMz7nh7Eo97p-ikdE6cyTu_Vge_RJktj68BpC9QHqE7iw@mail.gmail.com>
Date:   Thu, 23 Dec 2021 12:48:33 -0700
Message-ID: <87zgordrvy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Fri, 17 Dec 2021 at 05:49, Harinder Singh <sharinder@google.com> wrote:
>>
>> Describe the components of KUnit and how the kernel mode parts
>> interact with kunit_tool.
>>
>> Signed-off-by: Harinder Singh <sharinder@google.com>
>
> Acked-by: Marco Elver <elver@google.com>
>
> For the .svg file, I think per
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> at least my Signed-off-by is required, but probably also my
> Co-developed-by? In any case my SOB for kunit_suitememorydiagram.svg
> is hereby given:
>
> Signed-off-by: Marco Elver <elver@google.com>

This is important; Harinder, please try to be sure to credit things
properly; I'll add this tag to the patch.

Thanks,

jon
