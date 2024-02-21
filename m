Return-Path: <linux-kselftest+bounces-5119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94185CE22
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA4B2461C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA32B9C4;
	Wed, 21 Feb 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzVI/H5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D138FAD;
	Wed, 21 Feb 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483178; cv=none; b=HpfKxo2fVMT4WbXslCDFIKPBKeGDmlkSbed9hRMEtesXbnjCuACdsDmff07LcYiz74Uzjgow0N54Ghp7tDpnCPkzY7DJjgwT7wkXt8+u/GCzX/lGPG5sQ+nn1nfdTT2SgnnDgm8o565PCJ3vaioAc5Pw3pI0rHGeqEhDvw6y6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483178; c=relaxed/simple;
	bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gb7CIeLkOIFbpY8Cb6BKNSJvnoKSdb0M2wt9MQpEw1jzbnB9wfp0ZcZfmo2iyu+ymPsFpVOLb6iyMt55MPXUlOoh+yctqX8yujhNXS+ZEmMmlheYvhnNImdIe8IgM3OdVsN+A9IzF25WOwEr9U1a5v3/OlUJikt4lY/m+6NRlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzVI/H5n; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7476a11e0so169466839f.3;
        Tue, 20 Feb 2024 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708483176; x=1709087976; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
        b=OzVI/H5nBQctbftpl/IRIrbCDyUM7ydFt1MDeAMbSPK/poCT7jmvnu4biTmgMHB8SK
         IL3VrXBT/cvu2EnJD413NfhgL1pZOHnTai5yK4XqR16+uTYk/D7BWgRe6a8fQ4RxFtRt
         aFc31Te4+xaTYhMP4iMG9Z18XFF7Z0I9/bcbQa4nC1E19zCdTeUjVuzJUMIMHlXoeXyx
         6LNji3/h4jAMZQhDlW7DXoMJ6WCeKX20/H8ei3DdvU0VgYpGS0TOTew6O/3K1DqjQGe2
         Zw17VWwgWEZApfQUmw44LrmGBNyNTKorUNHXd9tyck3TTvxdvYhqxZ/+/R1SiXfDmW+S
         Xnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483176; x=1709087976;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
        b=q8LRCi/kkqRsqfvBvU1c0T/xRKtmB3MAvjXhL6BwL298ZBIeMOLGf+4eyI+Zj7OKX8
         srEfyQILkK4HMud67PmFPzbpgJNvmIksRiFPPuYFPuoCIJNeEBkHTpKB0zjb3znv5wUv
         HqjnsxAnEHrVvPL9EOIRwGuAMFTuzOTLTAykih7iPTguQneI755dv/WfxAwonmfj57EQ
         6r4hrNcirFg9wN5a5imtIxNkYY5/bTMALbFTWUuJzv0JS0bl9qbBvS4LtmNZwVQnVF0O
         0YkK6VGzexBsVClHWZoOddCt6gBJ+HvS7TuBW/aQfXbFeoNldHSno8PhLYUJBmlra3xO
         pq3w==
X-Forwarded-Encrypted: i=1; AJvYcCVoyK94K3da+ry6UsR4F1uW/HURKkNv77PzxFNNEhl1wfsbQsQ5+aKkWj6+1TwfF1BpKYU2qwW770SWzIsuiE0zBA2ao45qdGXpoYCEONDiaPPDaA/5+XoIkVN8nzdWe2bxl0KAHctc773FyZ+M7+cleo1G07z4UJD4Ck4ypnhnC0X+KYn/SwdrxALDFg==
X-Gm-Message-State: AOJu0Yw2mhuRudz/edPpESLlfM0dysbWoQqsb061BhcLEJ9d39hO/fAo
	CoZ5qYSmYxmFFTQk+hu7MQPHaT9OVwIctanQDG2L1Q+MaJAPkews
X-Google-Smtp-Source: AGHT+IHdPAzRPM+453B1bOhsVK1YUxRorHpbtePN0NVHN/mgjkN53+mUpvIbAhWaEJYcYdDHjuy8eQ==
X-Received: by 2002:a05:6e02:1be8:b0:365:4b67:df58 with SMTP id y8-20020a056e021be800b003654b67df58mr3177116ilv.0.1708483176054;
        Tue, 20 Feb 2024 18:39:36 -0800 (PST)
Received: from smtpclient.apple ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id q15-20020a02a30f000000b0047447882b41sm20027jai.48.2024.02.20.18.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 18:39:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
From: zhang warden <zhangwarden@gmail.com>
In-Reply-To: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>
Date: Wed, 21 Feb 2024 10:38:56 +0800
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
 jikos@kernel.org,
 joe.lawrence@redhat.com,
 jpoimboe@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org,
 mbenes@suse.cz,
 pmladek@suse.com,
 shuah@kernel.org,
 skhan@linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B052E4A4-3652-452F-B4F9-F36860143CC3@gmail.com>
References: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>
To: Shresth Prasad <shresthprasad7@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)

Would you please pasting the original warning of your complier?=20
And did you check your source code if your source code is the the latest =
version?

Regards,
Warden

> On Feb 20, 2024, at 21:20, Shresth Prasad <shresthprasad7@gmail.com> =
wrote:
>=20
>> What compiler version and architecture? Are you >compiling using =
flags like W=3D1?
>> I would advise you to always add more information >about how the =
problem
>> manifests, and what you are executing. This can >help to nail down =
the issue quicker.
>=20
> I'll keep that in mind. I'm on an x86_64 system with gcc version =
13.2.1 20230801.
>=20
> I'm using the command `make -j15 -C tools/testing/selftests` with no =
additional flags.
>=20
> Regards,
> Shresth


