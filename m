Return-Path: <linux-kselftest+bounces-21905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BF9C66EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 02:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE72DB2606E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A04C62E;
	Wed, 13 Nov 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kGDRbR/5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWxDIHKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7722081;
	Wed, 13 Nov 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462734; cv=none; b=JAvX0DlKfMPbq9d8Ae69jAKgmgyxTKW5iVoqqiytbN1/a80CtKgyYzc/5m3WueprOBHu3wLYF3BSHZaYdeDa/mXmZFJMepA4bPrjEU6OJcNyjupshubU8S45t2C1J3Z8EoVHw6wEaOVABww6ZAkeuxf3ZHFqmVqdwx2V/udK6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462734; c=relaxed/simple;
	bh=3o1IAk0Pu1DMM+4JmjvQ/Lh83+id96fpgNVzAmCd5iI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bjPWlR7BbFPHoTrNRGEij5Y5k1mG9+5X/VHZ3ZEgyp9L/8Ri8+QjL5VfdopgWxI5+5ibyn0jzfHjgzMWjNYWdAkkekLNhPf+L7b/cFAv6KIuAn6ckbnhjofhfxYA4H+u8MwHvfkT5PufLc9yxU04ffeSI08P5ol5WfPbj/e3bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kGDRbR/5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWxDIHKY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D74F11400EE;
	Tue, 12 Nov 2024 20:52:11 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 20:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731462731;
	 x=1731549131; bh=8/kcwCsb6nVPjwURuXhrNrDPbY+2hNixujv0dk2XUuk=; b=
	kGDRbR/5ubQKcSZKDz/HQMIjG5HkCHlrzuddY1pjTenNipq6A/8y1wcDpHbQTulj
	R/evifz0zmqrztKExrJPabMiEe10oZCkXlObFV17iLC0vWxuMFlOMigbk0TZfT6m
	1RSA1HoDHjR/P3XLpbWPBM/V78LFbdmBDQB2YuBVy1qCtRChsVtbhcBZD5be8U9w
	CQbyYXoA5h4mqcNFx6kootse3whLx/pbRwsLCv2x7x4ucw+upLGsLrx9mQDO/sOZ
	UwTwdjoFK3xgbT7u/6TAyt89SefysXcHrtNGmVBsrjwlkvIBNRW+yKywRzmmoSWI
	AuGBtigrDN0owfiiQwkx2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731462731; x=
	1731549131; bh=8/kcwCsb6nVPjwURuXhrNrDPbY+2hNixujv0dk2XUuk=; b=M
	WxDIHKYOS1P2LW4aarOkEYToYOHdomKqY4npqtSaNZuLtzn2lZwHPcR1j4D1mo6B
	beTcz3vdfWUCdselYDU79HmJBIs/zFSc1D83uiKn8qLj0/E1GFeULJ+RlaztkKsz
	NYMGJ/JOLo9pkM5QvbgKjVFChlHGr4T7kHgMCn2EcIi3YJ3jiuRpW2rdGmOAmqxr
	phn/SeHPNq7Q9EPTjJSKHkpodLFyMS68ZBKfbJDFMw1dKl22PsxwmQvOpAnwlipZ
	0Gi+I1xxjhW6CHZLeMVYGcLThrB+BobsO/Op9GlKPw1soJn88n9cQMSbyJmGnxoe
	ZDtw1P4jsBA9Oi9LMdEEg==
X-ME-Sender: <xms:SgY0Zxll0Cse2x-mQtHnDdCaS91651rxYCcuLKg6XXfVOLJ8fUPfmA>
    <xme:SgY0Z82dkQtOrGpnLGPcaWdY7aHB3bLEr7RNo5gvBq_ZHSNJcGePhBKhNudhB4IkD
    gffy3PTT-j__vURcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvg
    hlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrtghh
    vggssghisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtohepvggtrhgvvgdrgihilhhinhigsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvg
    hvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:SwY0Z3q2IvcM6mwyf2mM_tTQImDSUDZY9uhctecPeiaVXv5hMwkubQ>
    <xmx:SwY0Zxm6FLNx7DhLs8KYlF3oqPU3ZKkSRV_ueZhiA9H4y1zlXuuE8w>
    <xmx:SwY0Z_12VVhoWKVgJlHu6ti9h65rFcMEqB_7TKlreRx3WaWoNRLxnA>
    <xmx:SwY0ZwuUbf3rrn3mSyu_KwrkW6ghpNoFEr_786bsJyeRKzzB1J-LWQ>
    <xmx:SwY0Z23eZtYs0DgoZ1wOs0X_GFCq9fXd0--EvlharEoRXeMxQ1xnMYMC>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDFBE18A0068; Tue, 12 Nov 2024 20:52:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 17:51:50 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Edward Cree" <ecree.xilinx@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "David Miller" <davem@davemloft.net>,
 "Shuah Khan" <shuah@kernel.org>, andrew+netdev@lunn.ch,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Michael Chan" <michael.chan@broadcom.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Pavan Chebbi" <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kernel Team" <kernel-team@meta.com>
Message-Id: <d5b21f01-0f19-4580-bb7a-829d46ee7dcb@app.fastmail.com>
In-Reply-To: <93831343-03c3-d540-369d-fe82eb480c58@gmail.com>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
 <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
 <93831343-03c3-d540-369d-fe82eb480c58@gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rule
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ed,

On Tue, Nov 12, 2024, at 3:10 AM, Edward Cree wrote:
> On 12/11/2024 02:23, Daniel Xu wrote:
>> Extend the rss_ctx test suite to test that an ntuple action that
>> redirects to an RSS context contains that information in `ethtool -n`.
>> Otherwise the output from ethtool is highly deceiving. This test helps
>> ensure drivers are compliant with the API.
>> 
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ...
>> +def _ntuple_rule_check(cfg, rule_id, ctx_id):
>> +    """Check that ntuple rule references RSS context ID"""
>> +    text = ethtool(f"-n {cfg.ifname} rule {rule_id}").stdout
>> +    pattern = f"RSS Context ID: {ctx_id}"
>> +    ksft_true(re.search(pattern, text, re.IGNORECASE),
>
> This won't match the output from your ethtool patch, because that
>  removes the colon.  Probably want to wait until the patch is
>  finalised and then write a regex that matches both versions.

Argh, I meant to have wildcards here. But yeah, makes sense, will wait
until the other patch is finalized.

Thanks,
Daniel 

