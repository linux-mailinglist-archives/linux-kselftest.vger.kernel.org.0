Return-Path: <linux-kselftest+bounces-47405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA2CB54ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90A693004CA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF625A33F;
	Thu, 11 Dec 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVlq42UD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BD3B2A0
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444042; cv=none; b=OG3AhMARp3vjtM0WJ7wlU0UM1oaXENsh9yqNjTbBkWgrvjbkqqPFGoK22FbKVcD/gfJqZhwgnjGX7+dZKyZmpHzmCgZIy2uKFzThsb8Zkp/Y9pfXRFfIhUDU6oqYjpg8n+gs4PT+7OSx3UdMWnmln52GcaQdA9qPvz6kkIo+Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444042; c=relaxed/simple;
	bh=ttdjBkhC96i/wRHOwkiUCWxMcnZwcz60Y9yMhK/NI8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wne+kh4P6+2DY7TJeeZf2raGMD7MPzoibYpFMZVV5EkT8F2343bovADUZeCgL/olr6nndNoN85P42T46kq0lPivBFyk7KqEFbDzgMSPwMzL3GwgEgJMaAVBPLaXvdrLxRY4OJ0Y8GhlOgc4LsbEcyCvnZ8255THR5BNpvRKV2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVlq42UD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4d8Su7OCn9SSpikVB1AMndX+Pol0Nx0pC/e19C9VIs0=;
	b=gVlq42UD6txhFBJl4LxFFfUTX/vlfskxSJx5jPYNQ/q1HA4eRVcgGkIHSPs3R8xTWQ5n7y
	dScdGuFxOBrPNmbbn+ytoORrAAfuSnwgxz/ytj8pYHGA5eO8Laeizn+XmPXpO/DPzFUB1T
	HRyGS9rjXLsGizVAR0Jv/rmMSmPDtGI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-N4WSIRJXMsKS52O_R2LxKA-1; Thu,
 11 Dec 2025 04:07:18 -0500
X-MC-Unique: N4WSIRJXMsKS52O_R2LxKA-1
X-Mimecast-MFC-AGG-ID: N4WSIRJXMsKS52O_R2LxKA_1765444037
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D745E195FCDF;
	Thu, 11 Dec 2025 09:07:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC39D1953984;
	Thu, 11 Dec 2025 09:07:13 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:07:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] selftests: ublk: don't share backing files between
 ublk servers
Message-ID: <aTqJvMr9D2orECii@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 10, 2025 at 10:16:00PM -0700, Caleb Sander Mateos wrote:
> stress_04 is missing a wait between blocks of tests, meaning multiple
> ublk servers will be running in parallel using the same backing files.
> Add a wait after each section to ensure each backing file is in use by a
> single ublk server at a time.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


