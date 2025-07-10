Return-Path: <linux-kselftest+bounces-36960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09608B000B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D4F7A9E95
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98A241666;
	Thu, 10 Jul 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVKHIlIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480841A841A;
	Thu, 10 Jul 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147641; cv=none; b=p65UvWhEg09W5tE+27Q1vGdhtbwi/ws4e41IuUThTFvO18Nuqs3KPxMgWKjORIk5gEN+FY71KrP23/AXRwWyL5EDRnmCKaPsuAL0S6xSPk+cv+eqCL2F2JejHY2fyOj86QlOlXJB7xTZZdsD8tBYRHfZP9NMYz04Edux9NQohE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147641; c=relaxed/simple;
	bh=0iRUdl962OfD5WdAy2WaNPadKxxM8rE6jjoKazsAV20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0AevxyB+H0PHmjQFYOZJJR1O+R/F4yZaZiNiiY+E4rOLHJwdPGv8qgbf5Px7ErF2FIFUYZzvzEdehUcBW9l0iVa11YBVsP8b6CC9GITu+9xltW1k++CNp2W5R7ErK3AJySs3a/QCuSyxksLPgMOjMQfz4yZbGcw5MjIq3ZMURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVKHIlIb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1716774b3a.0;
        Thu, 10 Jul 2025 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752147639; x=1752752439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iRUdl962OfD5WdAy2WaNPadKxxM8rE6jjoKazsAV20=;
        b=OVKHIlIbuC7aWrhU4fNKV8+h/imMXidIMjcj5AuYlnmFCuhv24uPw4Lszkq/707czA
         +imO9iO6ZUKdPY+P9BmJV1vr9I9llPpUWrJ5t/h7VAz0Ok4y4ggC2rWkq7RZrA3VXr8L
         to6qurSPF/Nw1ZAUFwdsRtnX4Fu0tEgmfRjo2QJGkJlYWI7mB86VQ2Vtr0wmjBdgyPJD
         a2vPbJM6wFJ5J8fwzIK0NQN6+cN3io5X5o07qtpWwajYzK5ypPVRP74UtBTTT7k6UXIy
         dAREz0eX35CxPiLycw0vHZMVRHhSfiDTQrMakOt08eAM+7Q/3rTbdHfraYkm4zyIj44B
         aJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752147639; x=1752752439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iRUdl962OfD5WdAy2WaNPadKxxM8rE6jjoKazsAV20=;
        b=PPTuoThNo7SrjvwY+0vKnd3f2InlyQ9PlWkhYpBMl+s/yDYQFCJrYXMGluAkPMh7Jv
         gX4n2XpXYxo728Ds6oVaz1H2o6jAI///kiBUXhE+U7+svKtf7GauDh3qEXIfR7x3HeYl
         ASZ2cPHhbLjKQ+4kt1v2AhmaDPNzplngi6insJE9gtXrxoAyHNUovQuzQkUvMQjbLHqS
         5WqpgFFyOFA/z+Js3L0ZrrNHgfKzmmSVFo6ydPRFrfKu6k8Xp3f7Me+MAsHs6bdkl+TV
         eAYdrt0455MAgmaUaYgCXh8piVroV1phEKgT66cl6mC6oNlgCPPgDzr72sGEDLM1VBrJ
         U+gA==
X-Forwarded-Encrypted: i=1; AJvYcCUqbEmCLGIUXy+mDjceGkE+QI8RgqX+Go+xhgaZyrVhBA0g/HWvV5FrlwJU8kqJg5yssGlXuQwKZE/JfM4=@vger.kernel.org, AJvYcCXoIeH8/umPEUwMP/ECBBhAqLG2kLm2eFOkSMQbIWgJ3WAX7Nj5UMVbqeXkKaST9fVHiCCz1tromQI+M4UKrFQU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lbOtt0j7gatgZsjIGflcTIBcgKZGU+Gs5Ob4WcyHksCsYHPY
	ghyuoi5T7jmAPZBjhO/xkrEfemmT1s8d5IbXMtSus1vNXwXXObAkDiuC
X-Gm-Gg: ASbGncsmGbLylz4aNe75+9UQM9fXLfW44MEq28Wllu7fzk+EyxCIn9ltjqpCYyGO7r1
	jUwNvFfwKahN9vHfAu9QeBmGdAMdb7KiZqMdc4LoQccaZkF86Kjsvk5RGcuQenvGyOLTmZKGVyv
	5rU+lpE5IuR5JfWRmGjip86EwB/kr3r4PUXhCy6DsR4+buiv7cbffpYjd0SjK1i0HrujS33HSXO
	eoevX3hxJqNtaU8wwMDdWfa2r2VUyF3PrCJwigIw05ZGdQOF7x9GR5lub7T0IAmUz3VL4zCCBxS
	d/M9XD2D68qBL3rGv7ndCZjmW3A8S6Z1pbHJ1fstyEJCRKKUo518opl93894pFzN5makLhYr4/Y
	3AuWgrHUbsT4H
X-Google-Smtp-Source: AGHT+IG4jOvVrFVHKIwUQ3SJ4F00MMttTRUh8ul+FH0UmJKgEUH8VTKbVF2uEvCcsLoGiniMkUBLQg==
X-Received: by 2002:a05:6a20:158b:b0:224:46a0:25ef with SMTP id adf61e73a8af0-22fc38bc880mr5213931637.16.1752147639233;
        Thu, 10 Jul 2025 04:40:39 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d34dsm2136736b3a.104.2025.07.10.04.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:40:38 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Thu, 10 Jul 2025 19:40:32 +0800
Message-ID: <20250710114032.63278-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
References: <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zi,

On <Date of Zi's email>, Zi Yan wrote:
> On 9 Jul 2025, at 8:32, wang lian wrote:
>
>> Hi Zi Yan,
>> Thanks for testing the patch and reporting this build failure.
>> I don't have an arm64 environment readily available for testing, so I
>> appreciate you catching this. I suspect this is caused by missing or
>> older userspace headers in the cross-compilation toolchain.
>
> Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
> should not rely on userspace headers, otherwise we cannot test
> latest kernel changes.
>
>> I will try to fix this in the next version. If the problem persists, a
>> good solution would be to manually define the syscall wrapper to avoid
>> the dependency on <sys/pidfd.h>.
>
> Based on what I see in other mm tests, the following patch fixes my
> compilation issue.
>
> [ ... patch snippet ... ]

Thank you very much for not only identifying the root cause but also
providing a concrete patch to fix the compilation issue. Your analysis
that selftests should be independent of userspace headers is spot on,
and this approach aligns perfectly with the feedback I've received.

I have integrated your suggested changes into my local tree and will
include them in the next version of the patch. I will also be sure
to add your "Suggested-by" tag in the commit message to properly
credit your contribution.

Your help has been invaluable.

Best regards,
Wang Lian

