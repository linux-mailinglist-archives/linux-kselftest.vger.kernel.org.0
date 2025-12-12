Return-Path: <linux-kselftest+bounces-47506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67FCB8B07
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E4530361E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF152836AF;
	Fri, 12 Dec 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8fl6aHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A023EA8E
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538176; cv=none; b=mQbW77SqNX1kR8eEv4ZtJdQYu73lSRM8tpQtCv79fqBp6XzswJpA6D5UnIioFpNJ396dn42DoTEqKuE+QSGXfIDQr3d4dePcn7ruotaczDdXq8l0Ft3yYrs68vGxxbfATFz1HYDCu+lai+0+yj32xthtLfXlO6Sd8BjUA5sqsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538176; c=relaxed/simple;
	bh=iTFxxzCgzgLCCa41qEKV28ldYeSNvS7CyEcsSgsivBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTD+jTJESIJFNTvZIrLaH6XiyjEomsVKBXwATNca5uVFTNGdxFUMzscYgKod9m8dERCyaEKSNt8eeroeyCJRb7znMgHmuZ10mIIe7JAE7ve6DVL9F+goWUItDIZTsdxfUNJenOQl4vrNRpq0svTYCo9LxpxyoRqeE4O/zkZcPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8fl6aHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LP/mjTYTKiCiU5cIiY2LJTGJw6nKbULNhGHyX+Hblf0=;
	b=E8fl6aHwG0UIqP05z4XbapVtu+7dg0lqcf2PcZ2o4uLJIOio7vgP0KvblhA8SEwWUQ4Wlv
	D/kLkthH7Za7yDBDEynNZeHiiUCCyg2v1O9rLilxt5w2oE0mTBzENuv602zezRLmPZFCWP
	eOwo3FKArsdEtqhbpypcIK4XAoh0+9E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-SbVy66R7MvWLg0u7XiC-ow-1; Fri,
 12 Dec 2025 06:16:12 -0500
X-MC-Unique: SbVy66R7MvWLg0u7XiC-ow-1
X-Mimecast-MFC-AGG-ID: SbVy66R7MvWLg0u7XiC-ow_1765538171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95A90195605B;
	Fri, 12 Dec 2025 11:16:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B61219560B4;
	Fri, 12 Dec 2025 11:16:07 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:16:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] selftests: ublk: add support for user copy to
 kublk
Message-ID: <aTv5cz_B1IdLpI78@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-8-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-8-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 10:16:57PM -0700, Caleb Sander Mateos wrote:
> The ublk selftests mock ublk server kublk supports every data copy mode
> except user copy. Add support for user copy to kublk, enabled via the
> --user_copy (-u) command line argument. On writes, issue pread() calls
> to copy the write data into the ublk_io's buffer before dispatching the
> write to the target implementation. On reads, issue pwrite() calls to
> copy read data from the ublk_io's buffer before committing the request.
> Copy in 2 KB chunks to provide some coverage of the offseting logic.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


