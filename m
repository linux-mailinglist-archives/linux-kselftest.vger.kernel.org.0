Return-Path: <linux-kselftest+bounces-12097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A990BA18
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4283228004B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A3198E73;
	Mon, 17 Jun 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQHHHvNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC856166312
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650128; cv=none; b=UAOeK9Iut4YRiCpzHjnhbwVKvo5+nX7K0gKkf98YqHvE0EKFiOB109LT99D7Zsq5KlnAU39xadLWoSuvCUuwQQsOygSPbDXVjgOB+7jHgQqtZ9UJB4TxPsT+N2fezS0zNC+hZC5z0TEzo7k+FsUMlG/NnFonxsV1X7SWYHqAvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650128; c=relaxed/simple;
	bh=2pW5K756b3vnOMMzbNNarIqr13h/Yp4f80y1nx+hSeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuvHEpsuJ0+WH3dIWC6JhRKTTjDoNeNHL+eBwNqt6LIHaAt75LxBCamNz+VgSgIKzDCmAs42ZgxvVmf34skQqX+AkZVnZ3Fu6AiaRAaaz7QKNf4lPsaEcJJ1hi/UoGA41Ri8b/LIH3uJuHUstvmcTcqeQeOH6Lo6FJPApEVgZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQHHHvNf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718650124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZaXnpTdtezaPILoSmIEc1ZZ9gp2RX1pMrPgPH0P1ko=;
	b=QQHHHvNfVyQOhnbnt1++JzugD5pRY884A6Y3GMiPWK4Ipa4lXJsqG8Dp7nxu3lCuiXdkWG
	6Xx32+lMeNUJMAxT5yoQCIDH8jD4BRgcP4f5EYQ0moqYg5JB5Ln6GS+kasWz0Oq49uu2wP
	hVMlVc3UVqq1+k//Ud1UZuSk7byLtk8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-PkUv--UFMge2y1Z3w6A3ng-1; Mon, 17 Jun 2024 14:48:43 -0400
X-MC-Unique: PkUv--UFMge2y1Z3w6A3ng-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-632591a256bso68395697b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 11:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650123; x=1719254923;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZaXnpTdtezaPILoSmIEc1ZZ9gp2RX1pMrPgPH0P1ko=;
        b=VMmS9aq/F1V2JxUj87TTTslOxYLMdcv7nSbRcFcOrIAYNdRBmPTRLXf/gyr2AcQcjx
         b+RNne+zPEWaIGOCOp6akihT+O/rXOxnxsF3d/QQYaAWiV02Ot9d5dOcXP3BHNKIxJli
         8gwzP9oz4ia01UnalfiZreDpx/8zGzl50jjPfnfoBZK41/DeNjFsGDTlU5Tzqw6eK3s8
         csBU6ng35KKpTwq3vkPf5uIKSYHUyJvuP/E0COa9hXAgCArhNcKmG09yLESwGCMJFQSQ
         BN1JPbvFaSMokFDZYNT8ifhJdtj9ex1GhTeisYuOZ+UL4BkHmKlI+fYhRMhPSnsIhFAq
         OG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWfO7MkEr1zQes7YG0aHPuCY/15Akmrokq/LLeF9LWRQtcjFL7cHlcLwY+nPd1XDHGipWo+xOyVcZPU84rexUQc3dQMptufFaoZruxe/i33
X-Gm-Message-State: AOJu0YyjUY1jxpBshJpqW9FrhOAbIZ3dXN/vUXDc0gfh8tIPi7428Oy4
	KiQtcbHRqwgyFAP6Vc9K7r4pKzdjSmHDw16bsEkcV3zivd1df5p0S8NyaiqFMmmR4cy+h1H90jF
	J4xgJr5v5bpIGBXSJbB9EPUg0DiBbKq3XmtCL5E9qmimqoVyJvRxhF43ZKTAvY0jleA==
X-Received: by 2002:a81:9245:0:b0:617:d8a7:df60 with SMTP id 00721157ae682-6394a6c537dmr4984557b3.40.1718650122510;
        Mon, 17 Jun 2024 11:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD/nY/QKBHmtUF5IvBSZOGzxA0YnpE8P+v9PhV468bowcK1HtPww2hkYffchrQU0zOplnI7Q==
X-Received: by 2002:a81:9245:0:b0:617:d8a7:df60 with SMTP id 00721157ae682-6394a6c537dmr4984307b3.40.1718650121979;
        Mon, 17 Jun 2024 11:48:41 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5f10739sm57649316d6.146.2024.06.17.11.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:48:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 20:48:04 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
Message-ID: <20240617204804.680a1254@elisabeth>
In-Reply-To: <20240617180218.1154326-7-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
	<20240617180218.1154326-7-aconole@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 14:02:17 -0400
Aaron Conole <aconole@redhat.com> wrote:

> The current pmtu test infrastucture requires an installed copy of the
> ovs-vswitchd userspace.  This means that any automated or constrained
> environments may not have the requisite tools to run the tests.  However,
> the pmtu tests don't require any special classifier processing.  Indeed
> they are only using the vswitchd in the most basic mode - as a NORMAL
> switch.
> 
> However, the ovs-dpctl kernel utility can now program all the needed basic
> flows to allow traffic to traverse the tunnels and provide support for at
> least testing some basic pmtu scenarios.  More complicated flow pipelines
> can be added to the internal ovs test infrastructure, but that is work for
> the future.  For now, enable the most common cases - wide mega flows with
> no other prerequisites.
> 
> Enhance the pmtu testing to try testing using the internal utility, first.
> As a fallback, if the internal utility isn't running, then try with the
> ovs-vswitchd userspace tools.

Oh, nice, it looks saner than I thought. :)

> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 145 +++++++++++++++++++++++-----
>  1 file changed, 123 insertions(+), 22 deletions(-)

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


