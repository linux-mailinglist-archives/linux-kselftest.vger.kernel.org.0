Return-Path: <linux-kselftest+bounces-44040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047AC092B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DD3406353
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AA302CBF;
	Sat, 25 Oct 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WD/o5w9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A8302CA2
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406231; cv=none; b=ZCJNEORRxiqxQ9/vlipJyy6GVu4l8E3FuLcIuF/I3O7OUouj1dqL/mP3C5swO+Q5zqkaVuzwZAZbDopffCkp9VcaSaTDoRhIyn/z8H40uXV+8wR1fNKUN/LbqgHY/A2sQz0rXVvTB90G2sp3llUf7UJ+3jNOuyYZc8sbDxriAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406231; c=relaxed/simple;
	bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApX5DOqNoTd+mBSOp91JLpAjIKW2x3moQMe9gDEowujy7/47cVjzsHJI95f4kN8aV16CyZnsZn8yXGbSqKXC+VWIAJyHS1ILdDULB6E3LEacJG2ULCGxHu3XWf+UqkkFMRESkoEHEde4RkPZwN3rthpk4hwhRXwBqe1sro8+/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WD/o5w9z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso5611810a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761406228; x=1762011028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
        b=WD/o5w9z1wSGPe5tQTOcVGH8/2Xc0adxZs7tsn+UGgF+xOGoBUTIiz+tEcmtVOQ8v6
         Ac7QvrH5lXCfthJ/Jt6UZJYuU/sEBnp/WRvJ8XtksENV7IYJihZpOLnuG+21mn9vMm5a
         ZLexIuOJSHtchjxt0gu2v4bBPIBz3ekwhTslJquym9oB4qUkVoruPGMPlkV8XLP6z81v
         KbFIeY34t9xSed24UlSwa7EG7rimVcZ4fVbGeu9IV9jjwyW3Wd7DBMrZh/67RYN5fDcj
         yxoM5xR/RyKwpPpnEP2WEZdCaoxckTaBqISFcZOJUZxEkTMSG2h6KGL5b8CCWqn3p4qV
         eyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406228; x=1762011028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
        b=Cj2zigQt/XXbPUG/hMOKo8Vvb4HqZkWi31oxqtUWStqG0Ykw0CYonuf0gcIOs1Va2U
         Sp6pYCZZ2jEvlXCJQvpJZdpvyTtU6teef81wgu90j4y/ePwDh0nQDR8EP4XzGjL0EgCh
         p7+p8ND2btaCXKmiT8wUG7me+QUe/S1sqICRKsBA5UA170dGrVQFfDICkMO+8XUT8ijf
         MBP7C2ZUdCDujead+qZezMVba5vGOnqu7z3IDJRzhNBU+kAMIAImmpt+ONEQC3HijNAH
         UMzqlsAzADfk4lcY2aKMCwBud+N2BQYsyf8yrDf6Q3rVs4sMTTTgzfHD1Xi6RzzJwicY
         4m4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyhwEynk570v6q5oCHWL/PJtW7TkFDGl7osMir+pD7IIUFyo7F+GooHYmXmzeezdcc+K1TAI5rZtcNN8Vl9yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnSh/O+F7VdGH0zqifxDJm16zNeG6RhFT6y29ygFj5yo48atR
	vDuw105ILkCjxRwH0jo5/z583Zz8CO5Gc6y1/LG8hdHOD+k2RIdII4C6LIRLpdFJdh5Ju5bGfU5
	M15zbcEj+JFzUxApbnOZBq0BQ+JpyiNXJvWhb1iWiZA==
X-Gm-Gg: ASbGncthPsZP6hfWmAJEq15tn+pH68togUbSjg4L2sHjwm3dFfLsjhry5w+NCaTj+Hh
	RxDnW5ZV5FYUrBxiAVGgi44x5NeOcuBAkBvAdNlELsFJ2XsI0wHPb+rU4WKibfzO6FlhMMMXf/8
	qYh5VWmWagt682FV/Oqf85j1JiFjlrYnyAjf1owF6Siii8I9f/ZRCmZhS6IVt+t5m6zKAFA6YD1
	KEJdfGsw5/J1o5XHSpbxCiCYuTpoQ8/AxFmuIFFU3rn8JKo2BaXoQKzC8nzEBCJrWXfWV4T4TbV
	gGFm1GJzHvpM4qYzGB3dfGbdZCkQ
X-Google-Smtp-Source: AGHT+IHyii/MACqqA1gMbxyh8CZfZM/MVeB0dSh2M8XUI9vv6+1k3VQ9IQ7FPNSu6S0HuT0ITqx9emJSEDbCLG+Yc0Y=
X-Received: by 2002:a05:6402:350c:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-63e6007d198mr5362602a12.22.1761406228044; Sat, 25 Oct 2025
 08:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:29:51 -0400
X-Gm-Features: AWmQ_bmUOgV3_0ASbOM3QoMzXfGDVzgu3GeEUS2HtNMs-zqEXMaBdqidVXde5tM
Message-ID: <CA+CK2bBHzGi-4dqXeQn+OvahYfm5miKEhSuVmYCpo=Z4cUdONw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] iommupt: Add iova_to_phys op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> iova_to_phys is a performance path for the DMA API and iommufd, implement
> it using an unrolled get_user_pages() like function waterfall scheme.
>
> The implementation itself is fairly trivial.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

