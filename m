Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E812542CA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jun 2022 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiFHKJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jun 2022 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiFHKIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jun 2022 06:08:19 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 02:51:38 PDT
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001ED62EE;
        Wed,  8 Jun 2022 02:51:37 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id CCA6A2051589;
        Wed,  8 Jun 2022 18:42:36 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 2589gZHG171264
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jun 2022 18:42:36 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 2589gZFp099261
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jun 2022 18:42:35 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 2589gXI5099260;
        Wed, 8 Jun 2022 18:42:33 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Lennart Poettering <lennart@poettering.net>,
        linux-kernel@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] fat: add support for the renameat2
 RENAME_EXCHANGE flag
References: <20220601173204.1372569-1-javierm@redhat.com>
        <05bfb010-6b00-edb1-0e28-889a2ff71503@redhat.com>
Date:   Wed, 08 Jun 2022 18:42:33 +0900
In-Reply-To: <05bfb010-6b00-edb1-0e28-889a2ff71503@redhat.com> (Javier
        Martinez Canillas's message of "Wed, 8 Jun 2022 09:56:46 +0200")
Message-ID: <87ilpbtrsm.fsf@mail.parknet.co.jp>
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

> Hello OGAWA,
>
> On 6/1/22 19:32, Javier Martinez Canillas wrote:
>> Hello,
>> 
>> The series adds support for the renameat2 system call RENAME_EXCHANGE flag
>> (which allows to atomically replace two paths) to the vfat filesystem code.
>> 
>> There are many use cases for this, but we are particularly interested in
>> making possible for vfat filesystems to be part of OSTree [0] deployments.
>> 
>> Currently OSTree relies on symbolic links to make the deployment updates
>> an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
>> to achieve a similar level of robustness when using a vfat filesystem.
>> 
>> Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
>> support, patch #2 moves some code blocks in vfat_rename() to a set of
>> helper functions, that can be reused by tvfat_rename_exchange() that's
>> added by patch #3 and finally patch #4 adds some kselftests to test it.
>> 
>
> I think that addressed all the issues you pointed out in v3, please let me
> know if there's anything else that is needed for this patch series.
>
> Would these be merged by you or should I ping someone else? I'm not
> that familiar with how filesystem patches make into the mainline tree.

Sorry, it is just the my issue. I was traveling latest week, so is not
reviewing yet. I'll do soon.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
