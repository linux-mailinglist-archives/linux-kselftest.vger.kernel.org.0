Return-Path: <linux-kselftest+bounces-42034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C66AB8E600
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B27C3B8A84
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472E25C6FF;
	Sun, 21 Sep 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b="O+t5Okyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7OYAISj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834D185955;
	Sun, 21 Sep 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488894; cv=none; b=urSu+/rMp7aRjF9TqGY003h7i3p/4EPQRn29GyoL0JO+1VZEi1epFNTmqYxkjEMtPWIPs3MNDbuJ5IejX6NRxxo3i9AXw8IAktm3du2OeIsqIfQoiOIRi498UxtNziBKklfyUy8uphQ+VFBOp+4q1WqW+QSCFoLpNN2ume5goV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488894; c=relaxed/simple;
	bh=qOSGdF6leebqlCaCu8EDW3SnUS0vexy+XgNqzR/Dc08=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nTMVjC4Rnr6PdThqdMkE1sf/4Y8m41/RNFHlgy1dQBr7TnK65ZlSRObPt/nvUqVTs3qmcQnO6kT3B3ga99OHqjNNcIOg7GrYJA+fym09HY6fgYrEYBbbYP26aoHdNR+YMj9lbzeDl1+oa5hz6WUjvntO+20iEfYV13i4SuPxN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net; spf=pass smtp.mailfrom=wolber.net; dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b=O+t5Okyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7OYAISj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolber.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EE8414000D0;
	Sun, 21 Sep 2025 17:08:11 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-02.internal (MEProxy); Sun, 21 Sep 2025 17:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758488891;
	 x=1758575291; bh=qOSGdF6leebqlCaCu8EDW3SnUS0vexy+XgNqzR/Dc08=; b=
	O+t5OkyishpEBU64ngGj2QXgDOaAOBeUbmgWUQMCmKwx1Npjnm180g3HpjbuJz7L
	oOUmtHVzHzvR+TMPdjkII8WZK0ZQfH53fauABngziZI2MhaBq4mIy8qF0p1fQmiD
	zYPYqP/TtXCzh+zkr0U19xV9bU0ytCbarD+/v9sEtxkhmyYY1dGwEGPblxgvkuhl
	pcTacxOMfKnsjkE4MzHvMkKT9QIcdt6P+CL0Z2uzn7e8f1MouVLSEBfDq65mDwYY
	UwGbCOFIb+zEXcQmRct/VdA6NGq+1r/Gwxb83mHEABwi8fEJrOkGZbkSWiNFjTzZ
	WXdwdlD1mjbPjseDQufUQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758488891; x=
	1758575291; bh=qOSGdF6leebqlCaCu8EDW3SnUS0vexy+XgNqzR/Dc08=; b=J
	7OYAISjmKUZ/1/ExByetMJrNDQcvG1dVGu4Ls5/GrGeFO72phduhmnhjT0QErykQ
	ZP3fO6ABW+uWhMvcpoWTwPfm74WObvU9bgLQQ+aim3VpwJsZAIdPtO76zJvtVxuk
	VNl0Wr+8kPCCS0oxGUbOhnBmokETBMSjt6cxJVTxXnZZs4zDGaRmmnFZZ9HgwIny
	ZpQgM9UdgvrAigul3WudCubZMq+ByvronsY7gXO8UlL2kZs2SB4+RfjsagZCset8
	ssKtMikD7Yt++vKJrQVvdAGrtA58wm+PjTQTXbF3n03EdaAvfumBKlTv7EchTlSy
	v5Eav4tf+LjvLjuIfygJg==
X-ME-Sender: <xms:OmnQaCgCwMYVVEs2RoGBfACA1aOmnQMQJAmILe9dRRbiZVr5vrUcIQ>
    <xme:OmnQaDD3hhanCV1noJMk8yjWE95fXSEB5uVNdvfsbs1Ys2RRR7XYbDMunsmLW4iVs
    zEAhvdc9SLDjoWAed0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcuhgholhgsvghrfdcuoegthhhutghkseifohhlsggvrhdrnhgvtheqnecuggftrfgrth
    htvghrnhepgefhieelvdfgvedvfffgudehueeukefgfeefhfeiudejieevheekgffhtddt
    udetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptg
    hhuhgtkhesfiholhgsvghrrdhnvghtpdhnsggprhgtphhtthhopedvkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnrdhkvghllhihsegtrhhofigushhtrh
    hikhgvrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghf
    fhhitghiohhsrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprh
    gtphhtthhopegrmhgvrhihhhhunhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvggu
    ugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhhjrghsohhngi
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgruhhlrdgthhgrihhgnhhonhesghhmrghilhdrtghomhdprh
    gtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:OmnQaGE5h0i6QZg9hxcX-SEfitPDqL5I_2ejrbQuP80ODAf8zwM2jw>
    <xmx:OmnQaIl1OmCwuSDFd94Uvl7vNXRASMJTnG8AL5e8mCZXHDdKx0V9-Q>
    <xmx:OmnQaJB07OP3kO9qObmlNkKBu3KTsOSCWw7EI-qchDkswFz8cMGYNA>
    <xmx:OmnQaHHr4bXuh7fQYtHbKovrDNI14xD7pXyyDFjRY5qTJlN-WTIiUQ>
    <xmx:O2nQaLrNsk7LQNO7Q0QB7jXw20IHlRLcR67HCtWbvzeFkSy3Gjgj8ayd>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 86B6318E0069; Sun, 21 Sep 2025 17:08:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 21:08:09 +0000
Message-Id: <DCYSABMLGCUG.3T4ZQDGWFW6KY@wolber.net>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <haoluo@google.com>, <jolsa@kernel.org>, <eddyz87@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <willemb@google.com>,
 <kerneljasonxing@gmail.com>, <paul.chaignon@gmail.com>,
 <chen.dylane@linux.dev>, <memxor@gmail.com>,
 <martin.kelly@crowdstrike.com>, <ameryhung@gmail.com>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <yikai.lin@vivo.com>
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
From: "Chuck Wolber" <chuck@wolber.net>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Fuyu Zhao" <zhaofuyu@vivo.com>
X-Mailer: aerc 0.21.0
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <20250917153055.6fee814f@gandalf.local.home>
 <e8e8b5e2-35fe-43cc-ba41-c84ccba189f7@vivo.com>
 <20250918112425.23d4d379@gandalf.local.home>
In-Reply-To: <20250918112425.23d4d379@gandalf.local.home>

On Thu Sep 18, 2025 at 3:29 PM UTC, Steven Rostedt wrote:
>
> My entire workflow for what I created in the tracing system was "I have a
> need, I will implement it". The "need" came first. I then wrote code to
> satisfy that need. It should not be the other way around.

Tagging on to this sentiment - the kernel's design is emergent and will alw=
ays
remain so.

Speculative features have a very low probability of reflecting the required
design language. On the other hand, if someone needs a thing, the need will
drive the use of conformal design language.

..Ch:W..


