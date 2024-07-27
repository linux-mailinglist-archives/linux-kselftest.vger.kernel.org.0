Return-Path: <linux-kselftest+bounces-14292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEA93DD38
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 06:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC771C23030
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 04:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63964A05;
	Sat, 27 Jul 2024 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej95FFsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E961FC4;
	Sat, 27 Jul 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722054163; cv=none; b=NekbY50RdfsA/iPNXyxCMFNiKVf4NppL48ZlZruOqB8ZvkVKdwx8ApvRznfdgX63+rK6mlIszdejEduo2zg6vawFgnupOsZg6zyIH2noE1rP5a0hTtNuJyO/vldJVH/stHSFPSgbqYoSqIjRF75CaMrLJxC1SX6/NHgoRCCjnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722054163; c=relaxed/simple;
	bh=FaOA4STlvwvdTml/Vu5HBITnRXe/6R+E7Hy85KU46XY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScwBUqm34Deb5ce77w9EaNqAzDSL4W3THUL6wo5GihfLwgax235zrZFnXKIpakfWkhgcWQAlZSJ655orkh0mWW725OlPbdQFB/J4TMiH7NaQt1bRPfzNhgFYas5pxShZRpmTaL6zX7RcVYg77Z/rSF5j2NZTA7heFDk3BbCKnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej95FFsr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d333d5890so1479607b3a.0;
        Fri, 26 Jul 2024 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722054161; x=1722658961; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=csFcossKFu3lQBsnFjLw1ZKIqevQEimAqEa45AdAQLI=;
        b=ej95FFsr+pBfSud+77W6eh6GESGCRrCHnKmd7E5K4tmwFV/l2TTyjdNTij6EtNtK7d
         rScGkkuBQIM+HG5/br9DaZ2oTGDgm1cRrLbu9sU3eTJ4YAeEBFefEnFRV3zhTkaLhrkL
         ylWgdv9bJes5870wzN54Sn0z3/MFJNTMY1GN/7A+7yecMfHPe4WQ6Ot8GufTIqB4u0lg
         bVq0GhUcfrhpC11l5GjrZGk7YLWdO3oKmaYmretmFyxNxEftChTInRbLw0EDMXb/F1vO
         rDs15VzpT6BSF//kTGxXYArRV0cPi8rgBaMOdVFWtwGqf9YR9GfGTpaEhTPEeMuuL5Ys
         Etcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722054161; x=1722658961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csFcossKFu3lQBsnFjLw1ZKIqevQEimAqEa45AdAQLI=;
        b=cypTcPvaNP7D7tWqhKs5+qmNEt7n/oN8VAQuaixkmIQgn0abko8LrKapkIADjupvmf
         1g5MxsFrgNM/XJ6+A/V0b37G0GOHy22SfBJmY5BHKTQwid4rf52NpYAV4PYxf+8/MHES
         L3pfEkoFt49a3Kxe21ex/x8twXmSI6/L0NAeM1qKPBaLrGwbowgcDh60DJnYqip9XpoV
         vubqfSG6Fi+eGTEUzzckbzqLk9Kpb6ns27PYta/CPPTU3Sj+j4m8Hj0BUAN182DEan0l
         jSiHra9AjXEmFB78NC/JZge/BLnDa7RJtGs9Uiv9D0ihDiB8R+f8r1+GSTyJJaefjMSN
         nydA==
X-Forwarded-Encrypted: i=1; AJvYcCXleEGkg3zEoytiX79JJzZNaAk8GmXELiKh9G/QLZ+zLYH5AjIDjA893KvI825yA9gjw2w/y0waGOE3LxxIH7K55Cf6X1JjfbDfMrK4ALC1wzYKkNMpL9QdulP3bdCwDpSPBop59kDS
X-Gm-Message-State: AOJu0YxVK4phPRd8SVSVNYjT40/thLE7C5UMxDq8TkzCRlwWSz9g37py
	3Yz2t3NhqmXkH2s7nnRfBul8yg/2L5UsBFQ/wfIOnMP4FOF1SZD1
X-Google-Smtp-Source: AGHT+IH8gdvwEIySaHk4nalEBVPtvkLdMQXvzSFYIxHiWAdNLpViGxqZqomKQDSDZpUsx9krj3FSnw==
X-Received: by 2002:a05:6a00:8596:b0:706:7943:b9aa with SMTP id d2e1a72fcca58-70ece9f75dfmr1878402b3a.5.1722054161477;
        Fri, 26 Jul 2024 21:22:41 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a61a4sm3434803b3a.217.2024.07.26.21.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 21:22:40 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 26 Jul 2024 21:22:38 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Fix using stdout, stderr
 as struct field names
Message-ID: <ZqR2DuHdBXPX/yx8@kodidev-ubuntu>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
 <847a5b798f24e81b9dec4e8d9eb3eb1e602a909e.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4BzauQQgWfc8eKsWF+Fr-j--oY6tJAM2+ZfAPHP7JJqZ6Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzauQQgWfc8eKsWF+Fr-j--oY6tJAM2+ZfAPHP7JJqZ6Zg@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:27:03PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 3:39 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Typically stdin, stdout, stderr are treated as reserved identifiers under
> > ISO/ANSI C, and a libc implementation is free to define these as macros.
> 
> Ok, wow that. Do you have a pointer to where in the standard it is
> said that stdin/stdout/stderr is some sort of reserved identifier that
> can't be used as a field name?
> 

I'll need to dig around to share some references. The short answer IIRC
is there's enough potential variation in their definitions that their
use requires care (or better avoidance).

> 
> I really don't like these underscored field names. If we have to
> rename, I'd prefer something like env.saved_stdout instead of
> env._stdout. But I'd prefer even more if musl wasn't doing this macro
> definition, of course...

OK, I'll use clearer names for a v2.

I believe the macro definitions are quite common and old, but "how"
makes a difference: specifically, using parenthesis happens to break our
.stdxxx field names.


In glibc <stdio.h> we have for example:
...
/* Standard streams.  */
extern FILE *stdin;             /* Standard input stream.  */
extern FILE *stdout;            /* Standard output stream.  */
extern FILE *stderr;            /* Standard error output stream.  */
/* C89/C99 say they're macros.  Make them happy.  */
#define stdin stdin
#define stdout stdout
#define stderr stderr
...

while in musl <stdio.h> we have:
...
extern FILE *const stdin;
extern FILE *const stdout;
extern FILE *const stderr;

#define stdin  (stdin)
#define stdout (stdout)
#define stderr (stderr)
...

which borks code in test_progs.c:
...
env.stderr = stderr;
env.stdout = stdout;
...


> 
> > This is the case in musl libc and results in compile errors when these
> > names are reused as struct fields, as with 'struct test_env' and related
> > usage in test_progs.[ch] and reg_bounds.c.
> >
> > Rename the fields to _stdout and _stderr to avoid many errors seen building
> > against musl, e.g.:
> >
> >   In file included from test_progs.h:6,
> >                    from test_progs.c:5:
> >   test_progs.c: In function 'print_test_result':
> >   test_progs.c:237:21: error: expected identifier before '(' token
> >     237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
> >         |                     ^~~~~~
> >   test_progs.c:237:9: error: too few arguments to function 'fprintf'
> >     237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
> >         |         ^~~~~~~
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
> >  tools/testing/selftests/bpf/test_progs.c      | 66 +++++++++----------
> >  tools/testing/selftests/bpf/test_progs.h      |  8 +--
> >  3 files changed, 38 insertions(+), 38 deletions(-)
> >
> 
> [...]

