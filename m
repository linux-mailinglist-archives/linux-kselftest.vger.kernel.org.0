Return-Path: <linux-kselftest+bounces-142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD17EC795
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725261C2074E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FC3BB21;
	Wed, 15 Nov 2023 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugF3OweW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EB200B2
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:48:33 +0000 (UTC)
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 07:48:32 PST
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DA196
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:48:32 -0800 (PST)
Date: Wed, 15 Nov 2023 15:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700062872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez3o0C9ttk5i0lUy5nBMjLkOP010UEr3wabYUS8B7kA=;
	b=ugF3OweWxcO6VMW+nS9tfqdkxzf8F+7W5It4nkO46fj7K6Y11x6rEJzhXn01dWSAFpjrdM
	TPulrHmSGX1JZHwYHUu+Vw+ELnEy8j4dmqmp7tctL793ssOhTrTQI9oWviC9qh5J+cI7H5
	HwHVT2XFdj0Dafjwwp3v/PRjY/On47w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Message-ID: <ZVTmk-u-zUKC4Nrw@linux.dev>
References: <20231115153449.17815-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115153449.17815-1-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 15, 2023 at 10:34:48AM -0500, Shaoqin Huang wrote:
> The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
> value, define it in one place to make the code clean.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

Colton already posted a fix for this as part of his selftests series

https://lore.kernel.org/kvmarm/20231103192915.2209393-2-coltonlewis@google.com/

-- 
Thanks,
Oliver

