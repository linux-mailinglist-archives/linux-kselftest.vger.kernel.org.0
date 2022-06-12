Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5405479D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jun 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiFLKwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFLKwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 06:52:03 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 416FC1A812;
        Sun, 12 Jun 2022 03:52:02 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id A4E162719CF1;
        Sun, 12 Jun 2022 19:51:59 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1/8.17.1/Debian-2) with ESMTPS id 25CApvdp038205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 19:51:59 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1/8.17.1/Debian-2) with ESMTPS id 25CApvBl063742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 19:51:57 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1/8.17.1/Submit) id 25CApulC063741;
        Sun, 12 Jun 2022 19:51:56 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Kellner <ckellner@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/4] fat: add support for the renameat2
 RENAME_EXCHANGE flag
References: <20220610075721.1182745-1-javierm@redhat.com>
Date:   Sun, 12 Jun 2022 19:51:56 +0900
In-Reply-To: <20220610075721.1182745-1-javierm@redhat.com> (Javier Martinez
        Canillas's message of "Fri, 10 Jun 2022 09:57:17 +0200")
Message-ID: <874k0qyx0z.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> The series adds support for the renameat2 system call RENAME_EXCHANGE flag
> (which allows to atomically replace two paths) to the vfat filesystem code.
>
> There are many use cases for this, but we are particularly interested in
> making possible for vfat filesystems to be part of OSTree [0] deployments.
>
> Currently OSTree relies on symbolic links to make the deployment updates
> an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
> to achieve a similar level of robustness when using a vfat filesystem.
>
> Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
> support, patch #2 moves some code blocks in vfat_rename() to a set of
> helper functions, that can be reused by tvfat_rename_exchange() that's
> added by patch #3 and finally patch #4 adds some kselftests to test it.
>
> This is a v6 that addresses issues pointed out in v5:
>
> https://lkml.org/lkml/2022/6/9/361
>
> [0]: https://github.com/ostreedev/ostree
> [1]: https://github.com/ostreedev/ostree/issues/1649

Looks good this patchset.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
