Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94365B9DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 04:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjACDvw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 22:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjACDvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 22:51:50 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196B1AE;
        Mon,  2 Jan 2023 19:51:49 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by gnuweeb.org (Postfix) with ESMTPSA id 9A1217E444;
        Tue,  3 Jan 2023 03:51:48 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672717908;
        bh=QYJzaVWEN9rJqXhGfvYSckZDzJI7KSe/z6dryTHgH4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JxqhMMS95GgOfb9fLwje/ktE3eLW6QdDFaZX5Kb1EUSkEEFHigAKR8X4gOokcDomp
         620fDZ22zZpgsCVBJLJqXcbh03sE+5YoulmPR99WulRLeLDhAajTFK5zYkGr4O/izh
         MMDaawc/E2/D6QQNF3gToDKdjoA7wsBDO9qPZEVlUMo604i17jYFfl+raJgluJKTON
         MKHy+1tLTZ8kVYWyhm0DdXxz/GdHX3fcy3D18fB1A2/rRML0DNwmOeHJNIkGVbvZwi
         inBSEbAhulZgvIMxmVLx4aCxifMrHlf0h2eTaLR07CLFMHkF2cnr7pADDlp7ZqfaUe
         zPEMe6Xb0RWyQ==
Received: by mail-lf1-f48.google.com with SMTP id 1so44023177lfz.4;
        Mon, 02 Jan 2023 19:51:48 -0800 (PST)
X-Gm-Message-State: AFqh2kpbKlRuypGvuyLb8mLEzuVN/LvqHQAGe1HKM8WGkEJb6aSQ58wc
        BSghpxIkI+p29jAfh6aB1LhcyGwqweXnoeeSq+M=
X-Google-Smtp-Source: AMrXdXuzaNFgikwUSNWt0817iguzQbXD08dVoevW9eoI/uBjB4kQLl4/vK0FCOJ0JrJ2xjpstQ+HSOg8ncxM52UP9t8=
X-Received: by 2002:a05:6512:34d3:b0:4cb:c78:1895 with SMTP id
 w19-20020a05651234d300b004cb0c781895mr967155lfr.83.1672717906547; Mon, 02 Jan
 2023 19:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
In-Reply-To: <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Tue, 3 Jan 2023 10:51:35 +0700
X-Gmail-Original-Message-ID: <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
Message-ID: <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 29, 2022 at 6:42 PM Ammar Faizi wrote:
> On 12/28/22 8:35 PM, Willy Tarreau wrote:
> > It gives me the correct code for x86_64 and i586. I don't know if other
> > architectures will want to add a prologue. I tried with "naked" but it's
> > ignored by the compiler since the function is not purely asm. Not very
> > important but given that we already have everything to perform our calls
> > it would make sense to stay on this. By the way, for the sake of
> > consistency with other syscalls, I do think the function (or label if
> > we can't do otherwise) should be called "sys_rt_sigreturn" as it just
> > performs a syscall.
>
> Will call that 'sys_rt_sigreturn' in the next series.

From glibc source code says:
GDB needs some intimate knowledge about it to recognize them as signal
trampolines, and make backtraces through signal handlers work right.
Important are both the names (__restore_rt) and the exact instruction
sequence.

link: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/sigaction.c;h=4e6d9cc32e1e18746726fa430d092de9a19ba6c6;hb=b4a5d26d8835d972995f0a0a2f805a8845bafa0b#l34

glibc does this:

   "    .type __" #name ",@function\n" \
   "__" #name ":\n"                    \
   "    movq $" #syscall ", %rax\n"    \
   "    syscall\n"                     \

where

   #name = "restore_rt"
   #syscall = __NR_rt_sigreturn

I think it should be called "__restore_rt" instead of "sys_rt_sigreturn"?
glibc also has unwind information, but we probably don't need to care
with that much
