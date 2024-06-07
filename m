Return-Path: <linux-kselftest+bounces-11343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CB8FFE26
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548061F212FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F3815B115;
	Fri,  7 Jun 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="eWbpZLV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBnpFRu+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAA15443A;
	Fri,  7 Jun 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749523; cv=none; b=b29vmt4L5gsrkiPO+4qd9LknjNkmGgCDTXBSBkqZldx7uOmhP0pPTgMW8fxkp++eHOFuBoePbwtILZH7u1BimdSHKO9dIKPMr3nwjjj1ESgavpiE6wzedF+Khqxdn+CBti2cboTJ0fXmQfjlEdjlecEqO+FwScxJoHtqnCqaGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749523; c=relaxed/simple;
	bh=pm63gUhDzxzIyHRn1R0ROHMn5/pMUkbkCFlsiwV774c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=X3Fc2r6bhF9/uyinKkFmyWhNxjSHXqD7q+ER7V82nEKYlCXEvQOr6XISh1YclWSEEVHyrCVBSVJP7/cnCPD9SQKvrMLTjD8jNGauy0vU1ybgkraPegGTWQPeqiIhKMUMaxSzako/Oq2AEv1wD3yQ3BqcL5T8lSnrrffr4Ve8u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=eWbpZLV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBnpFRu+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 05E3313801CE;
	Fri,  7 Jun 2024 04:38:39 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717749519; x=1717835919; bh=lUYVYpbofo
	M+ovYwmbpHaBkHewk/bAEUDSaoJenkC3c=; b=eWbpZLV3ZB2DziJnbmicxBo1Fn
	JZrGpgbnIrtm6knLo/2K95aw7sfWvJvQgGP+iaSQEBvunGNlUFid+x/+XC27eBw7
	KVzBHwzmpl6Re+pC12mGEHfHV67fgQdMI6xpWsy6uTafJMCUdFqdkpoj/Z7vZTnO
	n69ztEXXTflrkhtm1rCxG68hoZn7n8hD/lRpfarPR6yrp5GQEKFIL8STPXfZAxqq
	dwvrWHBVzqo6NmAXKcPjcmk3DwvG2ZSdpyrtS1tWW63QSZDvd4B8F6Ez2cFQNYDt
	Pa/iSjsFkBM3+Zk0PAuqQatt3WyHDgiQuz1OfiSSIsmEuDdTN3F0oeNtJRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717749519; x=1717835919; bh=lUYVYpbofoM+ovYwmbpHaBkHewk/
	bAEUDSaoJenkC3c=; b=RBnpFRu+ihHlemOYuCsaIVAoRXtslx3w/Xv1Rb2b7ygk
	H9noCMD/IPpKWYSDaIhpMuvHqvXJp54Ej150F2uduU9nojT+PevNV2Mo23cL55y3
	Ww+1AUwe76f9uTAqrQMRJJxkN+zg4NaGKogzON8FdP+O9RAfPJ/t4BeKH2t70+Xo
	x54OKvvLkz4MJwBOpeGlxsolf5TV5zDys8ln431v6DL04fXExbhlg9ysIOvozdTe
	wv+ZV8App3v+1GHxNHIUmRUKPrYnXc3CBx4cAfmNoOkiwOsCL8CIPE8FMhCrV6BT
	LoRqJ0NWSVBu/AnssZTDgmD53mTs7P0bKfK2OD7Blw==
X-ME-Sender: <xms:DsdiZttVXFoTlZ1nHJQgxM_ICRg4jQg3mZ_gKeVCUsEwn3-UwGN1vg>
    <xme:DsdiZmdsTcbEtxZblPCm7afmIsGyOC_WkocogOU-bOz3gbpxVIwTBVMdXlFxTKDNZ
    xtug58PWY7RsdldOm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedttddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgr
    vhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvggruggrhhgvrggurdgvuh
    eqnecuggftrfgrthhtvghrnhepfeelgeeuheeihfeuleefleehtdektdeihffguddvheef
    iefhveelhedvvdfhueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:DsdiZgwKsDbh1x8XK_0B9u2LyfVh-T6P3WAIZtEIYkN0mmMpshSDWw>
    <xmx:DsdiZkN77mGDL2DIj9qHkdEwcTr37Q9AptUhbQ-xxwnZy4mvKj2F6A>
    <xmx:DsdiZt9xUO3DWVzIvoBCKMZS2tnsmKkF1cdik9fQrdDpzEIkjPQXOg>
    <xmx:DsdiZkVyCS55Jdpvfx1uw47BW59mcwWpW8npNymmU5mrf5yu0QcWog>
    <xmx:DsdiZrdOOXrgHKBmqjQaS0rZJJ5WtZ_s85SteCwhdQOcSNX4k4zkAsg0>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30DF01700093; Fri,  7 Jun 2024 04:38:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e1edbdc-f91f-4106-baa6-b765b78e6abc@app.fastmail.com>
In-Reply-To: 
 <CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=uO9OewMhGfhGCY66Hbw@mail.gmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
 <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
 <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
 <f880562e-9521-4270-82e2-c6fb14dc853a@app.fastmail.com>
 <CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=uO9OewMhGfhGCY66Hbw@mail.gmail.com>
Date: Fri, 07 Jun 2024 10:38:16 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Jeff Xu" <jeffxu@google.com>, "Jeff Xu" <jeffxu@chromium.org>
Cc: "Aleksa Sarai" <cyphar@cyphar.com>,
 =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dmitry.torokhov@gmail.com, "Daniel Verkamp" <dverkamp@chromium.org>,
 hughd@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Content-Type: text/plain

Hi

On Tue, May 28, 2024, at 7:13 PM, Jeff Xu wrote:
>> > Another solution is to change memfd to be by-default sealable,
>> > although that will be an api change, but what side effect  will it be
>> > ?
>> > If we are worried about the memfd being sealed by an attacker, the
>> > malicious code could also overwrite the content since memfd is not
>> > sealed.
>>
>> You cannot change the default-seals retrospectively. There are existing shmem-users that share file-descriptors and *expect* the other party to be able to override data, but do *not* expect the other party to be able to apply seals. Note that these models explicitly *want* shared, writable access to the buffer (e.g., render-client shares a buffer with the display server for scanout), so just because you can *write* to a shmem-file does not mean that sharing is unsafe (e.g., using SIGBUS+mmap can safely deal with page-faults).
>>
> If the other party is controlled by an attacker, the attacker can
> write garbage to the shm-file/memfd, that is already the end of the
> game, at that point, sealing is no longer a concern, right?

No. If a graphics client shares a buffer with a graphics server, the client is free to write garbage into the buffer. This is not unsafe. The graphics server will display whatever the client writes into the buffer. This is completely safe, without sealing and with a writable buffer.

> If the threat-model is preventing attacker on the other side to write
> the garbage data, then F_SEAL_WRITE|F_SEAL_SHRINK|F_SEAL_GROW can be
> applied, in that case, default-sealable seems preferable because of
> less code change.

Again, the threat-model is *NOT* concerned with writes.

Graphics clients/servers are a good example where *ANY* data is valid and can be processed by the privileged server. Hence, *ANY* writes are allowed and safe. No need for any seals. Those setups existed way before `memfd_create` was added (including seals).

However, when windows are resized, graphic buffers need to be resized as well. In those setups, the graphics server might call `ftruncate(2)`. If you suddenly make shmem-files sealable by default, a client can set `F_SEAL_SHRINK/GROW` and the privileged graphics server will get an error from `ftruncate(2)`, which it might not be able to handle, as it correctly never expected this to happen.

Thanks
David

