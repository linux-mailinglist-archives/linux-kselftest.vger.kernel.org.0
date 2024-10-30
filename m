Return-Path: <linux-kselftest+bounces-21093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8259B62D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0D285396
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080811E7C37;
	Wed, 30 Oct 2024 12:18:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E51DD53C;
	Wed, 30 Oct 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290714; cv=none; b=LSS3ZLSkIQ8i/symH2Wwa/wgcJxiD8ct39CnNZp0/oDoRf6NV9qSKpteBK2tfVjMCVNRA+TDdm/aGAwyT0YK/z2PHY+BYFNSBhU2jJTvXisZvT6fL8rWYTi9QRAi+DMqoLTB9lrcSN7puMXZML16D2D6/gMLMFvbijnEtlrJnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290714; c=relaxed/simple;
	bh=co4bBOD3rhpGQ8LE+NofDGBnW0OmztRaoBrPLAy6KpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUtQ4GLVhI/rLuTQdyciMM8IYGbCdNR1RlDMHocRKh5o77PBOxA7JE63s1Wf6pqB7lFJqGqomIMwpt07q92Rx+8013g9Vita5ryAwZ14EzN33PdGEn7d8sRe+Wz+yBXr9J3jKVSKruhlZs+hwODrAVxvY2Ij3llNlm7EMDxkGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=51632 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1t67ed-00BCGI-Nj; Wed, 30 Oct 2024 13:18:29 +0100
Date: Wed, 30 Oct 2024 13:18:27 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: remove unused parameter
Message-ID: <ZyIkE658ekdhFexM@calendula>
References: <20241021080447.2918-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021080447.2918-1-liujing@cmss.chinamobile.com>
X-Spam-Score: -1.9 (-)

Applied to nf.git, thanks

