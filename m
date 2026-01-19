Return-Path: <linux-kselftest+bounces-49377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176CAD3AD6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 882463012AB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC838BF88;
	Mon, 19 Jan 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NwzwIIec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsnbjnY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908C38B9A9;
	Mon, 19 Jan 2026 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834456; cv=none; b=DX2yepT8WM4dTRv08rh8PlNrzgrgXPs9/uSc5eWtNIYfaeyZsvWl07cqejIBJjVLOStoLdrSfxI2YoqoYjxEfQmvD7M33mQLWyUkEZPvanON/AkGcvNsBU4RuiInXHd1UYNA/ZObeH/CHpC6lA11MKQHHJnZuUF+H55jw45LWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834456; c=relaxed/simple;
	bh=llLFA9b2YfIkc29XJEW6fP/+hpmcZIzF0BLQSjAdBbQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XctbkhWI7xhgNCR2BetWGGdef+efqrXe2vck11xNDDGhrGEfx5+H5kiPpAjRpab2aoYofHPevEiPO9dlLnfgj3WkBOq+w5BGoRGYCAeJS/lGm7tl4JtVqmoIPvxwLcjoW84upkwPiBvks/mklDJxBvm2Kjx4M41WoH2FtyruOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NwzwIIec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsnbjnY1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5BE47A00AC;
	Mon, 19 Jan 2026 09:54:13 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 09:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768834453;
	 x=1768920853; bh=llLFA9b2YfIkc29XJEW6fP/+hpmcZIzF0BLQSjAdBbQ=; b=
	NwzwIIecJyBMtAT/kPRu8yqRtgYcn1jOl2cokyNoUPMm8QBLjuZXBJ55S5YVBlnr
	t3aQefxGwa9NEGYffPG1ccCjxgUrphRJL4sRn5fNXqiufosScljHef6BXrQRzocA
	YG2wd/g8732oYQH6KXE8oTa+RfiAjMfZsB6QDblh/gyXAH+iKA28axPjEzQVN2II
	iTV3hrU00hG5i0eaq8twxBiBvkkxzXdgyGDf0q6dcpd4tV5Bae1A4fdze1/pnzFe
	zWmZeEwRQY2WEUdGRREmO8x5vZbKFQFnlmgjVstpyGH2Oi80j9RYcvWT0O4kRI8b
	B8k8iRX68rRVOhsZNe+ITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768834453; x=
	1768920853; bh=llLFA9b2YfIkc29XJEW6fP/+hpmcZIzF0BLQSjAdBbQ=; b=d
	snbjnY1SJbs3yFzgcbapAl2m6wYArsi/3zv8B8+ony2WbqiWbmbonoVy+lxYgsXg
	ZI2xEsbYbUrCp+om5SS2TszGilTA94+Priy4OFVHbb+x24v8KaCVx2L2sdiC61CO
	zyuUVSrXzkNyAsgIPi6hWBep6AAzSoh0rrspUWCVT+6K8jOOwNivDLt8cu7/HEgn
	BbIRO2RyVd3y+etpHr68XoPOF5iMxZoBb0fB2bBMbSX3Nmme09vaOlO2sHyq6DL/
	By+vzW4RRG+J5QUiSRdF/qsKxYLg57OSm9mR29u4xah7qjGiucX70RX9BIoY1WgG
	EpCMp0BQGgiwfmneL8a3w==
X-ME-Sender: <xms:lEVuac1fEGNc1uQdblsZNV5kxSjWEWf4MWFfnKlnKqhnEn07l_K2xw>
    <xme:lEVuaR7MldZy0Ehy-dSUGYupURNKkqmJ-a1EOe7m-3SUfQ2tPtzIsn7qpouUhTRW8
    orJVC4NenseppFaDqcs9UzZfcgi-ErUyRVzrCKRdCoLHOrcvkoKgrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgefgjedujedvieejgeelgfdthfduffeiteefudeghfffkeejfeehtdejfeejteef
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvrghssehgrghishhlvghr
    rdgtohhmpdhrtghpthhtoheplhhuugifihhgrdhrhigusggvrhhgsehgrghishhlvghrrd
    gtohhmpdhrtghpthhtohepjhhrthgtvdejsehjrhhttgdvjedrtghomhdprhgtphhtthho
    pegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhr
    ghdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrd
    guvgdprhgtphhtthhopehstghhuhhsthgvrhdrshhimhhonhesshhivghmvghnshdqvghn
    vghrghihrdgtohhm
X-ME-Proxy: <xmx:lEVuaSmafTbXTD1vqSXz-_AxXbbwgmUC9P_uzlbiX9RHUg8bx9JmhQ>
    <xmx:lEVuaQUZNR2Wb4c-wv4apalYiP7ztX7mDvZ5sjBqyj0CSdr82GyTXg>
    <xmx:lEVuaeovnCNL1ZyQcGKOYwHfOHpBpZhaImkfAIue1SFSKFUpqTHyCQ>
    <xmx:lEVuaZXu7qFj5bNwRZ-Sg59OGQ1yZktn0dSnBJ1tb12kavZHLSzuiA>
    <xmx:lUVuaUXUbnENjFSGHxWC3VVQ05rl7XEqknHgOuNKMzUkBL8AHU0rAWvz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98AB1700069; Mon, 19 Jan 2026 09:54:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADArjYosoCao
Date: Mon, 19 Jan 2026 15:53:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ludwig Rydberg" <ludwig.rydberg@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christian Brauner" <brauner@kernel.org>, shuah <shuah@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Jessica Clarke" <jrtc27@jrtc27.com>
Message-Id: <93510cb7-e398-4af7-896c-5b4a4654598f@app.fastmail.com>
In-Reply-To: <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
 <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
Subject: Re: [PATCH v2 2/2] sparc: Add architecture support for clone3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 19, 2026, at 15:47, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
>
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
>
> The return value convention for clone3 follows the regular kernel return
> value convention (in contrast to the original clone/fork on SPARC).
>
> Closes: https://github.com/sparclinux/issues/issues/10
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

Thanks a lot for addressing this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

