Return-Path: <linux-kselftest+bounces-41847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7662B85209
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623CE7BC33D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88130CD8D;
	Thu, 18 Sep 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XtILx/zR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5930CD89;
	Thu, 18 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204475; cv=none; b=ARdPAaICz5Q9NgGXruy2vZtdb6qVSm7B/Qzw6hb8GoPG38+jqj5q/RuhDBt0TTMIY5tFT/XyCzk7dUXV93YR2kZDwz+b8qDSjSiOE61DomTRIzhFEWV98rHudrIKehMepOZoSHAwLl2NFZlUIGn9YUxqjeLA94ACFvd0F35o4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204475; c=relaxed/simple;
	bh=KLL9YJXtSSSZ1Vd0/isQrxMphZZqXIjYKKJpaSBPKo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkuFmo1AQcCdNW6ticJAPhrLUaPWCnelFO5qjX7TB6bmImun+dpHZjbfTUNmwgG6lH/Hm5ikcy9g6TUM/vSDcpRWoY/63692rs0/4NKMEbLe2TX9iwOR7qD6TixNWkH8ihEF+W/htenF1uVTlHzWo/Prepx8dlzlt6Pabm5sdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XtILx/zR; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSHXN2pvBznsr;
	Thu, 18 Sep 2025 16:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758204468;
	bh=vVKOs9N1kLsZNFyRJ52LmCjCUC7Qes6mPkdcbujsc20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtILx/zREilfKNPvUphCInZ9NyXZCREZmkr3va/pK38KPQmvCT7r3aNiMvEe3g5yf
	 NQIAWHYCLNkKeevf/KYc1jX1Dx0rSIPxw3s2V/1Zfwy+IIG7W8p/XGCS0XG8way6na
	 kGyL8Mz14mNHZcAmfKn3Hcruo4Wpy6u5cICPdD/8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSHXM4HPxzZ8T;
	Thu, 18 Sep 2025 16:07:47 +0200 (CEST)
Date: Thu, 18 Sep 2025 16:07:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Fan Wu <wufan@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH RFC 2/4] landlock: implement memfd detection
Message-ID: <20250918.kieghied1ahS@digikod.net>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
 <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
 <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
 <87v7nj7p1d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7nj7p1d.fsf@gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 22, 2025 at 03:56:38PM -0600, Abhinav Saxena wrote:
> Fan Wu <wufan@kernel.org> writes:
> 
> > On Sat, Jul 19, 2025 at 4:13 AM Abhinav Saxena <xandfury@gmail.com> wrote:
> >>
> >> Add is_memfd_file() function to reliably detect memfd files by checking
> >> for “memfd:” prefix in dentry names on shmem-backed files. This
> >> distinguishes true memfd files from regular shmem files.
> >>
> >> Move domain_is_scoped() to domain.c for reuse across subsystems.
> >> Add comprehensive kunit tests for memfd detection edge cases.
> >>
> >> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> >> —
> >>  security/landlock/domain.c |  67 +++++++++++++++
> >>  security/landlock/domain.h |   4 +
> >>  security/landlock/fs.c     | 210 +++++++++++++++++++++++++++++++++++++++++++++
> >>  security/landlock/task.c   |  67 —————
> >>  4 files changed, 281 insertions(+), 67 deletions(-)
> >
> > …
> >
> >>
> >> +/**
> >> + * is_memfd_file - Check if file was created via memfd_create()
> >> + * @file: File to check
> >> + *
> >> + * Returns true if @file was created via memfd_create(), false otherwise.
> >> + *
> >> + * memfd files are shmem-backed files with “memfd:” prefix in their dentry name.
> >> + * This is the definitive way to distinguish memfd files from regular shmem
> >> + * files.
> >> + */
> >> +static bool is_memfd_file(struct file *file)
> >> +{
> >> +       const struct dentry *dentry;
> >> +       const unsigned char *name;
> >> +       size_t name_len;
> >> +
> >> +       /* Fast path: basic validation */
> >> +       if (unlikely(!file))
> >> +               return false;
> >> +
> >> +       /* Must be shmem-backed first - this is the cheapest definitive check */
> >> +       if (!shmem_file(file))
> >> +               return false;

In which case a memfd would not be detected by this function?
shmem_file_operations or hugetlbfs_file_operations are always set for
memfd right?

We could export memfd_get_seals() to stay consistent over time.

> >> +
> >> +#ifdef CONFIG_MEMFD_CREATE
> >> +
> >> +       /* Validate dentry and get name info */
> >> +       dentry = file->f_path.dentry;
> >> +       if (unlikely(!dentry))
> >> +               return false;
> >> +
> >> +       name_len = dentry->d_name.len;
> >> +       name = dentry->d_name.name;
> >> +
> >> +       /* memfd files always have “memfd:” prefix (6 characters) */
> >> +       if (name_len < 6 || unlikely(!name))
> >> +               return false;
> >> +
> >> +       /* Check for exact “memfd:” prefix */
> >> +       return memcmp(name, “memfd:”, 6) == 0;
> >> +#else
> >> +       return false;
> >> +#endif
> >
> > I was trying to do something similar early this year but didn’t hear
> > feedback from the linux-mm folks.
> > <https://lore.kernel.org/linux-security-module/20250129203932.22165-1-wufan@kernel.org/>
> >
> > I have considered this approach but didn’t use it. My concern is,
> > potentially a malicious user can create a file in a shmem fs, e.g.
> > tmpfs , with the “memfd:” prefix, which can be used to bypass security
> > policy.

In the case of Landlock that should not be a security issue but a
compatibility issue, which is not better.

> > (Resending this message due to a misconfiguration with my email
> > client. Apologies for any inconvenience.)
> >
> > -Fan
> 
> Hi Fan,
> 
> Thanks for your comments.
> 
> I agree that an LSM hook into memfd_create() would be a much better
> solution. In the absence of such a function, do you think adding a
> `d_unlinked(dentry)` check could serve as an additional verification?
> 
> I say things since I *think* that legitimate memfd files are always
> unlinked while spoofed tmpfs files remain linked. I could be wrong
> though.

We should just use the same checks used by the memfd-related
syscalls/operations to detect such file.

> 
> In any case, we can test this approach using kprobes to validate
> the behavior.
> 
> -Abhinav


