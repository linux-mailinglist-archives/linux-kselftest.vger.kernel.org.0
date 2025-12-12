Return-Path: <linux-kselftest+bounces-47507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD7CB8B14
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DE05300E83A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AF31691C;
	Fri, 12 Dec 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irY1zt0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C02882D0
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538270; cv=none; b=J7UsaEIcE7HtyceJxZSMjV85AVDsZg/x/22Rq8E8OD1ZYH4j2UkL7mElIW5k/mT/5ssUVJMJzEPkMgWPeSo+LHQw5VqTkXQXQbhuwf34WKvroRLE9B3L+gtZxdKJtUQLB+DcRyUlOtHH1J4+dQyiPT1tUpxuag+yVVBbHLkdjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538270; c=relaxed/simple;
	bh=9vfZ5XCGP3ZhYtH+h7UKepd7I2NVyzlr40thkL6imuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrZgAo90js11cLCAGLUk+BV2rmj01x1jTpLnAyfXeJzTOrvsIGAxvMn1q2E38GTAjGm5tX2SIiMWwAX4MgFRTATuFe1nlgUju65J203EnvlcTZ9z48sB2/dJXdusojJvUIb81jYo4TxBKOCAfUpQuL5c3pWUQCsdjMm38DP6orY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irY1zt0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaHPS68+EA7nzmnx3Y5AjUxG/xQcmg9zYrO4XmI6Jk=;
	b=irY1zt0KsPNv/QMAfbPp0VoIqCE0xs9KjKFgSBilb9J+jVuB5Z/n00k1fPZVRA/1oCXpoP
	G9pLmx/ZtHhLWFuiMPlLCCDPKWt5wV0NgN/0k/poobN8gxghaETMSdx9QEDo84d6FydrMz
	uF6BAGrlMPmWbgQB+mtgcM4AzbWd0t0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-vXgnASk0OK2CIht-AbhYMA-1; Fri,
 12 Dec 2025 06:17:46 -0500
X-MC-Unique: vXgnASk0OK2CIht-AbhYMA-1
X-Mimecast-MFC-AGG-ID: vXgnASk0OK2CIht-AbhYMA_1765538265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00358195608E;
	Fri, 12 Dec 2025 11:17:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B263194C65A;
	Fri, 12 Dec 2025 11:17:41 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:17:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests: ublk: add user copy test cases
Message-ID: <aTv50Ip1GzR-7dbc@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 10:16:58PM -0700, Caleb Sander Mateos wrote:
> The ublk selftests cover every data copy mode except user copy. Add
> tests for user copy based on the existing test suite:
> - generic_14 ("basic recover function verification (user copy)") based
>   on generic_04 and generic_05
> - null_03 ("basic IO test with user copy") based on null_01 and null_02
> - loop_06 ("write and verify over user copy") based on loop_01 and
>   loop_03
> - loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
>   loop_04
> - stripe_05 ("write and verify test on user copy") based on stripe_03
> - stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
>   and stripe_04
> - stress_06 ("run IO and remove device (user copy)") based on stress_01
>   and stress_03
> - stress_07 ("run IO and kill ublk server (user copy)") based on
>   stress_02 and stress_04
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


