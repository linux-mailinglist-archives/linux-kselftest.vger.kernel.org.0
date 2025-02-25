Return-Path: <linux-kselftest+bounces-27465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBEA443BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C5C18976C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DDB269AEA;
	Tue, 25 Feb 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcpfU73g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1F2686B3;
	Tue, 25 Feb 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495332; cv=none; b=HGOOvyfmiW4UD98DKy7dg7R2yXswmpE2PboULqQgCIIhVs0uLH8e9tUQnElZpjPDutTmGzjGAid3zYSmkm0UnDams01mHar20UNG9mlWe9asr3Vx4RDKdm7QDRebqw97l3J7dkXYzZQYcTVEHkXUxmReKqBXBDs6iYA2KjpvD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495332; c=relaxed/simple;
	bh=r/ZZoZr2ULO+NtzPA4njXHi/b/AtJLxzrOEJzxEhTEk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S+fbNZd/r8RWGCqhPZh1g+1P/2MFb8g1y7OutIdboJ6YbOFr1gdhfXH9xIFrj5M6imHSYoWgJzIMXx9drv8NrO1pNGuCeGJ00fX1HjSD8+QpjSqRfiihoqrgDNE3C6lQjEQriMpSpFzs5hQ8OPx+ILqsNVwqGOmF+NHLBpWXRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcpfU73g; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c2303a56d6so227492985a.3;
        Tue, 25 Feb 2025 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495330; x=1741100130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjv1BVttWy8yEf+ech4rBoic+lPnV1nxxM8d9pp6mDA=;
        b=OcpfU73g187VXJUQSlVKjrMQCgHwblswuei4zVS2NgXEQ83pxB3lIY/rwISqaFbft1
         RZMgjRuLyqHBN9CjAwlc3dXd2lc5eIhaVki/vFZSrf7C9sRzo98CM72/5nPkidq/IirI
         fHFDPgQYWBgllyHwSxA+cRF4sGEtKMVx7mCbJsGJHWDs6DeaXO345nlZZ2kg5yQIxtig
         BUdfvZgLh7Cp4AQLiMh8G5bvz39GGY/fsUCLYIgSypCAc3hR5f1hGppWHlnFBgq4pGiZ
         P8PKwn2/sNH7jYj0AfGurF95D232LKonJZANxVRbl6U8k61e6GdVIdMoUa7BmKy7IDC7
         CnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495330; x=1741100130;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hjv1BVttWy8yEf+ech4rBoic+lPnV1nxxM8d9pp6mDA=;
        b=Ml7p+5Ncgw+A3EPjvNG1nvi68WXisoRfxtvErWDmKEIgqdv1lbxdMctehWxADGEkoE
         BIlLvF6cTU/RqR3+wLeamBuaws1BF0Zo8KvNKFKRg+d6sl4T/jQWdy3xlS/Mm7DBzavW
         70bYlTdm4jcgsUgBatnpVxMmhRtB3lo3VmBrxYubS1is3YQl2LpZErhA6FC9b2lOh7gb
         pkZPsX4cUuHeue4SnrvjBAMDuXya+IYnQGtImQOe2cvaa904xemdQDGqTEKCG3vkRgW9
         ok78agWyMfeeEctQZnQYiwiGxs1IWl8n9nJ3i4YB6g5mQfkdXvjkYsvAadG5SHT5jQIs
         E9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbZxPW65Bqb2JsIaAXsRYLCfRzMGsAgvbG0MHumTy0dFJbOnWs05j8HbBsOOzczfPx6ln5rkUX@vger.kernel.org, AJvYcCWzh6tvm9HVns6TpZ+YADSZZVr3pmEylVkPac+AihT6TKAGzfvFniV9DZfuZbVSZFiLOTUxqLcA969hWppM@vger.kernel.org, AJvYcCX4X0bj9/8sNyI5OiYxYpPBojbOTYtBig6WbrulE8QhRL+KBQkI/NDSHwy0jvRYJyL1Z8U=@vger.kernel.org, AJvYcCXFdlnsTzgyLAy3F4Hq/HwREP9imqL61hpwklMoAzx0YIOnOYeOJ1cIc1z1xt+8rrP9gKlZGeSzC4kSbr36tsOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5uOwp9jGcZ+a9JB6wGosCczYiR8VnUSpI70lWdNwsHyyTy4N
	IU7WGjHtvXQMFj5VOCU0uWf6ciVWiWxSi0CKyJaB1z7loNldvp9G
