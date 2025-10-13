Return-Path: <linux-kselftest+bounces-43024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F2BD5A84
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D540219A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D482D12E2;
	Mon, 13 Oct 2025 18:11:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF0259CA5
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379067; cv=none; b=ZQnj4bXDRZ5OjlM1R65B1lwF2fEll2wchnpTfr03hcpj3Y5fSwKCcm3juevcZJqmtPInNT0HOx7T1MIpvIVYEEH3ROgR6v7cL0WCtoxEtXsB+5WJql7QPIV2pIs70cNjTaRSVYZ+p0rnCPgt7wEPB8X1lVxBSRTMx45Oa87avyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379067; c=relaxed/simple;
	bh=0Bzuud3fbzTgE93y68oTL55XoEOeH0xhkZtO0YadA28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjDeDSC7V3CFLjvd6dpStbDGZ9NKVcmgJzIyezRLdMJs3oNfQ86essTYLjPFIJpxsnvsPoBcHHlB1bp0NZeu6wRvz21vlHDpDLHoGRm/KMdCCVkci0w0i723zQdu6tFHbwUoY9Gkpp13EbKQwVRnYZrrsXwvBQQYHVNIrJZlj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b27b50090so838621466b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 11:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379064; x=1760983864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NktohjsRp1hmfKBBZVJM9FY0NL3mIXRdvn/tPXzoAnk=;
        b=upRG2PA+fxeuJnt/b4IO7l600TsO+MPsGqxxTFGD7gECSKNgfR2qp9dXWQM7fj3tYs
         8Bpmnoej1zXtupBUHeLv9ZdUJwQcwR3XRAWm7S2hxQZ7WtjClYDMuOOl1ipw9aBCqAA3
         U/7JE6OuKN3ePil6tkmzJ/Va4dReLW9QUL00Q3SYTjpmpxkjOPkwRCOL+lYDrqn75i+G
         YptQHuoyWSarLH4r3HlbYO0v2qDjcVlfhi8wffAE00tp1bGY3qK5/PBAA9q8BBKRGXy9
         rczAhKutEzYrksYcpw5yKqZIBVmfqG+HJP8F/lLitniwzJnrsrO52uB+73C6UpQhuzdA
         E7uw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ABiF3ZNAxuP6zIQePTaSFfevjCAl/mJgLojQ8B8GtLkpUEBw0XT44RAWdxpKsvYlvWiyt8MwYfGpRXcHvAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzSD3dPmkLKF01PTwD0R1NpcntnjYv2Tk0uBk96k0Qypa2fuo
	9Ku09fRJsJXs2NBppc8h6iqrw7Yc/HrZdtpbL1e0WAgfhvW5ZBzTU7KK
X-Gm-Gg: ASbGncu6CgfDaZMA/WOxqX01yM/NvX1ykzvUJW9tqXFBtO/D9kbxjYNtgHF27HpJhR5
	pnmDNSVpGeBXVWlWdnN+DGbUiV0HvCYBPbRJTduIoEPc/U5ouinzpzMvqwNZjTsj25gqKb+32Nm
	lxqPJ6GTCZq7yGwg9fnaSFPH+SLw9/ymFmL8qP769PxIeTRKZb/gN+4X2lRNNp7JjNLQYToW1De
	44GT4nUkiZ6t8CIgR44iiOEjeJ/eTg06IazuTePKrtLLBRZGp/J3vRhJIYsedxhFwCMv9HFKT49
	xm9csKQlA3Gq80qY+AV9HFULu+z7loiffsS3z6qeKmVovh8MOAqE7+fm/ZtiOPTiyI/rcgzYDcH
	0LCTy6NqzUXAIxSkh33ec/LKyfxoUN5JKEU9C89MbAXsAnw==
X-Google-Smtp-Source: AGHT+IHbes+6c9B6vBDGbbc0VnnI9qPJtLLBClW/BkZx58Er6Zqt3ZVOHaRjm9I+D9i4QTYnlUSGfA==
X-Received: by 2002:a17:907:7f8f:b0:b4e:a47f:7157 with SMTP id a640c23a62f3a-b50aa9a1d23mr2461363366b.19.1760379063674;
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12c48sm980952466b.50.2025.10.13.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:11:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <3aozzslkx7jpiabyvey3562i57ogqkw2wb4xfp7uazidj572p6@jg6lw5dzxxto>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>

On Tue, Oct 07, 2025 at 11:47:22AM +0200, Paolo Abeni wrote:
> On 10/3/25 1:57 PM, Breno Leitao wrote:
> > +# Clean up netdevsim ifaces created for bonding test
> > +function cleanup_bond_nsim() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> > +	cleanup_all_ns
> 
> If all devices are created in child netns, you will not need explicit
> per device cleanup.

Humm, that is what I was expecting as well, but, when I tried it, I found that
the interfaces got re-pareted by the main network namespace when the namespace
is deleted.


For instance, in the following example, eth1 belongs to namespace `ns1`, and
when I delete it, it then moves to the main network namespace:

	# ip link

	# ip -n ns1 link
	3: eth1: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

	# ip netns delete ns1

	# ip link
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
	link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
	3: eth1: <BROADCAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

