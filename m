Return-Path: <linux-kselftest+bounces-21420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165D9BC1B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F682826BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD11FE0FE;
	Mon,  4 Nov 2024 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RB0N9pDj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8B18C015
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764519; cv=none; b=X1oDydcuRC62zjzF/A20I7T1kJMJ5wp36ynnivFnV1va7pEM9U1CdmDVcLndoVT8dXuxXyaHo1k+AILAyQu3e6ZjTBqtOXRnHTYDAYi19qkRJRGnWTFEAWiCGXslnzbb9pWp3aGVybp91XMRlfEjREr9cGpAZycNrpbZHK8bLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764519; c=relaxed/simple;
	bh=SQPYkT47hOs+WYldnCS00UuH1aSAzNu3lkFQnfZn8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG2x0COJ7+DU6KB7dJawlF7TuW2QOMwoswuv81z2/d8xr0W4M3HoLKyuMho34TaJCul1MxNtTBS84HiU7awBTbfToT95UAtLRtigri6C6xr78sn/f35ZdWFQ8D6ychcyndra15M0H54nqItOkZT3KA+KOkmIDctjncKNQi4pfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RB0N9pDj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbcd71012so55739305ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764516; x=1731369316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdnfp77LKN/DlaR7y6ZRTeOdlisM2V4uYL3wKi+GwVo=;
        b=RB0N9pDjm/yaCKnvJXBe95kJNzLesKiaUOANfhkRCyqegEQxM3Yu4lBaB+we7Jcwx9
         LOhsWfiVmpaUPtsQVcefQAk17czxSzsPHe0bsqAqTlLlDWBouMNX/52k1r4kikQE8Rxj
         mo6gJhyffEOfO/zlB9b6A7GzMvc5RvkkkN/U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764516; x=1731369316;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnfp77LKN/DlaR7y6ZRTeOdlisM2V4uYL3wKi+GwVo=;
        b=FFWK4P8/5BY3UyUkjh71KK4VY7NajbwnIHn/Db5fnK6z4mkNyNmfmNWQsGjrbKaJP8
         jQC2tx8oJug9Y5ck48ZrY/Ya1zeZ9paUt1Gz8xTSAh3Ip3Nbhi4BrBELT/DDLqVxbOol
         4oXOKJhF0yfzhFGGv4mSKwZU4P4eW5QKM0TAZFaYii+JM82kv5UrHzPednFVy1r1Yopy
         /aygD64RXsGemy6Smjg4E2LxKRl08Hvo9yX2I2Ubb0xYG9dml5p4KVdJOylUGd7rXvlg
         AITECHLJ9vZ8dnUflvsLMU7EwuJzVTRTwpie/EgY0FX5sP5lRUVS9xvQByH5WlqJx5lZ
         gzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPlURTgB4yJAT8/Wl5KrLJIUhmLp12t/YX5UFnq/r2LWkkzbAi0jXo15Zm9k9gb+8u8icUIwIqGED6Kc6ma8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01zwLKjr8meHa0cl8Z1J7cELa80lYh/hRqkHWk70488gQteqU
	LC4IBuWTwe7wUrayjXHZjVyvvEVFF+A9Oc3hlfGz71XUUS9jxRmPtLbmKu+5DY0=
X-Google-Smtp-Source: AGHT+IFFicJJsCVy+lROsW0Upk7xis+4h5Hml5B/geSkDDTcfqZIgZUyHs5LYZCG12/IYRuFTY4ZUA==
X-Received: by 2002:a17:902:e552:b0:20c:5c37:e2c6 with SMTP id d9443c01a7336-2111aec87d9mr179112995ad.11.1730764516098;
        Mon, 04 Nov 2024 15:55:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edbf6sm66708225ad.43.2024.11.04.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:55:15 -0800 (PST)
Date: Mon, 4 Nov 2024 15:55:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to AF_INET6
Message-ID: <Zyle4LszJdMOudRP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-7-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:24AM -0800, Stanislav Fomichev wrote:
> Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
> can be used to do v4.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 99 ++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 28 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

