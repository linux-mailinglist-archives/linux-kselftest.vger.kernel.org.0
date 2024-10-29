Return-Path: <linux-kselftest+bounces-21017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAE9B5520
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 22:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77190285F0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04B208987;
	Tue, 29 Oct 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNyoF1wb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8120720D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237632; cv=none; b=grQc+B8gv55ypBcu5i1HBuCk4EuRD6wobBF/f9h37NXWaFta1+4IMBsCK+TkKhnhlh/+pGo8Uo697ZO5VIoYffeUik7uaopiqwiSKuI9CHvg6I1QSl/RPJV0wI8G8Do6gbWs7isvX3c+VPOs5gyafNycIclZx2AdUgjo3Frwnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237632; c=relaxed/simple;
	bh=h+puN0fhqWblaJnsZw9q5nmFY1+4n5wVKrQtRnvjDf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx/aiincwGJCOpWhN7A3HUzyGyof2wItr9GXTmru3e+oJ7fUBgAwes1LY/tbzrASlnR/ili4XzAqsG90ZNlEjCYlBGxzTzgQBwSdgOxonzf0QiiPDxodp3fIPAxOIBezDCdAAg1nXs4Cvuxcbx9Ffn41Ds47Kv32smTjJpRAL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNyoF1wb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e66ba398so3683e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730237628; x=1730842428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLCevXoJGaR8oKfiYoaHQvhcyK6u+L88OrvNrE2LLbA=;
        b=BNyoF1wbleE66/xgDAqCHqo/h2UJFNBJFEtgQ0Y0U+U3hnkqC5hmrEkBLvedVdJ9mS
         Z111GU336U8LhEXvlpeUSDXN5x1V+8d+rdCczsKwbpezkrrOh6tiYaHwR3mhjfRO+B90
         S55osjzp9wwFOz37FCedyhXKS+VJbeGlG0bm5AS7SGYoe9ZpVylPs2f7acusUsKK+0o5
         6/Mo5Y6BQPeoYuXFTDei0n+cU5pfTJjxfx067qSxz5G6lSbxYvx5XdomKt8U+JI8tXgI
         nT10QYvhgOLe4GjJCzzUWlTk5j6e17Bjrv7hllxCva3xruEChdpwjIJ/iGFtFQR/9L3g
         Bptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237628; x=1730842428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLCevXoJGaR8oKfiYoaHQvhcyK6u+L88OrvNrE2LLbA=;
        b=T6s9AgbJL6CXpegnI82YTTxrwSPU4s3+NL4imfwjaqE0NuSbqBlovHJ8KO7g6PBZr+
         4kislmhu93zQPDmfUXuqL09Q0xEP1TM2dpQrC0fpjFTOspKgklHQ9wic6xkrKJMPaD2C
         +jH23sTi3vv1l1SP2UASrrDufD+BY135MZK93zoPSQhDR4psO0BXZfSDU4+PEu2Xn/sM
         XDlExdmksGPmVnIoaqT9A0Q/LENRg5uJmp0mcFf3l4+E38lPvAsJSx9yxZTsqkqLwkUr
         ORwq2VunP5jF3Y+XZ8TZpeSX5OZEqo122EjxlyPL36GbRWGXRzY+w8ImaycJfz87hFvc
         75xg==
X-Forwarded-Encrypted: i=1; AJvYcCUZxnE19CtGpxIB1lQXIGEz0mpA38/06VK9s/2hH26tdi13loiHyBM335k28tIHM277IwjGU07QCDr1DObVVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2K1HopdaxtV8tMCa3Pi2Oa8AFiQERdn2bkuF814WTSOkAOsy
	+RzvzXVlBziX8F9hmIAUdnHw+uniaPjoagEKAuUekUjPmX/VFH6D+h0THTkjNgvik/UhUuJLlnW
	1bdHTNfUQHoi+7gCP4iPXtt7k8mbMi+W9hN/k
X-Gm-Gg: ASbGncs+eJi1ybT0SjSvtowUvG1Datr7p7khO/1rUvVNlkIUB9hxAZuA7EoPOjodbbI
	t7ArjzGNUckhtVEpPqEmrwSnTGIdxoOSIagMnyJ2x4SuHQwQzvjSqGH1shuZbnw==
X-Google-Smtp-Source: AGHT+IGYEgSe/xaLttCW468YzyVt+PJSqrl2F1hKgdaEVJVyCsWJcWbraB6StYd3H9kULin2IaXyAhjjioQjPAzPjxY=
X-Received: by 2002:a05:6512:138c:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53b480a3611mr660213e87.4.1730237627739; Tue, 29 Oct 2024
 14:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-4-kaleshsingh@google.com> <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
In-Reply-To: <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 29 Oct 2024 14:33:35 -0700
Message-ID: <CAC_TJveyKz5be6tVr9J_P32g2cVWAOs2eaQVi4Yrx6ATfb==nQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: Fix tracefs gid mount option
To: Eric Sandeen <sandeen@redhat.com>
Cc: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Ali Zahraee <ahzahraee@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:00=E2=80=AFPM Eric Sandeen <sandeen@redhat.com> w=
rote:
>
> On 10/28/24 4:43 PM, Kalesh Singh wrote:
> > Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> > tracefs to use the new mount APIs caused mounting with the gid=3D<gid>
> > option to not take effect.
>
> Or any other mount options. I'm sure this isn't unique to gid, right?
> So, might want to fix the commit title.

