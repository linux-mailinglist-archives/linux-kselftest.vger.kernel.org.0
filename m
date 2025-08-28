Return-Path: <linux-kselftest+bounces-40120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12122B38FCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69224607CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7D17A2E8;
	Thu, 28 Aug 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtO188HV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2217082D;
	Thu, 28 Aug 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341027; cv=none; b=OZE1KK9prLmmjg2JFWMLPJc3+ayJCQamZ28N5lbtFLMel+4xo7zwd6kix2ejfFZzIpkLtBzeWz4y5935G0K4rHzfLeXwk5qh95hkLVcwcJ9d8Hc/Tsr5gKFIBC4NnhE2obXPu6Ly3/eKKMzj5N8LMV5ZQ91SM3bpEpXc48cN/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341027; c=relaxed/simple;
	bh=phOVfCAyG2G09ByIghVyGcxcGxwbIBKKcwy6JYmeN2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tohsX6w8P6rUbdP1I+QrlwwS4Rh87Z34vAuUXNJjvoEq/7/rvkwbMLj7wnz30+A4RjRCceClDB15EGYKVls/gJB9eNT+3S7A0DhOS3b+Po3B/JRUl6gYdzLWHbfVeCnIJ3k28XuBZqGraTZPUwxwnQf8pCoN/HpeoYpzb7KSc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtO188HV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c7ba6c2b2cso224562f8f.1;
        Wed, 27 Aug 2025 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341024; x=1756945824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phOVfCAyG2G09ByIghVyGcxcGxwbIBKKcwy6JYmeN2c=;
        b=FtO188HVlW9+S8WQvbvKTiVjp20CMN/Ll1eBpKCAHTLEj/hui3JXJaS8pYfdIQJubG
         hHYrDqB65JKOSSe2aiAiXYQ8pjS8cqq7/qRN9VnbGfzxHKg83ykf9p83PkqaApLFzOrW
         TUgJDtR5ilP6nCKX+pzRZZ6e7GQ1/rkb8rr0JAN/EtuN3NopLgSkig15kdr+DXLImBHr
         mc1oX8KLogzrrY3XNfENBYa8Tm+mYKmVMUm0R/gh4BDgI2t3wAx+hMBBa+os+mBFsSn9
         go0SN0wZJIG0hR3Dmh6kQzxESmprit8iJVj3W5lJ0/VsDFxqH9YyJsRNCV8A27wEZ1jS
         jdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341024; x=1756945824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phOVfCAyG2G09ByIghVyGcxcGxwbIBKKcwy6JYmeN2c=;
        b=I7o37cDvOEsDFZTYjSW+2MmV0N7zkQIhOLDg1so6L0hJjyBvD7RJkyUXfmT60zH/8U
         CUdym9VkTj26+aO8UTlYmiteiesmy8eRqGVTCoFFmXqGQ7ZA9zj8e/lu90JwYpaHAeqZ
         /BA0N8furW4rKMYzcI16EiMB2Wf5mC/+oFDGL7SxgV6R5dI5KUkb1ihpzpAGMLk8iI0o
         Ci3SLBOUJSKuhXy7jTkOSgp43bZDtsCOaUzq1vdqfZ46zH8RM8viHk9DQAs+ooekkLpW
         63IeIhHjNYkyoNqnLiQmbk8+Y1GLDOGh1/l6MIxykDElRVTruwBFU5hQOsLJFboLaJ2p
         KlAA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ERSvpXIIskDTLXHjQNFvhfn+yKE9nx3faROBuiduTiN+8v+iiS1fwA681NqBtZA+hgg=@vger.kernel.org, AJvYcCW4eTOPD4zNdsni1xlywM4mg6buEVbYYCGfNiGv3KaOpBmsX4ph1wz4V2PpcIotCDvfrPMMZnik1l+KHENj@vger.kernel.org, AJvYcCXX441TeAehFYCI+1dnfds6MdcHfUMMb3bDSi+G4XKifwhwpOxGyRfZrRn/DCxJd1qArcl5ruyD@vger.kernel.org, AJvYcCXrnM7+LOJViMaoJ37RU6UPFBb8bvXFsNIQRFwSvM+NG4TAHtMz5iSY9ThxPV865zKryTIsfyYGsTgbdBd7tG7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzdo0cMO3x7bvk1a+E3rJeXUmZ1C4xBPVFcpLfO2PsyawBI/my
	ApX15i0KosQWuAa66YuAWABxSGoetz5uaPMikrFFuCQLlEzzn87D9xgZdJynQrrJU9yjSUN+Yyd
	sdGzuAUiWQNO45xO/Wt/whOmvVq2tZCfpAQ==
X-Gm-Gg: ASbGncu+7Emq+A6xfRYUAu30JEzCBAD3PA87zhjNnTIDb0ppMXAQ2P4M9rCC8j7Chy6
	VZtTfwn8YOvJQx+X2aI8FAXa0B3G+rKrjbJErDVeGjJTLaQkKkxx8DAufWuebF48JcBK2zAO41j
	HVsLuCv7s4fJPn2pIC5Db2iGhtKLiYCvleJWMovNSNcVhbaewsNjhNgbkKm+uOexbcEE5dnIw8f
	jN741YEJS9ALSIzpMdtsmgslNnDYD2VsZK1eziwQIGlwjY=
X-Google-Smtp-Source: AGHT+IHsBjxQ6KPNzmi4UP+/vHqyZoaeugKKKAaen4xEZl/RJk7r9BwnIKeOiGc16r5pHxZ4HUO4cE4Cjpd8qeafxNw=
X-Received: by 2002:a05:6000:2585:b0:3b9:16a3:cf9b with SMTP id
 ffacd0b85a97d-3c5da64a8fbmr18419300f8f.5.1756341024014; Wed, 27 Aug 2025
 17:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827140149.1001557-1-matt@readmodwrite.com>
In-Reply-To: <20250827140149.1001557-1-matt@readmodwrite.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 17:30:12 -0700
X-Gm-Features: Ac12FXzogGUWsqRuxEyzqrDVx1QZOE4C3zTzDz5wyOV5A8JQEpcsRWtQKOa6GCk
Message-ID: <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:02=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

I fixed the tag while applying, since it should be //
also dropped or-later to match .h and the rest.
I believe that's what you meant.

