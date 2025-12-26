Return-Path: <linux-kselftest+bounces-47966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF57CDE3E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 03:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B5F3007FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508619D07A;
	Fri, 26 Dec 2025 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2d9dJf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373F9443
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766717481; cv=none; b=K676og3VwAnZgwB5h7DZEw+kZB3y6fEWHDo1SThh6dkwK+LGjCXSdhB/PxWeCN4sQMc5fP7QLm6fQJJg0L/QGBC2mRqUq7NFavLkeEqvRe5H63cQ6acXi0dORuo8L1GYBQlL8SuGSCo8AGRPFR7wR2vZoszbTa6t3jmMN0Lp6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766717481; c=relaxed/simple;
	bh=xvhd+798rmdkTXqOI2P5JGZmsSV2OmN8I6fkUCNTzpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s++Eux24b6koi+oOcbwfSyhXp5GzYFovg8BqKrgvDifdpWgu2tY4qfsAzCXWHJBYZOO9BUJUebVwtYANoQyOyIE5zu+UQ87b0uPl0+hoUBK9fck1HBCwLAjwBREbpsHd0n3jQS9j+7LvnTbk+AXxj9sIMhQL7iSIlPGmPRjAj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2d9dJf4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766717478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syVyzrdITVT4PIvkT7TnxDjknHuk9KwWcoQMn4NlCzQ=;
	b=N2d9dJf4Kk0vc3yGE3ozouB0AybRkJbiPji45WtVTXtbIx730KnwTlffdqZXYvunTgAyL4
	5itOmi8Mz8hsilxMTyEqts4JNF0EhgdASni3oxn3Letu5ud2ctcWZOnViX5s6PTcr3+EVt
	6NGw19Ium1eHB4xDs+RL21mVSbArVGY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Zzsu1CzjN2C8a3rUIa3NJQ-1; Thu,
 25 Dec 2025 21:51:15 -0500
X-MC-Unique: Zzsu1CzjN2C8a3rUIa3NJQ-1
X-Mimecast-MFC-AGG-ID: Zzsu1CzjN2C8a3rUIa3NJQ_1766717473
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C6A71956046;
	Fri, 26 Dec 2025 02:51:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D38ED180049F;
	Fri, 26 Dec 2025 02:51:08 +0000 (UTC)
Date: Fri, 26 Dec 2025 10:51:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 13/20] ublk: optimize ublk_user_copy() on daemon task
Message-ID: <aU34F9Y-47IhFWRJ@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-14-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-14-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:47PM -0700, Caleb Sander Mateos wrote:
> ublk user copy syscalls may be issued from any task, so they take a
> reference count on the struct ublk_io to check whether it is owned by
> the ublk server and prevent a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ
> from completing the request. However, if the user copy syscall is issued
> on the io's daemon task, a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ isn't
> possible, so the atomic reference count dance is unnecessary. Check for
> UBLK_IO_FLAG_OWNED_BY_SRV to ensure the request is dispatched to the
> sever and obtain the request from ublk_io's req field instead of looking
> it up on the tagset. Skip the reference count increment and decrement.
> Commit 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon
> task") made an analogous optimization for ublk zero copy buffer
> registration.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


