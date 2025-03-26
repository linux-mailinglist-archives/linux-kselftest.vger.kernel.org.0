Return-Path: <linux-kselftest+bounces-29801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F2A70F4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 04:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228613B11BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A21531E8;
	Wed, 26 Mar 2025 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajAdKh3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74113B797
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958464; cv=none; b=OBoyOFAD89WsR9EUUv10D2+fTpz56KyF+rLNFHSPRnvH8ZkQ3jdRUzZv/SIqigqk0y6kXh6F3dTWyfL/WB6kmrlO/MUc4kcqkL3bqH7/IcMu1V1qZBHOLy+6pOXxptaFbbphKBtpvMS4PaxQbM9sqRwQL9RpsLtAwX2+wCBbKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958464; c=relaxed/simple;
	bh=yN/Lkx1N0OJq5Y+e3NqV/4uO+thy5fSIVb8mX/V8l5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb3Smuwc9cHMWRB3sNYoU6HSSYQrD6gtCYv/1+FLfcvpWfhF0NAuo1OnTb2klHFVyZQAIYZcPSd8M0PJ6tgRZ1sKmrWG0+yx8/fOhypDz8n7RA0wuODGp1FJTlyh9bwYpLv01sBUTQUirbwv3rqyNVDaGKBMLAboUXoq2drq9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajAdKh3x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742958461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cBqfDizozM+WCO0bJhlFa+MM3ZqxFCbpm0gEORpsS4=;
	b=ajAdKh3xg0TJNnACmWDtBwz74U46QsvFQ1A/rMiNXuMNRg/3JmkIKNvP1YcQeJoBwTm3gS
	wND5soGIxoQBYekIEg/5M5wiwrewu8zB6UQBnKHEyN/YltLMQHSUhsmhWTZs8MG3HYYIrB
	YbIy6Q+1z8t99o0DBCqTrQLXRR3mofM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-oGx5zoQ7Peeu2GShCexApg-1; Tue,
 25 Mar 2025 23:07:37 -0400
X-MC-Unique: oGx5zoQ7Peeu2GShCexApg-1
X-Mimecast-MFC-AGG-ID: oGx5zoQ7Peeu2GShCexApg_1742958456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F049C1800257;
	Wed, 26 Mar 2025 03:07:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CDC6180B493;
	Wed, 26 Mar 2025 03:07:29 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:07:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Message-ID: <Z-NvbFqIJgxHisd3@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Mar 25, 2025 at 04:19:31PM -0600, Uday Shankar wrote:
> There are a couple of places in the kublk selftests ublk server which
> use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
> a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
> could easily require it to be set as a prerequisite for these selftests,
> but since new applications should not be using the legacy opcodes, use
> the ioctl-encoded opcodes everywhere in kublk.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


