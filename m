Return-Path: <linux-kselftest+bounces-16881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96960966E6A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61951C2198E
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D320326;
	Sat, 31 Aug 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqZNyOsg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE43FC2;
	Sat, 31 Aug 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067502; cv=none; b=d/bxkYcq1BQtLoL42Kv+whdWDKV62gw50NwutvAz7Z0PPlP9zfJyCLbrjVOiMb5TqYLSXfSXXUMlqmoP/qLLlcFPGm9dgw3BsOzb/jGeaVhAs8KACv8/GVPpJMfyyj5ng4e3A93RpC+wUYFrxPCHyGlkEFu+Qekq3eQjC08yUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067502; c=relaxed/simple;
	bh=WaQjz7IOjBiEvHs8LC2W3ui5sG24VxmEhanTFTSMvwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PexBX5Q1bGxRSlVHBdHZmbGF3t/MKQNJiqggPNipn676RwhuNYq21xWyYVcwK0C/i3hSadIbEm3R/gijGYJxxiN4l3RnoI2IFR9oOkD3aY02Ln71SrBvLHeGv2O+dPQmCQZIZbxeOQW0xH1uCDClDuwxKLMAR6oHhuSwS0Qbkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqZNyOsg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so13698715e9.3;
        Fri, 30 Aug 2024 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725067499; x=1725672299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaQjz7IOjBiEvHs8LC2W3ui5sG24VxmEhanTFTSMvwc=;
        b=NqZNyOsgDWbobWP1lRbqOYhimVFLtRmTIbfe19rKaQ7AwNoX6I8/geT4CSLv/N6LQ8
         KxAU2/byljn32Wrw2Tfp4HC0YRjK7RKLCu2i8b6V7i1xYpF2fKwfkji9Jb52IOjju/xW
         GCEdbN8prfd3hcM0g1TI8ftzCmS/0zWEZVuWmD7csZCOzGAULXszIxcSv8KpK3hTiomv
         IupkpgUqfnyoCGa4Wbmm3pj204MZMGN+aOipE2xu1Zyu7vSiHdZ9YiLIZAawZsqK+QfL
         XhNx51a9/+M78+8KJBlN513Hm5pJ/JMGmhJg7/iQUIcfVgTW1aPyQ+FkO6PSBz/dap7G
         wAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725067499; x=1725672299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaQjz7IOjBiEvHs8LC2W3ui5sG24VxmEhanTFTSMvwc=;
        b=UFtj/dKAREwemd69QDRM2cGD0UPTODUaYpmxIGF0m/oX47Q0HaoL+tMPUQyikCAhXa
         SqpXgEvCRHLUKkCt9i7qu/6LvKMOG5CwKFg82G4Gzp8Kxne4yez3wxdfIMH73lioCOEi
         FZCRLFAeHAUEk6/9NhkjBt+MMqRLcUPMpMn/hvn+CuCqlD7R2ZTWvyU8iDUPXiiEHL75
         h8NCOfHQ1llMl8x2chhlTCZdMme4lN4uoh8w7krJdZWHUZZW8/hDwO5zldBSbZl/f1YB
         m+JZzgj+AQtf+VrdEKFuOwLhL09GiVD7+yWTponS4OImeXRnle8L/YDbD+PqaDXxjFeQ
         ix9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF7jHl9/uF19IHtge49WP14G5SmnLzIY53jt6OZvg6avz5GRUMX7smy5f8cNDoNtUiCy0=@vger.kernel.org, AJvYcCXk0cDzafOETtzNyhxPuh96oCN2RvW6sqBkqmzgLftbV4/dQ1w7WB5ytGlosROJdq11TYHaKFDN0pGbvx+ApEYj@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1DQLkxe3LM9b3nQMYj33WbQWNnXEIp03QmwkbwpLwklgZ6l1
	fiSvBT0WX4eUPypPZ8ntWmuijz0VWlf3orYfubtgvZWpg/7fOO44hyCMiFfCT3K0yvpDhmHZ/bZ
	AsyIfC/VPrAmrRJii2zCWcLakgGk=
X-Google-Smtp-Source: AGHT+IGQGBjeAPh61ErF4x9nVvcFvuT6g1jPWnWTMmXixDXQHdmcIoU4Sg7aRFWJH/E8jWWfzJ2DR605Db89ECdHQ1w=
X-Received: by 2002:a05:600c:4453:b0:42b:a2fd:3e52 with SMTP id
 5b1f17b1804b1-42bb02aa81fmr62369925e9.22.1725067499021; Fri, 30 Aug 2024
 18:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <ed17daaceb6fd12a62c7286958239bb34fc3f55b.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Aug 2024 18:24:47 -0700
Message-ID: <CAADnVQLXYL66nCYpRrMmeR0c-ANtUW-6d5SoEE76cjPb3rVBTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] libbpf: Support creating light skeleton
 of either endianness
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
>
> for the rest, Alexei, can you please review and give your ack?

It looks fine.
All of the additional pr_debug()s look a bit excessive.
Will take another look at respin.

