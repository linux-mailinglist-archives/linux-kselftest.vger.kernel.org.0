Return-Path: <linux-kselftest+bounces-21151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74C9B6AF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E071C23B35
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229921BD9C8;
	Wed, 30 Oct 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPJ3rFsE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E51BD9D6
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309066; cv=none; b=hDjrynGUEzweEJ6bSf6HiRdhVmnVd2RAafM47qAmbzgEj6h/D0Zd/fVrlsWXFUJP/OQ2NVyZPbsO/FfxYzz1rnDqjyZngTvgeEkvoNwphYtiHL/W2sxQkJgpwq9Mrnf9+zgMkL4dbv+GTDwH7mT34Oaekkq3DSKHtkffztC9ZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309066; c=relaxed/simple;
	bh=WviN9txN0CrQa1oy/crkHmncmo1YuKYTJThTJDUFEkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRAzvNVmcb/9kX2fEDWxzkiN6NSPvRzjCbjo+y3vMnhlPTVmno6PsSOTFi5QufuoGpUJSpwV1vCNJEvIKCza460bQfvSAN+h3WthAVKlVOzW4pip9Md3FMCRY2sl/SuxdAq/iSe7t6/xKG3z0bA+bmNs5QhnQYSw1KbVgh7MkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPJ3rFsE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so19625e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730309061; x=1730913861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOcAWHV5P+ZBR3oghxDNAmcIDt1HA6ow1slX+W8r2xI=;
        b=DPJ3rFsEIM7pZ31SmqyAy7+8H3hSwJcJgVIJyAs/GSCTIPfpRZvVNr1nkrvUNo2cwA
         DaT3FVzjuYYgrNhOR1+llMAcvpOiQMzpftG5wV4nPocoP54t0LNRgEiKVrMalVd01uZ+
         1joF/KZqcgtbWYJaY5jc0Kg+DreKnmc/u6qoda7j8ch4yqOSQz0IaB3ldS45P7aT4uX5
         LIKQR7EN+jOtUC8K4uhACM6YiOQ9iEvERhKjgLmb/IvzJY3e/ij8M5s9Hhpb1lgEjiX8
         qu/X4L6YvW0fntWr85hRLLguckci4LBXze41Mx4B9VCtkLROlo4+QVZkwRQqe01gc+cp
         qZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309061; x=1730913861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOcAWHV5P+ZBR3oghxDNAmcIDt1HA6ow1slX+W8r2xI=;
        b=RrQqkTG/R9xZVyByfT1Y96totXmjNfvJ9iE21qyWqqdOYiSmjF/wuCEp7BPO6vcPtY
         Wy60wxZw4wIzWizFMJWZ0XvyD39Q0iBZD2AU0n4bW2hzRBIf4qH0ecHaLyPqMiPelUqI
         j+07uJGj87h50d+Fas1MZOzkaHfQ206+ALZiwV3nh7dX/O/2SwiAGH9urhiKV/6o9KmA
         7BLSxu47RviA9iZ3RSEawO6FW86IZ9nwsvVtbLd8U4mXUUrU2UYJO5D+kPSrJYGjhs3C
         kBTpYXjk4H3z3NMyO/UfzstdR7KBmPsbC+q/BPurtCV+JDeU1zrH+G9OcGTYnimzRGLC
         3Jpg==
X-Forwarded-Encrypted: i=1; AJvYcCXAmctOrEx02ZvqksTAIKnLyHsMidchz/BNqO2ecNClhMefcWANQFC06CDLBDVNzycmlyQVTSb0YjVeJ9iHlGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnELqPUKbchzGmI0SdTbds/y1B/7kqniyrLZLP7wF0YQ+DvvlP
	hfRl0c12+ZvE2sPUUHwZyZOH9PQXBKdMtCuVHuDJm/K2Ljn5wO9b5tbbT2hnei8FHfcgs05+nL2
	tnXymlNuhl+KPpjGwbYUOIk5OrO1MZPSCuFle
X-Gm-Gg: ASbGncv9rH0hIBd+VN02oWe+hKpE7Z5ocdiOlcPxOYCt5J+Upx5eyS8RkF7hJq2P3J/
	QBM+1eccyC5UsqlI256sFLtxCEQb+qZD3Ti7YJYa+6RuA45FiwcQFiCVgfW8pdg==
