Return-Path: <linux-kselftest+bounces-47026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0FCA4548
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BEEA30B75B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4D2D9EF3;
	Thu,  4 Dec 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Eed214"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9B2AD2B
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863014; cv=none; b=gAqs5yFW3JjACJhItaALvK/qpf7nbP/cQ/rG5uVwBC7JuX0I90lxj8aAuvslGC1qoDV3HkG3mlj01V8rubJcF+8tDQDebkCRAI4IQ0T1gC9wAw3WIp1SDQG97NpwZ5fHGSyz84zNm6HkWu75K9fea8rPqWHGm6Q60fUMnIeT/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863014; c=relaxed/simple;
	bh=iKUJIm2WGMEBpZ5Nv3OHKAdudbcM2UVOMkylidNxVPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBeCoxg9G7IxLKACRzENgGnslFSdCSOZLk1CwEtWiot3BIVHIe+gZpH+E0L4r8m7eQOMmqjnGCrck6n9TfI1ouIF0yx3mlD03gu7L2VDgthc9Ng97D4S0MDQOAuLVRljQtzPaflJjKV23SHG/cFVQFtqdDMFYeUhfUgp+uPbDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Eed214; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34372216275so1143408a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 07:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764863011; x=1765467811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcULqT1gBZ4JnBLfYhNZO/NSXxFxQuxnawJT72KsaCg=;
        b=b0Eed214jEfrU4eS3gnOoBcbOwGZ50ScGj+40v7Qa/mpjDyne6IjvFxQe58klC0jG7
         x7w7kCxEt+e5RnFeH8Xk7kKR5GllsyBpXLwYLqiP3wc3BiYjcBSy9F7I+B2VVwE8hWJg
         xiz3k/J76iwYa8Hoa5zyTrcGxGhkG0O6FfjmMr+P5q0DmV5zJwfyLB/UwgnvFrAG9Nl3
         jN20VALypVvlmPZqEojlO4uJXdENjtBNT9fMmezm4mtUuxgRzbRN1r5JhS49ei2veskp
         f3ge4DuYduvqll9mS/8FT6NeFMQNoG6PHhVevcE5bREYUZ5n9f7SSj4J2gZg5tZytUHM
         B/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764863011; x=1765467811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcULqT1gBZ4JnBLfYhNZO/NSXxFxQuxnawJT72KsaCg=;
        b=uwrwFFzW30tTJGV/0OIERSgkeko/22ISr83UKZ/gI1X58cGcC2DyT/MP/vdNOi5usl
         1lZhhlrUzte2nlon79GXU7KZ6NPkORBXLpm2HWgf640E7t15ZlMp6iDKFYZtAbNs8eo3
         BqmYrihcRkR8cBlCdGv9Gyqjh5yoOGa0VnbYuKFBKmq0mrDcjcZjcZTKo+00MC8crrys
         pXH4Q9zVXQmkS4OugE928+ZMqJjDHNRZMFHck1p8r7M97QLewxBIJYavVJcUotQ+OZ+N
         AVhV1hmJHLPioIwZyC39BVVj7oO12WMtov9W3GKvK36OU31L35QP2f/mDSaTEfPrd4ya
         PZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUupvbhasv/3R96h5OBGe8nWdQZd0SkJvdB0Xm9Eu6TGkvqrZE6QCAWctTC/nz6jS6/yXJWaZKapmlxIPRXvoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJtDVPpDhTk1ErPURE0LlUym7wp5JCsPPw8a7bPhG7eO0XpJ/
	5q7cFxoPR7wyk84KXovuxwhd2KetYXNfH8DCvT8WtFsYXk9NabVoOi1uK4joByrVAVl0oXvtMYb
	BZ4DJNkoUUqUBlgfc4CMxJrNZG+1zM18=
X-Gm-Gg: ASbGncuJHKgQ1W8BTbztiko7xWpyyvr8JABMwulOEX46vI4Hd6HZm8WM4JJeWiMDOYn
	31gOU1/599kFphYecA9svzTOIOrOGOyt20p0eSG3HofEB943nEoINVlTNKZ/FPTKyyQMAK56oqH
	lnqFVVjtmKrD+tTVOv5h6dIp0b1tPBGR2I37q0GlCwKJJTijtq7uZTtWC3P6rqsLsqY1fJcAJwo
	brRQDc0j+Pj6AvQxv1yo4NOSiiQSHeMeHnaHYuVp2ulCK18l26YmXQAXxYQiDlTuExzJ8nDEZyx
	Rf/JDA==
