Return-Path: <linux-kselftest+bounces-29106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056DA61FF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0033BAF38
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265391ACEA5;
	Fri, 14 Mar 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="bnRCVJJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94E262BE;
	Fri, 14 Mar 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990367; cv=none; b=YJF2iQUfEwtSaVEiEQyHVNP1DuUh7M3qhDO6UGMcVjnnlMD9Z/WMgMRPGdTl0uqR9iTAvN3hSIH4X8xApiGcP/cf3F/j5L9dMtIioLbMoqERVNHFh89Za2lq2HhV30rFt1bFyrYGgi4OUoPWn7ydG5lZhk9WjSb+DJdaQ33zo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990367; c=relaxed/simple;
	bh=/qa9kng7AEMh41uBI0t8y0IwvHlZ8twjI0KXzYEPMXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spoizmVVeWyMhyFVfy4DdggNMgC5fSeCDw5xkuC4jX5d8CCyQD0Vp7Ec6+tb7QUoClIZg+hEgd0AbQ2PQ8OtWb0j1K2AusSphD1Tcak98gzVdvvxn50C+MLz/1IE45MG0aTV0+QsK9Gp5mqe6F5xjH8v6QK9h8dWfBZo1VQ+5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=bnRCVJJ5; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ntFKTtOQJdL6wYgl+WU5UTRlb+59U34o/MnPIn+k7dg=; b=bnRCVJJ5ErzAY6MIfV6eJ0sZhe
	CDgkdgzH5W1X5KTOFrUbaHgu57lZq3S2Hsci5pE8fGGk2+emJkbn7rXqqkjMN1DsUJVaAnx4JPnB3
	uYOp7fcUW2jIRasmSK3wpn5GYbOB/tMwit5Y0eQsNRM4sK+2rrzH3Es409bC2BFKV78w9SBnTWbae
	tCvPmJzE67L6H4e7lNWjD8OH57RN8FsJVyO9mCE4UNVL2E2d8y57sQIHb+RE2VtWN09Rmi3XO3WBs
	M5ZLv7MZ5hg1jNe8OVPT3N5RLYuG8dFjLWNSNX3tJgOxDjx8am4Gq2o5/VAa4nt1QWNv+1awLt5J/
	CKe5PRsw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttDGm-00EMt7-13;
	Fri, 14 Mar 2025 17:12:44 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: shuah@kernel.org, Su Hui <suhui@nfschina.com>
Cc: Su Hui <suhui@nfschina.com>, wine-devel@winehq.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests: ntsync: update config
Date: Fri, 14 Mar 2025 17:12:44 -0500
Message-ID: <2267427.72vocr9iq0@camazotz>
In-Reply-To: <20250314071454.201697-4-suhui@nfschina.com>
References: <20250314071454.201697-4-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 02:14:53 CDT Su Hui wrote:
> ntsync should be tested when CONFIG_NTSYNC is setting rather than
> CONFIG_WINESYNC, correct this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  tools/testing/selftests/drivers/ntsync/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/config b/tools/testing/selftests/drivers/ntsync/config
> index 60539c826d06..0aa68de147af 100644
> --- a/tools/testing/selftests/drivers/ntsync/config
> +++ b/tools/testing/selftests/drivers/ntsync/config
> @@ -1 +1 @@
> -CONFIG_WINESYNC=y
> +CONFIG_NTSYNC=y
> 

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>



