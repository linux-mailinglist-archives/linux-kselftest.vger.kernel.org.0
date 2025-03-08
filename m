Return-Path: <linux-kselftest+bounces-28535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB4A57861
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 05:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED9D7A8F6B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91217A5A4;
	Sat,  8 Mar 2025 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OofxIiQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA67182CD;
	Sat,  8 Mar 2025 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409693; cv=none; b=JmEs035CmaTItSJ6axrmZTeZhzUsyoqgZpJgUGUK0pA1nOLcqpeSl++pG7lcdddfFHuUwGX0bCnxl3BKxARgLYYQeLkvbcw3f7+8uqtFFKk5w0dI2ErWjNMH1Q7Bi1670guynaHmpxUs3pgy0wmAH7T7m7JstMqmG1o5a2wLgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409693; c=relaxed/simple;
	bh=m7E7hfGjzYxVKvu1XX3hJSXaUHoz6cQWsutZRTb5GBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnxPckYfCX9hfpj0nXWxh4fgwmrRPq8hAAoyDOMIOdXIDi4TZRY1RADMDBxteO1m0Rwxb/Qbtpj+5suzrXn1QBp3ZkGP2MC/2C0h7wSN2DDBWTa1T9QO9uh/76USNO2wHW6oklHi/vys/vyTjp3tq0lwoy1kYsX4pfnmu6ltY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OofxIiQh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso3883877a91.3;
        Fri, 07 Mar 2025 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741409691; x=1742014491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rVGE9wl0Ua0Qt/DrkYxodd4KQ8at+5opd4O2vE36Bw=;
        b=OofxIiQhTpBka83Fr9V7Cbyx9rsnwfWp6nink4LA+pEOd2dKS/e4IxGBXMX/U7f0EO
         k12CtlVDrFCdT810lUJ/VkjNBw8qnnCVAklFLW8sCLlo4s56BH8qfTpWUHvnFHR1gdWD
         NnRqkILX5c14PDiapyb7LXCsR60xT/0BeQyWSbBxNVSMMWofUJOvSI33BOM5mMfg8p/o
         RcG6lgVcK+Tq2AQFRtLvfGYX0C5+vqF9fUM8eIFLgfkJh0gm+VHNslngq124K2SqtilU
         I9uu8Rpmb8Q2iXRbxh9PcbTHko1GY2sYFJ74sbZahizuHKRXvhbW2Ltfwi7xqAnYa1lj
         /vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741409691; x=1742014491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rVGE9wl0Ua0Qt/DrkYxodd4KQ8at+5opd4O2vE36Bw=;
        b=n3VhKvLZLj2luKkuK0VTzEdBt/oRoBJE5RNDW3v5TSDaCOYbVwRanthuaNhFk1yeDh
         Bvx9U/V+P7TkdQVbHMRcy7tcWu/7OSrPmnGoOjR9n91foqB02i9DueEWjR9NihiK5hOO
         2kUUOMILs1n6ZIZT1eVlT07uCMjQ+7qRDsXEmsO1p+9d0t3L9ANaYYUI56xRTyV+scEh
         IkS9svvMIIiNuINh1MtdNQM53TVhXJ5sbwfBC02FTDMXi0v6TsfnMSPjU/DeBUuiw0AV
         lJVBbGRNGuOoeoVwUJCWi7eweSrvC/c6R7K9VW2RwHW60MUtTmOJdd53gR4HLyMeZNcF
         RI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhPFFJDB9UH02LNCgJ5G4bhdu9J9V1Wfkcyyp9t5OGL81gbc5rWjeOAayyI+URVQFUjfA=@vger.kernel.org, AJvYcCVxhSk2iXIMA0jINSLIIwswSOcYsglGRt+EF008bJlAunrGJ0LUnoJDUz6526qmptS932j6ZEqj8pEWNCmS@vger.kernel.org, AJvYcCX56xYOvZ/NSq/JusQHM4zhHUeflrmUafobEw+3cY4a2PcrT8bXBqJ24FfUID+8+BPULkqDHlx+/31z5JDYuT7M@vger.kernel.org
X-Gm-Message-State: AOJu0YwHagayvwqkvikkXcNp6kiNOYlZIEdMrDYvVunbmdiZqjXvRmQA
	SQPSlOo+wnNRZNuENP7nEhazf/mC4sRNsq1Mm+24meHyuzQnDdU=
X-Gm-Gg: ASbGncv+KeN8n2mIJ+UAd1QoWb6PLIMKBvQC67vKjYtsF8ED+KRtbMz1oKneCHXjNt5
	fKg4WUMJte6nbNyo7EOoGK5Y/bNBTUWjktzDyxGYb7AyF7V7rUT6DOhfkFQOWUP0OhO3DUA+P+0
	Wc9HTJCIaEIO+sLP18skysR5YcSsWOJPS40bcKfzJx32UpJBsVxNsKwZcgic6ouYTh3aBGn74MH
	jlUPMLkzQ2wao60NqMgkQ8+PcAlThfsnCDc4y7ce/tVEqICQ9dleFcBaDAf68K9vTTi9NqTr9s5
	TtMlq2CUUALkNRrP3qI43zuvX+1Q4a3M7qo/redctKYs
X-Google-Smtp-Source: AGHT+IFsqTQ1XZGfImIAAQO0Pt3PNoxiUFFfaNcH3bx/gViFixwh+wID75CRGSs7UX0UdPOap4IljA==
X-Received: by 2002:a17:90a:ec87:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2ff7cef6771mr8111291a91.22.1741409691036;
        Fri, 07 Mar 2025 20:54:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e789387sm5844066a91.25.2025.03.07.20.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 20:54:50 -0800 (PST)
Date: Fri, 7 Mar 2025 20:54:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Alexis Lothore <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Move test_lwt_seg6local to
 test_progs
Message-ID: <Z8vNmRN8JPFZZOlU@mini-arch>
References: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>

On 03/07, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.
> 
> test_lwt_seg6local.sh tests some bpf_lwt_* helpers. It contains only one
> test that uses a network topology quite different than the ones that
> can be found in others prog_tests/lwt_*.c files so I add a new
> prog_tests/lwt_seg6local.c file.
> 
> While working on the migration I noticed that some routes present in the
> script weren't needed so PATCH 1 deletes them and then PATCH 2 migrates
> the test into the test_progs framework.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

