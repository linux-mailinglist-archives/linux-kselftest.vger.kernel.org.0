Return-Path: <linux-kselftest+bounces-47403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525ECB54B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8865E3000B30
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676A2BDC2A;
	Thu, 11 Dec 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUlnvxmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26019C546
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443848; cv=none; b=LuDFr2AsyXLMNl8q7TVXLFErNxAWKVyjQnYubCJh7pm1PIlllmZqz5Jz4dC0FV7mOneCgDF063BmaSlUZKIDys5rUBCsqSiVEL+tguzvFlFyHKEcI12Fkk4eALL88VcLISawjhFPx0W0pZkZWAUKYX2soykmnTb9bk3Q9SCqgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443848; c=relaxed/simple;
	bh=rgWQzXkArdNKxZWWY7GD+rveWG6KntmnPHpJak7kPZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbfqUXPg1/cSBuJ7bW3BoDJCZaPWCRjwH3v51LkKiIn/YstNpbDwLG3yvGs3EqilQnAvKz2ZvuBpTehU1ObByLsYgUdkP2FaK0Ti2HI3yk9bc0BnG2Jgx9mBoLCC0lkEyPrA6cpnHV2fOF2P39g99gkD5CHVRG7E2At94GIzb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUlnvxmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765443845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+P3Fg80P3FSGUIaveMBnlWzzxUXDJdv0MJd5t/DXbQ=;
	b=EUlnvxmkyP2+uANIlA/TdBlvf5+XgTOZ09xCp5US+5GjGdaU3nkpxkFXseVwFN3LLEwCQE
	thB3gV9AJHN1pYShwq2d+Ph89/SBf0BUwiXW6vb7cQMxauK4FVpo86C0kLVpGyfhPpeL5C
	rh/ymyTWdCJACMuWRAQUe3UThM20K4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-qMnsxxqsO2OOWIb6fJtHvA-1; Thu,
 11 Dec 2025 04:04:03 -0500
X-MC-Unique: qMnsxxqsO2OOWIb6fJtHvA-1
X-Mimecast-MFC-AGG-ID: qMnsxxqsO2OOWIb6fJtHvA_1765443842
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748F41800654;
	Thu, 11 Dec 2025 09:04:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5501A1956056;
	Thu, 11 Dec 2025 09:03:57 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:03:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] selftests: ublk: fix fio arguments in
 run_io_and_recover()
Message-ID: <aTqI-SzV2uS9YPQ5@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 10, 2025 at 10:15:58PM -0700, Caleb Sander Mateos wrote:
> run_io_and_recover() invokes fio with --size="${size}", but the variable
> size doesn't exist. Thus, the argument expands to --size=, which causes
> fio to exit immediately with an error without issuing any I/O. Pass the
> value for size as the first argument to the function.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


