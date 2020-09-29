Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B027BA85
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgI2BxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI2BxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 21:53:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91918C061755;
        Mon, 28 Sep 2020 18:53:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x16so2550356pgj.3;
        Mon, 28 Sep 2020 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=muPavyROLoVVZRpBtwcBY8n2nc+gVoJRAgcTPB/X6ZE=;
        b=kZWT8SqKokpVld4pvJkGZNeOBwSb95rOoGWG0rc0+4oXZ2RoFfoYWn+wITl1j9Tidz
         wn8RWKJXdomdGPjaJ9g7DX2cvHImFS7CLc+4XeBZAXsjJE7h/w9doKLuqOu3qOkK6hiP
         lCBG+GSHYg5XSIZgtjdHvsrOqV+OB2gLv8XjQAJC4XXB7n5WkdYNFJPJ7rX78OuXaFQj
         4id2ToKQzfkxlvH/3VyBLEQ8EF8PTgobYbHbSL8ExTrroVDk1aIGcBlH6Epu8a4s5vq2
         JG8eW52GZ7QZmQOq7ZBrrMNt6HmquhiUGSqC/gEaoo0xEtSXsrdrvy8OHUge9kwaynjn
         ed/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muPavyROLoVVZRpBtwcBY8n2nc+gVoJRAgcTPB/X6ZE=;
        b=iVLc9jSIfQ09efEpovkVXi+F0aoLTZN4NLZDbwh3cFhqn4GoB6h249dpioxjKXo0gI
         ElwIzQk0W6ZwhgcNikvmiAPgLIglEjtPpQLvRG/JUGeSg3W+DZf/SH/RSqmD34k/qtEP
         +iXn+KVjpOo3/TMXYbtQkMyOqMguFW7Zt/BdlLC2gv3KybaPtbVa5M8pTcXOkgSzXvnJ
         uq1mJf8QHkC5j86eOJuG/ChTyNPELUxzuVTEn1nYS+dwU5e/uL49L7m0Qa4Yn0pqXXA3
         +rmzmA5MqJoWlGNFGx5foI0vYac9HzU5SuIYreKdIyH4GgkR7bsifBaRp0H3hgar3YsE
         IYEQ==
X-Gm-Message-State: AOAM533Zjw/6qn4v+HnCyd4TZb284zpn4XTvlhXaSocpGQ9feEWptZu3
        JGqzuqoSTBw5E0lBbohbEqc=
X-Google-Smtp-Source: ABdhPJySH5jWlyKpCINSKeeLxOGCz1qDXpeHznFZN5cKcil/EGZrWRzINUp4yQnTRPgDPbCndKjS5g==
X-Received: by 2002:a62:5:0:b029:13e:d13d:a05a with SMTP id 5-20020a6200050000b029013ed13da05amr1931737pfa.32.1601344392114;
        Mon, 28 Sep 2020 18:53:12 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i1sm3155742pfk.21.2020.09.28.18.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 18:53:11 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:53:00 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Extract run_kselftest.sh and generate stand-alone
 test list
Message-ID: <20200929015300.GF2531@dhcp-12-153.nay.redhat.com>
References: <20200928202650.2530280-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928202650.2530280-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 28, 2020 at 01:26:47PM -0700, Kees Cook wrote:
> v2:
> - update documentation
> - include SPDX line in extracted script
> v1: https://lore.kernel.org/linux-kselftest/20200925234527.1885234-1-keescook@chromium.org/
> 

I'm not sure if the doc update are all appropriate. Need others help review.
The script part looks good to me. Thanks for your update.

Regards
Hangbin