X-Google-Smtp-Source: AGHT+IG/KI4bV1Y+XgKIRsw188s6cXrD+X8g2TljCfLmP7yyw6XvY1UQhIxzR9TJhdr8DvUIQOSUc5CNOtoD7VsnUZw=
X-Received: by 2002:a05:600c:4e0f:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-431b4a3d374mr10684965e9.7.1730309059952; Wed, 30 Oct 2024
 10:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-3-kaleshsingh@google.com> <20241028191448.5f62531a@rorschach.local.home>
 <CAC_TJvf8aU07JRiBK9tgWynixXBX9MpqFJh6GVaUcEzqX6aLhQ@mail.gmail.com>
In-Reply-To: <CAC_TJvf8aU07JRiBK9tgWynixXBX9MpqFJh6GVaUcEzqX6aLhQ@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 30 Oct 2024 10:24:07 -0700
Message-ID: <CAC_TJvf_sOfP5R4VG+JExc4J3dUbcMVVoRqvO1S8QXYiK4oFZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing/selftests: Add tracefs mount options test
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dhowells@redhat.com, mhiramat@kernel.org, surenb@google.com, 
	jyescas@google.com, kernel-team@android.com, android-mm@google.com, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:23=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Mon, Oct 28, 2024 at 4:14=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Mon, 28 Oct 2024 14:43:58 -0700
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > > Add test to check the tracefs gid mount option is applied correctly
> > >
> > >    ./ftracetest test.d/00basic/mount_options.tc
> > >
> > > Use the new readme string "[gid=3D<gid>] as a requirement and also up=
date
> > > test_ownership.tc requirements to use this.
> > >
> > > mount_options.tc will fail currently, this is fixed by the subsequent
> > > patch in this series.
> >
> > Test cases should never be added when they can fail. They should always
> > come after the fix is applied. But it appears that you check the README
> > to make sure that it does work and not fail.
> >
> > I'll take a look at these patches in more detail later.
>
> Hi Steve,
>
> Thank you for the quick reviews, please feel free to ignore until you are=
 back.
>
> I'll address these comments and resend a v2.

I've posted v2 at:
https://lore.kernel.org/r/20241030171928.4168869-1-kaleshsingh@google.com/

Thanks,
Kalesh

>
> Thanks,
> Kalesh
>
> >
> > Thanks,
> >
> > -- Steve
> >
> >
> > >
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >  .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++=
++
> > >  .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
> > >  .../testing/selftests/ftrace/test.d/functions |  25 +++++
> > >  3 files changed, 129 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mou=
nt_options.tc
> > >
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_opti=
ons.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > > new file mode 100644
> > > index 000000000000..b8aff85ec259
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> > > @@ -0,0 +1,101 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: Test tracefs GID mount option
> > > +# requires: "[gid=3D<gid>]":README
> > > +
> > > +fail() {
> > > +     local msg=3D"$1"
> > > +
> > > +     echo "FAILED: $msg"
> > > +     exit_fail
> > > +}
> > > +
> > > +find_alternate_gid() {
> > > +     local original_gid=3D"$1"
> > > +     tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: =
-f3
> > > +}
> > > +
> > > +mount_tracefs_with_options() {
> > > +     local mount_point=3D"$1"
> > > +     local options=3D"$2"
> > > +
> > > +     mount -t tracefs -o "$options" nodev "$mount_point"
> > > +
> > > +     setup
> > > +}
> > > +
> > > +unmount_tracefs() {
> > > +     local mount_point=3D"$1"
> > > +
> > > +     # Need to make sure the mount isn't busy so that we can umount =
it
> > > +     (cd $mount_point; finish_ftrace;)
> > > +
> > > +     cleanup
> > > +}
> > > +
> > > +create_instance() {
> > > +     local mount_point=3D"$1"
> > > +     local instance=3D"$mount_point/instances/$(mktemp -u test-XXXXX=
X)"
> > > +
> > > +     mkdir "$instance"
> > > +     echo "$instance"
> > > +}
> > > +
> > > +remove_instance() {
> > > +     local instance=3D"$1"
> > > +
> > > +     rmdir "$instance"
> > > +}
> > > +
> > > +check_gid() {
> > > +     local mount_point=3D"$1"
> > > +     local expected_gid=3D"$2"
> > > +
> > > +     echo "Checking permission group ..."
> > > +
> > > +     cd "$mount_point"
> > > +
> > > +     for file in "." "events" "events/sched" "events/sched/sched_swi=
tch" "events/sched/sched_switch/enable"; do
> > > +             local gid=3D`stat -c "%g" $file`
> > > +             if [ "$gid" -ne "$expected_gid" ]; then
> > > +                     cd - # Return to the previous working direcotry=
 (tracefs root)
> > > +                     fail "$(realpath $file): Expected group $expect=
ed_gid; Got group $gid"
> > > +             fi
> > > +     done
> > > +
> > > +     cd - # Return to the previous working direcotry (tracefs root)
> > > +}
> > > +
> > > +test_gid_mount_option() {
> > > +     local mount_point=3D$(get_mount_point)
> > > +     local mount_options=3D$(get_mnt_options "$mount_point")
> > > +     local original_group=3D$(stat -c "%g" .)
> > > +     local other_group=3D$(find_alternate_gid "$original_group")
> > > +
> > > +     # Set up mount options with new GID for testing
> > > +     local new_options=3D`echo "$mount_options" | sed -e "s/gid=3D[0=
-9]*/gid=3D$other_group/"`
> > > +     if [ "$new_options" =3D "$mount_options" ]; then
> > > +             new_options=3D"$mount_options,gid=3D$other_group"
> > > +             mount_options=3D"$mount_options,gid=3D$original_group"
> > > +     fi
> > > +
> > > +     # Unmount existing tracefs instance and mount with new GID
> > > +     unmount_tracefs "$mount_point"
> > > +     mount_tracefs_with_options "$mount_point" "$new_options"
> > > +
> > > +     check_gid "$mount_point" "$other_group"
> > > +
> > > +     # Check that files created after the mount inherit the GID
> > > +     local instance=3D$(create_instance "$mount_point")
> > > +     check_gid "$instance" "$other_group"
> > > +     remove_instance "$instance"
> > > +
> > > +     # Unmount and remount with the original GID
> > > +     unmount_tracefs "$mount_point"
> > > +     mount_tracefs_with_options "$mount_point" "$mount_options"
> > > +     check_gid "$mount_point" "$original_group"
> > > +}
> > > +
> > > +test_gid_mount_option
> > > +
> > > +exit 0
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_owner=
ship.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > index 094419e190c2..e71cc3ad0bdf 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > @@ -1,24 +1,14 @@
> > >  #!/bin/sh
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  # description: Test file and directory ownership changes for eventfs
> > > +# requires: "[gid=3D<gid>]":README
> > >
> > >  original_group=3D`stat -c "%g" .`
> > >  original_owner=3D`stat -c "%u" .`
> > >
> > > -mount_point=3D`stat -c '%m' .`
> > > +local mount_point=3D$(get_mount_point)
> > >
> > > -# If stat -c '%m' does not work (e.g. busybox) or failed, try to use=
 the
> > > -# current working directory (which should be a tracefs) as the mount=
 point.
> > > -if [ ! -d "$mount_point" ]; then
> > > -     if mount | grep -qw $PWD ; then
> > > -             mount_point=3D$PWD
> > > -     else
> > > -             # If PWD doesn't work, that is an environmental problem=
.
> > > -             exit_unresolved
> > > -     fi
> > > -fi
> > > -
> > > -mount_options=3D`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).=
*/\1/'`
> > > +mount_options=3D$(get_mnt_options "$mount_point")
> > >
> > >  # find another owner and group that is not the original
> > >  other_group=3D`tac /etc/group | grep -v ":$original_group:" | head -=
1 | cut -d: -f3`
> > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/=
testing/selftests/ftrace/test.d/functions
> > > index 779f3e62ec90..84d6a9c7ad67 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > @@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-wit=
h-error-pos-by-^ command-file
> > >      # "  Command: " and "^\n" =3D> 13
> > >      test $(expr 13 + $pos) -eq $N
> > >  }
> > > +
> > > +# Helper to get the tracefs mount point
> > > +get_mount_point() {
> > > +     local mount_point=3D`stat -c '%m' .`
> > > +
> > > +     # If stat -c '%m' does not work (e.g. busybox) or failed, try t=
o use the
> > > +     # current working directory (which should be a tracefs) as the =
mount point.
> > > +     if [ ! -d "$mount_point" ]; then
> > > +             if mount | grep -qw "$PWD"; then
> > > +                     mount_point=3D$PWD
> > > +             else
> > > +                     # If PWD doesn't work, that is an environmental=
 problem.
> > > +                     exit_unresolved
> > > +             fi
> > > +     fi
> > > +     echo "$mount_point"
> > > +}
> > > +
> > > +# Helper function to retrieve mount options for a given mount point
> > > +get_mnt_options() {
> > > +     local mnt_point=3D"$1"
> > > +     local opts=3D$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.=
*\)).*/\1/')
> > > +
> > > +     echo "$opts"
> > > +}
> > > \ No newline at end of file
> >

