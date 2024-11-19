Return-Path: <linux-kselftest+bounces-22268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9E9D250E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BB31F25544
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3A91CACD9;
	Tue, 19 Nov 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP0YiKqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE1C8773
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016469; cv=none; b=JahQcjs/id6cEO7qSvL8N/LMCNQp9gvsYUz4Bx17wvk26TOqA+nDfwQyrNjxwCFCl5RnQLkN7Ngqw8reMXKCCue3Z7ZLlLj0bMx5wqCXzqUUB7dcmQXMFaI2c7/5+HPkWeEHX4o3nwfj5qIRtbDBUO1tcgEen2RVi/D+WWsqEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016469; c=relaxed/simple;
	bh=B6tGFGc/acnVM3Qye2kgK47gJP4agRKP+KzyCFDdH6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9cC3HmqVP59zoNbytlByk8WQPueQCB4fQ81p5E8ocbIlFQwS82Dbo8Rc0uvYsfJKYe2iFoLvIbByuBkeB9zhiQTDOBWuteFk5XJ/m7iGgyHrDGc8e0lRE90lK1/+Qm0YcZfoOsxxJXDmzdaL6q0YOJTavRO3M/JYJkYUSUkePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP0YiKqT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732016466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
	b=DP0YiKqT9vOn2Ki/CuDdBcI4vNLQlYyC0HhEchXXBRlcCPRqFXY902rOpQo5uhSt38PBkI
	fplbK59WdPawl/nCv63BVYWc8W+jV39WYO61MzoAovthhO7TnRzzfIy9BFj83Ufhpl5SM0
	SUPTZ8V2mcJXcihng9jAwRdCsRuj8GM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-BwJzkUqEMJOwDBXtkOFb3A-1; Tue, 19 Nov 2024 06:41:05 -0500
X-MC-Unique: BwJzkUqEMJOwDBXtkOFb3A-1
X-Mimecast-MFC-AGG-ID: BwJzkUqEMJOwDBXtkOFb3A
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d41f4c5866so11402786d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016464; x=1732621264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
        b=tTEIW8DMQPTNcoQ9eHb7lAk1O7rvHec8m9/N0Z3CPW3mtppt+3Zln7ZgFt3W0ndtqs
         i0s5t1/gawczOWi2ki2EKn9cQ0U85pM8peS+HaHm4a+Y71RV8mocgvvZMtS74w499aRC
         quDHDeDvyOB/YOLCjEJNLXw9RKKCbYGaB1TEdRsEKeRTUoDoQMRqo4eVYwIdl/KWdMvB
         JcdS86MvvK++/LgbXdYP91anQQ7oiAMJbWVJDOrYyTbm66cdgwdOBZjdn5nvyuDtrYD3
         OjjAAQSCF79himR1KfRQH4C5aZcVCDga4Kyeo6e66U2Pp3aCnMBZxRRzxJkSE28hLTtO
         gwHw==
X-Forwarded-Encrypted: i=1; AJvYcCW9uUPuub00nSQSfrSL0lHvKk6iRrbLaDwmbgyUEngQqFmnPD8Pfcth5kaSeBgXPQKtqoSMOK+UGoXHDmwSs1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWpluBcQghrG7StOa/7i5G3FEb6Y3Bx4eyLtf8to88BGOUnvU
	b36jIQharJpnhwoYWp/sDIjHdxFE4J9gl9ipIyTi21HLKB8wsPMxxGbOxsqjLL9l1VL1v1NUn/l
	I8y7/fJT2WEz6oTc33lJKMm48ZilPBm2HPg+SG+t0D54lERSAEpcTVvo+4kxlosvQXA==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732306d6.42.1732016464387;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSL+CvUXEPORupLRfcZC0IPSOYYNVWZYJtS4mmscYBrBcgg3M5ByxsUOZ5P6MeA/A9Dqar/A==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732066d6.42.1732016464058;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc7ada9sm47266936d6.69.2024.11.19.03.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:41:03 -0800 (PST)
Message-ID: <06940878-8a7c-441c-958b-7cd7e7408beb@redhat.com>
Date: Tue, 19 Nov 2024 12:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] mm: page_frag: fix a compile error when
 kernel is not compiled
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Linux-MM <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 04:30, Yunsheng Lin wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
> 
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Alexander Duyck <alexanderduyck@fb.com>
> CC: Linux-MM <linux-mm@kvack.org>
> Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
> Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Mark Brown <broonie@kernel.org>

I'm closing the net-next PR right now, and we must either apply this
patch even on short notice or reverting the blamed series.

As this fix should not cause any more conflict than the original series,
looks reasonable to me and has been tested by Mark, I'm going to apply it.

/P


