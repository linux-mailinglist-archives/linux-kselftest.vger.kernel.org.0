Return-Path: <linux-kselftest+bounces-6931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8D89348C
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC002847AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522914A4CA;
	Sun, 31 Mar 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy2AymGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEF15EFA2;
	Sun, 31 Mar 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903428; cv=fail; b=lE3lSLsURiaV9RinuguqDvOtx3tElXXLYVlNYcz83dDMBgFTbfHiyC6D762tZt25x0jmXKByqEPwj33sAVuHTAhjU4YH6TPhMuivfuNXM7gJi0TqzOKLeYEQcVXHQrN7CZqGSPnxr8/0oiY2p+HFdhjZh2idRbby5cQRjQZeXww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903428; c=relaxed/simple;
	bh=K02O6tXWhQvm0ZWKP9nwjiuHSAsZNDuVatGLv6Lpks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvSqbNc6JA4KQgCRJWlfjr+Qn+YaJy6xn5wZBpwaLn7XUQxY8OTteJaTr+K35ptWcfyxWDUKr88+tszf37EmsroveddPlbvmZOkorK9dL5ZeUA5NCUwBz81SZ59Nbl+LjBY1pHZj05dO5HGumLcl8pypJ8whsdBbKpGnarOp5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy2AymGs reason="signature verification failed"; arc=none smtp.client-ip=209.85.166.50; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 92492208C8;
	Sun, 31 Mar 2024 18:43:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMQTNbjbghYG; Sun, 31 Mar 2024 18:43:41 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 522A7208BE;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 522A7208BE
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 42D94800060;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:40 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:27 +0000
X-sender: <netdev+bounces-83537-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAJWsFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAGEAAADpigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 17450
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83537-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com BD08C20199
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy2AymGs"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711852487; cv=none; b=jWMqKNBstHic1NnNqtmEhklFX98fH400WfQDTFyqhKjtIXY7tRb0YqsOvtGOZyXx0wEWKPJAKd86o+m1j+A6/1WE8pCEXzgUX6SKfC6W0ezZ25Rzsz2fAVlUyUeM5EEuntcuT+ehdeWbAQcf77zyAw8axusWoE4oQeU/ECfd/vE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711852487; c=relaxed/simple;
	bh=gV26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmzYeAGSaMyIjDZPlrwMo3hgPPsMOffRH8URPmCTR8dQMZhq7GO//lFDYMSk6tPcMuQTRTFRf2OrVj1ugqK0lxJM3vFBFuu/N7HMnZBcdqNyXGtnkhCp/notTFUWHOF2ByvyVCUhghBbJ/tO3SGu2dV2uOZN7pwqyGJffONCsRk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy2AymGs; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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

X-sender: <linux-kernel+bounces-125930-steffen.klassert=3Dcunet.com@vger.ke=
rnel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAJWsFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGIAAADpigAABQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 17433
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 04:35:13 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sun, 31 Mar 2024 04:35:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id E266220322
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 04:35:12 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7swtypsqutpn for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 04:35:12 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.80.249; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-kernel+bounces-=
125930-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klass=
ert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 297DC20199
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dy2AymGs"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 297DC20199
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A51F218DC
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F935611B;
	Sun, 31 Mar 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dy2AymGs"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166=
.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384E1396;
	Sun, 31 Mar 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.166.50
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711852487; cv=3Dne; b=3DMqKNBstHic1NnNqtmEhklFX98fH400WfQDTFyqhKjtIXY7t=
Rb0YqsOvtGOZyXx0wEWKPJAKd86o+m1j+A6/1WE8pCEXzgUX6SKfC6W0ezZ25Rzsz2fAVlUyUeM=
5EEuntcuT+ehdeWbAQcf77zyAw8axusWoE4oQeU/ECfd/vEARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711852487; c=3Dlaxed/simple;
	bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DzYeAGSaMyIjDZPlrwMo3hgPPsMOffRH8URPmCTR8dQMZhq7GO=
//lFDYMSk6tPcMuQTRTFRf2OrVj1ugqK0lxJM3vFBFuu/N7HMnZBcdqNyXGtnkhCp/notTFUWHO=
F2ByvyVCUhghBbJ/tO3SGu2dV2uOZN7pwqyGJffONCsRkARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D2AymGs; arc=3Dne smtp.client-ip 9=
.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc01644f51=
so159554639f.2;
        Sat, 30 Mar 2024 19:34:46 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711852485; x=1712457285; darn=3Der.kernel=
