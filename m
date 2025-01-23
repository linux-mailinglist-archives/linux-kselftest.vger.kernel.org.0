Return-Path: <linux-kselftest+bounces-25032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D07BA1AA90
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931FD7A55DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0971C54BB;
	Thu, 23 Jan 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyy2NvRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4E1C3F34;
	Thu, 23 Jan 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661506; cv=none; b=IXlI7CmcnBnDHQAGLxRcnSTB25AbZEOyGCSuY/Ee6+nGOo0F6PvqmrnMCcAzNN9fcOmYR7bQI71G/JIugGPqkKsSxysWQR0++8H63frm2+aqpO0dxugEoMa7buiwZsSL5/R7VL+M7wWkM1UEWRasbUi9Ymzq/2FfMgJHCweiNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661506; c=relaxed/simple;
	bh=GNyYwOjgvjBmBQHiAq4euePxv6GmOehuGrlNoyd3X6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQCk7dzkVg1ng+xFEGHHoxkzcC5uJqWp+oeDbASRG198I3lhA4NEGl78H7QnfyCwD2a4AZRTtlj7mJlX8Hs4HS+Xn5jRLpPHrps79WwSeOhFhFEZ2ey9MVvMk/ssppgOZ6aWKA0y6IlxwTXzylH7hhDi6F+dhIMlhFKsXy8LBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyy2NvRe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2161eb94cceso16257285ad.2;
        Thu, 23 Jan 2025 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661504; x=1738266304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbDJ5jRP800MdKxkVmQO5UhCCyRJRcpUXo8vGydGxc0=;
        b=fyy2NvRek00CeWhmi083M755moZZ9+RK6n0MmKOUiP1JhcyftAQGZuVgc6+zKwoKeh
         Df4WAkmoVk3fSnkMOvFXyKPaGba7DGfZOK2wjdVxaMlc7q5vzspgzZyS6jeWLq8VBlM+
         v+ujW47WTHL73Uuul6//QXEt9peILRt7RqUXMz6ayrTm+eCl8EWIMd7yNvYC+O9nAesW
         ENjc8TSkkff5eTgbj10UdIJwVbIm92KjggK7gWGE2U0PJe794H4Yug9/f3UThXGE0Xat
         F8AmsFkcRONkZx00rv77+aEKXUrt14WjsaxPrqNlOIhc3I5QR9SwkQ+X9dsrpcfmw36f
         ngMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661504; x=1738266304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbDJ5jRP800MdKxkVmQO5UhCCyRJRcpUXo8vGydGxc0=;
        b=rKJ4GQcHZqnWlwC6dG84Se4zHBxKfVKfDLfhDJReDIRKEBgpb+nM2/KEP5/jrjPYne
         XJuaV+YRXvtzWGCfMbo9UKlgUhz8iINFVQbAPyUKJPNPUfMu6E5DtL38Wo37LPFPgB7S
         E/Rw5z9oJeeXLrjQZ3364j6gTWoXRUoi/I4M+f2TKI5AkTd/sFaG3oNOrTCSbKapfHSt
         mgEeABGugLhRE4fJfefMsltgNLXbYn+sepjy8yNruOr0bZTAzsyaep4PpS1xmm3r0U7L
         0BxFNrdMg0PCI+vYZtTcruFZ27cU/nJV3bj2MKRKxVLxmDpwrcVmpNt7zuDomo2V22s4
         4Nbg==
X-Forwarded-Encrypted: i=1; AJvYcCUgF1jm1NdbLpG8JKivgneoaf28fscAV3AA1Zelw3PdVXWh72GCZEMHBzBZl0e1WmgLoDVOX+8ELaPT7r2l@vger.kernel.org, AJvYcCVBQqx8JOTT6DF0sPQiKCkVRGv4gkMlYpIkw8mc+iN2NAbTe+E4e/aHGDpc5y2iP3XTHWLgetg9@vger.kernel.org, AJvYcCVMluszgZf/tF2mVa/zjDnBKguo2xzsvNvVRW0a+D9T5D53iCToLlcoXbSja8ox0TtqfBo=@vger.kernel.org, AJvYcCVcRXZRRyOfLG6DmE+piUgCcryz+uDrxnMwmSWoFtd0f6Zy8j1sAbt5K1TpLEZsBfbGCBIq0PICXPyGjod1PhfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFZgIy1isH/xu23cOteeGQDHAUqHsyCzhwbF0tBtXDybhWwHb
	Qxh48ZaHLRZ3ZS39WWZLSCY8t3QwmAJjUC4ecGCGb7Xwe/xq44M=
X-Gm-Gg: ASbGncuD4jWbvNPfrC+PNvVijST8Nvlu2wyebW67gA60gxnG3hzQ2lqOAECXcxcYhKg
	w2U7de08WJN26hxLPcq32vRaXZYt9TAf2uMfr31/XMfMjbMJzKunPioM7NDkdwSBPeNRgh31/iz
	ddjXN+o7QEnfilDO2AFEQjInfKEQtucx6NtByYTI7Zh1srfbT0L4y0tMB6RpUS9GIT+xHit3KGJ
	N4f2M6Y/N7GuIUnQSeUwp1QDtniO0tqR0zuXS2l+TrJhPpKd8JzRozqWjmQbfE/XI6oCpIYTE30
	Tt+s
X-Google-Smtp-Source: AGHT+IFLfR7sepB411Y1o6WYsBTMG+7bZpq+2cLG/v7NZ59Qt3di4PECY8vUrmkC1ddsallRyaM24w==
X-Received: by 2002:a17:903:22c4:b0:215:352c:af73 with SMTP id d9443c01a7336-21c3550db34mr349257565ad.18.1737661504553;
        Thu, 23 Jan 2025 11:45:04 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e083sm2845345ad.25.2025.01.23.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:45:04 -0800 (PST)
Date: Thu, 23 Jan 2025 11:45:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Alexis Lothore <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 00/10] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Message-ID: <Z5KcP_rJw4Iv5tKp@mini-arch>
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>

On 01/21, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the *.sh tests into
> prog_tests framework.
> 
> test_xdp_redirect_multi.sh tests the XDP redirections done through
> bpf_redirect_map().
> 
> This is already partly covered by test_xdp_veth.c that already tests
> map redirections at XDP level. What isn't covered yet by test_xdp_veth is
> the use of the broadcast flags (BPF_F_BROADCAST or BPF_F_EXCLUDE_INGRESS)
> and XDP egress programs.
> 
> Hence, this patch series add test cases to test_xdp_veth.c to get rid of
> the test_xdp_redirect_multi.sh:
>  - PATCH 1 to 5 rework test_xdp_veth to make it more generic and allow to
>    configure different test cases
>  - PATCH 6 adds test cases for 'classic' bpf_redirect_map()
>  - PATCH 7 & 8 covers the broadcast flags
>  - PATCH 9 covers the XDP egress programs
>  - PATCH 10 removes test_xdp_redirect_multi.sh
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
> Changes in v2:
> - Use serial_test_* to avoid conflict between tests

Do I understand correctly that we want them serial mostly because of the
hard-coded namespace names? If yes, might be a good idea to follow up
(separately) with a way to generate unique name for each subtest and
unserialize them.

(If you have time/desire, I think there is a bunch of similar cases
where we have to serialize tests, might as well undo that).

I looked briefly through the series, looks good:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

