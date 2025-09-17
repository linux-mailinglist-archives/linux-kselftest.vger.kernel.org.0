Return-Path: <linux-kselftest+bounces-41651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A9B7CC6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A031B25B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA226E6FF;
	Wed, 17 Sep 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPG52uPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09E26159E
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081173; cv=none; b=Yu73htYNsoF21CLIHsuDcj9t5rl0OWvJ6ecB3PJbvg03uwxlVfn9P2r2LA3v4dy/OXII1nTidHiuGNDzfXWLEeakcr4kwgpkZ50jYS9UM28jvLSDwUxRBewCU08RYgQbbx6IMSApYFRglCIN+EjPlFShqYlXms4upGsJPDWMshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081173; c=relaxed/simple;
	bh=CBOTbMPLyW6Qri05HDDpBJ2PvCULc1vyqw9jSPetlDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pynSjbjUR4tVrURGm2Kl9Oltjh4nk8bH0Liy1yc4gV0HONlAPeaPUvm9BUUQlNOfbNwrkaOjfjPgZJoCJbNs8Oh/Oxqrt6DBGpywGasJQpzvPKfnTx/idYMFzvKaENPqK7Iau3GDpROsr1RYquDtDtQPMA0CQ3WIJErPdG7tRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPG52uPB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758081171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrKEzK18eUta4tCPwqfVqVURTriuK6G2hxnic40XtZ8=;
	b=VPG52uPBBstb0lqWqXftQrA48zY0A+sZDrJGK3orOUGeccCFLGTqysxEsyVCShc0gfjpBc
	hyqBNBZU86zZ3Cqd8eME9IiYcsKz32O6cDKPQ10H1Z5lZZE9os7DVS6nvU/SZ5uExSFKjX
	U3ovNQAq0woljo7UuchOaQptMVMK9do=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-o75eMzOhNeaoS7J23TH45A-1; Tue,
 16 Sep 2025 23:52:49 -0400
X-MC-Unique: o75eMzOhNeaoS7J23TH45A-1
X-Mimecast-MFC-AGG-ID: o75eMzOhNeaoS7J23TH45A_1758081168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1937919560B0;
	Wed, 17 Sep 2025 03:52:48 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 149291800446;
	Wed, 17 Sep 2025 03:52:43 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:52:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: add test to verify that feat_map is
 complete
Message-ID: <aMowhqjOND9EdiKh@fedora>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
 <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Sep 16, 2025 at 04:05:57PM -0600, Uday Shankar wrote:
> Add a test that verifies that the currently running kernel does not
> report support for any features that are unrecognized by kublk. This
> should catch cases where features are added without updating kublk's
> feat_map accordingly, which has happened multiple times in the past (see
> [1], [2]).
> 
> Note that this new test may fail if the test suite is older than the
> kernel, and the newer kernel contains a newly introduced feature. I
> believe this is not a use case we currently care about - we only care
> about newer test suites passing on older kernels.
> 
> [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@purestorage.com/t/#u
> [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile           |  1 +
>  tools/testing/selftests/ublk/test_generic_13.sh | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab460366485ccc80abfa145a0c57b 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
>  TEST_PROGS += test_generic_10.sh
>  TEST_PROGS += test_generic_11.sh
>  TEST_PROGS += test_generic_12.sh
> +TEST_PROGS += test_generic_13.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..ff5f22b078ddd08bc19f82aa66da6a44fa073f6f
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_13.sh
> @@ -0,0 +1,16 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="generic_13"
> +ERR_CODE=0
> +
> +_prep_test "null" "check that feature list is complete"
> +
> +if ${UBLK_PROG} features | grep -q unknown; then
> +        ERR_CODE=255
> +fi
> +
> +_cleanup_test "null"
> +_show_result $TID $ERR_CODE

What if the ublk selftest is run on downstream kernel?

Maybe the output can changed to "unsupported" to show that ublk selftest
code doesn't cover or use this feature.



Thanks,
Ming


