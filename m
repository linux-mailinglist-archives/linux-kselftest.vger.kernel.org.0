Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CBD10F7B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 07:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLCGQ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 01:16:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32795 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 01:16:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1196472pgk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qE/70uhu0jaSAMS8KivJvAncflzBY+imZtLjsRtcA00=;
        b=OA58cEfLSG/ymRbZf1oZr5T5yf7CX4tQh61rxiUlE16G3++1SovYv+eUTEn0/EbvHg
         Ij0EXU9gjp/u8mFrSSw0zKkVX0mn47PspiuSy0IQ6g0ntqf9HUEfr3RGn9iUE4ghJFQg
         1oPZi001msqEKsLwqhes4b57LzVywuFgnNR+Lq8xOKLN7cBXbYfLUraQ9/+uYpQDM+Oq
         sg7gCYMk1YwY7mvf5l+gg/phX36djG2C5MrT4MeEEDny7/hQ6tXAjrdgo0dJJblgPInp
         XLfgdh50k1+pNfwARCdj74xn04YwLHNkdRnxJy+DapDIP2Fvtn3x1qlXRgrchcKhOJ7o
         1Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qE/70uhu0jaSAMS8KivJvAncflzBY+imZtLjsRtcA00=;
        b=gr4NrzhPg7NDcDF/fgilZfFLvOtz+jtsbLrxVjK3LlXwjCusxHgwGc7L/w2vNmHv+r
         wiF07CJGSap/Y6r6jphZPeB63t8ydPqypJA58yzV4XV1QwuERJFhJd7gRji7x/kyp69o
         E52kfSQZTGN8ts9MEUX7L72JVRsNDFuPTeHO7IQH46W2b8qDTC9KnOa5Fqc1N+7DzQM/
         ANuTfpIGJfa4UVr/ukmniRCYrS6IH4DWbFd6tCLDBlwIvcQt2/4Qv22lLjBJ4oNQJ95Q
         Pho1XGLLoyT+ylLH7sdlCLU6caiIHyk+/gUumLEJcdkUTKkA9tTVV60yUkzY9Ze7LLtd
         ao5Q==
X-Gm-Message-State: APjAAAUFhIlnj1XeJGYAo1aYoXdNi04rOiLKwAtVd9qA1T5kY2c/weT9
        i03og2IXi6T2ByVRm9piGIWOvnHmzmMIQm2QYet/EA==
X-Google-Smtp-Source: APXvYqxIATMvEvC4LUmHaq0s9rzJuaHa84MyxysOr3z/cffTlAZjA1TXl44Q6sACqTVONzLZzMyh6y9VLKvOrRG52QQ=
X-Received: by 2002:a62:7b46:: with SMTP id w67mr3087699pfc.113.1575353788248;
 Mon, 02 Dec 2019 22:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20191202235329.241986-1-heidifahim@google.com>
In-Reply-To: <20191202235329.241986-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 22:16:17 -0800
Message-ID: <CAFd5g47a7a8q7by+1ALBtepeegLvfkgwvC3nFd8n8V=hqkV+cg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Heidi Fahim <heidifahim@google.com>, shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 2, 2019 at 3:53 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/351
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> Reviewed-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Heidi, thanks for taking care of this!

Shuah, can we make sure to get this in as a v5.5 fix?
