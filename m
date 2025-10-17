Return-Path: <linux-kselftest+bounces-43402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C479ABEB2F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465AD1AE2EFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393230C617;
	Fri, 17 Oct 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdszF6i3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD162561D1;
	Fri, 17 Oct 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725152; cv=none; b=j03rYHEx3fJeIAjHpHUybSjqOgYW/G0x8/2jyDOLtMyDb7DUhtQLa304Si3tfmGluICGzHJgzymwgtGrTO2f5aEBn7EcjSALSUw6YJNHg6kYDeQ0tEpyINt77Hudd0XxuGSPJjdvUUO42cQNEQPMeVXy3zu5kmGpBiHl3kVQLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725152; c=relaxed/simple;
	bh=6c2q0iYFzUJcTv6Ww3TyQ8jSACvrFIEXN2r9O92STN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnSbjFPrvFLPECES/QtFlL4PkkIxv8+rNocABS28NERZLECFLBKc4m9QQy+E8zGpLWg9NzkyStwuuHCQfmCy7XZ87ZWktFiIkcdXtoR933PcQRKJoHpJlxCnuiWSAtFZKiUU73lBaGHHcRIdy3AJYkOcrbWOsnGnN1gy5iQlbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdszF6i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C11C4CEE7;
	Fri, 17 Oct 2025 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725151;
	bh=6c2q0iYFzUJcTv6Ww3TyQ8jSACvrFIEXN2r9O92STN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MdszF6i327SkDG8OozqcMmVy870fbx7kUUAbdfQ1maQSiY3ONgzhY92B+LpVT9bIX
	 Ay0N6wWTGPxa1VBP+9hBCAw7x/scVMBtr4mvgse76Y6J3Oe+tz/9vFXY01sQNA6mcx
	 DPXFxqYdJnsgOsw+QWTdmSbVpzc05R7PcWRwTgh+j36uWXPwmo5tcPuZkWRLcmqcXa
	 GVh0AjuoBo+GafGKfoKrNDUomoAC4jsvXElhnRxkeOYJmtRklTjtrBCrHcwfsfTX+N
	 pHaW2pgn/zZcwGLaDyzEom6PlXgikgC0TbSj+Q4AfQ8+sSxavBXW5C2nt20ylcOkyg
	 acoqeX1frVVkA==
Message-ID: <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
Date: Fri, 17 Oct 2025 20:19:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com> <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com> <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
 <20251017163738.GB316284@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251017163738.GB316284@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 6:37 PM, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:
> 
>> I'm not sure about MISC device though. Unless there's a good reason,
>> I think MISC device should be "fenced" instead.
> 
> misc is a very small wrapper around raw fops, and raw fops are
> optimized for performance. Adding locking that many important things
> like normal files don't need to all fops would not be agreed.
> 
> The sketch in this series where we have a core helper to provide a
> shim fops that adds on the lock is smart and I think could be an
> agreeable way to make a synchronous misc and cdev unregister for
> everyone to trivially use.

Sure, for MISC devices without a parent for instance there are no device
resources to access anyways.

