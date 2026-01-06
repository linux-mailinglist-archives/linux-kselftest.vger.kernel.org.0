Return-Path: <linux-kselftest+bounces-48296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BAFCF88B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2380030299DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CE3321A1;
	Tue,  6 Jan 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLdbl8XR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763F330678
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706608; cv=none; b=ru/fDfeAJz3cvtgBvHY4qCbZfSEJ18fZuqTuj0jnoz6Oig3RoftEDMk3y8FJsUwR0AMemlhNIYp8LzGJJEznAvqWPp2c/3wlRDcuTqaQn1iEKXsr93hG4KuoGi2gzohuWELG1453+Uqu0rHZf/Ho95rRXZ2EJQXz+OYf4uR0SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706608; c=relaxed/simple;
	bh=SFx2b2O5Xai/31PBK1ljJU5OeDhmpnKFS85HBJDBJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm3NulIC/Mo/OIzyyMusBV1FHps7e4i0gkK1iHW1MuUiHdlIJ6vIGJkpKCRWiX01k6DU5/aVr1pgXOXZDay712dPvXpsTfmStFEZuhWDJ1tB3gawfYBqHIMTHVAzRLk9//HMkPbxuAqTN7llnfatPKCa000gTcNRIVF6YJMxtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLdbl8XR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQH2tS6p8C6ddM5URhXlqhqtGE7QDS7qlRZ/W9IQQrE=;
	b=RLdbl8XR4bX8FVBPqVwtXFnJ2gu8JYoN6Rf35gKXGnYdpWfsSc8DgGVCnkUrPJJO9nbS1+
	TLx+0XV9yxLllI8YnS5Pz2QM1tshJ7oUn6oJhPFjE1YddHsjKdgfqzTx75zQbVNROnFvgx
	CkJ9w5reZRXxOZvKOx5Fbgb5degzmZo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-gs9YGgADNteo5E4VG9F1XA-1; Tue,
 06 Jan 2026 08:36:43 -0500
X-MC-Unique: gs9YGgADNteo5E4VG9F1XA-1
X-Mimecast-MFC-AGG-ID: gs9YGgADNteo5E4VG9F1XA_1767706601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67E6D195DE48;
	Tue,  6 Jan 2026 13:36:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565D819560AB;
	Tue,  6 Jan 2026 13:36:22 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:36:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 10/19] ublk: support UBLK_F_INTEGRITY
Message-ID: <aV0P0DCt4Jprm-Wy@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-11-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-11-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 05, 2026 at 05:57:42PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Now that all the components of the ublk integrity feature have been
> implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
> layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
> servers to create ublk devices with UBLK_F_INTEGRITY set and
> UBLK_U_CMD_GET_FEATURES to report the feature as supported.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9694a4c1caa7..4ffafbfcde3c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -73,11 +73,12 @@
>  		| UBLK_F_USER_RECOVERY_FAIL_IO \
>  		| UBLK_F_UPDATE_SIZE \
>  		| UBLK_F_AUTO_BUF_REG \
>  		| UBLK_F_QUIESCE \
>  		| UBLK_F_PER_IO_DAEMON \
> -		| UBLK_F_BUF_REG_OFF_DAEMON)
> +		| UBLK_F_BUF_REG_OFF_DAEMON \
> +		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


