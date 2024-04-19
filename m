Return-Path: <linux-kselftest+bounces-8398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C28AA82B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423A31F226AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78EC121;
	Fri, 19 Apr 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpfaZSVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3567883D;
	Fri, 19 Apr 2024 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506554; cv=none; b=Y1w2qTUxb2t4wTig0TxeLDZxSjwXvya0waiIrSdc7h2/aUDLDK193Z7AJj4K8EgLaU5FoazSbky4uRMdNTx2fm1p7ipLZkxH2OL/e3wbZEtA37COzTwVmXwj+BSQjxWNR7Ck8SgWeOTo5brVZvZi7yDIXB67bv858Q4TT9Zx8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506554; c=relaxed/simple;
	bh=tc45MP3xvAi/fc+qLWIOqm89KZMY3tKZKlLAqK0H6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDLPIIVyvSSbHbfrfpvFMi8pUPYEtwofiFQZMfmlStgZSBKV4+/sCNEoSWNYkPlF96aeRn7o2jq8tR3W5igtcy9iGabd1zr9ua7AFqgtejEgRCuAZB8pvXr1jz5GdVZZnKudPw09m51t8POMaWQkHiIfQPqz1RjFDSVZ/udvgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpfaZSVu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so1657417b3a.2;
        Thu, 18 Apr 2024 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713506552; x=1714111352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot66TNo9jo8sFoPSFYhZLhjDFx9tukqKH85BtSrdHiM=;
        b=WpfaZSVutdmn13zAefAXxI2bSrxbt9B2iwVweOsbo0qdhwrNlu/qRbmFVSwzHmYrl/
         h+Qp5NVLjjVrokCG8R0K2NifBCtIHUHS15lrN5CYMGFEHs23SnedTu2JhJ/Y96xWA1+i
         1ow6js6zWlLxN1Wq6INElZlZ1BlWBo5QV8WMPFq7IF3JehRprk+/ARDG8tFeSUey7U61
         Z0zPmU5rHa2RluzMcDm0BpQ6wxs5wY7qxp9wUSU3oyQnBYOqhtRn+g0EJHynZDRH1Nyz
         S/5UooOgkTrwlf+qladDnq4qFZFWNgg1EQjAB4mo83HCiFkajAGn9l1REkCYIp3LPg2U
         CVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506552; x=1714111352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot66TNo9jo8sFoPSFYhZLhjDFx9tukqKH85BtSrdHiM=;
        b=w88D70vgzbr8THS64hjRrEjwA4ZT/7P9feqpUA42kTLbmRaSf01o2OiLX/ZK245Wjq
         r7+RgkYn7o4kJZO59PWp9MvzHNNRu7Gm4zohhBePL8AWdPpbA00fEHe6i2EGqVx+booQ
         GU82zoMma74yhv8GI6qKNwFuNrDYCAPSa0BbQ7bnBYUEvgdDd9cif7ByYBiNGKreu6dp
         8fQqJgxIMUaNAw9J3cW+CCKNyI3shmPXZ636ZxNl7lFSTJywl9wd4JNuYZMaONEx8QzE
         K0LXsbu0xr1f4Qs3opEuR1wimqvLE5VlwPASi++34GW07ZZvSXI+I1isFJArMXqcGN2d
         SLlg==
X-Forwarded-Encrypted: i=1; AJvYcCWuZ1HNwjicWVxF8d/TGeMOzJfPO+T8Y4gKC6igPPUvJeOTG9V+wiCHaijRAbagHphIPrdWW8mA10JaiFhQly16mNaGpD3fuwETt959XN7oddePkKmjxUSmN6NPNvMAesuqxMBeRpW5ShtgUHB+mEG+SDmdALLgOuJCN+YbgUuvDCFJ
X-Gm-Message-State: AOJu0YyKzxuSg2ltImULvmHBlo82pnsi48zB+Ec4C2aHAWy2q8vukiwj
	PfvNARD1xvPiklNQ5dTp5H0rE3uJUdLo4xdXK2DnVklRLUfnDl0EAXq0WA==
X-Google-Smtp-Source: AGHT+IFeobqGWq9JLsJsew1uvqbNw3hPrv+xXVWNHCXeyWhe4t+Qyl+RZNNg19AYF2EXBmDuOVeoOQ==
X-Received: by 2002:a05:6a20:dda7:b0:1a7:ae5d:5fb4 with SMTP id kw39-20020a056a20dda700b001a7ae5d5fb4mr1345609pzb.28.1713506552207;
        Thu, 18 Apr 2024 23:02:32 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:fbcc])
        by smtp.gmail.com with ESMTPSA id s73-20020a632c4c000000b005dc26144d96sm2392828pgs.75.2024.04.18.23.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:02:31 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:02:28 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/18] bpf: add support for bpf_wq user type
Message-ID: <mdsuvmekgn5uws6smpgydvqxxryrftvrfzsjo6pq32ku6p46h4@vbja473hk5yq>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-6-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bpf_wq-v1-6-c9e66092f842@kernel.org>

On Tue, Apr 16, 2024 at 04:08:19PM +0200, Benjamin Tissoires wrote:
> Mostly a copy/paste from the bpf_timer API, without the initialization
> and free, as they will be done in a separate patch.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Patches 2-6 look good.

