Return-Path: <linux-kselftest+bounces-3705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BB8415D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6C1288646
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3D4C605;
	Mon, 29 Jan 2024 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cf1MSkKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD73DB9B;
	Mon, 29 Jan 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567827; cv=none; b=igr0bdk/AsCDRyvJEzMP/NayUCvfvCRg1NsDtTKAbG84+nc74MHAgmiMC2LsgDo4hep1DC0dVCxvmflVsvJysyLJWDEeiBdMaZg43wmCSrRMbQg+JVNIDZILsOg5ooUhixiUlZGCpuaGPz/zpgr6MuiQZNB+MzwznNDiDCd+5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567827; c=relaxed/simple;
	bh=wUepOEIuKF+pt+mzZ2cf9etKM0arZg3q5iaJxXS0bzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c6xjihqPNaftBxYhcTnj0HK4gY+Obt5HH8z2NpilaB0vEDvPHB9RZOijztBgh9eLwtusNSkDw9umFUf6HG4DlLJaxTd3ffc40mgpKMDgKR7ECK9FQbTTHKEspNZ2p8dFPxHRbzNAg7ZUVSME1VR1wGGdrConuwgsO2qDn4zWDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cf1MSkKV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3240145ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706567819; bh=yAQLX1Us/QviIhk0kzQZyMSxjm5vzw6rQEyBltA/iOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cf1MSkKVSY/OCJo9th/8LlckbTbMMN2vX+Va6XC28KEHxn2wQ+7vhiRCkeE2tbUAX
	 wz/3LWvvkxUbuF3Ng4gg4PTrMqIa3CVMUj2qRrpmRxWELO6bi8a1St8oGfQhk1mD2a
	 AuSKk2U124EDipQwFM8kG5/Q/rC+2254pIn+A7Ky6SC1y//6BE+0NfMA6cbtsQPcJr
	 B1oYQRjJXaRX6ppsqE20RM6u7zudzYsojUlRW5rLTAB0PaxuO4eUSnHtaMxCEe10MG
	 0BTo8rYazwWruk4gOc9g+dSLsDhEyBovIWdrvSMKLiGmzM0lKfW3zwpsZ+W1X1M/eU
	 rhUAYLY4uTGrw==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3240145ACB;
	Mon, 29 Jan 2024 22:36:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 usama.anjum@collabora.com, rdunlap@infradead.org
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org, Jeff Xu
 <jeffxu@chromium.org>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
In-Reply-To: <20240122152905.2220849-1-jeffxu@chromium.org>
References: <20240122152905.2220849-1-jeffxu@chromium.org>
Date: Mon, 29 Jan 2024 15:36:58 -0700
Message-ID: <87a5ong41h.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jeffxu@chromium.org writes:

> Although the initial version of this patch series is targeting the
> Chrome browser as its first user, it became evident during upstream
> discussions that we would also want to ensure that the patch set
> eventually is a complete solution for memory sealing and compatible
> with other use cases. The specific scenario currently in mind is
> glibc's use case of loading and sealing ELF executables. To this end,
> Stephen is working on a change to glibc to add sealing support to the
> dynamic linker, which will seal all non-writable segments at startup.
> Once this work is completed, all applications will be able to
> automatically benefit from these new protections.

Is this work posted somewhere?  Having a second - and more generally
useful - user for this API would do a lot to show that the design is, in
fact, right and useful beyond the Chrome browser.

Thanks,

jon

