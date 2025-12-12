Return-Path: <linux-kselftest+bounces-47502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385BCB89E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9E33051620
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC431A7F4;
	Fri, 12 Dec 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHJidu2x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0C30EF67
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534898; cv=none; b=b/KOAJfCCrW3IZcPUijO10gIj0gdZQM9MZ1oslVXs5jBSJE4C/BbpYx9thv/tH1P7caGmL/HIIQgZR3mXvFORUjAN6/LhqC20rskrjvOGthXLdij6SKyw7nYlMdnVtgsfdFrWWgemfGUcQZIfuw6xoxLCMKUZcoQYOK6UHj1IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534898; c=relaxed/simple;
	bh=awUymwBOhC47itu7ecucOMoWbNKHt3Ez/u/Movb3JeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI8lF5xjh8o7ZcXL2Cx5YLjrvxe3JoR3cjWKiIEfsouYla5Sar4Jnk8OG37mG5+JXXLhAVLKWiYijj2ywPBBO7j+hmJR8lGj9QwOzstp2A66blo450Xx7H/Q2UWAC8tU4P9Yxv05yG9aOYi6IwQk5y3bKES3fT7mli0dafynDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHJidu2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765534894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6Lor8Lpgp2EoSCBr8xGXTWBkjbzDfRr36NxSS3iwDg=;
	b=KHJidu2xyr3q9dbybQgx+LwsLIDjrD3eCWH+esO9eEwM2poM58jdJpMRqmhfdAxxhpbv1t
	x1Ej5YGyH02+TKKQscfzVmLlkupcVf2J7AKFyDegH0EFIdlnowfXLKWqnjvQBjXa4UlYGt
	h0tCx1IA2FUCQVGJgaLzwxEZYrbKlyY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-mVY7mouoPgezxasEN4OPWg-1; Fri,
 12 Dec 2025 05:21:28 -0500
X-MC-Unique: mVY7mouoPgezxasEN4OPWg-1
X-Mimecast-MFC-AGG-ID: mVY7mouoPgezxasEN4OPWg_1765534887
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94C47195608E;
	Fri, 12 Dec 2025 10:21:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1D51180044F;
	Fri, 12 Dec 2025 10:21:23 +0000 (UTC)
Date: Fri, 12 Dec 2025 18:21:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
Message-ID: <aTvsnv9aGxJZ486D@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
> stress_04 is described as "run IO and kill ublk server(zero copy)" but
> the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> test cases is duplicated. Add --auto_zc to these test cases and
> --auto_zc_fallback to one of the duplicated ones. This matches the test
> cases in stress_03.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


