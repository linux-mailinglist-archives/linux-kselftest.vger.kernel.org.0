Return-Path: <linux-kselftest+bounces-14033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9039397F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 03:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E4D1F22496
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7213049E;
	Tue, 23 Jul 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgYA1gsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF02F5E;
	Tue, 23 Jul 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698529; cv=none; b=CVP7zRkdFKUFzm3PKm+TyiE2wJf9wWMXiSh3j7tR9Gy8BgtwKJAGxohpbUY9YKqDJhHn9SoeAWNGMb+m/A526vekJxIWzpnfMmoByvPA4+s5uF06JZpwk3DowWm71zICBbbskPA8pUVOuopAx6JFycNxluiwA1o+JthcLABfipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698529; c=relaxed/simple;
	bh=KpmVnjIGyU8xhmtjVqedazKOEMlfk3JxhmfhQcPVEtQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3TjVaJLO0K8nd+ktjbGmErPK9JLE4Nmv8TzLg9D+AyPg5CFQLByEU2CF2i7F1NUV8HOV238Jx47dc0afHj82VGuFPWxWSq9/ZWqB93eRcmvZMf2BgaqEOUfaWRrB4qz6mGoMWJWC+uFu/PW0WQc8r4uQARu2OoSHFMiGg3oxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgYA1gsn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b703eda27so2200447b3a.3;
        Mon, 22 Jul 2024 18:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721698527; x=1722303327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+XVqrMSR6U3ix0X7mPYeOwhGWM5DiehI771I1P8154=;
        b=fgYA1gsnYbVNXKk7TN2M+gCz2gDTcpYpC/+ZtlxWvNv496iYli5ctni3jpgEVDAwse
         QpM6Ya2n8sKJ1hO0mwS2R5bMgGdOkiVB+PttXc2g7SrVmhd7G/muoPz4aytiVwX0LnAJ
         HGz9bC6B67ZmgtmQbdzRiYlivVhVQ+zT9v7j3AqLf8SgRYZPdTp1TOPfM1CKoEeWBFLk
         GY92+i25dpyQ4Erc404o/bt52YE6mKsaJB+hq+sWKOixDmk/UDyx08sdpHc12pcLop08
         ZEsSRd4BbxGk2CXleYeFYAIEyIBXSsdCITGct4UmqUHoq4IggPINEr6KMPizzaCjTjjM
         Ioxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698527; x=1722303327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+XVqrMSR6U3ix0X7mPYeOwhGWM5DiehI771I1P8154=;
        b=dAYDNH4MvyExYFc+OpTw+wxrNgKjc04/8of31ei+GZdlq7Y5JI2WE/1ouyUFFN+8yW
         7JPGdJawiHcU+sVnfLz3b8DJnSNPJRBjbsHWv0jsFb3plvP2qOIG/LgTxyvG//pCrcPn
         zZhCVT1m3IFZTpzGKzTgF1zdZ/NoiwgIo1QHaIebA2LTHQi/m4hYcdSuLMFwuVpRhWxD
         eTbKab7L93Z6g6lsiP9336tf12tKHsg9rcb/4fFbugZKMeuUEpGLZkTknjBpmhv3MoD/
         vioubuTHB19q8vUtTvnibxnD9Kv6/wu2pKUWeWHgjvtddSamjAbj0dq0rhf6VCoc4Ssh
         wHxA==
X-Forwarded-Encrypted: i=1; AJvYcCUBVyNgwtYBNSNB9mr9qjZWwrfSVAHMBYxVdjntjXhoeVlN7kIxE2y7UD/8vnKbVfQG3N4V5SkFmSoQigdWl1S1Bhfl4k11n3EiJVk3UhXi
X-Gm-Message-State: AOJu0YxL20uyyrxyq0P3hNDJQm9IRFTUC6FAmDFgawoDZxsOnUWEkXBO
	0WFaBOu29SordDWTVK/E1XDZXry01snZBgQqnGR64UKVGVneuIg1
X-Google-Smtp-Source: AGHT+IGc7xI1xeyV8paiqb9CwZ0C4tFLmNvK3Eo48Pev/YNYrmjzNGCMMbfEJ8cSBHAOHa11uBbq0w==
X-Received: by 2002:a05:6a00:17aa:b0:705:ddbf:5c05 with SMTP id d2e1a72fcca58-70d0efa95a2mr8134479b3a.11.1721698527443;
        Mon, 22 Jul 2024 18:35:27 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a22ad16fefsm2670026a12.21.2024.07.22.18.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:35:27 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 22 Jul 2024 18:35:25 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
Message-ID: <Zp8I3aN/bZnka4I+@kodidev-ubuntu>
References: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
 <20240719232159.2147210-1-tony.ambardar@gmail.com>
 <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>
 <ZptJ1dsnKbjTZ6iH@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZptJ1dsnKbjTZ6iH@kodidev-ubuntu>

On Fri, Jul 19, 2024 at 10:23:33PM -0700, Tony Ambardar wrote:
> On Fri, Jul 19, 2024 at 07:57:09PM -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 19, 2024 at 4:22 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >

[...]

> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -425,27 +425,28 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> > >  $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> > >
> > >  # Build BPF object using Clang
> > > -# $1 - input .c file
> > > -# $2 - output .o file
> > > -# $3 - CFLAGS
> > > +# $1 - binary name
> > > +# $2 - input .c file
> > > +# $3 - output .o file
> > > +# $4 - CFLAGS
> > >  define CLANG_BPF_BUILD_RULE
> > > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
> > > +       $(call msg,CLNG-BPF,$1,$3)
> > > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v3 -o $3
> > 
> > this works, but did you have to renumber all parameters? Let's maybe
> > pass this binary name as the 4th argument?
> > 
> 
> OK, I'll update as requested and minimize the diff.
> 
Hi Andrii,

I sent out a v2 based on your suggestions but omitted Eduard's Acked-by:
by mistake. Should I resubmit or is that something you can update?

Thanks,
Tony
> > pw-bot: cr
> > 
> > >  endef
> > >  # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> > >  define CLANG_NOALU32_BPF_BUILD_RULE
> > > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
> > > +       $(call msg,CLNG-BPF,$1,$3)
> > > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v2 -o $3
> > >  endef
> > >  # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
> > >  define CLANG_CPUV4_BPF_BUILD_RULE
> > > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
> > > +       $(call msg,CLNG-BPF,$1,$3)
> > > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v4 -o $3
> > >  endef
> > >  # Build BPF object using GCC
> > >  define GCC_BPF_BUILD_RULE
> > > -       $(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> > > -       $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
> > > +       $(call msg,GCC-BPF,$1,$3)
> > > +       $(Q)$(BPF_GCC) $4 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $2 -o $3
> > >  endef
> > >
> > >  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
> > > @@ -534,7 +535,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                             \
> > >                      $(wildcard $(BPFDIR)/bpf_*.h)                      \
> > >                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
> > >                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> > > -       $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
> > > +       $$(call $(TRUNNER_BPF_BUILD_RULE),$(TRUNNER_BINARY),$$<,$$@,    \
> > >                                           $(TRUNNER_BPF_CFLAGS)         \
> > >                                           $$($$<-CFLAGS)                \
> > >                                           $$($$<-$2-CFLAGS))
> > > --
> > > 2.34.1
> > >

