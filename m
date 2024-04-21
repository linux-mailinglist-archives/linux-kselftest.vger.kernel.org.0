Return-Path: <linux-kselftest+bounces-8585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBA8AC0F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFD7280E9C
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B723F9E0;
	Sun, 21 Apr 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujrey7p4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8038DE4;
	Sun, 21 Apr 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727946; cv=none; b=RV2FELdpuAUK423g7O35wRQnixETBoghAdNrMupEquWhysFO1nbVuETGVzoRCpfV/6a0s3e4W60DB5B5ViBQcgFXBZy0/dVBeOFqPYMjettBl5hk+o/EKUJNS0OA6dLbxvo5NYXdDj0y5SrR287aJGaoo4np86HKJNxLmJYG78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727946; c=relaxed/simple;
	bh=krzLUqQecTEOyEkxjGz9LNCmtO1Aojsnd+iPOcKj2Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWg7dvahacp1IFRuoqVrqceo4FXrUkIBD0+9eDj5pDWAbFYAoV+Rpuonggc7bUDnmGatfRDLPy/soVcaO7hDn9P4nPNIVCR/YVKV9oyfcY408VlJTGe8I66TiTUmR7tJ4w/ASpJWqzIIYtvCxyufLm1UENBmTsureZ0qTErSZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujrey7p4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0CC113CE;
	Sun, 21 Apr 2024 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713727946;
	bh=krzLUqQecTEOyEkxjGz9LNCmtO1Aojsnd+iPOcKj2Xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ujrey7p4cKI0TA20IPGzBsX9trA7Vv5V2GStf4aHiOZgmBIJkHq5mSnHMgxQ/inVq
	 h2khcbKQvtsnbAp4DlqZFSqEnBZz6LVcEXkMCaBf/r+vLOPtTgQEawdLmvIBrGGIO7
	 XoO4ePPE+9nIJn+G+8rF8WRXe1/p8+Mx5PtPbSCJ2SsU2P5FHsDrjN0JmX2F7GxhOO
	 1oTtmRcNIznI81VW+e1DBs/4AbhrbDNGc/w/3ATyoJi1o257PhlFwu/dg5OFK/O+BQ
	 6TFj/M5R+vaB7p9y8zLL1gedVJhanbke0NEdwFkz/YKS2fxoNZW0HnmPAgeN4yUPi7
	 t5M+sBEA0UuXA==
Message-ID: <a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org>
Date: Sun, 21 Apr 2024 13:32:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in
 qstats
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com,
 linux-kselftest@vger.kernel.org
References: <20240420023543.3300306-1-kuba@kernel.org>
 <20240420023543.3300306-2-kuba@kernel.org>
 <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/24 1:17 PM, Eric Dumazet wrote:
> I wonder if NLM_F_DUMP_FILTERED should not be reported to user space ?

good point. We do set that flag for other dumps when a filter has been
used to limit data returned.

