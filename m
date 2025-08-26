Return-Path: <linux-kselftest+bounces-39939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFEB35A08
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BAB2A8036
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817622BDC2C;
	Tue, 26 Aug 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkDLulOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EB1514E4;
	Tue, 26 Aug 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203844; cv=none; b=u4R1AA6d1VtrXJxQyrfdeb4dzOvIShpzbd2bckCjqJuVVz/V6YPzSPefBqXzSfpjd2EbzrRCzSUZtSwp5BsazklVQjYa/PFSCpQGYlrbn6WW2dge+K+76sItgLIrJn0j8EI6hkeAOyCcFCjDIS57zxyeZdRR5IQIAkDx38Mk8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203844; c=relaxed/simple;
	bh=V5nVH9kggGN3ZNMTkOuHzNnVaaPn/QaM2ccMbZfahso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlxBO3klSjkIrcKpoCBeA2/bm7w39f5mnWuCc0V6457FklULyGJR21wNNPJxuUuHJ+mNdnQZzNqwCGJl0dGoy9F6dP46ot92PiBwHcvmR4IgEfwzuoHoSKWlvB1xcaaXELqRgQ8MbhDLXfc2XMkvfkE+yy26aq1HuDmw4lEeeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkDLulOv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so4011124276.3;
        Tue, 26 Aug 2025 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756203842; x=1756808642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpxekdYluNHvQnP3E65nORQc3gyYRQYdWHU33qmvF4U=;
        b=SkDLulOvpMPYloRTw3ljWB5PfyhS1CX0XYRJZWwatrRO6OfSTcM+H69NTDjADAO7iA
         L0mZfPw56l5dEfAX1C62DvAM9VRK23+R8gCvQYcAqEV6lRE7qnjIHgkQolFKf8fCYe6D
         +C/9MgxTmY8P3pl2uC6x7s6aWnEsK7W8YZYbjuM1N8h5o4EVLP0Z2h7HEAzn3CQr665n
         j5X61o6Ttu7536YWp6ISmLYllL8EKx5fIhxbpU2jQrZA+1EcURe2zbtUEQEPFd2LKUhC
         b+WksT+OhmPs/2OaLOPRzK7LcTStW7FLOnjuD6L62O5WYgDAUrBW6kNVK1t3jJlxaLvj
         HG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203842; x=1756808642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpxekdYluNHvQnP3E65nORQc3gyYRQYdWHU33qmvF4U=;
        b=MC8rD9kC1OC22RP17EzqDlOSLlGJBoCFIZLc/snBug7CVyIOFobYm0nAXjzVzWqyfJ
         KzebbWkowImEOodPF/Zp6yY0PkZ88LAI9moq/Vy0c49M4Biv4I4tbWKl2/w+6GvIwifl
         gqEUHAqCAP4z2pIgfqBGO7po9Ls1KNHeYB4+spkpooHzIv32FBQo476AaXfmben0faKM
         gZd1MjLkrSTgSBWpJ0H/A3BQHAXJ0axOWUQif8evhpJBD3rC0sohcBlk8O8WvshYxG3/
         /ys0rWGj4SdIB92MYcdo/frxYdzOWB2Af6LXeP4uP+aFtbWSqSA+D7ug3n9fJB/ju11D
         Hb1w==
X-Forwarded-Encrypted: i=1; AJvYcCVocoTZ80iTiPfylaCJ6dPai6GHuPWuWOO/0y8j5RC9wrvz6sS6xqIls2NZXU2OR1z3yxHIZj/ykQdc07Y3r/Fa@vger.kernel.org, AJvYcCWAWDT1LdMw06PlazFYum+87D4uySjYtSy4VxkX4AJyydFZ+/CINl2wkQPcpoOjJjdpZwpnloYtTg==@vger.kernel.org, AJvYcCWolxGPgDIxy6s9HMPlo2kN4aOaCnnxLMWczTPMiq/JhQoZKTUIrMRXEgdj4FjIWVtab8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI13yqUrjJ97qtIHGbggGLOSmXZGu1kXxI238Y59XW/riZJNVm
	spp4hjtr05RSyOg1+32btgomXJnEuBNVl97vcVUlvSnlK4oSzaI7kWG+
X-Gm-Gg: ASbGncsZ3GjhBJK/mINw8OPp1Cf1bOrDdmnWcyypq+QD8qNaGLjdsLnBH8YfRmcu/+r
	JeY9e69bbACElJ3w4JloGszpxzltyXw29KBAYgZwqUGnfeYSNrG3ABeIz1Z2KCzS7pWCD2DUH6F
	hQHPaoMBGpDi8R9Gcqsfkc5qtsuFtKKpgmzLSdb6NwbGAT/6u4CXWfVD8VD/dKd2+wAYwZ5su1r
	7o2xUuOl1WZJK8fXk5QGjvtvVvM3BcYMxsu3MCnbzaeGBp7LTXmC5LMtm6oGpPaT/D+9L4rEa9b
	d+Z43VpqCzknTgzFkywwFXQHoEOCVhz1tSDZODuwVY43/csXHMwc0RM+wsAG+w07syeLvmIbOXT
	mwIe5yq9osHppg+E=
X-Google-Smtp-Source: AGHT+IFomDZUfo1A86VwCZ5Jkb93juw3dch9/oyj9hrsql8HA46eoNWE4iuTr2OnGnF+w4r7cZ0+GQ==
X-Received: by 2002:a05:6902:1542:b0:e95:2bde:4965 with SMTP id 3f1490d57ef6-e952bde4ba2mr13453799276.23.1756203841635;
        Tue, 26 Aug 2025 03:24:01 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.98.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c2591ddsm3178245276.5.2025.08.26.03.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:24:01 -0700 (PDT)
Message-ID: <38e3bdf1-2d01-4d92-80c9-09ab806e9dec@gmail.com>
Date: Tue, 26 Aug 2025 11:23:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tixxdz@opendz.org
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
 <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
 <aKUhkIdCEsIqmvvV@slm.duckdns.org>
 <efa7d1ed-9cfc-4e32-936c-a2f7827da1c9@gmail.com>
 <aKywEsqVAHdgasZw@slm.duckdns.org>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <aKywEsqVAHdgasZw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/25/25 19:48, Tejun Heo wrote:
> Hello,
> 
> On Fri, Aug 22, 2025 at 07:16:15PM +0100, Djalal Harouni wrote:
> ...
>> I do realize taking the same usual path with write is the obvious thing,
>> but we don't have the corresponding open context, and faking it seems
>> more trouble than calling directly cgroup backends...
>>
>> Allow me please to do it again directly on cgroup_base_file[] assuming
>> it was Alexei suggestion and see how it looks.
> 
> I'm probably missing something but what prevents you from getting a dentry
> from kernfs_node and then calling vfs_open() on it and then do vfs_write()
> on the returned file?

If we include the open path then don't have the right context, first
example in vfs_open() will use the wrong current cred context to perform
permission checks, current could have dropped privileges while the
cgroup hierarchy is still root owned...

The thing here is that the bpf program will be called from arbitrary
paths, not a single pre-defined path/function were we could control
the context...

> If there are some fundamental reasons that we can't do something like that,
> let's go back to the simple approach where we just have bpf helpers for
> freezing and unfreezing cgroups outside of fs interface.

Alright, seems Alexei also agree on this. Thanks will prepare another
version.

>> Also Tejun, could you please point me to extra cgroup or kernfs tests
>> you run? much appreciated!
> 
> I'm afraid there isn't much outside what's in the selftest directory.

Ok, thank you!


> Thanks.
> 


