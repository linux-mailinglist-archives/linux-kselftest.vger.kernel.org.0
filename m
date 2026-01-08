Return-Path: <linux-kselftest+bounces-48508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B2D02DA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6018E3085860
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D547278E;
	Thu,  8 Jan 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7WThCqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC6472789
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875280; cv=none; b=oc440Y66Yz8IF2F+ZIzlY5eIrBb2kGHuSUMQbMUCaSSO3M9uaMoQkwjwTdwqpGuHpfy/y3f31dRNPwB5YDMXew6tgu+wKtVE/z2hiXHRbNFe4yeLTH2a0xh71zxgJ/omM6x7LNuWZc5CePTJ7Gt8QeRgj87ln7tpSHJOF4EcAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875280; c=relaxed/simple;
	bh=Mv3xIbvO6qBeve+QW9fRU6oey42jpoH0UUFwCj2Z1b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doluAnhZfJe4dMAisz8bzSJjNTpRY+wlb4zG939OXV7FUTniBli3c3lRpA12dVrbO4KVfj4EioQaxswcaM+QNXW0w36j2FJYA/mPQw/f4YaRyfiUbRi3voBlxFzZsScEyCDZ/etc70wkeZ3bdV4GaJggLHAE4dueYIVa2SN8DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7WThCqa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767875277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCUZ7jG07z3qpW3MUQnwKGbfDx/GqG1olorkz/pyZ04=;
	b=a7WThCqa1sQKpZE6KZQ034U3E3IsZdBQqBMaDpFaHVjRpTRiQbm5656W7QunPDFz3ZhQ+U
	5cAjVZeMhnbJINXpfFBwnt4bA/5UMBmpKbN5l/9p9ox9ZCCflfCZza0Twqxi5vGfZVHYgg
	IinhrIpl8zdUw163/NK/pThDXlsgWqQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-0Y-_IwM7NJ2O8EK9TrNCqg-1; Thu,
 08 Jan 2026 07:27:54 -0500
X-MC-Unique: 0Y-_IwM7NJ2O8EK9TrNCqg-1
X-Mimecast-MFC-AGG-ID: 0Y-_IwM7NJ2O8EK9TrNCqg_1767875273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE231955F3F;
	Thu,  8 Jan 2026 12:27:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7F4619560A2;
	Thu,  8 Jan 2026 12:27:47 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:27:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 15/19] selftests: ublk: implement integrity user copy
 in kublk
Message-ID: <aV-ivp99MRjUBD3j@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-16-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-16-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 08, 2026 at 02:19:43AM -0700, Caleb Sander Mateos wrote:
> If integrity data is enabled for kublk, allocate an integrity buffer for
> each I/O. Extend ublk_user_copy() to copy the integrity data between the
> ublk request and the integrity buffer if the ublksrv_io_desc indicates
> that the request has integrity data.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


