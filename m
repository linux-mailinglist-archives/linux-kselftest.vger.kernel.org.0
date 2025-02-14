Return-Path: <linux-kselftest+bounces-26601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D36A3534F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 01:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169E716D859
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF958BA38;
	Fri, 14 Feb 2025 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCF4/9NQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992A53BE;
	Fri, 14 Feb 2025 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494707; cv=none; b=M5TBff4+AZiOD7JKJxmUSPrtr7ER6/GZrO1r0tclT4bZO3EXSlk4L/PFXuu6h9G8Vq33/U6edLH5TTZIlLnKM6KdBsU2s6AN3fNBjITyJJ+uqgycFhxhrnf4q7Md1AG0IbzawRWFfL5J83zOq3p1FwPxgsDOCjAFoTzBbGDo+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494707; c=relaxed/simple;
	bh=3c/RBCDB9xkIY4oXApsaoAXITS7AkOykfuC/uTfRa5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8E3PAX1X5FXOsonp7r8RLvpmcR5HQ4AZQTMBUAprBXO5LFs2tQ1jHgUNlpyOUDW0VwHcbLyhlYtZoufBOsTW9pklIWmZtL8E5GelOBSE32zV9D6ysUD+uajLTE/wQa4fu9NtiEpABrPMX4a9gdq+18KK19o0kqvg6NdhyYl4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCF4/9NQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso9867475e9.0;
        Thu, 13 Feb 2025 16:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494704; x=1740099504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaKUbzQ5VnxaPhfOHbD+HRzgp/IzdHvetBYfhHiZL+M=;
        b=CCF4/9NQ5ZzykwmwB0aOr7Se6npoVVaf9JzWTLc8f5SeEDaCcW+erEw2klePqUNqDa
         GSLrrirXHgf4vZz6263w7Xn+YSmkA6/rPTCA8hzRSYlePIbfHigM5VjMJj4KCXLjqAxU
         Cz72OFuaO/gXmw2NbbIQdr3hxWzHncRAaTQjMNzOG4P8BIYdgSz9wdfGgZLyE/d3PZYi
         7AWsjjOOwEhwSikDopKWz7HsbE0BkrrWLT7S6qLFLdgHXt2g0ynvB8ehjxiFJjZwmaiB
         hAY3alsldQCl8BYxHcP5VPBK+Zrs8EdI9yfANGpCCCUe7Qz70BCSmqRFnlJX9VNVk4uT
         Cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494704; x=1740099504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaKUbzQ5VnxaPhfOHbD+HRzgp/IzdHvetBYfhHiZL+M=;
        b=NugkW4KFhmmrXstKXzeyBEvtW3+zgBHIEaa0Y0b12NJLriNbVMkKxOOZ9ItOs2VVyA
         /lHfypMVf88F4veBWolbaP84XqNcNANMtEKapt7zhxDIdoSeCh98KLObLeKreI6ZHnLj
         te/B5GAdqYV0z8jpOdGNDnvVxlVRZ8YhdinJVlnC8LmW3b8LlfIJ1mJUghF5RdhrrUub
         0MBQzUsW27p/Ju8/QGpRVgCS7XNfNVBf/p0fWWZhpv2YAAJVTi6+1dmZlNggQt8J8MEu
         912lH2xqmGyYQPUBjyCgfHKPCKImA0d08DiAkH6q3VbZnc1OK+430TQsrJQVvX4LaOVx
         s4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4m0isl4v5ANhiehI7VVUXrrn5LvAEpWBV3cLyyupAiAXFVEYPF22Rdk/ssu1P19sN62S+vTZtqrm7FqyoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgPUUpFboCxhOtbYjmTNILsZz2hyCuDROnCx420eo3uYUBLnc
	/msAJxkLuxug/K9AygAzfhYPvyNPqZELCNXdCflAm5Foa9ynvwv8GMzxs3NGVEXVAetreqUmO6J
	52jyCalngdS5Xjeuh+eAKSsz9Lx0krrb8
X-Gm-Gg: ASbGnctq/ZIE+X2moYXlx+AMEj53wuj1CvSVT9xl9jUAqU14osfqaM8ZoCMwXRCGBer
	I7iYdaH4ksVzGFLaqzpc3f7IQ7OrXqdDEMykh5g3QYFd04UEEaqE2PRNEn3Um639WuZVuMA76d8
	5YpA0yRy825GscRmA+uGR4k+yw+w6L
X-Google-Smtp-Source: AGHT+IHaj5hygnI3x4tDx3lnIWG79Ct94Dh23biUD58gxwEh48HfLpf1aTBvKY9KgBBf9DFC9P3Z5zs/fFKhWplaN9s=
X-Received: by 2002:a05:600c:c8c:b0:439:4499:54de with SMTP id
 5b1f17b1804b1-439601afaf0mr69502255e9.31.1739494703912; Thu, 13 Feb 2025
 16:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213131214.164982-1-mrpre@163.com> <20250213131214.164982-4-mrpre@163.com>
 <CAADnVQKRKD1hxZ+rXQk5Af2my8vK_2OvQ7x6Xn58edYVkOpDxA@mail.gmail.com> <tlpmq4lu7e26jz7q6ry4gfws7mebviff3k75hk7aqzwcqndjgp@7y6es4u4uha6>
In-Reply-To: <tlpmq4lu7e26jz7q6ry4gfws7mebviff3k75hk7aqzwcqndjgp@7y6es4u4uha6>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 16:58:13 -0800
X-Gm-Features: AWEUYZkEfU2NkfgJJ1uBs36t1N5MMuV7pbibAmz_Xd8COKwoCeWh74ZMfduLsvw
Message-ID: <CAADnVQL7jPw+2=+NaS6yytDo4-Oo13ozdw4NqktPcsUwbHDvqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for may_goto
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:42=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wrote:
>
> On Thu, Feb 13, 2025 at 08:04:05AM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 13, 2025 at 5:13=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wr=
ote:
> > >
> > > Add test cases to ensure the maximum stack size can be properly limit=
ed to
> > > 512.
> > >
> > > Test result:
> > > echo "0" > /proc/sys/net/core/bpf_jit_enable
> > > ./test_progs -t verifier_stack_ptr
> > > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit=
:SKIP
> > > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without =
jit:OK
> > >
> > > echo "1" > /proc/sys/net/core/bpf_jit_enable
> > > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit=
:OK
> > > verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without =
jit:SKIP
> >
> > echo '0|1' is not longer necessary ?
> > The commit log seems obsolete?
> >
> > pw-bot: cr
>
> It looks like the problem only arises when CONFIG_BPF_JIT_ALWAYS_ON is
> turned off, and we're only restricting the stack size when
> prog->jit_requested is false. To test this, I simulated different
> scenarios by echoing '0' or '1' to see how the program would behave when
> jit_requested is enabled or disabled.
>
> As expected, when I echoed '0', the program failed verification, and when
> I echoed '1', it ran smoothly.

I misunderstood the tags in patch 2. I thought:

+#define __use_jit() __attribute__((btf_decl_tag("comment:run_mode=3Djit"))=
)
+#define __use_interp()
__attribute__((btf_decl_tag("comment:run_mode=3Dinterpreter")))

"use jit" actually means use jit.

while what it's doing is different:

+ if ((jit_enabled && spec->run_mode & INTERP) ||
+    (!jit_enabled && spec->run_mode & JIT)) {
+     test__skip();
+     return;
+ }
+

The tags should probably be named __load_if_JITed and __load_if_interpreted
or something like that.

