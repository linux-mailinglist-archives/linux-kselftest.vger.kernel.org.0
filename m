Return-Path: <linux-kselftest+bounces-240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A57EECB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 08:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E2B209F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09102DDC2;
	Fri, 17 Nov 2023 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3yznsa9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F41D529;
	Fri, 17 Nov 2023 07:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67DCC433C7;
	Fri, 17 Nov 2023 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700206744;
	bh=MDu1t0zFSNc308/snawMqMaX2iwig8LNL/B47AR5Y1o=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=i3yznsa96M1YjRT5IOwa0ePeCMITU48CZTwcE3pjxJ3e/sRxhDVNpulJlsPcmXt44
	 E6jfNDIjR6SwMOYVR933Zahw7aPoH+lmtkLrUkYjIUjTfWBFTcTCXynZtfGKbBAQtn
	 iFJPDaYioxX5vIxN8nEoPhm6UToQNwZiOeY5tPPw4QGiXrkHk4VTkeRMyWwjjTrFFo
	 hyoPAHv5DyAfQ/XwomGbI/FVMBwfTOe8dA6qQmnKLMu6+e5d/RmWUQoLaBhpDK6prW
	 1j7l7/XWAMCsohEvQ0jRxI42m/XHOJ1PLUEZuPWRvUIJytOdlWxywxUxCXreQdNOF3
	 kKojjhYVyD4Ng==
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>, Andy Whitcroft
 <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>, David Gow
 <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev, Chandan Babu R <chandanrlinux@gmail.com>, Dave
 Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Date: Fri, 17 Nov 2023 12:39:56 +0530
In-reply-to: <20231115185808.GD36211@frogsfrogsfrogs>
Message-ID: <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 15, 2023 at 10:58:08 AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 15, 2023 at 07:43:50PM +0200, Nikolai Kondrashov wrote:
>> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
>> ---
>>  Documentation/process/tests.rst | 32 ++++++++++++++++++++++++++++++++
>>  MAINTAINERS                     |  1 +
>>  2 files changed, 33 insertions(+)
>> 
>> diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
>> index 907311e91ec45..9a9ea3fe65c37 100644
>> --- a/Documentation/process/tests.rst
>> +++ b/Documentation/process/tests.rst
>> @@ -33,3 +33,35 @@ particularly useful:
>>  
>>  :Source: A URL pointing to the source code of the test suite
>>  :Docs: A URL pointing to further test suite documentation
>> +
>> +xfstests
>> +--------
>> +
>> +:Summary: File system regression test suite
>> +:Source: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> You might as well use the https link to the fstests git repo.
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md
>
> Awkardly, this github link is nice for rendering the markdown as html,
> but I think the canonical source of xfstests-bld is also kernel.org:
>
> https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
>
>> +
>> +As the name might imply, xfstests is a file system regression test suite which
>> +was originally developed by Silicon Graphics (SGI) for the XFS file system.
>> +Originally, xfstests, like XFS was only supported on the SGI's Irix operating
>> +system. When XFS was ported to Linux, so was xfstests, and now xfstests is
>> +only supported on Linux.
>> +
>> +Today, xfstests is used as a file system regression test suite for all of
>> +Linux's major file systems: xfs, ext2, ext4, cifs, btrfs, f2fs, reiserfs, gfs,
>> +jfs, udf, nfs, and tmpfs. Many file system maintainers will run a full set of
>> +xfstests before sending patches to Linus, and will require that any major
>> +changes be tested using xfstests before they are submitted for integration.
>> +
>> +The easiest way to start running xfstests is under KVM with xfstests-bld:
>> +https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>> +
>> +kvm-xfstests smoke
>> +------------------
>> +
>> +:Summary: File system smoke tests
>> +:Superset: xfstests
>
> Source: https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
>
> ?
>
>> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>> +
>> +The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
>> +file systems, running under KVM.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2565c04f0490e..f81a47d87ac26 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7974,6 +7974,7 @@ L:	linux-ext4@vger.kernel.org
>>  S:	Maintained
>>  W:	http://ext4.wiki.kernel.org
>>  Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
>> +V:	kvm-xfstests smoke
>
> I wouldn't mind one of these being added to the XFS entry, though I've
> cc'd the current and past maintainer(s) of XFS for their input.
>
> --D
>

IMHO, For XFS, The value of "V" field should refer to xfstests rather than a
framework built around xfstests. This is because xfstests project contains the
actual tests and also we could have several frameworks (e.g. Kdevops) for
running xfstests.

I think "kvm-xfstests smoke" could be mentioned in
Documentation/process/tests.rst as one of the easier methods to execute
xfstests.

Also, We could add a statement in Documentation/process/tests.rst encouraging
the patch author to look into xfstests/tests/[generic|xfs]/group.list files to
pick and execute test groups which are applicable to areas of XFS
(e.g. realtime) being modified.


>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>>  F:	Documentation/filesystems/ext4/
>>  F:	fs/ext4/
>> -- 
>> 2.42.0
>> 

-- 
Chandan

