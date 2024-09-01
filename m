Return-Path: <linux-kselftest+bounces-16904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE839967535
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B06D1C20F68
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5840BE3;
	Sun,  1 Sep 2024 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeJEhdil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09A2F28;
	Sun,  1 Sep 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170750; cv=none; b=ardHCmnn3pLc4r8nqEiXgWf1f1b2PJdhyNOyChExrjD8i8eUTBVblat5C8wie8psAMdENcyYV44uTX/L816xCEP3ZxNVbdkgYI9kgHBBP/iAWRJ19ZOU7PnfiKcHGISro1rENqvPvYIdJvF3NS4elLvzIGWpSGaDDxp5NzFD+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170750; c=relaxed/simple;
	bh=OALqQUX0W8OFyahoghMcYuvK1OYZzSUq7udfZWNGcs4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOcYZ7kXP4B2XexV66yWdiWwMnDsf4dY+V16hxpozkFbrKPZLggnGwsfnOyeDsWtPOTeUGVUtWpwRwuKeoTLZo7z5U2QOIuqOHs8oCuGGr9Q7MoORFkGTdYCeOYbQBN07tb6qpNhekqoiRHhq/RoSX2xgsDvFww6T90UPXh21l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeJEhdil; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1340126a91.2;
        Sat, 31 Aug 2024 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170749; x=1725775549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+k+saKABzmp5Ku7fOZ43llAvpWExc1bm1z9JQspRbI=;
        b=WeJEhdilS7KzM89Td42+n61Y3NGJgoGZt/S+TEk0h8zvuLquRpEjpGVWmlFFTt183f
         T9IFYWyVln7z95UxLpkgK8gZsG9chpz0vYh2uwcvuh1p9SKBs5Su/XeM/S4YpuDotKma
         oD2Ngg4Hox2FpoOyfAk8avv9Yahg8gFFH5TtI7qk4kXtgu0L4vZEmZgyP03c1CyNCQfc
         A0thpB4ZzRqV302DHPxqQkUdBeheOhu3+wKD1o1gwKUPG0/uAcxppZvA/XyVdrLfQPpR
         QF7wT1EZ8P1AtG/Xr/o/MQH3HMehkEzQfrtMucCLDVKpPC+JnzHl6IRvHhPXz4/G1in2
         Jlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170749; x=1725775549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+k+saKABzmp5Ku7fOZ43llAvpWExc1bm1z9JQspRbI=;
        b=HQ1qjEs4YGFC7LVlQf6YWueVuBDvEddPU9XDZFD5hS4Dt4Y4xN6WISnm8vjMbRirCy
         YScOXuIfmWHeoamnkGNKbeS/yv+plCrKTNJde6nUc56trcaFjvsFxQOhZ34X+Vl9qGrR
         CiScSyipliptHFgJ4L37N0M7YN3Af5flQa1AHCTyzV/s03orSw7+NDIuIssFJLD0SoAW
         HEXptPNwKH9GfzXzI7aQTGHMIirWznLL7AHTuPixAWe94fI33q9j6p9Brkw4wt3Ef/1h
         3wbYftQPL/xx7LglocAfN5mMc7lnLT5Jm4VxYsg3+g8HbTKlluzG8N8b7AfAg84Akl+l
         AHpw==
X-Forwarded-Encrypted: i=1; AJvYcCX7XCv4iY0cLNN/bDoCcBa71/k+Jq5g+jWExL4IgfMF51SPhSj2jq95DbHdMZc0j05Xkn4I130ZpywIY88hwRPl@vger.kernel.org, AJvYcCXEjx3BbO0CD31IMVXVTI7yDl8MK9ENu7YsMB54U4iF0LXy8IaxMVlBVCZP6qCjC7zgods=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEIkq429pJccnw9k21gMs/Rd9/UMY/WHZEoTnLO26qOvdR6OG
	+tXx72uF0EtO1FzlzuoLHiE4bSpxcEWdn55whOpAqzW+bFaFffWJ
X-Google-Smtp-Source: AGHT+IFroxIb7E2f6ukKtX2irsiFggmWeaE6ljKDC79EsROsZmNV5LPJ0MhZA5LFVhGonsCfDmXSrA==
X-Received: by 2002:a17:90a:f006:b0:2d8:8f24:bd86 with SMTP id 98e67ed59e1d1-2d8904c2fb8mr3252508a91.8.1725170748693;
        Sat, 31 Aug 2024 23:05:48 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39d10csm6629919a91.44.2024.08.31.23.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:05:48 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:05:46 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <ZtQEOk5ZZRtWCekn@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>
 <f52f1489bd0936595ff0e492bcdfad8307bab364.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52f1489bd0936595ff0e492bcdfad8307bab364.camel@gmail.com>

On Fri, Aug 30, 2024 at 06:26:10PM -0700, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 14:25 -0700, Andrii Nakryiko wrote:
> 
> [...]
> 
> > >         err = bpf_object__elf_init(obj);
> > > -       err = err ? : bpf_object__check_endianness(obj);
> > >         err = err ? : bpf_object__elf_collect(obj);
> > >         err = err ? : bpf_object__collect_externs(obj);
> > >         err = err ? : bpf_object_fixup_btf(obj);
> > > @@ -8500,6 +8529,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
> > > 
> > >         if (obj->gen_loader)
> > >                 bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
> > 
> > nit: add {} around if, both sides should either have or not have {}
> > 
> > > +       else if (!is_native_endianness(obj)) {
> > > +               pr_warn("object '%s' is not native endianness\n", obj->name);
> > 
> > "object '%s': load is not supported in non-native endianness\n"
> > 
> > 
> > > +               return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> > > +       }
> 
> Silly question:
>   why load is allowed to proceed for non-native endianness when obj->gen_loader is set?
> 

Not silly, had similar questions. Having obj->gen_loader set means "light
skeleton" is being generated, where it tries to eliminate dependency on
libbpf by skeleton code. In this mode, the code doesn't load anything but
instead tracks "what would libbpf do" so it can later write a pure BPF
loader program. Alexei will correct me or elaborate as needed I hope.

Unconditionally blocking on non-native endianness would break light skel.

