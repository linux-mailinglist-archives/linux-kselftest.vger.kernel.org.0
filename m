Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A6BC3CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 10:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504040AbfIXIHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 04:07:21 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39257 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503934AbfIXIHV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 04:07:21 -0400
Received: by mail-wm1-f52.google.com with SMTP id v17so941991wml.4;
        Tue, 24 Sep 2019 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vazoaJV8w6hXBuGcHHYiuY1lqVoAb/qasD3kvGZNtoI=;
        b=uwCe+JBkx/ianOrarr5XVh4sVtM2bN6EOy+rywel/DgCMbKDeRGoYF/Xw3zeBsFpsW
         DTBS5YcoSYMo0oqgUu/4UvAbDLfXBUIPzxqL04w59l641+pNI3bkxWcr25lW+PXUQUUw
         qz3gvAq8LVvdl+JvBvycCQn3XEgIK6D4qBX5H6+AdRsw8VhCwyMpjE6PDT3Qb5DfvW1W
         Qny1dsWGmnuAukL9pDGcUAmAemxjsvfQHnd6z9lqhAkTkBXR1NXaHaYCblYRBkgX4+1y
         rH79Uzm6qLFpe87ltCEk/8C79pSQ0Nf6hIWtrn0RwjF4lO6WW0CnbY+4w4FqryAwgnKe
         5mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vazoaJV8w6hXBuGcHHYiuY1lqVoAb/qasD3kvGZNtoI=;
        b=OSpLFa+xymHzVpQMHhpt8f5O2dtpCqE7MtvH/aitA5mm7pdPg//HrTvalXoldiHSu3
         pCbWvYQWYGPK3kHQcJOuN+7LyDq5GuitrE16NBNd87NY2AEDpzB7oEKj4fQR93gMDMye
         hki3oXZ0uGC38dmDCEW6OuxvqN5DEuB/g3NQVN7XkaXFl5+hlcNHGe80vfzmFtiH+N/+
         +zE0cYvTJesAgHH4l3Zx4ScRzJK9HtaeQTf3OccJX8QtocfCnCg1+qDy+KIrUM6gGuVt
         HVN5wolIWEgs0m0VnrzyL6GaWN7gBxnso0mP4ygQfChuY4l/QX61DElyL25HJh+jOGht
         Os4w==
X-Gm-Message-State: APjAAAXkmRwDSjlGMwTGc8BgL+QqpcQSijameoDkZkHm9/ZNu/WVEueF
        iuOqBddKwBbmKOGHfHu2+D0=
X-Google-Smtp-Source: APXvYqyf1JKKGJC2wktTnx0Kdyy1fK1Sztzy0S3aKXmkFcSCQG/+ODXjdnuIcUAnsJWuuUp6KcUU3g==
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr1504702wmi.108.1569312437903;
        Tue, 24 Sep 2019 01:07:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d9sm2118700wrf.62.2019.09.24.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 01:07:17 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:07:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim.Bird@sony.com
Cc:     torvalds@linux-foundation.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org, broonie@kernel.org,
        jarkko.sakkinen@linux.intel.com, anders.roxell@linaro.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190924080715.GA63699@gmail.com>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BB784@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BB784@USCULXMSG01.am.sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Tim.Bird@sony.com <Tim.Bird@sony.com> wrote:

> > -----Original Message-----
> > From: Ingo Molnar on Sunday, September 22, 2019 1:26 AM
> > 
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Sorry about that. I am surprised that none of the other reviewers
> > > > brought this up.
> > >
> > > I think I'm "special".
> > >
> > > There was some other similar change a few years ago, which I
> > > absolutely hated because of how it broke autocomplete for me. Very few
> > > other people seemed to react to it.
> > 
> > FWIW, I am obsessively sensitive to autocomplete and overall source code
> > file hieararchy and nomenclature details as well, so it's not just you.
> > 
> > Beyond the muscle memory aspect, nonsensical naming and inanely flat file
> > hierarchies annoy kernel developers and makes it harder for newbies to
> > understand the kernel source as well.
> > 
> > The less clutter, the more organization, the better - and there's very
> > few valid technical reasons to add any new files or directories to the
> > top level directory - we should probably *remove* quite a few.
> > 
> > For example 'firmware/' was recently moved to drivers/firmware/, and in a
> > similar fashion about a third of the remaining 22 directories should
> > probably be moved too:
> > 
> >   drwxr-xr-x    arch
> >   drwxr-xr-x    block
> >   drwxr-xr-x    certs           # move to build/certs/ dir
> >   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
> >   drwxr-xr-x    Documentation
> >   drwxr-xr-x    drivers
> >   drwxr-xr-x    fs
> >   drwxr-xr-x    include
> >   drwxr-xr-x    init
> >   drwxr-xr-x    ipc             # move to kernel/ipc/
> >   drwxr-xr-x    kernel
> >   drwxr-xr-x    lib
> >   drwxr-xr-x    LICENSES
> >   drwxr-xr-x    mm
> >   drwxr-xr-x    net
> >   drwxr-xr-x    samples         # move to Documentation/samples/
> >   drwxr-xr-x    scripts         # move to build/scripts/
> 
> This one seems like it would break a lot of workflows, and contributor
> muscle memory and scripts.  get_maintainer.pl and checkpatch.pl
> are probably in quite a few people's scripts.
> 
> Also, I'm not sure '/build' is the right destination for this.  There
> are a lot more things in there than just build scripts.  If you really
> want to remove the top level 'scripts', it might be best to put
> the  scripts from top-level '/scripts' into '/tools/scripts', which is
> mostly empty now.

Agreed - I'll leave it alone for now, because you are right that it's 
widely used.

Thanks,

	Ingo
