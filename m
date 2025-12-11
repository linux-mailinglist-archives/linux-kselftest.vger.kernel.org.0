Return-Path: <linux-kselftest+bounces-47404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 687E6CB54FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E973017939
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD732D6E5B;
	Thu, 11 Dec 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9WOPRzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC431DF759
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444004; cv=none; b=EweR5IjpMfYEZhYtLqqkBEvsjK5enxibRGQhRRMVth3GSOfaiNo7xd4x8uJmxoRrbcMYLpMjqTeoaOliECm85OaeozLJXtZ/2lvzkucee1WEL4bVvZCps1pLDgp7aS/ZD90w6FYbKWEfU6c9BuMOuCZH+ot5tgqYAOle608dI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444004; c=relaxed/simple;
	bh=teAzMo5yQuqSl4hPQUy/EgXCiT7icaIDEZ4Uh5eiJqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4MWnhBr+FZ7Q5EHCuSroZxY/zDKejaobCIFPU0tUV+/3sP6cZBsGwBhDJMJTs9/CeWMS6I//R1OT1kTKV7zPzjTODbPS0B3tB1CcwB5ZLNV06FUSj/3OthL7spGuY3DE6CDPk2wSNNrQCjPwVECtSE5ALYUOg7SgG+9J+hPtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9WOPRzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg19wiGYY6vsBkwCpi5AtQH0+YPAc6y1x1cHHwsb4I0=;
	b=R9WOPRzRG+v/SkwjVS6PSfiG7UdvtvyTl/O+2R4ekTBSyv9wkYyWpi578CPlQUpX7JJczz
	oklLMG7i6ge+dfIVCUS5ifLxdJirw9Yp2wz1lQU+LhoLF0moDxAaK6kVKSox3g1pisvMfd
	KAAuxaECWWT1/KgkX9CbcvZEfnRJcNo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-E2klMEXfNi6AA-nUHbkUWA-1; Thu,
 11 Dec 2025 04:06:39 -0500
X-MC-Unique: E2klMEXfNi6AA-nUHbkUWA-1
X-Mimecast-MFC-AGG-ID: E2klMEXfNi6AA-nUHbkUWA_1765443998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 223E318002C9;
	Thu, 11 Dec 2025 09:06:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFBB6180044F;
	Thu, 11 Dec 2025 09:06:33 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:06:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests
 in stress_04
Message-ID: <aTqJlLbAiup38hTI@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 10, 2025 at 10:15:59PM -0700, Caleb Sander Mateos wrote:
> stress_04 is described as "run IO and kill ublk server(zero copy)" but
> the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> test cases is duplicated. Add --auto_zc to these test cases and
> --auto_zc_fallback to one of the duplicated ones. This matches the test
> cases in stress_03.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> index 3f901db4d09d..965befcee830 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
>  	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
>  	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
>  fi
>  
>  if _have_feature "PER_IO_DAEMON"; then
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> -	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> -	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> +	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &

I'd rather to fix the test description, the original motivation is to cover
more data copy parameters(--z, --auto_zc, plain copy) in same stress test.


Thanks,
Ming


