Return-Path: <linux-kselftest+bounces-11760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7C9052C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC951C21238
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A359173322;
	Wed, 12 Jun 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQz9aj/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC517083D;
	Wed, 12 Jun 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196125; cv=none; b=Xh8NHHj24nkcILBoQZmbd7qNHtU2a0c4VpZASCU4ivw1qnCeL1wNRz1VKo8XM5k0jNz1QF/yYRbuet2bJaMC66A/2o6MfckWwbukOq8KgVqXae56rBznnEHOX8p5CEHcMKpwAhNuvxt6F90zx/KrKhVs4F89HU9BWEXALNw6edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196125; c=relaxed/simple;
	bh=2eS5AS9BXmEOhaWNRS+1JFWwcMxQFs94YTD2RJKbNJI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHHum1i3SlbTU4t3VucCRaRuacmjBcIACAaf5toDq9SxNga3CUSoTXIgZUHS1tr6bugS8vXbdkRSQN913t2NTzUOtb8D9e6q7OPwAPqwFA5DHkXa8QBjPFLdK/MIA+w1tzc6FR7rav6wc3TcxXvWu6TR+tjnjP6wZKG1Y5RcksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQz9aj/a; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so3590988a12.3;
        Wed, 12 Jun 2024 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196122; x=1718800922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaWg4m5Bnwvqv8YcEFmBCH4VJg0dR5I+06fePYSf13o=;
        b=GQz9aj/afkHFwSE+qfS7yErjJNwZ3dqH/CVpt/uScG6PPvAgz3psfh5X2tfM5UkD5G
         pMpPWb4kcN1dDIw255l8CNNR1iNb20Ou/aTXjxFlKJjea4rt4sRPTd48tVpb2pIQdVsk
         egSJgonwMBzBSe+RAj8ktDDMAnZUX6wgTCDgUk9l5JImsmrZfoGJPvRalcv+DIRDMyG1
         jHoGWc2jx+JMtMxwGYqkFjd7Ujxobl6Qm6TL4y4DdRtun8eeLFRsY4ShelDgqCSSi4TR
         tXTHmgqHQaMZualXvuY3Ti8aYXSEiyxWOQsVRKMpKB2M/CxcQRtN8rviXz50ltPBGYXY
         M+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196122; x=1718800922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaWg4m5Bnwvqv8YcEFmBCH4VJg0dR5I+06fePYSf13o=;
        b=uxLgpnww9Z6SjezGbjaT+yZatl0H1B3lCSUR8B/aKoadM8Jg1Z0rIFlPulyVTqDljC
         P1u/DzT/mC5uYObHJ/Ye6JSkoZbbcidIASIaIuS2AdyA7h7J3TxJAmvxF9XqsyzKgeBq
         /VV60FJz4seiMdx6AFqnuN7EeN1ac9VUeXy20Ac1FQSuLXzior+pcFRkYYAwphfWNOV9
         fnhXa9XrQERqjJ19nRaufGX54i3x4uHafi0xDv+9kMcFSNqsBTL4Z6vzC4PT3l5UGqPU
         6VGlVk3gQe2fuFJHpMfrhCCHsLhICC6P+QWTkcNBD9kTU9ZlgDc88V5m4GGvJUKQ3icw
         XWmw==
X-Forwarded-Encrypted: i=1; AJvYcCVRw4D6jDupSDBmHBnjwU4OgVhTPFbbkBR/1gihrSjAWwNju7cu0GnMcvlqo2uIfSs8vIJeIliReb8QQXpc7j6mt/n60uqxDwl6oQSles3n2pv8Ww7fB9iRB7ed7lgTUNq48yvineZTG7zfknyp9eufNnXzfWV6lx6ggHYfkoi0folk
X-Gm-Message-State: AOJu0Yw5N1xIXqrbq2WsvZRTRz7okxE2NWYjWA7+Qd+azetaf2XmQLn0
	QwKZEwv1UQmf/UdCBcspOWRKccL/cMgd9S5BNS4/XTO+OyGzkCIS
