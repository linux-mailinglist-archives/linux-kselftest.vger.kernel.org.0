Return-Path: <linux-kselftest+bounces-28460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45DA5628E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761581890F41
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B71C84B5;
	Fri,  7 Mar 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Zdl2TGmN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C91A727D
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336142; cv=none; b=T3F2Zj22Gl8l7ZJ+lOG8lPWXgGYg+s1/xbBm43MBiZ2HZiLEXr5JCD3QiJt+W+AojoO7d33KsbqwVaQBT480WJYXJJErPsrBw+QQD5uZXLjE9lCW21hAu5sLPAjh5qLv4xqNWBJUMxBAbW6SR9TQMZiP5ObuRv13+2F+9nCQzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336142; c=relaxed/simple;
	bh=KAEABgo5QmoLhvA8/dKPBOR8Bq/G4TG267wdgb4RRRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6DbIggkcr3xO6GcibqG34Uf8VXFYOFP2V00y9bVEdptez8O5EAxUtBbUtfvm9pbpEiPBmrZJsRY189qj/D5qbI4X5V6QdA69b+ayXfUXLCKFGDWY1FIB+/dg0mF9Y71iP34lEJF7WdzyU6v7vezjO6Rsryki7hg5Cde/A+0IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Zdl2TGmN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b018062a5so133708639f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1741336139; x=1741940939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YlIiXhwG4KRcbOBdAmDvGTlkxDSVAhUX3csscpKyVg=;
        b=Zdl2TGmNjlXM06Ncz5wDIhQU5kU/XKpjSvqrO1WU+20bi93on/Dr62PNLgLzq9njkp
         A8KIVGFrLsy6+qndjyEmbO95Zr9dOkP8syd5rWFfnC2jbYWCXShunygvVFuEMETsqr1R
         p2FHgbc9iNynHkzuCPeJudsXw+miMPttLaIuKfprPvD4txughSOtIA1L4FzOEg8KQJtN
         UTsi1t8uwlne33L0gE9Z7lOnAnPEunKdvAB11dPz6hZa8aalqxCEsIfJEYfFo6vx97aC
         BjoZQfopMDxP4m7pjK1GHHPdHRTuPMtOoeL4ZFtGYM390tdduHD4cgli6tmcMPIYlI4V
         XRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336139; x=1741940939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YlIiXhwG4KRcbOBdAmDvGTlkxDSVAhUX3csscpKyVg=;
        b=s6fdHqzWyhvhRDLOdDqfrJv4G6aUtHDRpUGH0RqnDvkY3cjZOF1kNccFbewAg+ewyW
         bWsdU9L/6fWK5qO8QcVAWo+Xd2I5A5DuIjd0FUHOyYwbsHVnnvI+FCfMy5KB3GH8UXQu
         Vl8PtbQwZjmduUM5Y6GlU3vd+KbaxuJebXyF8Io9LaQdfgLO5X1FAj2pHffLszbbVOaK
         pQGzMc0008MQAXSrPUxC/l/VdSMilbFN4vU8HUdxIwongD/NR6rssqNlHUDOMKivSa/0
         Q1TBkZ6qfd334iMWhM1M+rRC0fr74CB6m8ktj0MBqbHn/Ses39nAK1sp1J8qYHl97eJV
         qiQg==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ9+gI3nLSSl6pnO22VqTyrkIXuSwEH9eYmMMcK4D91P+9x5aAuQ6q+VpHXy/hS2kbzIu+61Mh4X+n5zGNfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybMdeV2tMj3pR4v+3XyGocVg30nfSDIz7a763eXRL44WpkANx
	K4jyV3TOWB7S6cYTu9OCzaUk/X/hfc15rXyKytAISk/WSjVOsiWuXgyHfWsxBTsiCar0C0bMUFN
	CaTK8XGNS8YsSIg2Oi6n8zxdN4mnKcnzD50qi2w==
X-Gm-Gg: ASbGncsWrPNY7BOcQ43CJ4htfM/Asyvw/8iAXdpxLAzviJu4+AdQMbTkY9KcArHyjIo
	rAFWI4gfFTuE0sftpxNhPdM+D1ujpFwCFopL8Op6mp2KJN8y4bw3jwE+FS83p+09II1vz2KdzN1
	EUa8jtxMBS/xMUMVVTFSDIne3ZWgk=
X-Google-Smtp-Source: AGHT+IHpyge1YXB1VBykLP/dh9ft8HFAB3zzw6CmKWnhV8/XYcR00xSa4YW+S5Z3jF04shZ9TO0vf5OuS0Vy70VC954=
X-Received: by 2002:a05:6e02:16c7:b0:3d0:239a:c46a with SMTP id
 e9e14a558f8ab-3d44194816cmr30189715ab.9.1741336139186; Fri, 07 Mar 2025
 00:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
In-Reply-To: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Mar 2025 13:58:46 +0530
X-Gm-Features: AQ5f1JqfLRDl2sXghMrs9tGiGCXrhEWfy1IvZjbEz2be6tiJtFVbpcg_wKAhY44
Message-ID: <CAAhSdy3KncYJhPAa20oH=bB1Zi5-=sD8m69OYFS451q3_EMiEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V KVM PMU fix and selftest improvement
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:23=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> This series adds a fix for KVM PMU code and improves the pmu selftest
> by allowing generating precise number of interrupts. It also provided
> another additional option to the overflow test that allows user to
> generate custom number of LCOFI interrupts.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Changes in v2:
> - Initialized the local overflow irq variable to 0 indicate that it's not=
 a
>   allowed value.
> - Moved the introduction of argument option `n` to the last patch.
> - Link to v1: https://lore.kernel.org/r/20250226-kvm_pmu_improve-v1-0-74c=
058c2bf6d@rivosinc.com
>
> ---
> Atish Patra (4):
>       RISC-V: KVM: Disable the kernel perf counter during configure
>       KVM: riscv: selftests: Do not start the counter in the overflow han=
dler
>       KVM: riscv: selftests: Change command line option
>       KVM: riscv: selftests: Allow number of interrupts to be configurabl=
e

Queued this series for Linux-6.15.

Thanks,
Anup

>
>  arch/riscv/kvm/vcpu_pmu.c                        |  1 +
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 81 ++++++++++++++++--=
------
>  2 files changed, 57 insertions(+), 25 deletions(-)
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250225-kvm_pmu_improve-fffd038b2404
> --
> Regards,
> Atish patra
>

