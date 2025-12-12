Return-Path: <linux-kselftest+bounces-47494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C853CB808B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 07:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABA69300A573
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2BF30E852;
	Fri, 12 Dec 2025 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eqq1yAh2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3941E487
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521071; cv=none; b=KihURsqn5cWi9KQ0wxCP6hMy/7m2RtszQ7mHFL7yeXqiFwChkzdDU1ec7HPTbLflZrpV1KHAOgWQyW39RYVnWzT1w8RkBc5f6/NOkWuRy21AsXdvGtXdwjtJt5WqObb5cTSL45WxxuAA/pNWq4QZ/LzSHEVQ6BQGHKKP0UXQ7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521071; c=relaxed/simple;
	bh=WHfjJAKVkIUXIYSx6rWIPbnGvhEHiZRS2sMWHC3xBHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPmhORZtPntUJiPq2Ai6NZiWZgTuJZej+uau7jDSwf2es4+IpZB1p1U4a9y6KXDGnxq53nONKdZ8FFUJPTj4gNq9bnHFShJxCYOWeCZ9SzUOOamYZWcNZ+0CP8ynjeG+PfhJoJIyMdUDpXPnqDidLRDncni0Rot7Ppx4jBz4biQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eqq1yAh2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso745269b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 22:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765521067; x=1766125867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU9rsCRRgIidE7+HdxiRFrmvgyo9gOWJIixuizT3mjw=;
        b=eqq1yAh2typbZCt9Cac2k41yuJx63OB7KJeQW2P431JY4tdSetAPM19BcIOVU+1yBD
         COf+KCjXlRSFS2ugY2rczB7ICFW4yHGDo9VftJGNLhjQn0JAbV2rqptaoWgFe42yTRpD
         Qe6lFCtdKDjGB8UnF1CxHHtFiQ28W4z2hFox5Phg0HpIej1Gtou9kDBCx4OOga+hVbKK
         dASqQkW1uEw2LOk7mCFI3FfTZfSfvboLPEFWqr01PBJNmRvmIXE294yUSLhaj5OXuDM/
         GM5BLVamLUmUWpRVzTWY3fHIF+qcxFgFi2HiZQs1+efUcNNtD4oUi+IZEXkfOSDHVifG
         2Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765521067; x=1766125867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU9rsCRRgIidE7+HdxiRFrmvgyo9gOWJIixuizT3mjw=;
        b=fEmeQm5u7Ui5DvvnALQUMw3RGLhVE/b/SS+9bu9oyJiw+7pF05WNrRcVkuaT0vb87D
         7zpxjKvachYjzSQTDaojjrjt40GXz3K6d2PZKfYMVJa5td9lDOxinGsh5xIGWAisVLG4
         o/O6pPp/3cwBh60JBm7Cf4ZrT1Jl2D5UQGsg/bX7Zm5Z7cLGzOC3ucP64xvsFf/gGvNf
         C3HZfdFqY75vnwYIO6GE0i3y2Waq9Z9zkiUfwv2KEIhetH2y5WtJVDBI5G1MqJGM/kmB
         KdO6gPBb6sGDD0f6KbMXNxASV5Z0aRTUg2DK9MPW+rAhkqwrxbPRoCVzepBiOJh7LZKw
         bJYg==
X-Forwarded-Encrypted: i=1; AJvYcCW21aXaIqI+poIwDOIYfjaXN5a/MV/BuAbtx/H/UdJDnUPLFeY1gI4fBYUy0xrMFueSSgo6OEB1/5gk+3uJtjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVjQ8XPlnWEm8m9cZRj7dxjxGKNCATyJ+lrKL6/lu4HbiJ5U8
	1rX8/rN/lB9Fn5NhGhys/De463rMyaA7dq6ch9qkzbG19RBuqxSFKqxtZ8e2VrFPIyavqzwWVuB
	qy4nFPzQ=
X-Gm-Gg: AY/fxX6Oxjd/vwmR8ewirVu2sAFGsJcWEWJir12vq5qmEmhvg/rfY6KtAg5X919QVe/
	EzVwiQ1XV8uDm9EQ6xFERS7VXyrmnJ6XXM6j2f/qohrNinmPeOmlCiuzxfLTxWeQ5cs4/U/53+M
	l3Gmca7ZSXdW48e7gzc5vXOk0RJBYTzd4NMPprViJe6WAjpMZNvj3lWSZ7DMc+BmaxlqUjIHb7u
	VHSXQ9nD2a3t3usy1x32BOB+qFKLS69qSnfjhcIsJRlnKYwxZXxZViGtpIJjsK5dVPo6jTyzsa7
	UeyHExmYuBm6l3jF7XvVPPi9hKk9rVY6r30g+ADtc2pvUsL88Voeu/+4WnPMrHlsvIR4BXlGcYa
	JnOLYjr9nC2S2lgn5IzMHXTMAB6B50BDEf/NSPLJ+IqvtlGcG8mgHUYj6paRDGdrXyZhipBVIt4
	QHJN8Rl7E8
X-Google-Smtp-Source: AGHT+IH+qDNBAAjjvzDFg6yVuXzSvyQ8clec2E1T7VYOcntr6/9AB25tUSNDsi4QD0DIx45+xLR/mg==
X-Received: by 2002:a05:6a20:1584:b0:361:3bda:7155 with SMTP id adf61e73a8af0-369ad3fc3eemr1099607637.7.1765521066910;
        Thu, 11 Dec 2025 22:31:06 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2284da4sm4138329b3a.2.2025.12.11.22.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:31:05 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTwgA-0001rC-Tw;
	Fri, 12 Dec 2025 02:31:02 -0400
Date: Fri, 12 Dec 2025 02:31:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.l.liu@intel.com, nicolinc@nvidia.com, alex.williamson@redhat.com,
	katharaasasikumar007@gmail.com
Subject: Re: [PATCH] selftests: iommu: fix Warray-bounds in get_hw_info test
Message-ID: <aTu2pgId9mRPPIRj@ziepe.ca>
References: <20251210211342.989850-1-katharasasikumar007@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210211342.989850-1-katharasasikumar007@gmail.com>

On Wed, Dec 10, 2025 at 09:13:42PM +0000, Kathara Sasikumar wrote:
> The get_hw_info uses a smaller user buffer on purpose to check how
> the kernel updates only the fields that fit in the buffer. The test
> created a custom smaller struct for this, but the helper function later
> treats the buffer as struct iommu_test_hw_info. This makes the compiler
> warn about a possible out-of-bounds access (-Warray-bounds).
> 
> This keeps the test behavior the same and removes the warning.
> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This breaks the test, I already posted a fix, it should be in linux-next.

Jason

