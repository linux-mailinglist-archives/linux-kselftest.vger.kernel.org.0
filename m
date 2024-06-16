Return-Path: <linux-kselftest+bounces-12011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6655909B6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34021C20EDD
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAC3BBE5;
	Sun, 16 Jun 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="CDcrwCau";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTpjkbCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE3946F;
	Sun, 16 Jun 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718509179; cv=none; b=fuoIZ7p8ZfPbiUiYBiMf9Be9varuqhK3GdHR/r8n/TIb202AR9my5O2K8jhNUHHrLeDlAU1u7xb47zYaElNqy5f1b/QTlcfH71oDKKxRNiwv3AzT9vApuv4dGYU39QWEqXzGFAZy2RC9tkf1Hc1Qc2tkAM+OOUbREMhRQLVYoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718509179; c=relaxed/simple;
	bh=7D4dshEE0owSMVmON8T+vWUatwFJHMpZ3QKpk7xnXTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvrsGAXiAIJg4NqB07Vq8idEp8jr+dOzMYfCmDFeShF8k13eWC/mHgOoN7mrZOJV1nY5E0DMrc/0R4JCI8fkGDtBiWuA+7ov5kftY7rPZiuh/Gjqjo76NUgwo5u8y44fCsROgUH1IvLfnpt46P1uUkswbJ+6n2JBDIHGbVhxE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=CDcrwCau; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTpjkbCK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8A7A413800E5;
	Sat, 15 Jun 2024 23:39:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 15 Jun 2024 23:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718509176; x=
	1718595576; bh=rDnFR1LEPJ1H9/yPWYumA2WahuuPUTtitar8t78RgZM=; b=C
	DcrwCauzZEFTxCIbJE9f6jM/GM6MIrtfpzg24EirmirMCywhf8bhakKdlTYppVZf
	V9/1pmCSI/EH1fFkAWpFDVvhTuFcBo0boihRUb/VQwudLQAmWZpR4XFk3TJVllG4
	/f6c2rfxUWVXzY1QKnmT7WOBLJTtzWtfASEARL2IGgSpq1dczjyDk31crz6AyFFP
	6m4B0DEzmA1LiJ7iwgbSBAaHQLRdm1fSWhkAeWB/PJexROFzptm5v4mq8n+Buh1K
	qFzCWtmr0JFI+BOCFp4T/pcsqV3pwm7oA6z+zaRE7pZqtF45LwTMi92o/0eVtOdW
	AY5bf9EtUI0Q99cif5/wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718509176; x=1718595576; bh=rDnFR1LEPJ1H9/yPWYumA2WahuuP
	UTtitar8t78RgZM=; b=jTpjkbCKAwlV6n4Ay9vWkjVFwgHxG/tf5+LOc//QMFkn
	1NPvUoxLM2WIz/OpOYbsRjPnUucNMaXtOJ6r0mpWFsT3uxqYk3XrT924Kx8acB/6
	n2RA0GLHG1SXITO4/w4e2rZbwIAu5jSPe4HMMFtfcKQShPl8TEOH1N0qAelIeUIF
	2oz+06LwLal/iwwBdifSfkcMbqNUzfvi+jO1BdC+NsNd/ZAJQnL5WFsv4PWMRj54
	mjxPIWmjyS9dUCiflXEg44MAOApIJvgMJnviwNNZzyysyJFuQhDE9nl4owtr60sP
	eS5Gi85HHYRuBMv0fKwQjpNYOxUgyYirLbNOmdO+Og==
X-ME-Sender: <xms:dl5uZrIQrljN5rZd7PqIlECNh2UtMag11PFuxRUnWmGx-Tq1Tx2fDg>
    <xme:dl5uZvIjKy3w4PRP1VBfM06GEEfraCJAt-EcoCQ3FBAZbLU_trdBsTuL1ep8xo8ZN
    ZL4P3YylqVbrUXr_Ug>
X-ME-Received: <xmr:dl5uZjsSIvQDmIo8lh48bVV2b0K6Jz2FjzRgozl_hQY_nSrvx8FhBE47Bm_lYpT-sx_KdSVLTz4vJaGDy-f3wTZjhsm8Wmjz4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:d15uZkYxKsxpXEVeD3nNivhkvW1BzMwcMERHse7dudF_IpWGK_KgHA>
    <xmx:d15uZiajBzOp60Wkq4TRFIh8lXDbhYL2jdZNcWXWquez6ja_tri_Dg>
    <xmx:d15uZoA3w3J72yk9-ek1pZCtSlOnj7Uezyl2LWzX8IwEYaSGEhcAfQ>
    <xmx:d15uZgYzmd39XKpK_tyTmsxI69dEL8Blj9-OMS5ahRnHYRdamoBfoA>
    <xmx:eF5uZnMGadwDzmxsfppUno9TvMVNFeBvzfXeUTxlT7pnWNzm_hgI-qf_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 23:39:33 -0400 (EDT)
Date: Sun, 16 Jun 2024 12:39:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values
 for user elements
Message-ID: <20240616033931.GA518788@workstation.local>
References: <20240614153717.30143-1-tiwai@suse.de>
 <20240614153717.30143-4-tiwai@suse.de>
 <20240615051329.GA494527@workstation.local>
 <871q4y7jgt.wl-tiwai@suse.de>
 <20240615080235.GA508000@workstation.local>
 <87tthu6225.wl-tiwai@suse.de>
 <87le365tei.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le365tei.wl-tiwai@suse.de>

On Sat, Jun 15, 2024 at 01:37:09PM +0200, Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v3] ALSA: control: Apply sanity check of input values for user elements
> 
> Although we have already a mechanism for sanity checks of input values
> for control writes, it's not applied unless the kconfig
> CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
> Nevertheless, it still makes sense to apply the same check for user
> elements despite of its cost, as that's the only way to filter out the
> invalid values; the user controls are handled solely in ALSA core
> code, and there is no corresponding driver, after all.
> 
> This patch adds the same input value validation for user control
> elements at its put callback.  The kselftest will be happier with this
> change, as the incorrect values will be bailed out now with errors.
> 
> For other normal controls, the check is applied still only when
> CONFIG_SND_CTL_INPUT_VALIDATION is set.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/control.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto

