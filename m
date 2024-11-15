Return-Path: <linux-kselftest+bounces-22109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025B9CF089
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552522900B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90D1D5CF5;
	Fri, 15 Nov 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjdiOCR1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC381C75E2;
	Fri, 15 Nov 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685202; cv=none; b=m6qwWkuzgIgdjikUosArYUdGA6ploV2/Rof9zFu0Bot7h3gtGjmR36DWmJQYddEbCKj+llDsPaah4WfsCEPz3s714PnN7gFgcPsGTvThSjR1sEQamoZ5IxyNhu1zLRSwh+3g56YS/mVE0JRhQYllP8Zr+qsQszMlvvy3ixwOCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685202; c=relaxed/simple;
	bh=VYy5Z/F2SKHEKyEF2sWqcE3UJqYratJdw86SVPgNnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/8J3rDOHff0TrD4xqTldyk1InPaSZkOAeKnVkLyDrri7f0QRo/TsQ0jTohJRvF0pcAjVZG53VlNQb4Zq772r88yZwAGQgoKMqUfM0K4RcjoLdD1UPtgAOf/DlU+ne4JXal06IEpexh9NVyIEg8NeH/GrEA6VW3OdszHcmGtcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjdiOCR1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9ecba5db0so1529924a91.2;
        Fri, 15 Nov 2024 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731685201; x=1732290001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvgMmyLZQaJHTw5Hy6Dx7Hfozw7BNQ60DAzTrMshfo8=;
        b=TjdiOCR1OK75K/1UZ1otICKC0vylhd2CORWgqkBc57cXGlnr2DMPuLtulMua/eyAir
         tWTjMYp23DI/RGnqo0YimokEhGZvlZR7uRY9T/F1BMMlcN/Gdsc9Jlgoz38wVYbHmdYp
         K/aQxhBqNbyo0ux7UvDIVC0/OUrl4FzCsWHlbRhkjkUCnBzJUYmS9eBCbZmOzYVyiH3r
         Q9Sip7NWAAVn7eu8L1TatbINlI5A3D2igwm+bE/Y7g+4E5FYk4W45VhXu6F1kEALpgNe
         QU2lTjGXBIzh09ke6jdEwoXom1VmTQ8cKyWzDFecni1FFdUoOB4/Q3St1C6qQ3qzSDBC
         5SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685201; x=1732290001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvgMmyLZQaJHTw5Hy6Dx7Hfozw7BNQ60DAzTrMshfo8=;
        b=HorHiFuWFzv3NxaVAfR2dTB8yxYH3Lkyx5kfm1XcH+CwXr1j/xPsc28WO/TMuh073W
         Y5atHKtKpeKIwq7Qszovbx53T2JltirDdNMWHTct/VPMOTSmVjHs2L8cpB7J26U7o26D
         QRXhOdKSjv+60TyWjkjs+lneoDukei0WruaYV3JmqBHvny5ARQiarR5aja3uZ3iSU/2w
         OcesKFse6xUUojX+UxBq7BXFjIfabMbJAeFNawacgVm2hiEt1irbba4IDLZjprhtXpBl
         U+CzXFJrnASEszCsJFVFWjo0m0hy+wP7A4DhysTH85H9l/pR4n03R8mPfBkTj9b4Ld0x
         KdXg==
X-Forwarded-Encrypted: i=1; AJvYcCUKkSH4nJY3z7VgORpzsBhjnf7RB/VVBpuGofbXrm22E9Wn8LNSpRfeminUT8i8BGtNAOrHpbHX@vger.kernel.org, AJvYcCXDjWpU/XzHbHxDIROvnBqjMg9bRfVN2XPf+nhBlwXYX0PgHNCapEuHTQrIOqtFImZDH0a4Vf6XSmXx7FSmZJqU@vger.kernel.org, AJvYcCXkpu62zowRapeyFonLEDh3O00jpuDrYABvLyp3KaUxCjz8LX2MO1eNuJapM5yXnN75RGY=@vger.kernel.org, AJvYcCXnSOw1neDy0ixAzYfPmrKvgaaB4njFV1wdqlzo4Abq4+m3UF3aun3jJANCTAJDm0UPHUpZPaLiqAvLkVbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa55KOc3Fert0XkYu1DYRzF1tKKymhOGDXHf+wSyITVTJ2Vd9Z
	NMF8/DcXZ+JWczZXn0nWyLho0gKa85BdymD3Nf4X2kmjp5uldqk=
X-Google-Smtp-Source: AGHT+IH9ZWeCw/lNubIqk1jjDJsSroUKoAIH0xi66bmklYnQSLVYg94H0OHQhU69Od2f8QbCO80hGA==
X-Received: by 2002:a17:90b:3d87:b0:2e2:d175:5f8d with SMTP id 98e67ed59e1d1-2ea154dfa68mr4076574a91.10.1731685200714;
        Fri, 15 Nov 2024 07:40:00 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024ab569sm3049473a91.32.2024.11.15.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:40:00 -0800 (PST)
Date: Fri, 15 Nov 2024 07:39:59 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 04/13] selftests/bpf: re-split main function
 into dedicated tests
Message-ID: <ZzdrT7wEUjUDNyGj@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-4-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-4-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> The flow_dissector runs plenty of tests over diffent kind of packets,
> grouped into three categories: skb mode, non-skb mode with direct
> attach, and non-skb with indirect attach.
> 
> Re-split the main function into dedicated tests. Each test now must have
> its own setup/teardown, but for the advantage of being able to run them
> separately. While at it, make sure that tests attaching the bpf programs
> are run in a dedicated ns.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