Hi Eric,

You are right, they same applies to any of the mount options. I'll
update the commit text for v2.

>
> > The tracefs superblock can be updated from multiple paths:
> >     - on fs_initcall() to init_trace_printk_function_export()
> >     - form a work queue to initialize eventfs
> >       tracer_init_tracefs_work_func()
> >     - fsconfig() syscall to mount of remount sysfs
> >
> > The tracefs super block root inode gets created early on in
> > init_trace_printk_function_export().
> >
> > With the new mount API tracefs effectively uses get_tree_single() inste=
ad
> > of the old API mount_single().
> >
> > Previously, mount_single() ensured that the options are alway applied t=
o
> > the superblock root inode:
> >     (1) If the root inode didn't exist, called fill_super() to create i=
t
> >         and apply the options.
> >     (2) If the root inode exists, called reconfigure_single() which
> >         effectively called tracefs_apply_options() to parse and apply
> >         options to the subperblock's fs_info and inode and remount
> >         eventfs (if necessary)
> >
> > On the other hand, get_tree_single() effectively calls vfs_get_super()
> > which:
> >     (3) If the root inode doesn't exists calls fill_super() to create i=
t
> >         and apply the options.
> >     (4) If the root inode already exists, updates the fs_context root
> >         with the superblock's root inode.
>
> I'm honestly a little lost here, but given the differences between mount_=
single()
> and get_tree_single() - are other get_tree_single() users similarly broke=
n?
>

I'm not sure if other filesystems are broken in the same way. The
issue happened for tracefs due to the fact that the sb root is created
before  calling mount -- from init_trace_printk_function_export(). If
there are other filesystems that have similar early initialization
(before mount) they may be broken as well.

> Should get_tree_single() just be calling reconfigure_single() internally =
like
> mount_single() did? The comment in reconfigure_single() confuses me.
>
> > (4) above is always the case for tracefs mounts, since the super block'=
s
> > root inode will already be created by init_trace_printk_function_export=
().
>
> this reminds me a little of
>
> commit a6097180d884ddab769fb25588ea8598589c218c
> Author: NeilBrown <neilb@suse.de>
> Date:   Mon Jan 17 09:07:26 2022 +1100
>
>     devtmpfs regression fix: reconfigure on each mount
>

Interesting, yes it seems like the same root cause. i.e. devtmpfs sb
root is created early on from  kernel_init() .... --> driver_init()
---> devtmpfs_init() which setups up the root inode for devtmpfs in
shmem_get_tree() ... -> vfs_get_super(); which is the case (4),
meaning that it would have ignored the options on mount for the same
reason: the superblock root indoe already exists.

I'm not very familiar with the filesystem area. If this is a common
scenario, maybe there needs to be a separate API to handle this case?


> > This means that the gid mount option gets ignored:
> >     - Since it isn't applied to the super block's root inode, it doesn'=
t
> >       get inherited by the children.
> >     - Since eventfs is initialized from form a separate work queue and
> >       before call to mount with the options, and it doesn't get remount=
ed
> >       for mount.
> >
> > Ensure that the mount options are applied to the super block and eventf=
s
> > is remounted to respect the new mount options.
> >
> > [1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redh=
at.com/
> >
> > Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  fs/tracefs/inode.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index 1748dff58c3b..cfc614c638da 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *f=
c)
> >       struct tracefs_fs_info *sb_opts =3D sb->s_fs_info;
> >       struct tracefs_fs_info *new_opts =3D fc->s_fs_info;
> >
> > +     if (!new_opts)
> > +             return 0;
>
> Can this really happen?

From init_trace_printk_function_export() the first time the super
block is allocated and added to file_system_type->fs_supers;
fc->s_fs_info is reset to NULL. [1]. I think that is ok since the
fs_info would have already been copied to the super block. [2]


See sget_fc():

[1] https://github.com/torvalds/linux/blob/v6.12-rc4/fs/super.c#L774
[2] https://github.com/torvalds/linux/blob/v6.12-rc4/fs/super.c#L766


--Kalesh
>
> > +
> >       sync_filesystem(sb);
> >       /* structure copy of new mount options to sb */
> >       *sb_opts =3D *new_opts;
>
> FWIW doing this as a structure copy was probably a terrible choice on my =
part. :(
>
> > @@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block =
*sb, struct fs_context *fc)
> >       sb->s_op =3D &tracefs_super_operations;
> >       sb->s_d_op =3D &tracefs_dentry_operations;
> >
> > -     tracefs_apply_options(sb, false);
> > -
> >       return 0;
> >  }
> >
> >  static int tracefs_get_tree(struct fs_context *fc)
> >  {
> > -     return get_tree_single(fc, tracefs_fill_super);
> > +     int err =3D get_tree_single(fc, tracefs_fill_super);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     return tracefs_reconfigure(fc);
> >  }
> >
> >  static void tracefs_free_fc(struct fs_context *fc)
>

