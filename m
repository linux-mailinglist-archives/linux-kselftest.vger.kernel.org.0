Return-Path: <linux-kselftest+bounces-6922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2C892E55
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 04:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89A41F21851
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 02:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3B628;
	Sun, 31 Mar 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy2AymGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384E1396;
	Sun, 31 Mar 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711852487; cv=none; b=jWMqKNBstHic1NnNqtmEhklFX98fH400WfQDTFyqhKjtIXY7tRb0YqsOvtGOZyXx0wEWKPJAKd86o+m1j+A6/1WE8pCEXzgUX6SKfC6W0ezZ25Rzsz2fAVlUyUeM5EEuntcuT+ehdeWbAQcf77zyAw8axusWoE4oQeU/ECfd/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711852487; c=relaxed/simple;
	bh=gV26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmzYeAGSaMyIjDZPlrwMo3hgPPsMOffRH8URPmCTR8dQMZhq7GO//lFDYMSk6tPcMuQTRTFRf2OrVj1ugqK0lxJM3vFBFuu/N7HMnZBcdqNyXGtnkhCp/notTFUWHOF2ByvyVCUhghBbJ/tO3SGu2dV2uOZN7pwqyGJffONCsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy2AymGs; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc01644f51so159554639f.2;
        Sat, 30 Mar 2024 19:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711852485; x=1712457285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=;
        b=Jy2AymGsN5lMSc1UzWBQqYEmctJu9hcEFMrLk1EvVIPUQ2vRWGvrki52sw7v23NLNy
         PJRpVeNV/9llTQ9/EMyMHfhE3PGEFhw1ToIkfDHcu4G1MtDeAmPMGmvoQVD2ytyOBfP9
         1k2Xm1jfRY4gUYOSigq2OoU+Ho3HoOiPnoIQxo10pvq1GTvxA/OcXA+fq6TRplYNpRAp
         fdai6ZVFdNN0dNmPdfkij0KZIsOnGnXl0Cln4cRXfOqX51cSkigiXGyKO4QieVXSKSXV
         CUYMuTkl3aX2Q2MAX4cEY+tEewnezwTFzF6/t0lpTHAi4cbvhL5i75u/2uT5rVPpvl4n
         4IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711852485; x=1712457285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=;
        b=rdUmY+KCUxxZt/KqUHDvByexlAZtEIH4XrbOIIDE9I6XBIVvHCTPgiV21Nr3oWYET5
         4yi797sJtaxzpP3l0L6AfMJZE1jq7q/JletLXiVED8JM2Mkgmh8pgemMqK+pjU5snNqj
         4SmAIY9xpkUFJTwb6KQRCHmClshfbax662MBwNLdyc71cKI+Ht6zOLscmyap13Cm8Jdl
         Pvwlu0PYjCt12ID8IEZH3heQS/YN134MrRK3B4SP56jTUo+ckVMsH43yk55Yq86rvUs/
         gxA5UuIqE4dGMSW497CceIm6gFxtwaAaA60xM1XmcEKkoJKn5MK0/KWEaiB12sZMfuDR
         xm/A==
X-Forwarded-Encrypted: i=1; AJvYcCW84S9V+AQQkYp+0Pg3uFJiqkrinKOD+cj0jo9RwHYKPgQTM0ca31x7++jsQaCnCHVrKhB4AZsrCgxGVc8F2iXDhlG9Twpbk1TuCelrLjExzQK5aDvFn2pyX1jXjUlDgWGnQskZ+ly86pfRZuSc6zLRTs1VtmYF1ktL1pi43uQwDvDiil12jcTRLBPiIPHnFnT4xag5EJJM5dDha3MF/IDYBm+KEn5/IQcomA3GYVFHVuXIiU3syvBp4mciUubTWnoJGGoBTfuVBZ+umC0D3La4taNF/wXygvGVcQ==
X-Gm-Message-State: AOJu0YxBCqzw8NXdwxSkflidZiBTQf2FxMt5MAFfeqN8T6V6IoSKYHDr
	LtNNbixGctgBJMaMxDf8ZKejURE+MphiwvxQexQkxWspvI/JgsQUap7XnuBlDVsr+sE+TBpgATD
	eqRNYh5vFsGTaYQ4ptCAJ0U5K7iE=
X-Google-Smtp-Source: AGHT+IEUljvEWt6RLJvm0ZvDNAAvbKF98d8W07FBneubUp0ru50ICaCtTHNp6cmd+wxEi3ZRk7j/LT8mS1rRQW2OsKc=
X-Received: by 2002:a05:6e02:3710:b0:366:ab6f:f63 with SMTP id
 ck16-20020a056e02371000b00366ab6f0f63mr8646788ilb.3.1711852485494; Sat, 30
 Mar 2024 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
 <20240330082755.1cbeb8c6@rorschach.local.home> <ZghRXtc8ZiTOKMR3@krava>
In-Reply-To: <ZghRXtc8ZiTOKMR3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 30 Mar 2024 19:34:33 -0700
Message-ID: <CAEf4BzbOAwLZ9=QnMQo-W5oHxTA7nM5ERRp0Q=WihuC8b+Y1Ww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 10:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Sat, Mar 30, 2024 at 08:27:55AM -0400, Steven Rostedt wrote:
> > On Fri, 29 Mar 2024 16:28:33 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > I thought I'll just ask instead of digging through code, sorry for
> > > being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
> > > before function execution to a return probe (fexit/kretprobe)? I.e.,
> > > how hard is it to pass input function arguments to a kretprobe? That'=
s
> > > the biggest advantage of fexit over kretprobe, and if we can make
> > > these original pt_regs/ftrace_regs available to kretprobe, then
> > > multi-kretprobe will effectively be this multi-fexit.
> >
> > This should be possible with the updates that Masami is doing with the
> > fgraph code.
>
> yes, I have bpf kprobe-multi link support for that [0] (it's on top of
> Masami's fprobe-over-fgraph changes) we discussed that in [1]

Sorry, I forgot the regs/args part, mostly remembering we discussed
session cookie ideas. Thanks for reminder!

>
> jirka
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dbpf/session_data
> [1] https://lore.kernel.org/bpf/20240228090242.4040210-1-jolsa@kernel.org=
/

