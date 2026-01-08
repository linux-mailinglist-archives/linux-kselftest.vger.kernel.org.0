Return-Path: <linux-kselftest+bounces-48509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2382D0407E
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 342313045170
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25544F59B1;
	Thu,  8 Jan 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgiQavt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01484F59B7
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875734; cv=none; b=mc92ULNr4VJ1aRQG5y2fOWlhzBBuloO9dG5bSXm2oTlbp1ex/qg5snbRLXqGR2VS3XyzFazZPzAku09iSZNYdM66xbYHz5Kl1sBa5agaf8pl4pb6bm6sTGj55pcOL8KuadmBy2Tm+cEvCiTefoX6WSmnW/6iDFiun7RNQ0kbifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875734; c=relaxed/simple;
	bh=7W5IbUQig48mmUun66kOBBefkisQQnzRZrgjkYz+eTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9F7buLhCTIYegPcwbeQcEss1l3EIvNYTWBXA5TBNXQQ88NRkJyjGtjeyQ5QrX3XmvKNrB4YOo8qzCo0CgsFfrYLz6JDK7lLy/rdR8qlncTkSEWaqqJT4veF4VOm5as8rYEyrldYSgO5vhDAesoBNCeAerG8tm1SZlOiEIisWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgiQavt7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767875731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGIZxA5+0nMI2UGYg26r4G9izdzM1b9mlt5Z8K1XQNg=;
	b=BgiQavt7Q8Bybf1IN1gDP5wnxvv3cu/+0wDtvWz6+34okwBRK9uX7SyyUBgrnLfU636V3r
	H+ZXLqfn/rwYSE/9/M9Z5iGjVOjRSar3nGQKlg14Q/+OO2h5rT6JsuSK9HfHisYu6xtJW9
	ft4pftnu5uHAB8yNxFXCvr+xbeBnLaA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5pMAXFOXO4K1pz8Gkfbc1A-1; Thu,
 08 Jan 2026 07:35:30 -0500
X-MC-Unique: 5pMAXFOXO4K1pz8Gkfbc1A-1
X-Mimecast-MFC-AGG-ID: 5pMAXFOXO4K1pz8Gkfbc1A_1767875728
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A05C818005AD;
	Thu,  8 Jan 2026 12:35:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9D619560A2;
	Thu,  8 Jan 2026 12:35:22 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:35:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 16/19] selftests: ublk: support non-O_DIRECT backing
 files
Message-ID: <aV-kgiZlP7DBz0bx@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-17-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-17-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 08, 2026 at 02:19:44AM -0700, Caleb Sander Mateos wrote:
> A subsequent commit will add support for using a backing file to store
> integrity data. Since integrity data is accessed in intervals of
> metadata_size, which may be much smaller than a logical block on the
> backing device, direct I/O cannot be used. Add an argument to
> backing_file_tgt_init() to specify the number of files to open for
> direct I/O. The remaining files will use buffered I/O. For now, continue
> to request direct I/O for all the files.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>
 
Thanks,
Ming


