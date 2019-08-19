Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B758924AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2019 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfHSNW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Aug 2019 09:22:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43967 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfHSNW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Aug 2019 09:22:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so1163923pfn.10
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2019 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cQU4KQrxQys58Jg2W2ly4+q7AEo42feQrOFY3UWkd4=;
        b=foc8SMFZSY7hAWCfbQkF1NyaOEME7p+GgYs0mQEYRExVuzMdmcZIO69KkuSM4Gz30z
         phr2GKMnO1gZyljMtVqE9trmrF1TH2ocny/sZqPsLWPCxKwCu94MIAboGuOZImCz4a+2
         6rugHvHTcSLrXh/FgSQtb2EpaVzIldZdJ1mX44LSDuhUVTwTvioNwPCq6jOoQPAbyxZW
         lamLTwYsht9EE4ljavIwA+m6MJDig3/cxHeALGSjp3/p0zmMbr01oY5frJa9Ajy67IYX
         ONH4A9HAHI0b+nkkHfJwUjbj1fzefUF1CSfLclemRepOywryAIEQlAVG1da9NNvcIp56
         c4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cQU4KQrxQys58Jg2W2ly4+q7AEo42feQrOFY3UWkd4=;
        b=bVdsxRHqpiC/lNP5wU2x8Pd6qUthyoBG48VJ6Z0vuJMKkiMOtY7IXwT6pQUBuaLMgq
         iYMtgSAAIICOH34WoILqm/A4J1vkHKZohbbwZXwwIQAQMes46GA54fiSg5LrlpQaEskf
         M9fSo/aP3W175ffFTJ23PBDO7qzIlyEIdbvhnfJmsEMxf5iMAJRVMVeTE+ZUMvyISAUO
         sfdAEnXhdT3Dy38Db5lbL1YhDjVI0BmiGrloxy8NglvfPg5eyZXGwsUlVqsDt4sU/efd
         XPVf3IlpxyiSYGfng5oUqUSvH6o+hQcU56FpeV37cuEIRvfY98UFJSUYGpPBZXbUbQG4
         JfWw==
X-Gm-Message-State: APjAAAU8hyhLiFXG8mLSlbYTiOJ1D4g4UTEtbNZKT2zuQ7F5UCZhiv8J
        44AI5if+zLWIMBzcqIPXutsih+tZvcx50+r+3tKDY8lsg8U=
X-Google-Smtp-Source: APXvYqwZh6+Pm6DLf/0IMEFuil+Sv4cgeF7APqK2x1eQmDZdJjRuYhVJzU6Gu2u88qeYL93rGmDLKMONZaHxZYuLG7g=
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr24549954pfq.25.1566220948252;
 Mon, 19 Aug 2019 06:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815081803.GA27238@mwanda>
In-Reply-To: <20190815081803.GA27238@mwanda>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 15:22:17 +0200
Message-ID: <CAAeHK+x6q_dTGdtTMuEg6L7wwCipo29tM8NKQK+MgZ9Q1XqCMA@mail.gmail.com>
Subject: Re: [bug report] selftests, arm64: add a selftest for passing tagged
 pointers to kernel
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 15, 2019 at 10:18 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Andrey Konovalov,
>
> The patch 9ce1263033cd: "selftests, arm64: add a selftest for passing
> tagged pointers to kernel" from Jul 23, 2019, leads to the following
> static checker warning:
>
>         ./tools/testing/selftests/arm64/tags_test.c:25 main()
>         error: uninitialized symbol 'tagged_ptr'.
>
> tools/testing/selftests/arm64/tags_test.c
>     14  int main(void)
>     15  {
>     16          static int tbi_enabled = 0;
>     17          struct utsname *ptr, *tagged_ptr;
>                                       ^^^^^^^^^^
>
>     18          int err;
>     19
>     20          if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
>     21                  tbi_enabled = 1;
>     22          ptr = (struct utsname *)malloc(sizeof(*ptr));
>     23          if (tbi_enabled)
>     24                  tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
>                 ^^^^^^^^^^^^^^^
> No else path.
>
>     25          err = uname(tagged_ptr);
>     26          free(ptr);
>     27
>     28          return err;
>     29  }
>
> regards,
> dan carpenter

Hi Dan,

Just sent a patch with a fix.

Thanks for the report!
