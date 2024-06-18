Return-Path: <linux-kselftest+bounces-12168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593E90DC33
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 21:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3311C233C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53E15ECFA;
	Tue, 18 Jun 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT6Tg5AV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4891BF50;
	Tue, 18 Jun 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737684; cv=none; b=CtrCaspBK4vF/UgA2u/uIWF0QCDtcnnNbc4Uw5tQOjlEd2ER78ebdrExEesZR0FGqsebTK/I287iHpNKJ1rY6OTOfcmXzlVAWn+bkU82rLnS2R58mABLtogK9HLnBSs7f6mJ0SWJAikic1AyYeQREd7HVEy3Ypn5eJUsQVWc1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737684; c=relaxed/simple;
	bh=vpmHfL9r9TyAE2DjCbaAMxhUUBeiCaKP/urqhM0ztMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PspBFExPyJL2sMzDXiLddZbQIip48JvRDvMdY3J0IZrqIa011zCuTPN2f5/7fXjKCW63v8IjESWlFj+kzuweLRRaF2AiMhUa81vNdortBEWCY84niB0Rzw84NxtclNnHzPTogC14FTBte6oq6v2Kc2VwUwjQb+vZLKuAobwAdTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT6Tg5AV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1691b18fso4744468f8f.2;
        Tue, 18 Jun 2024 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718737681; x=1719342481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0I0d/NKdwXHuOccz/djhmZkYE9cQJgTceoyjyWcQAP0=;
        b=KT6Tg5AVFPpSusV/+CCwrmN+18gPs3hSLGSSISah3bI8DbXxpntHTL2QUWhnBHAmKo
         scXlXfbUHI9NwJbpsLOEtOinFWQ9qRb/LUD9dYtZT9neOHQblHD96i6QsxkeXcm3+083
         DPdAO3WR3GNSkwGCqu+ee5ZKz+1skhaIY9GjIA9SbNBrrOyJXUMXUFuLHDQKt0HP6Sp+
         1vLca7i1yR8dzSEbsB1qyQsnWIEEy7vU+ZzqfpZ/NM0EsXrBPcNkP9WBGo4Ai4tPdcsP
         7CdrVbc0+6nTI2KrJ2yR7YhqIGMqRjHnmEwxTJtOYw6f5glg/43F8f+NSgPzJxikmO2N
         VGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737681; x=1719342481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0I0d/NKdwXHuOccz/djhmZkYE9cQJgTceoyjyWcQAP0=;
        b=SBmm18ZBNo9l0VB4MtJdbwWYPVXtnIc7veJM2c8XZPRI1pzNBwZnczV9zuusoRZDmf
         795o9IgRSKTS/6nOIQ7IwKDUVlOkbe/9o22jxzrUk+ITcBTBX6lA1UPEwOAGQuF/STQ0
         DO8YLjXNPSbapJnYlxcKjh1C8Pt5pVmuOpYaahvLA1J+f2thD/+8LFsUnRf//oiR2Ijn
         ysLmqZMWRzXoTSJMatzYvSeVnlA/0CiVArjs4N0getxrcRZdWFdAG1zgXqCrqGCrInxM
         MePytJBSpGMidSoWDTvingaDADgqfxROwxhSNf/lWP4DT0fv8LrcgTr/ePLwhoSdy4NY
         JXZw==
X-Forwarded-Encrypted: i=1; AJvYcCUkjwMESaAQXmekY5No7Jd8z0Z4Z6/AKKopsEDtYWuGCRtd9m99Oa8JL/wSGALKxyde9sK16OMnvdZ3eA4b//+ri+taSAVXdjSpYotTxBhhw9jYUz8rR8dihgZtKaeoxrhE9CC76xoXLlU9Ra5+odDO9+YloYUpfPLnX2VxfXeN9nHL
X-Gm-Message-State: AOJu0YyTedA8UwmEWOCTgag/d6yDrd+ayqDrPstrOj8+yRnlzJA0mpYj
	Lnm/WPAJQKUOs9RsofFGFbkOth5xKFSq/pTE6YN82iMZGWOAezAc
X-Google-Smtp-Source: AGHT+IFRdLy3kSCQHiBaMb3kuFLG6/e8w+S8xgh9afjw30/pEnRE2G+RFO2vDbjC9cYfD1I+tprCyw==
X-Received: by 2002:adf:e590:0:b0:360:6f9e:8a85 with SMTP id ffacd0b85a97d-363195b2334mr331834f8f.43.1718737681093;
        Tue, 18 Jun 2024 12:08:01 -0700 (PDT)
Received: from krava (85-193-35-215.rib.o2.cz. [85.193.35.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608accd8b3sm9391893f8f.71.2024.06.18.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:08:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Jun 2024 21:07:58 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, daniel@iogearbox.net, quentin@isovalent.com,
	alan.maguire@oracle.com, acme@kernel.org, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix
 bpf_session_cookie() kfunc prototype
Message-ID: <ZnHbDgAnwgZqw6Lk@krava>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava>
 <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>
 <ZnGBANDTF80gNDHR@krava>
 <CAEf4BzZVfppin_mfEJF9eVcZUu9hds5PKuLysWOXeSJ7gdV3dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVfppin_mfEJF9eVcZUu9hds5PKuLysWOXeSJ7gdV3dg@mail.gmail.com>

On Tue, Jun 18, 2024 at 09:58:23AM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 18, 2024 at 5:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jun 17, 2024 at 03:25:53PM -0700, Andrii Nakryiko wrote:
> > > On Mon, Jun 10, 2024 at 6:04 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > > > > The prototype defined in bpf_kfuncs.h was not in line with how the
> > > > > actual kfunc was defined. This causes compilation errors when kfunc
> > > > > prototypes are generated from BTF.
> > > > >
> > > > > Fix by aligning with actual kfunc definition.
> > > > >
> > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
> > > > >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > > index be91a6919315..3b6675ab4086 100644
> > > > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > > > >                                     struct bpf_key *trusted_keyring) __ksym;
> > > > >
> > > > >  extern bool bpf_session_is_return(void) __ksym __weak;
> > > > > -extern long *bpf_session_cookie(void) __ksym __weak;
> > > > > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> > > >
> > > > the original intent was to expose long instead of __u64 :-\
> > > >
> > >
> > > Cookies internally are always u64 (8 byte values). Marking them
> > > internally in the kernel as long could lead to problems on 32-bit
> > > architectures, potentially (it still needs to be 64-bit value
> > > according to BPF contract, but we'll allocate only 4 bytes for them).
> > >
> > > It seems better and safer to be explicit with __u64/u64 for cookies everywhere.
> >
> > hum, I based that on what we did for kprobe session,
> > but I guess it makes sense just for bpf side:
> 
> yep, exactly, long is 64-bit only for BPF "architecture", but
> internally it will be 4 bytes for 32-bit architectures, which will
> potentially lead to problems. With recent kfunc vmlinux.h generation,
> it's probably better to stick to explicitly sized types.

hm, it already got in 2b8dd87332cd, revert needs more changes in selftests
I'll send formal patch with fix below

jirka

---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4b3fda456299..cd098846e251 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3530,7 +3530,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc long *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index be91a6919315..3b6675ab4086 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 extern bool bpf_session_is_return(void) __ksym __weak;
-extern long *bpf_session_cookie(void) __ksym __weak;
+extern __u64 *bpf_session_cookie(void) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index d49070803e22..0835b5edf685 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -25,7 +25,7 @@ int BPF_PROG(trigger)
 
 static int check_cookie(__u64 val, __u64 *result)
 {
-	long *cookie;
+	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;

