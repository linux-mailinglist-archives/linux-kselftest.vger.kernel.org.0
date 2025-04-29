Return-Path: <linux-kselftest+bounces-31839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5AA9FF00
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF71D467FD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1DA19D8AC;
	Tue, 29 Apr 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxp8ycpD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34A433C4
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889777; cv=none; b=fR3YvfzVl7+Xy38+oB9QJspFMDcpVqPVJAZ1dQwa2xEonIpmIIrQ8Hpqqa5QBM+1yMIKzwIbVbWi7Zv3eGtPTOJ5dSu0FYKCrFSfBiIIP4ExmFzrKE82dBeyCjWdtYJOcVeUeQzR9INtILV5enTzGcGZQxw2bPoKIc+ss7VVNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889777; c=relaxed/simple;
	bh=lDdvpoV6qxHTWi1ZaNBNMrxyOcf/jUN7/pAntxJBUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb5aYvLVIVsjOH+VDhuMh9bA4UsmNn2DC6DCJQouWhyv1BNXLdmAgjHkt4lhwBwk39Osls3wciaQFi9UJxFzj2rFQ/bCScMYZ0jJkfjjxVXwBOj1FIMbYbyhNR3kTHpzmNMifAim/Nb3rl+sel8hM6Du4MfI/tJXSOAELB6dChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zxp8ycpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745889775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1De2Y8u2PUpjPCXzMy0cWwGfWJHKir9txxa56K9soM=;
	b=Zxp8ycpDUl1BCRrKoskTdV0RdnXuzDdurI36lIOpuGHGS8o7brdMWFJM9F0bbbDSulF5cc
	9HH9Hg3+tkFdTZUhupSapb54OACk4roBtUTq6nHoxyl2exjmhcYvkVV/jznZSDKgNG2WBB
	sN4A69Pi1GPKpN+33spCzJA6KAA7q/s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-97_8gxpSOaChXuV_Eijc-g-1; Mon,
 28 Apr 2025 21:22:50 -0400
X-MC-Unique: 97_8gxpSOaChXuV_Eijc-g-1
X-Mimecast-MFC-AGG-ID: 97_8gxpSOaChXuV_Eijc-g_1745889769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBEB81956094;
	Tue, 29 Apr 2025 01:22:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 690A519560A3;
	Tue, 29 Apr 2025 01:22:46 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:22:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: kublk: fix include path
Message-ID: <aBAp4VUNx20r_fiB@fedora>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Apr 28, 2025 at 05:10:22PM -0600, Uday Shankar wrote:
> Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
> error message) if kernel headers are not installed in a system-global
> location (i.e. somewhere in the compiler's default include search path).
> This failure is unnecessary, as make kselftest installs kernel headers
> in the build tree - kublk's build just isn't looking for them properly.
> There is an include path in kublk's CFLAGS which is probably intended to
> find the kernel headers installed in the build tree; fix it so that it
> can actually find them.
> 
> This introduces some macro redefinition issues between glibc-provided
> headers and kernel headers; fix those by eliminating one include in
> kublk.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

kernel selftest is supposed to run under the kernel tree without installing
headers system wide, nice!

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming


