Return-Path: <linux-kselftest+bounces-6909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6CC89278D
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 00:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB75B218B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3513E888;
	Fri, 29 Mar 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6BheGdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9913E895;
	Fri, 29 Mar 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753508; cv=none; b=FLeM8DL77EJQk6d3SoFqLdC7M9KInCrb73EaxABSIo6M20qhRi8lEN3eVO9pY77/N7l6TnWH2cSI20IexzpQI34U709g9VIp29JeVqTWnX76yniTt+/10d7iY8jWp+91WIOH3ijzvfB6Ea7PPBXZLP9SjUiLT5N7hcNrPeQ40gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753508; c=relaxed/simple;
	bh=bbuOaKvrjP/9RP0DxEgIjZZL+rizhBaVvYfdFek3Ayw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnKhXE0aLOBD7K1hY7M6uqlFa/aZRGqyfFx+VEjK8k6kal30SuIwFkrDs3hk5qFwJW2fZkesMP+UOA/OHPfsfVDDQRBZh66kxclEpsMd7l69fKS9U356kjE/Ick3Y6RmiwyscvuDpiu792NkL3zqiWcz1vHtzdsMJOqwuW2zPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6BheGdN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341cf28e055so1634072f8f.0;
        Fri, 29 Mar 2024 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711753505; x=1712358305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5EA1dNOkzmqCgmVjiD2GJtPLu9i/Imtz0kuQLrem3Q=;
        b=U6BheGdNeUMgaKm6mNXGRnCp1esqQW4gDO+RDLN6EV/KrDD7i6+on8+lbzNlgefLbm
         vokX82qEqTfkZmbM5iPf420jv5rOA9f2TScYT/l+ReBghoC2Dxeop7Qn+BW49Pz/pqGV
         5LwcLd/RxQuwWvNjQFbdokj04/tmUVvt98WDZqneNDeLrVSee5LJo4ySP+5XemFaRc/J
         tMwvhImcXJKZj7SpxQhVw5es2SbaltiPVSJi6nuvxgEVKbo466rwWWJijCjefxNoqrbc
         gLY2+M0cV3lepFWrNj5FCM/Hl6jZUskfjYzN4k57oIOLVzOg95D26J4/pRzX7ujDMJiE
         N0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711753505; x=1712358305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5EA1dNOkzmqCgmVjiD2GJtPLu9i/Imtz0kuQLrem3Q=;
        b=C09g1n69spfR6CUS/oEhb9r2Y0OyMbpQc2V0849IsD9Xam4Pf4kKeCbV08O1EoClPK
         a8sC0xD/pVaIKxrm/xsr+vu5QKmO/7sLBmoLryWpDpIHa5oPUOIOCv8M48e2npr3gv6t
         cpyPT/UyTXQc5kns9OK8w8TfeaLpaTv9Z1ykSNrB1RJ7eAkY5nM1LVikGrKpxJ1kOZyX
         Io3pBpIojitRFyBy/96N4PliO/nJYxVjJqco64vj7aY0hLCIebgh3e1xP3rMO/XySBZm
         DHnEEN15/m/x4IOJ9jwGVv9vL3gSyuE5ImQxjCNXbYH7BWjApFrAICyWI4UcBweMC5ue
         3s9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhoUbV68p4KJcbPDCXQ9D7P4zTusuthY+FGCAXM9+zaLQom1hP/iSNSC7g8PauKphynB4HtWVb6rcfu5iC7WSJqy3lvxyLqVa9XedwE7vd/+20qs20XDTiC30CTP/C60sVSBvIENbBoBzgLz83cJqBcRzya3aF0QGQqX2MeqLUPPFa+EqJp6wtXJvXHWPNsJblWfYDnvUhbSrPmg==
X-Gm-Message-State: AOJu0YyzlVXeqSG5DsAWannGBgZ73MxCu2I7krdyOqHH/vHWT8e0xMKS
	KIco58NPvq7ziTRt2lbKKhsopNd1wO02rnTPY72KEzzhleIxDiAzzWuy+H0n2IZzsmASEmW5Yov
	0FqHs3PXu+o49whdrOCbX453xatRjEMcGNFs=
X-Google-Smtp-Source: AGHT+IF2ci+unak71hLReqynfxa6tgaGH9aZUsNmeB01zAgeMDLG44P7GTpQiLz63QxISFU4QEHAfgz2JOgpTquvmN0=
X-Received: by 2002:a5d:4452:0:b0:33e:b78b:5831 with SMTP id
 x18-20020a5d4452000000b0033eb78b5831mr2444474wrr.52.1711753504850; Fri, 29
 Mar 2024 16:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org> <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org> <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org> <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org> <bcb084ae-c934-4eba-aadd-95bbec2a63cb@gmail.com>
 <Zgc1BZnYCS9OSSTw@slm.duckdns.org>
In-Reply-To: <Zgc1BZnYCS9OSSTw@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 16:04:53 -0700
Message-ID: <CAADnVQ+WmaPG1WOaSDbjxNPVzVape_JfG_CNSRy188ni076Mog@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:39=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Mar 29, 2024 at 02:22:28PM +0100, Djalal Harouni wrote:
> > It would be easy at least for me if I just start with cgroupv2 and
> > ensure that it has same available filenames as if we go through kernfs.
> > Not a root cgroup node and maybe only freeze and kill for now that are
> > part of cgroup_base_files.
> >
> > So if I get it right, somehow like what I did but we endup with:
> >
> > In bpf, cgroup was already acquired.
> >
> > bpf_cgroup_knob_write(cgroup, "freeze", buf)
> > |_ parse params -> lock cgroup_mutex -> cgroup_freeze() -> unlock
> >
> >
> > cgroup_freeze_write(struct kernfs_open_file *of, char *buf,...)
> > |_ parse params -> cgroup_ref++ -> krnfs_active_ref--  ->
> >      -> lock cgroup_mutex -> cgroup_freeze() -> unlock + krnfs++ ...
> >
> > Please let me know if I missed something.
>
> I've thought about it a bit and I wonder whether a better way to do this =
is
> implementing this at the kernfs layer. Something like (hopefully with a
> better name):
>
>  s32 bpf_kernfs_knob_write(struct kernfs_node *dir, const char *knob, cha=
r *buf);
>
> So, about the same, but takes kernfs_node directory instead of cgroup. Th=
is
> would make the interface useful for accessing sysfs knobs too which use
> similar conventions. For cgroup, @dir is just cgrp->kn and for sysfs it'd=
 be
> kobj->sd. This way we can avoid the internal object -> path -> internal
> object ping-poinging while keeping the interface a lot more generic. What=
 do
> you think?

And helpers like cgroup_freeze_write() will be refactored
to take kernfs_node directly instead of kernfs_open_file?
Makes sense to me.
Sounds like a minimal amount of changes and flexible enough.

