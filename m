Return-Path: <linux-kselftest+bounces-47504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE41CB8ABF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BC2308696D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA331AF1F;
	Fri, 12 Dec 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnpUj8zn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913331AA97
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537795; cv=none; b=szLGiJ4C0LACDwK28qlSFOjWE5FQ0WjqUyWa6nplx9RUUkuPsNWzPvKyMxsXw7TyQ/oXtCV4a3wTp5vkAz0R+oL6xJVI86gOyn1OdFCUgEzfGusVwjX+oOCnerOrMGSvKsixpBe4c4cW/V9jCa+NKFLkfaSBuqPoH+4xUtQT+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537795; c=relaxed/simple;
	bh=599F0iN8VoHAMcBk9hlUnhzqpKfM9wcRmEpKwX2fypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXF2KJS/s4wvnlu2My/rs0+J44P24cufbp2+LiVWvmVlrgVZkO1Ye7K5S8fWFwcizfJHRB41+ZejzIvzuJCfgdZ19E2yzaAcY1Il4LYB4WL2Jk3Rf79yRutaXm2wkjZRoeqm0uRktge7Ofj5yH4Kg7x3J+J6MW46HQngUTyrGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnpUj8zn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765537793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FeH2q0RH17mtsW9nUPh5TVnCObfHE1KFZdVHyBk5l4k=;
	b=hnpUj8znpsSL3V5FVjnK326RgiXKF4m9vcQw1cK92wE8473BZEthFgKs7kJYLmUR00p4nB
	KR6UIfObjXfXKsO8SUA4GURoegMqNcai8YfjXXVxllk2tq0MOaLE7NGxrmfSqrsR13cWie
	OdCwXkY3nvcGw/pQcl1XaF8ATEietmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-cc8hxSgeMFOSD6lxj6rfvg-1; Fri,
 12 Dec 2025 06:09:50 -0500
X-MC-Unique: cc8hxSgeMFOSD6lxj6rfvg-1
X-Mimecast-MFC-AGG-ID: cc8hxSgeMFOSD6lxj6rfvg_1765537789
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 024FF195608E;
	Fri, 12 Dec 2025 11:09:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9020A30001A2;
	Fri, 12 Dec 2025 11:09:45 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:09:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTv39DmuRbhXXekG@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Dec 11, 2025 at 10:16:56PM -0700, Caleb Sander Mateos wrote:
> The kublk mock ublk server allows multiple data copy mode arguments to
> be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> The ublk device will be created with all the requested feature flags,
> however kublk will only use one of the modes to interact with request
> data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> clarify the intent of the test, don't allow multiple data copy modes to
> be specified. --zero_copy and --auto_zc are allowed together for
> --auto_zc_fallback, which uses both copy modes.
> Don't set UBLK_F_USER_COPY for zero_copy, as it's a separate feature.
> Fix the test cases in test_stress_05 passing --get_data along with
> --zero_copy or --auto_zc.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


