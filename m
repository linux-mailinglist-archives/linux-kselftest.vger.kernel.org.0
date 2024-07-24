Return-Path: <linux-kselftest+bounces-14188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50C093B9AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 01:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560531F237CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B01448D4;
	Wed, 24 Jul 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4tAzfmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4734D8B9;
	Wed, 24 Jul 2024 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865287; cv=none; b=RWOPGghU74fLQyNaWNpD9I/e7w8Ri54ivK45SmCbh+z/6sNKxyLZiOwhpXNOERqyOrowwdgCn0qHYNYZt9rg9nD/kC8kjL4HhT173x57PHJDtJWFp3Q22CHviN/eTMEC46FHJjUyJ4UyEWyDdq5hOog9dMvdicaKvgkD91e777c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865287; c=relaxed/simple;
	bh=5cGfgGg//zyeOz8QVy7jQ4WfUvu320ZJvGyZLjaFlD8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOyb542gPEIVQkQCCAapSGLH41HGgZEpyk27MXCbob/66DolXmAxMrDuZMoIf0/JgW68HxKpoJoHYmU55nLM4S+qPmSQIT+Dmazq2YMk4dHHBlqwcDwTrrZRzfMm0wxEfEIvG+bERTQrB1Ayo/6Y3RZhzfyKCCyHWKH3U0LcAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4tAzfmy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d28023accso299897b3a.0;
        Wed, 24 Jul 2024 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721865285; x=1722470085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0fQAHkA7o0s4HUpDQqKKGIolPX1vRxRnadlpsHHbNug=;
        b=a4tAzfmyoSfujYEVNQJWJbpdihRoNDGKHkuLDGfmoCLFmBz/KpFWhuyZg7XO5kQ0cJ
         NI7gcO+KAL1CueFMFrZ5ZYarqk2nXGqqk4v0OUSvhp7c63KqFYU6S6HU6ys6THT8v0Hz
         FINnmqvFGmGc+6FUK9QSdzo6yyDR/SlG5qbOOFBRStWfSs5KJ7/Yc5HPTIOTrUWeme8Z
         /lVHfLHZP24jp8lgUkNedTbGeV6gb9eSLYxCJM1tD62tZDF44BqFUXO5zbgs0cPYp0hI
         mMJ7iWqTeMbG9/1ODRdW+USFM2HrSKPeEew3mv3Frl4opTfApEmX6s7RroHcMZWta/NR
         PP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721865285; x=1722470085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fQAHkA7o0s4HUpDQqKKGIolPX1vRxRnadlpsHHbNug=;
        b=cW9xYyFjNbdnAp/czawaiHgKfXQsuD2rIC3TY6QM/+Pv4HKWERX6vSb5CSP/uie02+
         NHuJZ4JmxmRc+6Myz1LCjSfplCP3PowGQ84bxaV82AgHILzOLL7CrP0vCmfrz7CM4Hg2
         eJDuAr+T4LL9uJQY6zpRR2/32dYaOnlRMu0NWYaY6TVdfvyiS0prrFNFPLdkQfZ5YdQw
         PzG7HTJgrBo6tWHDJFsCCVNz3/kVBdiQup7f/0yym/8cBedGy9nO5Z38wYP9bnfkhyiY
         gI/lN2B12B0UsFCXpGg/yb2f+zGjqACcDT01mlweJgGBjuoz80wOqoilofDV0ORXRVVg
         1yLw==
X-Forwarded-Encrypted: i=1; AJvYcCXY3f4lVBCMqhVfaBcbmxLVEDt6sUDQA5dfjQOtLaGNAPKFElxBvg1VoWveVS0Qrzj4FxHTT7HLUM70cJGrM6kO57+vTTRrctf5o0Rkdioe
X-Gm-Message-State: AOJu0YxJEkcmWUjQY8VCzCdThSx6BSWNUP3mf3oxnfSw91Bjvvn7lpTm
	oKE8WR8BanM8TZuZ+Nyzw24Xc/uVrTLdzS0KfU32zK8F+5oAMQ1x
X-Google-Smtp-Source: AGHT+IG3VCAVEC7tEPbfzTDgtJDaO4PEIWMIteW/qfVhG1vjxVaG9mYN+Ibz71SwunCJx4XKnoGSNg==
X-Received: by 2002:a05:6a00:9294:b0:706:58ef:613 with SMTP id d2e1a72fcca58-70eae9771f8mr153295b3a.27.1721865285120;
        Wed, 24 Jul 2024 16:54:45 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8748f1sm117490b3a.151.2024.07.24.16.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 16:54:44 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 24 Jul 2024 16:54:42 -0700
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH bpf-next v1 19/19] selftests/bpf: Fix errors compiling
 cg_storage_multi.h with musl libc
Message-ID: <ZqGUQoBb0lpKD37v@kodidev-ubuntu>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
 <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
 <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>

On Tue, Jul 23, 2024 at 03:35:22PM -0700, YiFei Zhu wrote:
> On Mon, Jul 22, 2024 at 10:56 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Remove a redundant include of '<asm/types.h>', whose needed definitions are
> > already included (via '<linux/types.h>') in cg_storage_multi_egress_only.c,
> > cg_storage_multi_isolated.c, and cg_storage_multi_shared.c. This avoids
> > redefinition errors seen compiling for mips64el/musl-libc like:
> >
> >   In file included from progs/cg_storage_multi_egress_only.c:13:
> >   In file included from progs/cg_storage_multi.h:6:
> >   In file included from /usr/mips64el-linux-gnuabi64/include/asm/types.h:23:
> >   /usr/include/asm-generic/int-l64.h:29:25: error: typedef redefinition with different types ('long' vs 'long long')
> >      29 | typedef __signed__ long __s64;
> >         |                         ^
> >   /usr/include/asm-generic/int-ll64.h:30:44: note: previous definition is here
> >      30 | __extension__ typedef __signed__ long long __s64;
> >         |                                            ^
> >
> > Fixes: 9e5bd1f7633b ("selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/cg_storage_multi.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> > index a0778fe7857a..41d59f0ee606 100644
> > --- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> > +++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> > @@ -3,8 +3,6 @@
> >  #ifndef __PROGS_CG_STORAGE_MULTI_H
> >  #define __PROGS_CG_STORAGE_MULTI_H
> >
> > -#include <asm/types.h>
> > -
> >  struct cgroup_value {
> >         __u32 egress_pkts;
> >         __u32 ingress_pkts;
> > --
> > 2.34.1
> >
> 
> Hmm, some linter checks prefer headers themselves include everything
> they use. This header uses __u32 and after this patch it would include
> no headers. Would it be okay to include <linux/types.h> or we don't
> care?
> 
> YiFei Zhu

Good point, I agree even the readability suffers without headers.
Replacing <asm/types.h> with <linux/types.h> makes more sense, and
guards in the latter avoid the conflicts noted above. I'll queue this
change for a v2. Appreciate the feedback!

Cheers,
Tony Ambardar

