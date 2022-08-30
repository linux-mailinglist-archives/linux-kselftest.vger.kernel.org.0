Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD85A6194
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH3LWc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiH3LWb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 07:22:31 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC3A572F
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 04:22:29 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MH4fC4m5wzMqJT0;
        Tue, 30 Aug 2022 13:22:27 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MH4fB03k7zlh8TF;
        Tue, 30 Aug 2022 13:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661858547;
        bh=VRsf1Wd8Vv3G5MDmh8RBWHIdTuSCowSnujkVCmhBQK0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H76gWaKNdSZh20vELtEQWYecxd3svm/aauuwqOvursL/QabjaoS5FSrQjVaS4SJe4
         gDmoIRSszixQ4TmnhKb6c1SaTMC7UzjfJ4mBPQGttWye0kdSQOZE8bdHJktGHVJkMf
         KderlZWhS64b0y/GXMaPCt+IkVK27Zwf5oKXRKLU=
Message-ID: <4142d01a-7362-0865-f199-7a49b2c1a5ea@digikod.net>
Date:   Tue, 30 Aug 2022 13:22:25 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next v2 0/6] landlock: add chmod and chown support
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220827111215.131442-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please add a description and include links to the previous versions.

On 27/08/2022 13:12, Xiu Jianfeng wrote:
> v2:
>   * abstract walk_to_visible_parent() helper
>   * chmod and chown rights only take affect on directory's context
>   * add testcase for fchmodat/lchown/fchownat
>   * fix other review issues
> 
> Xiu Jianfeng (6):
>    landlock: expand access_mask_t to u32 type
>    landlock: abstract walk_to_visible_parent() helper
>    landlock: add chmod and chown support
>    landlock/selftests: add selftests for chmod and chown
>    landlock/samples: add chmod and chown support
>    landlock: update chmod and chown support in document
> 
>   Documentation/userspace-api/landlock.rst     |   9 +-
>   include/uapi/linux/landlock.h                |  10 +-
>   samples/landlock/sandboxer.c                 |  13 +-
>   security/landlock/fs.c                       | 110 ++++++--
>   security/landlock/limits.h                   |   2 +-
>   security/landlock/ruleset.h                  |   2 +-
>   security/landlock/syscalls.c                 |   2 +-
>   tools/testing/selftests/landlock/base_test.c |   2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
>   9 files changed, 386 insertions(+), 31 deletions(-)
> 
