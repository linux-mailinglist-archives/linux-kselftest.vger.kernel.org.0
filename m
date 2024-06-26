Return-Path: <linux-kselftest+bounces-12813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A091841D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB39B259E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FA1850B8;
	Wed, 26 Jun 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeGqIaEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139791850A4
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412079; cv=none; b=CTh/ELkeWs0ljXU2AvRiXoUEmqmOP2caCTybEhxQxHvWKGAhF8cG7PREO+YVOAIDl9IgP5vU5qYOVu127L4QFMPho/FvOy0ZHc4KceH+xMFxdrMviKRmKuTXDwKB010muIEePaWEJQjcZSiWxoOXd3u1Z3yIER1zqdphguJOHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412079; c=relaxed/simple;
	bh=uvJrspBU9bKcZunDCtqHx/7zul1bnfXgHggRAC+SCok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ep2MCT8PfAcLxEUYE+0Rm5k2wv2r2HUsYTUn6kcEl70qfh4DHyyryuQ+u2f0hSNqKQrYw71zHVieGqq58YgL1txYiNmLR2ZSMqXq7BovpDwSfbiRWR13Sn9RSJIB+NcdUCmgv/U4d89+UHLClc87NdqNyldMPXG5HfGbcnwhatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeGqIaEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvJrspBU9bKcZunDCtqHx/7zul1bnfXgHggRAC+SCok=;
	b=HeGqIaEVikMR2wCTICtTY9VQ47WimQmsB7RfrM0AQidaoEe6m7s9jt3zeKifjm/5OBLQdR
	VDNzV2s/d2bHF9l1+gMBlERI0RE1YuPLQdvSoPQa80EKgFwWEyFk7JqOVt+hSQE7p6yyGL
	b6SIHE+njHjycSnPP2GR5whnkIri6jc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-5Xs4ubPQMWGqKDpLVT_gLA-1; Wed, 26 Jun 2024 10:27:55 -0400
X-MC-Unique: 5Xs4ubPQMWGqKDpLVT_gLA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fe871a5aeso233921166b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 07:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412074; x=1720016874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvJrspBU9bKcZunDCtqHx/7zul1bnfXgHggRAC+SCok=;
        b=km38DLVvcpYGp8/DBEj0bKPHaK/jgSrbWnfRhO+t+8zF9b2ahSJkucbHDbsFwWyHQS
         MypJW8F3BocQs5YATVNrDBiSyZiY+mTQtKazj58zIonN84Ki94nLYNf4gQZjj7WNExSx
         HbIrbIYNZQgrHsXqEtL1UQORK9sxmQNy2OvwEyr/wMu7VNBdNKx7ykadBTrP+82oOQ03
         ab1wGMGFG5q3sSZOixVPkJfFDoVjKPGfYJqiT5Xcv0m3ypISDWIOkBfbqPp+j0CjPzyf
         zvRDp7ulw3+bRjFoM9dQURPqJ13wfNVJv1i2P0WEX+vt72PSopaJxlYUMllpKle9XD3e
         8jQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0q4VVNx9whesbheWelwj2bLbolBCegB/F63LYTf2QBQ74+4pnbZqV9t3kvtUqQFY44sQUXrp/ODVNBD/aYnRCo9/THn4nyRGsbt+jQ/1B
X-Gm-Message-State: AOJu0YwhyIr5ogsKMWHk1yB0pNHOYBs5HOjcXDT3vj4cGqzO19y1SWZY
	HcHaSyCnO2FpxYiSxUP94EHzwdgCYuVT3vMAZVA0vni4SthpHsATv+rXxEuDSGT/AAi3V1w/xtu
	1eiHIfqB4o9Crh3KxLEXRmxhnXg4mxLXn+6C4HkTCTv1qpzpdBMageh4HESKMLz3yZw==
X-Received: by 2002:a17:907:270c:b0:a6f:b181:e3a0 with SMTP id a640c23a62f3a-a7242c9ca27mr660659266b.27.1719412074539;
        Wed, 26 Jun 2024 07:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGITU0WM1nvWNIRcPvt+8mKmTQC+2o4+y19m9kOvk7XXOOdDyxmbEGYzgSiACONT2x5sY2Z3w==
X-Received: by 2002:a17:907:270c:b0:a6f:b181:e3a0 with SMTP id a640c23a62f3a-a7242c9ca27mr660657566b.27.1719412074195;
        Wed, 26 Jun 2024 07:27:54 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:27:53 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] net: openvswitch: Add sample
 multicasting.
Date: Wed, 26 Jun 2024 16:27:52 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <256A6A9B-FAFA-4048-985E-7165B38760F8@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> ** Background **
> Currently, OVS supports several packet sampling mechanisms (sFlow,
> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a=

> userspace action that needs to be handled by ovs-vswitchd's handler
> threads only to be forwarded to some third party application that
> will somehow process the sample and provide observability on the
> datapath.
>
> A particularly interesting use-case is controller-driven
> per-flow IPFIX sampling where the OpenFlow controller can add metadata
> to samples (via two 32bit integers) and this metadata is then available=

> to the sample-collecting system for correlation.
>
> ** Problem **
> The fact that sampled traffic share netlink sockets and handler thread
> time with upcalls, apart from being a performance bottleneck in the
> sample extraction itself, can severely compromise the datapath,
> yielding this solution unfit for highly loaded production systems.
>
> Users are left with little options other than guessing what sampling
> rate will be OK for their traffic pattern and system load and dealing
> with the lost accuracy.
>
> Looking at available infrastructure, an obvious candidated would be
> to use psample. However, it's current state does not help with the
> use-case at stake because sampled packets do not contain user-defined
> metadata.
>
> ** Proposal **
> This series is an attempt to fix this situation by extending the
> existing psample infrastructure to carry a variable length
> user-defined cookie.
>
> The main existing user of psample is tc's act_sample. It is also
> extended to forward the action's cookie to psample.
>
> Finally, a new OVS action (OVS_SAMPLE_ATTR_EMIT_SAMPLE) is created.
> It accepts a group and an optional cookie and uses psample to
> multicast the packet and the metadata.
Hi Adrian,

I reviewed the first part of this series to ensure it aligns with the use=
rspace integration. I skipped the selftest patches, assuming Aaron is han=
dling/reviewing those.

Thanks,

Eelco


