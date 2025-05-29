Return-Path: <linux-kselftest+bounces-33985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BCFAC7B62
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E76189E052
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E570C28DB6E;
	Thu, 29 May 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsWbc56G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A5269885
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512097; cv=none; b=g+AHP/j3t9PIe+fRXyx0a7EdLJLnbVlH7VTbEC9BzHDj6yqvWxKQnSso5KVs3uif3B9iCmTdQw9gheahPT96BAXg+JhX2W+zNZopcmM8Nl/jnEEUiI+YPfW0OKEkkY2LUuHeGGOoS6HOodExKEmSN7NYjWbXwRk+DvWLaUvwack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512097; c=relaxed/simple;
	bh=QSW8yr7Wa8nIzabX+tA183Hg5HQRpsGXIwYwkre3aHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyR0ys+zbVClsiYvResC8PtKIjp2nhuKy8701WY8LIaZn9JO2UbypmB35M1yHRGKEK4ZNbvvKp3ywpu9CRUh1wgWpm8zvmPYirJSpoXmOfjnTKjrLgq7aBsluI7k0F9gJ1L4L5aa69aCwUj+jfvftZV9Tl1M0gZ1Rhfr5GVcn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsWbc56G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748512093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ry7WPuUyLkq5CyNjr1ayrOEZ4+99+KqGgcnAG6eR+Q=;
	b=PsWbc56GfDInEw4S/o3A+pWjCwrQ8lwAf54n3X8Fv3+i6fRYS4xmniwdsvPM+oHdvmEHKm
	x6Qy1B9g9xXzmengUWj4838zCtQcPvMrttk/6vB85qQMjy5DmWesGHQjsP9Qg37W/ZIKvH
	LHAoJ4hmgrNc5btCMSuKYVR0hV4Nzig=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-z78Vrh78N5GS2Mn1yMs8qA-1; Thu,
 29 May 2025 05:48:11 -0400
X-MC-Unique: z78Vrh78N5GS2Mn1yMs8qA-1
X-Mimecast-MFC-AGG-ID: z78Vrh78N5GS2Mn1yMs8qA_1748512089
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC7891800366;
	Thu, 29 May 2025 09:48:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D4E21955D82;
	Thu, 29 May 2025 09:48:03 +0000 (UTC)
Date: Thu, 29 May 2025 17:47:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 7/8] selftests: ublk: add test for per io daemons
Message-ID: <aDgtTqj-s_SN7wCK@fedora>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-7-cbdbaf283baa@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-ublk_task_per_io-v7-7-cbdbaf283baa@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, May 27, 2025 at 05:01:30PM -0600, Uday Shankar wrote:
> Add a new test test_generic_12 which:
> 
> - sets up a ublk server with per_io_tasks and a different number of ublk
>   server threads and ublk_queues. This is possible now that these
>   objects are decoupled
> - runs some I/O load from a single CPU
> - verifies that all the ublk server threads handle some I/O
> 
> Before this changeset, this test fails, since I/O issued from one CPU is
> always handled by the one ublk server thread. After this changeset, the
> test passes.
> 
> In the future, the last check above may be strengthened to "verify that
> all ublk server threads handle the same amount of I/O." However, this
> requires some adjustments/bugfixes to tag allocation, so this work is
> postponed to a followup.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


