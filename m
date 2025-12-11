Return-Path: <linux-kselftest+bounces-47401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615AECB5420
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC18300183C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E486A2D0C89;
	Thu, 11 Dec 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMReIfJJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507C23BD06
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443501; cv=none; b=F7y5buIypT839ATsQTiDXhq7Gb2L6N4PSy4su3Z3M3NpmmiV/+bvVMgX4FM4bLk54bn45PBDhS8z1If/Ch+7OFGv22qNYUf03Eh5A0cFe7FVY0Iv3S3B0azdaQOz2VaHv7Vx8XRPYFGestuaBE3c/opOK4kxq0Hn44U9CbbkMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443501; c=relaxed/simple;
	bh=ikTlwrQmci4X/uusets6DAXQBh3inbX9GdiNQBLv/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks8lykrHLt93Zv8ULGsOy/m7SqxJX+Ub4pc1ZVof2NuDXxvNptwJXmo3zIpNK/l8ABMTC0ZfhJs2s8FIKjmWEk/vakvFSA2mRtVFslzLxipUcDmQIvnyAIq8omuLbyoKkWmRdIUjrygvfyQnVhkzly3G84vK0On4zR+zYUC+wCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMReIfJJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765443498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65Y1627ZV2tbL0TMEgxGlq6K39Yb3mgwd2DIfysE9SI=;
	b=iMReIfJJ4eMcmJ5XC1k/zxDm+0XojRPDqtlg+I/Q1zmrSd7rRnJA0MtEMOjCIQ4IowK21v
	jH25ao04LS1l8MPFFrb8X6G9VWUrTpBumPzsp9iGrBVMzWGwiDcVMVocAyc1ZsiZv/UsxU
	nrFOqpYy8oVtK4Tc3zut1HRjRo40Jz4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-cvmRlKlMNaGtLd2Xlj5i1A-1; Thu,
 11 Dec 2025 03:58:14 -0500
X-MC-Unique: cvmRlKlMNaGtLd2Xlj5i1A-1
X-Mimecast-MFC-AGG-ID: cvmRlKlMNaGtLd2Xlj5i1A_1765443493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64231180035A;
	Thu, 11 Dec 2025 08:58:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08EA30001A2;
	Thu, 11 Dec 2025 08:58:09 +0000 (UTC)
Date: Thu, 11 Dec 2025 16:58:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] selftests: ublk: correct last_rw map type in
 seq_io.bt
Message-ID: <aTqHnCSZMiobMtXL@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 10, 2025 at 10:15:56PM -0700, Caleb Sander Mateos wrote:
> The last_rw map is initialized with a value of 0 but later assigned the
> value args.sector + args.nr_sector, which has type sector_t = u64.
> bpftrace complains about the type mismatch between int64 and uint64:
> trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
>         @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
> 
> Cast the initial value to uint64 so bpftrace will load the program.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
> index 272ac54c9d5f..507a3ca05abf 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -2,11 +2,11 @@
>  	$1: 	dev_t
>  	$2: 	RWBS
>  	$3:     strlen($2)
>  */
>  BEGIN {
> -	@last_rw[$1, str($2)] = 0;
> +	@last_rw[$1, str($2)] = (uint64)0;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


