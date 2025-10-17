Return-Path: <linux-kselftest+bounces-43374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBDBE7EAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106094EB072
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8E2DC357;
	Fri, 17 Oct 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BAHf8r5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAD2D6E71
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695023; cv=none; b=BeGaWil5EeLDIhuoata88wkMixZ5WBll9K00FZ7NhNBU30G6rcQiziz1HnOjTz/MGIfv+2bpZbdDJzfAAeFWtV0682wQPBZXp3t/VIjIt2iUv9xT62lP/pSebIerDC4tw3fodWRYsde7TR5o3DVXowfVxEd5l1cFs/Ry3OVSxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695023; c=relaxed/simple;
	bh=xwkxvH1FPDvwbJfFaw1wRPhCDrLbmhSWOofttyY7r+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiCw8pvNr06Lh6A+wjUHf6W3tddUqrK1d1LY7j6e1GT9O5QQMPJrteEyMPfyK/bgENUWRnF5/jbQVnaQe/57md63vjs/5XPlkSrz5y9jMXo+IPDuF9vSQznbNDgodLa5nLyPBx2yYdkjnEBhQMuX9TNkgxTFRNH307BYojB/nCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BAHf8r5r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1667113f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760695020; x=1761299820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjcGQpb5leVMb/C6XggUPD/+kfrKFLcG6qmnmp/+GHE=;
        b=BAHf8r5rrdAtbmmJ5i4mZuX0iZEU5vMCa1JxAlVrpOGqc4Y7yKVK7QARNchOKrkqN4
         cqEiizDpzOXvM0UfBlD7EjXtpSJ8sJ0/H+JWMQTqxVe209mYorVwNGjajs0qIXFnQX/B
         BZ345OwhlfUlSwurJvnpwowRoD31CxcHFKdiFwfP3qyzY7mRCSZ0NiVoDKnlYaP2adMk
         5KULHxddnIKlFBCWhFGCK/mJN1FVNmENGNnu27ejTVlx/PhJDURDSou0wWSIF96GcvJh
         /t10BvpxKN6uyKoggmH3RCcQHLNLtQbatN/ZBz60JCSzkAg5AWXfNglmGexNoBN8INqU
         4Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695020; x=1761299820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjcGQpb5leVMb/C6XggUPD/+kfrKFLcG6qmnmp/+GHE=;
        b=W6lRY4KpqGfqwyWI94drWC5l3KSG8ZwEXxcJLW3R0wC7KZ4VUW1D43N2awDA3u7DOj
         AkZSyXpTv3xJxArqZgOP73Yt3v/JJfFJVvj2IuJLJUxApY8LbUAtehB7gr4HiAl1aB6H
         AvVR8H/azX6dmY9gywRi9O1KJUkGA1kN9z+DGkBan1jSHTk73Nkb2ylPCQnhC0JIMzuT
         QPcnQQkaHTb9mj51RLH9k1kdk6G7Xdwd49DEU4wA+NBtqZYo513h2mOT6n8f3hZnmYpb
         HGYYFlhzveu0/zqoW052DBOO92kbw8uGIWprotNlGI3XQZfaeqQyhJVxFIGAZvaaHXjl
         0qpA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNdnq61M9Xh+Jth6FU+pWLyG4tbY4Zkc+HvfgUL9MghwwKGjCpIneQu/6SG181dOKckMdXcrhDgNuUJJAZBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyKNVUS16tuVkRdfKrnWlSB5vltjS/DUQqumKZzlDJ7ca6jLN
	HwUahx3UrVCZg2gILt/ayn67n2sQiEmDySbx48k+izuzl2QlzbWdnScD/GZffgHQW1s=
X-Gm-Gg: ASbGncuJ6qbhhMGtES8H0kefsNM9drwzcovQO8CkZLn4Ri9mfgmLbNIZnT1BS9L7tJv
	uuxZvdSmUnDcBz/cyIopiPt0c1bA34rfG0BO/5M0trTbAzwVUvp/W/MR+N5GZIUUEV+9y1xxcfC
	2OE9gDNUJwSWlpedJCSoBqhv8zXnSYwW3lw7Dy1V7nZUN7lVExf+1rw6YSHRBOJCeXl5q2vBLwH
	tdRro31hckzkdi7rpXGREljmF8dmbEr2DqJRH0xSXR4F4ZHkcUlQ8Kril9u/+3ZHVatQGHgW8J1
	yLrCeMo4LZWAa5naHWDA7P9h2UAfOsNq3mmz8zPfo8x9PEVl8rrB1dwrUoBHAmFaDAKsziqt2ck
	zmQGEwrr/5sl5GUN6kUpgPS/cervP1f0TreTfeywvGl7N5vz3MFJTF97rMpTIt6o9g40dgpNYbo
	aqz8j23UtVdv+7z4J59tiuMSHk27CGDNa2hFhP/Q==
X-Google-Smtp-Source: AGHT+IEeZDP2fZLW2njiX0+fFCA2KIjPFuvYhRMWhYWRWctEosSmZW5GRuJTpVFprjQALkK02Vuvcw==
X-Received: by 2002:a05:6000:24c3:b0:3fa:ff5d:c34a with SMTP id ffacd0b85a97d-42704da9deamr2388563f8f.39.1760695019334;
        Fri, 17 Oct 2025 02:56:59 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704a929acsm5791355f8f.18.2025.10.17.02.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:56:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:56:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>

Fri, Oct 17, 2025 at 08:10:09AM +0200, razor@blackwall.org wrote:
>On 10/17/25 06:03, Hangbin Liu wrote:
>> Currently, there is no straightforward way to obtain the master/slave
>> relationship via netlink. Users have to retrieve all slaves through sysfs
>> to determine these relationships.
>> 
>
>How about IFLA_MASTER? Why not use that?

It's been there for a decade. Plus is, it exposes master for all
slave-master devices. Odd that you missed it.

