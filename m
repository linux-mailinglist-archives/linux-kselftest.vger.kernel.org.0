Return-Path: <linux-kselftest+bounces-36737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37414AFC031
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 03:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F163B54B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B01F4169;
	Tue,  8 Jul 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrVPM4bJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D7BE6C;
	Tue,  8 Jul 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939092; cv=none; b=rFpDCq1S1ZGrOf/cb2Q8JQTjsdb8KadWvYcLjO4qQZMvaPqg3X2o1v1vSvN2xtGbjZr2ZL5AGsxwA0S6Wv1hDriojK/OpXTyCCOVybcWxebympptXsEKQoUl4IjGKJX/ISjUREf0TcNENbW1xXDqVc9GaVXoRdJrsHKNRjTegnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939092; c=relaxed/simple;
	bh=6m1lzxS6q2RHVwpfjunpRF/H7GBK31qlq/09C2C2JuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5HgqH2veMCpAewD6jGnV/uC9jH5Am4W09gBCpjW2qMqtD3AFZIUorMrkE/H0ojjdLim7IzVu9cjDfhGiHr+rAA5CfoUgusqR090CSPo/HzqdG45q623N1vQvzKip+ORIqdpXUwG/WpCpv0bztb1OwmtIZcUXGKcDndRzCOodZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrVPM4bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE80C4CEE3;
	Tue,  8 Jul 2025 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751939091;
	bh=6m1lzxS6q2RHVwpfjunpRF/H7GBK31qlq/09C2C2JuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XrVPM4bJNNe419JvqzI7qLZr3/wbwqIF+y8BR4guOS/jTnVYlVlZI96S74q/3MXOs
	 2EVVejkaL3ljsAINLrY2MgCZ/alac+fnzz7e1vvETqdRfquwb+t4xMQW1QgkClGIpn
	 3oBVnGAQciecwyUhkuAiNsvqWIvrGA96tFtrfRhqiztMj143COvUv/pvNXWv6QDWwn
	 7VFLLqe+Bj9X/1aGngKxCmyx0VJr9LM7/bHlhDichAFXjnHGqztM2A9kyMyVYpkgdj
	 vaFDm+HWHIC0wsb7dHHPhXXa0Hl8nkF9Oob8VGlDco65IwKHrwqIRKq0cmQEv12sVe
	 oQAlHI+EQy4nQ==
Date: Mon, 7 Jul 2025 18:44:49 -0700
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
Message-ID: <20250707184449.42736a0a@kernel.org>
In-Reply-To: <IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
	<20250707135507.29cb55be@kernel.org>
	<IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 01:34:13 +0000 Song, Yoong Siang wrote:
> >For normal XDP my understanding is that its the driver's responsibility
> >to move the "reserved" stuff out of place before presenting the frame to
> >program.  
> 
> Is it means that driver needs to move out the "reserved" stuff before XDP program
> and then move back the stuff after XDP program for certain situation, like XDP_PASS?

Why would the driver need to move it back?
On XDP_PASS an skb is constructed, so the metadata should 
be transferred to the skb. There is no need to copy it back
as a prepend.