X-Google-Smtp-Source: AGHT+IGPP0xbr8ijlvBCGceLouNPETyq6yt+2wUuDhEptf1TXNXkd61Kk0839gQ/19JRkHkqwlnGsXbepfF7hCbJxRQ=
X-Received: by 2002:a17:90a:c883:b0:33b:d74b:179 with SMTP id
 98e67ed59e1d1-349126e0e1cmr7801599a91.27.1764863011360; Thu, 04 Dec 2025
 07:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87tsyozqdu.fsf@email.froward.int.ebiederm.org> <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org> <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
 <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Dec 2025 10:43:20 -0500
X-Gm-Features: AWmQ_bmUfrO0mY15dNq3SP9hR0Gn5EatRKdJVj7voKpq3-tHkT_aD9YVC4fN8UE
Message-ID: <CAEjxPJ61OHDxmc2fgBp=hq27OoEhkO+Wwbb+rYAf2F9fM7gdLg@mail.gmail.com>
Subject: Re: Are setuid shell scripts safe? (Implied by security_bprm_creds_for_exec)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Bernd Edlinger <bernd.edlinger@hotmail.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>, 
	James Morris <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>, 
	Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, YueHaibing <yuehaibing@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Adrian Ratiu <adrian.ratiu@collabora.com>, 
	Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Ryan Lee <ryan.lee@canonical.com>, 
	apparmor <apparmor@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:34=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
>
> > + Mimi, linux-integrity (would be nice if we are in CC when linux-
> > security-module is in CC).
> >
> > Apologies for not answering earlier, it seems I don't receive the
> > emails from the linux-security-module mailing list (thanks Serge for
> > letting me know!).
> >
> > I see two main effects of this patch. First, the bprm_check_security
> > hook implementations will not see bprm->cred populated. That was a
> > problem before we made this patch:
> >
> > https://patchew.org/linux/20251008113503.2433343-1-roberto.sassu@huawei=
cloud.com/
>
> Thanks, that is definitely needed.
>
> Does calling process_measurement(CREDS_CHECK) on only the final file
> pass review?  Do you know of any cases where that will break things?
>
> As it stands I don't think it should be assumed that any LSM has
> computed it's final creds until bprm_creds_from_file.  Not just the
> uid and gid.
>
> If the patch you posted for review works that helps sort that mess out.
>
> > to work around the problem of not calculating the final DAC credentials
> > early enough (well, we actually had to change our CREDS_CHECK hook
> > behavior).
> >
> > The second, I could not check. If I remember well, unlike the
> > capability LSM, SELinux/Apparmor/SMACK calculate the final credentials
> > based on the first file being executed (thus the script, not the
> > interpreter). Is this patch keeping the same behavior despite preparing
> > the credentials when the final binary is found?
>
> The patch I posted was.
>
> My brain is still reeling from the realization that our security modules
> have the implicit assumption that it is safe to calculate their security
> information from shell scripts.
>
> In the first half of the 90's I remember there was lots of effort to try
> and make setuid shell scripts and setuid perl scripts work, and the
> final conclusion was it was a lost cause.
>
> Now I look at security_bprm_creds_for_exec and security_bprm_check which
> both have the implicit assumption that it is indeed safe to compute the
> credentials from a shell script.
>
> When passing a file descriptor to execat we have
> BINPRM_FLAGS_PATH_INACCESSIBLE and use /dev/fd/NNN as the filename
> which reduces some of the races.
>
> However when just plain executing a shell script we pass the filename of
> the shell script as a command line argument, and expect the shell to
> open the filename again.  This has been a time of check to time of use
> race for decades, and one of the reasons we don't have setuid shell
> scripts.
>
> Yet the IMA implementation (without the above mentioned patch) assumes
> the final creds will be calculated before security_bprm_check is called,
> and security_bprm_creds_for_exec busily calculate the final creds.
>
> For some of the security modules I believe anyone can set any label they
> want on a file and they remain secure (At which point I don't understand
> the point of having labels on files).  I don't believe that is the case
> for selinux, or in general.
>
> So just to remove the TOCTOU race the security_bprm_creds_for_exec
> and security_bprm_check hooks need to be removed, after moving their
> code into something like security_bprm_creds_from_file.
>
> Or am I missing something and even with the TOCTOU race are setuid shell
> scripts somehow safe now?

setuid shell scripts are not safe. But SELinux (and likely AppArmor
and others) have long relied on the ability to transition on shell
scripts to _shed_ permissions. That's a matter of writing your policy
sensibly.
Changing it would break existing userspace and policies.

