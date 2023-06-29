Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B5742403
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjF2Kao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjF2Kaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 06:30:30 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F82D5B;
        Thu, 29 Jun 2023 03:30:12 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A808FC020; Thu, 29 Jun 2023 12:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1688034610; bh=if9qbAJfyLZr3BzQNxYrgUhfEv4hP+9JnW2xBmEgwCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEfVaX0t2OTlde6Nd3qey+ECr1O+nYrxhyKKZOCmXh/2Kgcop7vRZZGfXcxSCkW9O
         vWBrQHO6EdSwboCUulup2O1xup6vfcwAA2DqiKe4OyYvd6TS6wbKjx41Lx5ZQxmYFv
         zxl6hIZ+F/OljOeiV/hZ0rKO9KXNX19gdAieVTBhnlRlqRIKPe4znCamk91RyWjpgd
         Zo4wwqIiqmylUaGksQz3sONpgxlJcMR0v+5kLVORcCl+zKCict7j3FOqPvvQYM5ZGL
         SeG9xnU8RQs8NhqFGuZ8Ohh+FQRrWzJa8NGmufRUwA7LHNGGXMMOSq8i7/cS3aUDfk
         62Jh4ql10yc5A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 3F9D1C009;
        Thu, 29 Jun 2023 12:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1688034609; bh=if9qbAJfyLZr3BzQNxYrgUhfEv4hP+9JnW2xBmEgwCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCJfaWg5ag2BGOgbHK7s89C2ekhrviQD8tcS4Twse5JOBeKNyoTJCAq6SGCTf3SSf
         X1jwKdSvMnpNmpynUzepZLjmFnIxPK19pPmpvR+qjvvhZ2fvVcq/pmCh2GawrhqyeQ
         b3QDV4VSIrSfZZ9w4doi9uyaaNanBZZZr+x/38T/xBOZaW9oDALteGq0rBLMZse75m
         9Y++q6QRmQUnN8ijUoIV+bhbSd2BmwuIs4tjSf6bVKI0ogoVMNhVoYuu2VuWHmpuba
         xjGs0VygsedMgSD2vLPool/GcdCoTQXjq0M3iwsj7gCkkDAMpgfqC87vJrtjrgn7mn
         s5NXJ8uUYen7A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9e8fd47c;
        Thu, 29 Jun 2023 10:30:01 +0000 (UTC)
Date:   Thu, 29 Jun 2023 19:29:46 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <ZJ1dGvWkJVAbBPn7@codewreck.org>
References: <20221215001205.51969-1-jeffxu@google.com>
 <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org>
 <ZJyKeeqRJxzwlMhk@codewreck.org>
 <CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jeff Xu wrote on Wed, Jun 28, 2023 at 09:33:27PM -0700:
> > > BTW I find the current behaviour rather hard to use: setting this to 2
> > > should still set NOEXEC by default in my opinion, just refuse anything
> > > that explicitly requested EXEC.
> >
> > And I just noticed it's not possible to lower the value despite having
> > CAP_SYS_ADMIN: what the heck?! I have never seen such a sysctl and it
> > just forced me to reboot because I willy-nilly tested in the init pid
> > namespace, and quite a few applications that don't require exec broke
> > exactly as I described below.
> >
> > If the user has CAP_SYS_ADMIN there are more container escape methods
> > than I can count, this is basically free pass to root on main namespace
> > anyway, you're not protecting anything. Please let people set the sysctl
> > to what they want.
>
> Yama has a similar setting,  for example, 3 (YAMA_SCOPE_NO_ATTACH)
> will not allow downgrading at runtime.
> 
> Since this is a security feature, not allowing downgrading at run time
> is part of the security consideration. I hope you understand.

I didn't remember yama had this stuck bit; that still strikes me as
unusual, and if you require a custom LSM rule for memfd anyway I don't
see why it couldn't enforce that the sysctl is unchanged, but sure.

Please, though:
 - I have a hard time thinking of 1 as a security flag in general (even
if I do agree a sloppy LSM rule could require it); I would only lock 2
 - please make it clear, I don't see any entry in the sysctl
documentation[1] about memfd_noexec, there should be one and you can
copy the wording from yama's doc[2]: "Once set, this sysctl value cannot
be changed"
[1] Documentation/admin-guide/sysctl/vm.rst
[2] Documentation/admin-guide/LSM/Yama.rst


Either way as it stands I still don't think one can expect most
userspace applications to be converted until some libc wrapper takes
care of the retry logic and a couple of years, so I'll go look for
another way of filtering this (and eventually setting this to 1) as you
suggested.
I'll leave the follow-up up to you and won't bother you more.

Thanks,
-- 
Dominique Martinet | Asmadeus