.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
        b=3D2AymGsN5lMSc1UzWBQqYEmctJu9hcEFMrLk1EvVIPUQ2vRWGvrki52sw7v23NLN=
y
         PJRpVeNV/9llTQ9/EMyMHfhE3PGEFhw1ToIkfDHcu4G1MtDeAmPMGmvoQVD2ytyOBf=
P9
         1k2Xm1jfRY4gUYOSigq2OoU+Ho3HoOiPnoIQxo10pvq1GTvxA/OcXA+fq6TRplYNpR=
Ap
         fdai6ZVFdNN0dNmPdfkij0KZIsOnGnXl0Cln4cRXfOqX51cSkigiXGyKO4QieVXSKS=
XV
         CUYMuTkl3aX2Q2MAX4cEY+tEewnezwTFzF6/t0lpTHAi4cbvhL5i75u/2uT5rVPpvl=
4n
         4IGQ=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711852485; x=1712457285;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
        b=3DUmY+KCUxxZt/KqUHDvByexlAZtEIH4XrbOIIDE9I6XBIVvHCTPgiV21Nr3oWYET=
5
         4yi797sJtaxzpP3l0L6AfMJZE1jq7q/JletLXiVED8JM2Mkgmh8pgemMqK+pjU5snN=
qj
         4SmAIY9xpkUFJTwb6KQRCHmClshfbax662MBwNLdyc71cKI+Ht6zOLscmyap13Cm8J=
dl
         Pvwlu0PYjCt12ID8IEZH3heQS/YN134MrRK3B4SP56jTUo+ckVMsH43yk55Yq86rvU=
s/
         gxA5UuIqE4dGMSW497CceIm6gFxtwaAaA60xM1XmcEKkoJKn5MK0/KWEaiB12sZMfu=
DR
         xm/A=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCW84S9V+AQQkYp+0Pg3uFJiqkrinKOD+cj0jo9RwHY=
KPgQTM0ca31x7++jsQaCnCHVrKhB4AZsrCgxGVc8F2iXDhlG9Twpbk1TuCelrLjExzQK5aDvFn2=
pyX1jXjUlDgWGnQskZ+ly86pfRZuSc6zLRTs1VtmYF1ktL1pi43uQwDvDiil12jcTRLBPiIPHnF=
nT4xag5EJJM5dDha3MF/IDYBm+KEn5/IQcomA3GYVFHVuXIiU3syvBp4mciUubTWnoJGGoBTfuV=
BZ+umC0D3La4taNF/wXygvGVcQ=3D=0A=
X-Gm-Message-State: AOJu0YxBCqzw8NXdwxSkflidZiBTQf2FxMt5MAFfeqN8T6V6IoSKYHD=
r
	LtNNbixGctgBJMaMxDf8ZKejURE+MphiwvxQexQkxWspvI/JgsQUap7XnuBlDVsr+sE+TBpgAT=
D
	eqRNYh5vFsGTaYQ4ptCAJ0U5K7iEX-Google-Smtp-Source: AGHT+IEUljvEWt6RLJvm0ZvD=
NAAvbKF98d8W07FBneubUp0ru50ICaCtTHNp6cmd+wxEi3ZRk7j/LT8mS1rRQW2OsKcX-Receiv=
ed: by 2002:a05:6e02:3710:b0:366:ab6f:f63 with SMTP id
 ck16-20020a056e02371000b00366ab6f0f63mr8646788ilb.3.1711852485494; Sat, 30
 Mar 2024 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail=
.com>
 <CALz3k9icPePb0c4FE67q=3DU0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=3DJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=3DmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=3Djt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CAEf4BzYgzOti+Hfdn3SUCjuofGe=
dXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
 <20240330082755.1cbeb8c6@rorschach.local.home> <ZghRXtc8ZiTOKMR3@krava>
