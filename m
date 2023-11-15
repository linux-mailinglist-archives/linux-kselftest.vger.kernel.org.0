Return-Path: <linux-kselftest+bounces-175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A27ECAD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 19:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E983B20B40
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43313A8D5;
	Wed, 15 Nov 2023 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpseXpzT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A0199A4;
	Wed, 15 Nov 2023 18:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28932C433C8;
	Wed, 15 Nov 2023 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700074689;
	bh=mbFipe60nh3wXLVitXBcl5WWbT6GAolpsW6Rl8bu/7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpseXpzTT0wSMAcgWMBgg2pysbbYQcPIX7NHH/8c2wXEatuGVcSoAxK7hnneM8DjV
	 iqDwv7Px+d2o3L6+b7ZG7VYKRFWEXiYh5bOLrYKR985uMxu7SuK78I0/upIWwcVpWj
	 K9P/dAtEhJwm/gUauhw7RWPURRvUVgJt4wwIR4sl9diVcqTef0KBsVGU62oOr1lKfe
	 onZxHEO6ln21IxWL9b6toFUlCb5lNEsvQhtZp1cV3hjQ9ZcQx7jHh77KQBVIRhIidM
	 y3t4wHjjiED4OGjuHekJ8AqUGQTbDcInRINTbVVscnZNd/ukT9wBTf8V6hDjFbTYcl
	 oadiSqjcx9eEw==
Date: Wed, 15 Nov 2023 10:58:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
	Chandan Babu R <chandanrlinux@gmail.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Message-ID: <20231115185808.GD36211@frogsfrogsfrogs>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>

On Wed, Nov 15, 2023 at 07:43:50PM +0200, Nikolai Kondrashov wrote:
> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> ---
>  Documentation/process/tests.rst | 32 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
> index 907311e91ec45..9a9ea3fe65c37 100644
> --- a/Documentation/process/tests.rst
> +++ b/Documentation/process/tests.rst
> @@ -33,3 +33,35 @@ particularly useful:
>  
>  :Source: A URL pointing to the source code of the test suite
>  :Docs: A URL pointing to further test suite documentation
> +
> +xfstests
> +--------
> +
> +:Summary: File system regression test suite
> +:Source: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

You might as well use the https link to the fstests git repo.
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md

Awkardly, this github link is nice for rendering the markdown as html,
but I think the canonical source of xfstests-bld is also kernel.org:

https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git

> +
> +As the name might imply, xfstests is a file system regression test suite which
> +was originally developed by Silicon Graphics (SGI) for the XFS file system.
> +Originally, xfstests, like XFS was only supported on the SGI's Irix operating
> +system. When XFS was ported to Linux, so was xfstests, and now xfstests is
> +only supported on Linux.
> +
> +Today, xfstests is used as a file system regression test suite for all of
> +Linux's major file systems: xfs, ext2, ext4, cifs, btrfs, f2fs, reiserfs, gfs,
> +jfs, udf, nfs, and tmpfs. Many file system maintainers will run a full set of
> +xfstests before sending patches to Linus, and will require that any major
> +changes be tested using xfstests before they are submitted for integration.
> +
> +The easiest way to start running xfstests is under KVM with xfstests-bld:
> +https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> +
> +kvm-xfstests smoke
> +------------------
> +
> +:Summary: File system smoke tests
> +:Superset: xfstests

Source: https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git

?

> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> +
> +The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
> +file systems, running under KVM.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2565c04f0490e..f81a47d87ac26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7974,6 +7974,7 @@ L:	linux-ext4@vger.kernel.org
>  S:	Maintained
>  W:	http://ext4.wiki.kernel.org
>  Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
> +V:	kvm-xfstests smoke

I wouldn't mind one of these being added to the XFS entry, though I've
cc'd the current and past maintainer(s) of XFS for their input.

--D

>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>  F:	Documentation/filesystems/ext4/
>  F:	fs/ext4/
> -- 
> 2.42.0
> 

