Return-Path: <linux-kselftest+bounces-32732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FFAB0BAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A3E1C06009
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C126FDBF;
	Fri,  9 May 2025 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8/LXMwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5026C39F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775719; cv=none; b=Bbr3cRVUoot9v0tV8HOtUQcIF9gPvYhtcYlKjfiqCCPbOyLG8Z0rbLdq415d9UZIUYyeROtzT47SV/0iWL6O4VNxtiRIhvB9SxnP3q/fN43GiXmHa3KBXi83HHs9LWIFj9udaHvMWpMZ4eNt8kRqwLW5LiIn+B8d17SvKj/10po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775719; c=relaxed/simple;
	bh=vNNJXPmIRRvxQn7lU+GE8zSMS6AYGiBcH1wCP7uFCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcjjB0VCjHsFN8mp+ql/1Ty1bewZyvVoYUVig05oAcZ3Vc5JXBevSbAsKYUZU/eRARNUOMFLtYx2Qp4RA6kfiGJEEinmhjRO/ZwjkFXxIziWIbFYaJzF67IIRlrYyzeMzkZFdh62H4lUL7wU1cRmdUdD7IuTNyEgu1SfA20Eao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8/LXMwH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746775716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EcVhGEtDDS4MQtb8jcRWSm04VWssJLaR8dtFCxNmpWo=;
	b=B8/LXMwHg/M9kRmWu188kDiYcMmrzS1Cdu9c2woVJ9ovWvBXPEHdAHH6TUOm8l9adBMyD0
	pO41moG7r9OGfxLPfxtS1QJfHt7Vv1WA/zi3FsC7nNq6iOsC306YWMwLHW7TPVFJykF8Wl
	HMdFRRtG+7Lfjep55Y00kJEai8ArMbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-EU_CBs6dOJK-loryusFO3w-1; Fri,
 09 May 2025 03:28:32 -0400
X-MC-Unique: EU_CBs6dOJK-loryusFO3w-1
X-Mimecast-MFC-AGG-ID: EU_CBs6dOJK-loryusFO3w_1746775710
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 961C51800373;
	Fri,  9 May 2025 07:28:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 130DD19560B3;
	Fri,  9 May 2025 07:28:22 +0000 (UTC)
Date: Fri, 9 May 2025 15:28:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/8] selftests: ublk: kublk: plumb q_id in io_uring
 user_data
Message-ID: <aB2ukYlUMqPNuKfO@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-3-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-3-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, May 07, 2025 at 03:49:37PM -0600, Uday Shankar wrote:
> Currently, when we process CQEs, we know which ublk_queue we are working
> on because we know which ring we are working on, and ublk_queues and
> rings are in 1:1 correspondence. However, as we decouple ublk_queues
> from ublk server threads, ublk_queues and rings will no longer be in 1:1
> correspondence - each ublk server thread will have a ring, and each
> thread may issue commands against more than one ublk_queue. So in order
> to know which ublk_queue a CQE refers to, plumb that information in the
> associated SQE's user_data.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming


