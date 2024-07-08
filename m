Return-Path: <linux-kselftest+bounces-13325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E304892A8F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165561C215D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92B14A4E0;
	Mon,  8 Jul 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbhuJb+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14994149C6A
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463279; cv=none; b=pAsr5xeupO4QeqS1E+WGCkm46/sCz2fwxBi+GRWqHAoRQFpU4T6pUeiVgJrJOFnptMrJ+yRH3kzcTIn9hg0rHayZv3Qyem2U6LEUIXPYfl7vdIDfAYoDvZWvldW9TTxOBl5BRyuBkQ2gjC7SQbkuaJUt7VkXAK19nlqSKXOQdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463279; c=relaxed/simple;
	bh=ilPn+u949EiekXc1fNlL1FFhQXdzr142oQcIyOq1/8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0uL+CNK29awTkO5MwmGub3dqRkQOXhn/jQOkR0JYH6+mNNlOJ1LqHMi9Apv/fGAtxTE8FdhGZNa7eDx1G1nNryuwQRBwn9gvpZ5h0iKN+xhmu089kA2SZjecY8ofV2UoznEx3O7vadmJ5NT5tsbb3/Q/5iedvPLsvfC/EVQkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbhuJb+l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720463277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFsqwavuUe9u0s443Cn3sa3uIqOnS2CpWueQCZ5/X/E=;
	b=GbhuJb+lMDipIK7ipH6c+w5fb2ORCfS+hvtJK5rgR2iCZTN/kT7v0jN5YTbPbzYdZI4N8d
	SM5B9dKNCUKRZ6SBRh/17V5CTSfzu+/eUPBminfK2wrNXDTCWF/c3yoOl/zcrsbB+W4gRQ
	7HIwPsP5ocxiZvWsjOapNCB/sf/ILBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-60_gX4xZOkidNDF89tLsgA-1; Mon,
 08 Jul 2024 14:27:53 -0400
X-MC-Unique: 60_gX4xZOkidNDF89tLsgA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB174195609F;
	Mon,  8 Jul 2024 18:27:51 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC8B619560AE;
	Mon,  8 Jul 2024 18:27:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests: openvswitch: retry instead of sleep
In-Reply-To: <20240708134451.3489802-1-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 8 Jul 2024 15:44:49 +0200")
References: <20240708134451.3489802-1-amorenoz@redhat.com>
Date: Mon, 08 Jul 2024 14:27:45 -0400
Message-ID: <f7tzfqrn3ha.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Adrian Moreno <amorenoz@redhat.com> writes:

> There are a couple of places where the test script "sleep"s to wait for
> some external condition to be met.
>
> This is error prone, specially in slow systems (identified in CI by
> "KSFT_MACHINE_SLOW=yes").
>
> To fix this, add a "ovs_wait" function that tries to execute a command
> a few times until it succeeds. The timeout used is set to 5s for
> "normal" systems and doubled if a slow CI machine is detected.
>
> This should make the following work:
>
> $ vng --build  \
>     --config tools/testing/selftests/net/config \
>     --config kernel/configs/debug.config
>
> $ vng --run . --user root -- "make -C tools/testing/selftests/ \
>     KSFT_MACHINE_SLOW=yes TARGETS=net/openvswitch run_tests"
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Looks like this does resolve the issue in question on the -dbg
environment:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=openvswitch-sh

Thanks Adrian!  Also, thanks for including the fractional sleep.

Reviewed-by: Aaron Conole <aconole@redhat.com>


