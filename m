Return-Path: <linux-kselftest+bounces-6920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57B892C35
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E53282788
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A839ACB;
	Sat, 30 Mar 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt1LKbPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3C1E865;
	Sat, 30 Mar 2024 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821157; cv=none; b=siVXXJM8fXyC9Tz3utLrwTv1wWoyWr++E4D8jm7OjujKnjhvoQgNkGlhrGYQ97EIisqRV84zYrTiZpvIYRatlmAxz02CUehnclurSKIcyqtcHWopafw7Y1+J0LTA9fizVvwXaCwmTV0izid1hUww2zFVCgAi4DBi/S5iJpm9s8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821157; c=relaxed/simple;
	bh=e3y+Wv0l0CutS/az1jjvT9w2VVhma+j5QqOCRBKlFIw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRYexQ2obYTRgxWhzvyo+ZOBzUA4CPJZdLzYTyncbiRwOQ7pRRSihMHwzaIzV/hxAyh40o96p2MIPoT92IvqaVRVr8KP5zR4atA58lwWIjOHMFqiEZydtv+GpFs0w+DkJ7azvX9G23XnV7aBEllcKtMpzH49cD7TCu+ONpC7DjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt1LKbPX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46de423039so165855066b.0;
        Sat, 30 Mar 2024 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711821154; x=1712425954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd1Ju+LCh2MPv5vAR1VJsB6sgx1pw4Hx1J299NMUFnM=;
        b=Rt1LKbPXFyD4XZCZ0XXPUiSKBUxkI6G1P4qAqMEmpsWwsiShzAWCPcbGha3qb2MHdX
         EgWJaQUn9jwaAdQ4gLn3Ki0JZBRWQL9CJGF8BqeB9k4uD2U7xkODsyngOQkt2n75dMlP
         qNfDDpqDsUQNYbMrxeiX2fdxIvEzJorE62ay7SRe3irLVCLCrz226v9RUJziUX5znP2j
         SirKQvnenMPjBLSg1a8luuJVp4NcIQCXVg06xlC8f7GfbdP6dmE+Tc+jIHzF/zg0vW27
         HFXiHZgPhMyU35U/aqd13506IbAGxHYQMwM6/b+hPR2gJMIDZkNqgdRm8M5kJ4ZF9B8t
         +eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821154; x=1712425954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd1Ju+LCh2MPv5vAR1VJsB6sgx1pw4Hx1J299NMUFnM=;
        b=CuUt/d2/t8TDqY1o5On2pUBtv+YYFtESMCRi+ZXaWSfW5LSEMeXDReaPCw0p46oGHK
         zrebhHffnj+9OoaML2jjHHKP2zFYEilpaLN6T/ABelC1vRXZmM8GPxEleQf0nm9/8ZDT
         HjORuaKueFh9k4U95GTvyLhUu2j5/Wb5Mb26uuX+Xc1RErfuspuKqGUpBuQaVvPhPSH8
         uNaOsLbJgrZuSowhFdUYC93dWd6g+rrIyNolEusCpB9iL6eLLceHLt53eciBBhdqg4p+
         ko22v9RJkzYH+9903nXRCTMPyANPhjdnJ3ySxfLK3L32V5p8Lbc2eU1wVYE0RQXwzMBZ
         HOSw==
X-Forwarded-Encrypted: i=1; AJvYcCWI1Li64/rv+kUMJ2fKVf6GTxpDhJM1lNopVvuZAaEOBabjWE5OPQGwFCwYXS4jtRNJGaAVF5ZmDZ+hbap7sDvroxSMnC9kY+H3AOSpSCtYC0npFFlzYHmhxufLZw76i/GGuKRkEf+ZWRwsx+qNd4w8H4MYMvWT/k4tkc+1DHiqq2l0+d4jB7Ee5M7G5mCaYKcffqgbv2VTzymNjmCGk3nCQgRB9fXEGWigdu9/7GW7hlqW2dqXn09KSVO184N7WyDD2rC8hiphYes0RkZZe7vO7HqP+Kl3nqQvMg==
X-Gm-Message-State: AOJu0YxSl1t7U0KU8E7V3nD00nJ3qFfSDKzB0yCArw81mERUzaFSX7vA
	re2OPOAQNv8T8/qv7EvqhfnbEVetfqRRhxe8Kzrr9vi0Cj5TfFF2
X-Google-Smtp-Source: AGHT+IEGAmf0kvvH3dm+5STvdXDGmaMLsXGzvzIXptUqdCRcniCaiSzPtCwt9Qd53mlg93swhXFVXQ==
X-Received: by 2002:a50:8ad9:0:b0:566:b09e:8d24 with SMTP id k25-20020a508ad9000000b00566b09e8d24mr4080922edk.12.1711821153955;
        Sat, 30 Mar 2024 10:52:33 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7cd14000000b0056bf9b4ec32sm3516637edw.78.2024.03.30.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 10:52:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 30 Mar 2024 18:52:30 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	=?utf-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
Message-ID: <ZghRXtc8ZiTOKMR3@krava>
References: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home>
 <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
 <20240330082755.1cbeb8c6@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330082755.1cbeb8c6@rorschach.local.home>

On Sat, Mar 30, 2024 at 08:27:55AM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2024 16:28:33 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > I thought I'll just ask instead of digging through code, sorry for
> > being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
> > before function execution to a return probe (fexit/kretprobe)? I.e.,
> > how hard is it to pass input function arguments to a kretprobe? That's
> > the biggest advantage of fexit over kretprobe, and if we can make
> > these original pt_regs/ftrace_regs available to kretprobe, then
> > multi-kretprobe will effectively be this multi-fexit.
> 
> This should be possible with the updates that Masami is doing with the
> fgraph code.

yes, I have bpf kprobe-multi link support for that [0] (it's on top of
Masami's fprobe-over-fgraph changes) we discussed that in [1]

jirka

[0] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/session_data
[1] https://lore.kernel.org/bpf/20240228090242.4040210-1-jolsa@kernel.org/

