Return-Path: <linux-kselftest+bounces-47849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2ACD65F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8C7E3042481
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE352D738E;
	Mon, 22 Dec 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T49Yda0n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC75231C9F
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413871; cv=none; b=tPLlPMP30ATPqTN/xLSvLUh0rZb3D6I28NisOH1uqL9KIKVoy2Cyls7WOvgfca6s4LnzKntiXPrd7+8oh7uDSyTBG0i+6+tm9eeBGLMt0L9uD0N8YAnxgj9lp3wSRne6e7O7MrUmkWk9KHAp1rRUIethR2L9uidygC7VE49mafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413871; c=relaxed/simple;
	bh=oIsi0Rgf2NnQ444MP8ZjJ+/BJZ4NEdduBMhmLl6uCSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLFH3AQ7XjWv1iGbonRcSX4OaUW5djYZLQcHsljHVcyhFYKa6/D6i8GCWCBhVFXileaXGSsPgTb4ILV2vDGISNOjVQGxSQi5GlXe/0q1HKwnttBwo8nlTxZH6jcGpziLReToPEzIhZDXcMzlbm12tVblezajmTlSEgBbk0W50fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T49Yda0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766413868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNLsW7FehdMTm64kjChBIslsj99UJfHS+j/pyib08D8=;
	b=T49Yda0n2RcZ9oOHSMB76PKk9kIpR0hYvJ9FPNSYGpLp2gVWmFr/WB+4HUrA2wHnPlAhv3
	AMatKdjExnUr1iil7ozyH1w1LX8WyYcY9WrQ/6wBM+IWPeMSDzplxC4esbC1ZG0AWYn1xX
	AMyB7H15A5W+/xsgwkvBbaLm+PjNeh8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-ZR0WEG32OvuJzSPqjEITsQ-1; Mon,
 22 Dec 2025 09:31:03 -0500
X-MC-Unique: ZR0WEG32OvuJzSPqjEITsQ-1
X-Mimecast-MFC-AGG-ID: ZR0WEG32OvuJzSPqjEITsQ_1766413862
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 008321956096;
	Mon, 22 Dec 2025 14:31:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC5D30001A2;
	Mon, 22 Dec 2025 14:30:54 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:30:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 05/20] ublk: move ublk flag check functions earlier
Message-ID: <aUlWGO--HJtHQJ9d@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 16, 2025 at 10:34:39PM -0700, Caleb Sander Mateos wrote:
> ublk_dev_support_user_copy() will be used in ublk_validate_params().
> Move these functions next to ublk_{dev,queue}_is_zoned() to avoid
> needing to forward-declare them.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