X-Google-Smtp-Source: AGHT+IEurYY9mBvYQqhqXDFmp4P8HwN0BoTp0cQDJ0TSoIEs17WlcQeFx3uNCZL+rbnmP83DTCb74A==
X-Received: by 2002:a50:d7dd:0:b0:57c:74b1:bf51 with SMTP id 4fb4d7f45d1cf-57ca97626b3mr1524272a12.20.1718196122177;
        Wed, 12 Jun 2024 05:42:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c9f32f079sm1869654a12.88.2024.06.12.05.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:42:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 12 Jun 2024 14:41:59 +0200
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, shuah@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	quentin@isovalent.com, alan.maguire@oracle.com, acme@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 03/12] bpf: selftests: Fix fentry test kfunc
 prototypes
Message-ID: <ZmmXl1NHgwOEXy4F@krava>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <1f493cb7a7e5349f99e2badf0880b75dd6681898.1717881178.git.dxu@dxuuu.xyz>
 <Zmb_hJQqxi44Nj5B@krava>
 <gwrlw7wtc72vz3ky2pltvpoadtjlezv6kdrs6wf3ptsecyu2sh@aexbk4rotm3x>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gwrlw7wtc72vz3ky2pltvpoadtjlezv6kdrs6wf3ptsecyu2sh@aexbk4rotm3x>

On Tue, Jun 11, 2024 at 10:58:26AM -0600, Daniel Xu wrote:
> On Mon, Jun 10, 2024 at 03:28:36PM GMT, Jiri Olsa wrote:
> > On Sat, Jun 08, 2024 at 03:15:59PM -0600, Daniel Xu wrote:
> > > The prototypes in progs/get_func_ip_test.c were not in line with how the
> > > actual kfuncs are defined in net/bpf/test_run.c. This causes compilation
> > > errors when kfunc prototypes are generated from BTF.
> > > 
> > > Fix by aligning with actual kfunc definitions.
> > > 
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > index 8956eb78a226..a89596f7585d 100644
> > > --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > @@ -5,13 +5,13 @@
> > >  
> > >  char _license[] SEC("license") = "GPL";
> > >  
> > > -extern const void bpf_fentry_test1 __ksym;
> > > -extern const void bpf_fentry_test2 __ksym;
> > > -extern const void bpf_fentry_test3 __ksym;
> > > -extern const void bpf_fentry_test4 __ksym;
> > > -extern const void bpf_modify_return_test __ksym;
> > > -extern const void bpf_fentry_test6 __ksym;
> > > -extern const void bpf_fentry_test7 __ksym;
> > > +extern int bpf_fentry_test1(int a) __ksym;
> > 
> > hum, the only registered one as kfunc is bpf_fentry_test1, to allow fmodret
> > also there's bpf_fentry_test9 as kfunc, which AFAICS is not really needed
> 
> I think bpf_modify_return_test() is also registered. But otherwise yeah,
> I think I was overaggressive here. Are you thinking something like this?

yes, looks good

> 
> 
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index a89596f7585d..2011cacdeb18 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -6,12 +6,11 @@
>  char _license[] SEC("license") = "GPL";
> 
>  extern int bpf_fentry_test1(int a) __ksym;
> -extern int bpf_fentry_test2(int a, __u64 b) __ksym;
> -extern int bpf_fentry_test3(char a, int b, __u64 c) __ksym;
> -extern int bpf_fentry_test4(void *a, char b, int c, __u64 d) __ksym;
>  extern int bpf_modify_return_test(int a, int *b) __ksym;
> -extern int bpf_fentry_test6(__u64 a, void *b, short c, int d, void *e, __u64 f) __ksym;
> -extern int bpf_fentry_test7(struct bpf_fentry_test_t *arg) __ksym;

I did not realize bpf_fentry_test6/7 are not used.. ok

thanks,
jirka

> +
> +extern const void bpf_fentry_test2 __ksym;
> +extern const void bpf_fentry_test3 __ksym;
> +extern const void bpf_fentry_test4 __ksym;
> 
>  extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;

