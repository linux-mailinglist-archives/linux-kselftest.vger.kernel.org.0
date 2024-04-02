Return-Path: <linux-kselftest+bounces-7005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E7895B9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B271F22EB3
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157EA15B101;
	Tue,  2 Apr 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXEWBeks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539015AD8D;
	Tue,  2 Apr 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082055; cv=none; b=bgurQEP7b89OBAvZ7sCWDT3qj+qmyFTi7HyDtqMDV+8VN2ebiAvvfnujk7IZh2fa4CZIw2nzwm1Fcnog8A3cMb9qTsBuhlP8oOTrrBByODH3GWCL8FgW+/kNZoRXllaUBWKNREi3+3z6QTnschQr5M9T7WnQYQ6Qdf/2tmNFGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082055; c=relaxed/simple;
	bh=zv7sHKFkjNevE/UqWToiX8FmogO6sxuivtv/ibrNNXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YI50ILQF3doVAiYBSDY5dFBenoeXtNMpQklNEhREGBKzDk0vOjjF1vlOBRaAtZvPcTiSGpNTsF1SVEi9bfwXWiNxoBw/fVxrC0KQTuQCQXXuIPIR4DqrN7LGHZ8JICa8R3L6eATjfELEN13XOQVPqCaPGoGfyPLDANFvletPifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXEWBeks; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415584360c0so21876535e9.1;
        Tue, 02 Apr 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712082051; x=1712686851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCiVkwPQCDGfrvASyvu6t9tXKJzzMnM8zHvPzO/AMwA=;
        b=EXEWBeksImfeRSHMAf69o9CTGp5sPYwl2nt+2fYso1zzFlA1+JOi+zHxkA+8uIOGsJ
         VoSpeXGY4aQxrHDyxDmicnkObs8PRW+6GYbeZTvG3xrV8XKd4MJsDXP0ji2N86K2FJvE
         gZ0Z60STS+OUIllD7JZcZ2vxbRdjr/rT6VxJwkI42txqJRBNf7qDsDUIv8jpgUNSqs8o
         LhxkBYp7YW4/CXu3f4usjEp99j1QUDvUCk1RaB0IMpQVwkm3sjFxs+aZRbS7ZPGR7W3t
         eRCwtgeDgZK2SyZM/o3oBBNPXXM8ctM2vJ8NkBVabVQBxRvesnho2phfNvMpSI6IHRg0
         IN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712082051; x=1712686851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCiVkwPQCDGfrvASyvu6t9tXKJzzMnM8zHvPzO/AMwA=;
        b=Hr+MyqdyYgLkb2ugWDrZ2PacAWEg6IlhDqWD7j2VyyJQQQOrPNlAxmUqx27YaPS568
         LStDoxYx1LTD61vqdMq2JS43EXTsnsUBMGY5/gkPvY4njAUrOd9oAgzwaUsjo9vx5Ltu
         W7dvCpIXWPXrlBFevuJ0vRRorJ9UD0FQD81SmwgAoKmTGxrzP7uf/ouSoqFMEtG26Jon
         xdjcPrq1o/1OQKu6fOUWci6oDAer5kKMLkO7VoX2thWOfs96+qLGJDQbqYmPe0pBs1iu
         cR/AgyIjp5TOMQT1m0rK7woFMA4m34DM6AdBQXlB/2F3yhhNdOWE36nakuzq5+S6vtvx
         A43w==
X-Forwarded-Encrypted: i=1; AJvYcCUJPvvnnJQRU609ms0G7s+YXwy4NPZi0vjZPztQg8zR/YxHnVS69KLN9haoF4NSAagixYVGK7HMKji3FF1mcXBQQ2cCKVFQjLCjsJrRDK7JQo+5zPCZBM8RDD4GDsgHBhbcAmkr05FklcIWXfp/Gmja9CHY5tN7csQVMhkaXVsiA8VeHnD0lUp0gjEuZkIZLIeRsBj+ltVts43VyA==
X-Gm-Message-State: AOJu0YzsSkbUp+Y6iZ8CZZjYa6AucfAIM9UOcARLhM8xMn1OJovdp9DP
	9awiWrPfRdvN3qPFI9zHYS2/69GNi0ib/0TCYvKhNOxJhkZWH3BL
X-Google-Smtp-Source: AGHT+IH7dZM98T8LsIjrzMa4icTrHivRPJMZDMvbLYQyhm1OTnVSmFrT5rXdsQklfK67izIlApE9XA==
X-Received: by 2002:a05:600c:1394:b0:415:6121:5171 with SMTP id u20-20020a05600c139400b0041561215171mr5870525wmf.32.1712082049265;
        Tue, 02 Apr 2024 11:20:49 -0700 (PDT)
Received: from [192.168.1.113] ([105.109.56.176])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0041409db0349sm18761667wmo.48.2024.04.02.11.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 11:20:48 -0700 (PDT)
Message-ID: <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com>
Date: Tue, 2 Apr 2024 19:20:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Michal,

On 4/2/24 18:16, Michal Koutný wrote:
> Hello.
> 
> On Wed, Mar 27, 2024 at 11:53:22PM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
>> ...
>> For some cases we want to freeze the cgroup of a task based on some
>> signals, doing so from bpf is better than user space which could be
>> too late.
> 
> Notice that freezer itself is not immediate -- tasks are frozen as if a
> signal (kill(2)) was delivered to them (i.e. returning to userspace).

Thanks yes, I would expect freeze to behave like signal, and if one
wants to block immediately there is the LSM override return. The
selftest attached tries to do exactly that.

> What kind of signals (also kill?) are you talking about for
> illustration?

Could be security signals, reading sensitive files or related to any
operation management, for X reasons this user session should be freezed
or killed.

The kill is an effective defense against fork-bombs as an example.

>> Planned users of this feature are: tetragon and systemd when freezing
>> a cgroup hierarchy that could be a K8s pod, container, system service
>> or a user session.
> 
> It sounds like the signals are related to a particular process. If so
> what is it good for to freeze unrelated processes in the same cgroup?

Today some container/pod operations are performed at bpf level, having
the freeze and kill available is straightforward to perform this.


> I think those answers better clarify why this is needed.

Alright will add those in v2.

> 
> As for the generalization to any cgroup attribute (or kernfs). Can this
> be compared with sysctls -- I see there are helpers to intercept user
> writes but no helpers to affect sysctl values without an outer writer.
> What would justify different approaches between kernfs attributes and
> sysctls (direct writes vs modified writes)?

For generalizing this, haven't thought about it that much. First use
case is to try to get freeze and possibly kill support, and use a common
interface as requested.

Thank you!

> 
> Thanks,
> Michal


