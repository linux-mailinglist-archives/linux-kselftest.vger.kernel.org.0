Return-Path: <linux-kselftest+bounces-44420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE8C20C65
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019633A8F81
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59EB266EFC;
	Thu, 30 Oct 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Q9hn/ByG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y43WZ2R5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29022230264;
	Thu, 30 Oct 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836254; cv=none; b=tl1mkAScu0xrJgAK3z5awpufbo45gT+skbB482fy+dU2IQBMPoKu2mkG9NLdB8hZAJcBnS75AR3ClhAA6Pk1U2joXgEEYfZeilYI57tr6KkQOlXzvqE6TmQQkukp4vQmUUo1uM4ptilhQpLZBD5ya8UuvvMV0OM4Ch1wgBmAFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836254; c=relaxed/simple;
	bh=D2EOopkwvW+aqcQNfXeMVFarQE5CziNi6o0d30R+uJ4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N/CS8OK/kSmpFYxEh+/yq7FpAuPCQm4fiQ9k2vF/t1S9d8x67ZjLYHl3jorPoDa+jeG/Sz9xZ193lTveJgv77mfAUg9+tYI3s3ey+2Q1TRUbn3bMAVoD+GMcdBwoCHNDkOPtBfUpY7Qln4EukOQm/fzjkz8RooUXXA5dBMnSifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Q9hn/ByG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y43WZ2R5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 57A6C1D000DD;
	Thu, 30 Oct 2025 10:57:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761836252;
	 x=1761922652; bh=D2EOopkwvW+aqcQNfXeMVFarQE5CziNi6o0d30R+uJ4=; b=
	Q9hn/ByGcIe+PmAprrZPB3hAfuTTXf7n+v4pYRG3nDDnnKbF0SiUBm1WSMylXXFp
	HdOF4wHFrXCdYTlGWS4i0sSj+zmOt34mW1k0GuNvVulLjgT9DdMIO9YVaOtSoR+P
	/63c1TS5g/RqSDSu/vqU/0eTrimm8HrSjutts3D5fRPqa2s882H9IDocYtM1n/NT
	u13iv/AXhSnk8ZLKEYj1SVKZ13mSfph5Hj6mhTh9U5wLLA0zFm2deJ8H4tBVYAu7
	k/7HfdPTO3w/wLReP6gbv+CxjLfreJo76q6wVVMuSTfI7N/y3bJ6172ntVy/SIqJ
	ziJm0XifOyGosfGlnO6mBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761836252; x=
	1761922652; bh=D2EOopkwvW+aqcQNfXeMVFarQE5CziNi6o0d30R+uJ4=; b=Y
	43WZ2R5k4xPc/2W8FYnTdyMj6yN5CkQ0S8lDi8BEK8k1vTao8XblKgt0NCA43I1c
	E1yPXq8A5vRAb308P3tX4AC6Ed7VEq8DFGR4Yb66JgEHWmHn1jtiW8OISeIfX5Tt
	PGeIKmBZFsTU5hlwI1gvp8XjVd7mgsW3dh0yq46SqjHBjb3KKoKWJtIrdeMJYhQY
	gPOtOnc1g6VpTDDAPDq95Lzxa93bi9wCO8O/5xwrOZCGJlf3EmO3l+IOyDaggSn+
	zMEjw4rdwaQ25aYeF4IdZuBm8jOjuDq5z50MLrug5C7IkATSQ2j0RLSkK5wChcE9
	TEg6hvmJkJR8HYpfaJBHA==
X-ME-Sender: <xms:23wDabE1iCpqnwD8E0EPS9aBrKaKawVa-2FKdKVqM8zhDCwuhfJCdw>
    <xme:23wDaTK29lSSaONNU5v37mH7SKfwfllB0wth-ponkXiWxuCSFkFZMTGs-MDh8Yrmf
    YfsgtbLXPrviy0A7zN75V-4AqknTJs63Q1N5n8L05RRIdfMJCN_vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:23wDabSVpG3P1PMNXNx7q5WkEB2djpXuRsMaTVVs1lkMzvXxMalReA>
    <xmx:23wDaVvPf6svp3S0tEMWEIk50LEc5vHfvDL0XWqiBxgHO5umnhxWnA>
    <xmx:23wDacZT1EFYSdFC2vZEsjSbiU7Qd4upY4ry6Ix3xQobgVpL3r2mRQ>
    <xmx:23wDabHQpLA6fINw8T1n3IAtikg2w4W1vsXLKXrfYI3oElgbdRhsZw>
    <xmx:3HwDaTW66AG8jYKBSmW-QbYYy2WBWDD8JOe29hxY34xl9y_vwoK6-KwZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7E3C700063; Thu, 30 Oct 2025 10:57:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZLzNVpFWGs3
Date: Thu, 30 Oct 2025 15:57:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <d3fe59df-a6cd-46dc-8821-0c2831e503b6@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 08/12] tools/nolibc: gettimeofday(): avoid libgcc 64-bit divisions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:02, Thomas Wei=C3=9Fschuh wrote:
> timespec::tv_nsec is going to be 64-bit wide even on 32-bit
> architectures. As not all architectures support 64-bit division
> instructions, calls to libgcc (__divdi3()) may be emitted by the
> compiler which are not provided by nolibc.
>
> As tv_nsec is guaranteed to always fit into an uint32_t, perform a
> 32-bit division instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

