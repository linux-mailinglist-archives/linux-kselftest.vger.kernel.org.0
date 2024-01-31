Return-Path: <linux-kselftest+bounces-3857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E98444B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52AE289631
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7612AADC;
	Wed, 31 Jan 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJvb8pjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B387BAEC
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719476; cv=none; b=icE+83jI+m0BR2rbOXsk6rKlljeJrVUXgB8V1G/pEDqzTh+QGkR1oo5QfokSkKmRUrrX+C4F4X16ykzOKUXv6Be8AyoC5W0cg37ycbnMGH8jTiVbjDUPEv9pRFvIAzr4JIUopLeBwicKhLbVVaYub5DyK0zKlHCdb8z1VJ73QCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719476; c=relaxed/simple;
	bh=Cvu0DIhuYA+aigtB5vEn9L4WmipBClGZCuLKOygUPsM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jm7uQh2z1nrKI4ylN3CmkrOzQVpU8CJJPk9hZ+1sA6rsroQokTmG8919O/swzhepTuQ37zPamQUhpWzuWGLBr6svGv7ulga9e/tPp2+WSFY4xfuK5lg9rktE2pIj4YiqXVYX4xe03VM8Vspugu7cwapRD3QiDQdecGX6W8Bwoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJvb8pjk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706719473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfsQIbJAPyfrnawYlf3IhHhMNM/4DIn/icL/D01AzJc=;
	b=dJvb8pjki09Tr+t4MPPPE/aqFXXol5k6iWlUKfjNmpqlasepw89vlWkxNhqihdxfzxV5hf
	ypG1uR7QcxL2xurlcCIE8wUIBzxkK3ZruRmyOQqcYhUz20bR3mNrT17z+/UeVdT0Mc62uT
	9Ey5bmUEb47MIlGX2sLFEZ/WWRYiXTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-PlsAS4AvMESnmbmO1I-a9A-1; Wed, 31 Jan 2024 11:44:31 -0500
X-MC-Unique: PlsAS4AvMESnmbmO1I-a9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA275185A787;
	Wed, 31 Jan 2024 16:44:30 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C504D1121306;
	Wed, 31 Jan 2024 16:44:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Brad Cowie <brad@faucet.nz>
Cc: netdev@vger.kernel.org,  pshelar@ovn.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  shuah@kernel.org,  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: openvswitch: Test ICMP related
 matches work with SNAT
References: <20240131040822.835867-1-brad@faucet.nz>
Date: Wed, 31 Jan 2024 11:44:29 -0500
In-Reply-To: <20240131040822.835867-1-brad@faucet.nz> (Brad Cowie's message of
	"Wed, 31 Jan 2024 17:08:22 +1300")
Message-ID: <f7tcythmp02.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Brad Cowie <brad@faucet.nz> writes:

> Add a test case for regression in openvswitch nat that was fixed by
> commit e6345d2824a3 ("netfilter: nf_nat: fix action not being set for
> all ct states").
>
> Link: https://lore.kernel.org/netdev/20231221224311.130319-1-brad@faucet.nz/
> Link: https://mail.openvswitch.org/pipermail/ovs-dev/2024-January/410476.html
> Suggested-by: Aaron Conole <aconole@redhat.com>
> Signed-off-by: Brad Cowie <brad@faucet.nz>
> ---

I tested this on a patched kernel and as well as an unpatched kernel and
got the following:

6.5.5-200: TEST: ip4-nat-related: ICMP related matches work with SNAT          [FAIL]
6.7.0    : TEST: ip4-nat-related: ICMP related matches work with SNAT          [ OK ]

Thanks for adding the test case!

Tested-by: Aaron Conole <aconole@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>