In-Reply-To: <ZghRXtc8ZiTOKMR3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 30 Mar 2024 19:34:33 -0700
Message-ID: <CAEf4BzbOAwLZ9=3DMQo-W5oHxTA7nM5ERRp0Q=3DhuC8b+Y1Ww@mail.gmail=
.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add suppo=
rt
 to record and check the accessed args
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, =3DTF-8?B?5qKm6b6Z6JGj?=3Dongmeng=
long.8@bytedance.com>,=20
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii=
@kernel.org>,=20
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net=
>,=20
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song =
Liu <song@kernel.org>,=20
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gm=
ail.com>,=20
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Lu=
o <haoluo@google.com>,=20
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntra=
eger@linux.ibm.com>,=20
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.ne=
t>,=20
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com=
>,=20
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>,=20
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,=20
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kerne=
l@vger.kernel.org>,=20
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger=
.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kern=
el.org,=20
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, l=
inux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125930-steffen.klassert=3Dcunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 02:35:12.9064
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: bd0d62d3-6a24-4f47-4e50-08dc=
512b311b
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-esse=
n-02.secunet.de:TOTAL-HUB=3D405|SMR=3D332(SMRDE=3D005|SMRC=3D326(SMRCL=3D10=
2|X-SMRCR=3D326))|CAT=3D070(CATOS=3D001
 |CATRESL=3D029(CATRESLP2R=3D023)|CATORES=3D037(CATRS=3D037(CATRS-Transport
 Rule Agent=3D001 |CATRS-Index Routing Agent=3D035)));2024-03-31T02:35:13.4=
14Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 11569
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D103|SMR=3D007(SMRPI=3D005(SMRPI-FrontendProxyAgent=3D005))|SMS=3D095
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AATwEAAAPAAADH4sIAAAAAAAEAHVUTY/b=
NhClbMtfu07a9N
 Tb9JQsYFuyd7fZGOlucgmwBbYBmqCXIAhoi5K5kkWBpOx1T/0R/R/9
 T/0lnSFtr4EmACGMhm/evHmk9Hf/fQkfuB3CHddwHg9hGk8vgFuYxL
 PL6b9//fP2Dn6VWsL7wnB4rfB5j69vshWXxXihVtew0cqK2aB/jQu+
 RRdfzaYvZ5eXSDeKL2Lc+WDFWpTwuzJWJPaRBRzJOy2x+JXjcRyTn2
 fTq9n5OZa/jGOPe1smWkr4jed6K3MFr7lLjMtd4qsq4doXX8Mt2KWq
 s6WF2+dFAfe1scBNDrJESTwBlUIis0yWGQI1IWGhEjEEo7TeQqr0nm
 kuCFTwP7cwO4Nbg3ihBfByCxu+Baug4sZAZb9okZkotZovhIthwStb
 a5E8UiGvgLQuF1aqEsSDWNQuQhYOWiC6hEqruYAXqXiQNsox6RJnN3
 A7FuPhnmupNrDkOgFpQNqDDFlWtX3swHVWr0Rpje9wYLuBj0tun5s9
 G84Ec/RDkE3JmpeWZ4JMcipArYV+LB7i8Ng3hY3AEUtY8VwcERks1B
 Kt5cVXXeFrPDg+LwRpOiLF0nJPs6oLK0eHTdhIPESRpgLHWotii1Yi
 Hkf3QKdyfHQBPtKewRtQJAStlDGSOm6kXbph6yrhVtBh4gW+44avJD
 mZKDrsPcpzpZnmlb8e492XsBVmiFdsyddoW5VC7lSOnBgoZJmDqatK
 aUsXyff4FH+GFxItB3fcFZpLTL41ZlNPQU6P9h2XvMQTOSOfE2kWtT
 Ei8WyyhE+Tz4P+oP+B7iuJwU6Zsm44ZzkePd5KrvGDXeF3iJ5psRKr
 udBuxCPKQd8I9Ad1LZTKpQCZCG7GdEXK3LgRsFSWidA/UUtnAf4pcr
 6LabaltZWZRVGGB5ELXYpijIKiqp5HZrGK0JT6IfIbhInu6XcTVUKn
 Y3otVBbdLH9BM6OdmC94QNyxTx7ZC/x+jukJT7+QeDq9il9hMB1f4C
 9oOolHk5Fr8eYITeIZa7Bmk4XNgJ3iYq0Ga7VY2AiaXca6rIdxi7W7
 AXvGeiFrIzJkg2+WBMxVdTEOGQtZp806HdYN2akvaQTsBBfFrVYQEj
 joOeQJIrus3w7YjxQcev0QsAYyOBkhVmGMVPh0ybaDneCTBLAmLpdp
 NUlV06liHRe0qW8Hgy77zvXq9VgfMciPryGtdo+dNtmg6cdxbJ4Et4
 7xPVL7xIvxSS8A875vww/ITn3h/zX4KsQTJmBPqXUf8yfOKOpISJzu
 e6piHUz6s/BND0nft8l6baJF8VjX8LA2HU3HA7DEGY45Fuync1JJXp
 sOt+M5O6iWhPWddS2HRxkd75J3xl8JfPVqcQrk9x56TJc9C4OBq22i
 oD9cd7/lV+jKfeDVeuW76YLeofbdflhf+IQ9RQAidwz/Ac+HXw/UBw
 AAAQrVAjw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0x
 NiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVm
 Vyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8RW1haWwgU3RhcnRJbmRl
 eD0iNDQiPg0KICAgICAgPEVtYWlsU3RyaW5nPm9sc2FqaXJpQGdtYW
 lsLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8
 RW1haWwgU3RhcnRJbmRleD0iMjAzIiBQb3NpdGlvbj0iU2lnbmF0dX
 JlIj4NCiAgICAgIDxFbWFpbFN0cmluZz5hbmRyaWkubmFrcnlpa29A
 Z21haWwuY29tPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KIC
 A8L0VtYWlscz4NCjwvRW1haWxTZXQ+AQuyAzw/eG1sIHZlcnNpb249
 IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPFVybFNldD4NCiAgPF
 ZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxVcmxzPg0KICAg
 IDxVcmwgU3RhcnRJbmRleD0iMTEzMCIgVHlwZT0iVXJsIj4NCiAgIC
 AgIDxVcmxTdHJpbmc+aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
 c2NtL2xpbnV4L2tlcm5lbC9naXQvam9sc2EvcGVyZi5naXQvbG9nLz
 9oPWJwZi9zZXNzaW9uX2RhdGE8L1VybFN0cmluZz4NCiAgICA8L1Vy
 bD4NCiAgICA8VXJsIFN0YXJ0SW5kZXg9IjEyMjQiIFR5cGU9IlVybC
 I+DQogICAgICA8VXJsU3RyaW5nPmh0dHBzOi8vbG9yZS5rZXJuZWwu
 b3JnL2JwZi8yMDI0MDIyODA5MDI0Mi40MDQwMjEwLTEtam9sc2FAa2
 VybmVsLm9yZy88L1VybFN0cmluZz4NCiAgICA8L1VybD4NCiAgPC9V
 cmxzPg0KPC9VcmxTZXQ+AQzyBzw/eG1sIHZlcnNpb249IjEuMCIgZW
 5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJz
 aW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogIC
 AgPENvbnRhY3QgU3RhcnRJbmRleD0iMzMiPg0KICAgICAgPFBlcnNv
 biBTdGFydEluZGV4PSIzMyI+DQogICAgICAgIDxQZXJzb25TdHJpbm
 c+SmlyaSBPbHNhPC9QZXJzb25TdHJpbmc+DQogICAgICA8L1BlcnNv
 bj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFpbCBTdGFydE
 luZGV4PSI0NCI+DQogICAgICAgICAgPEVtYWlsU3RyaW5nPm9sc2Fq
 aXJpQGdtYWlsLmNvbTwvRW1haWxTdHJpbmc+DQogICAgICAgIDwvRW
 1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YWN0U3Ry
 aW5nPkppcmkgT2xzYSAmbHQ7b2xzYWppcmlAZ21haWwuY29tPC9Db2
 50YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCiAgICA8Q29udGFj
 dCBTdGFydEluZGV4PSIxMTkiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIxMTkiIFBvc2l0aW9u
 PSJTaWduYXR1cmUiPg0KICAgICAgICA8UGVyc29uU3RyaW5nPlN0ZX
 ZlbiBSb3N0ZWR0PC9QZXJzb25TdHJpbmc+DQogICAgICA8L1BlcnNv
 bj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFpbCBTdGFydE
 luZGV4PSIyMDMiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAg
 ICAgIDxFbWFpbFN0cmluZz5hbmRyaWkubmFrcnlpa29AZ21haWwuY2
 9tPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAg
 IDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+U3RldmVuIF
 Jvc3RlZHQgd3JvdGU6DQomZ3Q7ICZndDsgT24gRnJpLCAyOSBNYXIg
 MjAyNCAxNjoyODozMyAtMDcwMA0KJmd0OyAmZ3Q7IEFuZHJpaSBOYW
 tyeWlrbyAmbHQ7YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbTwvQ29u
 dGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udGFjdH
 M+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJpZXZlck9wZXJhdG9yLDEw
 LDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0RG9jUGFyc2VyT3
 BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQ
 b3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3
 N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFu
 c3BvcnRXcml0ZXJQcm9kdWNlciwyMCwxMw=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 3103
