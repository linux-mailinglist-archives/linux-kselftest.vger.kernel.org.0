Return-Path: <linux-kselftest+bounces-26824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E5A390A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AEF188C417
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE5146A66;
	Tue, 18 Feb 2025 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExNkLFG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9F182BD;
	Tue, 18 Feb 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843812; cv=none; b=agx7jqxpI4Q7iHTrgHj+MHjeVU1M5IAuKQqvxx2EOun39/g4hZ2Wuk2kB5D4y41BOpM0qmqd6a3GojCpXpWBTbJDjDseyojVbW/sebx9dyznHhXLB33IBBNI9iY43KqAcvLJq5IzEK0pqpC1Ye1flPh0JIJR/zZXx908u+gP+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843812; c=relaxed/simple;
	bh=gEIqznjAb5jsVOR2TNWPj6iGQ7+mDmd5lCc8sedBBB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aauiXuHReD/WuNungfjJmPFAMMyaf8kf9XbGwEEmm1WE+byzp4+nbOvlX9iVmWgzoK/WpVbnfQuO5d0F1PBlrveeUvEdrnkJQ/M8N/bvn9bq1btE2O4kV74M81LL3GYyGW897wAqkCgxRPAsyNaqPH2F5gBHL1fRdSFGX2XG7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExNkLFG8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6df83fd01cbso24375286d6.2;
        Mon, 17 Feb 2025 17:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739843809; x=1740448609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqZXNmfQaNC1fzv0a1Hp52rqSG635sNoXcS9SSB5SBc=;
        b=ExNkLFG8aCD/5ccEgV/JhFtThq+jqlfbNyVbjVQ0ZpqiXe0A0DWE7kGF94qxPaLKyu
         BsL6L00DWVAbdYHFF9k4Pr0foGwyWHsHHET0sYmic9Uq9aBH3zTrXEhZGics1g7ZsJ4V
         bzNKsI8Ers6zmFe/vvtVk7HmfLRNkcokot2eMRwBFEnXRm6Q5p1StGO4uFusAcGr+tSg
         XJY00BjEuOo8YBNO5G7AaLUPeVz6S9o87YR5XOlKGlwFheL5iWbTKvGDlys0VTqGdZHf
         WGKUIcYq2D/5rilDBXEzwDdOk63XMlZJDxleI7HGbABgrYdObGeKvmON0+CaokPajna4
         TEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739843809; x=1740448609;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GqZXNmfQaNC1fzv0a1Hp52rqSG635sNoXcS9SSB5SBc=;
        b=ptgnXwtKhBwyu08OmNwfFc8aTEHmYnIQhcBXhEuIqR9HPBf8mI7EQKPOvCckBD4RJr
         TW0wMOnlTXBxH7+vFRBWnFQvl71FI6bJnViFGOn33Y6MZzlBPh6FrJEFsiy9GTjKFd1Z
         Uhi7Iv94oE5PvsaiHhhk1jsk3pEYNdBXzzY6oM+xHbgY2UbqdOQuTGyS6ywXnkEjV9MF
         iyxhe/A+vENVntKsn6oERIf/i9BaeMwOeHmtvldJlkZ0LQcwgkiwJpXoufiovMftGe6d
         QTF+n2K/zPaeDtu5eBNmnehDZMrgiSP3cM8AQROu6xz2LxpgdQmOGLTc4C5VheaA/UgS
         jbKg==
