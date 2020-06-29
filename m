Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646C120E078
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jun 2020 23:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgF2Uqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Jun 2020 16:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbgF2TNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8DC08EA4B;
        Sun, 28 Jun 2020 22:48:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49wGjw1lCLz9sRk;
        Mon, 29 Jun 2020 15:48:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593409684;
        bh=/YQUWPTNF1yfjssmjTfskL+aXMkfJR2ADKApusEzfaA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZiiGvlHCBnvAF3APkTommNfdvQmDkuYoZMa+llNNHmj31m9lhBnJPy19xfNxjMJiI
         LOEHaJ8xq26BiOKskUPmfOW4WUU+T79cfWSyDx7RdzCKZJzLLkNz4Oq9G8fr8h9PHV
         PpMSd3Xc/PQdrP1409zgma9HkuMVo4knpGsQy4+X88UPXbLERDNgC1cb6A2fF7WI5P
         WiWe7WtJ2hrelBssuoZAIEukoh8LAXk/XNOtW0D20iY0LEcnXYlflR65DabbSdQuIL
         Gj9HDWDpu1Zwa3R6DkW58ykovlV/uoJL3w1+hw4OyzGz778jSZTfL6rFVsmmhSmNAX
         mvOcCg0ljaiLQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
In-Reply-To: <202006270849.7190A26@keescook>
References: <202006261358.3E8AA623A9@keescook> <87k0zsbubg.fsf@mpe.ellerman.id.au> <202006270849.7190A26@keescook>
Date:   Mon, 29 Jun 2020 15:50:18 +1000
Message-ID: <87lfk68lph.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Sat, Jun 27, 2020 at 09:51:31PM +1000, Michael Ellerman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > Instead of full GNU diff (which smaller boot environments may not have),
>> > use "comm" which is more available.
>> 
>> Although using "comm" requires CONFIG_PRINTK_TIME=y doesn't it?
>
> No, it doesn't seem to. "comm" doesn't carry about the line prefixes.
> AIUI, the only reason for a mention of "sort" is because of how "comm"
> does its line pairing. i.e. as soon as it goes out of sync, it starts
> accounting for the disjunction between files. But that's exactly what we
> want it doing, and the prefix doesn't matter.

OK, if it works.

cheers
