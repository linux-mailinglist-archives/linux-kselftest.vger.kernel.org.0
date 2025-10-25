Return-Path: <linux-kselftest+bounces-44038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D82C09286
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 17:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D25CD4E2B76
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712F23B632;
	Sat, 25 Oct 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="En1khRSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBF47A6B
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405359; cv=none; b=D+V3ObgQWcHPPxVWNfaxlhNF4LP6yrbqv8zI2X/1fp7TXY9DD56Be1SLOr6Qgm9GEYQO+XxNZTx8SQsr6bjbROUAq3iCvesyfEfijSSry+jWDkYlljXpu61XkdLdxDsYZ37SYj0d5agCr84i/lEc4T4vIa3tM2x2pg3Smh01IGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405359; c=relaxed/simple;
	bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmYYOIeEllT9o9JQYXDa156eh2RMQlg+dAFPG9TAhKEABTCHjYtO0LQEkvBrzwOjQWODPaRLG974HlfXA4nat6viWQkJSxsEUDqXWKaop/abapC6a80WTbJGMlfVwC8elzstYr1W1zw80Ty/PIpZ7IHeHzn/43dvaw1nEzCfr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=En1khRSB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso5199447a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761405356; x=1762010156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
        b=En1khRSBLS6hpgD0EjfNw/xEEamxOXFEO4xl+mWrXdAWqjQTW0LehBwanoPzORLcnJ
         /BKJglcDFSprNufcZgzc60O/myCvzZ+0ZNvV3NIFwmaulq5cmncyJ+RUjilaQJbkmmbJ
         oiJO3V3qlk3t7q1l1eig0yiPyKXJs97gwjqwPgzb/Mv0gJuQ+UTFh6ZiSz5MqXhAQdVl
         u5bcXEHSOji8UvrLOQczSsv0WeezCysjAqxyuirjkhttoVxUYtqs8d2oBEyIsJg1i/PP
         /IpC9wYMWQXfcbm0+FL48Ny6XX1T1u6RqHT9kq6A7rASe2WZYg9VH1761W2+yX4MLxKn
         tSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405356; x=1762010156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
        b=daoGxngvwuFDTIKJ5mTaC4uBtiBXfmlT9BpISlXPIBiW/8hGuYByO0OsNlBLFBqw5L
         n7jyf9HqYQk1ZGwLhjr8FqQx0r5VOo7Pnvlt9UBD8GGEoGBAS8E/bloQoZnumwPnc9to
         4cvpL+QyXMqFNe7CmoAYETWB83jVCZXTCrwTGMHtGroupWI9uxMZyxhtEcNw3Sv+EOL2
         ihM976Z2oqoJdABTteeFABQYZ2LLXDTB4DJ/qLvZxfTInkYwU+4qJC17HHIZhRb3TOpI
         uPBmowRq2qig7KGDyqyobx7J3q0Las+tpW7unnVGtiQegfAhx8iCdpsgS3zKauefYXvU
         N9jA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHcRsTJrnpgK6K+oSRM7jT23mTb1TN4sC7bPMk+E2+xVhuVKSjiPvnK4IgR6kbL6BHU8bZQDHOVJTbs3pGRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxmwGdMsY5l07FlOpjO9j3bS2GNX3JrRGU1RtQFbiqqy5Knu7z
	r6VAJwRkUMAROTAoCDcZz6gC0GEC8opbfJxwgm1i+TPNzlxbmEyCZYEsYSKpIA19s/ce3nMshbY
	Zh/d5+oSjvqVpK7p9CNf2V0G4OT1gowJaaVK5vdVvdwEfRR+ReoH6
X-Gm-Gg: ASbGncsObOSMH2R8edFca+R2i3m+7HXIzADYgVMSl52mv6+BrUJ+atcae/uogL81+dL
	L6+jrA1rfZUxdcV9vSSwhfmqdasqtfJf++lsBGL4gdXhmW1mskrjPeZzYWVY/zYv0ULANY0OVnX
	gfI3u+qSn3UZnxbP/E2PC3WkrM8u/9qEpApdr8zW1h9Wd39m+5QBUB9n8KcI4es0LBr9ZDDlchR
	LEotQxkyEEBjO5z842fCBXwrlTMYGpp7rUuWm+enfz7SBB4oOR83RQN+5jQV2TVRkeRjpXZr68/
	xoWYPYsUYPDvvpOMjA==
X-Google-Smtp-Source: AGHT+IFCiIAROvFB2yMO0UCR+4ZQEZ0s8jgRn6oQbNbO878Y9zbld799sNxrnedeLYq8Qy2EigSbEXq7Bo6P6npPVMM=
X-Received: by 2002:a17:907:5cb:b0:b3f:294c:2467 with SMTP id
 a640c23a62f3a-b647195b32emr3912611266b.10.1761405356545; Sat, 25 Oct 2025
 08:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:15:20 -0400
X-Gm-Features: AWmQ_bmbZ8u5CogyggVXgDbcACzApTnoI3lXdk_DKTEGWhLBxFj0guiH9QhsMTM
Message-ID: <CA+CK2bBpunzb9yaQE91NYfp64xSSuRaHW71MC=3bLVfWsHBDzA@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] genpt: Add Documentation/ files
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

On Thu, Oct 23, 2025 at 2:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Add some general description and pull in the kdoc comments from the sourc=
e
> file to index most of the useful functions.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