X-Forwarded-Encrypted: i=1; AJvYcCV5NN+eOvSx4MmvL4+gnkqhNa3M5Hhp4AG8EFTsxxcPvWqDHy04cwpXuY07QILv0UqQxfA=@vger.kernel.org, AJvYcCVAHeKetwqwE5K1FV1AXRfqhiS5vtjlKVRjYr3Ssd6hnrbnXb68qrjkHSA6W7s7h7VNLoRVoDAqXO4/KT2MVYZb@vger.kernel.org, AJvYcCWb9tel0eDPVlD4Yqrz77PULQOJ6KoHfLXUyfhRLZbM6yGsTDceOC2B2t6gCRhUAWReBhGRROECg2MGNdTV@vger.kernel.org, AJvYcCXPdRBaGL/VrF2/NtWFCjL0gwSMzxEQ1lPx0niy/RdZK+fXhS17Cv00jbacUpTGOjOdmIsJjUN5@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLPEPtII0GHiXZ8fFF9DeXkJtSeXmZAX2JcAJkx/gtiLSlXvj
	M2odUI+i/BBt8+H0r0bLM04TU2IS32rdRzb3YAYlt1LWag+sfF50
X-Gm-Gg: ASbGnctNGt6wOAzUYdmK9M2QBTjBcR5enF2hYOs+uLF79TJ77pt8a5vTizUthbbgTBB
	46o2QoK9zmF6CVHw3H/6914HesyliDP3wHDFPr2oSwwBeV+BgprT65pO6Ep60HBtYdJXWHvv6ia
	n95/wOCLMywGQggLPQLgbslZjy9njeY/DmkXvJt5IUwZaxCQ/thy31ybZdxBbnzAFQ9crExz3DG
	CKODNBnPWITEdjgPSlufvLnN3NXtK1RTyLKy3S8y8hq43qnwEg1n64AxWispTm7PkNXYLifOWY7
	BZhIehjEuI5H7BpXNdhnKfvnzdYmAbCwtVPzUF+4TGD0TYMEYNAsKgNdwmsX7hA=
X-Google-Smtp-Source: AGHT+IGFTg9rdSsRYxtYVyFRKD2CsVrIbQvZyhA2EkFXxouO956UIWm0/1JZjIufdgZoz8Vd4rWsVw==
X-Received: by 2002:a05:6214:f05:b0:6e6:64c1:f80a with SMTP id 6a1803df08f44-6e66cce16bcmr183999636d6.15.1739843809358;
        Mon, 17 Feb 2025 17:56:49 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf946asm58710166d6.125.2025.02.17.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:56:48 -0800 (PST)
Date: Mon, 17 Feb 2025 20:56:48 -0500
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
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67b3e8e0928fc_c6df0294b8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250217172308.3291739-7-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
 <20250217172308.3291739-7-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: fix file descriptor
 assertion in open_tuntap helper
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
> The open_tuntap helper function uses open() to get a file descriptor for
> /dev/net/tun.
> 
> The open(2) manpage writes this about its return value:
> 
>   On success, open(), openat(), and creat() return the new file
>   descriptor (a nonnegative integer).  On error, -1 is returned and
>   errno is set to indicate the error.
> 
> This means that the fd > 0 assertion in the open_tuntap helper is
> incorrect and should rather check for fd >= 0.
> 
> When running the BPF selftests locally, this incorrect assertion was not
> an issue, but the BPF kernel-patches CI failed because of this:
> 
>   open_tuntap:FAIL:open(/dev/net/tun) unexpected open(/dev/net/tun):
>   actual 0 <= expected 0

Wow. What kind of environment is this that 0 is not assigned stdin.
 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

The code makes sense.

I suppose that if this condition can hit, then it can also affect
existing lwt_* tests and thus should be a fix to commit 43a7c3ef8a15
("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT"), sent
separately to bpf (not bpf-next)?

Since it's a test and no failure was reported so far, maybe fine
to just merge as part of this bpf-next series, not my call.

> ---
>  tools/testing/selftests/bpf/network_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index e1cfa1b37754..9b59bfd5d912 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -571,7 +571,7 @@ int open_tuntap(const char *dev_name, bool need_mac)
>  	struct ifreq ifr;
>  	int fd = open("/dev/net/tun", O_RDWR);
>  
> -	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
> +	if (!ASSERT_GE(fd, 0, "open(/dev/net/tun)"))
>  		return -1;
>  
>  	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
> -- 
> 2.43.0
> 