X-MS-Exchange-Forest-EmailMessageHash: B1968A4D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

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

X-sender: <netdev+bounces-83537-peter.schumann=3Dcunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Dc822;peter.schumann@secune=
t.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAPWsFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 12095
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 04:34:59 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sun, 31 Mar 2024 04:34:59 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 141EE20322
	for <peter.schumann@secunet.com>; Sun, 31 Mar 2024 04:34:59 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OpKISkofR2pT for <peter.schumann@secunet.com>;
	Sun, 31 Mar 2024 04:34:54 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.199.223; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83537=
-peter.schumann=3Dcunet.com@vger.kernel.org; receiver=3Dter.schumann@secune=
t.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 8423120199
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dy2AymGs"
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 8423120199
	for <peter.schumann@secunet.com>; Sun, 31 Mar 2024 04:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A61C20B9E
	for <peter.schumann@secunet.com>; Sun, 31 Mar 2024 02:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234410FA;
	Sun, 31 Mar 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dy2AymGs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166=
.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384E1396;
	Sun, 31 Mar 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.166.50
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711852487; cv=3Dne; b=3DMqKNBstHic1NnNqtmEhklFX98fH400WfQDTFyqhKjtIXY7t=
Rb0YqsOvtGOZyXx0wEWKPJAKd86o+m1j+A6/1WE8pCEXzgUX6SKfC6W0ezZ25Rzsz2fAVlUyUeM=
5EEuntcuT+ehdeWbAQcf77zyAw8axusWoE4oQeU/ECfd/vEARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711852487; c=3Dlaxed/simple;
	bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DzYeAGSaMyIjDZPlrwMo3hgPPsMOffRH8URPmCTR8dQMZhq7GO=
//lFDYMSk6tPcMuQTRTFRf2OrVj1ugqK0lxJM3vFBFuu/N7HMnZBcdqNyXGtnkhCp/notTFUWHO=
F2ByvyVCUhghBbJ/tO3SGu2dV2uOZN7pwqyGJffONCsRkARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D2AymGs; arc=3Dne smtp.client-ip 9=
.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc01644f51=
so159554639f.2;
        Sat, 30 Mar 2024 19:34:46 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711852485; x=1712457285; darn=3Der.kernel=
.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
        b=3D2AymGsN5lMSc1UzWBQqYEmctJu9hcEFMrLk1EvVIPUQ2vRWGvrki52sw7v23NLN=
y
         PJRpVeNV/9llTQ9/EMyMHfhE3PGEFhw1ToIkfDHcu4G1MtDeAmPMGmvoQVD2ytyOBf=
P9
         1k2Xm1jfRY4gUYOSigq2OoU+Ho3HoOiPnoIQxo10pvq1GTvxA/OcXA+fq6TRplYNpR=
Ap
         fdai6ZVFdNN0dNmPdfkij0KZIsOnGnXl0Cln4cRXfOqX51cSkigiXGyKO4QieVXSKS=
XV
         CUYMuTkl3aX2Q2MAX4cEY+tEewnezwTFzF6/t0lpTHAi4cbvhL5i75u/2uT5rVPpvl=
4n
         4IGQ=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711852485; x=1712457285;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D26OU7eK1E3sOOfCTy+tBkXi+05uIIvVJ+TP4hGj4w=3D=0A=
        b=3DUmY+KCUxxZt/KqUHDvByexlAZtEIH4XrbOIIDE9I6XBIVvHCTPgiV21Nr3oWYET=
