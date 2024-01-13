Return-Path: <linux-kselftest+bounces-2937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F482C892
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 02:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2316EB2256B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DB10A27;
	Sat, 13 Jan 2024 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ue2NC0Vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844E10A04;
	Sat, 13 Jan 2024 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=07FRS5V8yga9hKrKhnvPUx1n6tTm1VY5TNI0fw/V2Jk=; b=ue2NC0VidzNtsK51pBPASyttm/
	hKufMijxcnJs2olOQ2UH2Xpw5z0ZaVB1kjJRv+smf1Yku72CGRMoVIm97rsZfifOjVzPP+8+Q5sA5
	ee3lSm0xVVIfN5layVfciUsaINpKF1h9kKYzfbAqbA0KP/FXG6HjzQ6OKU5hiEu4afTjhdL4fWFrt
	0y4tJfPluBwQlBInv888QF+v4klP86TdSQlmjSfHoE1uIO2+leGufS3GMJFWXcAACwkEmbZFLFYmI
	6z6h41V0vW7K4PGaMjuOo2UWFfQZti9w3q0LM/KaTXvlVRZLfxA9S2j+rVyZbpJ5Lk81jdfcv4rlZ
	6aJH/+Sw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOSXL-004N7g-1K;
	Sat, 13 Jan 2024 01:10:11 +0000
Message-ID: <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
Date: Fri, 12 Jan 2024 17:10:10 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] mseal:add documentation
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 usama.anjum@collabora.com
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240111234142.2944934-1-jeffxu@chromium.org>
 <20240111234142.2944934-5-jeffxu@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240111234142.2944934-5-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jeff,


On 1/11/24 15:41, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add documentation for mseal().
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/userspace-api/mseal.rst
> 

To prevent the following documentation build warning:

linux-next-20240112/Documentation/userspace-api/mseal.rst: WARNING: document isn't included in any toctree

please add the following to your patch 4/4:

diff -- a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -23,6 +23,7 @@ place where this information is gathered
    ebpf/index
    ELF
    ioctl/index
+   mseal
    iommu
    iommufd
    media/index

-- 
#Randy

