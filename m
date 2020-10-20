Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E658229353A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgJTGvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 02:51:39 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:40838 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgJTGvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 02:51:39 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 93D7F1B3B63;
        Tue, 20 Oct 2020 15:51:37 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09K6paro1584010
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 15:51:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09K6pavD1770796
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 15:51:36 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 09K6pZ7p1770795;
        Tue, 20 Oct 2020 15:51:35 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: Add KUnit tests for checksums and timestamps
References: <20201020055856.1270482-1-davidgow@google.com>
Date:   Tue, 20 Oct 2020 15:51:35 +0900
In-Reply-To: <20201020055856.1270482-1-davidgow@google.com> (David Gow's
        message of "Mon, 19 Oct 2020 22:58:56 -0700")
Message-ID: <87d01die4o.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index f1b2a1fc2a6a..445ad3542e74 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -229,6 +229,7 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
>  		ts->tv_nsec = 0;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fat_time_fat2unix);

Hm, can this export only if FAT_KUNIT_TEST is builtin or module (maybe
#if IS_ENABLED(...))? And #if will also be worked as the comment too.

>  
>  /* Convert linear UNIX date to a FAT time/date pair. */
>  void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
