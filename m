Return-Path: <linux-kselftest+bounces-48297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793DCF8934
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A700307C707
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99BA3314D1;
	Tue,  6 Jan 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTBIxUqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8C3A1CD
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706711; cv=none; b=g3e4w/a3X+BUZNvIQMhnMIcPAF/jC4VuLEqQke5bXgzY9e7+wUPJyBeEoZL6ckyD9c5UCMwh/H1PeLORtx410czFbn+VsvaBNiXPxUP5opqkm9BXGAB158NBvjmzVPtmTLB3wn6cIaxmr3+sub000AUS6+1Kcg3xw1LxLUkoEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706711; c=relaxed/simple;
	bh=17opWGqelanW0CzKwjX8J8wUTObT7UF0i1B01EEufq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibmc1PpYoWgDJerZeF5N6tVeVeAmRm2FXApeuq0OezDREhK+7Kv9Q1PRioA4BGlp9mVfyoOoEpeMBScPeR0yn7+AGPh688VI/40+uAz2w+rFdZ1Mpv4HkLix1bxDitCGBZmydLAwEOpxjnO8E2nQppoQsMfssszq/VBjfZgOrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTBIxUqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qo+Fdya4vRKfMi6VqzXLv94Q/yK1zRBp7R03fFI3BSU=;
	b=VTBIxUqWDIp16yjCu1iU+k92R3UEmfxrOwPi6fVHFOI3gGMSaV+3rbVmop7dhvvvU1IMjM
	Fj2aILVkrpe1P5l+wfnhvza343lyBhBDxBE9BIkkabi4rAKoUEtlUjGuf6z9Z+21gGRviS
	BJeoaF7waDDsouENdrXQS/OAhIYGcWk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-lgGvWuwfOrOYEsK9HS9tZg-1; Tue,
 06 Jan 2026 08:38:25 -0500
X-MC-Unique: lgGvWuwfOrOYEsK9HS9tZg-1
X-Mimecast-MFC-AGG-ID: lgGvWuwfOrOYEsK9HS9tZg_1767706703
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85A3D18002C1;
	Tue,  6 Jan 2026 13:38:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB4CE180045B;
	Tue,  6 Jan 2026 13:38:15 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:38:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 12/19] selftests: ublk: display UBLK_F_INTEGRITY
 support
Message-ID: <aV0QQrococbVP1yh@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-13-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-13-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 05, 2026 at 05:57:44PM -0700, Caleb Sander Mateos wrote:
> Add support for printing the UBLK_F_INTEGRITY feature flag in the
> human-readable kublk features output.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 185ba553686a..261095f19c93 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
>  		FEAT_NAME(UBLK_F_UPDATE_SIZE),
>  		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
>  		FEAT_NAME(UBLK_F_QUIESCE),
>  		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
>  		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
> +		FEAT_NAME(UBLK_F_INTEGRITY),

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


