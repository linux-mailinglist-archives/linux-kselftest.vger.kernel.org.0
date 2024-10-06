Return-Path: <linux-kselftest+bounces-19121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F249E991C91
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 06:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BFA1C214F9
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B809339A0;
	Sun,  6 Oct 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S4sResj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635E7F6
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189356; cv=none; b=LbMry1bQNeS2/6hN+qPR27GIvSWZf/Nnoos0jd9yBAsMrqCR/kpsokZFv5wIOwSluWZgi3rVy37GdtsNeZ+BuRM116Kc4LSbB93UNlyEcU9XgUS48YwRiwkI///dF/fuAPjlpHE5JdmNAeTfUHXRytA35BzobkywpU0euU6BHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189356; c=relaxed/simple;
	bh=S6ZASsw1UbkwNCy/qT2cst33QvKpaMRTJ+1FEJnQDeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpmaRd3GMpNMbGiBbOzSGGl8gkIkTU0ZIc8hrJByvdQ6AfbtJHlRIeE1c8lfsRhwqRPEsXMKc0CAZ2388EsUemBiDombyqShFduRMc2C3iL7FWoJRcu+mk//yWcG8SLx9pPzgk1S6YViPtWpGV6c/p++aiSCFa5121Do0j1zkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=S4sResj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F5BC4CEC5
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S4sResj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728189353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ZASsw1UbkwNCy/qT2cst33QvKpaMRTJ+1FEJnQDeE=;
	b=S4sResj+lRflx5qjLUPuYzPme0/6WxKp7EE1CCPGrqkRyiGwGao3PBK73ddsHf7VdZa/1j
	IkHG3XlJA3DQIQH7YGI+7SxaoZ+CdkAS0/Msy9Hb8UiV6IfH+NkSENE//h9JV7cSEPbYwC
	jc3K9+HXUs5g0EWAUE2x6Gc8j2J4Hn0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bad6552d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kselftest@vger.kernel.org>;
	Sun, 6 Oct 2024 04:35:53 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-27b7a1480bdso1512358fac.2
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Oct 2024 21:35:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWePYZOiQN1k17NzDgcUOLR+LNd+lD6exgM2RQ22DFbOT+v8eUmUwG6z/LxYMjkqxew1XC26A3JHvGkYDnEuSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJ0JDMWK9rM9rOVr0T2Gus1H8Z7Nz2er3WbuoCj/VRUQoDbaI
	p5vdcfxLvG7aB+n6zB8ncW7vwBOJKABKTZthG1Fuz3XgwRsZ/WFeItRItt/XrEKmNuHsqlSjud3
	kuDqFIEnWuispTQ8ZrVvh95clCSc=
X-Google-Smtp-Source: AGHT+IHmmlNVfDVgKfoHgHGXP4e4P1j3dDWAH6HdIBvDuclwvTe95zu1Nuzoefn4l/yJV2kG5vGvqWoH5E0rgIXaeRU=
X-Received: by 2002:a05:6870:2191:b0:277:eea4:a436 with SMTP id
 586e51a60fabf-287c1d3f145mr5983709fac.7.1728189351962; Sat, 05 Oct 2024
 21:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003031307.2236454-4-Jason@zx2c4.com> <ZwIFjL7yb+7JpTS2@rli9-mobl>
In-Reply-To: <ZwIFjL7yb+7JpTS2@rli9-mobl>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 6 Oct 2024 06:35:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
Message-ID: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
Subject: Re: [PATCH kselftest 3/3] selftests: vDSO: improve getrandom and
 chacha error messages
To: kernel test robot <lkp@intel.com>
Cc: skhan@linuxfoundation.org, greg@kroah.com, linux-kselftest@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I'll send a v2.

