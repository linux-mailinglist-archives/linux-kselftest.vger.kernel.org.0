Return-Path: <linux-kselftest+bounces-22965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C79E8937
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 03:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB09618858B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245E3B1A2;
	Mon,  9 Dec 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hoj7BbLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406ADBA45
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711793; cv=none; b=lQWT5wAOZ5h39B/kxmclLOlDxoWz7lhenaKh+HLy7K3Q15Vv1rvLWVwN21GUgpZduN3tShnGGAEHvGPVfWMF/NrpPVH5akjbiC+XYvAtOjNQYBG7aNxTizpvjoj42JUWQm1IZ0Q/D8R62AxiovGIEuqO/TZEohyaiiFd/8WpfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711793; c=relaxed/simple;
	bh=o7FK+R1gnRcCOcM6Sarix0luaZ/u4v+GNEDWfYm6aQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3+hDQeJqhj7eGxufXVn3YUD2gXN6tZXwuh/wiW7wq2xtlifnMpEZ+HMT9NB/r6S/T0BKwhiZb9Erwnz+YDe9kIVSPN5NWBdeeUuA9fVxcMSTmmzQMyjxJzQrC7UzPYz+1k5xq+IAXkgeEHmQx+4+0LPsWq45zDmxSyWv2bxz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hoj7BbLJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Dec 2024 10:36:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733711787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kryJqFxtrrNAxE6BrcpWCi/Xgt3e9a2effKog6upGFM=;
	b=hoj7BbLJn+rDAX8ggfTgaBz1Kenqd/iUNxksJMftPBhKw+x5zfUeUVXNHZ/u7ei1d9FA2L
	4iuIjGatbJ7lNmwS+sbbdDN8Y8MoRRXNtI9t6yrjPFJWAGBRUEUmroVL6JtrfC2kNMLTs5
	tJnLLhA/ZmYd0v1AdtQlFNW/yR0oQFM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Guo <dongtai.guo@linux.dev>
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 joe.lawrence@redhat.com, shuah@kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace
 hardcoded module name with variable in test-callbacks.sh
Message-ID: <20241209103615.00006171@linux.dev>
In-Reply-To: <Z0XKpjs53Da5nEvU@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
	<20241125112812.281018-2-dongtai.guo@linux.dev>
	<Z0XKpjs53Da5nEvU@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On Tue, 26 Nov 2024 14:18:30 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2024-11-25 19:28:12, George Guo wrote:
> > From: George Guo <guodongtai@kylinos.cn>
> > 
> > Replaced the hardcoded module name test_klp_callbacks_demo in the
> > pre_patch_callback log message with the variable $MOD_LIVEPATCH.
> > 
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>  
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Hi petr,

This patch could be merged?

Thanks!

