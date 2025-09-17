Return-Path: <linux-kselftest+bounces-41647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5DB7C4B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FCF327BF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426B72F9C3E;
	Wed, 17 Sep 2025 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgerEsju"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAA2F7AC3
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080434; cv=none; b=rSe4zx4RPbSV5I98EfzsusKrvpySzdjShvLKCQfLHA/K2QdEGwdVr4pqUgLQ73vJ+Z3ORK1UYasjC/YuZCO3KazxYzejxYhg8wwqb1fkXJPz1xR7SFH9UOikoaMrPy/BnPU45ctZoZjhiPMeijINp+4sd6J1OmewTMqSEg55nNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080434; c=relaxed/simple;
	bh=piyHsypl3GXPi7gLgRDu2bhAxZZutaGxhkD65yAKTno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjKRqEuSNwJUC7ValeCtnEG4WUKyo5jzHDT6ZTgox3HTu6cmErWwSPG5j1ORvkP+CLpTuVghd2SmrXZxLbi8KjQcVAiZC9bXw36EX56aMmOvhPyzRSGSSAAsL130ins2uBKCrlRh3U4BWSvk+znIuLiSQdAqJAROkew2U53W4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgerEsju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758080431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNouETy1LKz/oc6u4FY58QTKf+3DfpDxE9rTMG3lvow=;
	b=LgerEsjur4Qtzbbx5Awk88RZiyIagjwKZLThd8fYkUBRq4yLzl2bE6K1zaqDnthZh4sPxN
	2mtGxc6wgYugnBcfT23M8itXntT+PKqnxQNvF0e2IbzUC+ppGwxY0aJUwEA2Tv5kPN1RYs
	5KNHgEAJe0Cg7z5T0kVSqhqqOFWjnbo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-GoyFwYYQOMiBJ9K1CWKj7w-1; Tue,
 16 Sep 2025 23:40:27 -0400
X-MC-Unique: GoyFwYYQOMiBJ9K1CWKj7w-1
X-Mimecast-MFC-AGG-ID: GoyFwYYQOMiBJ9K1CWKj7w_1758080426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CB1519560AE;
	Wed, 17 Sep 2025 03:40:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB263300018D;
	Wed, 17 Sep 2025 03:40:21 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:40:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Mohit Gupta <mgupta@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: ublk: fix behavior when fio is not
 installed
Message-ID: <aMotoKv7vMddunno@fedora>
References: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 16, 2025 at 06:42:52PM -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01, test_null_02, test_generic_01, test_generic_02, and
>   test_generic_12 try to run fio without checking if it exists first,
>   and fail on any failure of the fio command (including "fio command
>   not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> Fix these issues by adding _have_program fio checks to the top of all of
> these tests.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes in v2:
> - Also fix test_generic_01, test_generic_02, test_generic_12, which fail 
>   on systems where bpftrace is installed but fio is not (Mohit Gupta)
> - Link to v1: https://lore.kernel.org/r/20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


