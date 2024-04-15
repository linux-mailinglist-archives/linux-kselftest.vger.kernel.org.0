Return-Path: <linux-kselftest+bounces-7998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58C8A56F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEB3284A98
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22E7F7D9;
	Mon, 15 Apr 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgMeuffg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0279DDB
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196977; cv=none; b=quwHxICBN3MR2tcG828Vi7TbIa4rrOGytCwAUdZNtOIBCxbmTRr3HMIKfruIrEHu1piRrAkj8/BtKaT+WFpIIfGRAj4YMBVXucQm2hyUUfgSs06hZHcojiBqqsBVmiU6mCz1LfXiflL7FdG5WJZA99LBwFQM+f/b7RRDQzwFRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196977; c=relaxed/simple;
	bh=RdF5KTAEd8tP63a5S5xqNAtGrngcFzpU05PPOfhTqD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIFG0SOkO+I2bk6qoCBRHfbFUvNQJMIl3Ao9vhYElpL5oG5HAjOm1VKd+8kwqDYv+TJLs1Dht5E9FRdxtxf3AyjmHLsXv0HdXvxMSEvhLc3Kb9zYbHaFSvjvywwIgQamjGzpXC6HzNJNbY1gOBbuOjPVU+GNhPYA2WvKeaZ8K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgMeuffg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713196971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdF5KTAEd8tP63a5S5xqNAtGrngcFzpU05PPOfhTqD0=;
	b=KgMeuffgpI8O7Joyuny3hCX1j3p1yQW9PlggZB/eAatxAw6G2ZRhmZoSpFxdGQENn4viTE
	IgtD2MUFYsm2f0yc7uTK9nMGbSUuHwLvWWN1W8pogNXg64qebCf2AQBXesOAw/Dx3sYfZo
	DibLoI5bHoA5n65cLkJW0nkuFInw3yk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-o4FdfuyHO7-xo2R8BZ3Zxg-1; Mon, 15 Apr 2024 12:02:50 -0400
X-MC-Unique: o4FdfuyHO7-xo2R8BZ3Zxg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3450bcc1482so892140f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196969; x=1713801769;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdF5KTAEd8tP63a5S5xqNAtGrngcFzpU05PPOfhTqD0=;
        b=dQ3ib/AFVBScS+xW3yQ+utLypjFdbzwk+5LCk6GvqFRZF6GuSYxSgrVVa6dOqIBW7z
         lK2TKI8r/Hgp4LEnrMhcdLONBzPDSkOTDltPCruSfVNWZZ75j2P4ZXD2L4hDCiRhrPqW
         LTrOPHd7ahhfqVhM4WH0R79FdQ8lKn7Q0s7Ad0/Amg+HfuCKC/9KMigbosG/mKvBnGBr
         rhaOpjYqpwFFiyi9ELDeP/u8avbh2GeNGUxep3ZBaiF13dbk2THbv+s91b3wEPNKHo6g
         9R35XFUCOqCYU1pKz2eDQMawfsLu1xRHLbtWp3u1AuFYCsvHx0EoNr58I4XmS/Wp7YAH
         uRaw==
X-Forwarded-Encrypted: i=1; AJvYcCUErdq3Ik5PoGevUx20VmrZjKh37+6MqSyqCIdK0oDf/GpNJWvDCSKopC6s6FMFWS7B49Ci+Z3qNms2xnrUE5cNFyZiYKMbLQFg9sxX12fy
X-Gm-Message-State: AOJu0Yw0aGuUVy7OqPBwEOdYQh/4ByfLz3Z/z7eJ9+a+wigBUhWT7HKe
	UeOerqlaX7DxDYM1JbD7Wdm3U680OOgWN7H6YAt8LeRcCJY3uY27nJRtQNFePNF5c34Ax4KerH+
	9ILwWWxhpOYRlDTWa+Y0eJ8aLp4weBIFtQlKMR++ETKJVWYQIQ23XMhzFEIJ7vMFSaQ==
X-Received: by 2002:a5d:4ed1:0:b0:347:c3c7:9636 with SMTP id s17-20020a5d4ed1000000b00347c3c79636mr1996004wrv.0.1713196969373;
        Mon, 15 Apr 2024 09:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi7mKQpeI5LjsD7Na6Y0KmHDTB9nCL71TU5jjZgoOgX+C40H8rEgRC+0acrKh8lA8UrTFKdw==
X-Received: by 2002:a5d:4ed1:0:b0:347:c3c7:9636 with SMTP id s17-20020a5d4ed1000000b00347c3c79636mr1995988wrv.0.1713196968979;
        Mon, 15 Apr 2024 09:02:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id b10-20020a056000054a00b00341b7d5054bsm12594496wrf.72.2024.04.15.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:02:48 -0700 (PDT)
Message-ID: <0d02dbf78a0ab9f149c0c70a8508560d22abeffe.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	shuah@kernel.org, petrm@nvidia.com, linux-kselftest@vger.kernel.org, 
	willemb@google.com
Date: Mon, 15 Apr 2024 18:02:46 +0200
In-Reply-To: <20240415071914.23589fb8@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
	 <20240412233705.1066444-2-kuba@kernel.org>
	 <a80414c647940747c37a8c750bad4290ec81bd66.camel@redhat.com>
	 <20240415071914.23589fb8@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 07:19 -0700, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 10:57:31 +0200 Paolo Abeni wrote:
> > If I read correctly the above will do a full ssh handshake for each
> > command. If the test script/setup is complex, I think/fear the overhead
> > could become a bit cumbersome.
>=20
> Connection reuse. I wasn't sure if I should add a hint to the README,
> let me do so.
>=20
> > Would using something alike Fabric to create a single connection at
> > endpoint instantiation time and re-using it for all the command be too
> > much?=20
>=20
> IDK what "Fabric" is, if its commonly used we can add the option
> in tree. If less commonly - I hope the dynamic loading scheme
> will allow users to very easily drop in their own class that=20
> integrates with Fabric, without dirtying the tree? :)

I'm really a python-expert. 'Fabric' a python library to execute
commands over ssh:

https://www.fabfile.org/
>=20
No idea how much commont it is.

I'm fine with ssh connection sharing.

Thanks,

Paolo=20


