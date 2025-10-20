Return-Path: <linux-kselftest+bounces-43636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1BBF415C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FFC18C5151
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D3334C26;
	Mon, 20 Oct 2025 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKJDhg31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DF2F7AC5
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004562; cv=none; b=NqylsQ4ZVkwlc5/29iHoTVLh/jG77KzIqN1lgHN880QU9QLc+YckhffTtU6Fg1BWYOqkEjIEIUyN1Ch7YusWMm3AwHe2TE3WLf0iRgBjUJYqQK+IlSmyRwiolguS+gFKAVT1ryvMiGVIC/NXbMJMCigIjmc9GRVBOuwEBtTG1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004562; c=relaxed/simple;
	bh=mcUKfYrdQSpgEynl2UwsrQ2Hve4TuJQzk8+mUSe+wHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXcwC3reVanXckgKvhPmh6rVkePcBLnRGNFs/5/MZUH2rys+tQqHyNAkXEXGND3Oc2OSEUENIYQjRbJAosoKsN/qyHHBVes2lplysld1k6QeBh3chFFMZec58QbVQkdBvaVOiytEAGhb2ZrsgE0yYinJtz2V3/XSOVPnf4vIAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKJDhg31; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290da96b37fso57165ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004559; x=1761609359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=wKJDhg31+uMG8tNCOQ6dOFikOV8xNjjHTlI0dheKwrNLRKSZyfyIwpHDwsvlHsAgCP
         Vic2x+oWGa9lJpAhMELz3u46qNSngEypjDZ8WfPCe3geqdgnLPYHuO7kwVCnQSwpOTMN
         46c8HkTYok5k8qTzt9sOUIhyfqAdN74wbZsgl9DVbO5BeD1CTSb9osW84mGcO76iTlX9
         toldUfnk5kGkqgXsA09dN5Bc81m9f1lPeywv/2lUSeK7tJN7kH5MJo5pmkIwypdkpqHs
         /G4itnMUYSxFrSvkRJw+VOWpKUpg/5lqDPg47V2r4xwbuioQVXgV86GQUK25w9+m3fZB
         mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004559; x=1761609359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0nnZ8bRb5CyQ3D4M/BOIhfpk20sndQZa2pgDITOBD8=;
        b=Ju5BDDevlEeMyTky5G2S/dU3v1oTJ1cqyHtv8LWjNk7Hodtb93DaRmf3eUH6MO6HER
         UBsg+Iy55pIi8ncQ+SUAjNko03/ByoQkBX40P38gPxOMFgiCXdE+qVbuYuCiTR4SJKJM
         GdRwJPOC5oU0jO07+zo9uuS9JDxI1c3UYpBRc65+2I7qyczDRPXG2WrDVuFAYwSsm02K
         QLCdg0xiCEodg6goZzXBI6HwdQKfIGIzl5dl9pw+1CCaNzgc74StmUZALBb8e1Me5QvV
         oVuRw66vf01grgpa5O8lFxChgsRhKlBhX3lWN+SwtzcVsdCs8aB7L77yBbcjzr6lZUyS
         kDrg==
X-Forwarded-Encrypted: i=1; AJvYcCWbg/3ByfSxX+ZHqOojWAN389WdfYr+yJcfxW1/IFGILq24MiVt4v4/EhF/mM6QvQHku7vytI8sRm/zo5YQEVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxD/0uv7SdAtgnh6vR8dkqeR3/GHB62bjN9VZSJuJ3SbUZBtXg
	QGqzFoxsBoLBkGXdDBOLDpq9vMEclQO058Pqi3RozVtWlvDxjf75qaZ6W5f0PTHtnw==
X-Gm-Gg: ASbGncs2YJFsC5rKmIVaihVBF5O0iY4fCbYc9HzIFFFW8gMd6/X5KIc4jwYgtSecv+A
	Lbuk1djJAcJTKMFKNK6XZPplufKkDCYNQpGhd8JBs/GKzsVDYNAPm89es0AHrVVLCKYBqZmXJvJ
	PBcf4BSD8D4qkNOjLMUwIh3Qd1GlrljSasIRkgr+Lf+i4WnShGqO5+LYv42BgBat9oXTf8TssUE
	gYM2tZTcwqBFaL1Cg6Ym+NQi0LtfejOoe+7FWK45vRpHqca7AX3sR85Y2O8tFcnSQYkKNoTtg3m
	kiJUK0HQnn9y/1YO2UcTnCLfSAcCys3eg/Zcxbcgb5pJUfSOLg8yaBcy0rxwMnajAO7c4w4qRK4
	LYYkFsc4KZU9fKwkRASe4bbSjtGSC7BpvA55sQbP5Xrf4eAHvhwQTaLn+M8J7aP7GEyWGtKAOTv
	ttroK9vFUp+WNL8+Uy8MPsTwukJX9g++U4FtDN8G0FgCbE
X-Google-Smtp-Source: AGHT+IG32aKEvMqQdCicoH1rwzi9rTqB/3kzHLOxoWRLdvRJmMsuPKuV9j72408kyB6QWaxlgj5D/A==
X-Received: by 2002:a17:902:e547:b0:25b:ce96:7109 with SMTP id d9443c01a7336-292de616a3bmr863795ad.3.1761004558570;
        Mon, 20 Oct 2025 16:55:58 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8090csm9243673a91.18.2025.10.20.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:55:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:55:53 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in
 VFIO selftests
Message-ID: <20251020235553.GD648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-19-vipinsh@google.com>
 <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>

On 2025-10-20 13:50:45, David Matlack wrote:
> On Fri, Oct 17, 2025 at 5:07 PM Vipin Sharma <vipinsh@google.com> wrote:
> 
> > +TEST_GEN_ALL_PROGS := $(TEST_GEN_PROGS)
> > +TEST_GEN_ALL_PROGS += $(TEST_GEN_PROGS_EXTENDED)
> 
> The TEST_GEN_PROGS_EXTENDED support should go in the commit that first
> needs them, or in their own commit.

Yeah, this can be extracted out from this commit.

