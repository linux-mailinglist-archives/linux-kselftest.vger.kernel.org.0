Return-Path: <linux-kselftest+bounces-8257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18C68A86C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0421C20FD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599F142634;
	Wed, 17 Apr 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnyYWBfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F11411CA
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365576; cv=none; b=pDlc7JiZ8MMM7YxVlz5byvYiIRCjppNg8r+Miio/Afi+K2GG0VGOmn0fWA473jJJ5ZNW4mqR3qW3IcUsyJ/0CTa47qXayTNfEM/xDYk2P42Ivy7bLzAMjGcvLxYanh3M6gmAMfiPuWoU+dG1w2hTZw2ucydkEkBlWTRQ9keHpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365576; c=relaxed/simple;
	bh=o/WZVlqzqs+cchBVEDszJLyTbJFnJswqUxOSpCM7tSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+epf/I6FKsjGA9bia7T24XwKOSjZlb7i54dUDGxwjNah8U6vE0sWgJ9BHo6w3vUDmaAQb87NTlsOqnItJWevei57etAmLSfVDK3aKqqTqu+f3bEdACC1wJlv8DFo30n+/r23/KELBAmtTEma9CgKrNPyYBzg+MeuRPE1QwuSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnyYWBfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713365574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/WZVlqzqs+cchBVEDszJLyTbJFnJswqUxOSpCM7tSg=;
	b=WnyYWBfPf2BgpsaA9QyRdJH0FWBsO9M3iX6vM1bnIJQQQtzQNV2oqXJ/ZP/cNXwxq/brTw
	/I5wDd7pNEZB7zd1qc8hTdK42F6iNKVmtWK+mHUdZQzEAoI0P/7l4OxsA62hMdUbTn3GV9
	gfMaBfZZWz/VCWuDum0VjBwBeVRHBDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-hPO2HUuBOLC0GHQtplWUQA-1; Wed, 17 Apr 2024 10:52:50 -0400
X-MC-Unique: hPO2HUuBOLC0GHQtplWUQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B051104B502;
	Wed, 17 Apr 2024 14:52:50 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC881121306;
	Wed, 17 Apr 2024 14:52:49 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org (open list),
  Paolo Abeni <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>,
  dev@openvswitch.org (open list:OPENVSWITCH),
  linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
  Pravin B Shelar <pshelar@ovn.org>,  "David S. Miller"
 <davem@davemloft.net>,  Shuah Khan <shuah@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: openvswitch: Fix escape chars in
 regexp.
In-Reply-To: <20240416090913.2028475-1-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 16 Apr 2024 11:09:13 +0200")
References: <20240416090913.2028475-1-amorenoz@redhat.com>
Date: Wed, 17 Apr 2024 10:52:49 -0400
Message-ID: <f7t7cgwavni.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Adrian Moreno <amorenoz@redhat.com> writes:

> Character sequences starting with `\` are interpreted by python as
> escaped Unicode characters. However, they have other meaning in
> regular expressions (e.g: "\d").
>
> It seems Python >= 3.12 starts emitting a SyntaxWarning when these
> escaped sequences are not recognized as valid Unicode characters.
>
> An example of these warnings:
>
> tools/testing/selftests/net/openvswitch/ovs-dpctl.py:505:
> SyntaxWarning: invalid escape sequence '\d'
>
> Fix all the warnings by flagging literals as raw strings.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Thanks, Adrian.

Reviewed-by: Aaron Conole <aconole@redhat.com>


