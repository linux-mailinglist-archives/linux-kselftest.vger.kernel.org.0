Return-Path: <linux-kselftest+bounces-11998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C830909619
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162BE1C213D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC48EAFA;
	Sat, 15 Jun 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GoSuQ9cn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxIq/0H+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD40E573;
	Sat, 15 Jun 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718428419; cv=none; b=dKftL0BYqyTg/3az0xbsEyRANzguuZ2tuk9koVKZNx8gPTkAbwBNhJxWuBdZtzQiYHkR5MitrgxKSXkb/0vkTgZRws6vWbvDiq9y3CXUuWefkGFGXusd4fnJImbg8iulZcd7Bilad2pNjNxQSx/c2Vqu7h0krjENfZ7bWVhMc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718428419; c=relaxed/simple;
	bh=SI1QOdKUoEppwPF2MWp9YUkmuFhIruEH+JNhT0Da0oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiTZX51u3TYiBYL+TC1XGWfe3nJ8n+ljRByME2U2M3PBEX3xIkVzyLOSMiJGPf4/2oc/tdX2BH1koKODnYoy2Z9rXM7vbM552AplvbFWBjT74KYuHqdVebm8Byn+4AeJANW0cbpE0ajxJk2o+BBUZU6gosw+3Qv290ei+ZMx+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GoSuQ9cn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxIq/0H+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C8AD13803E8;
	Sat, 15 Jun 2024 01:13:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 15 Jun 2024 01:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718428415; x=
	1718514815; bh=ULe3PHZaVWu+u67al/fCAttGBkzxQ4k67WbosEG1VZw=; b=G
	oSuQ9cn2uLDM5kStNzwuAwg6aTRqGeMHr2Q4+Xqtr/hwRjEt4L8XKA9avF0AUCth
	cdXkM5qIMhUyIHNo2Sa1vyx9kB6oBxFtCljcUR8l2II5ZYv++cd+YGkLDyhkZzKT
	ipZ/hhiegMeUQagkDLC+vSKlQNmxGSmhkMc5MmYwL8KVs4QG5sfg/5eSbr2YRoFI
	u3lsSuptZ+vAdgn8KnKwrZ0b9ue0kDTkGniyF8vDBdYWj7PClyacFGe1oHUVJvPW
	QLnbexSHVLO3xtWzpUiUdaXg9adc+zB4JiRb5iiUXL7Cf7ove6aCp2a3QYarJZ0K
	9y/i/NcaZYQHHMl68BMUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718428415; x=1718514815; bh=ULe3PHZaVWu+u67al/fCAttGBkzx
	Q4k67WbosEG1VZw=; b=gxIq/0H+o95VvUXA+EQLc9TbEBUbGv/ykgz2Qt8zYO9s
	N41zrKN5QPG6zrIF9VtjAbvnqK8jLOV3rdLLRXKmKKPDzlNJWs81YANSddzjeJXV
	WVsLiTlIe9E6+K3VjM/YWIPMmodRlG79JLTphUB+AbudnFRDVvn64pY9kptqbwNU
	qEQEpS5SJlYToOyNsjJByCKm2fe/p67TDk7MlAPm/H2aE0B5+Snm+4ZRPb3PFGv+
	NNxM9x9qv0YZbKoFDoPCOCm3vetLSm/hzwyg1kE9VAW5gajeqKqtHArrj7KK8Cd3
	5X2uvGrS9MqB4sbV5sKSltGqmltn/B/RZ7kxhnzZDw==
X-ME-Sender: <xms:_iJtZtZD08mZgl66GcflaJTSmIfTgqMo0LUu62J-e0BQSjWPxD0IPA>
    <xme:_iJtZkZCJCMCZ9lEAKV1RBgEk86iISZow5bUe6_wUZxCy8CwuJ0Rq5-ZNfH0PeFlX
    9fyVY2z6KZh_64bxdo>
X-ME-Received: <xmr:_iJtZv9z402i-cyeNoPhbqtqSjbwy28S0poPM7qHN3DzVAE2PUg3RY9K41osJ-8M6YSzkJQpNWMu-qocSEnTqkkoU41ORRmkC3_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:_iJtZrrpBtrpaya9HfVApA4DNzE6__WEYAnLwvw22PcAgrfGxfKS9A>
    <xmx:_iJtZopkqgqsFyUUbglsuVCRwfpPC4hRYG_7EM7pF96GBv5WEUaunQ>
    <xmx:_iJtZhRn_3xhSG01a8vr-k45s3AxwxIMlTS413O_wVD5O54XYP0deQ>
    <xmx:_iJtZgptaIAii_MajcXgYlnhYRbjF3rIZtxOyz5Bw5TYH5tYUDNJdg>
    <xmx:_yJtZpdKkY3-KRSguDyx6fAYM45wriwKtIINps3pnL-ZlCal7_hxaH9Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 01:13:32 -0400 (EDT)
Date: Sat, 15 Jun 2024 14:13:29 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values
 for user elements
Message-ID: <20240615051329.GA494527@workstation.local>
References: <20240614153717.30143-1-tiwai@suse.de>
 <20240614153717.30143-4-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614153717.30143-4-tiwai@suse.de>

Hi,

On Fri, Jun 14, 2024 at 05:37:12PM +0200, Takashi Iwai wrote:
> Although we have already a mechanism for sanity checks of input values
> for control writes, it's not applied unless the kconfig
> CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
> Nevertheless, it still makes sense to apply the check for user
> elements despite of its cost, as that's the only way to filter out the
> invalid values; the user controls are handled solely in ALSA core
> code, and there is no corresponding driver, after all.
> 
> This patch enables the input value validation for user control
> elements no matter whether CONFIG_SND_CTL_INPUT_VALIDATION is set or
> not.  The kselftest will be happier with this change, as the incorrect
> values will be bailed out now with errors.
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
>  sound/core/control.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index fb0c60044f7b..50890983d7e2 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1317,7 +1317,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
>  	snd_ctl_build_ioff(&control->id, kctl, index_offset);
>  	result = snd_power_ref_and_wait(card);
>  	/* validate input values */
> -	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
> +	if ((IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) ||
> +	     (vd->access & SNDRV_CTL_ELEM_ACCESS_USER)) && !result) {
>  		struct snd_ctl_elem_info info;
>  
>  		memset(&info, 0, sizeof(info));

In my opinion, the validation in 'snd_ctl_elem_user_put()' is preferable
instead. In the function, it is free to access to 'struct
user_element.info' for the validation.

In the commit coment, I can see "that's the only way to filter out the
invalid values", however it not so good idea, since the ALSA control core
function loses transparency against control elements somehow.
Furthermore, I can see "there is no corresponding driver", however it is
suspicious somehow. It would be smart to charge the validation
implementation for user-defined control element set if forcing it.


Regards

Takashi Sakamoto

