Return-Path: <linux-kselftest+bounces-18391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65946986FD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B6B280EC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3A61A4F18;
	Thu, 26 Sep 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lar1gD64"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8032189509;
	Thu, 26 Sep 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342313; cv=none; b=cj6xhDo5XBpQYIedFFZTrXwClPTf9BMgaQoU4KGVHUeL2sMpWfNAMyONRhEmkvUNxWmCtkaMaT9IhSrx2GbxJfIwRErN4AuZwW68DJVNzzxVATZCO+vI2mZEGbrGRkVso/bgxIkR4kALyQLrKM5BOtlv25n7w/lruZO+F4eXZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342313; c=relaxed/simple;
	bh=t+0HprDGIny5DyKaTjHjbUILv+CFyx1UMTMYlJdPpkQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2mQj7xCq+MbT52dSpOEwGjFGjYZOoDZbU/alRoEl4BkNSxMZkQmrXUMW562ohg0c5a9z63qVeLcGwcpfZy9yvYDcO6W70dOJYon/ym/QBOmPjDcId1H4cpadQL6wZgUQ2+zHOtssYyd5V3MCUGyoBcru/PvJ57bF3pa9FHxaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lar1gD64; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so317418766b.0;
        Thu, 26 Sep 2024 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342310; x=1727947110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+0HprDGIny5DyKaTjHjbUILv+CFyx1UMTMYlJdPpkQ=;
        b=lar1gD64TfBFc8/iufyjdOD92Kdt41MDfF5i95DCeaXrmL1JvhoDI4Ftyt9x7imnvs
         9No7I9QkxmCwdIbL52Ao7uyhLtbNpzL17/6zuj5J1cZBXs447Hs7EDsVrWWV0VdCAlYR
         WTAME1kRumBc7hDZdOsfK0Ez+4nGqkV/yEpoLvnEjPk5rXjQ1yyHiom/xi4WVm6nrlzE
         n0hcd3aocS7LX2ZTOm34ebOwKg3N+o4yOjHH5+gnuQaZPPTVyyfbWusIwd81Tg+XNtgu
         He5nPAUdKtBmIRBtKa7x/Xc0kcWAP6VdtDyBTtuwv5q9xaO4rIk7KaNHItxDw7FbI1io
         K+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342310; x=1727947110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+0HprDGIny5DyKaTjHjbUILv+CFyx1UMTMYlJdPpkQ=;
        b=jmXI/+Q1YA4k3cF1c+UKaySWiLRgCvUw+MYU8qFx/RB3JDhedprIyx1xmxNM7HcuDr
         AhwacBsZ7+epMcHL9R5w2GC/LP722quoKAyBcroUsXwzZWcQ0tniy61DkVIfFA1Bejei
         d/YXKWQ0Wzlb1hE0HkznjBU1Xvij+obRROUbnIrLRWjJo9UW766jLxLbLVNMx+kd4qV0
         BztvNnR5V8IaJi18GPtHZwrl1Xq0XPj1xzBFX+CEC29/IJ3SpXdETfhkF7AXwWu/6r7e
         6D7gJAYc12jlm2qNgILRm9Ba2BRpUuAiiQTNna4jiDHM4diDbU+4pxGWZy9CbCbR90xk
         6X1g==
X-Forwarded-Encrypted: i=1; AJvYcCUlhEXP6ULwsVGqAS3XuDwfIfgx+4nfQ9t0RBKvGGDoqpyUTQ4GDNxFxP2G9h7q6byaAehjwHrGS7w=@vger.kernel.org, AJvYcCUn7mvlDZ9l5DIJyzbAoMTw8IVNcYvzxupXXSJy3Awh7o8uplT0zUFZ6TAgOX9njEfDHHI=@vger.kernel.org, AJvYcCVDzPR8p327OzxjWj3Ft28L9wngECm6cXvaLKHaW2Mmdn1bd0Z8zyRGqRx+2MiOlhVibiFgqmNz947YUC7G@vger.kernel.org, AJvYcCVetjNnbH62He4nf9ZDhiPFfSB7k52tQuNdU4xjQ8T8i6cI3sKDbp21p7Sd4oLEwTx7Je81MfQeAuwl@vger.kernel.org, AJvYcCW7LOfb5Rhi+2R50+UP3MJO2l8t6fQ7mQHQe4+rECMHWBNnW19kaqp0ulo4Vk7r/RMuAhwuAGrUlpJtRbgbKlKM@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDALzljmcoP2XgOAKa+IBl6PZOZ6B5L4JeDsHMg4hNwtgpQ9h
	vQ1YbKnheWr+m1izU5GpOVWhFsUqqpSpKouM2RixldQRRJjj+lnb
X-Google-Smtp-Source: AGHT+IGpqNPJK1s6i2Y5LV2mdudC516wJ/Q9mIUBcozWq9rbud6ltBH52LHG9Vz2rsfEkWd93Kp+4A==
X-Received: by 2002:a17:907:8687:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a93b165dacamr300948466b.22.1727342309802;
        Thu, 26 Sep 2024 02:18:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf? ([2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8440sm324989866b.182.2024.09.26.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:18:29 -0700 (PDT)
Message-ID: <21e5d209fa4c24c49dd72ba82dd6e5fc65bf52e9.camel@gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off
 for hibernate
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>,  Jonathan Corbet <corbet@lwn.net>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Shuah Khan
 <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 kvm@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev,  linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Thu, 26 Sep 2024 11:18:27 +0200
In-Reply-To: <20240924160512.4138879-6-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
	 <20240924160512.4138879-6-dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 17:05 +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The PSCI v1.3 specification (alpha) adds support for a SYSTEM_OFF2

Can remove (alpha).


