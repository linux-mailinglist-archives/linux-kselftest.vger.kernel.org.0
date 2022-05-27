Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4E535910
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 May 2022 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiE0GJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 May 2022 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiE0GJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 May 2022 02:09:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD2EC30F;
        Thu, 26 May 2022 23:09:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 9A8821F4586E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653631770;
        bh=QDvkzQfshs+H3XbXXQFYpToDQlyGSs72CHoJHIP8Ex8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Ox3jhkJFETCcFw2A5gzziNeeEFvqPo2K5bhLw7g2CjmfftBbDBfGiSOBTAqieLons
         +W9aPrp5pIFZcNqqExYU3fTnJi1cgQRS/IvveT0k5dEs6oKzTN8tesBfZjQV0fvMb6
         /UABjhP6xrLsLYfBVS4OyYyuCO2kMOUgr4zULsx8xUeRHDWG9HVyqJTqxD0tVT3Yji
         eFzqBhE6dFymf10vrcIgz7eYQeoxT2EXLopPWs4PJIJoNZp8/CN7y9ZqMzsDR3oIoj
         whRBydsQHl3XvJja6SWAYXCzpYEfcx3Ao5Eb8D4cor0Mu50ScN4o/IlO9yvKFaEaKs
         JKmkixSlwOatA==
Message-ID: <193aad3f-82dd-76a8-a44c-5000ab203dc2@collabora.com>
Date:   Fri, 27 May 2022 11:09:23 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     usama.anjum@collabora.com, Christian Kellner <ckellner@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE
 test
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220526134119.242182-1-javierm@redhat.com>
 <20220526134119.242182-4-javierm@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220526134119.242182-4-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/26/22 6:41 PM, Javier Martinez Canillas wrote:
> Add a test for the renameat2 RENAME_EXCHANGE support in vfat, but split it
> in a tool that just does the rename exchange and a script that is run by
> the kselftests framework on `make TARGETS="filesystems/fat" kselftest`.
> 
> That way the script can be easily extended to test other file operations.
> 
> The script creates a 1 MiB disk image, that is then formated with a vfat
> filesystem and mounted using a loop device. That way all file operations
> are done on an ephemeral filesystem.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
Muhammad Usama Anjum