5
         4yi797sJtaxzpP3l0L6AfMJZE1jq7q/JletLXiVED8JM2Mkgmh8pgemMqK+pjU5snN=
qj
         4SmAIY9xpkUFJTwb6KQRCHmClshfbax662MBwNLdyc71cKI+Ht6zOLscmyap13Cm8J=
dl
         Pvwlu0PYjCt12ID8IEZH3heQS/YN134MrRK3B4SP56jTUo+ckVMsH43yk55Yq86rvU=
s/
         gxA5UuIqE4dGMSW497CceIm6gFxtwaAaA60xM1XmcEKkoJKn5MK0/KWEaiB12sZMfu=
DR
         xm/A=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCW84S9V+AQQkYp+0Pg3uFJiqkrinKOD+cj0jo9RwHY=
KPgQTM0ca31x7++jsQaCnCHVrKhB4AZsrCgxGVc8F2iXDhlG9Twpbk1TuCelrLjExzQK5aDvFn2=
pyX1jXjUlDgWGnQskZ+ly86pfRZuSc6zLRTs1VtmYF1ktL1pi43uQwDvDiil12jcTRLBPiIPHnF=
nT4xag5EJJM5dDha3MF/IDYBm+KEn5/IQcomA3GYVFHVuXIiU3syvBp4mciUubTWnoJGGoBTfuV=
BZ+umC0D3La4taNF/wXygvGVcQ=3D=0A=
X-Gm-Message-State: AOJu0YxBCqzw8NXdwxSkflidZiBTQf2FxMt5MAFfeqN8T6V6IoSKYHD=
r
	LtNNbixGctgBJMaMxDf8ZKejURE+MphiwvxQexQkxWspvI/JgsQUap7XnuBlDVsr+sE+TBpgAT=
D
	eqRNYh5vFsGTaYQ4ptCAJ0U5K7iEX-Google-Smtp-Source: AGHT+IEUljvEWt6RLJvm0ZvD=
NAAvbKF98d8W07FBneubUp0ru50ICaCtTHNp6cmd+wxEi3ZRk7j/LT8mS1rRQW2OsKcX-Receiv=
ed: by 2002:a05:6e02:3710:b0:366:ab6f:f63 with SMTP id
 ck16-20020a056e02371000b00366ab6f0f63mr8646788ilb.3.1711852485494; Sat, 30
 Mar 2024 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail=
.com>
 <CALz3k9icPePb0c4FE67q=3DU0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=3DJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=3DmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=3Djt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CAEf4BzYgzOti+Hfdn3SUCjuofGe=
dXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
 <20240330082755.1cbeb8c6@rorschach.local.home> <ZghRXtc8ZiTOKMR3@krava>
In-Reply-To: <ZghRXtc8ZiTOKMR3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 30 Mar 2024 19:34:33 -0700
Message-ID: <CAEf4BzbOAwLZ9=3DMQo-W5oHxTA7nM5ERRp0Q=3DhuC8b+Y1Ww@mail.gmail=
.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add suppo=
rt
 to record and check the accessed args
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, =3DTF-8?B?5qKm6b6Z6JGj?=3Dongmeng=
long.8@bytedance.com>,=20
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii=
@kernel.org>,=20
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net=
>,=20
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song =
Liu <song@kernel.org>,=20
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gm=
ail.com>,=20
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Lu=
o <haoluo@google.com>,=20
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntra=
eger@linux.ibm.com>,=20
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.ne=
t>,=20
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com=
>,=20
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>,=20
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,=20
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kerne=
l@vger.kernel.org>,=20
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger=
.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kern=
el.org,=20
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, l=
inux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83537-peter.schumann=3Dcunet.com@vger.kernel.or=
g
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 02:34:59.1620
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 84b93fda-0cf0-47dc-3a87-08dc=
512b28ea
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=CAs-esse=
n-02.secunet.de:TOTAL-FE=3D011|SMR=3D011(SMRPI=3D008(SMRPI-FrontendProxyAge=
nt=3D008));2024-03-31T02:34:59.174Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 11546
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3Dw
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

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


