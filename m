Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12B83613B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOUyG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUyF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 16:54:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A316C061574;
        Thu, 15 Apr 2021 13:53:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F299F304D;
        Thu, 15 Apr 2021 20:53:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F299F304D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618520022; bh=JGuBcDCsoY8Pewg+MBKqE6IyTEvd/cQVdVqhnNSiz9A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bR0V82w9Sp/671/R1C6VuDxdFy/+ZlHH3SaQaod/0bDnqrXai4BepcSfgJtxgApbr
         C55hqINDF08FSms5kZMJxww38zZuBKTIK1DgZvchF95I6v4IcZsBCy+DV7KxWqoZev
         ygaAg4JxqR6oZvVmeknlf+6ZqktqKzQmKTHKlzIwQQeoX3NZWiqAsZ8zBRFAzzzyPA
         iwFjkiIdN/hTFQWm35e+w2xMz9J3Y/tjQOjGgsXNI68BaJIbygUx80No4XyuElVdQW
         LP7Kehidg+8HY3E4fusmWT1+Ef+LnWfZAXp0LzQuQP4u79c1tjY837GQou4JgzEnCA
         /N60GfQrXVxig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-doc@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: dev-tools: Add Testing Overview
In-Reply-To: <20210415054036.581117-1-davidgow@google.com>
References: <20210415054036.581117-1-davidgow@google.com>
Date:   Thu, 15 Apr 2021 14:53:41 -0600
Message-ID: <877dl3i816.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

> The kernel now has a number of testing and debugging tools, and we've
> seen a bit of confusion about what the differences between them are.
>
> Add a basic documentation outlining the testing tools, when to use each,
> and how they interact.
>
> This is a pretty quick overview rather than the idealised "kernel
> testing guide" that'd probably be optimal, but given the number of times
> questions like "When do you use KUnit and when do you use Kselftest?"
> are being asked, it seemed worth at least having something. Hopefully
> this can form the basis for more detailed documentation later.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> Thanks again. Assuming no-one has any objections, I think this is good
> to go.

I've applied it after fixing the conflict with docs-next.

Thanks,

jon
