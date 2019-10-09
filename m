Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC65AD05AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 04:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfJICo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 22:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfJICo5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 22:44:57 -0400
Received: from devnote2 (p242255-mobac01.tokyo.ocn.ne.jp [153.233.233.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4342E206C2;
        Wed,  9 Oct 2019 02:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570589096;
        bh=c3xOQvgGYBl3S/m/w8Bh9SPFzZtWX2+5tkofg57Vly4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hYZrjhTHk5VJLOxbjajBo4aswHgdlgYgfoy+JbXYsktzTN6LVJnfKZdY+cEJl7Itj
         tzHo0TA1BUrYAqHa9clZ0OMdyG8H/ze1iCw+wxb/0lqtWfm6zbNwf0vQgXBNdMvgKX
         a2P/FakCMYpuNZrByP54VmFAW22sX0ErRXcBZ1Co=
Date:   Wed, 9 Oct 2019 11:44:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     <Tim.Bird@sony.com>
Cc:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jaswinder.singh@linaro.org>
Subject: Re: [BUGFIX PATCH] selftests: Use real temporary working directory
 for archiving
Message-Id: <20191009114452.c87aea39cf858d3d8049ee1f@kernel.org>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977C0D28@USCULXMSG01.am.sony.com>
References: <157016600217.8022.346317009413291058.stgit@devnote2>
        <ECADFF3FD767C149AD96A924E7EA6EAF977C0D28@USCULXMSG01.am.sony.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 8 Oct 2019 23:39:40 +0000
<Tim.Bird@sony.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Masami Hiramatsu on Thursday, October 03, 2019 7:13 PM
> > 
> > Use real temporary working directory for generating kselftest
> > archive.
> > 
> > tools/testing/selftests/kselftest directory has been used for
> > the temporary working directory for making a tar archive from
> > gen_kselftest_tar.sh, and it removes the directory for cleanup.
> > 
> > However, since the kselftest directory became a part of the
> > repository, it must not be used as a working dir.
> 
> I'm not objecting to the test, but I would like to understand this
> point better.  Under normal circumstances (i.e. when not using O= or KBUILD_OUTPUT)
> the rest of the kernel directory structure holds generated files.
> What is the issue with using kselftest to hold generated files?

OK, after running ./gen_kselftest_tar.sh in tools/testing/selftests,
I found there is no tools/testing/selftests/kselftest was there.
Actually, this was found when I searched "runner.sh" on the tree
after building kselftest.tar.gz. I couldn't find it and realized that
the gen_kselftest_tar.sh removed kselftest directory.

This is not happen if you run gen_kselftest_tar.sh.

Thank you,

>  -- Tim
> 
> > 
> > Introduce mktemp to prepare a temporary working directory
> > for archiving kselftests.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/testing/selftests/gen_kselftest_tar.sh |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/gen_kselftest_tar.sh
> > b/tools/testing/selftests/gen_kselftest_tar.sh
> > index a27e2eec3586..eba1e9987ffc 100755
> > --- a/tools/testing/selftests/gen_kselftest_tar.sh
> > +++ b/tools/testing/selftests/gen_kselftest_tar.sh
> > @@ -38,16 +38,16 @@ main()
> >  	esac
> >  	fi
> > 
> > -	install_dir=./kselftest
> > +	tmpdir=`mktemp -d ./install-XXXXXX` || exit 1
> > 
> >  # Run install using INSTALL_KSFT_PATH override to generate install
> >  # directory
> > -./kselftest_install.sh
> > -tar $copts kselftest${ext} $install_dir
> > +./kselftest_install.sh $tmpdir
> > +tar $copts kselftest${ext} -C $tmpdir kselftest
> >  echo "Kselftest archive kselftest${ext} created!"
> > 
> >  # clean up install directory
> > -rm -rf kselftest
> > +rm -rf $tmpdir
> >  }
> > 
> >  main "$@"
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
