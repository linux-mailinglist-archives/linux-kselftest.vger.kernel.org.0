Return-Path: <linux-kselftest+bounces-12812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74C9183D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF41F2375F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560C1850BC;
	Wed, 26 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7M07gn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6F185090
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411690; cv=none; b=JiqaF4NNhBZTDgQntD2pOD0VF2NGvdAqxBI7fizI+xxD6PJonOSvtSABU4ieyR55htDRmjOhoTBULA73x+SnU/DrCnSho1v6hi+Kw/piOpHq22SGP0V/mtyUByUafHPyFNgazSbTADkx+SzWHn6rNVtb75d7yP87LJuu6MtLJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411690; c=relaxed/simple;
	bh=oR3F/W/MhqxgF6KdvLr27G1cva2slW9w0ZRA+4kSBko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1zzDdmfn71wqoggumQT9099tZqO1DMbUmWe8CZWSS0viC4rnJduqNLuiGr+AttNeGND44c5SHKiTk/eEmT13uc8jo9X2UVzfF81S6MMCZ0H87rvdZcq8skFcjbYV7cttCy5l1w7nXmt+u5iIY5IKC3JP1X45/xFB+Z2GoC5o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7M07gn1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719411687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR3F/W/MhqxgF6KdvLr27G1cva2slW9w0ZRA+4kSBko=;
	b=C7M07gn1y6Yig3sO2Jv7EwQRavE/NGij9NCnh9hNhw6uel0UgkEMn3hDulekKtUAnmZk3C
	4/vkrQNDzgYlAYGD8VBvvJ5QRDTwoqj52cIusVjP677xgGQfIkPaWvJJ/61Ui7i+Dm0V3a
	m1A7N+7VTQ/scXLOj9SuO36LVLYw2yY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613--HI60PISOwSDnuPHIuoz4Q-1; Wed,
 26 Jun 2024 10:21:26 -0400
X-MC-Unique: -HI60PISOwSDnuPHIuoz4Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785DA19560BD;
	Wed, 26 Jun 2024 14:21:24 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B77D71956050;
	Wed, 26 Jun 2024 14:21:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/10] selftests: openvswitch: parse trunc
 action
In-Reply-To: <20240625205204.3199050-10-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 25 Jun 2024 22:51:52 +0200")
References: <20240625205204.3199050-1-amorenoz@redhat.com>
	<20240625205204.3199050-10-amorenoz@redhat.com>
Date: Wed, 26 Jun 2024 10:21:20 -0400
Message-ID: <f7tjzibg4yn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Adrian Moreno <amorenoz@redhat.com> writes:

> The trunc action was supported decode-able but not parse-able. Add
> support for parsing the action string.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


