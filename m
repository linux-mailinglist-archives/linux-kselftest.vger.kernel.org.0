Return-Path: <linux-kselftest+bounces-23472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC009F5C79
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 02:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8792E168880
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE843D3B3;
	Wed, 18 Dec 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="W4cmdXhX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSnhheK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC135976;
	Wed, 18 Dec 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487054; cv=none; b=TgAKcX/auKJXqp1aAQx4VwenvC6nq39Q18JL3aRWNu9Flae0DkWhNaR/edCyZrKYhubOFc6SwugKqwHN99e5mYbZsiTFeWA8Xj16dAjXQVpt6chzCMNv6kwxfV0VQvgwaR0P8wavxvKOuz9Qkh/L5/jS3MeimShSXQoLEjslnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487054; c=relaxed/simple;
	bh=MhSVQktSGMzTb5L6MjUUqtY488RIB08Q7uVTet8ehCc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l/MsOLoZoNo/z0zlRSAo1dcLM60NuDgqj8Y75ld+hC/PPqZkzrw7DCPk1HjeAKZ+gOu9hh4kscsMdJdZ+OykQuHAQa/SB/dyodWvzVJ9TB7rsxuy9W0QIUWdK41cu6//OEx30RGpw8IsDBxtRLOAoo+9WA8y6CBuXymUh8OE63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=W4cmdXhX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSnhheK5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00DB52540100;
	Tue, 17 Dec 2024 20:57:30 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 20:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734487050;
	 x=1734573450; bh=MEVef3/GOt8gjtJ7/I60KXZ8vA3mo9L6N5uBnZHDFcU=; b=
	W4cmdXhXvMYawmHRVzFXelUIcZGgmtRuIw66qK/bcXBqo6mbM/YMMn+ug1g0U3of
	2qpJAVfsMxlHU9Tv7hqHE6F8Gz5bTTWanP5v80qVAeBYtlIahsVmMLwk9Y8WmBvg
	db4VujHE27xLsp+DEfSsxqATaPLBhVNLjAGBTPxcf5NmijbmuC4vjSjZW9bRm4Iw
	xQ1AGCU8VKn084B4RGoWM3T3AFoQARFnJYCAFhoDUsgiJOCpqLCUU+zPHima9xwJ
	ZY+QbcO400k0COi7YSGkC4qS9zSbyPAjewnrMprQdhpDyNFA2P5AMVKBguFqF2fH
	BVJhmpCvDaNfbWqX5+hsEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734487050; x=
	1734573450; bh=MEVef3/GOt8gjtJ7/I60KXZ8vA3mo9L6N5uBnZHDFcU=; b=e
	SnhheK5MuRaufFk28UTVkazRcLl0uAYhdqVNMnNGkKym2zNtuivuPisxGPUa0Uly
	8KFTFUqx/5kfIYlsT/84P/rZATgV1eLJdVNI6r0kLc4k97IPck48FsCoPR4YssD2
	JZ/xDSiloWSZAlpxT6skdoymkzy8zgqfBwJIylzRbNtkOtMRQbdnimpXhpMgo76R
	fZC2CbyE4jI9X06a/DArvG5zUsHtF9TJuGSnCX2pWYxjzo180p5xawQWulNIwW9y
	VIQQqZAfWGT4/RUEXYThibtIJKk3TbytIO2y+KiN0eCMOrKfzwn9guDE8AwUWjWV
	W10ezPD+WWx17t11UsRdA==
X-ME-Sender: <xms:CixiZ5cM6BKfitxNJmv0nxwaEDHHmCMYP_Cbw0ww-yChOXJuIFrS7Q>
    <xme:CixiZ3MiR11LFlTK_pBHhUaTAa6Wdkuk0LCA5ECRmgiXPXhiJkk4aGUe2Ho36m0-v
    ceEtkm3yxjDaUaDkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeigdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmhihkohhlrg
    hlsehfsgdrtghomhdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehhrgholhhuohesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    shhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:CixiZyhVoRPbpk06AtNHJdaLrcYWjFLmkRD8uIPyLXAaTFt0ovn0CQ>
    <xmx:CixiZy-e9sNZMAESY6RYCE_SChLsPkRFukI9YWfJ8GLTHZ9v13wQ_A>
    <xmx:CixiZ1tYt9NYOmuQcnBdlcWcHOpy5W1XYxuX8lmGb3-I_MCxTQl06A>
    <xmx:CixiZxH9PL0FUoqbgh6kWkwl06avpvnT4Jft0QQjKq5vUt_K7jYvrA>
    <xmx:CixiZ5SoQ1oWpxGhvJw9KuByauSW2hFjuE23hotv0Q5m3vap0C6maBin>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3DC7618A006F; Tue, 17 Dec 2024 20:57:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Dec 2024 17:57:10 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Eduard Zingerman" <eddyz87@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
Cc: "Mykola Lysenko" <mykolal@fb.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Message-Id: <d05e9e36-36e4-456f-9c4a-2476be13a7f7@app.fastmail.com>
In-Reply-To: <00d01559793cb22a323ff8e800e1ed6e79163e57.camel@gmail.com>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <c97b9ffd2042790ae6eb55ba01eae94282014006.1734045451.git.dxu@dxuuu.xyz>
 <00d01559793cb22a323ff8e800e1ed6e79163e57.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] bpf: selftests: verifier: Add nullness elision
 tests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, Dec 13, 2024, at 10:17 PM, Eduard Zingerman wrote:
> On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:
>> Test that nullness elision works for common use cases. For example, we
>> want to check that both full and subreg stack slots are recognized. As
>> well as when there's both const and non-const values of R2 leading up to
>> a lookup. And obviously some bound checks.
>> 
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>
> Daniel,
>
> since there would be a respin of this patch-set,
> maybe consider using plain C for some of the tests?

Yeah, makes sense. Will do for v6.

Thanks,
Daniel

