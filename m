Return-Path: <linux-kselftest+bounces-3934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB998457E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E81C24072
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FE5D47C;
	Thu,  1 Feb 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6s5EdgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E25D46B
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790717; cv=none; b=fFIUSjKWNqq4/KLFRijpBItrEuSYovojzBFELLagvQlJ/S66QaSAlZDYvHxlTz0G000PSpSPa2UIMPxzsJzmlQdKI3eZINA4LAobBfrMY1s9YJvA2asLBs8KYaV8w85zqHVOoDfCEPMSK+ANCcAHwX4gvE72/NNeFuWISKdM7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790717; c=relaxed/simple;
	bh=vFuz6GjziEsF8tIFPzKP71+n4ONaqUX+bFUX3vwueo8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/2NZr+8Sqck12Jno/VaE2wULUT/+fE5o+5sbPhQBJjb1C4GJusnZMRp08cpkWK8hQSABceFcQNV9EHS/3YCULSdCrsEMaJjRK9IuvfD1t3NvqOCcZ29J9//C+L/aix7LeueNYThNbq9L+HjnSuCOJumv9kMRD22CUxQV2Thc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6s5EdgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706790714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bTUZkGIAnQ4UIrmyCuy0FjocNAqGSflk8m8tXe4IgM8=;
	b=X6s5EdgKUea4B8laAGRc3FKvCGlbf1HsKPZPXSweIXwuycPVcT+Y9Jf8J/3n9oCosZ0+HX
	AC13mgNFSoFP0Wd/6AHVyzHo/NHLh8elnY590doSP8NyOINr6z3Rsb/BUEsJKFSxDMhUq9
	jCfXF1y7Zbvs8Gnl2rMuu+vWh6oVaIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-rVfdYuv4OBmTItGzWTkyEA-1; Thu, 01 Feb 2024 07:31:53 -0500
X-MC-Unique: rVfdYuv4OBmTItGzWTkyEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40fc2c5818aso173995e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 04:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706790712; x=1707395512;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTUZkGIAnQ4UIrmyCuy0FjocNAqGSflk8m8tXe4IgM8=;
        b=sHvGQDXLSsiRbDXJpscltfuObP1mlTn1z/sAm2yRle9KD+gUI9/dc/9kbUsNSE47KS
         pIGcGBfNutrOLhGzZFqYbDt62hC/eG21bOXvefj/6ckNxNoIMmeZbKNTfcCSSnBBa93L
         1Bof5MwJGUM4Fvd6PwdbXUEAOP6Wl0qsQmRmT5H+cCkXMFg/2B4H23fk1sSWnjPa6YM7
         0nykyZJs1SeoYYOOfzu2eO3M932IMTYLriMEzHoLktASxvtLikAKxjhvxX7IsEhe0BxF
         0eTJCGuVb/hd91quZsYudfM26YrP8kn+vO7vKLOdO7B1ShLw65nnp8YIKCrYmrZ3FTnM
         hzBQ==
X-Gm-Message-State: AOJu0YwoD0KZ9brHRwdFKunkC6FTjRplkY5DdVX+2N7VkeQ4cIyZVTK+
	yoaV/cMwRhgXnoNutXKLY1jT1w20KcW7HI3tepB1l2yqsKwuh6zwQ3beKUGkBAL5k3SFmuVWYyP
	aNY2hLPZOAhaHOGsnDUNtHoAkUnsGc+OT/jWKSjEncyMqSCyz82yN2F2DHUywC+4uxQ==
X-Received: by 2002:a5d:4f89:0:b0:337:c6ee:3d7a with SMTP id d9-20020a5d4f89000000b00337c6ee3d7amr1619998wru.5.1706790711881;
        Thu, 01 Feb 2024 04:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU5FE1/QQHBxbfXTeTRxXPq7220Whd+L/Z8t9G34xGeWinx+1tt/R9oJL4aaDO/hpOptf3Yw==
X-Received: by 2002:a5d:4f89:0:b0:337:c6ee:3d7a with SMTP id d9-20020a5d4f89000000b00337c6ee3d7amr1619983wru.5.1706790711529;
        Thu, 01 Feb 2024 04:31:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOJpaMuiyq6dZ8ZMz+gaEM5j1Uo44Y5Qb4Fxj/RX3hxQtPPjCB27S1OXm5w/H5F3B8mhvjXCIR/UnLLOW2fXIXH8VZaxtcwR//GRPCjcMuwTtxrEQRT57Vehv3v70XB9QURK+SBY0flHxXxzhfoqpRg0cIkIrTNwN0X/b9EzHO000SYzvXFTzxh4J0WL/onXh2eoAxg48Qj34J8PWmpVCc51cy1kyd1LxUFZ/rVFa7tz0=
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ae6530969sm13415277wrb.85.2024.02.01.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:31:51 -0800 (PST)
Message-ID: <5dfcfc03f62f80a498b9281e31f9e40ae1e35a34.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests: net: Fix bridge backup port test
 flakiness
From: Paolo Abeni <pabeni@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 shuah@kernel.org,  razor@blackwall.org
Date: Thu, 01 Feb 2024 13:31:49 +0100
In-Reply-To: <Zbt9dxyJHszL4Aoy@shredder>
References: <20240201080516.3585867-1-idosch@nvidia.com>
	 <4cca1f0d3c015a6ab9e371b1639f6c3c29b33024.camel@redhat.com>
	 <Zbt9dxyJHszL4Aoy@shredder>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 13:16 +0200, Ido Schimmel wrote:
> On Thu, Feb 01, 2024 at 10:34:52AM +0100, Paolo Abeni wrote:
> > What about adding an helper alike wait_local_port_listen(), checking
> > for bridge link status in short intervals, to likely reduce the overall
> > wait time?
>=20
> What about the below?
>=20
> diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/too=
ls/testing/selftests/net/test_bridge_backup_port.sh
> index 70a7d87ba2d2..1b3f89e2b86e 100755
> --- a/tools/testing/selftests/net/test_bridge_backup_port.sh
> +++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
> @@ -124,6 +124,16 @@ tc_check_packets()
>  	[[ $pkts =3D=3D $count ]]
>  }
> =20
> +bridge_link_check()
> +{
> +	local ns=3D$1; shift
> +	local dev=3D$1; shift
> +	local state=3D$1; shift
> +
> +	bridge -n $ns -d -j link show dev $dev | \
> +		jq -e ".[][\"state\"] =3D=3D \"$state\"" &> /dev/null
> +}

I was wondering more about a sleeping loop, something alike:

wait_bridge_link()
{=09
	for i in $(seq 10); do
		if bridge_link_check $1 $2 $3; then
			break
		fi
		sleep 0.1
	done
}

but no strong preference


Cheers,

Paolo


