Return-Path: <linux-kselftest+bounces-31469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5090A99C86
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C81046107E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068819A;
	Thu, 24 Apr 2025 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPjSSOPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA78BE8
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453352; cv=none; b=A9oAKP36MS2Aaef++7jqjH+oGzWjQqZp8TYNcWVKs6YUTuYYFdaT6W7RtTL/nSBstnvwO98BSxpyaJKklB5PMvcCYGJ6hgitReJcsSwfw6YonHR+vvh1QvF9Da5p4aEyiwLDtcdUbOiOhueWWlHSHjI0vxnHtifDHs69HehGDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453352; c=relaxed/simple;
	bh=rpML8Vw4CRUhPj0L+195Bj7yvekpPYn5VCnsEkrlF7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNrCdY3p1eHbDq4hRJp61r+N6ri+lox5sMyWhEiw7T6qX8rnLuSWqsoeGPMcIzCDSWTmR9UgV7ET4ThPnBcqe8JcCsukIeKnu2ZIkMQwADuEA18gIYG92w+n0MasgNSomLbYVV4eLb8nmXLdhQZN0kIcNw6H+tuHFedd2KO09KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPjSSOPZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745453350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=remwpkwHo2Gyd19QnDcRBS0h2F0Mkh/a20m7ArEbiYc=;
	b=bPjSSOPZVfyNARqFdaSYwXee5X9+6lO0LMv7AI9IiwliuBG3uF7NUHicNNpdAKb7wVo5oN
	Sqk03suhdey9kTS27yGe5PYFT6IsmGCqkypo/lOBb9bUhzQVIY4DibplNZ+24AoXpTdcQm
	dRHYn4GtnhQ4+1Rcn/NKhHI5rDlrAvE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-9HT4SPqZOtSa0NxKAdv81A-1; Wed,
 23 Apr 2025 20:09:06 -0400
X-MC-Unique: 9HT4SPqZOtSa0NxKAdv81A-1
X-Mimecast-MFC-AGG-ID: 9HT4SPqZOtSa0NxKAdv81A_1745453345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A5261800878;
	Thu, 24 Apr 2025 00:09:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9DCD180047F;
	Thu, 24 Apr 2025 00:09:01 +0000 (UTC)
Date: Thu, 24 Apr 2025 08:08:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: ublk: common: fix _get_disk_dev_t for
 pre-9.0 coreutils
Message-ID: <aAmBGKfC72Q_JBG0@fedora>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
 <20250423-ublk_selftests-v1-2-7d060e260e76@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-ublk_selftests-v1-2-7d060e260e76@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 23, 2025 at 03:29:03PM -0600, Uday Shankar wrote:
> Some distributions, such as centos stream 9, still have a version of
> coreutils which does not yet support the %Hr and %Lr formats for stat(1)
> [1, 2]. Running ublk selftests on these distributions results in the
> following error in tests that use the _get_disk_dev_t helper:
> 
> line 23: ?r: syntax error: operand expected (error token is "?r")
> 
> To better accommodate older distributions, rewrite _get_disk_dev_t to
> use the much older %t and %T formats for stat instead.
> 
> [1] https://github.com/coreutils/coreutils/blob/v9.0/NEWS#L114
> [2] https://pkgs.org/download/coreutils
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/test_common.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index 9fc111f64576f91adb731d436c2d535f7dfe5c2e..a81210ca3e99d264f84260aab35827e0c00add01 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -17,8 +17,8 @@ _get_disk_dev_t() {
>  	local minor
>  
>  	dev=/dev/ublkb"${dev_id}"
> -	major=$(stat -c '%Hr' "$dev")
> -	minor=$(stat -c '%Lr' "$dev")
> +	major="0x"$(stat -c '%t' "$dev")
> +	minor="0x"$(stat -c '%T' "$dev")

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


