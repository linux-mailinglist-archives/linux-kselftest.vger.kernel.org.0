Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75C2947BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440411AbgJUFTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 01:19:42 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:40974 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440408AbgJUFTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 01:19:42 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 35AE91B3B65;
        Wed, 21 Oct 2020 14:19:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09L5Jd3r1600172
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 14:19:40 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09L5Jd2X1996638
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 14:19:39 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 09L5JdPs1996637;
        Wed, 21 Oct 2020 14:19:39 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fat: Add KUnit tests for checksums and timestamps
References: <20201020055856.1270482-1-davidgow@google.com>
        <87d01die4o.fsf@mail.parknet.co.jp>
        <CABVgOSkQRvRSr-c1FKG+GDr5ewV+FJ-unZbtNvQLayoT6FmBtQ@mail.gmail.com>
Date:   Wed, 21 Oct 2020 14:19:39 +0900
In-Reply-To: <CABVgOSkQRvRSr-c1FKG+GDr5ewV+FJ-unZbtNvQLayoT6FmBtQ@mail.gmail.com>
        (David Gow's message of "Wed, 21 Oct 2020 11:50:02 +0800")
Message-ID: <878sc0i2ac.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

>> Hm, can this export only if FAT_KUNIT_TEST is builtin or module (maybe
>> #if IS_ENABLED(...))? And #if will also be worked as the comment too.
>>
>
> That's possible, but I'd prefer to export it unconditionally for two reasons:
> 1. It'd make it possible to build the fat_test module without having
> to rebuild the whole kernel/fat.
> 2. It'd be consistent with fat_time_unix2fat(), which is exported for
> use in vfat/msdos anyway.
>
> Neither of those are dealbreakers, though, so if you'd still prefer
> this to be behind an ifdef, I'll change it.

OK. If nobody complain, let's export. However, then, can you add the
comment instead of ifdef to mark for kunit?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
