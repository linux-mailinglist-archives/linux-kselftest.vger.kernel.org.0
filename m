Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6F5A3933
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiH0R25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiH0R24 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 13:28:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F212750;
        Sat, 27 Aug 2022 10:28:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m16so5280597wru.9;
        Sat, 27 Aug 2022 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Tw8vsPyMRa3R3vyQxE6x05r7Ol1hC2beKW2wM170gK0=;
        b=DARyLpI4clUVQFS6URnQ6v1XSzMgNHah89p4LoVnw5A5KRr3FWo+lCxXltmwmjAt+y
         mY1I0LAXsx70cYVFwllmDDOVEUZM6FMtf1gwmB4Q14vFJQ1UmNDM6YaDt/kt4L/yqNiK
         yNkmOLube3uLs6YAiWJe6TxVs2zVX3PavhUqC3uF2vLeABg6WU9GNtHrjkP1akggULwe
         LiUfbLkKXlT7nq5EJnUEgjm0vRt8WxRNQreDw3+xbGGZbSfzEjSdw+npWt0iHMS+eLwC
         OsEv64Misu2v71PaLPLcniXeuwhNztYz29JrCH1JxP5UF2Z37YhFCZ8160xkr7iFZry+
         xUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Tw8vsPyMRa3R3vyQxE6x05r7Ol1hC2beKW2wM170gK0=;
        b=g8PaYE/PJf61YnPjC2q/wkyGKiB2FuS/O7074CV9Z32RncA0L4s5LLc9udtInU5yIr
         Searhq1lKeMJ/1FnthxpYwTj80oQzMBVYJ441Q+YfiMEeNiG3Yy3IZ9LOz/JIVB+Zg1y
         lPhB4+zXnFCx/EBi2+VpPtMfMYl+yxUWIxLOuzzZ8wyrLVYGYuPzh5g2qfosCnVBlZWR
         S41EUU53RBQdlwNbCtUqhw5rx+kulm/RCE60hIFCrcV94wOL/3aJes+BEfXcKnMlV/ap
         Brc0m4Pe3rY+4LkfoJIxJfwpOSsuEUXF/mqRZg0rwaUyafudQ78su6yo7hGNBdQAjqwV
         epWQ==
X-Gm-Message-State: ACgBeo2kcmywXDrVCovBQCnuxZUQP4THrOCafL8kyn1qM1ofJE2bnmes
        9HprjQ7SMfAw06CQ5lNAu6k=
X-Google-Smtp-Source: AA6agR48v0VW6uxASmjaSFpX23fGT5NDeizRXy5KHmPfntmBadyasFjD38jgNRfYaDjMPdMq8m2ZgQ==
X-Received: by 2002:a5d:6d88:0:b0:222:c8e2:f5fb with SMTP id l8-20020a5d6d88000000b00222c8e2f5fbmr2660041wrs.35.1661621333761;
        Sat, 27 Aug 2022 10:28:53 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d4-20020a056000114400b0021d6924b777sm2747160wrx.115.2022.08.27.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:28:53 -0700 (PDT)
Date:   Sat, 27 Aug 2022 19:28:51 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v2 6/6] landlock: update chmod and chown support in
 document
Message-ID: <YwpUU+DZKfD/lV/g@nuc>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-7-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827111215.131442-7-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 07:12:15PM +0800, Xiu Jianfeng wrote:
> update LANDLOCK_ACCESS_FS_{CHMOD, CHGRP} support and add abi change
> in the document.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  Documentation/userspace-api/landlock.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 2509c2fbf98f..0e97a7998fa1 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -61,7 +61,9 @@ the need to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>              LANDLOCK_ACCESS_FS_MAKE_SYM |
>              LANDLOCK_ACCESS_FS_REFER |
> -            LANDLOCK_ACCESS_FS_TRUNCATE,
> +            LANDLOCK_ACCESS_FS_TRUNCATE |
> +            LANDLOCK_ACCESS_FS_CHMOD |
> +            LANDLOCK_ACCESS_FS_CHGRP
>      };
>
>  Because we may not know on which kernel version an application will be
> @@ -90,6 +92,11 @@ the ABI.
>      case 2:
>              /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>              ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> +            __attribute__((fallthrough));
> +    case 3:
> +            /* Removes LANDLOCK_ACCESS_FS_{CHMOD, CHGRP} for ABI < 4 */
> +            ruleset_attr.handled_access_fs &= ~(LANDLOCK_ACCESS_FS_CHMOD |
> +                                                LANDLOCK_ACCESS_FS_CHGRP);
>      }
>
>  This enables to create an inclusive ruleset that will contain our rules.

There is a sentence just above this code example that neesd updating as well.

--
