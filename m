Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878D59C884
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiHVTSh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiHVTSP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 15:18:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB874DB7A;
        Mon, 22 Aug 2022 12:17:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gt3so10757409ejb.12;
        Mon, 22 Aug 2022 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=Ww/zLVja8aGocviQTazyplD8WiIYTW+lQEN/JOcoOp0=;
        b=eSIXWq3zBlZ5kRMrRBBhgnmPJWSwhwcolElJUXH3iiGx2gcK8xoKHZAuL6ll5nXc/r
         vF3y4kQ+Fik0eYXxR1dWkOJAtDytOn7JlYDZ/knhqgKi++Q1T26q9ud0edqY2LkVoQoF
         en6JrFaydF6c3gvy8u2RLYbyLaHnndUYLwv0R5d4shdPm4+Uhult19HUJH31gkRF8VAK
         JrfgOedDtM55nkjmbnhPvWq2H2yA/mzbHH1gQN0Hpgm7MfkqaAlNGa1KiyKRBE0QtXeO
         Nk5Xn9TtGxSCtWR4QoyGYSH4O22DcGowNF99CsAw/T3JFlaKgikr1hGqU6d2asSjDJpY
         z/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Ww/zLVja8aGocviQTazyplD8WiIYTW+lQEN/JOcoOp0=;
        b=3b4AC2Pi0zaWcbOC4X702GoIMZj3n+CqjXu6+PFNgWF/t5M4/XTGT60QdEREBjd1U6
         pk+fWayG2SKv8i5fS36cvzLpdaucOPnGXxocbIzY5IRc+1FtNIIVqHVOMiBkHLOziDz7
         Kttdio0aznG7XcwFXg1pJOp1yxTf9rXrvxLokIE4azA5ObdY5Sh/B07OfUJCmmgYN1ly
         dtc041eXvGZ+7+3XIr0NI8gLKuCnzeggVAyIv7onRAPt2qO5RBoKv3oKRM9Eq2s3hSvq
         xWZOTUjjxD7i48iHBkS/1hSfhpRa0zW3ysrcWTSXu2gU73RPomjnr4erOve27b0yESct
         mudA==
X-Gm-Message-State: ACgBeo3jt581mB3a+66u/hFBUvrarELbxh+B5bbmvCGMM61aBg+rIhIo
        e8QPcvBg3YbLvZ9cQoQK4qM=
X-Google-Smtp-Source: AA6agR74OXBMyMhgrrICVycGtQDBtWfFv0yng7NSivL2HvsIdp9lfatgEQrDaKYmO5dMRCVWay3U5Q==
X-Received: by 2002:a17:907:c15:b0:73d:8337:3aa8 with SMTP id ga21-20020a1709070c1500b0073d83373aa8mr3788064ejc.254.1661195833128;
        Mon, 22 Aug 2022 12:17:13 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bt2-20020a0564020a4200b0043d7b19abd0sm168795edb.39.2022.08.22.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:17:12 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:17:11 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
Message-ID: <YwPWN/d15S24PuLS@nuc>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822114701.26975-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

Very exciting to see! Thank you for sending this! :)

I'm just throwing in some comments based on the very similar truncate
patch set, in the hope that it helps. (But obviously, Mickaël Salaün
has the last word on this code.)

Slightly higher level question: Should we start to group the
functionality of multiple LSM hooks under one Landlock flag? (Will it
be harder to change the LSM hook interface in the future if we
continue to add one flag per hook? Or is this structure already
exposed to userspace by other LSMs?)

For example, some of the "missing" operations listed on the Landlock
documentation could also be grouped roughly as:

Modifying files:
 - truncate

Modifying file metadata:
 - chmod
 - chown
 - setxattr
 - utime

Observing files (check presence and file metadata):
 - access
 - stat
 - readlink, following links (can observe symlink presence)
 - chdir (can observe dir presence and 'x' attribute)

Ungrouped:
 - flock
 - ioctl
 - fcntl

Do you have opinions on this?

—Günther

On Mon, Aug 22, 2022 at 07:46:56PM +0800, Xiu Jianfeng wrote:
> hi,
>   this patchset adds chmod and chown support for landlock
>
> Xiu Jianfeng (5):
>   landlock: expand access_mask_t to u32 type
>   landlock: add chmod and chown support
>   landlock/selftests: add selftests for chmod and chown
>   landlock/samples: add chmod and chown support
>   landlock: update chmod and chown support in document
>
>  Documentation/userspace-api/landlock.rst     |   8 +-
>  include/uapi/linux/landlock.h                |   8 +-
>  samples/landlock/sandboxer.c                 |  12 +-
>  security/landlock/fs.c                       |  16 +-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   | 234 ++++++++++++++++++-
>  9 files changed, 274 insertions(+), 12 deletions(-)
>
> --
> 2.17.1
>

--
