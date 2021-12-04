Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013346821A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Dec 2021 04:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384127AbhLDDRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 22:17:25 -0500
Received: from relay038.a.hostedemail.com ([64.99.140.38]:26511 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384126AbhLDDRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 22:17:25 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 22:17:25 EST
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 5B693203FE;
        Sat,  4 Dec 2021 03:07:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 078B52002F;
        Sat,  4 Dec 2021 03:06:40 +0000 (UTC)
Message-ID: <2236458d6a4e77bd09afb13bba65747a3416f293.camel@perches.com>
Subject: Re: [PATCH] mnt: remove unneeded conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        davidcomponentone@gmail.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Fri, 03 Dec 2021 19:06:40 -0800
In-Reply-To: <eef8e264-7cf7-8747-867e-b40c9f180d0d@linuxfoundation.org>
References: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
         <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
         <983ee57718a6e5838f79be96b7f7efc638177f76.camel@perches.com>
         <eef8e264-7cf7-8747-867e-b40c9f180d0d@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: smr71dzt7ndresc7qrttbw7o6ocaxgfd
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 078B52002F
X-Spam-Status: No, score=-4.90
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/gRbVzh7w/1ujJibE/Phog2pI4ecg335U=
X-HE-Tag: 1638587200-314246
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2021-12-03 at 17:24 -0700, Shuah Khan wrote:
> On 12/3/21 12:50 PM, Joe Perches wrote:
> > On Fri, 2021-12-03 at 11:26 -0700, Shuah Khan wrote:
> > > On 11/24/21 5:56 PM, davidcomponentone@gmail.com wrote:
> > > > From: Yang Guang <yang.guang5@zte.com.cn>
> > > > 
> > > > The coccinelle report
> > > > ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
> > > > WARNING: conversion to bool not needed here
> > > > ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
> > > > WARNING: conversion to bool not needed here
> > > > Relational and logical operators evaluate to bool,
> > > > explicit conversion is overly verbose and unneeded.
> > > > 
> > > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > > Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> > > > ---
> > > >    tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> > > > index 584dc6bc3b06..d2917054fe3a 100644
> > > > --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> > > > +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> > > > @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
> > > >    		if (!WIFEXITED(status)) {
> > > >    			die("child did not terminate cleanly\n");
> > > >    		}
> > > > -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> > > > +		return WEXITSTATUS(status) == EXIT_SUCCESS;
> > > >    	}
> > > >    
> > > >    	create_and_enter_userns();
> > > > @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
> > > >    		if (!WIFEXITED(status)) {
> > > >    			die("child did not terminate cleanly\n");
> > > >    		}
> > > > -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> > > > +		return WEXITSTATUS(status) == EXIT_SUCCESS;
> > > >    	}
> > > >    
> > > >    	orig_mnt_flags = read_mnt_flags(orig_path);
> > > > 
> > > 
> > > This change doesn't look right. WEXITSTATUS(status) return could be
> > > > 1 or 0 or negative.
> > 
> > The change is at least logically correct.
> > 
> > And isn't WEXITSTATUS range limited from 0->255 ?
> > 
> > https://www.gnu.org/software/libc/manual/html_node/Exit-Status.html
> > 
> 
> You are right. In any case, I don't see any value in changing the current
> logic. The way it is coded is cryptic enough :)

Well, it'd be more like the rest of the kernel when changed.

bool function()
{
	...
	return <foo> ? true : false;
}

is pretty redundant.


