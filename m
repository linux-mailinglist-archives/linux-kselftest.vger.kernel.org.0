Return-Path: <linux-kselftest+bounces-3126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAC82FD10
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6ED284438
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2701EB57;
	Tue, 16 Jan 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBmMA7aF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AF1DA4B;
	Tue, 16 Jan 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443568; cv=none; b=H5QeBYv6oaKPg4ldMTjNs2jw7JXdAaWnj+PBf0jTk/CmLBSlF1lXzOmB9hE6iMN11uvZSlXmwbcdMZ9coWEHjn+q3Tl0/NrbmBdcPvC7qiy9C1R5qnmLkAdkImxjEDDLuaP62I70T+RjLCrnWzwIS1Xjh+2W+g4zEVtZ7bW6K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443568; c=relaxed/simple;
	bh=ik2oY4JRBWR6rvEPEnHpEDt7BIuzwUBEczKTn6ckrrM=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=U7jqotkhmzAZVId3rugjDST7f8vjHsSKVrrFDrLrnrc1xQHyrajKAimjoAgeR31nP8nqOyJbv2sYbcZvotdWS4rWWg16/YBvFn8YvPbT0DH8Cg57ywfVy8ZKY2bsV1g4mOko5aTYlYou68jQYoELJ1w9JE0/iu5wxgOWhRh95TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBmMA7aF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gO384S22CcX+AdiDGbsRafLHAmf11EYzzlC346GiPdM=; b=FBmMA7aFfDHBS2zFkio9GGDiKl
	ZYzNT0szbWM8hCEJuCQ+iPTwmBOafYjkpJQPMBLAJnud3AP93Bd876K5Zf6c1MGEkEIIlZDBONZ1X
	T9BZIN44Qu+gH1bQAWgC8Fx0fr8mxnnGSPazpkheTe4P4gGJa6+DZElkjCld1yNmIG75b/IcA55SK
	FFqzIl9KYx63A94AQ05E2xMmBfnU9tdP57Goa2T2T2hqajs4H4sLNS2WLjINPz3c1BWK2xg4CParl
	BqMzaxTz4ReP8a9XOv2yheWr/dBlEuH2XX3XDqZoJvoFWF8ckWBrnr0wnNqdV5g102f2naP2Yv5Fi
	ApJmfc8A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPrmD-00DoD6-0D;
	Tue, 16 Jan 2024 22:19:21 +0000
Message-ID: <c16ff365-6d7d-40a1-b096-e4d5cc127c68@infradead.org>
Date: Tue, 16 Jan 2024 14:19:17 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] mseal:add documentation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org,
 akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240104185138.169307-1-jeffxu@chromium.org>
 <20240104185138.169307-5-jeffxu@chromium.org> <87y1cp9gvd.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87y1cp9gvd.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/24 12:13, Jonathan Corbet wrote:
> jeffxu@chromium.org writes:
> 
>> From: Jeff Xu <jeffxu@chromium.org>
>>
>> Add documentation for mseal().
>>
>> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>> ---
>>  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
>>  1 file changed, 181 insertions(+)
>>  create mode 100644 Documentation/userspace-api/mseal.rst
> 
> You need to add this file to index.rst or it won't be part of the docs
> build.  Sphinx should have warned you about that when you did your test
> build.

Yes, I have already asked Jeff to add this to his patch:

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

