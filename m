Return-Path: <linux-kselftest+bounces-6765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FF8907D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBCE1C29279
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901C131196;
	Thu, 28 Mar 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbH0VmiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD22E419;
	Thu, 28 Mar 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648731; cv=none; b=p3U/576+mjN6esatUMq6i6AIzOQ79+kq1aWnKWF99qOuhNpDxVPthFmAyUnP+BCqxMZJ2r46D/YdHjirS2qlpugF70IXI/Y2Emg4DWjb454a/cdErGzKTnmZ2aUq7h8qqIFVnlCJFtQ4so/OBM/GbE8w6fUjBDyPdV3zC7qzH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648731; c=relaxed/simple;
	bh=eoW/Ol+Fztd1pjIFLPvuQ9Q/3JpA1yu2NX4LAFYFqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AivFopBkAaiscBtQKzFysWhak/9B2Tm/AzO3fbHPcGmNOnX57uY888xXf3CA3bDdAvswtUuOm3lW+A7znhh9aAs10PljAJD8DAZ1lxgeE59mSW9lRkkbnyu1ahtKjei8mm0+RKD946GSpxQAPhUZyM7w2rVj4ZKfVrA1TxPUVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbH0VmiL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ead4093f85so1219499b3a.3;
        Thu, 28 Mar 2024 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648729; x=1712253529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTZjV+7S2zxd1Kd89MiyQnHfAcCtg3m3Sh+mN+X+VE4=;
        b=cbH0VmiLQgKd6eGr0Ib/dvR9ScAd3mNzQEY50dN/F5Z6sTv6qjZME5s2yjJnKJBdyv
         xXeGtTmd49rRR4+k5CQQalJnuC6eLSEu9sw1E/+i0GlbrUIYAOUbAdWEmqCjZsPoyl7+
         Gh85J53btlYHnXcke29bFI0dmaafkmm2rCmfNlSU4NzIhByNbQbC+FvgEpNJ0Y5j4WjU
         xMHKJiPyv1O97sR3D5czMH8UC4HUCAso3gwqij6zKpnD1DhThEhIZUVwPt58mv2slHHK
         H+cSV6IYQwjT219q9+CXGmp/99yRiElJOSciSAjtQJwzmsIahed0pAZYUJSV3s4LmCcJ
         EcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648729; x=1712253529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTZjV+7S2zxd1Kd89MiyQnHfAcCtg3m3Sh+mN+X+VE4=;
        b=SUAyfc/n1T1v7gM+EpHrTPXm1+66T/OODCna3XTorSJHSow7/oHeGPQgZP9KhCgk35
         6M6iHBpxVE1/XL6YCJGG4e+Ho4lp+5itDzdgaPgv9McWy4l+Ev/wmYNt0Mi+0o+2vaKm
         /CcX7LFpAPVcGaPaEQ+uzLUHH4HXdHuMggfNHDpSkgfDNu3nncUgckp+asg02jV1gZVf
         TzInCC21Yjwkf3Cp3adt7aJfcMi+A8p/4VgZGuojtBimUubvNNqd3ClyY/Njpt0S1DOV
         6kRBoEleVv1P4ftPHL+nl9GKUFLtdUZ5b8soLirEPxLFnjdi6j8p87ffNaXPDS3/3swj
         UIyg==
X-Forwarded-Encrypted: i=1; AJvYcCU5K48kIiuJhN4ncih6qIZL7k+U9aOHg5K3r1yZJNB9MSWch6sIN6QAkPNNpobjxdqE40Ku9fPqV88OLGNKIhYGa//cKif2yTHXERltE6keMiTlx+2tmWvWEgpra/4ZQOqaLgX/wssX/DHcPgjOy7/Yl4qyCSG665V0KMF6phU8PYT7jipZTa8Rf7mYjGDIY93fe4TQo9ltBSh8Aw==
X-Gm-Message-State: AOJu0YxzA1/EtY2JrFfMMu+ask4cs+fsH0LQJrld7/vINPFn2FD28VSO
	j8OS/QW59D5R9jGx4Z+nj9TzV7cjiIJ2kg0nPFZ8sciKa9PrvWt+
X-Google-Smtp-Source: AGHT+IH09lCUtZaPss1VyFYl40VeAXb9We1fTAAJJrYddWEHb5BMLEhDDxsPchyUikJpWi2lOU8z8Q==
X-Received: by 2002:a05:6a00:a82:b0:6ea:d10d:c96d with SMTP id b2-20020a056a000a8200b006ead10dc96dmr4950pfl.19.1711648729400;
        Thu, 28 Mar 2024 10:58:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id k24-20020aa78218000000b006eadd0f4803sm1282084pfi.206.2024.03.28.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:58:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 07:58:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <ZgWv19ySvoACAll4@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>

Hello, Alexei.

On Thu, Mar 28, 2024 at 10:32:24AM -0700, Alexei Starovoitov wrote:
> > It bothers me a bit that it's adding a dedicated interface for something
> > which already has a defined userspace interface. Would it be better to have
> > kfunc wrappers for kernel_read() and kernel_write()?
> 
> How would that look ?
> prog cannot and shouldn't open a file.

Oh, I didn't know. Why is that?

> The seq_file would be passed/pinned by user space?

Would it work if it's just "open this file, write this and then close it"?

Thanks.

-- 
tejun

