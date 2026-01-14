Return-Path: <linux-kselftest+bounces-48932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B6D1EC99
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 13:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4FAF305E424
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52302399A6D;
	Wed, 14 Jan 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZzxO7pL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F358399A69;
	Wed, 14 Jan 2026 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393743; cv=none; b=ZGNPmzNjKIdMmsYGmndnhi6mi0/13JFDzW6zDkroF6UH6wO8by1U8xlR0AOCTRk3rqbZaY05a8+K+S1FrTJrWuXU3oH7T0A6wvlH5cVrdEgtBfSpl+MN62JfTw5XQ6ASuQgnhwLmXMU9HeXhx4DouMGPxI+Sp1KW6tJNXueAZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393743; c=relaxed/simple;
	bh=2LVUPJAyVyauvFS49vi97xmP0WMroGHn6IQqudEGN2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IntxL8C8d8tfKG4jgFA6sBtq69qpxZu7wmwUe+PRzG7JmJvU7eX5Qva35dQte/rzuBtxdjQ3qjC37cTi+LZkA3moCXhrIODw0Dnek6rZJ4IWcXwX/KzKQ4Ax/htaVELND1cE0NPFlG+9dTwT+hPDPoPYDBxbl3kAsNvUlR8gzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZzxO7pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB30C4CEF7;
	Wed, 14 Jan 2026 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768393742;
	bh=2LVUPJAyVyauvFS49vi97xmP0WMroGHn6IQqudEGN2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UZzxO7pL24lBvpdl1yW2iNKJHrmOL9xko6kMOCad3v9j6YfEYsgb2G8yIz5wt0iaw
	 gnNNyD1rs+q/oqGcWDu9ny+k4UCf/+zmgwv5OL6s5LnzPnWVcgkJ2L9aNoiEA+XdL2
	 G7NsXm0gSwM2wclNrL5RQSLnVVyBNjsf9KkFO26wAJISZH0AfllbWlYVsFtNyBqyJ0
	 gOhG0ynHhGM9mSgO+ci43Yc7zOWpRaVylc14J5VBTXkTjuCHZsWoyigx5cZiUCsgO7
	 oKZuKbdJC3Dwc2rBIiQCWC7S7JjQZTNmGRiGTGbWmcwH85AKARtM2Sg3t2b/h2OYnN
	 MH0+g17HO78Ew==
Message-ID: <3bc63f36-a732-43d8-8f65-43d532adcd68@kernel.org>
Date: Wed, 14 Jan 2026 13:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] powerpc64/bpf: Support tailcalls with subprogs &
 BPF exceptions
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260114114450.30405-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> This patch series enables support for two BPF JIT features
> on powerpc64. The first three patches target support for
> tail calls with subprogram combinations. The first patch
> supports realignment of tail_call_cnt offset in stack frame.
> Implementation details are provided in the commit messages.

Did you consider doing it also for powerpc32 ?

Christophe


