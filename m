Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86577DE10
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbjHPKCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbjHPKCt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 06:02:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20230C1;
        Wed, 16 Aug 2023 03:02:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68706b39c4cso4580655b3a.2;
        Wed, 16 Aug 2023 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692180168; x=1692784968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLyQrRbJVdgGh8CFXvn+T34a3ovDLg5YXhFAThMrIZE=;
        b=Mk0igIid0XijBrZhCClU1w+7Hz5Dj3L5+9RKGwVIY6z20/LEohkmYJ5W77KgdSKNFb
         Rhmtb9TMLXXAwT1mY5gCIh89J1RYsNxiJRCJdKO0QMdjlDHgMHW1tdV9zjfATMINGvir
         7iVPYw6PoNbgdZB7mOzt6luOc3wXdVYHile/MHUTb/c28Rvzuj/bOk2ZmG7tdYw3EsaL
         rGs9VMwM6HKmAXDvlMhJdJidYozD5PnDtCz9XakINponU1EXc7FExLpE+TUDj89LVyiA
         xgVpMRHe8qGHBNye0RGdlI7UPQ2w7EpfJYo7hOe9rdLluCaD1DSx3QsHVE2bXAVofecr
         kYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180168; x=1692784968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLyQrRbJVdgGh8CFXvn+T34a3ovDLg5YXhFAThMrIZE=;
        b=WBOsu8BW6R8zvtPv92po8hmzUJI/YKRWadHu9t9fXZJgZMIo6dlNWBec+lC36jj7EB
         7BYeHbxwObCnyoc7yMxk5mDWGLveVZPqyBO7ePaZ6I4LZe1Z8IkTD52sY2Nop64BpIhX
         EGVoh6WG3lVimWORBOt5ZK6MhSzj+UNg0ysZJg7MX8s5ByB+Am8YTuTEjyFIcQRqwuN5
         U7XzKBcLYZYBTcbyPEUgJlXk6mYLYqyl5/5JpVrYUWKqVmEV488ENvH8kCSGX97gFHCx
         0a9DEtMTmxpt38Cac90wgb4MWsH/5V2IfvJgir9s3b0wa4zqwfdK3URRrxWSIkKJmxY2
         Uilg==
X-Gm-Message-State: AOJu0YxUCDDOS4wS5tjmtLvP4kHzJTRF6+kCiyn3wXWnYB9OAoXAY952
        JShGWY4EBVaHszOLTtSt5bk=
X-Google-Smtp-Source: AGHT+IHYBT6lpAoHLLW+zzYIKmGt4hR/KKkFvGOTLSzyJatnVRj5H4L5WwB/MOPgXkPEgj5QXffrwg==
X-Received: by 2002:a05:6a20:748d:b0:13f:8a5f:ad8e with SMTP id p13-20020a056a20748d00b0013f8a5fad8emr1602056pzd.58.1692180168471;
        Wed, 16 Aug 2023 03:02:48 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p13-20020aa7860d000000b006889348ba6dsm607583pfn.93.2023.08.16.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:02:46 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:02:41 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     shaozhengchao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete
 action of device link1_1
Message-ID: <ZNyewWqRI3xGu1ev@Laptop-X1>
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
 <ZNxorHjkyjktoj9m@Laptop-X1>
 <a363d616-eadb-2136-a445-f946c24cd66d@huawei.com>
 <ZNyJx1HtXaUzOkNA@Laptop-X1>
 <a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 05:22:38PM +0800, shaozhengchao wrote:
> Also I run bond-break-lacpdu-tx.sh, it reports FAIL.
> When the master is set up, the slave does not go up. It seems
> that the mechanism has changed. But now I haven't had time
> to analyze it in detail, maybe someone can do it.

I will check it.

Hangbin
