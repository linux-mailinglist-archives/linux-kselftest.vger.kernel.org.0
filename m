Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40274A4ACC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiAaPmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 10:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242802AbiAaPmA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 10:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1C6Hmt87vWzjWxqoVkiCorkigZnguA91Obr4BW1inuA=;
        b=KVJxJcZYwVtcgo97unoqhioInzZhIZIcwG2g/Qv8cvEMfpyIq9Cnd2jpkyFuU83QcNRdAD
        0hdMOaXteicdOke18cMFbKsQF9Q4ZcCgswriZn1bVNOvKsEiAzKZ+CBOGgj1P3NvZbLF/R
        tk18WoT8HkBBVIQiaVq60CgvViezw1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-qtxC7uSvMBGjT48AhhW50Q-1; Mon, 31 Jan 2022 10:41:58 -0500
X-MC-Unique: qtxC7uSvMBGjT48AhhW50Q-1
Received: by mail-wr1-f70.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso4944574wra.14
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 07:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1C6Hmt87vWzjWxqoVkiCorkigZnguA91Obr4BW1inuA=;
        b=TZcmVSm8z8iiZ/9FBSIIIYRrkYzHSG05+kMXrtMwvxSMKDwcDgOWqZaitnLcAI59B/
         /ZtFH1gLJUl5oTj1ZV1CpOb8QQ9pMkjP0beLUt+O3A1tDrhIAYD+d+nDBLpGp5R2kGHp
         oJw6q0h9GHCUs+GmPVDYMTBW8MdLaE+LO5HC1xcLb1aFO60IW8ZTdtI0G29da2rNECnl
         Xz3AOrMX8G0SOOj/kRdIm8f66kXHByd3Q1WpE+RkydkAtOKo+7J9fZbv1NjaqVsLzfVb
         A5i4+IlK4w4+3qNqXrJT13oz3xEhfg4FdnklV8zzu9xYWeHyqZrw+gRyVc10xAPWkZy5
         5gkw==
X-Gm-Message-State: AOAM532E5H0rTIdm6JrGvhCX3bJBjDOpaIewnhbkrjHdJSSgRjnUzP+V
        v+vrH8bCHG6oQa65eHOIcwGzZC05j0vHict2qpgFhJszI0xJyv9evfvHT8vSia39+7BQXDAX38J
        +St/NU4X8kjPbvWWOAEQPhO3sSvXw
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr7577956wrw.673.1643643717424;
        Mon, 31 Jan 2022 07:41:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy22KrqgW3Xz3v8qnHlD9gcRIZxiGHVoXvKPYyNXVgwkhNMPpOBlchmZYI+ec9lVTV5v52bqA==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr7577948wrw.673.1643643717269;
        Mon, 31 Jan 2022 07:41:57 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id i6sm9239390wma.22.2022.01.31.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:41:56 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:41:54 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/4] selftests: fib rule: Small internal and test
 output improvments
Message-ID: <cover.1643643083.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The first half of these patch set improves the code logic and has no
user visible effect. The second half improves the script output, to
make it clearer and nicer to read.

Guillaume Nault (4):
  selftests: fib rule: Make 'getmatch' and 'match' local variables
  selftests: fib rule: Drop erroneous TABLE variable
  selftests: fib rule: Log test description
  selftests: fib rule: Don't echo modified sysctls

 tools/testing/selftests/net/fib_rule_tests.sh | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.21.3

