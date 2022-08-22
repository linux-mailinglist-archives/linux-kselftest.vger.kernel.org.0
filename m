Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5359CACD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiHVVZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiHVVZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:25:41 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418494055A
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:25:40 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBQPr6Lb2zMpvsm;
        Mon, 22 Aug 2022 23:25:36 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBQPr0l8Kzlh8TC;
        Mon, 22 Aug 2022 23:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661203536;
        bh=bl79jSnYmOqsqEwfzn/3uZdbexw5tt9nsmEid8rJbl8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=t/KVRMzqA/JAYEXensgt6ob2cKG3uu+fhvhZ90HhNlZtT+mwvoS4DG2U/v/zaNV4U
         ineELGdGS0yxHXN/HGZIybSx0VJwhHrkagdZNVPtuKaHFbgHg5Q5y7mWVAsUIFJwJG
         wxeREv/Nn8boCIfXhdJiJhcKLCfWAUJgtnqIzfbE=
Message-ID: <68629a11-93c1-d7ab-ad3d-0fdbde1a35e3@digikod.net>
Date:   Mon, 22 Aug 2022 23:25:35 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-6-xiujianfeng@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next 5/5] landlock: update chmod and chown support in
 document
In-Reply-To: <20220822114701.26975-6-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 22/08/2022 13:47, Xiu Jianfeng wrote:
> update LANDLOCK_ACCESS_FS_{CHMOD, CHOWN} support and add abi change
> in the document.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   Documentation/userspace-api/landlock.rst | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 2509c2fbf98f..05ab338db529 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -61,7 +61,9 @@ the need to be explicit about the denied-by-default access rights.
>               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>               LANDLOCK_ACCESS_FS_MAKE_SYM |
>               LANDLOCK_ACCESS_FS_REFER |
> -            LANDLOCK_ACCESS_FS_TRUNCATE,
> +            LANDLOCK_ACCESS_FS_TRUNCATE |
> +            LANDLOCK_ACCESS_FS_CHMOD |
> +            LANDLOCK_ACCESS_FS_CHOWN
>       };
>   
>   Because we may not know on which kernel version an application will be
> @@ -90,6 +92,10 @@ the ABI.
>       case 2:
>               /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>               ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;

There is a missing fall-through attribute here.


> +    case 3:
> +            /* Removes LANDLOCK_ACCESS_FS_{CHMOD, CHOWN} for ABI < 4 */
> +            ruleset_attr.handled_access_fs &= ~(LANDLOCK_ACCESS_FS_CHMOD |
> +                                                LANDLOCK_ACCESS_FS_CHOWN);
>       }
>   
>   This enables to create an inclusive ruleset that will contain our rules.