X-Gm-Gg: ASbGncsQiZa8ahrECZYQRZ9rqV8alKjOtMWghzyLOkO9ttC5wypI8sxADLscOFiyWti
	7uWxQW2Moutr8lpiQe5hhCJg6HxYvgA2LL3LYOSFmL4Y7eZANzCX0HgKviT9dM/huGRj7XsfVP5
	KnhbXrBPWQEd0MiD5QNtfqRQZVJJQHAqpuxBObThNAU6G4dMrSclwPd80bbAaAV2KJLuP1H+jpU
	MEKPXJ+hZUCXIzsQkjz2Rq6jGyjDuNox1Bh64i4iWhQbQ3NOOO75G3bPtumhIWMCIXFfnJdCX98
	KBxS0zBpkPk4v/rED9sgdmrUDTfmprNlscn53vQwr6xlQnGws9IUP6CEhGpqnCdlYvUNQqkrJHA
	llUI=
X-Google-Smtp-Source: AGHT+IGjv2NvDrduope8pvx/36i17irAfSvtdZpt+ljFP0O7tK4Zc2qgfkUk4vwB434o/1wqwg4SIA==
X-Received: by 2002:a05:620a:800b:b0:7c0:c264:6737 with SMTP id af79cd13be357-7c0cf8b015emr2386412885a.4.1740495329747;
        Tue, 25 Feb 2025 06:55:29 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2c2925sm115007585a.61.2025.02.25.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:55:29 -0800 (PST)
Date: Tue, 25 Feb 2025 09:55:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67bdd9e0c54d9_2474a12947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 0/6] XDP metadata support for tun driver
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> Hi,
> 
> thank you for your reviw. As promised, here is V3 of this patch series.
> 
> I noticed that the updated selftests were flaky sometimes due to the kernel
> networking stack sending IPv6 multicast listener reports on the created
> test interfaces.
> This can be seen here:
> https://github.com/kernel-patches/bpf/actions/runs/13449071153/job/37580497963
> 
> Setting the NOARP flag on the interfaces should fix this race condition.
> 
> Successful pipeline:
> https://github.com/kernel-patches/bpf/actions/runs/13500667544
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Please don't add tags, unless a person has explicitly added them.

And they are only sticky when the code has not been changed since
they added them.

These are only in the cover letter, so not picked up. But for future
revisions and patches.

I'll take a closer look at the actual patches in a bit.
 
> ---
> 
> v3:
> - change the condition to handle xdp_buffs without metadata support, as
>   suggested by Willem de Bruijn <willemb@google.com>
> - add clarifying comment why that condition is needed
> - set NOARP flag in selftests to ensure that the kernel does not send
>   packets on the test interfaces that may interfere with the tests
> 
> v2: https://lore.kernel.org/bpf/20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de/
> - submit against bpf-next subtree
> - split commits and improved commit messages
> - remove redundant metasize check and add clarifying comment instead
> - use max() instead of ternary operator
> - add selftest for metadata support in the tun driver
> 
> v1: https://lore.kernel.org/all/20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de/
> 
> Marcus Wichelmann (6):
>   net: tun: enable XDP metadata support
>   net: tun: enable transfer of XDP metadata to skb
>   selftests/bpf: move open_tuntap to network helpers
>   selftests/bpf: refactor xdp_context_functional test and bpf program
>   selftests/bpf: add test for XDP metadata support in tun driver
>   selftests/bpf: fix file descriptor assertion in open_tuntap helper
> 
>  drivers/net/tun.c                             |  28 ++-
>  tools/testing/selftests/bpf/network_helpers.c |  28 +++
>  tools/testing/selftests/bpf/network_helpers.h |   3 +
>  .../selftests/bpf/prog_tests/lwt_helpers.h    |  29 ----
>  .../bpf/prog_tests/xdp_context_test_run.c     | 163 ++++++++++++++++--
>  .../selftests/bpf/progs/test_xdp_meta.c       |  56 +++---
>  6 files changed, 230 insertions(+), 77 deletions(-)
> 
> -- 
> 2.43.0
> 



