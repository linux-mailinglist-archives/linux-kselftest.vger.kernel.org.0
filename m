Return-Path: <linux-kselftest+bounces-33986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E6AC7B68
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7BE9E5A13
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A928DB6B;
	Thu, 29 May 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlC/Rd9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D328D8E6
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512131; cv=none; b=ao4tJX7pKH5wW/qHhihwVP5tJJb6LDAmw1FFvi/tU7u1P8ZY7X0s4mx/MwUPvdk1w/TrrlfSl6Ogr2tm+fhL/8ODqYsYALvVxBUOArvQk1aGUIpWPp0beYtAag3wHdKhM39HUXK9+PP4J0sd97pkzJV6Ds5GPfUqJWGKtjk3Wes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512131; c=relaxed/simple;
	bh=tJ37GiEQgPK+kXaLSCs5FYz85UyulupB0lEDDibes8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY2PePi0CpCbkK13DW1jiImcF/cZD0W3Wek6wpYJ1wChrRNjMPwGFHvEqQ7VfJeKQoCBjvPdPOUIQPuxVm/ymdPIjxI0ToFoxyZkbzd/Uzu/EHjnE8EzVW25A2ctnU4jtTnyH8D9zHe5UifmrTIoejeA+suSXtlxK3HvBOGY2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlC/Rd9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748512128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ii9nK1D9ztG0XhbaHqDzvUWqyA0bRZma24ZQouI2Yqw=;
	b=WlC/Rd9Cwx07sxrJGM0NLsyrjQCO+tPdHa79aH2vjDivK/SML3VZFOv2d/McUhA4NRjFe9
	pHZVoxvJ0ZrcPUMg5AhuPEAVENqj8vsPHZ0J5DJwcE4sEDrrhu2cRNbfwdjerlvwCkRjNB
	tSI2Ddc3OZbzm5iVPX6UnaSvb4N9udM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-rPDIT-n7Nf64G3Yl0Bg7FQ-1; Thu,
 29 May 2025 05:48:45 -0400
X-MC-Unique: rPDIT-n7Nf64G3Yl0Bg7FQ-1
X-Mimecast-MFC-AGG-ID: rPDIT-n7Nf64G3Yl0Bg7FQ_1748512123
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B7F619560B0;
	Thu, 29 May 2025 09:48:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2EC19560AF;
	Thu, 29 May 2025 09:48:37 +0000 (UTC)
Date: Thu, 29 May 2025 17:48:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 8/8] Documentation: ublk: document UBLK_F_PER_IO_DAEMON
Message-ID: <aDgtcAoUci9F9ZmR@fedora>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, May 27, 2025 at 05:01:31PM -0600, Uday Shankar wrote:
> Explain the restrictions imposed on ublk servers in two cases:
> 1. When UBLK_F_PER_IO_DAEMON is set (current ublk_drv)
> 2. When UBLK_F_PER_IO_DAEMON is not set (legacy)
> 
> Remove most references to per-queue daemons, as the new
> UBLK_F_PER_IO_DAEMON feature renders that concept obsolete.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


