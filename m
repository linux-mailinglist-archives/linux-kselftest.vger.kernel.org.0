Return-Path: <linux-kselftest+bounces-47853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219FCD676A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B5A3033DEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2430F532;
	Mon, 22 Dec 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+0l46Gj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC07230BE9
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415525; cv=none; b=Mgh7KFFD+0omFrCiOE9So29Cpgmwv6Rl5sRpfWLU3MaiG6l5xCohPl2JlfN9oqIDOkL7rzohJEL3stvxn2E8HT79u40LQQYGO0aZ3I+w3FCLrZVl8pxPXyrQggWfgYgW/xhPRVU2LubKUFVMvUS7IxI3XywXkI7NsO+dlWOTyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415525; c=relaxed/simple;
	bh=DabZrtZ7B8OJhdn3iQEaY3ilFKSBkpnRKqB0dxFduTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV9YUtxzge+31GRuCtdrfN6EzR/rEIvIruao5C8XS9cVTzurP49IkzP92w8hk+XuSJEDbSaURVJHnhTSb/DN2QMj8ri/swTxKqYR8jj9N1Z+AGFavHVYMS/vDPCFPMKlGu0jVGSFv1pUmYSxnbnojIX1nlCjQBQI/NCvHXsuE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+0l46Gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766415522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+Aa3u8Q6ZiKr4jWojNxq5jGrdqy9Y3sIONrpXeaek=;
	b=C+0l46Gj0RwCvDml0C0SV2UBemGIC+/EUhJ8CDN52/yyRWUGahzX+nArRWWfInL+ginnQD
	I9Pe0Kw4DQvO7u4bdc/vnX7xBh6wfk8lxcVypClwE6Kv+wj3MLPktWVyNCLp50dZbolv1e
	y11ZfSezPYfpMnxBY9HR3xV0k4UY7+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-RbpGU8IpNhWNoKqBCTIBPw-1; Mon,
 22 Dec 2025 09:58:40 -0500
X-MC-Unique: RbpGU8IpNhWNoKqBCTIBPw-1
X-Mimecast-MFC-AGG-ID: RbpGU8IpNhWNoKqBCTIBPw_1766415518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8C0718002C1;
	Mon, 22 Dec 2025 14:58:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 139AF180045B;
	Mon, 22 Dec 2025 14:58:30 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:58:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 09/20] ublk: split out ublk_user_copy() helper
Message-ID: <aUlcinKQIDmPevQH@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-10-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-10-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:43PM -0700, Caleb Sander Mateos wrote:
> ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
> for the iter direction. Split out a helper function ublk_user_copy() to
> reduce the code duplication as these functions are about to get larger.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Nice cleanup!

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


