Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4F467E90
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353722AbhLCUBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 15:01:48 -0500
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:44464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353665AbhLCUBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 15:01:45 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 15:01:45 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id A98EC180A7755
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 19:50:51 +0000 (UTC)
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 39E0A1833B033;
        Fri,  3 Dec 2021 19:50:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id E054846;
        Fri,  3 Dec 2021 19:50:47 +0000 (UTC)
Message-ID: <983ee57718a6e5838f79be96b7f7efc638177f76.camel@perches.com>
Subject: Re: [PATCH] mnt: remove unneeded conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        davidcomponentone@gmail.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Fri, 03 Dec 2021 11:50:47 -0800
In-Reply-To: <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
References: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
         <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E054846
X-Spam-Status: No, score=-4.80
X-Stat-Signature: 8azozw8hph8h4bhn76oots7xepur15ww
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+HQzYyVsx4UOivXp9oYFki3fVdhkr27jI=
X-HE-Tag: 1638561047-943619
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2021-12-03 at 11:26 -0700, Shuah Khan wrote:
> On 11/24/21 5:56 PM, davidcomponentone@gmail.com wrote:
> > From: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > The coccinelle report
> > ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
> > WARNING: conversion to bool not needed here
> > ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
> > WARNING: conversion to bool not needed here
> > Relational and logical operators evaluate to bool,
> > explicit conversion is overly verbose and unneeded.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> > ---
> >   tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> > index 584dc6bc3b06..d2917054fe3a 100644
> > --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> > +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> > @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
> >   		if (!WIFEXITED(status)) {
> >   			die("child did not terminate cleanly\n");
> >   		}
> > -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> > +		return WEXITSTATUS(status) == EXIT_SUCCESS;
> >   	}
> >   
> >   	create_and_enter_userns();
> > @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
> >   		if (!WIFEXITED(status)) {
> >   			die("child did not terminate cleanly\n");
> >   		}
> > -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> > +		return WEXITSTATUS(status) == EXIT_SUCCESS;
> >   	}
> >   
> >   	orig_mnt_flags = read_mnt_flags(orig_path);
> > 
> 
> This change doesn't look right. WEXITSTATUS(status) return could be
> > 1 or 0 or negative.

The change is at least logically correct.

And isn't WEXITSTATUS range limited from 0->255 ?

https://www.gnu.org/software/libc/manual/html_node/Exit-Status.html


