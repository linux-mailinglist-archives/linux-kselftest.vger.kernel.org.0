Return-Path: <linux-kselftest+bounces-36740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA579AFC0B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 04:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC78189085C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21760157A72;
	Tue,  8 Jul 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClKxGCTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DE4A33;
	Tue,  8 Jul 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941075; cv=none; b=V/Lq1TcArwVIBi4UrIL9VMZJ2yW38F0EFcb+UgR2H6IpqLHob+OwxzzgZEtF2md+2Li5NiHEv1tGKh53bw1Ijk62WZZlcxNYkPVF5AT/nS7xPkrAeaJ3uxRGmq828u1qMfluqPfAu9hAV2azGcaSLRdvR6k5PDBn8UEZ+koA2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941075; c=relaxed/simple;
	bh=CRpOrfSwGL9/Z96Cxl6WO3Wqwa/IZSORWC6BncTNWLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZliQqqeU3Dn/ii+e+naHAE9r3cMLm9hDMLGdCT20MV96G5fBBXMBe556W2DTaUfYjxzw4xE27+xVve/Mf3Ghg6fkQJ4QrY6Db4OmXcoLo4sIPeZESqvnWxB6N5qeRbf8cpdB7vCIFWCFGxct0N1EfXSeE0wmv5NPYhxZ4/3GTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClKxGCTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E027C4CEE3;
	Tue,  8 Jul 2025 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941074;
	bh=CRpOrfSwGL9/Z96Cxl6WO3Wqwa/IZSORWC6BncTNWLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ClKxGCTRQ7lrIwmIJldjcqO0LFxXnM+M41V5VV5+C695sMWXCPA5+fxbGz230hwTm
	 OX8dvC0EcDBoWDZ73dhI0BuxJt6YKp+Sbw2sK97BrLrdJXSLhhYfYXkLBd4cLILq3Z
	 TPLudXfnf2zyQICkPlS87UqK4MTwYDAnK/abydWuGdy4CwL4geYX1+6BKWPkEitIhV
	 +NqCk7xVp58FPBk6Yh0WPK8RXx98u7KYtoOWQc32fj1bqb9lVu/m3TnlATGGYBgIlj
	 hlQk672zb4SMRJZmlZNUNz4rnVya93azZB2nWr7s8U/BSoVJQhWodfp7RAwcpsD2OY
	 QjPtzx5hUlo4w==
Date: Mon, 7 Jul 2025 19:17:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata
 Handling
Message-ID: <20250707191742.662aeffb@kernel.org>
In-Reply-To: <IA3PR11MB92545C3B2CD5778EE24244C1D84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
	<20250707135507.29cb55be@kernel.org>
	<IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
	<20250707184449.42736a0a@kernel.org>
	<IA3PR11MB92545C3B2CD5778EE24244C1D84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 02:06:11 +0000 Song, Yoong Siang wrote:
>> Why would the driver need to move it back?
>> On XDP_PASS an skb is constructed, so the metadata should
>> be transferred to the skb. There is no need to copy it back
>> as a prepend.  
> 
> I said so because I thought need to put back the timestamp
> as prepend and then point skb_shared_hwtstamps.netdev_data to it
> to support the ndo_get_tstamp().

No need, the timestamps are set in shared info directly.
There are multiple drivers which use the metadata prepend
method, so I'm pretty sure it should work.

