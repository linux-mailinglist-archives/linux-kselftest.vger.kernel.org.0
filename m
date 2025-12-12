Return-Path: <linux-kselftest+bounces-47505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EECB8AEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B406306636B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9A31064E;
	Fri, 12 Dec 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn4c8Lm3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278830ACEB
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538056; cv=none; b=nSnRwsUeVhIqK3on+Utg08D6RlzGail1ZTpcLt05fzsXbWr9c8FrCPnMbEsOF0ggf60R7Oi1kigTV94SMAhf9Fxe52H6H2jI66wnTrxhjHmVFKWP8WXvcKVEUWR4P9JhYo0gykd7j/by2WgamqndKE8nwZKm1UvNg/BV2sHyOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538056; c=relaxed/simple;
	bh=599F0iN8VoHAMcBk9hlUnhzqpKfM9wcRmEpKwX2fypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8amKweCAI9stvUD4UlsYdXIwkuSlxnB1uyFGLNXGWiNkSTI3z0VOmgIbd8t73TdOWuBzBRhkbC6OFaSVtnoZV+LWRI5oc6N6LwlUnLl6tT4zAIac+XBCIM1V3Ltoi8WzvXwApC220iV6Y4eT10NuxjuOcEG/CJMAx/nxPtAYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn4c8Lm3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FeH2q0RH17mtsW9nUPh5TVnCObfHE1KFZdVHyBk5l4k=;
	b=Nn4c8Lm3tWJX0ES601Stmtoopk5MqupJ9rWq7AkX6/3ykwds/ZKDm84nZDYl8wK3KlIv7g
	CgQGFINj0e9GwugF1ItxBQXagnc0vIxS96pZYF7CLFZBBGGLvpmpZGz4npuBW1ORWNhW+T
	J240XT2V141UwabrH/u6G7J/Mv0bOuE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-RbRQ-7iWMRqa-CUX7uIwng-1; Fri,
 12 Dec 2025 06:14:07 -0500
X-MC-Unique: RbRQ-7iWMRqa-CUX7uIwng-1
X-Mimecast-MFC-AGG-ID: RbRQ-7iWMRqa-CUX7uIwng_1765538046
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50EF180035A;
	Fri, 12 Dec 2025 11:14:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB6F19540DF;
	Fri, 12 Dec 2025 11:14:02 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:13:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTv49eVEicH9EHWg@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


